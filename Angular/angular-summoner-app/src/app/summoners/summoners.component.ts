import { Component, OnInit } from '@angular/core';
import { Summoner } from '../summoner';

@Component({
  selector: 'app-summoners',
  templateUrl: './summoners.component.html',
  styleUrls: ['./summoners.component.css']
})
export class SummonersComponent implements OnInit {

  // summoner = 'summoner7';
  summoner: Summoner = {
    id: 1,
    name: 'fed7'
  };

  constructor() { }

  ngOnInit() {
  }

}
