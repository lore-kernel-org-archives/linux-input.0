From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH] Input: synaptics - fix compile warning
Date: Mon, 23 Apr 2012 17:31:14 +0800
Message-ID: <1335173474-15758-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:12413 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2DWJcA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 05:32:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, JJ Ding <jj_ding@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, JJ Ding <dgdunix@gmail.com>

=46rom: JJ Ding <dgdunix@gmail.com>

Move synaptics_invert_y() inside CONFIG_MOUSE_PS2_SYNAPTICS to get rid =
of
a compile warning when we don't select synaptics support.

drivers/input/mouse/synaptics.c:53:12: warning: =E2=80=98synaptics_inve=
rt_y=E2=80=99 defined but not used [-Wunused-function]

Cc: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: JJ Ding <dgdunix@gmail.com>
---
 drivers/input/mouse/synaptics.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/syna=
ptics.c
index 8081a0a..c778f27 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -45,16 +45,6 @@
 #define YMIN_NOMINAL 1408
 #define YMAX_NOMINAL 4448
=20
-/*
- * Synaptics touchpads report the y coordinate from bottom to top, whi=
ch is
- * opposite from what userspace expects.
- * This function is used to invert y before reporting.
- */
-static int synaptics_invert_y(int y)
-{
-	return YMAX_NOMINAL + YMIN_NOMINAL - y;
-}
-
=20
 /*********************************************************************=
********
  *	Stuff we need even when we do not want native Synaptics support
@@ -112,6 +102,16 @@ void synaptics_reset(struct psmouse *psmouse)
  *********************************************************************=
*******/
=20
 /*
+ * Synaptics touchpads report the y coordinate from bottom to top, whi=
ch is
+ * opposite from what userspace expects.
+ * This function is used to invert y before reporting.
+ */
+static int synaptics_invert_y(int y)
+{
+	return YMAX_NOMINAL + YMIN_NOMINAL - y;
+}
+
+/*
  * Send a command to the synpatics touchpad by special commands
  */
 static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c=
, unsigned char *param)
--=20
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
