import React, { Component } from 'react';
import TimelineConsumptionItem from './TimelineConsumptionItem';
import axios from 'axios';

class TimelineConsumption extends Component {
    constructor() {
        super();
        this.state = {
            data: []
        }
    }

    getConsumption(dealid) {
        axios.request({
            method: 'get',
            url: 'api/preparationdeal-consumption/' + dealid
        }).then((response) => {
            this.setState({ data: response.data }, () => {
                console.log(this.state.data);
            })
        }).catch((error) => {
            console.log(error);
        });
    }

    componentDidMount() {
        this.getConsumption(this.props.dealid);
    }

    componentWillReceiveProps(nextProps) {
        //console.log(nextProps.dealid);
        if (nextProps.dealid !== this.props.dealid)
            this.getConsumption(nextProps.dealid);
    }


    render() {
        let timeline;
        if (this.state.data) {
            timeline = <TimelineConsumptionItem data={this.state.data} />;
        }
        return (
            <div className="portlet light portlet-fit ">
                <div className="portlet-title">
                    <div className="caption">
                        <i className="icon-calendar font-green"></i>
                        <span className="caption-subject bold font-green uppercase"> Consumption</span>
                    </div>
                </div>
                <div className="portlet-body">
                    {timeline}
                </div>
            </div>
        );
    }
}

export default TimelineConsumption;