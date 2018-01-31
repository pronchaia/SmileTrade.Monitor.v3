import React, { Component } from 'react';
import DealSearch from '../common/deal/DealSearch';
import TimelineConsumption from '../common/deal/TimelineConsumption';
import DealDetails from '../common/deal/DealDetails';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
class Deal extends Component {
    constructor() {
        super();
        this.state = {
            data: [],
            dealid: ''
        }
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange(dealid) {
        this.setState({ dealid: dealid }, () => {
            //console.log(this.state.dealid);
        });
    }

    render() {
        let consumption;
        let dealdetails;
        if (this.state.dealid !== "") {
            consumption = <TimelineConsumption dealid={this.state.dealid} />;
            dealdetails = <DealDetails dealid={this.state.dealid} />;
        }

        return (
            <div className="page-content">
                <div className="theme-panel">
                    <div className="toggler tooltips" data-container="body" data-placement="left" data-html="true" data-original-title="Click to open advance theme customizer panel">
                        <i className="icon-settings"></i>
                    </div>
                </div>
                <h1 className="page-title"> Deal
                        <small> timeline </small>
                </h1>
                <div className="page-bar">
                    <ul className="page-breadcrumb">
                        <li>
                            <i className="icon-home"></i>
                            <a href="/">Home</a>
                            <i class="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <span> Deal</span>
                        </li>
                    </ul>
                    <div className="page-toolbar">

                    </div>
                </div>
                <div className="search-page search-content-2">
                    <div className="search-bar ">
                        <div className="row">
                            <div className="form-group form-group-lg">
                                <MuiThemeProvider>
                                    <DealSearch onSearchClick={this.handleChange} />
                                </MuiThemeProvider>
                            </div>
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-md-4">
                            {consumption}
                        </div>
                        <div className="col-md-8">
                            {dealdetails}
                        </div>
                    </div>
                </div>



            </div >

        );
    }
}

export default Deal;