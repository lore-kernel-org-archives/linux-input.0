From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv6 0/4] DA9052 hardware monitoring improvements
Date: Mon, 21 Aug 2017 12:10:24 +0200
Message-ID: <20170821101024.i4khhkh65bdpntlw@earth>
References: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xv4c6lggwsob3vzo"
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Sender: linux-hwmon-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-input@vger.kernel.org


--xv4c6lggwsob3vzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

ping?

-- Sebastian

On Tue, Jul 18, 2017 at 11:20:20AM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> GE Healthcare's PPD [0] uses DA9053's touchscreen pins
> for hardware monitoring purposes. This adds support for
> the feature.
>=20
> The proposed merge solution is, that mfd queues the
> mfd patches and provides an immutable branch for hwmon,
> since the last patch depends on the other ones.
>=20
> [0] https://patchwork.kernel.org/patch/9809681/
>=20
> Changes since PATCHv5
>  - drop patch 1 & 2 (applied to mfd)
>  - use one line for da9052_tsi_subdev_info[]
>=20
> Changes since PATCHv4:
>  - split mfd changes from main hwmon patch
>=20
> Changes since PATCHv3:
>  - use correct index in da9052_channel_is_visible()
>  - disable touchscreen in mfd instead of in ts driver
>=20
> Changes since PATCHv2:
>  - switch from "diag," to "dlg," prefix
>  - add/use defines for accessing bits in registers
>  - provide more details in the comment above early exit
>    in touchscreen driver
>  - switch to da9052_group_read() to ensure MSB and LSB
>    are in sync
>  - move binding update into its own patch
>  - rename patch
>=20
> Changes since PATCHv1:
>  - convert tsiref-microvolt property into proper regulator
>  - drop error message for timeout
>  - simplify da9052_channel_is_visible()
>  - fix checkpatch warnings
>=20
> -- Sebastian
>=20
> Sebastian Reichel (4):
>   mfd: da9052: add register details for TSI
>   mfd: da9052: make touchscreen registration optional
>   hwmon: da9052: replace S_IRUGO with 0444
>   hwmon: da9052: add support for TSI channel
>=20
>  drivers/hwmon/da9052-hwmon.c      | 285 ++++++++++++++++++++++++++++++++=
+++---
>  drivers/mfd/da9052-core.c         |  26 +++-
>  include/linux/mfd/da9052/da9052.h |   6 +
>  include/linux/mfd/da9052/reg.h    |  11 +-
>  4 files changed, 302 insertions(+), 26 deletions(-)
>=20
> --=20
> 2.13.2
>=20

--xv4c6lggwsob3vzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmasZAACgkQ2O7X88g7
+prchA//d6qbtWsPlBpApkOf9WTXHpggQrHkzP9P+peFOQ/EL6mKVcQImKhLOR9z
VN+xGmM971f1e/zI4ObsdliJAYos424F0eXI5957YXoiFz3qALRljFJIQkVkWMLq
kU+UpHUpg3LPTVD6gRyajU3F3trDAXfrk32U4E7FJA59J0R5hgMZ79cy2KTq7Qc/
o96iWNvkup0/vxoYVFoqAjCWo9hWwK80tntrEZWdjfgztViE2rn9mhaqHIlwGd2z
9gNe5GCsOfYBw23efzShk+C3X/Dv/Be6dqLAr7G77LUJpq0ISF7RBFTC1sA2e410
TVOqKLNtXKA/85ZZLfhZzL4v4zCnU4HC3oqgPOl1vY8jgjosghzZGjjlFFJeKSUo
Pga8chpUAwuPO0R/GqlYElonqFbZ9JIGgZkJTdeMEsJmS9NZ3rSKbrylZ9pKexT0
sB34dfUdMkatwfD2Cgc8fZ1JVyZHt5skp8pufifqdaP3RcEZtrqUM2Bd8pGiESzz
17d0ZeM+tyZT1dwZt9SC031GS0TDTQR07PmZII/IhPHbFPDABIQkmaasHIKTtBQ0
3HOm4vDZAai25Pw8BK4EPKAtPsSk9wkr8YMTVJS+OEWIQdV9kKN+4nbCa9F/G3+K
5xp0xxBBaE1gv7dHmthpyyg+J4Yx6fD5Kr4SxuqxFqpcyUCMiho=
=8NyW
-----END PGP SIGNATURE-----

--xv4c6lggwsob3vzo--
