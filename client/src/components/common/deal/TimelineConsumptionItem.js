import React, { Component } from 'react';

class TimelineConsumptionItem extends Component {
    render() {
        let items;
        //console.log(this.props.data);
        if (this.props.data) {
            var sorted = this.props.data.sort(function (a, b) {
                return (a.CalculationGroup > b.CalculationGroup) ? 1 : ((b.CalculationGroup > a.CalculationGroup) ? -1 : 0)
            });

            items = sorted.map(item => {
                let id = item.ID;
                let groupid = item.CalculationGroup;
                let calculationGroup = item.CalculationGroupText;
                let consumeDate = item.ConsumeDate;
                let amount = item.Amount;

                let icon = "";
                if (groupid === "1") {
                    icon = "icon-home";
                } else if (groupid === "2") {
                    icon = " icon-doc";
                } else if (groupid === "3") {
                    icon = "icon-link";
                } else if (groupid === "4") {
                    icon = "icon-user";
                } else if (groupid === "5") {
                    icon = "icon-users";
                } else if (groupid === "6") {
                    icon = "icon-shield";
                } else {
                    icon = "icon-bulb";
                }

                return (
                    <div key={id} className="timeline-item ">
                        <div className="timeline-badge ">
                            <div className="timeline-icon bg-red bg-font-red border-grey-steel">
                                <i className={icon} ></i>
                            </div>
                        </div>
                        <div className="timeline-body">
                            <div className="timeline-body-arrow"> </div>
                            <div className="timeline-body-head">
                                <div className="timeline-body-head-caption">
                                    <a href="javascript:;" className="timeline-body-title font-blue-madison"> {calculationGroup}</a>
                                    <span className="timeline-body-time font-grey-cascade">
                                        {consumeDate}
                                    </span>
                                </div>

                            </div>
                            <div className="timeline-body-content">
                                <span className="font-grey-cascade">
                                    Amount : {new Intl.NumberFormat('en-US').format(amount)}
                                </span>
                            </div>
                        </div>
                    </div>

                )
            });

        }
        return (
            <div className="timeline">
                {items}
            </div>
        );
    }
}

export default TimelineConsumptionItem;