From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] HID: i2c-hid: Expand module_i2c_driver macro
Date: Sun, 18 Jun 2017 12:14:47 +0200
Message-ID: <20170618101448.17734-2-hdegoede@redhat.com>
References: <20170618101448.17734-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdFRKOy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Jun 2017 06:14:54 -0400
In-Reply-To: <20170618101448.17734-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

This is a preparation patch for not registering the driver on some
machines where just trying to probe a non HID compliant device causes
issues.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index fb55fb4c39fc..54b53d8f96ce 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1276,7 +1276,17 @@ static struct i2c_driver i2c_hid_driver = {
 	.id_table	= i2c_hid_id_table,
 };
 
-module_i2c_driver(i2c_hid_driver);
+static int __init i2c_hid_init(void)
+{
+	return i2c_add_driver(&i2c_hid_driver);
+}
+module_init(i2c_hid_init);
+
+static void __exit i2c_hid_exit(void)
+{
+	i2c_del_driver(&i2c_hid_driver);
+}
+module_exit(i2c_hid_exit);
 
 MODULE_DESCRIPTION("HID over I2C core driver");
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
-- 
2.13.0

