From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 17:58:44 +0100
Message-ID: <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com>
References: <4EC10878.20109@edigma.com>
	<CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
	<4EC13B0F.2080509@edigma.com>
	<CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com>
	<4EC1427D.2090703@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50384 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1KNQ6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 11:58:45 -0500
Received: by wwe5 with SMTP id 5so4667255wwe.1
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 08:58:44 -0800 (PST)
In-Reply-To: <4EC1427D.2090703@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Nuno

On Mon, Nov 14, 2011 at 5:31 PM, Nuno Santos <nsantos@edigma.com> wrote=
:
> On 11/14/2011 04:09 PM, David Herrmann wrote:
>>> I need to be able to communicate to and from the device from the an
>>> application build in Qt. So, there must be something really generic=
 that
>>> I
>>> can call from the application environment. In windows I use window =
API to
>>> call IOCTLS interaction.
>>
>> Why? I thought this thing is an input device? Why does an applicatio=
n
>> have to modify a running device? Is this modification local to the
>> application<->device interface or does it also affect all other
>> running applications that use this device?
>
> Yes, it is an multitouch overlay input device. However all the proces=
sing is
> done on the host side. The device delivers raw data into the system a=
nd all
> the tracking and touch information is processed on the kernel side. T=
he
> control panel for this device shows the input data and permits some
> parameter change. In order to visualize that data I need to be able t=
o get a
> complete structure from it. When I change a parameter it will reflect=
 the
> change to the input being reported to all the applications that use t=
hat
> input device.

The most straightforward approach would be applying default values I
think. If there is still a need to have variable configuration values
you should use sysfs attributes here. Maybe Dmitry knows other generic
ways in the input layer, but I would recommend sysfs attributes here.
This is never wrong ;)

>> If it is a configuration value to put the device into a different
>> state or similar, then you can use a sysfs attribute. The user can
>> change this with "echo<value> =A0>/sys/class/input/inputX/<attribute=
>"
>
> For setting new simple values I see I can use this interface, but two
> questions arise. How can I send a structure with this interface? Can =
I fopen
> this sys file and send the whole structure thru this mechanism. What =
about
> receiving data from the device?

sysfs attributes are simple files. That is, you can write to and read
from them. Please see ./Documentation/driver-model/device.txt for a
rough overview. You basically register two callbacks: read and write.
The read callback is called when userspace reads the file. You should
then pass the requested data to userspace.
The write callback is called when userspace writes the file. You
should parse the data and modify your internal structures accordingly.

But please take into account that you should never use a single
attribute for multiple values. If you need to pass a structure to the
driver then register multiple attributes, one for each member of the
structure. It is *not* bad style to have several attributes.
If there are possible race-conditions if a structure is not passed
atomically, you may violate this rule in some places.

Almost every driver today registers several attributes so it shouldn't
be hard to find examples.

> Regards,
>
> Nuno

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
