From: Ben Gamari <ben@smart-cactus.org>
Subject: RE: [PATCH] Alps source code update
Date: Tue, 17 May 2016 15:58:45 +0200
Message-ID: <87mvnozsyy.fsf@smart-cactus.org>
References: <1414102883-11084-1-git-send-email-masaki.ota@jp.alps.com> <20141024071852.GA10616@ndevos-x240.usersys.redhat.com> <1414405705437.30455@jp.alps.com> <87mvnp58r5.fsf@smart-cactus.org> <OSXPR01MB0408237FB2D7A7605D4FB67BC7480@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56035 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcEQN6x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 09:58:53 -0400
In-Reply-To: <OSXPR01MB0408237FB2D7A7605D4FB67BC7480@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, Niels de Vos <ndevos@redhat.com>, Masaki Ota <012nexus@gmail.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "cernekee@gmail.com" <cernekee@gmail.com>, "dturvene@dahetral.com" <dturvene@dahetral.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jclift@redhat.com" <jclift@redhat.com>

--=-=-=
Content-Type: text/plain

Masaki Ota <masaki.ota@jp.alps.com> writes:

> Hi, Ben,
>
> I would like to submit this modification, but it is not completed yet
>
Alright.

> Attached file is Touchpad device driver code for our I2C HID device.
> This device is I2C HID Touchpad + StickPointer.
>
Fair enough.

What about the PS/2 driver? The patch which gave rise to this thread was
to drivers/input/mouse/alps.c, which supports devices with PS/2
interfaces. I know for a fact that there are still new devices produced
with this hardware (for instance, the Dell Latitude E7470). Do you
intend on adding further protocol support for these newer PS/2 devices?

> I made the Touchpad code and it can work on Linux.
> But StickPointer cannot work.(Actually one device can work, another device cannot work)
>
> I attached the source code.(Please change .zap -> .zip)
> Could you just check this source code?
>
I'm afraid I can't do a proper review without a proper patch. However,
it sounds like your intuition is correct: the device is exposing two
physical devices, therefore it should be exposed to the kernel as
two input devices.

A maintainer would likely be better equipped to provide guidance here,
but my guess would be you want to simply allocate a second input device,
as is done in the dualpoint codepath in the alps PS/2 driver [1].

Also, note that you will want to clean up the DOS line endings in
hid-alps.c before submitting this for review.

Cheers,

- Ben


[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/input/mouse/alps.c#n2923


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXOyOVAAoJEHPt6ejPuu8BbOsH/jxnMXLD941OmFH5Owy1Za/N
JBknEcP79N44tOwyWjbzkBD4FdXP7XPo9Ox/upFmWsqBmEkTDAjojOYI4GRBGU+U
nflVN7aoi0P0Xf5J8sJg7AsEmFH+zEuUd842uBDewAQyoVBXurEEXvo18sG18x98
RKIGd04iVA0H9VnZ+uvHN9MkVPJPEaGr4F3P1Ae0i+xR4NmEzl/xie2NjTmCVf6R
lE/UxOkTwFLhwdf/KqC1pXMG7Ok/TxBdFECv6blsGz/MIILY7gvRwaoPMPJwbMUF
RpcV81SeBCW6w36rOLphczsnmYslTxc8PQenAIaPBqVpGAqaxSJQV5Lul2z7g2U=
=cWqU
-----END PGP SIGNATURE-----
--=-=-=--
