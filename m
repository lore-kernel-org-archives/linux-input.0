From: Mike Murphy <mamurph@cs.clemson.edu>
Subject: Re: PATCH [1/3] drivers/input/xpad.c: Improve Xbox 360 wireless
	support and add sysfs interface
Date: Mon, 2 Mar 2009 16:46:01 -0500
Message-ID: <5aa163d00903021346g59d90241v11f384eb97641e43@mail.gmail.com>
References: <5aa163d00902282053h38b0febbyb37fc30855fdc985@mail.gmail.com>
	 <20090302130425.23cc628d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:16469 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZCBVqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 16:46:04 -0500
In-Reply-To: <20090302130425.23cc628d.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, greg@kroah.com, oliver@neukum.org, fweisbec@gmail.com, torvalds@linux-foundation.org

On Mon, Mar 2, 2009 at 4:04 PM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> my brain hurts.
>
>> +static void set_stick_limit(unsigned int new_size, unsigned int *sl=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int dead_zone)
>> +{
>> + =A0 =A0 if (new_size < (dead_zone + 1024))
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_size =3D dead_zone + 1024;
>> + =A0 =A0 if (new_size > 32767)
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_size =3D 32767;
>> + =A0 =A0 *sl =3D new_size;
>> +}
>
> Perhaps the intent of these functions would be a bit clearer if they
> were to use min() and max().
>

I was not aware these functions were available inside the kernel...
ditto for abs(). I had done a search to see if they were, but came up
inconclusive.

