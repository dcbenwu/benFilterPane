<%@ page import="filterpane.BooksEqpt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <asset:javascript src="fp.js" />
    <r:require module="export"/>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">Home</a></span>
</div>
<div class="body">
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <filterpane:currentCriteria domainBean="filterpane.BooksEqpt" dateFormat="${[title: 'yyyy-MM-dd', search_date: 'yyyy-MM-dd']}"
                              removeImgDir="images" removeImgFile="bullet_delete.png" fullAssociationPathFieldNames="no"
                              filterPropertyValues="${[type: [displayProperty: 'display'], state: [displayProperty: 'display']]}"/>
    <div class="list">
        <table class="table table-bordered">
          <thead>
          <tr>

            <g:sortableColumn property="ip" title="IP" params="${filterParams}"/>
            <g:sortableColumn property="type" title="Type" params="${filterParams}"/>
            <g:sortableColumn property="pn" title="PN" params="${filterParams}"/>
            <g:sortableColumn property="sn" title="SN" params="${filterParams}"/>
            <g:sortableColumn property="location" title="Location" params="${filterParams}"/>
            <g:sortableColumn property="search_date" title="Date" params="${filterParams}"/>
            <g:sortableColumn property="state" title="State" params="${filterParams}"/>

          </tr>
          </thead>
          <tbody>
          <g:each in="${bookList}" status="i" var="book">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

              <td>${book.ip?.encodeAsHTML()}</td>
              <td>${book.type?.encodeAsHTML()}</td>
              <td>${book.pn.encodeAsHTML()}</td>
              <td>${book.sn?.encodeAsHTML()}</td>
              <td>${book.location?.encodeAsHTML()}</td>
              <td><g:formatDate date="${book.search_date}" format="yyyy-MM-dd"/></td>
              <td>${book.state?.encodeAsHTML()}</td>

            </tr>
          </g:each>
          </tbody>
        </table>
    </div>

    <div class="paginateButtons">
    <div class="pagination">
        <filterpane:paginate total="${bookCount}" domainBean="filterpane.BooksEqpt"/>
    </div>
    <filterpane:filterButton text="Search Filter" appliedText="Change Filter"/>
    <filterpane:isNotFiltered>Pure and Unfiltered!</filterpane:isNotFiltered>
    <filterpane:isFiltered>Filter Applied!</filterpane:isFiltered>
    </div>
    <div class="exportButtons" >
    <export:formats formats="['csv', 'excel', 'pdf', 'rtf']"  params="${filterParams}"/>
    <export:resource />
    </div>

    <div class="filterPaneTable">
      <filterpane:filterPane domain="filterpane.BooksEqpt"
                             additionalProperties=""
                             excludeProperties="device_type"
                             filterPropertyValues="${[search_date: [years: 2038..2000, precision: 'month', precision: 'day']]}"
                             titleKey="fp.tag.filterPane.titleText"
                             dialog="true"
                             visible="n"
                             showSortPanel="n"
                             showTitle="n"
                             fullAssociationPathFieldNames="false"/>
    </div>
</div>
</body>
</html>
