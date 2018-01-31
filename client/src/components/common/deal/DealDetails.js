import React, { Component } from 'react';
import axios from 'axios';
import DealInfo from './DealInfo';
import DealAudit from './DealAudit';

class DealDetails extends Component {
    constructor() {
        super();
        this.state = {
            data: [],
            audit: []
        }
    }

    getApi(dealid) {
        axios.all([this.getDeal(dealid), this.getCreditStatusAudit(dealid)])
            .then(axios.spread(function (deal, audit) {
            })
            ).catch((error) => {
                console.log(error);
            });
    }

    getDeal(dealid) {
        axios.request({
            method: 'get',
            url: 'api/preparationdeal/' + dealid
        }).then((response) => {
            this.setState({ data: response.data }, () => {
                //console.log(this.state.data);
            })
        }).catch((error) => {
            console.log(error);
        });
    }

    getCreditStatusAudit(dealid) {
        axios.request({
            method: 'get',
            url: 'api/preparationdeal-credit-audit/' + dealid
        }).then((response) => {
            this.setState({ audit: response.data }, () => {
                //console.log(this.state.audit);
            })
        }).catch((error) => {
            console.log(error);
        });
    }



    componentDidMount() {
        this.getApi(this.props.dealid);
    }

    componentWillReceiveProps(nextProps) {
        if (nextProps.dealid !== this.props.dealid)
            this.getApi(nextProps.dealid);
    }

    render() {
        let dealdata;
        let audit;
        if (this.state.data) {
            dealdata = this.state.data;
            audit = this.state.audit;
        }
        return (
            <div className="portlet box green">
                <div className="portlet-title">
                    <div className="caption">
                        <i className="fa fa-bug"></i> Deal details </div>
                    <div className="tools">
                        <a className="javascript:;" class="collapse"> </a>
                        <a className="#portlet-config" data-toggle="modal" class="config"> </a>
                    </div>
                </div>
                <div className="portlet-body">
                    <div className="tabbable-custom ">
                        <ul className="nav nav-tabs ">
                            <li className="active">
                                <a href="#tab_5_1" className="#tab_5_1" data-toggle="tab"> Deal </a>
                            </li>
                            <li>
                                <a href="#tab_5_2" className="#tab_5_2" data-toggle="tab"> Audit </a>
                            </li>
                            <li>
                                <a href="#tab_5_3" data-toggle="tab"> Tracer </a>
                            </li>
                            <li>
                                <a href="#tab_5_4" data-toggle="tab"> Counterparty </a>
                            </li>
                        </ul>
                        <div className="tab-content">
                            <div className="tab-pane active" id="tab_5_1">
                                <DealInfo deal={dealdata} />
                            </div>
                            <div className="tab-pane" id="tab_5_2">
                                <DealAudit audit={audit} />
                            </div>
                            <div className="tab-pane" id="tab_5_3">
                                <p> Howdy, I'm in Section 3. </p>
                                <p> Duis autem vel eum iriure dolor in hendrerit in vulputate. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum
                                                    iriure dolor in hendrerit in vulputate velit esse molestie consequat </p>
                                <p>
                                    <a className="btn yellow" href="ui_tabs_accordions_navs.html#tab_5_3" target="_blank"> Activate this tab via URL </a>
                                </p>
                            </div>
                            <div className="tab-pane" id="tab_5_4">
                                <p> Howdy, I'm in Section 3. </p>
                                <p> Duis autem vel eum iriure dolor in hendrerit in vulputate. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum
                                                    iriure dolor in hendrerit in vulputate velit esse molestie consequat </p>
                                <p>
                                    <a className="btn yellow" href="ui_tabs_accordions_navs.html#tab_5_3" target="_blank"> Activate this tab via URL </a>
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        );
    }
}

export default DealDetails;