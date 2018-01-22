import React, { Component } from 'react';

class Header extends Component {
    render() {
        return (
            <div className="page-header navbar navbar-fixed-top">
                <div className="page-header-inner ">
                    <div className="page-logo">
                        <a href="/">
                            <img src="assets/layouts/layout2/img/logo.png" alt="logo" className="logo-default" /> </a>
                        <div className="menu-toggler sidebar-toggler">
                        </div>
                    </div>
                    <a href="javascript:;" className="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
                    <div className="page-top">
                        <form className="search-form search-form-expanded" action="/" method="GET">
                            <div className="input-group">
                                <input type="text" className="form-control" placeholder="Search deal ..." name="query" />
                                <span className="input-group-btn">
                                    <a href="javascript:;" className="btn submit">
                                        <i className="icon-magnifier"></i>
                                    </a>
                                </span>
                            </div>
                        </form>
                        <div className="top-menu">
                            <ul className="nav navbar-nav pull-right">
                                <li className="dropdown dropdown-user">
                                    <a href="javascript:;" className="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                        <img alt="" className="img-circle" src="assets/layouts/layout2/img/avatar_chai.jpg" />
                                        <span className="username username-hide-on-mobile"> Pronchai.A </span>
                                        <i className="fa fa-angle-down"></i>
                                    </a>
                                    <ul className="dropdown-menu dropdown-menu-default">
                                        <li>
                                            <a href="#">
                                                <i className="icon-user"></i> My Profile </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i className="icon-calendar"></i> My Calendar </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i className="icon-envelope-open"></i> My Inbox
                                        <span className="badge badge-danger"> 3 </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i className="icon-rocket"></i> My Tasks
                                        <span className="badge badge-success"> 7 </span>
                                            </a>
                                        </li>
                                        <li className="divider"> </li>
                                        <li>
                                            <a href="#">
                                                <i className="icon-lock"></i> Lock Screen </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i className="icon-key"></i> Log Out </a>
                                        </li>
                                    </ul>
                                </li>

                                <li className="dropdown dropdown-extended quick-sidebar-toggler">
                                    <span className="sr-only">Toggle Quick Sidebar</span>
                                    <i className="icon-logout"></i>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>

            </div>
        );
    }
}

export default Header;