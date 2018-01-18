import React, { Component } from 'react';
import axios from 'axios';
import { Line } from 'react-chartjs-2';

class BackGroundJobChart extends Component {
    constructor() {
        super();
        this.state = {
            labels: [],
            dataSap: [],
            dataMorning: []
        }
    }

    componentWillMount() {

        axios.request({
            method: 'get',
            url: 'api/backgroundjob-days/'
        }).then((response) => {
            this.setState({
                labels: response.data
            })
        }).catch((error) => {
            console.log(error);
        });

        axios.request({
            method: 'get',
            url: 'api/backgroundjob-sap/'
        }).then((response) => {
            let data = response.data.map(function (sap) {
                return sap.SECOND;
            });
            //console.log(data);
            this.setState({
                dataSap: data
            });
        }).catch((error) => {
            console.log(error);
        });

        axios.request({
            method: 'get',
            url: 'api/backgroundjob-morning/'
        }).then((response) => {
            let data = response.data.map(function (sap) {
                return sap.SECOND;
            });
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
            labels: this.state.labels,
            datasets: [
                {
                    label: 'SAP',
                    type: 'line',
                    fill: false,
                    backgroundColor: 'rgba(75,192,192,0.4)',
                    borderColor: 'rgba(75,192,192,1)',
                    borderDashOffset: 0.0,
                    borderCapStyle: 'butt',
                    borderJoinStyle: 'miter',
                    pointBorderColor: 'rgba(75,192,192,1)',
                    pointBackgroundColor: '#fff',
                    pointBorderWidth: 1,
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: 'rgba(75,192,192,1)',
                    pointHoverBorderColor: 'rgba(220,220,220,1)',
                    pointHoverBorderWidth: 2,
                    pointRadius: 1,
                    pointHitRadius: 10,
                    data: this.state.dataSap
                },
                {
                    label: 'Morning',
                    type: 'line',
                    fill: false,
                    backgroundColor: '#EC932F',
                    borderColor: '#EC932F',
                    borderDashOffset: 0.0,
                    borderCapStyle: 'butt',
                    borderJoinStyle: 'miter',
                    pointBorderColor: '#EC932F',
                    pointBackgroundColor: '#fff',
                    pointBorderWidth: 1,
                    pointHoverRadius: 5,
                    pointBackgroundColor: '#EC932F',
                    pointHoverBackgroundColor: '#EC932F',
                    pointHoverBorderColor: '#EC932F',
                    pointHoverBorderWidth: 2,
                    pointRadius: 1,
                    pointHitRadius: 10,
                    data: this.state.dataMorning
                }
            ]
        };
        return (
            <div className="portlet light ">
                <div className="portlet-title">
                    <div className="caption">
                        <span className="caption-subject bold uppercase font-dark">SAP and Morning</span>
                        <span className="caption-helper"> Job .</span>
                    </div>
                    <div className="actions">
                        <a className="btn btn-circle btn-icon-only btn-default fullscreen" href="#"> </a>
                    </div>
                </div>
                <div className="portlet-body">
                    <Line data={data} />
                </div>

            </div>
        );
    }
}

export default BackGroundJobChart;