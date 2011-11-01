From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 01:18:54 +0100
Message-ID: <20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__1_Nov_2011_01_18_54_+0100_UAwf763W/y_4Z/Ms"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:40289 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934225Ab1KAAYO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Oct 2011 20:24:14 -0400
In-Reply-To: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-input@vger.kernel.org

--Signature=_Tue__1_Nov_2011_01_18_54_+0100_UAwf763W/y_4Z/Ms
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Nov 2011 01:04:37 +0200
Alon Bar-Lev <alon.barlev@gmail.com> wrote:

> Hello,
>=20
> I feel uncomfortable, as people reports that it does work...
> Bluetooth pairing is not working and almost no documentation of
> bluez-4 success....
> So I thought starting in USB will be easier....
>=20
> I am using linux-3.1.0
> When doing cat /dev/input/js0 or cat /dev/input/event15 or usbhid-dump
> I get no activity.
>=20
> Can anyone please help? or acknowledge that it actually work?
> Can I provide more information?

Hi Alon, we were tracking the progress on:

https://bugzilla.kernel.org/show_bug.cgi?id=3D40812

but bugzilla on kernel.org is still down.

The current situation is that it is working but patches needs to be
applied to BlueZ, I copied the mails from the bugzilla reports here in
this file:

http://ao2.it/tmp/sixaxis_discussion_kernel.org_bugzilla.mbox

where you will find instructions on how to make the Sixaxis work over
BT.

Keep in mind that the file is under /tmp on my server, so it will go
away eventually.

Ah you could help pushing linux-bluetooth people to review my changes
and eventually apply them so we can have official support for
Sixaxis/DS3 in BlueZ.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__1_Nov_2011_01_18_54_+0100_UAwf763W/y_4Z/Ms
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6vOu4ACgkQ5xr2akVTsAGniwCZAWTWRKEjt48xXLNyxrcLbdIU
FF4An0kPDUjqJRSSEx+wPAi3natIbJyT
=FuLe
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Nov_2011_01_18_54_+0100_UAwf763W/y_4Z/Ms--
