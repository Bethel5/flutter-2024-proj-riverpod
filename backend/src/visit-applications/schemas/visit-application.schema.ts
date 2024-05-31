import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { ServiceType } from '../dto/create-visit-application.dto';

export type VisitApplicationDocument = VisitApplication & Document;

@Schema()
export class VisitApplication {
  @Prop({ required: true })
  userId: string;

  @Prop({ required: true })
  petId: string;

  @Prop({ required: true, enum: ServiceType })
  serviceType: string;

  @Prop({ required: true })
  date: string;

  @Prop({ required: true })
  time: string;

  @Prop({ default: 'pending' })
  status: string;

  @Prop({ default: Date.now })
  createdAt: Date;

  @Prop({ default: Date.now })
  updatedAt: Date; 
}

export const VisitApplicationSchema = SchemaFactory.createForClass(VisitApplication);
