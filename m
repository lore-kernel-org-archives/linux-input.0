From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 04/22] HID: Move run-time power supply configuration
 to separate structure (ACK needed)
Date: Tue, 10 Mar 2015 15:03:49 +0100
Message-ID: <20150310140348.GA11992@earth>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-5-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59334 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351AbbCJOEI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 10:04:08 -0400
Content-Disposition: inline
In-Reply-To: <1425976046-20973-5-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Tue, Mar 10, 2015 at 09:27:08AM +0100, Krzysztof Kozlowski wrote:
> Add new structure 'power_supply_config' for holding run-time
> initialization data like of_node, supplies and private driver data.
>=20
> The power_supply_register() function is changed so all power supply
> drivers need updating.
>=20
> When registering the power supply this new 'power_supply_config' should be
> used instead of directly initializing 'struct power_supply'. This allows
> changing the ownership of power_supply structure from driver to the
> power supply core in next patches.
>=20
> When a driver does not use of_node or supplies then it should use NULL
> as config. If driver uses of_node or supplies then it should allocate
> config on stack and initialize it with proper values.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> [for the nvec part]
> Reviewed-by: Marc Dietrich <marvin24@gmx.de>
>=20
> [for drivers/platform/x86/compal-laptop.c]
> Reviewed-by: Darren Hart <dvhart@linux.intel.com>
>
> ---
>  [...]
>  drivers/hid/hid-input.c               |  2 +-
>  drivers/hid/hid-sony.c                |  2 +-
>  drivers/hid/hid-wiimote-modules.c     |  2 +-
>  drivers/hid/wacom_sys.c               |  5 +++--
>  [...]
>  69 files changed, 224 insertions(+), 167 deletions(-)

I would like to merge this patch via power-supply tree. Can you
please provide your Acked-By?

-- Sebastian

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/vm8AAoJENju1/PIO/qadwMP/3zDm9wl/d16BukrwsXqagPt
xow61fI90+UwsCgTQT+qTytPAZCWTxbXOI+cZThvMPy83Pm2kRlafTgei/+LF+xH
SGf4TELxzU+0NZP1Iby9tU5EnEdiqXRD3Fnl+Ke1IM14d14TUr83qYUkzwYMb4RR
aV6NFQo4V6acb0VIYeqx6sLEHmS1kKuqPcvj7H8o/FO2pThcfiAlLyuOSSAM7kzJ
xWqt6fQ4qlDt5bzfzTo20ZuelR75vT6Syjjp7hqjdJVFF3mhndgQSBHrVrcmHygY
WYWIU1wqx17BtDt8wb1Ae2FibMMTddS0WB+Oxarsz1M6hiN+LilagXOopFTN4QM3
BZQiZU16F8NYJciqmzSsf3vi+Nsk7zLzaCnYUZg9goAR0iv/JUhyEkmAvzJWj5uV
NJ53MbuLb4afMEgwSp6LxbI4vUghuDPu6FjfLZJFD1zOmNYupYZb70N6X3VOuNGl
bmStvhiXXL8dgeiSMNw7phRFzbuno594JAAWKjjchnhR2QuqxS7Z+WQyAzz7iS5L
pD0RZvBDPICmXR7Ckb/4GGxCCygEAMOJ+N4dPDA7cHIjKNZVII4YXfZigGReCP7r
spnAs8X9LzLCyMFySXwujjq9LIq4MlxMyjO+ZwIDa+XDRNb9wmS7GaahVuUCxuzY
MXoJ6C7tCyLOuTY+Su8e
=eBwu
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
