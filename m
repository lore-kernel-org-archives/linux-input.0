From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v5 1/8] Input: elantech - correct x, y value range for v2 hardware
Date: Mon,  5 Sep 2011 10:16:40 +0800
Message-ID: <1315189007-2179-2-git-send-email-jj_ding@emc.com.tw>
References: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, JJ Ding <jj_ding@emc.com.tw>
List-Id: linux-input@vger.kernel.org

x, y values are actually 12-bit long. Also update protocol document to =
reflect
the change.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
Acked-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 Documentation/input/elantech.txt |    8 ++++----
 drivers/input/mouse/elantech.c   |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/input/elantech.txt b/Documentation/input/ela=
ntech.txt
index db798af..bce9941 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -389,14 +389,14 @@ byte 0:
 byte 1:
=20
    bit   7   6   5   4   3   2   1   0
-	 p7  p6  p5  p4  .  x10 x9  x8
+	 p7  p6  p5  p4 x11 x10 x9  x8
=20
 byte 2:
=20
    bit   7   6   5   4   3   2   1   0
 	 x7  x6  x5  x4  x3  x2  x1  x0
=20
-         x10..x0 =3D absolute x value (horizontal)
+         x11..x0 =3D absolute x value (horizontal)
=20
 byte 3:
=20
@@ -420,7 +420,7 @@ byte 3:
 byte 4:
=20
    bit   7   6   5   4   3   2   1   0
-        p3  p1  p2  p0   .   .  y9  y8
+        p3  p1  p2  p0  y11 y10 y9  y8
=20
 	 p7..p0 =3D pressure (not EF113)
=20
@@ -429,7 +429,7 @@ byte 5:
    bit   7   6   5   4   3   2   1   0
         y7  y6  y5  y4  y3  y2  y1  y0
=20
-         y9..y0 =3D absolute y value (vertical)
+         y11..y0 =3D absolute y value (vertical)
=20
=20
 4.2.2 Two finger touch
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 3250356..da161da 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -290,15 +290,15 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 		/* pass through... */
 	case 1:
 		/*
-		 * byte 1:  .   .   .   .   .  x10 x9  x8
+		 * byte 1:  .   .   .   .  x11 x10 x9  x8
 		 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
 		 */
-		x1 =3D ((packet[1] & 0x07) << 8) | packet[2];
+		x1 =3D ((packet[1] & 0x0f) << 8) | packet[2];
 		/*
-		 * byte 4:  .   .   .   .   .   .  y9  y8
+		 * byte 4:  .   .   .   .  y11 y10 y9  y8
 		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
 		 */
-		y1 =3D ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]);
+		y1 =3D ETP_YMAX_V2 - (((packet[4] & 0x0f) << 8) | packet[5]);
=20
 		input_report_abs(dev, ABS_X, x1);
 		input_report_abs(dev, ABS_Y, y1);
--=20
1.7.4.1
