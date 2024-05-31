import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type PetDocument = Pet & Document;

@Schema()
export class Pet {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  age: number;

  @Prop({ enum: ['Female', 'Male'], required: true })
  gender: 'Female' | 'Male';

  @Prop({ required: true })
  species: string;

  @Prop({ required: true })
  category: string;

  @Prop()
  description: string;

  @Prop()
  image: string;

  @Prop({ default: Date.now })
  createdAt: Date;
}

export const PetSchema = SchemaFactory.createForClass(Pet);
