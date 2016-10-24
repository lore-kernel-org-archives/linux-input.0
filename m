From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v5 6/7] Input: synaptics-rmi4 - add sysfs interfaces for hardware IDs
Date: Mon, 24 Oct 2016 22:51:56 +0100
Message-ID: <1477345917-25326-7-git-send-email-nick@shmanahar.org>
References: <1477345917-25326-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477345917-25326-1-git-send-email-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_driver.c |   2 +-
 drivers/input/rmi4/rmi_driver.h |   5 +-
 drivers/input/rmi4/rmi_f01.c    |  23 ++++++++-
 drivers/input/rmi4/rmi_f34.c    | 110 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ea62d7e..1bb2c7e 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -307,7 +307,7 @@ static void rmi_driver_set_input_name(struct rmi_device *rmi_dev,
 				struct input_dev *input)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	char *device_name = rmi_f01_get_product_ID(data->f01_container);
+	const char *device_name = rmi_f01_get_product_ID(data->f01_container);
 	char *name;
 
 	name = devm_kasprintf(&rmi_dev->dev, GFP_KERNEL,
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e627a3a..e22a77f 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -105,7 +105,10 @@ int rmi_init_functions(struct rmi_driver_data *data);
 int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
 		      const struct pdt_entry *pdt);
 
-char *rmi_f01_get_product_ID(struct rmi_function *fn);
+const char *rmi_f01_get_product_ID(struct rmi_function *fn);
+u8 rmi_f01_get_manufacturer_ID(struct rmi_function *fn);
+const char *rmi_f01_get_date_of_manufacture(struct rmi_function *fn);
+u32 rmi_f01_get_firmware_ID(struct rmi_function *fn);
 
 #ifdef CONFIG_RMI4_F34
 int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index b64d1cd..8624be8 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -241,13 +241,34 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
 	return 0;
 }
 
-char *rmi_f01_get_product_ID(struct rmi_function *fn)
+const char *rmi_f01_get_product_ID(struct rmi_function *fn)
 {
 	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
 
 	return f01->properties.product_id;
 }
 
+u8 rmi_f01_get_manufacturer_ID(struct rmi_function *fn)
+{
+	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
+
+	return f01->properties.manufacturer_id;
+}
+
+const char *rmi_f01_get_date_of_manufacture(struct rmi_function *fn)
+{
+	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
+
+	return f01->properties.dom;
+}
+
+u32 rmi_f01_get_firmware_ID(struct rmi_function *fn)
+{
+	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
+
+	return f01->properties.firmware_id;
+}
+
 #ifdef CONFIG_OF
 static int rmi_f01_of_probe(struct device *dev,
 				struct rmi_device_platform_data *pdata)
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 9124a1e..1a5aed9 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -384,6 +384,110 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	return ret;
 }
 
+static ssize_t rmi_driver_manufacturer_id_show(struct device *dev,
+					       struct device_attribute *dattr,
+					       char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct rmi_function *fn = data->f01_container;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 rmi_f01_get_manufacturer_ID(fn));
+}
+
+static DEVICE_ATTR(manufacturer_id, 0444,
+		   rmi_driver_manufacturer_id_show, NULL);
+
+static ssize_t rmi_driver_dom_show(struct device *dev,
+				   struct device_attribute *dattr, char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct rmi_function *fn = data->f01_container;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 rmi_f01_get_date_of_manufacture(fn));
+}
+
+static DEVICE_ATTR(date_of_manufacture, 0444, rmi_driver_dom_show, NULL);
+
+static ssize_t rmi_driver_product_id_show(struct device *dev,
+					  struct device_attribute *dattr,
+					  char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct rmi_function *fn = data->f01_container;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 rmi_f01_get_product_ID(fn));
+}
+
+static DEVICE_ATTR(product_id, 0444,
+		   rmi_driver_product_id_show, NULL);
+
+static ssize_t rmi_driver_firmware_id_show(struct device *dev,
+					   struct device_attribute *dattr,
+					   char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct rmi_function *fn = data->f01_container;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 rmi_f01_get_firmware_ID(fn));
+}
+
+static DEVICE_ATTR(firmware_id, 0444,
+		   rmi_driver_firmware_id_show, NULL);
+
+static ssize_t rmi_driver_bootloader_id_show(struct device *dev,
+					     struct device_attribute *dattr,
+					     char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct rmi_function *fn = data->f34_container;
+	struct f34_data *f34;
+
+	if (fn) {
+		f34 = dev_get_drvdata(&fn->dev);
+
+		if (f34->bl_version == BL_V5)
+			return scnprintf(buf, PAGE_SIZE, "%c%c\n",
+					 f34->bootloader_id[0],
+					 f34->bootloader_id[1]);
+		else
+			return scnprintf(buf, PAGE_SIZE, "V%d.%d\n",
+					 f34->bootloader_id[1],
+					 f34->bootloader_id[0]);
+	}
+
+	return 0;
+}
+
+static DEVICE_ATTR(bootloader_id, 0444,
+		   rmi_driver_bootloader_id_show, NULL);
+
+static ssize_t rmi_driver_configuration_id_show(struct device *dev,
+						struct device_attribute *dattr,
+						char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct rmi_function *fn = data->f34_container;
+	struct f34_data *f34;
+
+	if (fn) {
+		f34 = dev_get_drvdata(&fn->dev);
+
+		return scnprintf(buf, PAGE_SIZE, "%s\n", f34->configuration_id);
+	}
+
+	return 0;
+}
+
+static DEVICE_ATTR(configuration_id, 0444,
+		   rmi_driver_configuration_id_show, NULL);
+
+static int rmi_firmware_update(struct rmi_driver_data *data,
+			       const struct firmware *fw);
+
 static ssize_t rmi_driver_update_fw_store(struct device *dev,
 					  struct device_attribute *dattr,
 					  const char *buf, size_t count)
@@ -435,6 +539,12 @@ static DEVICE_ATTR(update_fw_status, 0444,
 		   rmi_driver_update_fw_status_show, NULL);
 
 static struct attribute *rmi_firmware_attrs[] = {
+	&dev_attr_bootloader_id.attr,
+	&dev_attr_configuration_id.attr,
+	&dev_attr_manufacturer_id.attr,
+	&dev_attr_date_of_manufacture.attr,
+	&dev_attr_product_id.attr,
+	&dev_attr_firmware_id.attr,
 	&dev_attr_update_fw.attr,
 	&dev_attr_update_fw_status.attr,
 	NULL
-- 
2.7.4
