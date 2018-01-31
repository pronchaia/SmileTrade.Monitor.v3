import React, { Component } from 'react';
import axios from 'axios';
import AutoComplete from 'material-ui/AutoComplete';
import RaisedButton from 'material-ui/RaisedButton';

class DealSearch extends Component {
    constructor(props) {
        super(props);
        this.state = {
            dataSource: [],
            dealid: ''
        }
    }

    componentDidMount() {
        axios.request({
            method: 'get',
            url: 'api/preparationdeal-auto-text/'
        }).then((response) => {
            this.setState({ dataSource: response.data }, () => {
                //console.log(this.state.data);
            })
        }).catch((error) => {
            console.log(error);
        });

    }

    handleUpdateInput = (value) => {
        this.setState({ dealid: value });

    };

    handleSearchClick(e) {
        //console.log(this.state.dealid);
        e.stopPropagation();
        this.props.onSearchClick(this.state.dealid);
    }

    render() {
        let dataSource;
        if (this.state.dataSource) {
            dataSource = this.state.dataSource;
        }

        const dataSourceConfig = {
            text: 'DealID',
            value: 'DealID',
        };

        const style = {
            margin: 12,
        };

        return (

            <div className="col-sm-5">
                <AutoComplete
                    hintText="Type Deal ID"
                    floatingLabelText="Deal ID"
                    dataSource={dataSource}
                    onUpdateInput={this.handleUpdateInput.bind(this)}
                    openOnFocus={true}
                    dataSourceConfig={dataSourceConfig}
                />
                <RaisedButton label="Search" primary={true} style={style} onClick={this.handleSearchClick.bind(this)} />
            </div>
        );
    }
}

export default DealSearch;