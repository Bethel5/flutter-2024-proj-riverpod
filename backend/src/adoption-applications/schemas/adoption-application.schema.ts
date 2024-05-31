import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type AdoptionApplicationDocument = AdoptionApplication & Document;

@Schema()
export class AdoptionApplication {
  @Prop({ required: true })
  userId: string;

  @Prop({ required: true })
  fullName: string;

  @Prop({ required: true })
  address: string;

  @Prop({ required: true })
  phoneNumber: string;

  @Prop({ required: true })
  typeOfPet: string;

  @Prop({ required: true })
  gender: string;

  @Prop({ required: true })
  ageRange: string;

  @Prop({ required: true })
  previousPetOwnershipExperience: string;

  @Prop({ default: 'pending' })
  status: string;

  @Prop({ default: Date.now })
  createdAt: Date;
}

export const AdoptionApplicationSchema = SchemaFactory.createForClass(AdoptionApplication);
