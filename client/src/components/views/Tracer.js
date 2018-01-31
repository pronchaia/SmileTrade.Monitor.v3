import React, { Component } from 'react';
import TracerDataGrid from '../common/tracer/TracerDataGrid';
import axios from 'axios';

class Tracer extends Component {
    constructor() {
        super();
        this.state = {
            data: []
        };
    }

    componentWillMount() {
        axios.request({
            method: 'get',
            url: 'api/systracer-table/'
        }).then((response) => {
            this.setState({
                data: response.data
            }, () => {
                console.log(this.state);
            });
        }).catch((error) => {
            console.log(error);
        });


    }

    render() {
        return (
            <div className="page-content">
                <h1 className="page-title"> Smile Trade Credit
                    <small> tracer</small>
                </h1>
                <div className="page-bar">
                    <ul className="page-breadcrumb">
                        <li>
                            <i className="icon-home"></i>
                            <a href="/">Home</a>
                            <i className="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <span>Tracer</span>
                        </li>
                    </ul>
                </div>
                <div className="portlet box green">
                    <div className="portlet-title">
                        <div className="caption">
                            <i className="fa fa-globe"></i>Tracer </div>
                        <div className="tools"> </div>
                    </div>
                    <div className="portlet-body">
                        <TracerDataGrid data={this.state.data} />
                    </div>
                </div>
            </div>
        );
    }
}

export default Tracer;