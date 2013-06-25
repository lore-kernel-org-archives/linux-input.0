From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] i2c-hid: explicitly cast parametrs to follow specifiers
Date: Tue, 25 Jun 2013 15:24:41 +0300
Message-ID: <1372163081-11394-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5541 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab3FYMYw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jun 2013 08:24:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The vendor and product parameters are defined as __u32, but used as short int.
Let's do an explicit casting for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 879b0ed..d595f2a 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1009,7 +1009,7 @@ static int i2c_hid_probe(struct i2c_client *client,
 	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
 
 	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
-		 client->name, hid->vendor, hid->product);
+		 client->name, (short int)hid->vendor, (short int)hid->product);
 
 	ret = hid_add_device(hid);
 	if (ret) {
-- 
1.8.3.1

