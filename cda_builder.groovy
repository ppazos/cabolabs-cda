import groovy.xml.MarkupBuilder

def usage = """Usage:
groovy cda_builder.groovy [1,2,3] header_file [options]
 + level 1 options: body_content_file e.g. a PDF or image or plain text file
 + level 2 options: body_section_texts
 + level 3 options: body_section_texts (will generate sample entries for the sections)
"""

def start = System.currentTimeMillis()

if (args.size() < 2)
{
   println "\n"
   println usage
   return 0
}

def level = 1

try
{
   level = args[0].toInteger()
   
   if (!(level in 1..3))
   {
      println "arg ${args[0]} should be in 1..3"
      println usage
      return 0
   }
}
catch (Exception e)
{
   println "Can't parse arg ${args[0]}"
   println usage
   return 0
}

/*
usage:

groovy cda_builder.groovy [1,2,3] header_file [options]
 + level 1 options: body_content_file e.g. a PDF or image or plain text file
 + level 2 options: body_section_texts
 + level 3 options: body_section_texts (will generate sample entries for the sections)

line 0:
 0 ClinicalDocument.code.code
 1 ClinicalDocument.code.codeSystem
 2 ClinicalDocument.code.displayName
 3 ClinicalDocument.title
 4 ClinicalDocument.languageCode.code
 
line 1:
 0 ClinicalDocument.recordTarget.patientRole.patient.name.given
 1 ClinicalDocument.recordTarget.patientRole.patient.name.given
 2 ClinicalDocument.recordTarget.patientRole.patient.name.family
 3 ClinicalDocument.recordTarget.patientRole.patient.name.family
 4 ClinicalDocument.recordTarget.patientRole.patient.birthTime.value
 5 ClinicalDocument.recordTarget.patientRole.patient.administrativeGenderCode.code
 6 ClinicalDocument.recordTarget.patientRole.id.extension
 7 ClinicalDocument.recordTarget.patientRole.id.root

line 2:
 0 ClinicalDocument.author.assignedAuthor.assignedPerson.prefix
 1 ClinicalDocument.author.assignedAuthor.assignedPerson.given
 2 ClinicalDocument.author.assignedAuthor.assignedPerson.given
 3 ClinicalDocument.author.assignedAuthor.assignedPerson.family
 4 ClinicalDocument.author.assignedAuthor.assignedPerson.family
 5 ClinicalDocument.author.assignedAuthor.id.extension
 6 ClinicalDocument.author.assignedAuthor.id.root
 7 ClinicalDocument.author.assignedAuthor.representedOrganization.id.extension
 8 ClinicalDocument.author.assignedAuthor.representedOrganization.id.root
 9 ClinicalDocument.author.assignedAuthor.representedOrganization.name

line 3:
 0 ClinicalDocument.custodian.assignedCustodian.representedCustodianOrganization.id.root
 1 ClinicalDocument.custodian.assignedCustodian.representedCustodianOrganization.name
 2 ClinicalDocument.custodian.assignedCustodian.representedCustodianOrganization
 3 ClinicalDocument.custodian.assignedCustodian.representedCustodianOrganization
 4 
 5 
 6 
*/

String.metaClass.static.uuid = { ->
   java.util.UUID.randomUUID().toString()
}

Date.metaClass.static.nowString = { ->
   new Date().format("yyyyMMddhhmmss")
}

// Parse header data
def header_file = new File(args[1])

if (!header_file.exists())
{
   println "File ${header_file.path} doesn't exists"
   return 0
}

def header_data_csv = header_file.text
def header_data = header_data_csv.normalize().tokenize("\n")*.split(",") //*.trim()

println header_data

// Variables for the body
def content_type, level_1_body_content, level_1_body_representation
def header_only = false

