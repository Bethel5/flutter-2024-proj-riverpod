import { Module } from '@nestjs/common';
import { VisitApplicationsController } from './visit-applications.controller';
import { VisitApplicationsService } from './visit-applications.service';
import { MongooseModule } from '@nestjs/mongoose';
import { VisitApplication, VisitApplicationSchema } from './schemas/visit-application.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: VisitApplication.name, schema: VisitApplicationSchema }])
  ],
  controllers: [VisitApplicationsController],
  providers: [VisitApplicationsService]
})
export class VisitApplicationsModule {}
