import { Test, TestingModule } from '@nestjs/testing';
import { VisitApplicationsController } from './visit-applications.controller';

describe('VisitApplicationsController', () => {
  let controller: VisitApplicationsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [VisitApplicationsController],
    }).compile();

    controller = module.get<VisitApplicationsController>(VisitApplicationsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
