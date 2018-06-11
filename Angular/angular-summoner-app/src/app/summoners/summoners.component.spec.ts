import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SummonersComponent } from './summoners.component';

describe('SummonersComponent', () => {
  let component: SummonersComponent;
  let fixture: ComponentFixture<SummonersComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SummonersComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SummonersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
