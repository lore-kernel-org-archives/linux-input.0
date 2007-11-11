From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] ACPI: Put button input devices in correct place in sysfs
Date: Sun, 11 Nov 2007 11:42:45 +0300
Message-ID: <200711111142.52346.arvidjaar@mail.ru>
References: <200711062051.59884.arvidjaar@mail.ru> <d120d5000711061247l5102875bg9d9b841086dd77b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1650336.XjCWlIMpJ9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <d120d5000711061247l5102875bg9d9b841086dd77b5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, David Brownell <david-b@pacbell.net>
List-Id: linux-input@vger.kernel.org

--nextPart1650336.XjCWlIMpJ9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 06 November 2007, Dmitry Torokhov wrote:
> Hi Andrey,
>=20
> On Nov 6, 2007 12:51 PM, Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > Properly set up parent on input device registered by the button driver.
> >
>=20
> Seems to be a popular topic today :)
>=20
> >
> > +       input->cdev.dev =3D &device->dev;
>=20
> Please don't use cdev, but rather input_dev->dev.parent. cdev is going
> away soon.
> I sent a patch a couple of days ago to teh acpi list...
>=20

You mean button patch? I could find only video one.

Just in case, here is updated version.

Subject: [PATCH] Make real parent for ACPI button input devices
=46rom: Andrey Borzenkov <arvidjaar@mail.ru>



Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

=2D--

 drivers/acpi/button.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 24a7865..6c5da83 100644
=2D-- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -449,6 +449,7 @@ static int acpi_button_add(struct acpi_device *device)
 	input->phys =3D button->phys;
 	input->id.bustype =3D BUS_HOST;
 	input->id.product =3D button->type;
+	input->dev.parent =3D &device->dev;
=20
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:


--nextPart1650336.XjCWlIMpJ9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHNsCGR6LMutpd94wRAiaHAJ4uCnnrt9k/f+S3JSXUyNquVos0UQCgnlBj
RW06nempKiKp5ovI2IadW8k=
=OJEQ
-----END PGP SIGNATURE-----

--nextPart1650336.XjCWlIMpJ9--
