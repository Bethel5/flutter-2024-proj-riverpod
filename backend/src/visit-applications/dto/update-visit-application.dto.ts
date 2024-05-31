import { PartialType } from '@nestjs/mapped-types';
import { CreateVisitApplicationDto } from './create-visit-application.dto';

export class UpdateVisitApplicationDto extends PartialType(CreateVisitApplicationDto) {}
