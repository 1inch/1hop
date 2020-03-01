import { TestBed } from '@angular/core/testing';

import { OneHopTokenService } from './one-hop-token.service';

describe('OneHopTokenService', () => {
  let service: OneHopTokenService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(OneHopTokenService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
