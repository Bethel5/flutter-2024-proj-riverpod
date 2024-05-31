import { Module } from '@nestjs/common';
import { PetsController } from './pets.controller';
import { PetsService } from './pets.service';
import { Pet, PetSchema } from './schemas/pet.schema';
import { MongooseModule } from '@nestjs/mongoose';


@Module({
  imports:[
    MongooseModule.forRoot('mongodb://localhost/petdb'),
    MongooseModule.forFeature([{ name: Pet.name, schema: PetSchema }]),
  ],
  controllers: [PetsController],
  providers: [PetsService],
  exports: [MongooseModule]
})
export class PetsModule {}
