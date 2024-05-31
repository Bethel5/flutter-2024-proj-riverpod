import { Test, TestingModule } from '@nestjs/testing';
import { VisitApplicationsService } from './visit-applications.service';

describe('VisitApplicationsService', () => {
  let service: VisitApplicationsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [VisitApplicationsService],
    }).compile();

    service = module.get<VisitApplicationsService>(VisitApplicationsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
