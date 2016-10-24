From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v5 7/7] Input: synaptics-rmi4 - add package_id sysfs attribute
Date: Mon, 24 Oct 2016 22:51:57 +0100
Message-ID: <1477345917-25326-8-git-send-email-nick@shmanahar.org>
References: <1477345917-25326-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477345917-25326-1-git-send-email-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_driver.h |  1 +
 drivers/input/rmi4/rmi_f01.c    | 24 +++++++++++++++++++++++-
 drivers/input/rmi4/rmi_f34.c    | 16 ++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e22a77f..85cdb70 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -109,6 +109,7 @@ const char *rmi_f01_get_product_ID(struct rmi_function *fn);
 u8 rmi_f01_get_manufacturer_ID(struct rmi_function *fn);
 const char *rmi_f01_get_date_of_manufacture(struct rmi_function *fn);
 u32 rmi_f01_get_firmware_ID(struct rmi_function *fn);
+u32 rmi_f01_get_package_ID(struct rmi_function *fn);
 
 #ifdef CONFIG_RMI4_F34
 int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 8624be8..463c810 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -54,6 +54,7 @@ struct f01_basic_properties {
 	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
 	u16 productinfo;
 	u32 firmware_id;
+	u32 package_id;
 };
 
 /* F01 device status bits */
@@ -220,8 +221,22 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
 			has_build_id_query = !!(queries[0] & BIT(1));
 		}
 
-		if (has_package_id_query)
+		if (has_package_id_query) {
+			ret = rmi_read_block(rmi_dev, prod_info_addr,
+					     queries, 4);
+			if (ret) {
+				dev_err(&rmi_dev->dev,
+					"Failed to read package info: %d\n",
+					ret);
+				return ret;
+			}
+
+			props->package_id = queries[3] << 24 |
+					    queries[2] << 16 |
+					    queries[1] << 8 |
+					    queries[0];
 			prod_info_addr++;
+		}
 
 		if (has_build_id_query) {
 			ret = rmi_read_block(rmi_dev, prod_info_addr, queries,
@@ -269,6 +284,13 @@ u32 rmi_f01_get_firmware_ID(struct rmi_function *fn)
 	return f01->properties.firmware_id;
 }
 
+u32 rmi_f01_get_package_ID(struct rmi_function *fn)
+{
+	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
+
+	return f01->properties.package_id;
+}
+
 #ifdef CONFIG_OF
 static int rmi_f01_of_probe(struct device *dev,
 				struct rmi_device_platform_data *pdata)
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 1a5aed9..6cad9fe 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -485,6 +485,21 @@ static ssize_t rmi_driver_configuration_id_show(struct device *dev,
 static DEVICE_ATTR(configuration_id, 0444,
 		   rmi_driver_configuration_id_show, NULL);
 
+static ssize_t rmi_driver_package_id_show(struct device *dev,
+					  struct device_attribute *dattr,
+					  char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct rmi_function *fn = data->f01_container;
+
+	u32 package_id = rmi_f01_get_package_ID(fn);
+
+	return scnprintf(buf, PAGE_SIZE, "%04x.%04x\n",
+			 package_id & 0xffff, (package_id >> 16) & 0xffff);
+}
+
+static DEVICE_ATTR(package_id, 0444, rmi_driver_package_id_show, NULL);
+
 static int rmi_firmware_update(struct rmi_driver_data *data,
 			       const struct firmware *fw);
 
@@ -544,6 +559,7 @@ static struct attribute *rmi_firmware_attrs[] = {
 	&dev_attr_manufacturer_id.attr,
 	&dev_attr_date_of_manufacture.attr,
 	&dev_attr_product_id.attr,
+	&dev_attr_package_id.attr,
 	&dev_attr_firmware_id.attr,
 	&dev_attr_update_fw.attr,
 	&dev_attr_update_fw_status.attr,
-- 
2.7.4
