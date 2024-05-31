import { IsString, IsNotEmpty, IsPhoneNumber } from 'class-validator';

export class CreateAdoptionApplicationDto {
  @IsString()
  @IsNotEmpty()
  fullName: string;

  @IsString()
  @IsNotEmpty()
  address: string;

  @IsPhoneNumber(null)
  @IsNotEmpty()
  phoneNumber: string;

  @IsString()
  @IsNotEmpty()
  typeOfPet: string;

  @IsString()
  @IsNotEmpty()
  gender: string;

  @IsString()
  @IsNotEmpty()
  ageRange: string;

  @IsString()
  @IsNotEmpty()
  previousPetOwnershipExperience: string;
}
