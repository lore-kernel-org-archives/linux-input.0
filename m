From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 17/26] Input: synaptics-rmi4: Remove unused firmware_name variable
Date: Thu, 5 Nov 2015 15:41:28 -0800
Message-ID: <1446766888-30987-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

Firmware update is not currently supported in the current state of
this driver. We can add it back if we need it when implementing
firmware update.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 include/linux/rmi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 9a0152c..fef482a 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -276,10 +276,6 @@ struct rmi_device_platform_data {
 
 	bool unified_input;
 
-#ifdef CONFIG_RMI4_FWLIB
-	char *firmware_name;
-#endif
-
 #ifdef	CONFIG_PM
 	void *pm_data;
 	int (*pre_suspend) (const void *pm_data);
-- 
2.1.4
