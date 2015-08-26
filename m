From: Hans Holmberg <hans.holmberg@intel.com>
Subject: [PATCH] Input: only send a syn event when needed in input_dev_release_keys
Date: Wed, 26 Aug 2015 09:38:32 +0200
Message-ID: <1440574712-25629-1-git-send-email-hans.holmberg@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29818 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbbHZHdM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2015 03:33:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: ting.li@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans Holmberg <hans.holmberg@intel.com>

A SYN event is reported in input_release_keys even if no keys are
released. Stop doing this as the superfluous event can prevent autosleep
if a user has opened a device with EPOLLWAKEUP enabled.

Based on a patch developed by Ting Li <ting.li@intel.com>.

Signed-off-by: Hans Holmberg <hans.holmberg@intel.com>
---
 drivers/input/input.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 78d2499..c748805 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -675,12 +675,18 @@ EXPORT_SYMBOL(input_close_device);
 static void input_dev_release_keys(struct input_dev *dev)
 {
 	int code;
+	bool key_released = false;
 
 	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
-		for_each_set_bit(code, dev->key, KEY_CNT)
+		for_each_set_bit(code, dev->key, KEY_CNT) {
 			input_pass_event(dev, EV_KEY, code, 0);
-		memset(dev->key, 0, sizeof(dev->key));
-		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+			key_released = true;
+		}
+
+		if (key_released) {
+			memset(dev->key, 0, sizeof(dev->key));
+			input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+		}
 	}
 }
 
-- 
1.9.1

