From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was:
	Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Tue, 8 Dec 2009 13:15:20 -0500
Message-ID: <9e4733910912081015he8b9b63o27ee802dea7adcfc@mail.gmail.com>
References: <BDRae8rZjFB@christoph>
	 <20091208042210.GA11147@core.coreip.homeip.net>
	 <1260275743.3094.6.camel@palomino.walls.org>
	 <4B1E54FF.8060404@redhat.com>
	 <9e4733910912080547j75c2c885o29664470ff5e2c6a@mail.gmail.com>
	 <4B1E5BDF.7010202@redhat.com>
	 <9e4733910912080619t36089c9bg5e54114844b9694a@mail.gmail.com>
	 <4B1E640B.6030705@redhat.com>
	 <9e4733910912080756j7e1fac32qc552c6514a307b7d@mail.gmail.com>
	 <4B1E7E56.80701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:55954 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937077AbZLHSPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 13:15:14 -0500
In-Reply-To: <4B1E7E56.80701@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Andy Walls <awalls@radix.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jarod Wilson <jarod@wilsonet.com>, Krzysztof Halasa <khc@pm.waw.pl>, Christoph Bartelmus <lirc@bartelmus.de>, j@jannau.net, jarod@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com

On Tue, Dec 8, 2009 at 11:27 AM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Jon Smirl wrote:
>> On Tue, Dec 8, 2009 at 9:34 AM, Mauro Carvalho Chehab
>> <mchehab@redhat.com> wrote:
>>> Jon Smirl wrote:
>>>> On Tue, Dec 8, 2009 at 8:59 AM, Mauro Carvalho Chehab
>>>> <mchehab@redhat.com> wrote:
>>>>> Jon Smirl wrote:
>>>>>> On Tue, Dec 8, 2009 at 8:30 AM, Mauro Carvalho Chehab
>>>>>> <mchehab@redhat.com> wrote:
>>>>>>> Andy Walls wrote:
>>>>>>>> On Mon, 2009-12-07 at 20:22 -0800, Dmitry Torokhov wrote:
>>>>>>>>> On Mon, Dec 07, 2009 at 09:42:22PM -0500, Andy Walls wrote:
>>>>>>>>>> So I'll whip up an RC-6 Mode 6A decoder for cx23885-input.c =
before the
>>>>>>>>>> end of the month.
>>>>>>>>>>
>>>>>>>>>> I can setup the CX2388[58] hardware to look for both RC-5 an=
d RC-6 with
>>>>>>>>>> a common set of parameters, so I may be able to set up the d=
ecoders to
>>>>>>>>>> handle decoding from two different remote types at once. =A0=
The HVR boards
>>>>>>>>>> can ship with either type of remote AFAIK.
>>>>>>>>>>
>>>>>>>>>> I wonder if I can flip the keytables on the fly or if I have=
 to create
>>>>>>>>>> two different input devices?
>>>>>>>>>>
>>>>>>>>> Can you distinguish between the 2 remotes (not receivers)?
>>>>>>>> Yes. =A0RC-6 and RC-5 are different enough to distinguish betw=
een the two.
>>>>>>>> (Honestly I could pile on more protocols that have similar pul=
se time
>>>>>>>> periods, but that's complexity for no good reason and I don't =
know of a
>>>>>>>> vendor that bundles 3 types of remotes per TV card.)
>>>>>>> You'll be distinguishing the protocol, not the remote. If I und=
erstood
>>>>>>> Dmitry's question, he is asking if you can distinguish between =
two different
>>>>>>> remotes that may, for example, be using both RC-5 or both RC-6 =
or one RC-5
>>>>>>> and another RC-6.
>>>>>> RC-5 and RC-6 both contain an address field. =A0My opinion is th=
at
>>>>>> different addresses represent different devices and in general t=
hey
>>>>>> should appear on an input devices per address.
>>>>> The same IR can produce two different addresses. The IR bundled w=
ith my satellite
>>>>> STB produces two different codes, depending if you previously pre=
ssed <TV> or <SAT>
>>>>> key (in fact, I think it can even produce different protocols for=
 TV, as it can
>>>>> be configured to work with different TV sets).
>>>> You have a multi-function remote.
>>> Yes.
>>>
>>>> That's why those keys don't send codes. When writing code you shou=
ld
>>>> think of this remote as being two indpendent virtual remotes, not =
a
>>>> single one.
>>> Not really. I may think on it as a single device and use the two gr=
oups
>>> of functions to control two aspects at the same application.
>>>
>>> For example, I may map the <TV> group on kaffeine for DVB reception=
 and the
