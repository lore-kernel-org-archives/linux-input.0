From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] input: cros_ec_keyb_clear_keyboard() depends on CONFIG_PM_SLEEP
Date: Wed,  8 May 2013 23:45:29 +0200
Message-ID: <1368049529-8168-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jacques.telenet-ops.be ([195.130.132.50]:44740 "EHLO
	jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab3EHVpl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 May 2013 17:45:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Glass <sjg@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If CONFIG_PM_SLEEP is not set:

drivers/input/keyboard/cros_ec_keyb.c:211: warning: =E2=80=98cros_ec_ke=
yb_clear_keyboard=E2=80=99 defined but not used

Move the definition of cros_ec_keyb_clear_keyboard() inside the section
protected by #ifdef CONFIG_PM_SLEEP to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/keyboard/cros_ec_keyb.c |   54 ++++++++++++++++---------=
-------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyb=
oard/cros_ec_keyb.c
index 49557f2..7e8b0a5 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -206,33 +206,6 @@ static int cros_ec_keyb_work(struct notifier_block=
 *nb,
 	return NOTIFY_DONE;
 }
=20
-/* Clear any keys in the buffer */
-static void cros_ec_keyb_clear_keyboard(struct cros_ec_keyb *ckdev)
-{
-	uint8_t old_state[ckdev->cols];
-	uint8_t new_state[ckdev->cols];
-	unsigned long duration;
-	int i, ret;
-
-	/*
-	 * Keep reading until we see that the scan state does not change.
-	 * That indicates that we are done.
-	 *
-	 * Assume that the EC keyscan buffer is at most 32 deep.
-	 */
-	duration =3D jiffies;
-	ret =3D cros_ec_keyb_get_state(ckdev, new_state);
-	for (i =3D 1; !ret && i < 32; i++) {
-		memcpy(old_state, new_state, sizeof(old_state));
-		ret =3D cros_ec_keyb_get_state(ckdev, new_state);
-		if (0 =3D=3D memcmp(old_state, new_state, sizeof(old_state)))
-			break;
-	}
-	duration =3D jiffies - duration;
-	dev_info(ckdev->dev, "Discarded %d keyscan(s) in %dus\n", i,
-		jiffies_to_usecs(duration));
-}
-
 static int cros_ec_keyb_probe(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec =3D dev_get_drvdata(pdev->dev.parent);
@@ -299,6 +272,33 @@ static int cros_ec_keyb_probe(struct platform_devi=
ce *pdev)
 }
=20
 #ifdef CONFIG_PM_SLEEP
+/* Clear any keys in the buffer */
+static void cros_ec_keyb_clear_keyboard(struct cros_ec_keyb *ckdev)
+{
+	uint8_t old_state[ckdev->cols];
+	uint8_t new_state[ckdev->cols];
+	unsigned long duration;
+	int i, ret;
+
+	/*
+	 * Keep reading until we see that the scan state does not change.
+	 * That indicates that we are done.
+	 *
+	 * Assume that the EC keyscan buffer is at most 32 deep.
+	 */
+	duration =3D jiffies;
+	ret =3D cros_ec_keyb_get_state(ckdev, new_state);
+	for (i =3D 1; !ret && i < 32; i++) {
+		memcpy(old_state, new_state, sizeof(old_state));
+		ret =3D cros_ec_keyb_get_state(ckdev, new_state);
+		if (0 =3D=3D memcmp(old_state, new_state, sizeof(old_state)))
+			break;
+	}
+	duration =3D jiffies - duration;
+	dev_info(ckdev->dev, "Discarded %d keyscan(s) in %dus\n", i,
+		jiffies_to_usecs(duration));
+}
+
 static int cros_ec_keyb_resume(struct device *dev)
 {
 	struct cros_ec_keyb *ckdev =3D dev_get_drvdata(dev);
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
