From: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Subject: Re: [PATCH 1/3] Input: Add new property INPUT_PROP_COMPOSITE
Date: Tue, 22 Aug 2017 23:34:17 +0000
Message-ID: <1DD62093774CEE42AFC16E785A1088049D819097@USCULXMSG08.am.sony.com>
References: <20170818020156.23390-1-roderick@gaikai.com>
 <20170818020156.23390-2-roderick@gaikai.com> <20170818032454.GA1254@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29301
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752742AbdHVXe1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2017 19:34:27 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, "roderick@gaikai.com" <roderick@gaikai.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>

On 08/17/2017 08:25 PM, Peter Hutterer wrote:=0A=
> On Thu, Aug 17, 2017 at 07:01:54PM -0700, Roderick Colenbrander wrote:=0A=
>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>=0A=
>>=0A=
>> This new property can be set on subdevices part of a composite=0A=
>> input device. The purpose of the constant is to notify other=0A=
>> kernel components (e.g. joydev) and user space that a device is=0A=
>> a composite device.=0A=
>>=0A=
>> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>=0A=
>> ---=0A=
>>   Documentation/input/event-codes.rst    | 12 ++++++++++++=0A=
>>   include/uapi/linux/input-event-codes.h |  1 +=0A=
>>   2 files changed, 13 insertions(+)=0A=
>>=0A=
>> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/e=
vent-codes.rst=0A=
>> index a8c0873..d56a32e 100644=0A=
>> --- a/Documentation/input/event-codes.rst=0A=
>> +++ b/Documentation/input/event-codes.rst=0A=
>> @@ -356,6 +356,18 @@ can report through the rotational axes (absolute an=
d/or relative rx, ry, rz).=0A=
>>   All other axes retain their meaning. A device must not mix=0A=
>>   regular directional axes and accelerometer axes on the same event node=
.=0A=
>>   =0A=
>> +INPUT_PROP_COMPOSITE=0A=
>> +--------------------=0A=
>> +=0A=
>> +The functionality of some advanced input devices is exposed through sev=
eral=0A=
>> +event devices. For example a gamepad with motion sensors could be expos=
ed as=0A=
>> +a gamepad device with axes / buttons and a separate motion sensor devic=
e.=0A=
>> +=0A=
>> +The INPUT_PROP_COMPOSITE flag is set on all sub devices making up a lar=
ger=0A=
>> +composite device. This flag allows user space applications in addition =
to=0A=
>> +other kernel drivers (e.g. joydev) to easily determine whether a device=
=0A=
>> +is part of a composite device.=0A=
> =0A=
> honestly, I would love for this to be paired with an ioctl that can give =
me=0A=
> the sysnames of the other devices. Or (probably safer) just a unique=0A=
> number/string that all composite devices share.=0A=
=0A=
I agree enumerating composite devices is a pain, which requires looping =0A=
over all evdev nodes and attempting to stitch them together based on =0A=
ioctl return info or by manually scanning sysfs. On a sidenote, the =0A=
process of finding sysfs node for a device as this often needed too for =0A=
e.g. LEDs and device specific options is tricky too and could use =0A=
improvements.=0A=
=0A=
I'm trying to envision how a new ioctl for composite device enumeration =0A=
would work. Even right now there are already fun race conditions as the =0A=
composite devices come up in different order just, because they =0A=
completed initialization at slightly different times.=0A=
=0A=
Maybe there would be some 'evdev device group' concept with each evdev =0A=
node storing this unique id. This would map to a unique location in =0A=
sysfs, which contains the list of devices? The ioctl would just be used =0A=
to query this id?=0A=
=0A=
=0A=
> =0A=
> That way I can reassemble this in userspace. We already do something like=
=0A=
> this for the libinput device groups and I think just having the input=0A=
> property isn't quite enough. We can already guess a lot of this from the=
=0A=
> PHYS attributes but there are several devices where having this filled by=
=0A=
> the kernel is going to be useful. Wacom devices for example where the pen=
=0A=
> and touch device don't share the same pid.=0A=
=0A=
I'm not too familiar with the Wacom devices, the composite device show =0A=
up as different devices on a bus (e.g. USB / Bluetooth / ..) or is there =
=0A=
a single physical device, but the driver somehow exposes different sub =0A=
devices through some vendor specific method?=0A=
=0A=
> =0A=
> Right now, it's a bit too simple - all this flag gives me is the=0A=
> notification that I have to start looking for other devices. Works fine w=
ith=0A=
> one composited device connected, but once you look at more than that it=
=0A=
> doesn't seem to be overly useful.=0A=
=0A=
I understand a more sophisticated solution is desired and we don't help =0A=
creating that. For us the original problem was that we expose dualshock =0A=
3 / 4 subdevices in recent kernels for which the subdevices got picked =0A=
up by joydev. We proposed code to limit accelerometer devices, but =0A=
during review it was felt that the code didn't narrow it down enough. We =
=0A=
felt joydev would cause issues for users and then recently we had this =0A=
reddit thread =0A=
(https://www.reddit.com/r/linux_gaming/comments/6rxhj8/what_happened_with_t=
he_dualshock_4_and_the_new/) =0A=
with complaining users (SDL2 we took care of last year, but they still =0A=
haven't released 2.0.6 yet). Since 4.13 or 4.14 will be used in a lot of =
=0A=
upcoming distributions, we like to consider at least getting this =0A=
initial part in, if it is considered to be a stepping stone towards the =0A=
full solution of adding an ioctl as well.=0A=
=0A=
=0A=
> =0A=
> Cheers,=0A=
>     Peter=0A=
> =0A=
> =0A=
>> +=0A=
>>   Guidelines=0A=
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>>   =0A=
>> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux=
/input-event-codes.h=0A=
>> index 1798910..da3fa83 100644=0A=
>> --- a/include/uapi/linux/input-event-codes.h=0A=
>> +++ b/include/uapi/linux/input-event-codes.h=0A=
>> @@ -26,6 +26,7 @@=0A=
>>   #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */=
=0A=
>>   #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */=0A=
>>   #define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */=0A=
>> +#define INPUT_PROP_COMPOSITE		0x07	/* is part of a composite device */=
=0A=
>>   =0A=
>>   #define INPUT_PROP_MAX			0x1f=0A=
>>   #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)=0A=
>> -- =0A=
>> 2.9.4=0A=
> =0A=
> =0A=
=0A=
