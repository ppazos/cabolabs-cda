import javax.xml.xpath.*
import javax.xml.parsers.DocumentBuilderFactory

def usage = """Usage:
groovy cda_xpath.groovy cda.xml
"""

if (args.size() == 0)
{
   println "\n"
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
  def res = [:]
  def name
  nodes.each { node ->

    // text nodes have name #text
    name = node.nodeName
    if (name == '#text') name = node.parentNode.nodeName
    
    // only add results with data
    if (node.textContent.trim())
    {
      if (res[name] == null) res[name] = []
      res[name] << node.textContent
    }
    //if (node.textContent.trim()) res << node.textContent
    //if (node.textContent.trim()) res[node.nodeName] = node.textContent
  }
  return res
}

def xml = new File(args[0])
def xml_string = xml.text

println ""

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

println ""
