From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC v2] Another approach to IR
Date: Thu, 3 Dec 2009 00:18:54 -0500
Message-ID: <9e4733910912022118h28058f4dt2815c3da4f717b02@mail.gmail.com>
References: <4B155288.1060509@redhat.com> <4B16614A.3000208@redhat.com>
	 <20091202171059.GC17839@core.coreip.homeip.net>
	 <9e4733910912020930t3c9fe973k16fd353e916531a4@mail.gmail.com>
	 <4B16BE6A.7000601@redhat.com>
	 <20091202195634.GB22689@core.coreip.homeip.net>
	 <2D11378A-041C-4B56-91FF-3E62F5F19753@wilsonet.com>
	 <9e4733910912021620s7a2b09a8v88dd45eef38835a@mail.gmail.com>
	 <Pine.LNX.4.58.0912021827120.4729@shell2.speakeasy.net>
	 <5FED031C-C24B-4F82-9621-EB1C8A5B928B@wilsonet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:53841 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbZLCFSt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 00:18:49 -0500
In-Reply-To: <5FED031C-C24B-4F82-9621-EB1C8A5B928B@wilsonet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jarod Wilson <jarod@redhat.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Devin Heitmueller <dheitmueller@kernellabs.com>, Maxim Levitsky <maximlevitsky@gmail.com>, awalls@radix.net, j@jannau.net, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, superm1@ubuntu.com, Christoph Bartelmus <lirc@bartelmus.de>

On Wed, Dec 2, 2009 at 11:13 PM, Jarod Wilson <jarod@wilsonet.com> wrot=
e:
> On Dec 2, 2009, at 9:48 PM, Trent Piepho wrote:
> ...
>>>>> Now I understand that if 2 remotes send completely identical sign=
als we
>>>>> won't be able to separate them, but in cases when we can I think =
we
>>>>> should.
>>>>
>>>> I don't have a problem with that, if its a truly desired feature. =
=A0But
>>>> for the most part, I don't see the point. =A0Generally, you go fro=
m
>>>> having multiple remotes, one per device (where "device" is your TV=
,
>>>> amplifier, set top box, htpc, etc), to having a single universal r=
emote
>>>> that controls all of those devices. =A0But for each device (IR rec=
eiver),
>>>> *one* IR command set. =A0The desire to use multiple distinct remot=
es with
>>>> a single IR receiver doesn't make sense to me. =A0Perhaps I'm just=
 not
>>>> creative enough in my use of IR. =A0:)
>>
>> Most universal remotes I'm familiar with emulate multiple remotes. =A0=
I.e.
>> my tv remote generates one set of scancodes for the numeric keys. =A0=
The DVD
>> remote generates a different set. =A0The amplifier remote in "tv mod=
e"
>> generates the same codes as the tv remote, and in "dvd mode" the sam=
e codes
>> as the dvd remote. =A0From the perspective of the IR receiver there =
is no
>> difference between having both the DVD and TV remotes, or using the
>> aplifier remote to control both devices.
>
> Okay, in the above scenario, you've still got a single input device..=
=2E
>
>> Now, my aplifier remote has a number of modes. =A0Some control devic=
es I
>> have, like "vcr mode", and there is nothing I can do about that. =A0=
Some,
>> like "md mode" don't control devices I have. =A0That means they are =
free to
>> do things on the computer. =A0Someone else with the same remote (or =
any
>> number of remotes that use the same protocol and scancodes) might ha=
ve
>> different devices.
>>
>> So I want my computer to do stuff when I push "JVC MD #xx" keys, but=
 ignore
>> "JVC VCR #yyy" yets. =A0Someone with an MD player and not a VCR woul=
d want to
>> opposite. =A0Rather than force everyone to create custom keymaps, it=
's much
>> easier if we can use the standard keymaps from a database of common =
remotes
>> and simply tell mythtv to only use remote #xxx or not to use remote =
#yyy.
>
> Sure, but the key is that this can't be done automagically. The IR dr=
iver has no way of knowing that user A wants JVC MD keys handled and JV=
C VCR keys ignored, and user B wants vice versa, while user C wants bot=
h ignored, etc. This is somewhat tangential to whether or not there's a=
 separate input device per "remote" though. You can use multiple remote=
s/protocols with a single input device or lirc device already (if the h=
ardware doesn't have to be put explicitly into a mode to listen for tha=
t proto, of course, but then its a hardware decoding device feeding a s=
ingle input device anyway, so...).
>
>> It sounds like you're thinking of a receiver that came bundled with =
a
>> remote and that's it. =A0Not someone with a number of remotes that c=
ame with
>> different pieces of AV gear that they want to use with their compute=
r.
>
> No, I just pick *one* remote and use it for everything, not schizophr=
enically hopping from one remote to another, expecting them all the be =
able to control everything. :) Its a hell of a lot easier to find butto=
ns w/o looking at the remote if you always use the same one for everyth=
ing, for one.
>
> Anyway, I think I'm talking myself in circles. Supporting multiple re=
motes via multiple input devices (or even via a single input device) is=
n't at all interesting to me for my own use, but if there really is dem=
and for such support (and it appears there is), then fine, lets do it.

Simple use case:

You have a multifunction remote. Press the CABLE key - it sends out
commands that control the cable box, press the TV key - now the
commands control the TV, press CD - now the CD player, etc.

Now imagine a headless Linux box running a music server and a home
automation app. Press the CD key - commands get routed to the music
server, press the AUX key - commands get routed to the home automation
app.

This is accomplished by recognizing the device code part of the IR
signal and figuring out that there are two different device codes in
use. The commands of then routed to two evdev devices corresponding to
the two different device codes.

Using things like Alt-Tab to switch apps is impossible. There's no
screen to look at.

>
> --
> Jarod Wilson
> jarod@wilsonet.com
>
>
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
