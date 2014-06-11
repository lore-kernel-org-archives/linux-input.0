From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Input: st-keyscan - Protect PM-only functions by #ifdef CONFIG_PM_SLEEP
Date: Wed, 11 Jun 2014 21:04:53 +0200
Message-ID: <1402513493-17613-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63066 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbaFKTE4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jun 2014 15:04:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If CONFIG_PM_SLEEP=3Dn:

drivers/input/keyboard/st-keyscan.c:219: warning: =E2=80=98keyscan_susp=
end=E2=80=99 defined but not used
drivers/input/keyboard/st-keyscan.c:236: warning: =E2=80=98keyscan_resu=
me=E2=80=99 defined but not used

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/keyboard/st-keyscan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboa=
rd/st-keyscan.c
index 758b48731415..668e3cf4b491 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -215,6 +215,7 @@ static int keyscan_probe(struct platform_device *pd=
ev)
 	return 0;
 }
=20
+#ifdef CONFIG_PM_SLEEP
 static int keyscan_suspend(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -249,6 +250,7 @@ static int keyscan_resume(struct device *dev)
 	mutex_unlock(&input->mutex);
 	return retval;
 }
+#endif /* CONFIG_PM_SLEEP */
=20
 static SIMPLE_DEV_PM_OPS(keyscan_dev_pm_ops, keyscan_suspend, keyscan_=
resume);
=20
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
