import React, {Component} from 'react';
import './css/champs.css';
import { getChamp } from "./getChamp";

class Champs extends Component {


  helper() {
    // temp
  }

  render() {

    const aatrox = 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Aatrox_0.jpg',
      ahri = 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Ahri_0.jpg',
      akali = 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Akali_0.jpg';

    const temp = this.helper();

    return (
      <div className='champs-wrapper'>
        <table className='champs-table'>
          <tbody>
            <tr>
              <td>
                <div className="champs-table__champ">
                  {getChamp("aatrox", 'red', 'bomb')}
                </div>
              </td>
              <td>
                <div className="champs-table__champ">
                  {getChamp("ahri", 'blue', 'heart')}
                </div>
              </td>
              <td>
                <div className="champs-table__champ">
                  {getChamp("akali", 'green', 'bolt')}
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    );
  }
}

export default Champs;
