import groovy.util.XmlSlurper

def usage = """Usage:
groovy cda_xmlslurper.groovy cda.xml
"""

if (args.size() == 0)
{
   println "\n"
   println usage
   return 0
}

def xml = new File(args[0])
def xml_string = xml.text
def clinical_doc = new XmlSlurper().parseText(xml_string)

//println clinical_doc*.text()

println ""

def nombre_autor = clinical_doc.author.assignedAuthor.assignedPerson.name.children().collect{ it.text() }
println "nombre_autor: "+ nombre_autor

def nombre_paciente = clinical_doc.recordTarget.patientRole.patient.name.children().collect{ it.text() }
println "nombre_paciente: "+ nombre_paciente

def id_paciente = clinical_doc.recordTarget.patientRole.id[0].attributes()
println "id_paciente: "+ id_paciente

println ""
