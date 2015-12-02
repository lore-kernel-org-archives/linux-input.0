From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] Input: sparcspkr - Use platform_register/unregister_drivers()
Date: Wed,  2 Dec 2015 17:25:19 +0100
Message-ID: <1449073519-11768-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34528 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbLBQZW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 11:25:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

These new helpers simplify implementing multi-driver modules and
properly handle failure to register one driver by unregistering all
previously registered drivers.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/input/misc/sparcspkr.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 6f997aa49183..4a5afc7fe96e 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -345,23 +345,19 @@ static struct platform_driver grover_beep_driver = {
 	.shutdown	= sparcspkr_shutdown,
 };
 
+static struct platform_driver * const drivers[] = {
+	&bbc_beep_driver,
+	&grover_beep_driver,
+};
+
 static int __init sparcspkr_init(void)
 {
-	int err = platform_driver_register(&bbc_beep_driver);
-
-	if (!err) {
-		err = platform_driver_register(&grover_beep_driver);
-		if (err)
-			platform_driver_unregister(&bbc_beep_driver);
-	}
-
-	return err;
+	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
 }
 
 static void __exit sparcspkr_exit(void)
 {
-	platform_driver_unregister(&bbc_beep_driver);
-	platform_driver_unregister(&grover_beep_driver);
+	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
 }
 
 module_init(sparcspkr_init);
-- 
2.5.0

