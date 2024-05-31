import { Test, TestingModule } from '@nestjs/testing';
import { AdoptionApplicationsController } from './adoption-applications.controller';

describe('AdoptionApplicationsController', () => {
  let controller: AdoptionApplicationsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AdoptionApplicationsController],
    }).compile();

    controller = module.get<AdoptionApplicationsController>(AdoptionApplicationsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
