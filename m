From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input: synaptics-rmi4 - rmi_driver.h tidy up
Date: Thu, 9 Jan 2014 17:59:38 -0800
Message-ID: <1389319178-27751-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:57704 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaAJB7l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 20:59:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This is a trivial change to remove an unused macro, and change CONFIG_PM to
CONFIG_PM_SLEEP.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 4d82b90..ad3ee33 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -24,8 +24,6 @@
 	.attrs = _attrs,  \
 }
 
-#define attrify(nm) (&dev_attr_##nm.attr)
-
 #define PDT_PROPERTIES_LOCATION 0x00EF
 #define BSR_LOCATION 0x00FE
 
@@ -62,7 +60,7 @@ struct rmi_driver_data {
 	u8 bsr;
 
 	bool enabled;
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	bool suspended;
 	struct mutex suspend_mutex;
 
