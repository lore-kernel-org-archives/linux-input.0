From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [patch 0/2] Winbond IR Driver - v2
Date: Sat, 15 Aug 2009 22:10:19 +0200
Message-ID: <20090815201019.GB27484@hardeman.nu>
References: <20090809095645.198777507@hardeman.nu> <1250305347.18122.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:60277 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZHOUKU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Aug 2009 16:10:20 -0400
Content-Disposition: inline
In-Reply-To: <1250305347.18122.4.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, randy.dunlap@oracle.com, dmitry.torokhov@gmail.com

On Sat, Aug 15, 2009 at 06:02:27AM +0300, Maxim Levitsky wrote:
>On Sun, 2009-08-09 at 11:56 +0200, david@hardeman.nu wrote:
>> Here's a new patch set which should replace all the patches currentl=
y in the
>> -mm tree for the winbond cir driver. The new series incorporate feed=
back from
>> Bjorn Helgaas (convert the driver from ACPI to PNP) and Randy Dunlap=
 (Kconfig
>> fixes).
>>=20
>> The IR decoding can still be improved but the driver works for in da=
ily use
>> decoding RC6 commands, so I believe it is ready to go upstream.
>>=20
>
>Hi.

Hi,

>As I understand, this hardware returns sampled IR signal, so it can be
>used with any remote, right?

Yes.

>Then why not to implement lirc driver?

That's a fair question, but I'm afraid you're putting the cart before=20
the horse.

The question is not why anyone would want to write an in-kernel driver=20
but rather why anyone would want to write an out-of-kernel driver.

There have been repeated attempts to get LIRC merged with the kernel,=20
and the feedback has been pretty consistent - make it part of the input=
=20
subsystem.

I have written the driver for the input system and it limits the driver=
=20
somewhat. I am working on extending the input system to accomodate IR=20
drivers (see the discussion of EV_IR on the linux-input list).

As an example, the input system already has a quite extensive set of=20
additional functions to deal with force-feedback hardware (mostly=20
additional ioctl's, see include/linux/input.h). I want the input system=
=20
to grow similar extensions for IR hardware which would then allow IR=20
drivers to be written as input drivers with their full functionality=20
exposed to user-space.

=46eel free to help me out in implementing that API, and porting LIRC=20
drivers, and all the benefits of in-kernel drivers will flow from that=20
work.

To be more specific, the things that are on my radar right now are:

o IR TX - I believe an IOCTL which will take an array of signed integer=
s=20
           symbolizing IR on/off timings together with parameters for I=
R=20
           carrier modulation is the way to go and to let userspace dea=
l=20
           with the generation of those integers (for a number of=20
           reasons).

o IR RX - We need to expose the full functionality of hardware with=20
           multiple receivers to userspace. Microsoft's current CIR spe=
cs=20
           mandate that IR hardware that includes transmitters must=20
           include both a long-distance, narrow-band receiver for commo=
n=20
           use and a short-distance, wide-band receiver for learning=20
           purposes. Expect future hardware to meet those demands...

o Hardware differences -
           The lircd daemon currently has a "-H" parameter to specify t=
he=20
           driver to use. To me, that is a dead giveaway for an=20
           inconsistent kernel <-> userspace API. We can do better, giv=
en=20
           the proper HW flags from the input layer, userspace should=20
           adapt automatically. Some hardware, say=20
           drivers/media/dvb/ttpci/budget-ci.c (where you'll find my na=
me=20
           in the git logs) only support passing decoded RC5 events. So=
me=20
           hardware (like the lirc mceusb(2) driver) passes the timing=20
           for the IR signals and supports any remotely sane IR protoco=
l.=20
           The WPCD376I has even a bit more capabilities like=20
           wake-from-poweroff, two receivers and up to four transmitter=
s
           with the capability to detect which transmitters are connect=
ed=20
           and which ones are not.

           The challenge at this point is not in writing drivers for th=
e=20
           hardware, it is designing an extension to the input layer th=
at=20
           can sanely deal with the diversity.

Anyhow, do check the linux-input list for my EV_IR patches, they are th=
e=20
first step in that direction (and they're based on the API proposal by=20
Jon Smirl posted at the end of last year). Raw signalling information=20
for wonky remotes is part of that proposal (though the patches are not=20
fully fleshed out yet).

>This driver as I understand is a driver for single remote shipped with
>the notebook.

It's a driver for a winbond chipset shipped with many Intel desktop=20
"media" motherboards (DP35DP, DG33TL, DX388T, DX488T2, DP455G, DG45ID=20
and DG45FC are the ones I'm aware of).

>I have recently wrote a lirc driver for  my receiver, a lirc driver. N=
ow
>I can use all my remotes.

So can I. But for a easy-to-use and consistent user interface, some=20
changes are needed to the input layer.

>And no, I don't need any software support for that. LIRC happily
>forwards all events via uinput to kernel, so I use it a an ordinary
>keyboard.

I know LIRC and what it can do, look in the CVS logs and the LIRC=20
mailing list archives and I think you'll find my name there.

Regards,
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
