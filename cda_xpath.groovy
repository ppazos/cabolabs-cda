import javax.xml.xpath.*
import javax.xml.parsers.DocumentBuilderFactory

def usage = """Usage:
groovy cda_xpath.groovy cda.xml
"""

if (args.size() == 0)
{
   println usage
   return 0
}

def processXml( String xml, String xpathQuery )
{
  def xpath = XPathFactory.newInstance().newXPath()
  def builder     = DocumentBuilderFactory.newInstance().newDocumentBuilder()
  def inputStream = new ByteArrayInputStream( xml.bytes )
  def records     = builder.parse(inputStream).documentElement
  def nodes = xpath.evaluate( xpathQuery, records, XPathConstants.NODESET )
  def res = []
  nodes.each { node ->
    if (node.textContent.trim()) res << node.textContent
  }
  return res
}

def xml = new File(args[0])
def xml_string = xml.text

def atributos_documento = processXml( xml_string, '/ClinicalDocument/*/text()' )
println "atributos_documento 1: "+ atributos_documento

atributos_documento = processXml( xml_string, '/ClinicalDocument/*/@*' )
println "atributos_documento 2: "+ atributos_documento

def autor = processXml( xml_string, '/ClinicalDocument/author//text()' )
println "autor: "+ autor

def paciente = processXml( xml_string, '/ClinicalDocument/recordTarget//text()' )
println "paciente: "+ paciente

def id_paciente = processXml( xml_string, '/ClinicalDocument/recordTarget//id/@*' )
println "id_paciente: "+ id_paciente

def organizacion = processXml( xml_string, '/ClinicalDocument/custodian//text()' )
println "organizacion: "+ organizacion


