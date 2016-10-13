From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 12/18] Input: synaptics-rmi4 - Add rmi_find_function()
Date: Thu, 13 Oct 2016 17:51:06 +0200
Message-ID: <1476373872-18027-13-git-send-email-benjamin.tissoires@redhat.com>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756194AbcJMPvr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 11:51:47 -0400
In-Reply-To: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

If a function needs to communicate with an other, it's better to have
a way to retrieve this other.

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

no changes in v2
---
 drivers/input/rmi4/rmi_driver.c | 13 +++++++++++++
 drivers/input/rmi4/rmi_driver.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index e3f674e..1d20c5b 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -219,6 +219,19 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
 	return 0;
 }
 
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