>>
>> ...
>>
>> +static ssize_t xpad_show_int(struct device *dev, struct device_attr=
ibute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
>> +{
>> + =A0 =A0 struct usb_xpad *xpad =3D to_xpad(dev);
>> + =A0 =A0 int value;
>> + =A0 =A0 if (attr =3D=3D &dev_attr_rumble_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->rumble_enable;
>> + =A0 =A0 else if (attr =3D=3D &dev_attr_controller_number)
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->controller_number;
>> + =A0 =A0 else if (attr =3D=3D &dev_attr_controller_present)
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->controller_present;
>> + =A0 =A0 else if (attr =3D=3D &dev_attr_controller_type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->controller_type;
>> + =A0 =A0 else if (attr =3D=3D &dev_attr_left_trigger_full_axis)
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->left_trigger_full_axis;
>> + =A0 =A0 else if (attr =3D=3D &dev_attr_right_trigger_full_axis)
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D xpad->right_trigger_full_axis;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 return snprintf(buf, PAGE_SIZE, "%d\n", value);
>> +}
>
> The code's a bit unusual. =A0Most drivers don't have all that
> if-then-else stuff. =A0They use a separate function for each sysfs fi=
le
> and then they wrap it all up into a macro which emits all the data an=
d
> code for each file.
>

I think if I were to do a cleanup on this, my first instinct would be
to do a switch on attr, instead of a nested if/else setup like this
(internally, they are equivalent). I'm not entirely sure how I would
decompose this into a macro... other than to emit a separate
*function* for each show/store. But since the show/store pairs do the
same things for different variables, it seems like having a separate
function for each makes the module a lot bigger than it needs to be.

>>
>> ...
>>
>> +static void xpad_process_sticks(struct usb_xpad *xpad, unsigned cha=
r *data)
>> +{
>> + =A0 =A0 struct input_dev *dev =3D xpad->dev;
>> + =A0 =A0 int coords[4]; =A0 =A0/* x, y, rx, ry */
>> + =A0 =A0 int x_offset, y_offset, rx_offset, ry_offset;
>> + =A0 =A0 int c;
>> + =A0 =A0 int range;
>> + =A0 =A0 int abs_magnitude, adjusted_magnitude, difference, scale_f=
raction;
>> + =A0 =A0 int dead_zone[2], stick_limit[2];
>> +
>> + =A0 =A0 dead_zone[0] =3D xpad->left_dead_zone;
>> + =A0 =A0 dead_zone[1] =3D xpad->right_dead_zone;
>> + =A0 =A0 stick_limit[0] =3D xpad->left_stick_limit;
>> + =A0 =A0 stick_limit[1] =3D xpad->right_stick_limit;
>> +
>> + =A0 =A0 if (xpad->xtype =3D=3D XTYPE_XBOX) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 x_offset =3D 12;
>> + =A0 =A0 =A0 =A0 =A0 =A0 y_offset =3D 14;
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_offset =3D 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ry_offset =3D 18;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 x_offset =3D 6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 y_offset =3D 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_offset =3D 10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ry_offset =3D 12;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 coords[0] =3D (__s16) le16_to_cpup((__le16 *)(data + x_off=
set));
>> + =A0 =A0 coords[1] =3D ~(__s16) le16_to_cpup((__le16 *)(data + y_of=
fset));
>> + =A0 =A0 coords[2] =3D (__s16) le16_to_cpup((__le16 *)(data + rx_of=
fset));
>> + =A0 =A0 coords[3] =3D ~(__s16) le16_to_cpup((__le16 *)(data + ry_o=
ffset));
>
> We don't need the first typecast here and if `data' were to have type
> `void *', we could do away with the second cast as well.
>

These two typecasts are in the original xpad driver, which is
presently in-tree (see drivers/input/joystick/xpad.c in the current
stable branch). I did not change the logic here, because I'm not clear
on the intent of the __s16 data type.

The actual device raw data is little-endian from the docs I've read.
What happens if the user is trying to run this driver on a big-endian
architecture? Does __le16 take care of it?

>
>> + =A0 =A0 /* Adjustment for dead zone and square axis */
>> + =A0 =A0 for (c =3D 0; c < 4; c++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 abs_magnitude =3D (int) coords[c];
>
> `coords[c]' already has type `int'.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (abs_magnitude < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abs_magnitude =3D -abs_mag=
nitude;
>
> use abs()?

See above regarding max/min. abs() is certainly what I want here.

>> + =A0 =A0 input_report_abs(dev, ABS_X, (__s16) coords[0]);
>> + =A0 =A0 input_report_abs(dev, ABS_Y, (__s16) coords[1]);
>> + =A0 =A0 input_report_abs(dev, ABS_RX, (__s16) coords[2]);
>> + =A0 =A0 input_report_abs(dev, ABS_RY, (__s16) coords[3]);
>> +}
>
> The third argument to input_report_abs() has type `int', and coords[n=
]
> has type `int'. =A0Why go and put a __s16 cast in the middle there?
>
> Please review all the typecasting which this patch does with a view t=
o
> deleting as much as possible.
>
> In fact, delete all of it. =A0If the code then warns or stops working=
,
> then something was probably already wrongly designed and the
> typecasting was covering up the breakage.
>

I will give this a try... but I only have Intel (little-endian)
systems on which to test the results. I do see that the
input_report_abs takes an int, so I see the type-cast is unnecessary
in this specific section. Once again, I was trying to follow the
original driver, perhaps a little too closely.

>> - =A0 =A0 int dpad_mapping; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* map d-pad=
 to buttons or to axes */
>> - =A0 =A0 int xtype; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* t=
ype of xbox device */
>> -};
>>
>> =A0/*
>> =A0 * =A0 xpad_process_packet
>>
>> ...
>>
>> +static void xpad360w_identify_controller(struct usb_xpad *xpad,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned char *data)
>> +{
>> + =A0 =A0 u32 id;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 snprintf(xpad->controller_unique_id, 17,
>> + =A0 =A0 =A0 =A0 =A0 =A0 "%02x%02x%02x%02x%02x%02x%02x%02x",
>> + =A0 =A0 =A0 =A0 =A0 =A0 data[8], data[9], data[10], data[11], data=
[12], data[13],
>> + =A0 =A0 =A0 =A0 =A0 =A0 data[14], data[15]);
>> +
>> + =A0 =A0 /* Identify controller type */
>> + =A0 =A0 id =3D (u32) *(data + 22);
>
> Another unneeded cast.

I could do something here as simple as:

id =3D data[22];

But in that case, someone reading the code might see that data is a
byte array (be it unsigned char * or void *) and assume that id is one
byte in size. In reality, id is 4 bytes, and it is really a byte
string. To be less clever, I should probably just do another snprintf
and change the id field to be unsigned char[5]. If I make this change,
however, the check to identify the controller type will take longer
(basically a strncmp).

Since the code currently runs in an interrupt handler (for wireless
360 devices, at least), I will also need to move the call to this
function to my workqueue task.

>>
>> -#ifdef CONFIG_JOYSTICK_XPAD_FF
>> +/* end output section */
>> +
>> +/******************************************************************=
***********/
>> +
>> +/* Force feedback (rumble effect) section, depends on CONFIG_JOYSTI=
CK_XPAD_FF */
>> +
>> +#if defined(CONFIG_JOYSTICK_XPAD_FF)
>
> #ifdef CONFIG_JOYSTICK_XPAD_FF
>
> is more typical.
>

I had that form originally in my new code... but the old code used #if
defined(...), so I changed mine to be uniform. I suppose I should be
less ready to accept something just because it's already in the stable
tree... but on the flip side, I didn't want to change parts that were
known to be working.

>
>>
>> ...
>>
>> --- origdrv/drivers/input/joystick/xpad.h =A0 =A0 1969-12-31 19:00:0=
0.000000000 -0500
>> +++ newdrv/drivers/input/joystick/xpad.h =A0 =A0 =A02009-02-28 23:20=
:20.000000000 -0500
>
> This header file contains a large number of statements which emit dat=
a.
>
> Such as this:
>
>> +static int dpad_to_buttons;
>> +module_param(dpad_to_buttons, bool, S_IRUGO);
>> +MODULE_PARM_DESC(dpad_to_buttons,
>> + =A0 =A0 "Map D-PAD to buttons rather than axes for unknown pads");
>
> and this:
>
>> +static const struct xpad_device {
>> + =A0 =A0 u16 idVendor;
>> + =A0 =A0 u16 idProduct;
>> + =A0 =A0 char *name;
>> + =A0 =A0 u8 dpad_mapping;
>> + =A0 =A0 u8 xtype;
>> + =A0 =A0 u8 controller_type;
>> +} xpad_device[] =3D {
>
> This is all wrong - those statements should be in a .c file.
>

I had looked up another driver that used a header file in the stable
tree (don't remember which one) and tried to place things according to
where that driver had them. I guess I picked the wrong one :). I'll
move those declarations to the .c file.

There may be some delay in getting an update done. I have a fairly
full plate at the moment, and I always make a test run with the actual
hardware and actual userspace software (read: a video game) prior to
posting a new version of the patch.

Thanks,
Mike
--=20
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838   Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
