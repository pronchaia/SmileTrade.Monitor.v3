import React, { Component } from 'react';
import Header from './components/common/Header';
import Sidebar from './components/common/Sidebar';

import Content from './Content'

import './App.css';
import "react-table/react-table.css";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentPage: 'dashboard'
    }

  }

  handleChange(page) {
    //alert(page);
    this.setState({ currentPage: page });
  }

  render() {
    return (
      <div>
        <Header />
        <div className="clearfix"> </div>
        <div className="page-container">
          <Sidebar currentPage={this.state.currentPage} change={this.handleChange.bind(this)} />
          <div className="page-content-wrapper">
            <Content />
          </div>

        </div>
        <div className="page-footer">
          <div className="page-footer-inner"> 2017 &copy; Smile Trade
                <div className="scroll-to-top">
              <i className="icon-arrow-up"></i>
            </div>
          </div>
        </div>
      </div>

    );
  }
}

export default App;
