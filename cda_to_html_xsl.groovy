// @Grab('org.apache.commons:commons-io:2.11.0')
import groovy.xml.*
import groovy.transform.Field
import javax.xml.transform.*
import javax.xml.transform.stream.*
import java.io.*

// Read XML file
def xmlFile = new File('documents/20250914082104.xml')
def xmlContent = xmlFile.text

// Read XSLT file
def xsltFile = new File('CDA.xsl')
def xsltContent = xsltFile.text

// Create transformer
def factory = TransformerFactory.newInstance()
def transformer = factory.newTransformer(new StreamSource(new StringReader(xsltContent)))

// Perform transformation
def xmlSource = new StreamSource(new StringReader(xmlContent))
def outputFile = new File('output.html')
def result = new StreamResult(outputFile)

transformer.transform(xmlSource, result)

println "Transformation complete. Output written to ${outputFile.name}"