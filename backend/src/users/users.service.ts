import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User, UserDocument } from './schemas/user.schema';
import { CreateUserDto } from './dto/create-user.dto';
import { CreateAdminDto } from './dto/create-admin.dto';
import * as bcrypt from 'bcryptjs';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}

  async create(createUserDto: CreateUserDto): Promise<User> {
    const { email, password, fullName } = createUserDto;
    const existingUser = await this.userModel.findOne({ email }).lean();
    if (existingUser) {
      throw new HttpException('Email already in use', HttpStatus.BAD_REQUEST);
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new this.userModel({ fullName, email, password: hashedPassword, role: 'user' });
    return newUser.save();
  }

  async createAdmin(createAdminDto: CreateAdminDto): Promise<User> {
    const { email, password, fullName } = createAdminDto;
    const existingUser = await this.userModel.findOne({ email }).lean();
    if (existingUser) {
      throw new HttpException('Email already in use', HttpStatus.BAD_REQUEST);
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newAdmin = new this.userModel({ fullName, email, password: hashedPassword, role: 'admin' });
    return newAdmin.save();
  }

  async findByEmail(email: string): Promise<User | undefined> {
    return this.userModel.findOne({ email }).lean().exec();
  }

  async findById(id: string): Promise<User> {
    return this.userModel.findById(id).lean().exec();
  }

  async findAll(): Promise<User[]> {
    return this.userModel.find().exec();
  }
}
