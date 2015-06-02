From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] elantech: Fix detection of touchpads where the revision matches a known rate
Date: Tue,  2 Jun 2015 11:33:37 +0200
Message-ID: <1433237617-12495-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Ulrik de Bie <ulrik.debie-os@e2big.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Make the check to skip the rate check more lax, so that it applies
to all hw_version 4 models.

This fixes the touchpad not being detected properly on Asus PU551LA
laptops.

Cc: stable@vger.kernel.org
Reported-and-tested-by: David Zafra G=C3=B3mez <dezeta@klo.es>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Update the comment above the check to match the new code
---
 drivers/input/mouse/elantech.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 79363b6..f181d73 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1376,10 +1376,11 @@ static bool elantech_is_signature_valid(const u=
nsigned char *param)
 		return true;
=20
 	/*
-	 * Some models have a revision higher then 20. Meaning param[2] may
-	 * be 10 or 20, skip the rates check for these.
+	 * Some hw_version >=3D 4 models have a revision higher then 20. Mean=
ing
+	 * that param[2] may be 10 or 20, skip the rates check for these.
 	 */
-	if (param[0] =3D=3D 0x46 && (param[1] & 0xef) =3D=3D 0x0f && param[2]=
 < 40)
+	if ((param[0] & 0x0f) >=3D 0x06 && (param[1] & 0xaf) =3D=3D 0x0f &&
+	    param[2] < 40)
 		return true;
=20
 	for (i =3D 0; i < ARRAY_SIZE(rates); i++)
--=20
2.4.2
