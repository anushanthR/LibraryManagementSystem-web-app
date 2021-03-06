<%-- 
    Document   : AddBook
    Created on : Jul 28, 2018, 9:15:52 PM
    Author     : Arun Yadhav
--%>
<%@page import="com.sgc.model.Book"%>
<%@page import="com.sgc.model.Classification"%>
<%@page import="java.util.List"%>
<%@page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <style>
            .dropdown-submenu {
                position: relative;
            }

            .dropdown-submenu a::after {
                transform: rotate(-90deg);
                position: absolute;
                right: 6px;
                top: .8em;
            }

            .dropdown-submenu .dropdown-menu {
                top: 0;
                left: 100%;
                margin-left: .1rem;
                margin-right: .1rem;
            }
            .navbar-nav>li{
                padding-left: 10px;
                padding-right: 10px;                
            }
            .navbar-brand{
                padding-left: 15px;
            }
            .card-header{
                background-color: #343a40;
                color: #fff;
            }
        </style>

    </head>
    <body>
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-5">
                <a class="navbar-brand" href="index.jsp"><img src="Content/ICONS/image.png" width="35" height="35"></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item dropdown">
                            <div class="btn-group">
                                <a class="btn btn-outline-light" href="ViewSubController">Classification</a>
                                <a class="btn btn-outline-light dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                                </a>
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <li class="dropdown-item"><a class="dropdown-item" href="AddMainClassification.jsp">Add Main classification</a>
                                    </li>
                                    <li class="dropdown-item"><a class="dropdown-item" href="AddSubClassification.jsp">Add Sub Classification</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <ul class="navbar-nav m1-auto">
                        <form class="form-inline my-2 my-lg-0" action="ViewBookController">
                            <input class="form-control mr-sm-2" name="txtSearchKey" type="search" placeholder="Search" aria-label="Search">
                            <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
                        </form>
                        <li class="nav-item active">
                            <a class="btn btn-outline-light" href="ViewBookController">View All Book<span class="sr-only">(current)</span></a>
                        </li>
                    </ul>
                </div>
            </nav>

            <div class="row">
                <div class="col col-md-8 offset-2">

                    <div class="card">
                        <div class="card-header"><b><center>UPDATE BOOK</center></b></div>
                        <div class="card-body">
                            <% if (request.getAttribute("result") != null) {
                                    Book b = (Book) request.getAttribute("result");
                            %>
                            <form name="editBookForm" id="editBookForm" action="UpdateBookController" onsubmit="return validateForm();" Method ="POST">
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <label for="txtMCID">Book ID</label>                                    
                                        <input type ="text" name ="txtBookId" id="txtBookId" class="form-control" value="<%= b.getId()%>" readonly/>
                                    </div>
                                    <div class="form-group col-md-5">
                                        <label for="txtTitle">Book Title</label>
                                        <input type ="text" name ="txtTitle" id="txtTitle" class="form-control" value="<%= b.getTitle()%>"/>
                                        <div id="messageTitle" class="invalid-feedback"></div>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label  for="txtAuthor">Author :</label>
                                        <input type ="text" name ="txtAuthor" id="txtAuthor" class="form-control" value="<%= b.getAuthor()%>"/> 
                                        <div id="messageAuthor" class="invalid-feedback"></div>
                                    </div> 
                                </div>  
                                <div class="form-row">
                                    <div class="form-group col-md-4">    
                                        <label for="txtMain">Main Classification</label>
                                        <select name ="txtMain" id="txtMain" class="form-control custom-select">
                                            <option value="" selected disabled hidden>--Select-Main-Classification--</option>                                            
                                        </select>
                                        <div id="messageMain" class="invalid-feedback"></div>
                                    </div>
                                    <div class="form-group col-md-4">    
                                        <label for="publishedYear">Published Year</label>
                                        <select name ="publishedYear" id="publishedYear" class="form-control custom-select" onChange="loadPrintedYear();">
                                            <option value="" selected disabled hidden>--Select-Published-Year--</option>
                                        </select>
                                        <div id="messagePublishedYear" class="invalid-feedback"></div>
                                    </div>
                                    <div class="form-group col-md-4">    
                                        <label  for="txtIsbn">ISBN No</label>
                                        <input type ="text" name ="txtIsbn" id="txtIsbn" class="form-control" value="<%= b.getIsbn()%>"/>
                                        <div id="messageIsbn" class="invalid-feedback"></div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-4">   
                                        <label for="txtSub">Sub Classification</label>
                                        <select name ="txtSub" id="txtSub" class="form-control custom-select">
                                            <option value="" selected disabled hidden>--Select-Sub-Classification--</option>
                                        </select>
                                        <div id="messageSub" class="invalid-feedback"></div>
                                    </div>
                                    <div class="form-group col-md-4">    
                                        <label for="printedYear">Printed Year</label>
                                        <select name ="printedYear" id="printedYear" class="form-control custom-select">
                                            <option value="" selected disabled hidden>--Select-Last-Printed-Year--</option>
                                        </select>
                                        <div id="messagePrintedYear" class="invalid-feedback"></div>
                                    </div>
                                    <div class="form-group col-md-4">    
                                        <label for="txtPages">No of pages</label>
                                        <input type ="text" name ="txtPages" id="txtPages" class="form-control" value="<%= b.getPages()%>"/>
                                        <div id="messagePages" class="invalid-feedback"></div>
                                    </div>
                                </div>
                                <button type ="Submit" class="btn btn-primary float-right">SUBMIT</button>
                            </form>
                        </div>
                    </div>
                </div>                
            </div>
        </div>        
    </body>
    <script type="text/javascript">
        function loadPublishedYear(){
            var fpy = document.getElementById('publishedYear');
            var cYear = (new Date()).getFullYear();
            for (var i = cYear; i >= 1800; i--) {
                var theOption = new Option;
                theOption.text = i;
                theOption.value = i;
                fpy.options[cYear - i + 1] = theOption;
            }
            $('#publishedYear').val("<%= b.getPublishedYear()%>");
        }
        
        function selectPrintedYear() {
            document.getElementById("printedYear").options.length = 0;

            var temp = document.getElementById("publishedYear");
            var startYear = temp.options[temp.selectedIndex].value;
            var lpy = document.getElementById('printedYear');
            var cYear = (new Date()).getFullYear();
            for (var i = cYear; i >= startYear; i--) {
                var theOption = new Option;
                theOption.text = i;
                theOption.value = i;
                lpy.options[cYear - i] = theOption;
            }
            $('#printedYear').val("<%= b.getPrintedYear()%>");
        }
        
        function loadPrintedYear() {
            document.getElementById("printedYear").options.length = 0;

            var temp = document.getElementById("publishedYear");
            var startYear = temp.options[temp.selectedIndex].value;
            var lpy = document.getElementById('printedYear');
            var cYear = (new Date()).getFullYear();
            for (var i = cYear; i >= startYear; i--) {
                var theOption = new Option;
                theOption.text = i;
                theOption.value = i;
                lpy.options[cYear - i] = theOption;
            }            
        }
        window.onload = loadPublishedYear();
        window.onload = selectPrintedYear();

        $(document).ready(function () {
            $.get("LoadMainController", function (responseJson) {
                var $select = $("#txtMain");
                $.each(responseJson, function (key, value) {
                    $("<option>").val(key).text(value).appendTo($select);
                });
                $('#txtMain').val("<%= b.getMain()%>");
            });
        
            var txtMain = "<%= b.getMain()%>";
            $.get("LoadSubController", {txtMain: txtMain}, function (responseJson) {
                var $select = $("#txtSub");
                $select.find("option").remove();
                $.each(responseJson, function (key, value) {
                    $("<option>").val(key).text(value).appendTo($select);
                });
                $('#txtSub').val("<%= b.getSub()%>");
            });
        });

        $(document).on("change", "#txtMain", function () {
            var txtMain = $('#txtMain').val();
            $.get("LoadSubController", {txtMain: txtMain}, function (responseJson) {
                var $select = $("#txtSub");
                $select.find("option").remove();
                $.each(responseJson, function (key, value) {
                    $("<option>").val(key).text(value).appendTo($select);
                });
            });
        });
        
        function validateForm() {
            var title = document.forms["editBookForm"]["txtTitle"].value;            
            if (title == null || title == "") {
                document.getElementById('txtTitle').classList.add('is-invalid');
            } else {
                document.getElementById('txtTitle').classList.remove('is-invalid');
            }

            var author = document.forms["editBookForm"]["txtAuthor"].value;
            if (author == null || author == "") {
                document.getElementById('txtAuthor').classList.add('is-invalid');
            } else {
                document.getElementById('txtAuthor').classList.remove('is-invalid');
            }

            var isbn = document.forms["editBookForm"]["txtIsbn"].value;
            if (isbn == null || isbn == "") {
                document.getElementById('txtIsbn').classList.add('is-invalid');
            } else {
                document.getElementById('txtIsbn').classList.remove('is-invalid');
            }

            var vMain = document.forms["editBookForm"]["txtMain"].value;
            if (vMain == null || vMain == "") {
                document.getElementById('txtMain').classList.add('is-invalid');
            } else {
                document.getElementById('txtMain').classList.remove('is-invalid');
            }

            var vSub = document.forms["editBookForm"]["txtSub"].value;
            if (vSub == null || vSub == "") {
                document.getElementById('txtSub').classList.add('is-invalid');
            } else {
                document.getElementById('txtSub').classList.remove('is-invalid');
            }
            var pubishedYear = document.forms["editBookForm"]["publishedYear"].value;
            if (pubishedYear == null || pubishedYear == "") {
                document.getElementById('publishedYear').classList.add('is-invalid');
            } else {
                document.getElementById('publishedYear').classList.remove('is-invalid');
            }

            var printedYear = document.forms["editBookForm"]["printedYear"].value;
            if (printedYear == null || printedYear == "") {
                document.getElementById('printedYear').classList.add('is-invalid');
            } else {
                document.getElementById('printedYear').classList.remove('is-invalid');
            }

            var nop = document.forms["editBookForm"]["txtPages"].value;
            if (nop == null || nop == "") {
                document.getElementById('txtPages').classList.add('is-invalid');
            } else {
                document.getElementById('txtPages').classList.remove('is-invalid');
            }
            if ((printedYear == null || printedYear == "") ||
                    (pubishedYear == null || pubishedYear == "") ||
                    (nop == null || nop == "") ||
                    (isbn == null || isbn == "") ||
                    (title == null || title == "") ||
                    (author == null || author == "") ||
                    (vMain == null || vMain == "") ||
                    (vSub == null || vSub == "")) {
                return false;
            }
        }
    </script>
    <%}%>
</html>
