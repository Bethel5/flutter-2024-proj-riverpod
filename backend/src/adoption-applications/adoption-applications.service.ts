import { Injectable, HttpException, HttpStatus, Logger } from '@nestjs/common';

import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateAdoptionApplicationDto } from './dto/create-adoption-application.dto';
import { UpdateAdoptionApplicationDto } from './dto/update-adoption-application.dto';
import { AdoptionApplication, AdoptionApplicationDocument } from './schemas/adoption-application.schema';

@Injectable()
export class AdoptionApplicationsService {
  private readonly logger = new Logger(AdoptionApplicationsService.name);
  constructor(
    @InjectModel(AdoptionApplication.name) private adoptionApplicationModel: Model<AdoptionApplicationDocument>,
  ) {}

  async create(createAdoptionApplicationDto: CreateAdoptionApplicationDto, userId: string): Promise<AdoptionApplication> {
    const newAdoptionApplication = new this.adoptionApplicationModel({
      ...createAdoptionApplicationDto,
      userId,
    });
    try {
      return await newAdoptionApplication.save();
    } catch (error) {
      throw new HttpException('Failed to create adoption application', HttpStatus.BAD_REQUEST);
    }
  }

  async findAll(): Promise<AdoptionApplication[]> {
    try {
      return await this.adoptionApplicationModel.find().exec();
    } catch (error) {
      throw new HttpException('Failed to fetch adoption applications', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async findByUserId(userId: string): Promise<AdoptionApplication[]> {
    try {
      return await this.adoptionApplicationModel.find({ userId }).exec();
    } catch (error) {
      throw new HttpException('Failed to fetch adoption applications for user', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async findOne(id: string, userId: string): Promise<AdoptionApplication> {
    try {
      const application = await this.adoptionApplicationModel.findById(id).exec();
      if (!application) throw new HttpException('Adoption application not found', HttpStatus.NOT_FOUND);
      if (application.userId !== userId) throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
      return application;
    } catch (error) {
      throw new HttpException('Failed to find adoption application', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async update(id: string, updateAdoptionApplicationDto: Partial<CreateAdoptionApplicationDto>, userId: string): Promise<AdoptionApplication> {
    try {
      const application = await this.adoptionApplicationModel.findById(id).exec();
      if (!application) throw new HttpException('Adoption application not found', HttpStatus.NOT_FOUND);
      if (application.userId !== userId) throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
      const updatedApplication = await this.adoptionApplicationModel.findByIdAndUpdate(
        id,
        { ...updateAdoptionApplicationDto, updatedAt: Date.now() },
        { new: true }
      ).exec();
      return updatedApplication;
    } catch (error) {
      throw new HttpException('Failed to update adoption application', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  // async remove(id: string, userId: string): Promise<AdoptionApplication> {
  //   try {
  //     const application = await this.adoptionApplicationModel.findById(id).exec();
  //     if (!application) throw new HttpException('Adoption application not found', HttpStatus.NOT_FOUND);
  //     if (application.userId !== userId) throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
  //     const deletedApplication = await this.adoptionApplicationModel.findByIdAndDelete(id).exec();
  //     return deletedApplication;
  //   } catch (error) {
  //     throw new HttpException('Failed to delete adoption application', HttpStatus.INTERNAL_SERVER_ERROR);
  //   }
  // }

  async remove(id: string, userId: string): Promise<AdoptionApplication> {
    this.logger.debug(`Attempting to delete adoption application with ID: ${id} for user ID: ${userId}`);

    try {
      const application = await this.adoptionApplicationModel.findById(id).exec();
      if (!application) {
        this.logger.warn(`Adoption application with ID: ${id} not found`);
        throw new HttpException('Adoption application not found', HttpStatus.NOT_FOUND);
      }
      this.logger.debug(`Application found: ${JSON.stringify(application)}`);
      this.logger.debug(`Comparing user ID from request: ${userId} (type: ${typeof userId}) with application user ID: ${application.userId} (type: ${typeof application.userId})`);

      if (application.userId !== userId.toString()) {
        this.logger.warn(`Unauthorized deletion attempt by user ID: ${userId} for application owned by user ID: ${application.userId}`);
        throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
      }

      const deletedApplication = await this.adoptionApplicationModel.findByIdAndDelete(id).exec();
      this.logger.debug(`Successfully deleted adoption application with ID: ${id}`);
      return deletedApplication;
    } catch (error) {
      this.logger.error(`Failed to delete adoption application with ID: ${id}`, error.stack);
      throw new HttpException('Failed to delete adoption application', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
  async updateStatus(id: string, status: string): Promise<AdoptionApplication> {
    try {
      const updatedApplication = await this.adoptionApplicationModel.findByIdAndUpdate(
        id,
        { status, updatedAt: Date.now() },
        { new: true }
      ).exec();
      if (!updatedApplication) throw new HttpException('Adoption application not found', HttpStatus.NOT_FOUND);
      return updatedApplication;
    } catch (error) {
      throw new HttpException('Failed to update adoption application status', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}
