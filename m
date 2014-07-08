From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] Input: st-keyscan - Fix 'defined but not used' compiler warnings
Date: Tue,  8 Jul 2014 10:47:58 +0200
Message-ID: <1404809278-2604-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:38140 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbaGHIsD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Jul 2014 04:48:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-input@vger.kernel.org

Add #ifdef CONFIG_PM_SLEEP around keyscan_supend() and keyscan_resume() to fix
the following compiler warnings occuring if CONFIG_PM_SLEEP is unset:

  + /scratch/kisskb/src/drivers/input/keyboard/st-keyscan.c: warning: 'keyscan_resume' defined but not used [-Wunused-function]:  => 235:12
  + /scratch/kisskb/src/drivers/input/keyboard/st-keyscan.c: warning: 'keyscan_suspend' defined but not used [-Wunused-function]:  => 218:12

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lkml.org/lkml/2014/7/8/109
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/keyboard/st-keyscan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index 758b487..de7be4f 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -215,6 +215,7 @@ static int keyscan_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int keyscan_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -249,6 +250,7 @@ static int keyscan_resume(struct device *dev)
 	mutex_unlock(&input->mutex);
 	return retval;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(keyscan_dev_pm_ops, keyscan_suspend, keyscan_resume);
 
-- 
2.0.1


