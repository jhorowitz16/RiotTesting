import React from 'react';

export function getChamp (champName) {

  const url = buildURL(capitalize(champName), 0);

  if (url) {
    return (
      <img src={ url } alt={ champName }/>
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

function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
}