>>> <SAT> group for DVD (well, probably, in this case, I'll use an IR w=
ith
>>> <TV> and <DVD> keys, instead ;) ).
>>>
>>>> By using maps containing the two different addresses for <TV> and
>>>> <SAT> you can split these commands onto two different evdev device=
s.
>>> True. I can do it, but I can opt to have both mapped as one evdev d=
evice as well.
>>> This will basically depend on how I want to mount my environment.
>>>
>>>> This model is complicated by the fact that some remotes that look =
like
>>>> multi-function remotes aren't really multifunction. The remote bun=
dled
>>>> with the MS MCE receiver is one. That remote is a single function
>>>> device even though it has function buttons for TV, Music, Pictures=
,
>>>> etc.
>>> It is very common to have such remotes bundled with multimedia devi=
ces.
>>>
>>> An unsolved question on my mind is how should we map such IR's? Sho=
uld we
>>> provide a way for them to emulate a multifunction IR (for example, =
after pressing
>>> TV key, subsequent keystrokes would be directed to the TV evdev dev=
ice?), or
>>> should we let this up to some userspace app to handle this case?
>>
>> Splitting them into multiple devices requires remembering state and
>> scripting so it needs to be done in user space.
>
> It shouldn't be hard to do it in kernelspace, since you'll need to ha=
ve
> one evdev interface associated with the IR anyway, but this will add
> some extra complexity at the scancode->keycode conversion, but I'm wa=
ndering
> if we should do it or not.
>
> Maybe the better is to not do it in kernelspace, to avoid adding ther=
e an
> extra complexity that can easily be done in userspace.
>
>> If the user wants to
>> control a radio app and a home automation app they need to choose.
>> Keep the bundled remote and do some non-trivial scripting or buy a
>> universal remote.
>
> Ok, but using the shipped IR even without a separate address group fo=
r
> different applications, and having it controlling radio app and tv ap=
p
> (not simultaneously) should not be hard, but I LIRC already covers su=
ch
> usecase, so maybe we don't need to worry about it.
>
>> Universal remotes make it much easier to achieve "just works".
>
> True.
>
>> The IR core can contain default universal profiles for various class=
es
>> of devices. Say Morotola_DVR and SciAtlanta_DVR. The core would chec=
k
>> if the receiver is cable of receiving these profiles before loading
>> them. There would be ten of these default universal profiles at most
>> and you can unload them from RAM if they aren't needed.
>>
>> Now Myth can have a menu with three remote choices:
>> =A0Universal Morotola_DVR
>> =A0Universal SciAtlanta_DVR
>> =A0Bundled
>>
>> The Bundled choice came from the map built into the IR receiver's de=
vice driver.
>> The other two choices were loaded by the IR core after ensuring that
>> the hardware could receive from a universal remote.
>>
>> The core would also load a couple of default radio profiles
>> =A0Univeral SonyDR112_RADIO
>> =A0Univeral OnkyoTX8255_RADIO
>> Same for automation and mouse/keyboard emulation.
>
> Agreed.
>
>> Myth looks in sysfs and builds a menu containing DVR devices and all
>> bundled entries. First app to open the "Bundled" device gets to keep
>> it.
>
> Myth (or other userspace apps) don't need to to that, since we've sta=
ndardized
> the keycode actions (see the IR chapter of the media DocBook). It jus=
t
> needs to support the keycodes already defined, for the common case.
>
>> These apps could take "just works" even farther. When they start up
>> they could listen on all three evdev devices: =A0Morotola_DVR,
>> SciAtlanta_DVR, =A0 Bundled. And then if you find Myth responding to
>> unwanted commands you could disable the unwanted profiles by
>> deselecting them in the Myth UI.
>
> I don't like the idea of automatically loading 3 different keycodes a=
t the
> same time. You may have overlaps between different keycode tables. Th=
e
> better is to have some userspace GUI that will allow the user to sele=
ct
> what keycode table(s) he want to be available, if he decides to not u=
se the
> bundled IR.

Of course there is going to be overlap of the keycodes, but not the
scancodes. There should be almost 100% overlap.

The three maps are there to support a non-technical user, a
sophisticated user will disable two of them. This works because the
non-technical user is only going to use one of the three IR device
profiles. The other two may be loaded, but the user isn't sending any
IR signals that match their maps.

Where this breaks down is if they are using SciAtlanta_DVR to control
MythTV and they also happen to have a physical Motorola DVR in the
same room. The Linux box is going to pick up the commands meant for
the Motorola DVR and both boxes will respond.. In that cause they will
need to figure figure out how to disable the Motorola DVR profile.
But is a non-technical person likely to have two DVRs in the same
room?

>
> The same applies to applications: if you have 3 keymaps loaded, is be=
cause you
> want do do different things with the 3 keymaps (like using keymap 1 f=
or kaffeine,
> keymap 2 for mplayer, keymap 3 for mythtv).
>
> So, IR-aware applications should have a setup interface to specify wh=
at IR keycodes
> are relevant to that particular application, and how to associate an =
evdev interface
> to an specific group of functions (for applications that supports sev=
eral different
> types of media, like MythTV and Kaffeine, where you'll end by having =
a "TV" keymap/evdev,
> a "Radio" keymap/evdev, a "CD/DVD" Keymap/evdev, etc).
>
> Btw, if we're doing that, IMO, we should have an string sysfs alias a=
ttribute,
> to allow associating the userspace application to an specific keymap =
alias
> (like "radio", "tv", etc.).
>
>> All of this may seem complicated to build, but the purpose is to
>> create an environment where a non-technical user can get an IR remot=
e
>> working without needing detailed knowledge about how IR protocols
>> work.
>
> IMO, this is an important requisite to fulfill.
>
> Cheers,
> Mauro.
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
