import { TestBed } from '@angular/core/testing';

import { MakerService } from './maker.service';

describe('MakerService', () => {
  let service: MakerService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MakerService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
