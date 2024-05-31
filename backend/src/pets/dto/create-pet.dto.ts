import { IsString, IsInt, IsOptional, IsEnum} from 'class-validator';

export class CreatePetDto {
  
  @IsString()
  name: string;

  @IsInt()
  age?: number;

  @IsEnum(["Female", "Male"], {})
  gender: "Female" | "Male";

  @IsString()
  species: string;

  @IsString()
  category: string;

  @IsString()
  @IsOptional()
  description?: string;
}
