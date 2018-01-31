import React, { Component } from 'react';

class TimelineDealStatus extends Component {
    render() {
        return (
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
        );
    }
}

export default TimelineDealStatus;

