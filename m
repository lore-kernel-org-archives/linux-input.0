From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH] ACPI: Put button input devices in correct place in sysfs
Date: Tue, 6 Nov 2007 20:51:55 +0300
Message-ID: <200711062051.59884.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2756250.CW4idclnDt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Cc: dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

--nextPart2756250.CW4idclnDt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Properly set up parent on input device registered by the button driver.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

=2D--

 drivers/acpi/button.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 301e832..5b0f065 100644
=2D-- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -450,6 +450,7 @@ static int acpi_button_add(struct acpi_device *device)
 		break;
 	}
=20
+	input->cdev.dev =3D &device->dev;
 	error =3D input_register_device(input);
 	if (error)
 		goto err_remove_handlers;

--nextPart2756250.CW4idclnDt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHMKm8R6LMutpd94wRAmQyAKCOrVqKGPbUYDRAgH+E0C3WVWzMUACfZ8A/
XHs0OMxEDzI0QsuUMp2jMRE=
=4E4x
-----END PGP SIGNATURE-----

--nextPart2756250.CW4idclnDt--
