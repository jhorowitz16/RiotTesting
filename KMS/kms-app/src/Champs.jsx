import React, {Component} from 'react';
import './css/champs.css';

class Champs extends Component {
  render() {
    return (
      <div className='champs-wrapper'>
        <table className='champs-table'>
          <tr>
            <td>
              <div className="champs-table__champ"></div>
            </td>
            <td>
              <div className="champs-table__champ"></div>
            </td>
            <td>
              <div className="champs-table__champ"></div>
            </td>
          </tr>
        </table>
      </div>
    );
  }
}

export default Champs;
