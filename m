From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] HID: hid-input: Fix accessing freed memory during driver unbind
Date: Tue, 28 Jul 2015 09:16:30 +0900
Message-ID: <1438042590-17719-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

During unbinding the driver was dereferencing a pointer to memory
already freed by power_supply_unregister().

Driver was freeing its internal description of battery through pointers
stored in power_supply structure. However, because the core owns the
power supply instance, after calling power_supply_unregister() the
driver cannot access these members.

Fix this by using resource-managed allocations so internal data will be
freed by pointers stored in resource-managed core.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
Cc: <stable@vger.kernel.org>
---
 drivers/hid/hid-input.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 14aebe483219..5429a8497d51 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -408,15 +408,14 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (dev->battery != NULL)
 		goto out;	/* already initialized? */
 
-	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
+	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (psy_desc == NULL)
 		goto out;
 
-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery", dev->uniq);
-	if (psy_desc->name == NULL) {
-		kfree(psy_desc);
+	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL,
+					"hid-%s-battery", dev->uniq);
+	if (psy_desc->name == NULL)
 		goto out;
-	}
 
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	psy_desc->properties = hidinput_battery_props;
@@ -449,8 +448,6 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (IS_ERR(dev->battery)) {
 		hid_warn(dev, "can't register power supply: %ld\n",
 				PTR_ERR(dev->battery));
-		kfree(psy_desc->name);
-		kfree(psy_desc);
 		dev->battery = NULL;
 	} else {
 		power_supply_powers(dev->battery, &dev->dev);
@@ -466,8 +463,6 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 		return;
 
 	power_supply_unregister(dev->battery);
-	kfree(dev->battery->desc->name);
-	kfree(dev->battery->desc);
 	dev->battery = NULL;
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
-- 
1.9.1

