From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v5 6/8] Input: elantech - clean up elantech_init
Date: Mon,  5 Sep 2011 10:16:45 +0800
Message-ID: <1315189007-2179-7-git-send-email-jj_ding@emc.com.tw>
References: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:65306 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab1IECOm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Sep 2011 22:14:42 -0400
In-Reply-To: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, JJ Ding <jj_ding@emc.com.tw>

Group property setting code into elantech_set_properties.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
Acked-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   69 ++++++++++++++++++++++----------=
-------
 1 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 008e8c2..2ae7c49 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -791,6 +791,42 @@ static int elantech_reconnect(struct psmouse *psmo=
use)
 }
=20
 /*
+ * determine hardware version and set some properties according to it.
+ */
+static void elantech_set_properties(struct elantech_data *etd)
+{
+	/*
+	 * Assume every version greater than 0x020030 is new EeePC style
+	 * hardware with 6 byte packets, except 0x020600
+	 */
+	if (etd->fw_version < 0x020030 || etd->fw_version =3D=3D 0x020600)
+		etd->hw_version =3D 1;
+	else
+		etd->hw_version =3D 2;
+
+	/*
+	 * Turn on packet checking by default.
+	 */
+	etd->paritycheck =3D 1;
+
+	/*
+	 * This firmware suffers from misreporting coordinates when
+	 * a touch action starts causing the mouse cursor or scrolled page
+	 * to jump. Enable a workaround.
+	 */
+	etd->jumpy_cursor =3D
+		(etd->fw_version =3D=3D 0x020022 || etd->fw_version =3D=3D 0x020600)=
;
+
+	if (etd->hw_version =3D=3D 2) {
+		/* For now show extra debug information */
+		etd->debug =3D 1;
+
+		if (etd->fw_version >=3D 0x020800)
+			etd->reports_pressure =3D true;
+	}
+}
+
+/*
  * Initialize the touchpad and create sysfs entries
  */
 int elantech_init(struct psmouse *psmouse)
@@ -816,26 +852,9 @@ int elantech_init(struct psmouse *psmouse)
 	}
=20
 	etd->fw_version =3D (param[0] << 16) | (param[1] << 8) | param[2];
-
-	/*
-	 * Assume every version greater than this is new EeePC style
-	 * hardware with 6 byte packets
-	 */
-	if (etd->fw_version >=3D 0x020030) {
-		etd->hw_version =3D 2;
-		/* For now show extra debug information */
-		etd->debug =3D 1;
-		etd->paritycheck =3D 1;
-
-		if (etd->fw_version >=3D 0x020800)
-			etd->reports_pressure =3D true;
-
-	} else {
-		etd->hw_version =3D 1;
-		etd->paritycheck =3D 1;
-	}
-
-	pr_info("assuming hardware version %d, firmware version %d.%d.%d\n",
+	elantech_set_properties(etd);
+	pr_info("assuming hardware version %d "
+		"(with firmware version 0x%02x%02x%02x)\n",
 		etd->hw_version, param[0], param[1], param[2]);
=20
 	if (synaptics_send_cmd(psmouse, ETP_CAPABILITIES_QUERY,
@@ -847,16 +866,6 @@ int elantech_init(struct psmouse *psmouse)
 		etd->capabilities[0], etd->capabilities[1],
 		etd->capabilities[2]);
=20
-	/*
-	 * This firmware suffers from misreporting coordinates when
-	 * a touch action starts causing the mouse cursor or scrolled page
-	 * to jump. Enable a workaround.
-	 */
-	if (etd->fw_version =3D=3D 0x020022 || etd->fw_version =3D=3D 0x02060=
0) {
-		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy curs=
or workaround\n");
-		etd->jumpy_cursor =3D true;
-	}
-
 	if (elantech_set_absolute_mode(psmouse)) {
 		pr_err("failed to put touchpad into absolute mode.\n");
 		goto init_fail;
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
