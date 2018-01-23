import React from 'react';

export function getChamp (champName, color, logo) {

  const url = buildURL(capitalize(champName), 0);

  if (url) {
    return (
      <div>
        <i className={buildLogo(logo)}></i>
        <img className={ color } src={ url } alt={ champName }/>
      </div>
    );
  }

  return (
    <div className='redirect-new__missing-logo'>missing</div>
  );

};

function buildURL(name, num) {
  return 'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/' + capitalize(name) +
    '_' + num + '.jpg';
}

function buildLogo(logo) {
  return 'logo fa fa-' + logo;
}

function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
}
