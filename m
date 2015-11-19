From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH] hid: Drop owner assignment from i2c_driver
Date: Thu, 19 Nov 2015 12:58:14 +0900
Message-ID: <1447905494-30794-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:22030 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933261AbbKSD6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2015 22:58:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/hid/i2c-hid/i2c-hid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 10bd8e6e4c9c..55d8f9d25696 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1184,7 +1184,6 @@ MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);
 static struct i2c_driver i2c_hid_driver = {
 	.driver = {
 		.name	= "i2c_hid",
-		.owner	= THIS_MODULE,
 		.pm	= &i2c_hid_pm,
 		.acpi_match_table = ACPI_PTR(i2c_hid_acpi_match),
 		.of_match_table = of_match_ptr(i2c_hid_of_match),
-- 
1.9.1

