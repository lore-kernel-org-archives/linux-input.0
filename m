From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 1/9] i2c: export i2c_client_type structure
Date: Fri, 10 Mar 2017 15:01:06 -0800
Message-ID: <20170310230114.788-2-dmitry.torokhov@gmail.com>
References: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35293 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932731AbdCJXCR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 18:02:17 -0500
In-Reply-To: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

i2c bus has 2 different types of device belonging to the same bus and
bus notifiers use device type to distinguish between adapters and clients.
Previously we only had i2c_adapter_type exported, which made code wanting
to work with i2c_client devices test for type not equal to adapter type.
This unfortunately is not safe if we ever add another type to the bus,
so let's export i2c_client_type as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-core.c | 4 ++--
 include/linux/i2c.h    | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 34a5115484dd..446e341e9508 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -74,7 +74,6 @@
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 
-static struct device_type i2c_client_type;
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
@@ -1096,11 +1095,12 @@ struct bus_type i2c_bus_type = {
 };
 EXPORT_SYMBOL_GPL(i2c_bus_type);
 
-static struct device_type i2c_client_type = {
+struct device_type i2c_client_type = {
 	.groups		= i2c_dev_groups,
 	.uevent		= i2c_device_uevent,
 	.release	= i2c_client_dev_release,
 };
+EXPORT_SYMBOL_GPL(i2c_client_type);
 
 
 /**
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 2cc3988d127b..89ca5e56b433 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -37,6 +37,7 @@
 
 extern struct bus_type i2c_bus_type;
 extern struct device_type i2c_adapter_type;
+extern struct device_type i2c_client_type;
 
 /* --- General options ------------------------------------------------	*/
 
-- 
2.12.0.246.ga2ecc84866-goog

