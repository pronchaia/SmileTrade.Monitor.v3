import React, { Component } from 'react';
import ReactDOM from 'react-dom'

export default class MapSearch extends Component {

    state = { 
        name:[]
    }
    componentDidMount() {
    
        fetch('http://localhost:5000/api/v1/objects')
          .then((response) => response.json())
          .then(json => {
              this.setState({name:json})
              console.log(this.state.name)
          });
          
      }
    render() {
        const listItems;
        if (this.state.name) {
            listItems =  this.state.name.map((item, i) =>
                <li>{item.name}</li>
            );
        }

       

        return ( 
            <div>
                <ul>
                <p>Tracking app</p>
                <input className="input" type="text"/>
                <button className="button is-primary">Search</button>
                   
                {listItems}

                </ul>       
            </div>)
            }
        }