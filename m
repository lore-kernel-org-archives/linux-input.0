From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Fri, 7 Aug 2015 15:26:39 +0200
Message-ID: <20150807132639.GB21627@pali>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37237 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbbHGN0l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 09:26:41 -0400
Received: by wibhh20 with SMTP id hh20so65935023wib.0
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2015 06:26:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ari Entlich <atrigent@gmail.com>
Cc: linux-input@vger.kernel.org

On Thursday 06 August 2015 07:07:19 Ari Entlich wrote:
> Hello!
>=20
> I'm an owner of a Thinkpad T440p, and was always unhappy with the
> buttonless trackpad. I was ecstatic when I learned that trackpads fro=
m
> the 50 series laptops, with buttons, are compatible with 40 series
> laptops. I have since performed this mod, and all of the hardware
> seems to be working.
>=20
> The only problem I've been having is a software one. It seems that th=
e
> trackpad and trackpoint are usually arranged such that the trackpoint
> is "behind" the trackpad and all communication with the trackpoint
> goes through the trackpad. This allows the trackpad to provide an
> abstraction of the trackpoint for OSes that don't explicitly support
> it.
>=20
> With my old trackpad, which was a Synaptics device, Linux would detec=
t
> the trackpoint as its own device with the TPPS/2 protocol. It seems
> that it was able to do this because the Synaptics driver has support
> for a "pass-through port" which allows the OS to send commands
> directly to the trackpoint. However, the new trackpad that I received
> is an ALPS v7 device. I see some references to passthrough support in
> drivers/input/mouse/alps.c, but it doesn't appear to be used in the
> same way as it is in the Synaptics driver and doesn't seem to be
> supported at all for v7 devices. Therefore, instead of showing up as
> its own special device, the trackpoint shows up as a "DualPoint
> Stick". In general this is fine, because the trackpoint works.
> However, the dedicated trackpoint driver allows you to modify a few
> trackpoint-specific hardware settings, most notably the sensitivity.
> This was much more of an issue before this:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D088df2ccef75754cc16a6ba31829d23bcb2b68ed
> commit, but I still think it would be nice to be able to control my
> hardware as much as possible.
>=20
> Interestingly, I've been able to find very little discussion of this
> limitation of the ALPS driver. Here are the few links that I've been
> able to find:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D8864 (comment 24 seems
> especially relevant)
> https://bugzilla.redhat.com/show_bug.cgi?id=3D483224
> http://www.spinics.net/lists/xorg/msg49549.html
> http://thinkpad-forum.de/threads/185025-T*50-Clickpad-in-T*40-Trackpo=
int-Konfiguration
> (German)
>=20
> Since the trackpad that I received is from some Thinkpad model (I
> don't know which one though), there presumably should be other 50
> series Thinkpad users who are affected by this same issue. It could
> just be that the number of people with the right device who use Linux
> and want to adjust the hardware sensitivity and care enough to post
> about it online is essentially zero, but I've had a hard time
> convincing myself of this.
>=20
> Comment 24 in the first link states that ALPS has been unwilling to
> share the secret to the passthrough port for their hardware. However,
> this comment is 8 years old, so I'm hoping things have changed. The
> second and third links seem to be describing approximately the same
> problem, with one difference being that disabling the trackpad in the
> BIOS does not cause the trackpoint driver to be used for me - it only
> causes the trackpad device to stop emitting events. Perhaps this is
> because the buttons are now part of the trackpad device, or maybe it'=
s
> just because this is a non-standard mod. The fourth link seems to be
> describing the exact problem that I'm having, however my ability to
> read German is only as good as Google Translate ability to translate
> it.
>=20
> If there's anything that I can do to help get this implemented, pleas=
e
> let me know. I'd even be willing to try and figure out how the Window=
s
> driver does this, if that becomes necessary.
>=20
> Also: I am aware that sensitivity/speed/acceleration/whatever can be
> adjusted somewhat through libinput settings. That is not what I'm
> asking about, so please don't suggest it. :)
>=20
> Thanks!
>=20
> Ari
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

Hello,

ALPS devices does not support pass-throw mode like Synaptics devices.
But our ALPS driver is good and can detect packet from device contains
data for touchpad or trackpoint. So ALPS driver create two input device=
s
and send events to userspace via correct input device and userspace see
that there are two different devices (touchpad and trackstick) and not
one "combined".

Looks like that ALPS devices does not support any speed or acceleration
configuration, so everything needs to be implemented in software -- in
userspace. X drivers already have such configuration ether via xorg.con=
f
or runtime via xinput. Speed or acceleration can be configured per inpu=
t
device, so this is something which you probably want.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
