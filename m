From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [RFC] Add Input IOCTL for accelerometer devices
Date: Mon, 18 May 2009 16:45:55 +0900
Message-ID: <4d34a0a70905180045u6619773dt1563fe38b13d46fb@mail.gmail.com>
References: <20090515131636.GE4443@nokia.com>
	 <5d5443650905151106v2fe7ad1ci6c966463a991e732@mail.gmail.com>
	 <45cc95260905151230j5485995dpbbd882dc91b25339@mail.gmail.com>
	 <20090515200235.GA11829@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f112.google.com ([209.85.221.112]:52811 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064AbZERHqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2009 03:46:05 -0400
In-Reply-To: <20090515200235.GA11829@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>, Kim Kyuwon <q1.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jean Delvare <khali@linux-fr.org>

Hi All,

It's very nice of Felipe to make an issue of accelerometers in Linux
kernel again.
Before further discussions, we'd better see previous threads about
accelerometer.

http://lkml.org/lkml/2008/5/20/135
http://lkml.org/lkml/2008/12/1/156
--

I have considered how I can add my accelerometer driver into the Linux
kernel nicely for a few months.

As Trilok said, there are many accelerometer drivers under
drivers/hwmon. So I first tried to add my driver as hwmon, but Jean
Delvare didn't agree this idea. Please refer to the following URL:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-April/025686.html

And from the next URL, Dmitry don't think it is great idea to add
accelerometer as Input system.
http://lkml.org/lkml/2008/5/27/283

On Sat, May 16, 2009 at 5:02 AM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
> Hi all,
>
>
> On Fri, May 15, 2009 at 09:30:41PM +0200, ext Mohamed Ikbel Boulabiar=
 wrote:
>> I am really interested about that.
>>
>> But I want to know more about the device, its type, name, ...
>> The device isn't HID (Human Interface Device) ? If so, we should
>> rethink adding such thing but modify/use hid-input instead.
>>
>> Because, I have an accelerometer phidget device and it is HID.
>> Handling should be the same.
>
> Yeah, let's try to define the best way to expose accelerometers with
> linux kernel and avoid a sysfs hell. Better sooner than later.

=46elipe,
Can I ask why did you say "avoid a sysfs hell"?. I have thought Kernel
developers prefer sysfs to IOCTL lately.

>> On Fri, May 15, 2009 at 7:06 PM, Trilok Soni <soni.trilok@gmail.com>=
 wrote:
>> > Hi Felipe,
>> >
>> > Adding linux-input and Jonathan, so not deleting any lines from th=
is e-mail.
>> >
>> > On Fri, May 15, 2009 at 6:46 PM, Felipe Balbi <felipe.balbi@nokia.=
com> wrote:
>> >> Hi all,
>> >>
>> >> the following patch is just an idea to see how the community feel=
s about
>> >> it. Considering accelerometer devices, you might have different u=
se
>> >> cases for it while running different applications. You could be u=
sing it
>> >> for screen rotation in one case but when opening a game, you coul=
d use
>> >> it as a game controller by turning the device side-by-side.
>> >
>> > There was one proposal from Jonathan called Industrial IO patchset
>> > which tried to address these sensor devices. Please grep in your
>> > linux-kernel archieve. I believe there are accelerometer drivers u=
nder
>> > drivers/hwmon.
>
> The problem is that it doesn't really seem to me that all acceleromet=
ers
> will be doing hw monitoring. The ones used in laptops, for sure, tryi=
ng
> to prevent the hd from drying during a fall. But imagine the
> accelerometers used in, say, wii-mote, or cellphones, or such stuff ?
>
> Say we wanna use the accelerometer for both screen rotation and gamin=
g,
> that device isn't doing hw monitoring and still we _do_ want to set
> different thresholds and irq requests/types for different use cases,
> right ?

Yes, I agree that accelerometer needs new interface. However setting
parameters of accelerometer is very different from devices and device
specific. Until now, I met two accelerometer, SMB380 from
bosch-sensortec and KXSD9 from Kionix. As far as I know, these two
accelerometers are quite different from each other and existing
accelerometer drivers located /driver/hwmon/ in current Linux kernel.
Thus I think sysfs interface (including hwmon-sysfs) is the best
solution for setting various parameters of accelerometer..

On the other hand, accelerometers are mostly used as Input device in
these days. Most APIs(input_allocate_device,
input_allocate_polled_device, ...) and macros(ABS_X,  ABS_Y, ...)of
Input subsystem are useful to accelerometer too. If we create another
APIs and Macros for accelerometers, I think It's another duplicate
work and result.

It seems like Dmitry concerns input_dev becomes too big with hundreds
of sensors.(right?) However, Market trend makes us consider
accelerometer as an input device now. I'm sure there is a good way to
add accelerometer input system without enlarging input_dev much.

In conclusion,
We need the inheritance concept in the object-oriented programming.
Accelerometer device sometimes can be hwmon device, sometimes input
device. So let accelerometer drivers use both APIs of hwmon and input
subsystems(hwmon_device_register, input_register_device,
input_register_polled_device). Acutally this is what many
accelerometer drivers in current Linux kernel are doing, so we don't
have to do much.

Let's
1) Introduce a new maintainer of accelerometer (Felipe?).
2) Move accelerometer drivers in current Linux kernel to /driver/accele=
rometer.
3) If we find the common functions of accelerometer or have idea about
new API or Macro, let's make at driver/accelerometer/acccelerometer.c,
input/linux/acccelerometer.h file or modify input.h little.
4) Add every new accelerometer into /driver/accelerometer.


Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
