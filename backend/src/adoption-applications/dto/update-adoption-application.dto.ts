import { PartialType } from '@nestjs/mapped-types';
import { CreateAdoptionApplicationDto } from './create-adoption-application.dto';

export class UpdateAdoptionApplicationDto extends PartialType(CreateAdoptionApplicationDto) {}
