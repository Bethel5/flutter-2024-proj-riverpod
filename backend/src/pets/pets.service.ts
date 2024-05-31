import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreatePetDto } from './dto/create-pet.dto';
import { UpdatePetDto } from './dto/update-pet.dto';
import { Pet, PetDocument } from './schemas/pet.schema';

@Injectable()
export class PetsService {
  
  constructor(@InjectModel(Pet.name) private petModel: Model<PetDocument>) {}

  async create(createPetDto: CreatePetDto, imagePath: string): Promise<Pet> {
    const createdPet = new this.petModel({ ...createPetDto, image: imagePath });
    return createdPet.save();
  }

  async findAll(): Promise<Pet[]> {
    return this.petModel.find().exec();
  }

  async findOne(id: string): Promise<Pet> {
    const pet = await this.petModel.findById(id).exec();
    if (!pet) {
      throw new NotFoundException(`Pet with ID ${id} not found`);
    }
    return pet;
  }

  async update(id: string, updatePetDto: UpdatePetDto, imagePath?: string): Promise<Pet> {
    const pet = await this.petModel.findById(id).exec();
    if (!pet) {
      throw new NotFoundException(`Pet with ID ${id} not found`);
    }
    if (imagePath) {
      updatePetDto['image'] = imagePath;
    }
    return this.petModel.findByIdAndUpdate(id, updatePetDto, { new: true }).exec();
  }

  async remove(id: string): Promise<Pet> {
    const pet = await this.petModel.findByIdAndDelete(id).exec();
    if (!pet) {
      throw new NotFoundException(`Pet with ID ${id} not found`);
    }
    return pet;
  }
}
