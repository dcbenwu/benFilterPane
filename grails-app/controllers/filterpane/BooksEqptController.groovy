package filterpane

import org.grails.plugins.filterpane.FilterPaneUtils

class BooksEqptController {

    def filterPaneService
    def dataSource
    def exportService // Export service provided by Export plugin

    static defaultLines = 25

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def index(Integer max) {
        redirect(action:'list',params:params)
    }

    def list = {
        log.info("user operation " + params.toQueryString())
        if(!params.max) params.max = defaultLines
        log.debug("Book is ${BooksEqpt} or type ${BooksEqpt.class}")
        if(params?.f) {
            export(params)
            return
        }
        [ bookList: BooksEqpt.list( params ), filterParams: FilterPaneUtils.extractFilterParams(params)]
    }

    def filter = {
        log.info("user operation " + params.toQueryString())
        if(!params.max) params.max = defaultLines
        if(params?.f) {
            export(params)
            return
        }
        render( view:'list', model:[ bookList: filterPaneService.filter( params, BooksEqpt ),
                                     bookCount: filterPaneService.count( params, BooksEqpt ),
                                     filterParams: FilterPaneUtils.extractFilterParams(params),
                                     params:params ] )
    }

    def export(params) {
        if(params?.f && params.f != "html"){
            params.max = 1000
            response.contentType = grailsApplication.config.grails.mime.types[params.f]
            response.setHeader("Content-disposition", "attachment; filename=books.${params.extension}")
            //exportService.export(params.f, response.outputStream, filterPaneService.filter( params, BooksEqpt ), [:], [:])
            List fields = ["ip", "type", "pn", "sn", "location", "search_date", "state"]
            Map labels = ["ip": "IP", "type": "Type", "pn": "PN", "sn": "SN", "location": "Location", "search_date": "Date", "state": "State"]

            // Formatter closure
            def upperCase = { domain, value ->
                return value.toUpperCase()
            }

            Map formatters = [:] // [type: upperCase]
            Map parameters = [:] //[title: "Devices export result"] //, "column.widths": [1.8, 1.4, 1.5, 0.5, 0.5, 1.8, 0.4]]

            exportService.export(params.f, response.outputStream, filterPaneService.filter( params, BooksEqpt ), fields, labels, formatters, parameters)
        }
    }
}
