import React, {Component} from 'react';
import logo from './data/logo.svg';
import './css/navbar.css';

class Navbar extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo"/>
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>

        <table>
          <div>hello</div>
          <div>hello</div>

        </table>
      </div>
    );
  }
}

export default Navbar;
