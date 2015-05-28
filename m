From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] elantech: Fix detection of touchpads where the revision matches a known rate
Date: Thu, 28 May 2015 11:09:31 +0200
Message-ID: <1432804171-3878-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Make the check to skip the rate check more lax, so that it applies
to all hw_version 4 models.

This fixes the touchpad not being detected properly on Asus PU551LA
laptops.

Cc: stable@vger.kernel.org
Reported-and-tested-by: David Zafra G=C3=B3mez <dezeta@klo.es>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/elantech.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 79363b6..e605303 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1379,7 +1379,8 @@ static bool elantech_is_signature_valid(const uns=
igned char *param)
 	 * Some models have a revision higher then 20. Meaning param[2] may
 	 * be 10 or 20, skip the rates check for these.
 	 */
-	if (param[0] =3D=3D 0x46 && (param[1] & 0xef) =3D=3D 0x0f && param[2]=
 < 40)
+	if ((param[0] & 0x0f) >=3D 0x06 && (param[1] & 0xaf) =3D=3D 0x0f &&
+	    param[2] < 40)
 		return true;
=20
 	for (i =3D 0; i < ARRAY_SIZE(rates); i++)
--=20
2.4.1
