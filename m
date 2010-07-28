From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Can I expect in-kernel decoding to work out of box?
Date: Wed, 28 Jul 2010 06:40:45 -0400
Message-ID: <AANLkTingNgxFLZcUszp-WDZocH+VK_+QTW8fB2PAR7XS@mail.gmail.com>
References: <1280269990.21278.15.camel@maxim-laptop>
	<1280273550.32216.4.camel@maxim-laptop>
	<AANLkTi=493LW6ZBURCtyeSYPoX=xfz6n6z77Lw=a2C9D@mail.gmail.com>
	<AANLkTimN1t-1a0v3S1zAXqk4MXJepKdsKP=cx9bmo=6g@mail.gmail.com>
	<1280298606.6736.15.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1280298606.6736.15.camel@maxim-laptop>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Jarod Wilson <jarod@wilsonet.com>, linux-input <linux-input@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 28, 2010 at 2:30 AM, Maxim Levitsky <maximlevitsky@gmail.co=
m> wrote:
> On Tue, 2010-07-27 at 22:33 -0400, Jarod Wilson wrote:
>> On Tue, Jul 27, 2010 at 9:29 PM, Jon Smirl <jonsmirl@gmail.com> wrot=
e:
>> > On Tue, Jul 27, 2010 at 7:32 PM, Maxim Levitsky <maximlevitsky@gma=
il.com> wrote:
>> >> On Wed, 2010-07-28 at 01:33 +0300, Maxim Levitsky wrote:
>> >>> Hi,
>> >>>
>> >>> I ported my ene driver to in-kernel decoding.
>> >>> It isn't yet ready to be released, but in few days it will be.
>> >>>
>> >>> Now, knowing about wonders of in-kernel decoding, I try to use i=
t, but
>> >>> it just doesn't work.
>> >>>
>> >>> Mind you that lircd works with this remote.
>> >>> (I attach my lircd.conf)
>> >>>
>> >>> Here is the output of mode2 for a single keypress:
>> >
>> > =A0 =A08850 =A0 =A0 4350 =A0 =A0 =A0525 =A0 =A0 1575 =A0 =A0 =A052=
5 =A0 =A0 1575
>> > =A0 =A0 525 =A0 =A0 =A0450 =A0 =A0 =A0525 =A0 =A0 =A0450 =A0 =A0 =A0=
525 =A0 =A0 =A0450
>> > =A0 =A0 525 =A0 =A0 =A0450 =A0 =A0 =A0525 =A0 =A0 1575 =A0 =A0 =A0=
525 =A0 =A0 =A0450
>> > =A0 =A0 525 =A0 =A0 1575 =A0 =A0 =A0525 =A0 =A0 =A0450 =A0 =A0 =A0=
525 =A0 =A0 1575
>> > =A0 =A0 525 =A0 =A0 =A0450 =A0 =A0 =A0525 =A0 =A0 =A0450 =A0 =A0 =A0=
525 =A0 =A0 1575
>> > =A0 =A0 525 =A0 =A0 =A0450 =A0 =A0 =A0525 =A0 =A0 =A0450 =A0 =A0 =A0=
525 =A0 =A023625
>> >
>> > That decodes as:
>> > 1100 0010 1010 0100
>> >
>> > In the NEC protocol the second word is supposed to be the inverse =
of
>> > the first word and it isn't. The timing is too short for NEC proto=
col
>> > too.
> No its not, its just extended NEC.

http://www.sbprojects.com/knowledge/ir/nec.htm
Says the last two bytes should be the complement of each other.

So for extended NEC it would need to be:
1100 0010 1010 0101 instead of 1100 0010 1010 0100
The last bit is wrong.

=46rom the debug output it is decoding as NEC, but then it fails a
consistency check. Maybe we need to add a new protocol that lets NEC
commands through even if they fail the error checks. It may also be
that the NEC machine rejected it because the timing was so far off
that it concluded that it couldn't be a NEC messages. The log didn't
include the exact reason it got rejected. Add some printks at the end
of the NEC machine to determine the exact reason for rejection.

