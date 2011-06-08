From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs
 settings
Date: Wed, 8 Jun 2011 11:20:54 +0200
Message-ID: <20110608112054.1521ada7.ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	<1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
	<1304644488.16101.28.camel@novo.hadess.net>
	<20110507011412.ba0ad1e9.ospite@studenti.unina.it>
	<1304787442.2427.11.camel@novo.hadess.net>
	<20110603135904.096660bc.ospite@studenti.unina.it>
	<1307114762.2669.125.camel@novo.hadess.net>
	<d49388493b61c568c5ce7cd2ae9594e0.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Jun_2011_11_20_54_+0200_VwtHY.IJX8PwcqZT"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:58753 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab1FHJVE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Jun 2011 05:21:04 -0400
In-Reply-To: <d49388493b61c568c5ce7cd2ae9594e0.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

--Signature=_Wed__8_Jun_2011_11_20_54_+0200_VwtHY.IJX8PwcqZT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jun 2011 11:56:38 -0400
simon@mungewell.org wrote:

> Just generally on this subject, should the code which performs the USB
> 'write' be in 'hid-sony.c' rather than the BT core.
>
> It's possible that the Sixaxis or other compatible controllers will be
> only USB connected and BT might not even exist on the system.
>
> If/When I manage to do some work on rumble support, we will probably need
> to ensure that a 'hid-sonyff.c' is aware of any LED settings otherwise it
> might overwrite them when setting the rumble.
>

About leds: in order to decide which leds to set in a meaningful way we
need to know the X in /dev/input/jsX, and udev is the only way I know
to find that out, so either in a bluez plugin or in a standalone
daemon I think the answer is in userspace.

About knowing the led status, I have to check if we can read the led
settings out of the device after we have set them in the HID Output
Report, that's a good point.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__8_Jun_2011_11_20_54_+0200_VwtHY.IJX8PwcqZT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3vPvYACgkQ5xr2akVTsAHDogCfU52STS1bSRsY/Nepw4BIzcLQ
w/oAoJi675J4Cdtc7b9ohFx2OORJCwJa
=UtZT
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Jun_2011_11_20_54_+0200_VwtHY.IJX8PwcqZT--
