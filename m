From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 02/20] power_supply: Move run-time configuration to
 separate structure
Date: Thu, 26 Feb 2015 01:34:09 +0100
Message-ID: <20150226003409.GA885@earth>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424692061-30624-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 23, 2015 at 12:47:23PM +0100, Krzysztof Kozlowski wrote:
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
> ---
>  drivers/acpi/ac.c                     |  2 +-
>  drivers/acpi/battery.c                |  3 ++-
>  drivers/acpi/sbs.c                    |  4 ++--
>  drivers/hid/hid-input.c               |  2 +-
>  drivers/hid/hid-sony.c                |  2 +-
>  drivers/hid/hid-wiimote-modules.c     |  2 +-
>  drivers/hid/wacom_sys.c               |  5 +++--
>  drivers/platform/x86/compal-laptop.c  |  2 +-
>  drivers/power/[...]                   |  lots of changes
>  drivers/staging/nvec/nvec_power.c     |  7 ++++---
>  include/linux/power_supply.h          | 16 ++++++++++++++--
>  67 files changed, 211 insertions(+), 158 deletions(-)

I would like to merge this via the power supply tree.

Rafael, Dmitry, are you ok with this change?

-- Sebastian

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7mn8AAoJENju1/PIO/qaYvMP/A2Qc+Dfz21x4KB9qiJaUPj8
4vmu3j02TSMvbISiXEFe1orPY89HJZYJWUDPWKwlGDsP7ZC/YNQREVe4zlD/KFsV
MgMKrJvTrd6qsFam2GCFJYIThqMgRNoARHJQsFsDlXXtuSsK0a+q0QHLNlqEPe5h
DniIt0Us+J1n05/o86xNR2UWuLBCAJXuztigwdbQgYAVz7L6d35z8Puan2tPfHaE
mtwbGcmA+aP0TqT66hv1ch9Jkl1lJWfdLI01ea7WWrNUX+XxlrxaFbBvKvs4Bk5o
fYr7EY4qA53AGAF9J1dM3Qdc/YXPEham0Qxnsd5oXgYUD4puo5D57QIrifKU1YgM
LfSahXGvzDBi2YGtho1OiMbbrzmwTB5JkdVWGFGrji+DVM4g7dvq5CyKAEThvAdA
BhG0wQwQTT99Hs25QTuCQ3fbLk0U9Sm23A9Yi1JtKtVPAK8/Fryt/IPK2Ye870r9
BBguj0J6LqnnnbcFkeY0LHqyhdwblXvPIMAP+XcVuhTdT2KlXen9tua1PDPWRfFF
RlQVYwK2T1kLh5BCu+vUgcrC6gFebUbLGonLdpizcgEdOpXwTSFz+iYzdTUDsK3r
WU+GTySRp3UYEFf4aJcMMDAJwH4sYZiFQ8g17ahnpueOQ40rRJ9CMsytkFSgY5fq
Vs7ou8iHfTLQ4ql0RbZi
=kRX0
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
