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
      //println e.message // uncomment to see errors
      return false
   }
   
   return true
}

int i = 1

new File('.' + File.separator).eachFileMatch(~/.*.xml/) { xml ->

  if (!validate(validator, xml.text ))
  {
     println i +") "+ xml.name +' NO VALIDA'
     /*
     println '====================================='
     validator.errors.each {
        println it
     }
     println '====================================='
     */
  }
  else
  {
     println i +") "+ xml.name +' VALIDA'
  }
  i++
}
