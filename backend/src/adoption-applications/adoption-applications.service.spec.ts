import { Test, TestingModule } from '@nestjs/testing';
import { AdoptionApplicationsService } from './adoption-applications.service';

describe('AdoptionApplicationsService', () => {
  let service: AdoptionApplicationsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AdoptionApplicationsService],
    }).compile();

    service = module.get<AdoptionApplicationsService>(AdoptionApplicationsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
