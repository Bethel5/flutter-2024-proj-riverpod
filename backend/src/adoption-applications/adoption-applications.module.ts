import { Module } from '@nestjs/common';
import { AdoptionApplicationsController } from './adoption-applications.controller';
import { AdoptionApplicationsService } from './adoption-applications.service';
import { MongooseModule } from '@nestjs/mongoose';
import { AdoptionApplication, AdoptionApplicationSchema } from './schemas/adoption-application.schema';
import { PetsModule } from '../pets/pets.module';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: AdoptionApplication.name, schema: AdoptionApplicationSchema }]),
    PetsModule,
  ],
  controllers: [AdoptionApplicationsController],
  providers: [AdoptionApplicationsService]
})
export class AdoptionApplicationsModule {}
