<%-- 
    Document   : AddBook
    Created on : Jul 28, 2018, 9:15:52 PM
    Author     : Arun Yadhav
--%>
<%@page import="com.sgc.model.Classification"%>
<%@page import="com.sgc.model.Book"%>
<%@page language="java"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <!--<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script type="text/javascript" language="javascript" src="Content/bootstrap-4.1.3-dist/js/jquery.tablesorter.min.js"></script>
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
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-3">
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
                                <li class="dropdown-item"><a class="dropdown-item" href="MainIdAutoGenController">Add Main classification</a>
                                </li>                                    
                            </ul>
                        </div>
                    </li>
                    <!--                <li class="nav-item active">
                                        <a class="btn btn-outline-light" href="AddBook.jsp">Add Book <span class="sr-only">(current)</span></a>
                                    </li>-->
                </ul>
                <ul class="navbar-nav m1-auto">
                    <form class="form-inline my-2 my-lg-0">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
                    </form>
                    <li class="nav-item active">
                        <a class="btn btn-outline-light" href="ViewSubController">View All Classifications</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="row" style="padding-top: 50px;">
                <div class="col col-md-4 offset-4 mb-3">
                    <% if (request.getAttribute("result") != null) {
                            Classification c = (Classification) request.getAttribute("result");
                    %>
                    <div class="card">
                        <div class="card-header"><b><center>EDIT SUB CLASSIFICATION</center></b></div>
                        <div class="card-body">
                            <form action="UpdateSubController" method="get">
                                <div class="form-row">
                                    <div class="form-group col-md-12">                       
                                        <Label for="txtsubId">ID</label>
                                        <input type ="text" name ="txtSubId" class="form-control mb-3" value="<%= c.getSubId()%>" readonly/>                        
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <Label for="txtsubId">Main Classification</label>
                                        <select name ="txtMainId" id="txtMain" class="form-control custom-select mb-3">
                                            <option value="" selected disabled hidden>--Select-Main-Classification--</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <Label for="txtsubId">Sub Classification</label>
                                        <input type ="text" name ="txtSubClass" class="form-control mb-3" value="<%= c.getSubClass()%>"/>
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
    <script>
        $(document).ready(function () {
            $.get("LoadMainController", function (responseJson) {
                var $select = $("#txtMain");
                $.each(responseJson, function (key, value) {
                    $("<option>").val(key).text(value).appendTo($select);
                });
                $("#txtMain").val("<%= c.getMainId()%>");
            });
        });
    </script>
    <%}%>
</html>