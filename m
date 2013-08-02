From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] i2c-hid: don't push static constants on stack for %*ph
Date: Fri,  2 Aug 2013 14:07:15 +0300
Message-ID: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31084 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab3HBLHa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Aug 2013 07:07:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to pass constants via stack. The width may be explicitly
specified in the format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index c21e692..05d4f96 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -801,8 +801,8 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 	 * bytes 2-3 -> bcdVersion (has to be 1.00) */
 	ret = i2c_hid_command(client, &hid_descr_cmd, ihid->hdesc_buffer, 4);
 
-	i2c_hid_dbg(ihid, "%s, ihid->hdesc_buffer: %*ph\n",
-			__func__, 4, ihid->hdesc_buffer);
+	i2c_hid_dbg(ihid, "%s, ihid->hdesc_buffer: %4ph\n", __func__,
+			ihid->hdesc_buffer);
 
 	if (ret) {
 		dev_err(&client->dev,
-- 
1.8.4.rc0

