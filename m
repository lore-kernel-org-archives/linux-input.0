From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Date: Fri, 14 Jun 2019 12:32:24 -0700
Message-ID: <20190614193224.GA249765@google.com>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190614065438.142867-1-phoenixshen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ting Shen <phoenixshen@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Pi-Hsun Shih <pihsun@chromium.org>, Enrico Granata <egranata@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
List-Id: linux-input@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ting,
On Fri, Jun 14, 2019 at 02:54:38PM +0800, Ting Shen wrote:
> http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> the event_type field, the receiver side should mask out this extra bit wh=
en
> processing the event.
>=20
> Signed-off-by: Ting Shen <phoenixshen@chromium.org>
>=20
Reviewed-by: Benson Leung <bleung@chromium.org>

Looks good for chrome-platform, once ib-mfd-cros-v5.3 is merged.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXQP2SAAKCRBzbaomhzOw
wlZ9AP9f/12U97R86IgIU/pxp4H8GaL/1ZIlTb9bghg1G5lMhQD+MMfQiwPJrvNG
rwYrT8FRMWDZdTSXj6n4hOunOz6Ruw8=
=EtK3
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
