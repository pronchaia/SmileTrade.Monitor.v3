import React, { Component } from 'react';
import Card from '../common/Card';
import BackGroundJobChart from '../common/BackGroundJobChart';
import EmailChart from '../common/EmailChart';

class Dashboard extends Component {
    constructor() {
        super();
        this.state = {
        }

    }

    render() {
        return (
            <div className="page-content">
                <h1 className="page-title"> Smile Trade Credit</h1>
                <div className="page-bar">
                    <ul className="page-breadcrumb">
                        <li>
                            <i className="icon-home"></i>
                            <a href="/">Home</a>
                            <i className="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <span>Dashboard</span>
                        </li>
                    </ul>
                </div>
                <div className="row">
                    <Card Key='TOTALCONSUMPTION' />
                    <Card Key='DEALPREPARATION' />
                    <Card Key='NEWDEAL' />
                    <Card Key='NEWCOUNTERPARTYSAP' />
                </div>
                <div className="row">
                    <div className="col-lg-6 col-xs-12 col-sm-12">
                        <BackGroundJobChart />
                    </div>
                    <div className="col-lg-6 col-xs-12 col-sm-12">
                        <EmailChart />
                    </div>
                </div>
            </div>
        );
    }
}

export default Dashboard;