From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] elantech: Fix detection of touchpad on ASUS s301l
Date: Wed,  3 Sep 2014 16:24:02 +0200
Message-ID: <1409754242-10196-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

http://mariusmonton.com/?p=3D489

Cc: stable@vger.kernel.org
Reported-and-tested-by: M=C3=A0rius Monton <marius.monton@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/elantech.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index daaf82f..fad7367 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1331,6 +1331,13 @@ static bool elantech_is_signature_valid(const un=
signed char *param)
 	if (param[1] =3D=3D 0)
 		return true;
=20
+	/*
+	 * Some models have a revision higher then 20. Meaning param[2] may
+	 * be 10 or 20, skip the rates check for these.
+	 */
+	if (param[0] =3D=3D 0x46 && (param[1] & 0xef) =3D=3D 0x0f && param[2]=
 < 40)
+		return true;
+
 	for (i =3D 0; i < ARRAY_SIZE(rates); i++)
 		if (param[2] =3D=3D rates[i])
 			return false;
--=20
2.1.0
