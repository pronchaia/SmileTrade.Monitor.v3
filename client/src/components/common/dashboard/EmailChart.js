import React, { Component } from 'react';
import axios from 'axios';
import { Bar } from 'react-chartjs-2';

class EmailChart extends Component {
    constructor() {
        super();
        this.state = {
            dataSap: [],
            dataMorning: []
        }
    }

    componentWillMount() {
        axios.request({
            method: 'get',
            url: 'api/backgroundjob-email-sap/'
        }).then((response) => {
            let data = response.data;
            this.setState({
                dataSap: data
            });
        }).catch((error) => {
            console.log(error);
        });

        axios.request({
            method: 'get',
            url: 'api/backgroundjob-email-morning/'
        }).then((response) => {
            let data = response.data;
            //console.log(data);
            this.setState({
                dataMorning: data
            });
        }).catch((error) => {
            console.log(error);
        });
    }


    render() {
        console.log(this.state.dataSap);
        const data = {
            labels: ['Overlimit Blocked', 'No Assigned Security Blocked', 'Warning assign security'],
            datasets: [
                {
                    label: 'SAP',
                    backgroundColor: 'rgba(255,99,132,0.2)',
                    borderColor: 'rgba(255,99,132,1)',
                    borderWidth: 1,
                    hoverBackgroundColor: 'rgba(255,99,132,0.4)',
                    hoverBorderColor: 'rgba(255,99,132,1)',
                    data: this.state.dataSap
                },
                {
                    label: 'Morning',
                    backgroundColor: '#EC932F',
                    borderColor: '#EC932F',
                    borderWidth: 1,
                    hoverBackgroundColor: '#EC932F',
                    hoverBorderColor: '#EC932F',
                    data: this.state.dataMorning
                }
            ]
        };
        return (
            <div className="portlet light ">
                <div className="portlet-title">
                    <div className="caption">
                        <span className="caption-subject bold uppercase font-dark">Credit Email</span>
                        <span className="caption-helper"> today .</span>
                    </div>
                    <div className="actions">
                        <a className="btn btn-circle btn-icon-only btn-default fullscreen" href="#"> </a>
                    </div>
                </div>
                <div className="portlet-body">
                    <Bar data={data} />
                </div>

            </div>
        );
    }
}

export default EmailChart;