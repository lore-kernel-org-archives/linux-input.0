From: Benson Leung <bleung@chromium.org>
Subject: [PATCH] HID: i2c-hid: Add hid-over-i2c name to i2c id table.
Date: Tue, 14 Oct 2014 14:44:01 -0700
Message-ID: <1413323041-19468-1-git-send-email-bleung@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56892 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaJNVq5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2014 17:46:57 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so8652437pad.15
        for <linux-input@vger.kernel.org>; Tue, 14 Oct 2014 14:46:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, benjamin.tissoires@redhat.com, aduggan@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: olofj@chromium.org, bleung@chromium.org, satoshi.noguchi@jp.synaptics.com, dmitry.torokhov@gmail.com

When using the device tree binding of compatible = "hid-over-i2c"
the i2c id table also needs to have that name in order to
auto load this driver.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 747d544..1a7605f 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1123,6 +1123,7 @@ static const struct dev_pm_ops i2c_hid_pm = {
 
 static const struct i2c_device_id i2c_hid_id_table[] = {
 	{ "hid", 0 },
+	{ "hid-over-i2c", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);
-- 
2.1.0.rc2.206.gedb03e5

