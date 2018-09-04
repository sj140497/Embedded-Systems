with HWIF, HWIF_Types;
use HWIF, HWIF_Types;

procedure Controller is
   task lightingFunctionality is

   end lightingFunctionality;

   task body lightingFunctionality is

   --State : Integer := 1;
      crossing : Natural := 0;
      NS : Boolean := True;
   begin
   loop
      -- ONLY ROTATES THE LIGHTS AS NORMAL IF AN EMERGENCY VEHICLE IS NOT WAITING TO PASS
      if not (Emergency_Vehicle_Sensor(North) = 1
                    or Emergency_Vehicle_Sensor(South) = 1
                    or Emergency_Vehicle_Sensor(East) = 1
              or Emergency_Vehicle_Sensor(West) = 1) then
            -- Tried to do this with the case statement but had many issues with certain situations messing up the light rotation
            -- and this made much more sense
         if NS then

                  delay 0.1;
                  -- NS AR (Sets the NS lights to red-amber after 0.1s)
                  Traffic_Light(North) := 6;
                  Traffic_Light(South) := 6;
                  delay 0.1;
                  -- NS G (Sets the NS lights to green after 0.1s)
                  Traffic_Light(North) := 1;
                  Traffic_Light(South) := 1;

                  --TRAFFIC (Waits for 5 seconds to allow traffic to pass like specified in ICA)
                  delay 5.0;

                  -- NS A (Sets the NS lights to amber)
                  Traffic_Light(North) := 2;
                  Traffic_Light(South) := 2;
                  delay 3.0;
                  --NS R (Sets the NS lights to red after 3 seconds as specified in the ICA, all amber lights must be active for atleast 3 seconds)
                  Traffic_Light(North) := 4;
                  Traffic_Light(South) := 4;

                  -- Indicates that a full cycle has happened and the lights are back to red to allow pedestrians to pass.
                  crossing := crossing + 1;
               else


                  -- EW AR (Sets the EW lights to red-amber after 0.1s)
                  delay 0.1;
                  Traffic_Light(East) := 6;
                  Traffic_Light(West) := 6;
                  delay 0.1;
                  -- EW G (Sets the EW lights to green after 0.1s)
                  Traffic_Light(East) := 1;
                  Traffic_Light(West) := 1;

                  --TRAFFIC (Waits for 5 seconds to allow traffic to pass like specified in ICA)
                  delay 5.0;

                  -- EW A (Sets the EW lights to amber)
                  Traffic_Light(East) := 2;
                  Traffic_Light(West) := 2;
                  delay 3.0;
                  --EW R (Sets the EW lights to red after 3 seconds like specified in the ICA)
                  Traffic_Light(East) := 4;
                  Traffic_Light(West) := 4;

                  -- Indicates that a full cycle has happened and the lights are back to red to allow pedestrians to pass.
                  crossing := crossing + 1;
               end if;
               NS := not NS;
            end if;

         -- If an emergency vehicle is waiting from the north light then:
         if Emergency_Vehicle_Sensor(North) = 1 then
            --if State = 4 or State = 8 then
            -- Will only happen when all lights are red. Rotates through the usual light sequence with a long break at green.
         delay 0.1;
         Traffic_Light(North) := 6;
         Traffic_Light(South) := 6;

         delay 0.1;
         Traffic_Light(North) := 1;
         Traffic_Light(South) := 1;
         -- Loop to check when the emergency vehicle has passed the sensor
         while Emergency_Vehicle_Sensor(North) = 1
            loop
            delay 0.2;
         end loop;

         --Green lights stay lit for 10 seconds after EV has passed as stated in ICA.
         delay 10.0;

         Traffic_Light(North) := 2;
         Traffic_Light(South) := 2;
         delay 3.0;
         Traffic_Light(North) := 4;
         Traffic_Light(South) := 4;
            delay 0.1;
            -- Crossing incremented to indicate that pedestrians can cross
            crossing := crossing + 1;
            NS := False;
            end if;
            --end if;

          -- If an emergency vehicle is waiting from the south light then:
          if Emergency_Vehicle_Sensor(South) = 1 then
           --if State = 4 or State = 8 then
           -- Will only happen when all lights are red. Rotates through the usual light sequence with a long break at green.
                  delay 0.1;
                  Traffic_Light(North) := 6;
                  Traffic_Light(South) := 6;

                  delay 0.1;
                  Traffic_Light(North) := 1;
                  Traffic_Light(South) := 1;
                  -- Loop to check when the emergency vehicle has passed the sensor
                  while Emergency_Vehicle_Sensor(South) = 1
                  loop
                     delay 0.2;
                  end loop;
                  --Green lights stay lit for 10 seconds after EV has passed as stated in ICA.
                  delay 10.0;

                  Traffic_Light(North) := 2;
                  Traffic_Light(South) := 2;
                  delay 3.0;
                  Traffic_Light(North) := 4;
                  Traffic_Light(South) := 4;
                  delay 0.1;
                  -- Crossing incremented to indicate that pedestrians can cross
                  crossing := crossing + 1;
                  NS := False;
                  end if;
          --end if;

         -- If an emergency vehicle is waiting from the east light then:
           if Emergency_Vehicle_Sensor(East) = 1 then
            --if State = 4 or State = 8 then
            -- Will only happen when all lights are red. Rotates through the usual light sequence with a long break at green.
                     delay 0.1;
                     Traffic_Light(East) := 6;
                     Traffic_Light(West) := 6;

                     delay 0.1;
                     Traffic_Light(East) := 1;
                     Traffic_Light(West) := 1;
                     -- Loop to check when the emergency vehicle has passed the sensor
                     while Emergency_Vehicle_Sensor(East) = 1
                     loop
                        delay 0.2;
                     end loop;
                     --Green lights stay lit for 10 seconds after EV has passed as stated in ICA.
                     delay 10.0;

                     Traffic_Light(East) := 2;
                     Traffic_Light(West) := 2;
                     delay 3.0;
                     Traffic_Light(East) := 4;
                     Traffic_Light(West) := 4;
                     delay 0.1;
                     -- Crossing incremented to indicate that pedestrians can cross
                     crossing := crossing + 1;
                     NS := True;
               end if;
               --end if;

         -- If an emergency vehicle is waiting from the west light then:
            if Emergency_Vehicle_Sensor(West) = 1 then
            --if State = 4 or State = 8 then
            -- Will only happen when all lights are red. Rotates through the usual light sequence with a long break at green.
                        delay 0.1;
                        Traffic_Light(East) := 6;
                        Traffic_Light(West) := 6;

                        delay 0.1;
                        Traffic_Light(East) := 1;
                        Traffic_Light(West) := 1;
                        -- Loop to check when the emergency vehicle has passed the sensor
                        while Emergency_Vehicle_Sensor(West) = 1
                        loop
                           delay 0.2;
                        end loop;
                        --Green lights stay lit for 10 seconds after EV has passed as stated in ICA.
                        delay 10.0;

                        Traffic_Light(East) := 2;
                        Traffic_Light(West) := 2;
                        delay 3.0;
                        Traffic_Light(East) := 4;
                        Traffic_Light(West) := 4;
                        delay 0.1;
                        -- Crossing incremented to indicate that pedestrians can cross
                        crossing := crossing + 1;
                        NS := True;
               end if;
               --end if;

         -- If there are no EVs waiting to pass and pedestrians are able to cross then:
      if not (Emergency_Vehicle_Sensor(North) = 1
              or Emergency_Vehicle_Sensor(South) = 1
              or Emergency_Vehicle_Sensor(East) = 1
              or Emergency_Vehicle_sensor(West) = 1) then
            if Pedestrian_Wait(North) = 1 and
              crossing >= 2 then
                 --Set all the pedestrian lights to green
                 Pedestrian_Light(North) := 1;
                 Pedestrian_Light(South) := 1;
                 Pedestrian_Light(East) := 1;
                 Pedestrian_Light(West) := 1;
                 --Turn off all the pedestrian waiting lights
                 Pedestrian_Wait(North) := 0;
                 Pedestrian_Wait(South) := 0;
                 Pedestrian_Wait(East) := 0;
                 Pedestrian_Wait(West) := 0;

               -- Gives the pedestrians 6 seconds to cross the road, as stated in the ICA
                 delay 6.0;
                 --Turn all pedestrian lights to red
                 Pedestrian_Light(North) := 2;
                 Pedestrian_Light(South) := 2;
                 Pedestrian_Light(East) := 2;
                 Pedestrian_Light(West) := 2;

                 --Then after that, if any of the pedestrian buttons are indicated, turn all the pedestrian waiting lights on.
                 if (Pedestrian_Button(North) = 1
                     or Pedestrian_Button(South) = 1
                     or Pedestrian_Button(East) = 1
                     or Pedestrian_Button(West) = 1)

                 then
                    Pedestrian_Wait(North) := 1;
                    Pedestrian_Wait(South) := 1;
                    Pedestrian_Wait(East) := 1;
                    Pedestrian_Wait(West) := 1;
                 end if;

               delay 0.1;
                  --Reset the crossing counter
                  crossing := 0;

              end if;
              end if;
      end loop;
   end lightingFunctionality;

     begin
   loop
         -- If there is not a pedestrian waiting at the north light or if a pedestrian is not already crossing the north light then: (No point checking the next section if there is)
      if not ((Pedestrian_Wait(North) = 1) or (Pedestrian_Light(North) = 1)) then
         --If there is any pedestrian waiting at any of the lights:
            if (Pedestrian_Button(North) = 1
                or Pedestrian_Button(South) = 1
                or Pedestrian_Button(East) = 1
                or Pedestrian_Button(West) = 1)

            -- Turn on the all of the pedestrian waiting lights
            then
               Pedestrian_Wait(North) := 1;
               Pedestrian_Wait(South) := 1;
               Pedestrian_Wait(East) := 1;
               Pedestrian_Wait(West) := 1;
            end if;
         end if;
         delay 0.15;
      end loop;
   end Controller;



