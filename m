From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 02/20] power_supply: Move run-time configuration to
 separate structure
Date: Thu, 26 Feb 2015 02:58:02 +0100
Message-ID: <20150226015801.GA13062@earth>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-3-git-send-email-k.kozlowski@samsung.com>
 <20150226003409.GA885@earth>
 <20150226011007.GA25965@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226011007.GA25965@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 05:10:07PM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 26, 2015 at 01:34:09AM +0100, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Mon, Feb 23, 2015 at 12:47:23PM +0100, Krzysztof Kozlowski wrote:
> > > Add new structure 'power_supply_config' for holding run-time
> > > initialization data like of_node, supplies and private driver data.
> > >=20
> > > The power_supply_register() function is changed so all power supply
> > > drivers need updating.
> > >=20
> > > When registering the power supply this new 'power_supply_config' shou=
ld be
> > > used instead of directly initializing 'struct power_supply'. This all=
ows
> > > changing the ownership of power_supply structure from driver to the
> > > power supply core in next patches.
> > >=20
> > > When a driver does not use of_node or supplies then it should use NULL
> > > as config. If driver uses of_node or supplies then it should allocate
> > > config on stack and initialize it with proper values.
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > >=20
> > > [for the nvec part]
> > > Reviewed-by: Marc Dietrich <marvin24@gmx.de>
> > >=20
> > > [for drivers/platform/x86/compal-laptop.c]
> > > Reviewed-by: Darren Hart <dvhart@linux.intel.com>
> > > ---
> > >  drivers/acpi/ac.c                     |  2 +-
> > >  drivers/acpi/battery.c                |  3 ++-
> > >  drivers/acpi/sbs.c                    |  4 ++--
> > >  drivers/hid/hid-input.c               |  2 +-
> > >  drivers/hid/hid-sony.c                |  2 +-
> > >  drivers/hid/hid-wiimote-modules.c     |  2 +-
> > >  drivers/hid/wacom_sys.c               |  5 +++--
> > >  drivers/platform/x86/compal-laptop.c  |  2 +-
> > >  drivers/power/[...]                   |  lots of changes
> > >  drivers/staging/nvec/nvec_power.c     |  7 ++++---
> > >  include/linux/power_supply.h          | 16 ++++++++++++++--
> > >  67 files changed, 211 insertions(+), 158 deletions(-)
> >=20
> > I would like to merge this via the power supply tree.
> >=20
> > Rafael, Dmitry, are you ok with this change?
>=20
> Hmm, I do not see anything affecting input here, you want Jiri for HID I
> guess...

uhm right. Thanks for pointing out and sorry for the noise.

-- Sebastian

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7n2mAAoJENju1/PIO/qasDAQAIkaDOJmM+rFirAIP9L8Vkyi
pwA/YKfjuQ03RyhKIuqN3wgylsF1WsZ9GhlEBj3T08k1ksw+UBwkOtewJPtWMt9U
Wlc12Hl7ZNjgO9CkZNvIuw8YFUoKb0+2L3q2VC8EzHAlv95PkNZDwBI4hda3sfLN
jIA2QTMh9oPo6k2a0nnFtGUM+k3/B3KpsEhtv2k+HrV3/G9lQPdHXIaSAEDYU3xq
dVJzYi5CnUFk0Ojt3UNxiAZgoz6wSX+1b5wkk4PCaKc5TStVxavkb/SH1d5ihvPS
gzyyy/qMlnI8ZfTLxiEBCHgJny7e1CpmrEmD6lyHcogDBYGVfBeNAVSR2Q4Xl9nu
Rdi7jjQbKt7F53AZJrDa9v8yOSjR143nc8L9lyouGcT4ghbR/N0571IGdgnSQfs3
vYQdwaZ4QkB2jEneQpdrd/GUL5fuFddv8Gs9x948DtHhskIiaXnryWOyadvAHbWy
a1wPmHbLddJb+UIDxCCN6fFQe/kVJLKLR/hrwM+/zbch8GBpC84BW95jNPfwsrKF
1YshsRQDR3KqcynnDhQNPCAe6YwYF1tTchpMaSqU65P8P7msuZarQMjJenzf8esu
eKJD+bsj5JHeK8TDRFKtZtgTUPrEAFX3wi4liX1ZC6RYA082DKmWLjyXPuC0AD5j
1n6v5S6O9KRn8pu4SLnw
=fBx/
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
