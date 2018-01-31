import React, { Component } from 'react';
import CountUp from 'react-countup';
import axios from 'axios';

class Card extends Component {
    constructor() {
        super();
        this.state = {
            cnt: 1688702920.212472919,
            percentage: 82.503216,
            text: 'TOTAL CONSUMPTION',
            textPercentage: 'SUM CONSUMPTION TODAY',
            icon: 'icon-pie-chart',
            decimal: 0
        }
    }

    componentWillMount() {
        if (this.props.Key === 'TOTALCONSUMPTION') {
            axios.request({
                method: 'get',
                url: 'api/consumption-percentage/'
            }).then((response) => {
                //console.log(response.data);
                this.setState({
                    cnt: response.data[0].consume,
                    percentage: parseFloat(response.data[0].percentage).toFixed(2),
                    text: 'TOTAL CONSUMPTION',
                    textPercentage: 'SUM CONSUMPTION TODAY',
                    icon: 'icon-pie-chart',
                    decimal: 2
                }, () => {
                    //console.log(this.state);
                });

            }).catch((error) => {
                console.log(error);
            });

        } else if (this.props.Key === 'DEALPREPARATION') {
            axios.request({
                method: 'get',
                url: 'api/preparationdeal-percentage/'
            }).then((response) => {
                //console.log(response.data);
                this.setState({
                    cnt: response.data[0].preparation,
                    percentage: parseFloat(response.data[0].deal_percentage).toFixed(2),
                    text: 'DEAL PREPARATION',
                    textPercentage: 'deal preparation / deal',
                    icon: 'icon-basket',
                    decimal: 0
                }, () => {
                    //console.log(this.state);
                });

            }).catch((error) => {
                console.log(error);
            });
        } else if (this.props.Key === 'NEWDEAL') {
            axios.request({
                method: 'get',
                url: 'api/deal-today-percentage/'
            }).then((response) => {
                //console.log(response.data);
                this.setState({
                    cnt: response.data[0].cnt,
                    percentage: parseFloat(response.data[0].percentage).toFixed(2),
                    text: 'NEW DEAL',
                    textPercentage: 'NEW DEAL TODAY',
                    icon: 'icon-like',
                    decimal: 0
                }, () => {
                    //console.log(this.state);
                });

            }).catch((error) => {
                console.log(error);
            });
        } else if (this.props.Key === 'NEWCOUNTERPARTYSAP') {
            axios.request({
                method: 'get',
                url: 'api/staparty-percentage/'
            }).then((response) => {
                //console.log(response.data);
                this.setState({
                    cnt: response.data[0].cnt,
                    percentage: parseFloat(response.data[0].percentage).toFixed(2),
                    text: 'Counterparty SAP',
                    textPercentage: 'New ToDay',
                    icon: 'icon-user',
                    decimal: 0
                }, () => {
                    //console.log(this.state);
                });

            }).catch((error) => {
                console.log(error);
            });
        }
    }

    render() {

        return (
            <div className="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div className="dashboard-stat2 ">
                    <div className="display">
                        <div className="number">
                            <h3 className="font-green-sharp">
                                <CountUp start={0} end={this.state.cnt} duration={3} decimals={this.state.decimal} decimal="." separator="," />
                            </h3>
                            <small>{this.state.text} </small>
                        </div>
                        <div className="icon">
                            <i className={this.state.icon}></i>
                        </div>
                    </div>
                    <div className="progress-info">
                        <div className="progress">
                        </div>
                        <div className="status">
                            <div className="status-title"> {this.state.textPercentage} </div>
                            <div id="spnConsumptionProgressText" className="status-number"> {this.state.percentage} % </div>
                        </div>
                    </div>
                </div>

            </div>
        );
    }
}

export default Card;