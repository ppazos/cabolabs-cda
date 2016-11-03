import groovy.xml.MarkupBuilder

println args

/*

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
 4 ClinicalDocument.author.assignedAuthor.id.extension
 5 ClinicalDocument.author.assignedAuthor.id.root
 6 ClinicalDocument.author.assignedAuthor.representedOrganization.id.extension
 7 ClinicalDocument.author.assignedAuthor.representedOrganization.id.root
 8 ClinicalDocument.author.assignedAuthor.representedOrganization.name

line 3:
 0 ClinicalDocument.custodian
 1 
 2 
 3 
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

def header_file = new File(args[0])
def header_data_csv = header_file.text
def header_data = header_data_csv.normalize().tokenize("\n")*.tokenize(",;") //*.trim()

println header_data

// XML Builder Setup

def writer = new StringWriter()
def root = new MarkupBuilder(writer)
root.setDoubleQuotes(true)

root.ClinicalDocument( xmlns:      'urn:hl7-org:v3',
                      'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
                      'xmlns:voc': 'urn:hl7-org:v3/voc') {

   typeId(root: '2.16.840.1.113883.1.3', extension:'POCD_HD000040')
   id(root: String.uuid())
   code(code: header_data[0][0], codeSystem: header_data[0][1], displayName: header_data[0][2])
   title(header_data[0][3])
   effectiveTime(Date.nowString())
   confidentialityCode(code: "N", codeSystem: "2.16.840.1.113883.5.25")
   languageCode(code: header_data[0][4])
   setId(root: String.uuid())
   versionNumber(value: 1)
}

def cda = writer.toString()

println cda
