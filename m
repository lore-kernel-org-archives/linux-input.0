From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2] HID: hid-input: Fix accessing freed memory during device
 disconnect
Date: Mon, 03 Aug 2015 09:01:21 +0900
Message-ID: <1438560081-23055-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:49013 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbbHCABk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 20:01:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

During unbinding the driver was dereferencing a pointer to memory
already freed by power_supply_unregister().

Driver was freeing its internal description of battery through pointers
stored in power_supply structure. However, because the core owns the
power supply instance, after calling power_supply_unregister() this
memory is freed and the driver cannot access these members.

Fix this by storing the pointer to internal description of battery in a
local variable before calling power_supply_unregister(), so the pointer
remains valid.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
Cc: <stable@vger.kernel.org>

---
Changes since v1:
1. Re-work idea, use local variable instead of devm-like functions
   (pointed out by Dmitry Torokhov).
2. Adjusted subject and commit message.
---
 drivers/hid/hid-input.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 14aebe483219..460faaebaa2c 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -462,12 +462,15 @@ out:
 
 static void hidinput_cleanup_battery(struct hid_device *dev)
 {
+	struct power_supply_desc *psy_desc;
+
 	if (!dev->battery)
 		return;
 
+	psy_desc = dev->battery->desc;
 	power_supply_unregister(dev->battery);
-	kfree(dev->battery->desc->name);
-	kfree(dev->battery->desc);
+	kfree(psy_desc->name);
+	kfree(psy_desc);
 	dev->battery = NULL;
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
-- 
1.9.1

