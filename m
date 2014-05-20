From: Roland Bosa <rbosa@logitech.com>
Subject: Re: [PATCH v4 01/24] input: Add ff-memless-next module
Date: Tue, 20 May 2014 14:38:43 -0700
Message-ID: <537BCB63.1020200@logitech.com>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net> <2965006.XKYHWj9YzJ@sigyn> <537B9FAE.9070602@logitech.com> <10859911.6zyzadbfH9@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:53356 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868AbaETVis (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2014 17:38:48 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so699182pbb.7
        for <linux-input@vger.kernel.org>; Tue, 20 May 2014 14:38:48 -0700 (PDT)
In-Reply-To: <10859911.6zyzadbfH9@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

On 05/20/2014 12:00 PM, Michal Mal=FD wrote:
> Hi,
>=20
> "ff-memless-next" was designed with behavior of Logitech devices in m=
ind,=20
> however it was always meant as a general replacement for the current =
"ff-
> memless". After some followup discussion it's unlikely that it will b=
e=20
> mainlined in its current form. See the discussion here=20
> "http://www.spinics.net/lists/linux-input/msg31426.html" for more det=
ails.
>=20
> We would however really appreciate some information regarding Logitec=
h devices=20
> specifically. Although we have reverse engineered most of things, I b=
elieve=20
> there are still areas we're not entirely clear about. I realize that =
you'd=20
> probably have to take it up with the legal deparment but if someone a=
t=20
> Logitech could at least take a look at what we've found so far at fil=
l in the=20
> blanks it'd be most helpful.

I'm your guy, then. Please send any questions my way and I'll dig out
the information you need - with the lawyer's blessings, if need be.

> Please note that we found numerous bugs and DirectInput specs violati=
ons in=20
> the Windows driver which might have impacted our understading of how =
the=20
> driver works. "ff-memless-next" and "lg4ff" tries to fix or work arou=
nd these. A=20
> link to out-of-tree update to lg4ff which takes full advantage of "ff=
-memless-
> next" is also provided in this thread.

lg4ff is mostly wheels, from what I saw. We should be able to fold in
the G940 (Flight System) as well as other joysticks into the same
driver. The underlying model driving the forces of our devices is
essentially the same, there are just slight improvements made over the
years to accommodate higher resolutions and more powerful micro process=
ors.

Each device has a unique number (say 2 or 4) of force 'slots' per axis,
which is running a force calculation in firmware. Typically, one of
these slots is allocated by the host driver for a constant force, that'=
s
streamed to the device (and comprises all constant and periodic forces
sent by the 'game' - that's the combined type of your code, as far as I
can tell). The other slot may be used for position-based effects
(springs, centering spring) as well as velocity-based effects (dampers,
friction) - that's the un-combinable type. There's a healthy amount of
code in the Windows driver that you would call 'quirks' which deals wit=
h
deciding how to allocate multiple springs and dampers to a single slot.
Sometimes, even the springs and dampers are being streamed in via the
constants force, but that requires (as you pointed out earlier) a fast
update rate and some "smartness" (I'm getting in hot territory with the
lawyers now - let me stop).

One of the key features of the design is the decoupling of the USB
updates from the force feedback IOCTL's from the 'game'. I don't think
this is currently the case with today's drivers. I was able to send
force updates to a gamepad faster than the USB update rate, which led t=
o
some lost packets which in turn left the device in a inconsistent state
- the motors were still rumbling although they should have stopped. If
the 'ff-memless-next' driver offers this decoupling, it is a step in th=
e
right direction, IMO.

I will try to apply the patch mentioned in this thread and see where it
leads me...

Thanks
roland

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
