From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [patch 0/2] Winbond IR Driver - v2
Date: Sun, 16 Aug 2009 20:43:50 +0200
Message-ID: <20090816184350.GA28497@hardeman.nu>
References: <20090809095645.198777507@hardeman.nu>
 <1250305347.18122.4.camel@maxim-laptop>
 <20090815201019.GB27484@hardeman.nu>
 <1250374211.1928.27.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:33667 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbZHPSn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Aug 2009 14:43:56 -0400
Content-Disposition: inline
In-Reply-To: <1250374211.1928.27.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com

On Sun, Aug 16, 2009 at 01:10:11AM +0300, Maxim Levitsky wrote:
>On Sat, 2009-08-15 at 22:10 +0200, David H=E4rdeman wrote:
>> On Sat, Aug 15, 2009 at 06:02:27AM +0300, Maxim Levitsky wrote:
>>>
>>> Then why not to implement lirc driver?
>>
>> That's a fair question, but I'm afraid you're putting the cart befor=
e
>> the horse.
>
>No, I just want to write the driver that fully exposes the hardware. I
>don't care if it has to be outside or not.

That's not a very user-friendly sentiment. The entire idea is to extend=
=20
the input subsystem so that it fully exposes the hardware *and* gives=20
users the benefit of in-kernel drivers.

>> The question is not why anyone would want to write an in-kernel driv=
er
>> but rather why anyone would want to write an out-of-kernel driver.
>>
>> There have been repeated attempts to get LIRC merged with the kernel=
,
>> and the feedback has been pretty consistent - make it part of the in=
put
>> subsystem.
>>
>> I have written the driver for theo input system and it limits the dr=
iver
>> somewhat. I am working on extending the input system to accomodate I=
R
>> drivers (see the discussion of EV_IR on the linux-input list).
>
>The EV_IR thing is that he attempts to put all IR decoding in kernel,
>and on top of that create a configfs config system.

I never proposed a configfs system. I only proposed a part of Jon=20
Smirl's EV_IR functionality. I think the configfs system as well as the=
=20
in-kernel protocol _en_coders are overengineering.

>I first thought it would be nice, but then realized that this is reall=
y
>bad idea.
>Currently LIRC has very oiled system for decoding pretty much every
>remote that exist. It can cope with all kind of troubles, including no=
t
>very accurate receivers.

I think you've misunderstood my EV_IR suggestion on the linux-input=20
list. Part of that proposal is to allow drivers to generate IR_RAW=20
timing events (if asked to do so via an ioctl), then you could continue=
=20
to use lirc with some minimal changes to the lirc daemon while still=20
getting the benefits of in-kernel drivers. I have a hard time seeing=20
what would be wrong with that? Whether the input subsystem *also*=20
includes (optional) IR decoding or not should not matter to lirc fans a=
s=20
long as it includes some kind of IR_RAW support (which it does both in=20
Jon's proposal and in mine).

>On top of that there are pure userspace devices, like a IR diode
>connected to soundcard. It would be nice to do all the raw signal
>decoding in one place. Once signal is decoded, lirc forwards the input
>signal to the kernel via uinput, so it is a part of input system.

That's a red herring, there is always going to be esoteric DIY hardware=
,=20
and no matter which API is used in the kernel, that hardware can always=
=20
use user-space drivers.

>The way kernel hands in the raw IR data to lirc doesn't matter much. I=
t
>is really just a queue of numbers. It can be forced into input system,
>but there is really no need for that.

There really is a need if you want in-kernel drivers.

>> Feel free to help me out in implementing that API, and porting LIRC
>> drivers, and all the benefits of in-kernel drivers will flow from th=
at
>> work.
>
>This isn't a bad idea.

Good, we agree on this point, which is the most important one. IR_RAW=20
should be enough for the lirc daemon, right? So let's make sure=20
something like that gets added to the input subsystem and we can take i=
t=20
from there...

>>>This driver as I understand is a driver for single remote shipped wi=
th
>>>the notebook.
>>
>> It's a driver for a winbond chipset shipped with many Intel desktop
>> "media" motherboards (DP35DP, DG33TL, DX388T, DX488T2, DP455G, DG45I=
D
>> and DG45FC are the ones I'm aware of).
>
>But it won't work with my JVC remote?....

Not sure what you JVC remote has to do with the Intel mainboards that=20
include the WPCD376I chipset.

Anyway, based on past experience of JVC remotes I'm guessing that your=20
remote uses some version of the NEC protocol, in that case it will be=20
supported...and IR_RAW (or something similar) will be supported if it i=
s=20
accepted by the input subsystem maintainers so you will additionally be=
=20
able to use that air conditioning remote which implements a completely=20
wonky IR protocol together with lirc - if you want to...

Regards,
David H=E4rdeman

(trimmed some people of the CC list which are unlikely to be interested=
=20
in this discussion, I hope Dmitry will speak up soon).

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
