import React, { Component } from 'react';

class CpWorstdate extends Component {
    constructor() {
        super();
        this.state = {
        }

    }

    render() {
        return (
            <div className="page-content">
                <h1 className="page-title"> Smile Trade Credit
                    <small> search counterparty worst date</small>
                </h1>
                <div className="page-bar">
                    <ul className="page-breadcrumb">
                        <li>
                            <i className="icon-home"></i>
                            <a href="/">Home</a>
                            <i className="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <span>Worst date</span>
                        </li>
                    </ul>
                </div>
                <div className="portlet box green">
                    <div className="portlet-title">
                        <div className="caption">
                            <i className="fa fa-globe"></i>Worst date </div>
                        <div className="tools"> </div>
                    </div>

                </div>
                <div className="search-page search-content-3">
                    <div className="row">
                    </div>
                </div>
            </div>
        );
    }
}

export default CpWorstdate;