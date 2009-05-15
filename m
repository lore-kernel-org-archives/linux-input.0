From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [RFC] Add Input IOCTL for accelerometer devices
Date: Fri, 15 May 2009 20:30:41 +0100
Message-ID: <45cc95260905151230j5485995dpbbd882dc91b25339@mail.gmail.com>
References: <20090515131636.GE4443@nokia.com> <5d5443650905151106v2fe7ad1ci6c966463a991e732@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:56533 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZEOTbE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 15:31:04 -0400
In-Reply-To: <5d5443650905151106v2fe7ad1ci6c966463a991e732@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: felipe.balbi@nokia.com, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>

Hi all,

I am really interested about that.

But I want to know more about the device, its type, name, ...
The device isn't HID (Human Interface Device) ? If so, we should
rethink adding such thing but modify/use hid-input instead.

Because, I have an accelerometer phidget device and it is HID.
Handling should be the same.



On Fri, May 15, 2009 at 7:06 PM, Trilok Soni <soni.trilok@gmail.com> wr=
ote:
> Hi Felipe,
>
> Adding linux-input and Jonathan, so not deleting any lines from this =
e-mail.
>
> On Fri, May 15, 2009 at 6:46 PM, Felipe Balbi <felipe.balbi@nokia.com=
> wrote:
>> Hi all,
>>
>> the following patch is just an idea to see how the community feels a=
bout
>> it. Considering accelerometer devices, you might have different use
>> cases for it while running different applications. You could be usin=
g it
>> for screen rotation in one case but when opening a game, you could u=
se
>> it as a game controller by turning the device side-by-side.
>
> There was one proposal from Jonathan called Industrial IO patchset
> which tried to address these sensor devices. Please grep in your
> linux-kernel archieve. I believe there are accelerometer drivers unde=
r
> drivers/hwmon.
>
>>
>> Thinking about that, I decided it would be nice to have some paramet=
ers
>> configured at runtime in order to be able to use the accelerometer o=
n
>> different use cases.
>>
>> The following proposal (really draft) tries to add a new IOCTL on in=
put
>> layer such as userland could use that for passing proper parameters =
to
>> accelerometer drivers.
>>
>> ps: the patch is in really early stage, I'm guessing the best would =
be
>> to, as force feedback devices, provide proper registration for an
>> accelerometer device.
>>
>> diff --git a/include/linux/input.h b/include/linux/input.h
>> index adc1332..c3c9e82 100644
>> --- a/include/linux/input.h
>> +++ b/include/linux/input.h
>> @@ -55,6 +55,26 @@ struct input_absinfo {
>> =A0 =A0 =A0 =A0__s32 flat;
>> =A0};
>>
>> +#define INPUT_ACCEL_IRQ_NONE =A0 0
>> +#define INPUT_ACCEL_IRQ_HIGH =A0 BIT(0)
>> +#define INPUT_ACCEL_IRQ_LOW =A0 =A0BIT(1)
>> +#define INPUT_ACCEL_IRQ_LATCH =A0BIT(2)
>> +
>> +struct input_accelinfo {
>> + =A0 =A0 =A0 __u32 threshold;
>> + =A0 =A0 =A0 __u32 duration;
>> +
>> + =A0 =A0 =A0 /* the following 4 fields configure how the irqs will =
be generated:
>> + =A0 =A0 =A0 =A0* - High Event
>> + =A0 =A0 =A0 =A0* - Low Event
>> + =A0 =A0 =A0 =A0* - Latch irq request
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 __u8 x_irq;
>> + =A0 =A0 =A0 __u8 y_irq;
>> + =A0 =A0 =A0 __u8 z_irq;
>> + =A0 =A0 =A0 __u8 click_irq;
>> +};
>> +
>> =A0#define EVIOCGVERSION =A0 =A0 =A0 =A0 =A0_IOR('E', 0x01, int) =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* get driver version */
>> =A0#define EVIOCGID =A0 =A0 =A0 =A0 =A0 =A0 =A0 _IOR('E', 0x02, stru=
ct input_id) =A0 =A0 =A0 =A0/* get device ID */
>> =A0#define EVIOCGREP =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOR('E', 0x03, int[=
2]) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* get repeat settings */
>> @@ -81,6 +101,8 @@ struct input_absinfo {
>>
>> =A0#define EVIOCGRAB =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOW('E', 0x90, int)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Grab/Release device */
>>
>> +#define EVIOCACCELINFO =A0 =A0 =A0 =A0 _IOW('E', 0x91, struct input=
_accelinfo) /* set accelerometer's parameters */
>> +
>> =A0/*
>> =A0* Event types
>> =A0*/
>> @@ -975,6 +997,8 @@ struct ff_effect {
>> =A0#include <linux/timer.h>
>> =A0#include <linux/mod_devicetable.h>
>>
>> +struct input_accelinfo;
>> +
>> =A0/**
>> =A0* struct input_dev - represents an input device
>> =A0* @name: name of the device
>> @@ -1069,6 +1093,7 @@ struct input_dev {
>> =A0 =A0 =A0 =A0void *keycode;
>> =A0 =A0 =A0 =A0int (*setkeycode)(struct input_dev *dev, int scancode=
, int keycode);
>> =A0 =A0 =A0 =A0int (*getkeycode)(struct input_dev *dev, int scancode=
, int *keycode);
>> + =A0 =A0 =A0 int (*set_accelinfo)(struct input_dev *dev, struct inp=
ut_accelinfo *info);
>>
>> =A0 =A0 =A0 =A0struct ff_device *ff;
>>
>>
>>
>> --
>> balbi
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>>
>
>
>
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
