import React from 'react';

const champsJSON = require('./data/champion');
const champs = Object.keys(champsJSON.data);

export function getChamp (champName, color, logo) {

  const url = buildURL(capitalize(champName), 0);

  if (url) {
    return (
      <div>
        {/*<i className={buildLogo(logo, color)}></i>*/}
        <img className={ color } src={ url } alt={ champName }/>
      </div>
    );
  }

  return (
    <div className='redirect-new__missing-logo'>missing</div>
  );

};

export function getRandChamp(color, logo) {

  const champ = champs[getRandomInt(champs.length)];
  return getChamp(champ, color, logo);
};

function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

function buildURL(name, num) {
  return 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/' + capitalize(name) +
    '_' + num + '.jpg';
}

function buildLogo(logo, color) {
  return 'logo fa fa-' + logo + ' ' + color;
}

function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
}
