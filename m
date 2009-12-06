From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Sun, 6 Dec 2009 11:58:29 +0500
Message-ID: <20091206065829.GI5340@wrars-comp.wrarsdomain>
References: <1259826317-18809-26-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-28-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-29-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
 <20091203075404.GK9121@core.coreip.homeip.net>
 <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from k66.ru ([87.224.128.21]:59667 "EHLO k66.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbZLFH22 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 6 Dec 2009 02:28:28 -0500
Content-Disposition: inline
In-Reply-To: <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2009 at 09:12:52AM +0100, Corentin Chary wrote:
> >> This keycode could be used in a lot of platform specific drivers.
> >> For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
> >> drivers (bt/wl: off/off, on/off, off/on, on/on).
> >>
> >> Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIM=
AX
> >> are rarely used.
> > Is there any application support for such cycling? IOW does anyone cares
> > to do such cycling?
> On Asus laptops (both asus and eeepc) the Fn+F2 key cycle
> (bluetooth/wlan: on/on, on/off, off/on, off/off) on windows.
> On Linux, it only produces a KEY_WLAN keycode.
Default eee901's Xandros cycles and even shows an OSD with BT and WLAN
state images.

--=20
WBR, wRAR (ALT Linux Team)

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJLG1YUAAoJEOih81koZvPBe14H/0wg948KMptylkAy/eAzI5vL
AhmeYf1KoZD1aHNzYs9inDfpy46il+WxlSrE6t3OK9PKruFe4b0m76aOy7s636pN
lKxcyJn8BPqpCkh8ig5Cg2Wx6odRm4vIbxo2NLQFMAc58N56Y6bLMwBclOfTj9UU
AqaiY23C7n2zLCPYpMy50btzSwIh4UrsY5VOvsZNg5KvrRAc9MKXuES3xAFTF+Jk
jSj/fOpjUlq6OsERtrlpAZiPxK7rWywtb+qn7ym/BLJS7A73DtUHbTdrNoAlXIX6
GY07ff7AZ2eKMk64i5Li44y9Upa3aZW8MrqRGcr9QgA1DYWm0eX9giUoZSXXrz0=
=bGPk
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
