import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request, Query } from '@nestjs/common';
import { VisitApplicationsService } from './visit-applications.service';
import { CreateVisitApplicationDto } from './dto/create-visit-application.dto';
import { UpdateVisitApplicationDto } from './dto/update-visit-application.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@Controller('visit-applications')
export class VisitApplicationsController {
  constructor(private readonly visitApplicationsService: VisitApplicationsService) {}

  @UseGuards(JwtAuthGuard)
  @Post()
  create(@Body() createVisitApplicationDto: CreateVisitApplicationDto, @Request() req, @Query('petId') petId: string) {
    const userId = req.user._id;
    return this.visitApplicationsService.create(createVisitApplicationDto, userId, petId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Get()
  findAll() {
    return this.visitApplicationsService.findAll();
  }

  @UseGuards(JwtAuthGuard)
  @Get('me')
  findUserApplications(@Request() req) {
    const userId = req.user._id;
    return this.visitApplicationsService.findByUserId(userId);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  findOne(@Param('id') id: string, @Request() req) {
    const userId = req.user._id;
    return this.visitApplicationsService.findOne(id, userId);
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateVisitApplicationDto: Partial<CreateVisitApplicationDto>, @Request() req) {
    const userId = req.user._id;
    return this.visitApplicationsService.update(id, updateVisitApplicationDto, userId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Patch(':id/status')
  updateStatus(@Param('id') id: string, @Body('status') status: string) {
    return this.visitApplicationsService.updateStatus(id, status);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  remove(@Param('id') id: string, @Request() req) {
    const userId = req.user._id;
    return this.visitApplicationsService.remove(id, userId);
  }
}
