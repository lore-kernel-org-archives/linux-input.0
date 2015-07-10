From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] hid: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 14:51:04 +0900
Message-ID: <1436507466-19257-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58820 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbbGJFvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 01:51:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Antonio Borneo <borneo.antonio@gmail.com>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Andrew Duggan <aduggan@synaptics.com>, Seth Forshee <seth.forshee@canonical.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/hid/i2c-hid/i2c-hid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index f77469d4edfb..dfd679647391 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1167,7 +1167,6 @@ MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);
 static struct i2c_driver i2c_hid_driver = {
 	.driver = {
 		.name	= "i2c_hid",
-		.owner	= THIS_MODULE,
 		.pm	= &i2c_hid_pm,
 		.acpi_match_table = ACPI_PTR(i2c_hid_acpi_match),
 		.of_match_table = of_match_ptr(i2c_hid_of_match),
-- 
1.9.1

