package filterpane

import grails.databinding.BindingFormat

class BooksEqpt {

    String ip
    String device_type
    String type
    String pn
    String sn
    String location
    @BindingFormat("yyyy-MM-dd")
    java.sql.Date search_date
    String state

    static constraints = {
    }
    static mapping = {
        version false
        sort 'id'
        order 'desc'
    }
}
