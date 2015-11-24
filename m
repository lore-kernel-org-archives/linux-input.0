From: Andrew Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
Date: Tue, 24 Nov 2015 13:24:19 +0100
Message-ID: <565456F3.8080408@collabora.co.uk>
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kg5FvKtoNCUBUHghjMHwTC9GtWdKAa20M"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34806 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbKXMYY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 07:24:24 -0500
In-Reply-To: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input Mailing List <linux-input@vger.kernel.org>
Cc: =?UTF-8?B?SmnFmcOtIEtvc2luYQ==?= <jkosina@suse.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kg5FvKtoNCUBUHghjMHwTC9GtWdKAa20M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/15 16:00, Andrew Shadura wrote:
> PenMount 6000 USB resistive touchscreen controller reports it has three=

> buttons, while in reality it doesn't have any and doesn't support activ=
e
> styli, and only generates touch events.
>=20
> In penmount_input_mapping(), map only the first button (with code 0),
> ignore the rest.
>=20
> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>

Any news on this patch? It'd be cool if it could be merged.

--=20
Cheers,
  Andrew


--Kg5FvKtoNCUBUHghjMHwTC9GtWdKAa20M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVFb0AAoJEEFnG7NKhJOBOs4P/1jjovtnKS0GH1NuK+UqUACT
nOw6SHxqcCoyibUExtmNCoIBSATSkuxjMHdBrLciuIlblekxSWwpAhPphqe/woSt
0pj2siNjBCmmy+bAJxy7CAMr58udZkVxfpFP8MOcorC7sPkY+QCCmBP2VCrAhhtH
OVhTH0+X740VWiX9O3kHTjN4bIesnDa1qjDGAms2bkghD4CADirD0oH+4Qe9XeMt
iS5XLTEzKhNrHJjdsQwv6Xs3koYE4LL8C40OGqn87ESuDtjJD4M7d6QKeA0VM/K/
jaq2rInYJGtLjoUDNOt//OSxFv8KAnTJ7QIfuKM7VhvxqFvjwiVfOH3PUVJK8C9c
D58ZB6Q8njgMqvV3EkLLaPZ1ieDQTZ9cRoJbwJKJtykLuOtsHh9LklUFebebtkne
heuG1osvo0JnIyBDGgnBqjKYRHrP4NEhiYXs64115KtYowfboYdzhb5ECDOvTvCq
dQLMENlCwI0o7dFLhvSa2ETxZDODtDrXgJmWUAlntNKw/W5KPqvu6Qz54HxcXvqz
qUPrx11ktqknAxe+45IoE8W+Ft9jSvgtKTPNiyjuyjXekyH9byUaJ8YJpz6uSwwm
1441xz2SsBs7AHnBbbrpt5H/usPSiTHGTiULtieQ496x9W+JJazsY+OJiS/HpEWe
FMRcNA5A9G4NxSPAz4Bu
=4lwD
-----END PGP SIGNATURE-----

--Kg5FvKtoNCUBUHghjMHwTC9GtWdKAa20M--
