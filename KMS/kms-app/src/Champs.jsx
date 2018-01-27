import React, {Component} from 'react';
import './css/champs.css';
import { getChamp, getRandChamp } from "./getChamp";

class Champs extends Component {

  render() {

    const aatrox = 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Aatrox_0.jpg',
      ahri = 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Ahri_0.jpg',
      akali = 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Akali_0.jpg';

    return (
      <div className='champs-wrapper'>
        <table className='champs-table'>
          <tbody>
            <tr>
              <td>
                <div className="champs-table__champ">
                  {getRandChamp('red', 'bomb')}
                </div>
              </td>
              <td>
                <div className="champs-table__champ">
                  {getRandChamp('blue', 'heart')}
                </div>
              </td>
              <td>
                <div className="champs-table__champ">
                  {getRandChamp('green', 'bolt')}
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
