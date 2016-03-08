From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: i2c-hid: Add hid-over-i2c name to i2c id table
Date: Tue, 8 Mar 2016 11:25:39 -0800
Message-ID: <20160308192539.GA23955@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33050 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcCHTZn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 14:25:43 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When using the device tree binding OF compatible = "hid-over-i2c" the
i2c id table also needs to have that name in order to auto load this
driver, since i2c core reports module alias as i2c:<string> where
<string> is compatible string of OF binding stripped of manufacturer's
prefix.

Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b921693..a2c6c98 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1191,6 +1191,7 @@ static const struct dev_pm_ops i2c_hid_pm = {
 
 static const struct i2c_device_id i2c_hid_id_table[] = {
 	{ "hid", 0 },
+	{ "hid-over-i2c", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);
-- 
2.7.0.rc3.207.g0ac5344


-- 
Dmitry
