From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v3 03/49] Input: atmel_mxt_ts - rework sysfs init/remove
Date: Tue, 17 Sep 2019 18:32:34 +0900
Message-ID: <20190917093320.18134-4-jiada_wang@mentor.com>
References: <20190917093320.18134-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917093320.18134-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

An error in the sysfs init may otherwise interfere with the async return
from the firmware loader

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
(cherry picked from ndyer/linux/for-upstream commit 3114584ae77c2b03b6dad87174f010d002e9c05d)
[gdavis: Forward port and fixup conflicts. Also fixed sysfs leaks in
	 both the mxt_initialize() and mxt_probe() error return cases.]
Signed-off-by: George G. Davis <george_davis@mentor.com>
[jiada: keep call mxt_initialize() before sysfs creation]
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 64 +++++++++++++++++++-----
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 573b94a049b2..17263c260124 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2086,10 +2086,14 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	return 0;
 
 err_free_mem:
+	data->input_dev = NULL;
 	input_free_device(input_dev);
 	return error;
 }
 
+static int mxt_sysfs_init(struct mxt_data *data);
+static void mxt_sysfs_remove(struct mxt_data *data);
+
 static int mxt_configure_objects(struct mxt_data *data,
 				 const struct firmware *cfg);
 
@@ -2141,16 +2145,24 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
 
+	error = mxt_sysfs_init(data);
+	if (error)
+		return error;
+
 	error = request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
 					&client->dev, GFP_KERNEL, data,
 					mxt_config_cb);
 	if (error) {
 		dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
 			error);
-		return error;
+		goto err_free_sysfs;
 	}
 
 	return 0;
+
+err_free_sysfs:
+	mxt_sysfs_remove(data);
+	return error;
 }
 
 static int mxt_set_t7_power_cfg(struct mxt_data *data, u8 sleep)
@@ -2803,6 +2815,7 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 		if (ret)
 			goto release_firmware;
 
+		mxt_sysfs_remove(data);
 		mxt_free_input_device(data);
 		mxt_free_object_table(data);
 	} else {
@@ -2909,16 +2922,25 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 	return count;
 }
 
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
+
+static struct attribute *mxt_fw_attrs[] = {
+	&dev_attr_update_fw.attr,
+	NULL
+};
+
+static const struct attribute_group mxt_fw_attr_group = {
+	.attrs = mxt_fw_attrs,
+};
+
 static DEVICE_ATTR(fw_version, S_IRUGO, mxt_fw_version_show, NULL);
 static DEVICE_ATTR(hw_version, S_IRUGO, mxt_hw_version_show, NULL);
 static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
 
 static struct attribute *mxt_attrs[] = {
 	&dev_attr_fw_version.attr,
 	&dev_attr_hw_version.attr,
 	&dev_attr_object.attr,
-	&dev_attr_update_fw.attr,
 	NULL
 };
 
@@ -2926,6 +2948,28 @@ static const struct attribute_group mxt_attr_group = {
 	.attrs = mxt_attrs,
 };
 
+static int mxt_sysfs_init(struct mxt_data *data)
+{
+	struct i2c_client *client = data->client;
+	int error;
+
+	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
+	if (error) {
+		dev_err(&client->dev, "Failure %d creating sysfs group\n",
+			error);
+		return error;
+	}
+
+	return 0;
+}
+
+static void mxt_sysfs_remove(struct mxt_data *data)
+{
+	struct i2c_client *client = data->client;
+
+	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
+}
+
 static void mxt_start(struct mxt_data *data)
 {
 	switch (data->suspend_mode) {
@@ -3113,19 +3157,14 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (error)
 		return error;
 
-	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
+	error = sysfs_create_group(&client->dev.kobj, &mxt_fw_attr_group);
 	if (error) {
-		dev_err(&client->dev, "Failure %d creating sysfs group\n",
+		dev_err(&client->dev, "Failure %d creating fw sysfs group\n",
 			error);
-		goto err_free_object;
+		return error;
 	}
 
 	return 0;
-
-err_free_object:
-	mxt_free_input_device(data);
-	mxt_free_object_table(data);
-	return error;
 }
 
 static int mxt_remove(struct i2c_client *client)
@@ -3133,7 +3172,8 @@ static int mxt_remove(struct i2c_client *client)
 	struct mxt_data *data = i2c_get_clientdata(client);
 
 	disable_irq(data->irq);
-	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
+	sysfs_remove_group(&client->dev.kobj, &mxt_fw_attr_group);
+	mxt_sysfs_remove(data);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
 
-- 
2.19.2
