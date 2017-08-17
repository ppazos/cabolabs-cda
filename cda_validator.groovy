import javax.xml.transform.Source
import javax.xml.transform.stream.StreamSource
import javax.xml.validation.Schema
import javax.xml.validation.SchemaFactory
import javax.xml.validation.Validator
import javax.xml.XMLConstants

import org.xml.sax.ErrorHandler
import org.xml.sax.SAXException
import org.xml.sax.SAXParseException
import java.io.InputStream

def usage = """Usage:
groovy cda_validator.groovy folder_with_cdas
"""

def start = System.currentTimeMillis()  

if (args.size() == 0)
{
   println "\n"
   println usage
   return 0
}

def folder = new File(args[0])
if (!folder.exists())
{
   println "\n"
   println "Folder "+ folder.absolutePath +" doesn't exists"
   return 0
}

def xsdPath = "." + File.separator + "CDA_flat.xsd"
SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI)
def schema = schemaFactory.newSchema( [ new StreamSource( xsdPath ) ] as Source[] )
Validator validator = schema.newValidator()

boolean validate(Validator validator, String xml)
{
   try
   {
      validator.validate(new StreamSource(new StringReader(xml)))
   }
   catch(Exception e)
   {
      println ''
      println ' - '+ e.message // uncomment to see errors
      println ''
      return false
   }
   
   return true
}

int i = 1

folder.eachFileMatch(~/.*.xml/) { xml ->

  if (!validate(validator, xml.text ))
  {
     println i +") "+ xml.name +' NO VALIDA, error ^'
  }
  else
  {
     println i +") "+ xml.name +' VALIDA'
  }
  i++
}

def now = System.currentTimeMillis()
println "In ${now - start} ms"
print "\n"
