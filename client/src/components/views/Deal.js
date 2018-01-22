import React, { Component } from 'react';

class Deal extends Component {

    render() {
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
                            <div className="col-md-12">
                                <div className="input-group">
                                    <input type="text" className="form-control" placeholder="Search for..." />
                                    <span className="input-group-btn">
                                        <button className="btn blue uppercase bold" type="button">Search</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-md-6">
                            <div className="portlet light portlet-fit ">
                                <div className="portlet-title">
                                    <div className="caption">
                                        <i className="icon-calendar font-green"></i>
                                        <span className="caption-subject bold font-green uppercase"> Consumption</span>
                                    </div>
                                </div>
                                <div className="portlet-body">
                                    <div className="timeline">
                                        <div className="timeline-item ">
                                            <div className="timeline-badge ">
                                                <div className="timeline-icon bg-red bg-font-red border-grey-steel">
                                                    <i className="icon-home"></i>
                                                </div>
                                            </div>
                                            <div className="timeline-body">
                                                <div className="timeline-body-arrow"> </div>
                                                <div className="timeline-body-head">
                                                    <div className="timeline-body-head-caption">
                                                        <a href="javascript:;" className="timeline-body-title font-blue-madison">Andres Iniesta</a>
                                                        <span className="timeline-body-time font-grey-cascade">Replied at 7:45 PM</span>
                                                    </div>

                                                </div>
                                                <div className="timeline-body-content">
                                                    <span className="font-grey-cascade"> Lorem ipsum dolor sit amet. </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="col-md-6">
                            <div className="portlet light portlet-fit bg-inverse bordered">
                                <div className="portlet-title">
                                    <div className="caption">
                                        <i className="icon-microphone font-red"></i>
                                        <span className="caption-subject bold font-red uppercase"> Grey Timeline 1</span>
                                    </div>
                                </div>
                                <div className="portlet-body">
                                    <div className="timeline  white-bg white-bg">
                                        <div className="timeline-item">
                                            <div className="timeline-badge">
                                                <div className="timeline-icon">
                                                    <i className="icon-home font-green-haze"></i>
                                                </div>
                                            </div>
                                            <div className="timeline-body">
                                                <div className="timeline-body-arrow"> </div>
                                                <div className="timeline-body-head">
                                                    <div className="timeline-body-head-caption">
                                                        <span className="timeline-body-alerttitle font-red-intense">You have new follower</span>
                                                        <span className="timeline-body-time font-grey-cascade">at 11:00 PM</span>
                                                    </div>
                                                    <div className="timeline-body-head-actions">
                                                        <div className="btn-group">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="timeline-body-content">
                                                    <span className="font-grey-cascade"> You have new follower
                                                        <a href="javascript:;">Ivan Rakitic</a>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



            </div >

        );
    }
}

export default Deal;