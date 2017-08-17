import groovy.util.XmlSlurper
import groovy.xml.MarkupBuilder

def usage = """Usage:
groovy cda_2_html.groovy cda.xml
"""

if (args.size() == 0)
{
   println "\n"
   println usage
   println "\n"
   return 0
}

def xml = new File(args[0])
def xml_string = xml.text
def cda = new XmlSlurper().parseText(xml_string)
def writer = new StringWriter()
def html = new MarkupBuilder(writer)

html.html(lang:'es') {
  head() {
    meta  (charset:'utf-8')
    meta  ('http-equiv': "X-UA-Compatible", content: "IE=edge")
    meta  (name: "viewport", content: "width=device-width, initial-scale=1")
    title (cda.title.text())
    link  (rel: "stylesheet", href: "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css", integrity: "sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u", crossorigin: "anonymous")
    link  (href: "http://fonts.googleapis.com/css?family=Roboto:100,300,400,700", rel: "stylesheet")
  }
  body() {
    div(class: 'container') {
      div(class: 'row') {
        div(class: 'col-md-12') {
          h1(cda.title.text())
        }
      }
      div(class: 'row') {
        div(class: 'col-md-6') {
          h2('Patient')
          span (
            cda.recordTarget.patientRole.patient.name.children().collect{ it.text() }.join(' ')
          )
        }
        div(class: 'col-md-6') {
          h2('Author')
          span (
            cda.author.assignedAuthor.assignedPerson.name.children().collect{ it.text() }.join(' ')
          )
        }
      }
      
      if (!cda.component.structuredBody.isEmpty()) {
      
        cda.component.structuredBody.component.each { component ->
        
          div(class: 'row') {
            div(class: 'col-md-12') {
              h3(component.section.title.text())
              if (!component.section.text.list.isEmpty()) {
                make_list(html, component.section.text.list)
              }
              else if (!component.section.text.table.isEmpty()) {
                make_list(html, component.section.text.list)
              }
              else {
                span (
                  component.section.text.text()
                )
              }
            }
          }
        }
      }
    }
  }
}

/**
 * <list>
 *  <item>DOLOR DE CABEZA (Activo)</item>
 *  <item>MAREOS (Activo)</item>
 * </list>
 */
def make_list(html, list) {
  html.ul {
    list.item.each {
      li(it.text())
    }
  }
}

/**
<table>
  <tbody>
    <tr>
      <th>PRODUCTO</th>
      <th>CANTIDAD</th>
      <th>CRONICO</th>
      <th>TRAT_PROLONGADO</th>
    </tr>
    <tr>
      <td>MATRIX 400mg Comp. x 10</td>
      <td>36</td>
      <td>12</td>
      <td>N</td>
    </tr>
    <tr>
      <td>TRIFAMOX 1000mg Comp. x 16</td>
      <td>23</td>
      <td>12</td>
      <td>N</td>
    </tr>
  </tbody>
</table>
 */
def make_table(html, table) {

  // TODO
}

def destination_path = 'html'

def destination = new File(destination_path)
if (!destination.exists())
{
  println "\n"
  println destination.absolutePath +" doesn't exists, trying to create it"
  destination.mkdir()
}

String PS = System.getProperty("file.separator")
def out = new File( destination_path + PS + new java.text.SimpleDateFormat("yyyyMMddhhmmss'.html'").format(new Date()) )
printer = new java.io.PrintWriter(out, 'UTF-8')
printer.write(writer.toString())
printer.flush()
printer.close()

println "\n"
println "HTML created "+ out.absolutePath
println "\n"
