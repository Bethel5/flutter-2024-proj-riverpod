import { IsEmail, IsString, MinLength } from 'class-validator';

export class CreateAdminDto {
  @IsString()
  fullName: string;

  @IsEmail()
  email: string;

  @IsString()
  @MinLength(6)
  password: string;
}
