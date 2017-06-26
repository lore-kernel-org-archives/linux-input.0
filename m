From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Spurious touchpad events with closed LID
Date: Mon, 26 Jun 2017 21:09:42 +0200
Message-ID: <201706262109.42628@pali>
References: <201706261854.53970@pali> <20170626170312.GB4965@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2395314.Q036zSJDgZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33406 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdFZTJs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2017 15:09:48 -0400
In-Reply-To: <20170626170312.GB4965@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

--nextPart2395314.Q036zSJDgZ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 26 June 2017 19:03:12 Dmitry Torokhov wrote:
> On Mon, Jun 26, 2017 at 06:54:53PM +0200, Pali Roh=C3=A1r wrote:
> > Hi!
> >=20
> > When I'm using dock with external input devices (keyboard + mouse)
> > and LID is closed, I'm getting spurious touchpad events and random
> > mouse clicks and movements.
> >=20
> > It is because top part of LID is above touchpad and probably
> > generates touch pushes.
> >=20
> > Year (or two?) when I had conversation with ALPS people I was told
> > that Windows driver is automatically turning touchpad off when
> > ACPI LID close event is received (and similarly turn touchpad on).
> >=20
> > Maybe Linux should do similar thing? Random movement or touchpad
> > clicks is really annoying. But I'm not sure if kernel or userspace
> > should do this job... What do you think?
>=20
> It is a matter of policy (deciding when device is "usable") and this
> should be controlled from userspace. Kernel should provide necessary
> knobs for it though. For a long time I was saying that it should be
> done at device core level, but I do not think we will ever get
> there.
>=20
> On ChromeOS input devices export "inhibit" attribute that basically
> overrides open/close count and prevents delivery of events to
> userspace, and power management driver controls this attribute
> together with wake up and others.

Hm... this sounds like a "disable" property for each event device which=20
I was talking about months ago (ccing Pavel). Very similar problem is on=20
Nokia N900, where touchscreen needs to be turned off when screen is=20
locked and phone in pocket.

> This allows us to implement
> policies like "the touchpad should only be active and a wakeup
> source while the device is in laptop mode, but not in tablet or tent
> mode, or when lid is closed", "disable keyboard in tablet mode or
> when list is closed", etc.

Exactly. Userspace receive all needed events and then tell kernel to=20
"mute" input device based on own userspace policies.

> Drivers can also implement inhibit/uninhibit methods that can put
> inhibited devices into lower power mode.

Sounds good. Once events are not delivered to userspace, kernel does not=20
have to receive them too and can power off that input device (if hw=20
support such thing).

> I am not too happy with the
> implementation (I'd like to see if we could merge inhibit/uninhibit
> and open/close), that is why I haven't pushed it upstream yet.

Can you send some links to that implementation/patch series?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2395314.Q036zSJDgZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllRW/YACgkQi/DJPQPkQ1J96wCfU+AikwW5yjNAP4I80aOWxhY4
TbIAn20suagoCF3IolK0s92JT6Kn25CX
=ZVuP
-----END PGP SIGNATURE-----

--nextPart2395314.Q036zSJDgZ--
