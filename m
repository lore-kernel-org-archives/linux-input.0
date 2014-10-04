From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH 0/5] Input: elantech - support the Fujitsu H730 laptop
Date: Sat, 04 Oct 2014 11:33:17 +0200
Message-ID: <542FBEDD.5090409@web.de>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="McGnQGP1XVVkAJtAEdNeQFQMThqqfXkRq"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:50646 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaJDJdn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Oct 2014 05:33:43 -0400
In-Reply-To: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--McGnQGP1XVVkAJtAEdNeQFQMThqqfXkRq
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 2014-08-30 16:10, Ulrik De Bie wrote:
> This patch set makes the elantech driver work for the Fujitsu H730 lapt=
op. It
> also adds a sysfs knob to allow other laptops that are facing similar
> problems as the Fujitsu H730 to have working touchpad.
>=20
> I'm considering adding a WARN_ONCE when the crc_enabled signature check=

> fails. The message would then point the user to the crc_enabled sysfs k=
nob,
> and kindly ask the user to report the laptop to linux-input mailinglist=
 ?
> Any suggestions ?
>=20
> Two users have tested the combination of this patchset and confirmed th=
at
> it makes the H730 touchpad/trackpoint work.
>=20
> Here an overview of the patchset:
>=20
> Patch 1/ : Input: elantech - use elantech_report_trackpoint for hardwar=
e v4 too
> The Fujitsu H730 is the first v4 hardware identified that also sends th=
e
> trackpoint packets. This patch enables the trackpoint on v4 hardware.
> With this patch the trackpoint will work.
>=20
> Patch 2/ : Input: elantech - Fix crc_enabled for Fujitsu H730
> Uses DMI to detect the H730 and ,if detected, will set crc_enabled to 1=
=2E=20
> With this patch the touchpad and left/right button will start to work.
>=20
> Patch 3/ : Input: elantech - report the middle button of the touchpad
> The Fujitsu H730 is the first laptop listed in the elantech.c file with=

> 3 touchpad buttons. This patch enables the middle button for all elante=
ch
> hardware and enables the reporting for v4 hardware.
> I want to hear feedback here on what preferences exist for the conditio=
ns
> to enable the middle button:
> - DMI
> - enable only for v4
> - enable for all/report for v3+v4
> ...
>=20
> Patch 4/ : Input: Elantech - provide a sysfs knob for crc_enabled
> Probably H730 will not remain the only elantech laptop that has this fa=
iling
> detection for the crc_enabled. This provides users with a workaround wh=
en
> the crc_enabled detection fails.
>=20
> Patch 5/ : Elantech - Update the documentation: trackpoint,v3/v4,crc_en=
abled
> This provides an update of the elantech documentation.=20
>=20
> Patch 4 depends on patch 2, and for consistency, patch 5 depends on pat=
ch 1-2-4.
>=20
> Ulrik De Bie (5):
>   Input: elantech - use elantech_report_trackpoint for hardware v4 too
>   Input: elantech - Fix crc_enabled for Fujitsu H730
>   Input: elantech - report the middle button of the touchpad
>   Input: elantech - provide a sysfs knob for crc_enabled
>   Input: elantech - Update the documentation:
>     trackpoint,v3/v4,crc_enabled
>=20
>  Documentation/input/elantech.txt |  85 ++++++++++++++++++++++++++--
>  drivers/input/mouse/elantech.c   | 119 +++++++++++++++++++++++++++++++=
+-------
>  drivers/input/mouse/elantech.h   |   2 +-
>  3 files changed, 179 insertions(+), 27 deletions(-)
>=20
> Best regards,
> Ulrik De Bie
>=20

What's the status of this series? Is it queued for 3.18 already?

I'm on H730, and these patches work nicely here. Would be great being
able to use a distro kernel at some point...

Jan


--McGnQGP1XVVkAJtAEdNeQFQMThqqfXkRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlQvvucACgkQitSsb3rl5xTOswCgm1ADE1K0iSGtXtV7SzHsH6rT
C6EAn2RbAAmDD8xnLZePQLjh0uZ17Qdu
=jwNf
-----END PGP SIGNATURE-----

--McGnQGP1XVVkAJtAEdNeQFQMThqqfXkRq--
