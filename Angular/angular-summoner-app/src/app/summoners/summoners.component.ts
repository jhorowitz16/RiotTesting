import { Component, OnInit } from '@angular/core';
import { Summoner } from '../summoner';
import { SUMMONERS } from '../mock-summoners'

@Component({
  selector: 'app-summoners',
  templateUrl: './summoners.component.html',
  styleUrls: ['./summoners.component.css']
})
export class SummonersComponent implements OnInit {

  // summoner = 'summoner7';
  summoners = SUMMONERS;
  summoner: Summoner = {
    id: 1,
    name: 'fed7'
  };

  constructor() { }

  ngOnInit() {
  }

  selectedSummoner: Summoner;

  onSelect(summoner: Summoner) {
    console.log("selected: " + summoner.name);
    // console.log("before: " + this.selectedSummoner.name);
    this.selectedSummoner = summoner;
    console.log("after: " + this.selectedSummoner.name);
  }

}
