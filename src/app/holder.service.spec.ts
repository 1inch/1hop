import { TestBed } from '@angular/core/testing';

import { HolderService } from './holder.service';

describe('HolderService', () => {
  let service: HolderService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HolderService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
