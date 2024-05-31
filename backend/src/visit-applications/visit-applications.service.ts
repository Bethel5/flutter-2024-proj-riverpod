import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateVisitApplicationDto } from './dto/create-visit-application.dto';
import { UpdateVisitApplicationDto } from './dto/update-visit-application.dto';
import { VisitApplication, VisitApplicationDocument } from './schemas/visit-application.schema';

@Injectable()
export class VisitApplicationsService {
  constructor(
    @InjectModel(VisitApplication.name) private visitApplicationModel: Model<VisitApplicationDocument>,
  ) {}

  async create(createVisitApplicationDto: CreateVisitApplicationDto, userId: string, petId: string): Promise<VisitApplication> {
    const newVisitApplication = new this.visitApplicationModel({
      ...createVisitApplicationDto,
      userId,
      petId,
    });
    try {
      return await newVisitApplication.save();
    } catch (error) {
      throw new HttpException('Failed to create visit application', HttpStatus.BAD_REQUEST);
    }
  }

  async findAll(): Promise<VisitApplication[]> {
    try {
      return await this.visitApplicationModel.find().exec();
    } catch (error) {
      throw new HttpException('Failed to fetch visit applications', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async findByUserId(userId: string): Promise<VisitApplication[]> {
    try {
      return await this.visitApplicationModel.find({ userId }).exec();
    } catch (error) {
      throw new HttpException('Failed to fetch visit applications for user', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async findOne(id: string, userId: string): Promise<VisitApplication> {
    try {
      const application = await this.visitApplicationModel.findById(id).exec();
      if (!application) throw new HttpException('Visit application not found', HttpStatus.NOT_FOUND);
      if (application.userId !== userId) throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
      return application;
    } catch (error) {
      throw new HttpException('Failed to find visit application', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async update(id: string, updateVisitApplicationDto: Partial<CreateVisitApplicationDto>, userId: string): Promise<VisitApplication> {
    try {
      const application = await this.visitApplicationModel.findById(id).exec();
      if (!application) throw new HttpException('Visit application not found', HttpStatus.NOT_FOUND);
      if (application.userId !== userId) throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
      const updatedApplication = await this.visitApplicationModel.findByIdAndUpdate(
        id,
        { ...updateVisitApplicationDto, updatedAt: Date.now() },
        { new: true }
      ).exec();
      return updatedApplication;
    } catch (error) {
      throw new HttpException('Failed to update visit application', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async remove(id: string, userId: string): Promise<VisitApplication> {
    try {
      const application = await this.visitApplicationModel.findById(id).exec();
      if (!application) throw new HttpException('Visit application not found', HttpStatus.NOT_FOUND);
      if (application.userId !== userId) throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
      const deletedApplication = await this.visitApplicationModel.findByIdAndDelete(id).exec();
      return deletedApplication;
    } catch (error) {
      throw new HttpException('Failed to delete visit application', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async updateStatus(id: string, status: string): Promise<VisitApplication> {
    try {
      const updatedApplication = await this.visitApplicationModel.findByIdAndUpdate(
        id,
        { status, updatedAt: Date.now() },
        { new: true }
      ).exec();
      if (!updatedApplication) throw new HttpException('Visit application not found', HttpStatus.NOT_FOUND);
      return updatedApplication;
    } catch (error) {
      throw new HttpException('Failed to update visit application status', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}
