From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] sh: maple: Robust checking for errors on maple keyboard initialisation
Date: Wed, 24 Dec 2008 11:59:13 -0500
Message-ID: <200812241159.15332.vapier@gentoo.org>
References: <1229797527.6502.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7432194.PGOv0Vk5Ih";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1229797527.6502.18.camel@localhost.localdomain>
Sender: linux-sh-owner@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: lkmL <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Matt Fleming <matt@console-pimps.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-input@vger.kernel.org

--nextPart7432194.PGOv0Vk5Ih
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 20 December 2008 13:25:27 Adrian McMenamin wrote:
> -	maple_set_drvdata(mdev, NULL);
> -	return error;
> +fail:
> +	return -error;

same comment as for the joystick driver ... it's weird and i'm pretty sure=
=20
incorrect due to other functions setting error as well as this driver.
=2Dmike

--nextPart7432194.PGOv0Vk5Ih
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJUmpjAAoJEEFjO5/oN/WB8vUP+gLiz49YUsqfbp1pfCo5dkSY
bKtdS2kYmdoMnSACebWJKvBjawN8w5XU+is5F4DPbxZzqFlP5uuKBa1RWGUXIGTG
FOU1sKbI9Om3/4rh/9OMjJaytSkSALLPHaIXYwO3ivI1OlTfx2g+yz8e3vyIKFw6
V5PTRUMJan/RvFnPM50JtkKAxU7h7+hHbjkcxd9koD0dVgSmum77Wbt12bpaKVWi
X+Nkx1twxwhuvPBu/+/aTQfIdmNUJ1eE5Agk7UpwT1WlN2+l5wQrSy8d+qee0Ygd
M+EjNK/wStVG96Ho+k4vQuajUWWwaILFaBmvySHI5jld0Mx6h3zPJr7RA6qBw9MN
UaR89M8uUuCvISfApRdLuHtUSdyh/I1CbVLxra4NZcyPUEN452/La3qphJ8Wqwg4
wSSrHY7UcPH+ww+0W11w/2h9cyPZ0n7X4inHnlfiDA5DfehPG8RTXe9vlIQUmtHx
FhMU/f+F6EuGet6l3Xk+U3CUE2ElZprl7RacdfF26iS2ppTHi++VcE34Z4JHI1Vm
cqxuaCnFL+/N03ZwztgAWfEOewZVZc0a4xWFU1M92qttA4rj9E4BWP82uejHxJch
nrghA03elQ3dSOIE/YwPHe3m+fH5qzUwo2ZI4z9cQm83GJioKM29RCB/hOnom54Y
RGQ4PwZrGav4yQS5Io3U
=EysH
-----END PGP SIGNATURE-----

--nextPart7432194.PGOv0Vk5Ih--