The current state machines enforce protocol compliance so there are
probably a lot of older remotes that won't decode right. We can use
some help in adjusting the state machines to let out of spec codes
through.

The timing of those pulses is exactly right for JVC. Maybe there is an
extended 4 byte version of the JVC protocol. JVC doesn't have the
error checks like NEC. The question here is, why didn't the JVC
machine get started?

User space lirc is much older. Bugs like this have been worked out of
it. It will take some time to get the kernel implementation up to the
same level.


>
> This lirc generic config matches that output quite well:
> NEC-short-pulse.conf:
>
> begin remote
>
> =A0name =A0NEC
> =A0bits =A0 =A0 =A0 =A0 =A0 16
> =A0flags SPACE_ENC|CONST_LENGTH
> =A0eps =A0 =A0 =A0 =A0 =A0 =A030
> =A0aeps =A0 =A0 =A0 =A0 =A0100
>
> =A0header =A0 =A0 =A0 =A09000 4500
> =A0one =A0 =A0 =A0 =A0 =A0 563 =A01687
> =A0zero =A0 =A0 =A0 =A0 =A0563 =A0 562
> =A0ptrail =A0 =A0 =A0 =A0563
> =A0pre_data_bits 16
> # just a guess
> =A0gap =A0 =A0 =A0 =A0 =A0108000
>
> =A0repeat =A0 =A0 =A0 =A09000 2250
>
> =A0frequency =A0 =A038000
> =A0duty_cycle =A0 33
>
> =A0 =A0 =A0begin codes
> =A0 =A0 =A0end codes
>
> end remote
>
>
>
>> >
>> > Valid NEC...
>> > 1100 0011 1010 0101
>> >
>> > Maybe JVC protocol but it is longer than normal.
>> >
>> > The JVC decoder was unable to get started decoding it. =A0I don't =
think
>> > the JVC decoder has been tested much. Take a look at it and see wh=
y it
>> > couldn't get out of state 0.
>>
>> Personally, I haven't really tried much of anything but RC-6(A) and
>> RC-5 while working on mceusb, so they're the only ones I can really
>> vouch for myself at the moment. It seems that I don't have many
>> remotes that aren't an RC-x variant, outside of universals, which I
>> have yet to get around to programming for various other modes to tes=
t
>> any of the protocol decoders. I assume that David Hardeman already d=
id
>> that much before submitting each of the ir protocol decoders with hi=
s
>> name one them (which were, if I'm not mistaken, based at least
>> partially on Jon's earlier work), but its entirely possible there ar=
e
>> slight variants of each that aren't handled properly just yet. That
>> right there is one of the major reasons I saw for writing the lirc
>> bridge driver plugin in the first place -- the lirc userspace decode=
r
>> has been around for a LOT longer, and thus is likely to know how to
>> handle more widely varying IR signals.
>
> In fact its dead easy to test a lot of remotes, by using an universal
> remote. These remotes are designed to tech literate persons for a
> reason....
>
> On my remote, all I have to do is press TV + predefined number + OK t=
o
> make remote mimic a random remote.
> Unill now, kernel decoding couldn't pick anything but one mode....
>
>
> Here is a table I created long ago on my remote showing all kinds of
> protocols there:
>
> Heck, hardware isn't very accurate, I know, but streamzap receiver
> according to what I have heard it even worse...
>
> Best regards,
> Maxim Levitsky
>
>
> 08 - NEC short pulse / SANYO (38 khz), [15 - NEC]
> =A0 =A0 9440 =A0 =A0 4640 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A062=
0 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0=
550 =A0 =A0 =A0620 =A0 =A0 =A0550
> =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0=
610 =A0 =A0 =A0550 =A0 =A0 =A0610 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 1=
720 =A0 =A0 =A0620 =A0 =A0 1720
> =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0610 =A0 =A0 1730 =A0 =A0 =A061=
0 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 172=
0 =A0 =A0 =A0620 =A0 =A0 =A0550
> =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0=
620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0=
 =A0550 =A0 =A0 =A0610 =A0 =A0 =A0550
> =A0 =A0 =A0610 =A0 =A0 =A0550 =A0 =A0 =A0610 =A0 =A0 1720 =A0 =A0 =A0=
620 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 172=
0 =A0 =A0 =A0620 =A0 =A0 1720
> =A0 =A0 =A0610 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A062=
0 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A041540 =A0 =A0 9440 =A0 =A0 2300 =A0=
 =A0 =A0620 =A0 100110
> =A0 =A0(9440 =A0 =A0 2300 =A0 =A0 =A0610 =A0 100110)
> ---------------------------------------------------------------------=
------------------------------------------
> 02 - Philips (RC5): (36 khz)
> =A0 =A0 =A0990 =A0 =A0 =A0890 =A0 =A0 =A0970 =A0 =A0 =A0890 =A0 =A0 1=
920 =A0 =A0 =A0890 =A0 =A0 =A0970 =A0 =A0 =A0890 =A0 =A0 =A0970 =A0 =A0=
 =A0890 =A0 =A0 =A0970 =A0 =A0 =A0890
> =A0 =A0 =A0970 =A0 =A0 =A0890 =A0 =A0 =A0970 =A0 =A0 =A0890 =A0 =A0 =A0=
970 =A0 =A0 =A0890 =A0 =A0 =A0970 =A0 =A0 =A0890 =A0 =A0 =A0970 =A0 =A0=
 =A0890 =A0 =A0 =A0970 =A0 =A0 =A0890
> =A0 =A0 =A0970 =A0 =A094190
> ---------------------------------------------------------------------=
------------------------------------------
> 25 - Philips (RECS-80): (38 khz)
> =A0 =A0 =A0200 =A0 =A0 7720 =A0 =A0 =A0170 =A0 =A0 7720 =A0 =A0 =A017=
0 =A0 =A0 7700 =A0 =A0 =A0200 =A0 =A0 7690 =A0 =A0 =A0200 =A0 =A0 7720 =
=A0 =A0 =A0170 =A0 =A0 5090
> =A0 =A0 =A0160 =A0 =A0 7730 =A0 =A0 =A0170 =A0 =A0 5090 =A0 =A0 =A017=
0 =A0 =A0 5090 =A0 =A0 =A0160 =A0 =A0 5090 =A0 =A0 =A0170 =A0 =A0 5090 =
=A0 =A0 =A0170
> ---------------------------------------------------------------------=
------------------------------------------
> 01 - JVC: (38 khz)
> =A0 =A0 8840 =A0 =A0 4370 =A0 =A0 =A0590 =A0 =A0 1600 =A0 =A0 =A0590 =
=A0 =A0 1600 =A0 =A0 =A0590 =A0 =A0 =A0500 =A0 =A0 =A0590 =A0 =A0 =A050=
0 =A0 =A0 =A0590 =A0 =A0 =A0500
> =A0 =A0 =A0590 =A0 =A0 =A0500 =A0 =A0 =A0590 =A0 =A0 =A0510 =A0 =A0 =A0=
590 =A0 =A0 =A0510 =A0 =A0 =A0590 =A0 =A0 =A0500 =A0 =A0 =A0590 =A0 =A0=
 =A0500 =A0 =A0 =A0590 =A0 =A0 =A0500
> =A0 =A0 =A0590 =A0 =A0 1600 =A0 =A0 =A0590 =A0 =A0 =A0500 =A0 =A0 =A0=
590 =A0 =A0 1600 =A0 =A0 =A0590 =A0 =A0 =A0500 =A0 =A0 =A0590 =A0 =A0 =A0=
500 =A0 =A0 =A0590 =A0 =A025730
> ---------------------------------------------------------------------=
------------------------------------------
> 07 - Sony (SIRC): (40 khz)
> =A0 =A0 2550 =A0 =A0 =A0600 =A0 =A0 1260 =A0 =A0 =A0600 =A0 =A0 =A063=
0 =A0 =A0 =A0600 =A0 =A0 =A0630 =A0 =A0 =A0600 =A0 =A0 1260 =A0 =A0 =A0=
600 =A0 =A0 =A0630 =A0 =A0 =A0600
> =A0 =A0 =A0630 =A0 =A0 =A0600 =A0 =A0 =A0630 =A0 =A0 =A0600 =A0 =A0 1=
260 =A0 =A0 =A0600 =A0 =A0 =A0630 =A0 =A0 =A0600 =A0 =A0 =A0630 =A0 =A0=
 =A0600 =A0 =A0 =A0630 =A0 =A0 =A0600
> =A0 =A0 =A0630 =A0 =A027450 =A0 =A0<rep>
> ---------------------------------------------------------------------=
------------------------------------------
> 19 - MOTOROLLA:
> =A0 =A0 =A0610 =A0 =A0 2730 =A0 =A0 =A0550 =A0 =A0 =A0550 =A0 =A0 =A0=
580 =A0 =A0 =A0520 =A0 =A0 =A0580 =A0 =A0 =A0520 =A0 =A0 =A0580 =A0 =A0=
 =A0490 =A0 =A0 =A0600 =A0 =A0 =A0520
> =A0 =A0 =A0580 =A0 =A0 =A0520 =A0 =A0 =A0580 =A0 =A0 =A0520 =A0 =A0 =A0=
580 =A0 =A0 =A0520 =A0 =A0 =A0580 =A0 =A0 =A0520 =A0 =A0 =A0580 =A0 =A0=
21240
>
> =A0 =A0 (600 =A0 =A0 2720 =A0 =A0 =A0580 =A0 =A0 1070 =A0 =A0 =A0580 =
=A0 =A0 =A0520 =A0 =A0 =A0580 =A0 =A0 =A0520 =A0 =A0 =A0580 =A0 =A0 =A0=
520 =A0 =A0 1130 =A0 =A0 1070
> =A0 =A0 =A0580 =A0 =A0 =A0490 =A0 =A0 =A0580 =A0 =A0 =A0540 =A0 =A0 =A0=
550 =A0 =A0 =A0540 =A0 =A0 =A0580 =A0 126890)
> ---------------------------------------------------------------------=
------------------------------------------
> 06 - Sharp (denon): (38 khz)
> =A0 =A0 =A0370 =A0 =A0 1870 =A0 =A0 =A0340 =A0 =A0 =A0750 =A0 =A0 =A0=
340 =A0 =A0 =A0760 =A0 =A0 =A0340 =A0 =A0 =A0750 =A0 =A0 =A0340 =A0 =A0=
 =A0750 =A0 =A0 =A0340 =A0 =A0 =A0750
> =A0 =A0 =A0340 =A0 =A0 1870 =A0 =A0 =A0340 =A0 =A0 =A0750 =A0 =A0 =A0=
340 =A0 =A0 1870 =A0 =A0 =A0340 =A0 =A0 =A0760 =A0 =A0 =A0340 =A0 =A0 =A0=
760 =A0 =A0 =A0340 =A0 =A0 =A0760
> =A0 =A0 =A0340 =A0 =A0 =A0760 =A0 =A0 =A0340 =A0 =A0 1870 =A0 =A0 =A0=
340 =A0 =A0 =A0750 =A0 =A0 =A0340 =A0 =A048940
>
> =A0 =A0 =A0370 =A0 =A0 1870 =A0 =A0 =A0340 =A0 =A0 =A0750 =A0 =A0 =A0=
340 =A0 =A0 =A0760 =A0 =A0 =A0340 =A0 =A0 =A0760 =A0 =A0 =A0340 =A0 =A0=
 =A0750 =A0 =A0 =A0340 =A0 =A0 1870
> =A0 =A0 =A0340 =A0 =A0 =A0750 =A0 =A0 =A0340 =A0 =A0 1870 =A0 =A0 =A0=
340 =A0 =A0 =A0760 =A0 =A0 =A0340 =A0 =A0 1870 =A0 =A0 =A0340 =A0 =A0 1=
870 =A0 =A0 =A0340 =A0 =A0 1870
> =A0 =A0 =A0340 =A0 =A0 1870 =A0 =A0 =A0340 =A0 =A0 =A0760 =A0 =A0 =A0=
340 =A0 =A0 1870 =A0 =A0 =A0340 =A0 =A044610
> ---------------------------------------------------------------------=
------------------------------------------
> 30 - Nokia NRC17:
> =A0 =A0 =A0580 =A0 =A0 2590 =A0 =A0 =A0550 =A0 =A0 =A0990 =A0 =A0 110=
0 =A0 =A0 =A0490 =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0 =A0=
480 =A0 =A0 =A0550 =A0 =A0 =A0480
> =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0 =A0490 =A0 =A0 =A0=
550 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0=
 =A0490 =A0 =A0 =A0550 =A0 =A0 =A0480
> =A0 =A0 =A0550 =A0 =A0 =A0490 =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0=
550 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0=
20230
>
> =A0 =A0 =A0580 =A0 =A0 2580 =A0 =A0 =A0560 =A0 =A0 =A0990 =A0 =A0 =A0=
550 =A0 =A0 =A0490 =A0 =A0 1100 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0 =A0=
990 =A0 =A0 =A0550 =A0 =A0 =A0480
> =A0 =A0 =A0550 =A0 =A0 =A0490 =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0=
550 =A0 =A0 =A0480 =A0 =A0 1100 =A0 =A0 =A0990 =A0 =A0 1100 =A0 =A0 =A0=
490 =A0 =A0 =A0550 =A0 =A0 =A0990
> =A0 =A0 1100 =A0 =A0 =A0990 =A0 =A0 =A0550 =A0 =A084380
>
> =A0 =A0 =A0580 =A0 =A0 2580 =A0 =A0 =A0550 =A0 =A0 =A0990 =A0 =A0 =A0=
550 =A0 =A0 =A0490 =A0 =A0 1100 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0 =A0=
990 =A0 =A0 =A0550 =A0 =A0 =A0490
> =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0550 =A0 =A0 =A0480 =A0 =A0 =A0=
550 =A0 =A0 =A0480 =A0 =A0 1100 =A0 =A0 =A0990 =A0 =A0 1100 =A0 =A0 =A0=
480 =A0 =A0 =A0550 =A0 =A0 =A0990
> =A0 =A0 1100 =A0 =A0 =A0990 =A0 =A0 =A0550 =A0 =A084380
> ---------------------------------------------------------------------=
------------------------------------------
> 03 - Mitsubishi:
> =A0 =A0 =A0350 =A0 =A0 2220 =A0 =A0 =A0320 =A0 =A0 2220 =A0 =A0 =A032=
0 =A0 =A0 2220 =A0 =A0 =A0320 =A0 =A0 =A0950 =A0 =A0 =A0320 =A0 =A0 =A0=
950 =A0 =A0 =A0340 =A0 =A0 =A0920
> =A0 =A0 =A0320 =A0 =A0 2220 =A0 =A0 =A0320 =A0 =A0 =A0950 =A0 =A0 =A0=
320 =A0 =A0 2220 =A0 =A0 =A0320 =A0 =A0 =A0950 =A0 =A0 =A0350 =A0 =A0 =A0=
920 =A0 =A0 =A0320 =A0 =A0 2220
> =A0 =A0 =A0320 =A0 =A0 =A0950 =A0 =A0 =A0320 =A0 =A0 =A0950 =A0 =A0 =A0=
320 =A0 =A0 =A0950 =A0 =A0 =A0320 =A0 =A0 =A0950 =A0 =A0 =A0320 =A0 =A0=
27630 =A0 =A0 =A0<rep>
> ---------------------------------------------------------------------=
------------------------------------------
> 04 - Panasonic:
> =A0 =A0 3600 =A0 =A0 3460 =A0 =A0 =A0950 =A0 =A0 =A0820 =A0 =A0 =A096=
0 =A0 =A0 =A0820 =A0 =A0 =A0950 =A0 =A0 =A0820 =A0 =A0 =A0950 =A0 =A0 =A0=
820 =A0 =A0 =A0950 =A0 =A0 =A0820
> =A0 =A0 =A0960 =A0 =A0 2570 =A0 =A0 =A0960 =A0 =A0 =A0820 =A0 =A0 =A0=
950 =A0 =A0 =A0820 =A0 =A0 =A0950 =A0 =A0 2580 =A0 =A0 =A0950 =A0 =A0 2=
580 =A0 =A0 =A0950 =A0 =A0 =A0820
> =A0 =A0 =A0950 =A0 =A0 2580 =A0 =A0 =A0950 =A0 =A0 2580 =A0 =A0 =A095=
0 =A0 =A0 2580 =A0 =A0 =A0950 =A0 =A0 2580 =A0 =A0 =A0950 =A0 =A0 2580 =
=A0 =A0 =A0950 =A0 =A0 =A0820
> =A0 =A0 =A0950 =A0 =A0 2580 =A0 =A0 =A0950 =A0 =A0 2580 =A0 =A0 =A096=
0 =A0 =A0 =A0820 =A0 =A0 =A0960 =A0 =A0 =A0820 =A0 =A0 =A0950 =A0 =A0 2=
570 =A0 =A0 =A0960 =A0 =A039070
> =A0 =A0 =A0<rep>
> ---------------------------------------------------------------------=
------------------------------------------
> 11 - Panasonic:
> =A0 =A0 3700 =A0 =A0 1780 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A050=
0 =A0 =A0 1320 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0=
410 =A0 =A0 =A0490 =A0 =A0 =A0410
> =A0 =A0 =A0500 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0=
490 =A0 =A0 =A0410 =A0 =A0 =A0500 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0=
 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410
> =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0=
490 =A0 =A0 1320 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0500 =A0 =A0 =A0=
410 =A0 =A0 =A0490 =A0 =A0 =A0410
> =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0=
500 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0=
 =A0410 =A0 =A0 =A0500 =A0 =A0 =A0410
> =A0 =A0 =A0490 =A0 =A0 1320 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0=
490 =A0 =A0 =A0410 =A0 =A0 =A0500 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0=
 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410
> =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0=
490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 1320 =A0 =A0 =A0500 =A0 =A0 =A0=
410 =A0 =A0 =A0490 =A0 =A0 =A0410
> =A0 =A0 =A0490 =A0 =A0 1320 =A0 =A0 =A0500 =A0 =A0 1310 =A0 =A0 =A050=
0 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0=
410 =A0 =A0 =A0490 =A0 =A0 1320
> =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0490 =A0 =A0 =A0410 =A0 =A0 =A0=
490 =A0 =A0 1320 =A0 =A0 =A0490 =A0 =A0 1320 =A0 =A0 =A0490 =A0 =A0 =A0=
410 =A0 =A0 =A0490 =A0 =A0 =A0410
> =A0 =A0 =A0490 =A0 =A0 1320 =A0 =A0 =A0500 =A0 =A0<rep>
> ---------------------------------------------------------------------=
------------------------------------------
> 05 - unknown:
> =A0 =A020950 =A0 =A0 4110 =A0 =A0 =A0620 =A0 =A0 1990 =A0 =A0 =A0590 =
=A0 =A0 2020 =A0 =A0 =A0580 =A0 =A0 2020 =A0 =A0 =A0580 =A0 =A0 2020 =A0=
 =A0 =A0590 =A0 =A0 =A0980
> =A0 =A0 =A0580 =A0 =A0 =A0980 =A0 =A0 =A0580 =A0 =A0 2020 =A0 =A0 =A0=
590 =A0 =A0 2020 =A0 =A0 =A0580 =A0 =A0 =A0980 =A0 =A0 =A0580 =A0 =A0 =A0=
980 =A0 =A0 =A0590 =A0 =A0 =A0980
> =A0 =A0 =A0590 =A0 =A0 =A0980 =A0 =A0 =A0580 =A0 =A0 =A0980 =A0 =A0 =A0=
580 =A0 =A0 =A0980 =A0 =A0 =A0580 =A0 =A0 =A0980 =A0 =A0 =A0580 =A0 =A0=
 =A0980 =A0 =A0 =A0580 =A0 =A0 2020
> =A0 =A0 =A0580 =A0 =A0 2020 =A0 =A0 =A0590 =A0 =A0 =A0980 =A0 =A0 =A0=
580 =A0 =A0 =A0980 =A0 =A0 =A0580 =A0 =A0 2020 =A0 =A0 =A0590 =A0 =A0 2=
020 =A0 =A0 =A0580 =A0 =A0 2020
> =A0 =A0 =A0580 =A0 =A0 2020 =A0 =A0 1070
> ---------------------------------------------------------------------=
------------------------------------------
> 09 - unknown:
> =A0 =A0 =A0590 =A0 =A0 =A0480 =A0 =A0 =A0560 =A0 =A0 4230 =A0 =A0 =A0=
560 =A0 =A0 =A0480 =A0 =A0 =A0560 =A0 =A0 4230 =A0 =A0 =A0560 =A0 =A0 5=
260 =A0 =A0 =A0560 =A0 =A0 5260
> =A0 =A0 =A0560 =A0 =A0 =A0480 =A0 =A0 =A0560 =A0 =A0 4230 =A0 =A0 =A0=
560 =A0 =A0 5260 =A0 =A0 =A0560 =A0 =A0 =A0480 =A0 =A0 =A0560 =A0 =A0 4=
220 =A0 =A0 =A0560 =A0 =A0 5260
> =A0 =A0 =A0560 =A0 =A0 =A0480 =A0 =A0 =A0560 =A0 =A0 4220 =A0 =A0 =A0=
560 =A0 =A0 5260 =A0 =A0 =A0560 =A0 =A0 =A0480 =A0 =A0 =A0560 =A0 12645=
0 =A0 =A0<rep>
> ---------------------------------------------------------------------=
------------------------------------------
> 12 - RCA?
> =A0 =A0 4740 =A0 =A0 4650 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0620 =
=A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 =A0550 =
=A0 =A0 =A0610 =A0 =A0 =A0550
> =A0 =A0 =A0610 =A0 =A0 =A0550 =A0 =A0 =A0610 =A0 =A0 =A0550 =A0 =A0 =A0=
620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 1=
720 =A0 =A0 =A0620 =A0 =A0 1720
> =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0=
620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0=
 =A0550 =A0 =A0 =A0620 =A0 =A0 1720
> =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0=
610 =A0 =A0 =A0550 =A0 =A0 =A0610 =A0 =A0 1730 =A0 =A0 =A0610 =A0 =A0 =A0=
550 =A0 =A0 =A0610 =A0 =A0 =A0550
> =A0 =A0 =A0610 =A0 =A0 =A0550 =A0 =A0 =A0620 =A0 =A0 =A0550 =A0 =A0 =A0=
620 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 172=
0 =A0 =A0 =A0620 =A0 =A0 =A0550
> =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A0620 =A0 =A0 1720 =A0 =A0 =A062=
0 =A0 =A0 1720 =A0 =A0 =A0620
> ---------------------------------------------------------------------=
------------------------------------------
> 26 - junk -(thomson) - unsuppored/no carrier
> 27 - junk -(unknown) - unsuppored/no carrier
> 28 - junk -ITT =A0- unsuppored/no carrier
>
>
>
>
>
>>
>
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
