import { IsString, IsEnum, IsDateString, IsNotEmpty } from 'class-validator';

export enum ServiceType {
  TrialAtHome = 'trial_at_home',
  StoreVisit = 'store_visit',
}

export class CreateVisitApplicationDto {
  @IsEnum(ServiceType)
  @IsNotEmpty()
  serviceType: ServiceType;

  @IsDateString()
  @IsNotEmpty()
  date: string;

  @IsString()
  @IsNotEmpty()
  time: string;
}
