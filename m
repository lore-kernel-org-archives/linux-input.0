From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 0/4 incremental 1/2] Generalize controller handling to
 support different devices
Date: Fri, 19 Aug 2011 22:57:35 +0200
Message-ID: <20110819225735.ed1dbaa9aaa2f250d693c030@studenti.unina.it>
References: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
	<1313677340-4441-1-git-send-email-ospite@studenti.unina.it>
	<4E4D2F2E.20105@signal11.us>
	<20110819211449.b17b35611f11979f9d59a8ab@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__19_Aug_2011_22_57_35_+0200_FIB_wGoo4BH9FBS9"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:56094 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab1HSU5k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 16:57:40 -0400
In-Reply-To: <20110819211449.b17b35611f11979f9d59a8ab@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

--Signature=_Fri__19_Aug_2011_22_57_35_+0200_FIB_wGoo4BH9FBS9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Aug 2011 21:14:49 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> WRT HID_UUID, maybe this is not device specific, it might just tell
> "this is a HID device", I need confirmation about that so I can move the
> field out of the structure.
>

On a second thought, if this UUID is per device _type_, then it may
still make sense to have it in the struct, in case the PS3 headset will
need a different UUID, I'll just rename the field to just "uuid"
because the HID part is relative to the _value_.

Here's some doc about UUIDs I've found:
http://www.bluetooth.org/Technical/AssignedNumbers/service_discovery.htm

About the PNP record, I can find some info about the "PnP Information"
service in SDP, and I can see something with:
	$ sdptool records --tree <device_bdaddr>

but I don't know how to get the actual value currently used in the
plugin.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__19_Aug_2011_22_57_35_+0200_FIB_wGoo4BH9FBS9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5Ozj8ACgkQ5xr2akVTsAFLoACfZJzq4GklNxUDz3GQVzGJWKab
8MkAnie/PW+AvbJbNG6BjO2U8OsPG9v1
=gEDV
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Aug_2011_22_57_35_+0200_FIB_wGoo4BH9FBS9--
