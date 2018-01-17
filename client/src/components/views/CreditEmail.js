import React, { Component } from 'react';
import EmailDataGrid from '../common/EmailDataGrid';
import axios from 'axios';

class CreditEmail extends Component {
    constructor() {
        super();
        this.state = {
            data: []
        };
    }

    componentWillMount() {
        axios.request({
            method: 'get',
            url: 'api/credit-email-inbox/'
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

    componentWillUnmount() {
        this.unmounted = true;
    }

    render() {
        return (
            <div className="page-content">
                <h1 className="page-title"> Smile Trade Credit
                    <small> credit inbox</small>
                </h1>
                <div className="page-bar">
                    <ul className="page-breadcrumb">
                        <li>
                            <i className="icon-home"></i>
                            <a href="/">Home</a>
                            <i className="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <span>Email</span>
                        </li>
                    </ul>
                </div>
                <div className="portlet box green">
                    <div className="portlet-title">
                        <div className="caption">
                            <i className="fa fa-globe"></i>Email </div>
                        <div className="tools"> </div>
                    </div>
                    <div className="portlet-body">
                        <EmailDataGrid data={this.state.data} />
                    </div>
                </div>
            </div>
        );
    }
}

export default CreditEmail;