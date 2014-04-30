From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2 2/3] Input: synaptics-rmi4 - F11 abs or rel reporting
Date: Wed, 30 Apr 2014 14:41:43 -0700
Message-ID: <53616E17.7030604@synaptics.com>
References: <1396300267-5108-1-git-send-email-cheiny@synaptics.com>	<1396300267-5108-2-git-send-email-cheiny@synaptics.com> <CAN+gG=F7J6nOiSbHgctSxnNeGDr9VB1_wN-tagvrbm=ymCH_dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:19505 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759497AbaD3Vlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Apr 2014 17:41:44 -0400
In-Reply-To: <CAN+gG=F7J6nOiSbHgctSxnNeGDr9VB1_wN-tagvrbm=ymCH_dw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 04/09/2014 11:19 AM, Benjamin Tissoires wrote:
> On Mon, Mar 31, 2014 at 5:11 PM, Christopher Heiny <cheiny@synaptics.com> wrote:
>> If the firmware provides reporting both relative and absolute
>> coordinates, reporting both can cause userspace confusion, so
>> default to reporting only the absolute coordinates. In certain
>> cases in may be desirable to force only reporting relative
>> coordinates so a mask is provided in the platform data for
>> disabling absolute reporting and falling back to reporting
>> relative coordinates.
>>
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> Acked-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Linux Walleij <linus.walleij@linaro.org>
>> Cc: David Herrmann <dh.herrmann@gmail.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>>
>> ---
>>   drivers/input/rmi4/rmi_f11.c | 122 +++++++++++++++++++++----------------------
>>   include/linux/rmi.h          |   5 ++
>>   2 files changed, 64 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
>> index e98fa75..ee47b7e 100644
>> --- a/drivers/input/rmi4/rmi_f11.c
>> +++ b/drivers/input/rmi4/rmi_f11.c
>> @@ -499,9 +499,7 @@ struct f11_2d_data {
>>    * assume we have one of those sensors and report events appropriately.
>>    * @sensor_type - indicates whether we're touchscreen or touchpad.
>>    * @input - input device for absolute pointing stream
>> - * @mouse_input - input device for relative pointing stream.
>>    * @input_phys - buffer for the absolute phys name for this sensor.
>> - * @input_phys_mouse - buffer for the relative phys name for this sensor.
>>    */
>>   struct f11_2d_sensor {
>>          struct rmi_f11_2d_axis_alignment axis_align;
>> @@ -516,10 +514,10 @@ struct f11_2d_sensor {
>>          u32 type_a;     /* boolean but debugfs API requires u32 */
>>          enum rmi_f11_sensor_type sensor_type;
>>          struct input_dev *input;
>> -       struct input_dev *mouse_input;
>>          struct rmi_function *fn;
>>          char input_phys[NAME_BUFFER_SIZE];
>> -       char input_phys_mouse[NAME_BUFFER_SIZE];
>> +       u8 report_abs;
>> +       u8 report_rel;
>>   };
>>
>>   /** Data pertaining to F11 in general.  For per-sensor data, see struct
>> @@ -544,6 +542,9 @@ struct f11_data {
>>          struct mutex dev_controls_mutex;
>>          u16 rezero_wait_ms;
>>          struct f11_2d_sensor sensor;
>> +       unsigned long *abs_mask;
>> +       unsigned long *rel_mask;
>> +       unsigned long *result_bits;
>>   };
>>
>>   enum finger_state_values {
>> @@ -591,10 +592,7 @@ static void rmi_f11_rel_pos_report(struct f11_2d_sensor *sensor, u8 n_finger)
>>          if (x || y) {
>>                  input_report_rel(sensor->input, REL_X, x);
>>                  input_report_rel(sensor->input, REL_Y, y);
>> -               input_report_rel(sensor->mouse_input, REL_X, x);
>> -               input_report_rel(sensor->mouse_input, REL_Y, y);
>>          }
>> -       input_sync(sensor->mouse_input);
>>   }
>>
>>   static void rmi_f11_abs_pos_report(struct f11_data *f11,
>> @@ -691,13 +689,17 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
>>   }
>>
>>   static void rmi_f11_finger_handler(struct f11_data *f11,
>> -                                  struct f11_2d_sensor *sensor)
>> +                                  struct f11_2d_sensor *sensor,
>> +                                  unsigned long *irq_bits, int num_irq_regs)
>>   {
>>          const u8 *f_state = sensor->data.f_state;
>>          u8 finger_state;
>>          u8 finger_pressed_count;
>>          u8 i;
>>
>> +       int rel_bits;
>> +       int abs_bits;
>> +
>>          for (i = 0, finger_pressed_count = 0; i < sensor->nbr_fingers; i++) {
>>                  /* Possible of having 4 fingers per f_statet register */
>>                  finger_state = (f_state[i / 4] >> (2 * (i % 4))) &
>> @@ -711,10 +713,14 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
>>                          finger_pressed_count++;
>>                  }
>>
>> -               if (sensor->data.abs_pos)
>> +               abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
>> +                               num_irq_regs);
>> +               if (abs_bits)
>
> I am finding this bitmask gymnastic quite difficult to follow.
> I am also wondering if the following test will give the same result:
> "if (sensor->data.abs_pos && sensor->report_abs)"
>
>>                          rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
>>
>> -               if (sensor->data.rel_pos)
>> +               rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
>> +                               num_irq_regs);
>> +               if (rel_bits)
>
> Same for rel bits here
>
> The rest of the patch looks fine to me (except that if my previous
> assumptions are right, ew could remove the whole bitmask alloc and
> handling).

[snip]

I'm very sorry for the delayed reply to this - I though I'd done that, 
but apparently didn't.  Andrew has kindly applied a prod or two (ouch 
ouch all right already).

Anyway, the main reason for doing the bit masking is for situations 
where both relative and absolute reporting is enabled (surprisingly, 
those are do occur, although they are not common).  We'll enter the 
rmi_f11_attention() when either rel_data is ready, or abs_data is ready, 
or both, but we don't know which data is actually valid without checking 
the interrupt status register bits against the enabled interrupt bits.

An example of where this could occur is where a finger moves very 
rapidly across the touch surface.  The absolute data could be reported 
as one (or a few) absolute reports, but the relative data might be so 
large that it requires several reports to play out all the deltas.  If 
those deltas are still playing out while the finger is sufficiently 
stationary (and thus the absolute interrupt status bit is 0), it is 
possible for the absolute data to be incorrect in those reports.

As a secondary condition, in diagnostic and prototyping environments you 
sometimes need to turn either rel or abs (or both) on and off at various 
points to figure out what the heck is going on or to test out something 
new.  That implies that we need to allocate the rel_data and abs_data 
buffers ahead of time, so they can't be used as flags.  Well, OK, we 
could use allocate/deallocate of the buffers as flags, but that implies 
a bunch of locking to prevent kernel panics.

Maybe it would be clearer to have a well-named macro or inline that did 
the bitmask gymnastics, maybe something like enabled_report_has_data().

					Thanks,
						Chris
