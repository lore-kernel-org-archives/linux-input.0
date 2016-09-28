From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 06/12] Input: synaptics-rmi4 - Add rmi_find_function()
Date: Wed, 28 Sep 2016 10:35:41 +0200
Message-ID: <1475051747-25988-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1475051747-25988-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752113AbcI1IgF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 04:36:05 -0400
In-Reply-To: <1475051747-25988-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

If a function needs to communicate with an other, it's better to have
a way to retrieve this other.

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/input/rmi4/rmi_driver.c | 13 +++++++++++++
 drivers/input/rmi4/rmi_driver.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index c83bce8..e210e8f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -181,6 +181,19 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 }
 EXPORT_SYMBOL_GPL(rmi_process_interrupt_requests);
 
+struct rmi_function *rmi_find_function(struct rmi_device *rmi_dev, u8 number)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_function *entry;
+
+	list_for_each_entry(entry, &data->function_list, node) {
+		if (entry->fd.function_number == number)
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int suspend_one_function(struct rmi_function *fn)
 {
 	struct rmi_function_handler *fh;
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index fe26aca..9da1ee4 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -95,6 +95,7 @@ bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
 bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
 void rmi_unregister_physical_driver(void);
+struct rmi_function *rmi_find_function(struct rmi_device *rmi_dev, u8 number);
 
 char *rmi_f01_get_product_ID(struct rmi_function *fn);
 
-- 
2.7.4

