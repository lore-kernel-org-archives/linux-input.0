From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v1] Input: tegra-kbc - fix computation of polling time
Date: Sat, 30 Jul 2011 12:41:01 +0200
Message-ID: <20110730104101.GA12309@avionic-0098.mockup.avionic-design.de>
References: <1311981417-31865-1-git-send-email-riyer@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1311981417-31865-1-git-send-email-riyer@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: riyer@nvidia.com
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, olof@lixom.net, amartin@nvidia.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* riyer@nvidia.com wrote:
> From: Rakesh Iyer <riyer@nvidia.com>
>=20
> Fix a constant definition and computation of polling time.
>=20
> Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
> ---
>  drivers/input/keyboard/tegra-kbc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/=
tegra-kbc.c
> index da3828f..263f6fc 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -37,7 +37,7 @@
>  #define KBC_ROW_SCAN_DLY	5
> =20
>  /* KBC uses a 32KHz clock so a cycle =3D 1/32Khz */
> -#define KBC_CYCLE_USEC	32
> +#define KBC_CYCLE_MS	32
> =20
>  /* KBC Registers */
> =20
> @@ -647,7 +647,7 @@ static int __devinit tegra_kbc_probe(struct platform_=
device *pdev)
>  	debounce_cnt =3D min(pdata->debounce_cnt, KBC_MAX_DEBOUNCE_CNT);
>  	scan_time_rows =3D (KBC_ROW_SCAN_TIME + debounce_cnt) * num_rows;
>  	kbc->repoll_dly =3D KBC_ROW_SCAN_DLY + scan_time_rows + pdata->repeat_c=
nt;
> -	kbc->repoll_dly =3D ((kbc->repoll_dly * KBC_CYCLE_USEC) + 999) / 1000;
> +	kbc->repoll_dly =3D (kbc->repoll_dly + KBC_CYCLE_MS - 1) / KBC_CYCLE_MS;

You might want to consider using DIV_ROUND_UP for this.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4z370ACgkQZ+BJyKLjJp/VAQCdErLNgpcMILcKCw0KA3gt0nxx
gp8An2HcQjGUKBukFxMuYBMURUZCTAhX
=7O7h
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