if (level == 1)
{
   if (args.size() < 3)
   {
      println "Missing body content file, generating header only"
      header_only = true
      
      //println usage
      //return 0
   }
   else
   {
      // Process body data
      /* base 64 encode / undecode
      def s = '....'
      String encoded = s.bytes.encodeBase64().toString()    
      byte[] decoded = encoded.decodeBase64()
      assert s == new String(decoded)
      */
      def body_file =  new File(args[2]) // TODO: get the type of file to put the mime type in the body
      
      if (!body_file.exists())
      {
         println "File ${body_file.path} doesn't exists"
         return 0
      }
      

      // This might not work and depends on the OS, try with two methods, then exception...
      content_type = java.net.URLConnection.guessContentTypeFromName(body_file.name)
      if (!content_type) content_type = java.nio.file.Files.probeContentType(body_file.toPath())
      if (!content_type) throw new Exception("Content type not found for file "+ args[1])

      //println content_type
      
      if (content_type == 'text/plain')
      {
         level_1_body_content = body_file.text
         level_1_body_representation = 'TXT'
      }
      else
      {
         def body_bytes = body_file.bytes
         def body_base_64 = body_bytes.encodeBase64().toString()
         level_1_body_content = body_base_64
         level_1_body_representation = 'B64'
      }
   }
}
else
{
   println "level 2 and level 3 are not supported yet"
   return 0
}


// XML Builder Setup

def writer = new StringWriter()
def root = new MarkupBuilder(writer)
root.setDoubleQuotes(true)

// Build CDA Header

root.ClinicalDocument( xmlns:      'urn:hl7-org:v3',
                      'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
                      'xmlns:voc': 'urn:hl7-org:v3/voc') {

   typeId(root: '2.16.840.1.113883.1.3', extension:'POCD_HD000040')
   id(root: String.uuid())
   code(code: header_data[0][0], codeSystem: header_data[0][1], displayName: header_data[0][2])
   title(header_data[0][3])
   effectiveTime(value: Date.nowString())
   confidentialityCode(code: "N", codeSystem: "2.16.840.1.113883.5.25")
   languageCode(code: header_data[0][4])
   setId(root: String.uuid())
   versionNumber(value: 1)
   
   // Patient
   recordTarget {
      patientRole {
         id(root: header_data[1][7], extension: header_data[1][6])
         patient {
            name {
               given(header_data[1][0])
               family(header_data[1][2])
            }
            administrativeGenderCode(code: header_data[1][5], codeSystem: '2.16.840.1.113883.5.1')
            birthTime(value: header_data[1][4])
         }
      }
   }
   
   // Doctor
   author {
      time(value: Date.nowString())
      assignedAuthor {
         id(root: header_data[2][6], extension: header_data[2][5])
         assignedPerson {
            name {
               prefix(header_data[2][0])
               given(header_data[2][1])
               family(header_data[2][3])
            }
         }
         representedOrganization {
            id(root: header_data[2][8], extension: header_data[2][7])
            name(header_data[2][9])
         }
      }
   }
   
   // Organization
   custodian {
      assignedCustodian {
         representedCustodianOrganization {
            id(root: header_data[3][0])
            name(header_data[3][1])
            // TODO: TEL, ADDR
         }
      }
   }
   
   if (!header_only)
   {
      // Body level 1
      component {
         nonXMLBody {
            text(mediaType: content_type, representation: level_1_body_representation, level_1_body_content)
         }
      }
   }
}

def cda = writer.toString()

// Generates UTF-8 XML output

def destination_path = 'documents'

def destination = new File(destination_path)
if (!destination.exists())
{
   println "\n"
   println destination.absolutePath +" doesn't exists, trying to create it"
   destination.mkdir()
}

String PS = System.getProperty("file.separator")
def out = new File( destination_path + PS + (header_only?'header_only_':'') + new java.text.SimpleDateFormat("yyyyMMddhhmmss'.xml'").format(new Date()) )
printer = new java.io.PrintWriter(out, 'UTF-8')
printer.write(cda)
printer.flush()
printer.close()

def now = System.currentTimeMillis()

println ""
println "CDA created at "+ out.absolutePath
println "In ${now - start} ms"
println ""
