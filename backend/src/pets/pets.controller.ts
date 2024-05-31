import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, UploadedFile, UseInterceptors, HttpException, Req, HttpStatus, Res } from '@nestjs/common';
import { PetsService } from './pets.service';
import { CreatePetDto } from './dto/create-pet.dto';
import { UpdatePetDto } from './dto/update-pet.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';

@Controller('pets')
export class PetsController {
  constructor(private readonly petsService: PetsService) {}

  @Get()
  findAll() {
    return this.petsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.petsService.findOne(id);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Post()
  @UseInterceptors(FileInterceptor('image', {
    storage: diskStorage({
      destination: './uploads',
      filename: (req, file, cb) => {
        const randomName = Array(32)
          .fill(null)
          .map(() => Math.round(Math.random() * 16).toString(16))
          .join('');
        cb(null, `${randomName}${extname(file.originalname)}`);
      },
    }),
  }))
  async create(@Req() req, @Body() createPetDto: CreatePetDto, @UploadedFile() file: Express.Multer.File) {
    try {
      console.log('Request user:', req.user);  // Log the user
      console.log('Token:', req.headers.authorization);  // Log the token
      console.log('Uploaded file:', file);  // Log the file
  
      if (!file) {
        throw new HttpException('File not uploaded', HttpStatus.BAD_REQUEST);
      }
  
      return await this.petsService.create(createPetDto, file.path);
    } catch (error) {
      console.error('Error in create:', error);
      throw new HttpException('Internal server error', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
  
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Patch(':id')
  @UseInterceptors(FileInterceptor('image', {
    storage: diskStorage({
      destination: './uploads',
      filename: (req, file, cb) => {
        const randomName = Array(32)
          .fill(null)
          .map(() => Math.round(Math.random() * 16).toString(16))
          .join('');
        cb(null, `${randomName}${extname(file.originalname)}`);
      },
    }),
  }))
  update(@Param('id') id: string, @Body() updatePetDto: UpdatePetDto, @UploadedFile() file?: Express.Multer.File) {
    return this.petsService.update(id, updatePetDto, file?.path);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res) {
    console.log(`Deleting pet with ID: ${id}`);
    await this.petsService.remove(id);
    return res.status(HttpStatus.NO_CONTENT).send();
  }
}
