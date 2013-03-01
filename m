From: Julian Squires <julian@cipht.net>
Subject: Re: wacom serial tablet support
Date: Fri, 01 Mar 2013 09:19:04 -0500
Message-ID: <877glri4o7.fsf@sliver.cipht.net>
References: <878v6axv7t.fsf@sliver.cipht.net>
	<20130227052335.GA24420@core.coreip.homeip.net>
	<CAF8JNhJKpzkA_S3ebaZa3jDcT1wSbZf59Fqp9-s_KAux7pZviQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51306 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab3CAOTO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Mar 2013 09:19:14 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so3633261ieb.9
        for <linux-input@vger.kernel.org>; Fri, 01 Mar 2013 06:19:14 -0800 (PST)
In-Reply-To: <CAF8JNhJKpzkA_S3ebaZa3jDcT1wSbZf59Fqp9-s_KAux7pZviQ@mail.gmail.com>
	(Ping Cheng's message of "Thu, 28 Feb 2013 18:02:12 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Jason Gerecke <killertofu@gmail.com>, Linux Input <linux-input@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Ping Cheng <pinglinux@gmail.com> writes:
> On Tuesday, February 26, 2013, Dmitry Torokhov wrote:
>> The driver looks quite reasonable, however that would be the 4th Wacom
>> driver in the tree... I wonder if it is time to split out transport
>> parts from core wacom functionality so that it can be shared by USB, I2C
>> and serio devices.

I agree, although I'm not sure how much common code there would actually
be between these devices.  However:

> As for Julian's patch, serial models are more than 10 years old. Last
> serial devices (Intuos2 series) were released in 2001. We stopped
> producing serial devices in 2004 (Intuos3 released then). Whether we
> should add EOL models to upstream is beyond my decision. But, my team
> won't have resources to maintain this driver, that is for sure.

This is the reason I wrote the driver in the first place -- the existing
Wacom driver developers dropped support for serial tablets, which some
people still use (I regularly get email about my driver from users).  I
am only asking to bring this into the mainline because I get asked about
it regularly -- most signicantly, the device needs a serio ID allocated
for it so that users don't have to play whack-a-mole with the IDs being
allocated in the kernel.

I'll take a look at what could be shared between the drivers this
weekend.

Cheers,

=2D-=20
Julian Squires

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlEwuNgACgkQNlfN+A/UCSywCgCgikWytaS0xEJOTcJscWHURJEz
an0AoN9kM9K1a2fSxztXRUpe2v+TMt/q
=du2v
-----END PGP SIGNATURE-----
--=-=-=--
