From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: sc_keysc - only compile PM code if PM is enabled
Date: Tue, 03 May 2011 00:40:02 -0700
Message-ID: <20110503074002.2380.6883.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43392 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab1ECHkH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 03:40:07 -0400
Received: by pzk9 with SMTP id 9so3384160pzk.19
        for <linux-input@vger.kernel.org>; Tue, 03 May 2011 00:40:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/sh_keysc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index cb4f258..834cf98 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -291,6 +291,7 @@ static int __devexit sh_keysc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if CONFIG_PM_SLEEP
 static int sh_keysc_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -323,11 +324,10 @@ static int sh_keysc_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
-static const struct dev_pm_ops sh_keysc_dev_pm_ops = {
-	.suspend = sh_keysc_suspend,
-	.resume = sh_keysc_resume,
-};
+static SIMPLE_DEV_PM_OPS(sh_keysc_dev_pm_ops,
+			 sh_keysc_suspend, sh_keysc_resume);
 
 static struct platform_driver sh_keysc_device_driver = {
 	.probe		= sh_keysc_probe,

