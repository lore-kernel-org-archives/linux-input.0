From: Tobias Doerffel <tobias.doerffel@gmail.com>
Subject: [PATCH] Input: twl4030-vibra - depend on CONFIG_PM_SLEEP for suspend/resume functions
Date: Sun, 30 May 2010 00:31:48 +0200
Message-ID: <1275172308-15093-1-git-send-email-tobias.doerffel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jessica.hrz.tu-chemnitz.de ([134.109.132.47]:46760 "EHLO
	jessica.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756765Ab0E2Wbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 18:31:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tobias Doerffel <tobias.doerffel@gmail.com>

When building a kernel with CONFIG_PM=3Dy but neither suspend nor
hibernate support, the compiler complains about the static functions
twl4030_vibra_suspend() and twl4030_vibra_resume() not being used:

drivers/input/misc/twl4030-vibra.c:176:12: warning: =E2=80=98twl4030_vi=
bra_suspend=E2=80=99 defined but not used
drivers/input/misc/twl4030-vibra.c:187:12: warning: =E2=80=98twl4030_vi=
bra_resume=E2=80=99 defined but not used

Depending on CONFIG_PM_SLEEP rather than CONFIG_PM fixes the issue.

Signed-off-by: Tobias Doerffel <tobias.doerffel@gmail.com>
---
 drivers/input/misc/twl4030-vibra.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/tw=
l4030-vibra.c
index 4f9b2af..3600bca 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -172,7 +172,7 @@ static void twl4030_vibra_close(struct input_dev *i=
nput)
 }
=20
 /*** Module ***/
-#if CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int twl4030_vibra_suspend(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -273,7 +273,7 @@ static struct platform_driver twl4030_vibra_driver =
=3D {
 	.driver		=3D {
 		.name	=3D "twl4030_codec_vibra",
 		.owner	=3D THIS_MODULE,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 		.pm	=3D &twl4030_vibra_pm_ops,
 #endif
 	},
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
