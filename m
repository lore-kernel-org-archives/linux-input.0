From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 0/1] input/touchscreen: Synaptics Touchscreen Driver
Date: Tue, 23 Mar 2010 18:17:45 -0700
Message-ID: <4BA96839.9020903@synaptics.com>
References: <1269310058-10894-1-git-send-email-cheiny@synaptics.com>	 <d6200be21003222004g2e2a1000ja65fc3f80f9fad78@mail.gmail.com>	 <4BA913FB.1000508@synaptics.com> <d6200be21003231535w3cf9ff30w316f3447f3631689@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx4.synaptics.com ([12.178.49.178]:31074 "EHLO
	us-mx4.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0CXBRu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Mar 2010 21:17:50 -0400
In-Reply-To: <d6200be21003231535w3cf9ff30w316f3447f3631689@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <WManson@synaptics.com>

On 03/23/2010 03:35 PM, Arve Hj=F8nnev=E5g wrote:
> 2010/3/23 Christopher Heiny<cheiny@synaptics.com>:
>> On 03/22/2010 08:04 PM, Arve Hj=F8nnev=E5g wrote:
>>>
>>> On Mon, Mar 22, 2010 at 7:07 PM, Christopher Heiny<cheiny@synaptics=
=2Ecom>
>>>   wrote:
>>> ...
>>>>
>>>> There are two existing drivers for similar Synaptics devices in th=
e
>>>> current kernel tree (excluding the PS/2 touchpad driver).  These a=
re:
>>>>
>>>> ./linux-2.6/drivers/input/mouse/synaptics_i2c.c
>>>>       A driver for the Exeda 15mm touchpad, written by Mike Rapopo=
rt
>>>>       <mike@compulab.co.il>   and Igor Grinberg<grinberg@compulab.=
co.il>
>>>>
>>>> ./linux-2.6/drivers/staging/dream/synaptics_i2c_rmi.c
>>>>       A driver for the HTC Dream ClearPad, written by Arve Hj=F8nn=
ev=E5g
>>>>       <arve@android.com>
>>>>
>>>> We have not extended these drivers for a couple of reasons.  First=
, the
>>>> two drivers are specific to particular Synaptics products, and it =
is our
>>>> desire to produce a general solution that takes advantage of the '=
self
>>>> describing' features of products that use the RMI protocol.
>>>>
>>>
>>> Do you plan to add platform data to align the reported touchscreen
>>> data with the screen behind it, or do the new hardware allow the th=
e
>>> firmware handle this? In the past we even needed separate parameter=
s
>>> for different firmware versions (seen in
>>> drivers/staging/dream/synaptics_i2c_rmi.h).
>>
>> Hi Arve,
>>
>> RMI4 touchscreens allow adjustment of the reported coordinate range =
(see the
>> F11_2D_Ctrl6..9 registers, page 48 of the current version of the spe=
c at
>> http://www.synaptics.com/developers/manuals).  Using this feature, t=
he
>> device can be configured to report the same number of positions on e=
ach axis
>> as there are pixels on the display.
>>
>
> This does not help aligning the touchscreen values with the screen
> behind it. It just moves the linear scaling from userspace (which can
> use fixed or floating point values to preserve subpixel precision) to
> the firmware.

Hi Arve,

It sounds like your concern is for cases when the origin of the=20
touchscreen coordinates does not correspond to a corner of the pixel=20
area.  Is that correct?

In any case, it's a perfectly valid issue - not all manufacturers take=20
care to map the touchscreen to the display screen that way (though most=
=20
do).  Adding a translation control to the driver would be easy - we'll=20
put it on the todo list.

>
>> We plan to make these settings accessible via sysfs, so that it can =
be
>> dynamically tweaked if the user changes the display resolution (not =
likely
>> on a phone, probable on a tablet/slate/ereader type device). Assumin=
g there
>> are no significant issues with our current patch, we plan to include=
 that in
>> the next one.  We're holding off that implementation because we're s=
till
>> finding our feet on the submission process, and wanted to keep the i=
nitial
>> submits small so changes would be more manageable.
>
> You could also post a patch series instead of one patch.

It's more the other direction - we were concerned (validly, it turned=20
out) that some extensive changes might be required as a result of=20
feedback on the initial submissions, and wanted to keep the codebase=20
we'd have to refactor small.

As the codebase grows, we'll switch to using patch series.  Probably=20
with the next submission or (more likely) the one after that.

>> Coordinate rotation/reflection settings will be handled at the drive=
r level,
>> again via sysfs.
>>
> Do you also have a plan to let the userspace know that touchscreen
> coordinate x1,y1 correspond to screen coordinate 0,0 and x2,y2
> correspond to screen coordinate xmax,ymax? The android driver sets
> absmin/max to the values reported when touching the display edges (no=
t
> the actual min and max that the touchscreen can report), but other
> solutions are also possible.

We are not planning on that, since it would require the driver to know=20
the orientation (standard? rot 90? rot -90? rot 180?) and resolution of=
=20
the display and track whenever that changes.  It is better to handle=20
that information at a higher level, which can then tell the touchscreen=
=20
driver the desired resolution/rotation/etc settings.

>> These features should be independent of the touchscreen firmware lev=
el.
>
> In the past they have depended on the firmware version for two
> reasons. On one product, firmware changes to improve the edges of the
> screen completely changed the relationship between values reported an=
d
> the physical touch location.

Good point.

> On another product, the physical size of
> the sensor changed, and the firmware version was used to detect this.
> If all RMI4 based product allow field updates of the firmware the
> first case it less important, but we still need to cover the second
> case.

Hmmmm.  I can see a lot of other cases where it might be desirable to=20
know the size of the touchscreen in a platform independent manner.=20
Certainly the firmware version is not a reliable way to do this going=20
forward.  I will contact the spec maintainer and see if we can have the=
=20
device report the relative information in a query.

				Thanks,
					Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
