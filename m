From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was:
	Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Tue, 8 Dec 2009 10:56:21 -0500
Message-ID: <9e4733910912080756j7e1fac32qc552c6514a307b7d@mail.gmail.com>
References: <BDRae8rZjFB@christoph>
	 <6B4C84CD-F146-4B8B-A8BB-9963E0BA4C47@wilsonet.com>
	 <1260240142.3086.14.camel@palomino.walls.org>
	 <20091208042210.GA11147@core.coreip.homeip.net>
	 <1260275743.3094.6.camel@palomino.walls.org>
	 <4B1E54FF.8060404@redhat.com>
	 <9e4733910912080547j75c2c885o29664470ff5e2c6a@mail.gmail.com>
	 <4B1E5BDF.7010202@redhat.com>
	 <9e4733910912080619t36089c9bg5e54114844b9694a@mail.gmail.com>
	 <4B1E640B.6030705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:42000 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409AbZLHP4P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 10:56:15 -0500
In-Reply-To: <4B1E640B.6030705@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Andy Walls <awalls@radix.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jarod Wilson <jarod@wilsonet.com>, Krzysztof Halasa <khc@pm.waw.pl>, Christoph Bartelmus <lirc@bartelmus.de>, j@jannau.net, jarod@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com

On Tue, Dec 8, 2009 at 9:34 AM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Jon Smirl wrote:
>> On Tue, Dec 8, 2009 at 8:59 AM, Mauro Carvalho Chehab
>> <mchehab@redhat.com> wrote:
>>> Jon Smirl wrote:
>>>> On Tue, Dec 8, 2009 at 8:30 AM, Mauro Carvalho Chehab
>>>> <mchehab@redhat.com> wrote:
>>>>> Andy Walls wrote:
>>>>>> On Mon, 2009-12-07 at 20:22 -0800, Dmitry Torokhov wrote:
>>>>>>> On Mon, Dec 07, 2009 at 09:42:22PM -0500, Andy Walls wrote:
>>>>>>>> So I'll whip up an RC-6 Mode 6A decoder for cx23885-input.c be=
fore the
>>>>>>>> end of the month.
>>>>>>>>
>>>>>>>> I can setup the CX2388[58] hardware to look for both RC-5 and =
RC-6 with
>>>>>>>> a common set of parameters, so I may be able to set up the dec=
oders to
>>>>>>>> handle decoding from two different remote types at once. =A0Th=
e HVR boards
>>>>>>>> can ship with either type of remote AFAIK.
>>>>>>>>
>>>>>>>> I wonder if I can flip the keytables on the fly or if I have t=
o create
>>>>>>>> two different input devices?
>>>>>>>>
>>>>>>> Can you distinguish between the 2 remotes (not receivers)?
>>>>>> Yes. =A0RC-6 and RC-5 are different enough to distinguish betwee=
n the two.
>>>>>> (Honestly I could pile on more protocols that have similar pulse=
 time
>>>>>> periods, but that's complexity for no good reason and I don't kn=
ow of a
>>>>>> vendor that bundles 3 types of remotes per TV card.)
>>>>> You'll be distinguishing the protocol, not the remote. If I under=
stood
>>>>> Dmitry's question, he is asking if you can distinguish between tw=
o different
>>>>> remotes that may, for example, be using both RC-5 or both RC-6 or=
 one RC-5
>>>>> and another RC-6.
>>>> RC-5 and RC-6 both contain an address field. =A0My opinion is that
>>>> different addresses represent different devices and in general the=
y
>>>> should appear on an input devices per address.
>>> The same IR can produce two different addresses. The IR bundled wit=
h my satellite
>>> STB produces two different codes, depending if you previously press=
ed <TV> or <SAT>
>>> key (in fact, I think it can even produce different protocols for T=
V, as it can
>>> be configured to work with different TV sets).
>>
>> You have a multi-function remote.
>
> Yes.
>
>> That's why those keys don't send codes. When writing code you should
>> think of this remote as being two indpendent virtual remotes, not a
>> single one.
>
> Not really. I may think on it as a single device and use the two grou=
ps
> of functions to control two aspects at the same application.
>
> For example, I may map the <TV> group on kaffeine for DVB reception a=
nd the
> <SAT> group for DVD (well, probably, in this case, I'll use an IR wit=
h
> <TV> and <DVD> keys, instead ;) ).
>
>> By using maps containing the two different addresses for <TV> and
>> <SAT> you can split these commands onto two different evdev devices.
>
> True. I can do it, but I can opt to have both mapped as one evdev dev=
ice as well.
> This will basically depend on how I want to mount my environment.
>
>> This model is complicated by the fact that some remotes that look li=
ke
>> multi-function remotes aren't really multifunction. The remote bundl=
ed
>> with the MS MCE receiver is one. That remote is a single function
>> device even though it has function buttons for TV, Music, Pictures,
>> etc.
>
> It is very common to have such remotes bundled with multimedia device=
s.
>
> An unsolved question on my mind is how should we map such IR's? Shoul=
d we
> provide a way for them to emulate a multifunction IR (for example, af=
ter pressing
> TV key, subsequent keystrokes would be directed to the TV evdev devic=
e?), or
> should we let this up to some userspace app to handle this case?

Splitting them into multiple devices requires remembering state and
scripting so it needs to be done in user space. If the user wants to
control a radio app and a home automation app they need to choose.
Keep the bundled remote and do some non-trivial scripting or buy a
universal remote.

Universal remotes make it much easier to achieve "just works".

The IR core can contain default universal profiles for various classes
of devices. Say Morotola_DVR and SciAtlanta_DVR. The core would check
if the receiver is cable of receiving these profiles before loading
them. There would be ten of these default universal profiles at most
and you can unload them from RAM if they aren't needed.

Now Myth can have a menu with three remote choices:
 Universal Morotola_DVR
 Universal SciAtlanta_DVR
 Bundled

The Bundled choice came from the map built into the IR receiver's devic=
e driver.
The other two choices were loaded by the IR core after ensuring that
the hardware could receive from a universal remote.

The core would also load a couple of default radio profiles
 Univeral SonyDR112_RADIO
 Univeral OnkyoTX8255_RADIO
Same for automation and mouse/keyboard emulation.

Myth looks in sysfs and builds a menu containing DVR devices and all
bundled entries. First app to open the "Bundled" device gets to keep
it.

These apps could take "just works" even farther. When they start up
they could listen on all three evdev devices:  Morotola_DVR,
SciAtlanta_DVR,   Bundled. And then if you find Myth responding to
unwanted commands you could disable the unwanted profiles by
deselecting them in the Myth UI.

All of this may seem complicated to build, but the purpose is to
create an environment where a non-technical user can get an IR remote
working without needing detailed knowledge about how IR protocols
work.







--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
