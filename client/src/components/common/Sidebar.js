import React, { Component } from 'react';
import { Link } from 'react-router-dom';

class Sidebar extends Component {
    change(page) {
        this.props.change(page);
    }

    render() {
        return (
            <div className="page-sidebar-wrapper">
                <div className="page-sidebar navbar-collapse collapse">
                    <ul className="page-sidebar-menu  page-header-fixed page-sidebar-menu-hover-submenu page-sidebar-menu-closed " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                        <li className={(this.props.currentPage === 'dashboard') ? 'nav-item start active open' : 'nav-item  '}>
                            <Link to='/' onClick={this.change.bind(this, 'dashboard')} className="nav-link nav-toggle">
                                <i className="icon-home"></i>
                                <span className="title">Dashboard</span>
                                <span className={(this.props.currentPage === 'dashboard') ? 'selected' : ''}></span>
                                <span className={(this.props.currentPage === 'dashboard') ? 'arrow open' : 'arrow'}></span>
                            </Link>
                        </li>

                        <li className={(this.props.currentPage === 'systracer') ? 'nav-item start active open' : 'nav-item  '}>
                            <Link to='/Tracer' onClick={this.change.bind(this, 'systracer')} className="nav-link nav-toggle">
                                <i className="icon-settings"></i>
                                <span className="title">Tracer</span>
                                <span className={(this.props.currentPage === 'systracer') ? 'selected' : ''}></span>
                                <span className={(this.props.currentPage === 'systracer') ? 'arrow open' : 'arrow'}></span>
                            </Link>

                        </li>

                        <li className={(this.props.currentPage === 'creditemail') ? 'nav-item start active open' : 'nav-item  '}>
                            <Link to='/Email' onClick={this.change.bind(this, 'creditemail')} className="nav-link nav-toggle">
                                <i className="icon-envelope"></i>
                                <span className="title">Email</span>
                                <span className={(this.props.currentPage === 'creditemail') ? 'selected' : ''}></span>
                                <span className={(this.props.currentPage === 'creditemail') ? 'arrow open' : 'arrow'}></span>
                            </Link>
                        </li>

                        <li className={(this.props.currentPage === 'cpworstdate') ? 'nav-item start active open' : 'nav-item  '}>
                            <Link to='/Worstdate' onClick={this.change.bind(this, 'cpworstdate')} className="nav-link nav-toggle">
                                <i className="icon-magnifier"></i>
                                <span className="title">Worst date</span>
                                <span className={(this.props.currentPage === 'cpworstdate') ? 'selected' : ''}></span>
                                <span className={(this.props.currentPage === 'cpworstdate') ? 'arrow open' : 'arrow'}></span>
                            </Link>
                        </li>
                    </ul>
                </div>
            </div>

        );
    }
}

export default Sidebar;