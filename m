From: tom_lin@emc.com.tw
Subject: [PATCH v3 3/3] Input:Elan I2C touchpad update FW tool
Date: Mon,  4 Jun 2012 17:20:26 +0800
Message-ID: <1338801626-1513-3-git-send-email-tom_lin@emc.com.tw>
References: <1338801626-1513-1-git-send-email-tom_lin@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:61642 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab2FDJUb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 05:20:31 -0400
In-Reply-To: <1338801626-1513-1-git-send-email-tom_lin@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, agnescheng@google.com, Tom Lin <tom_lin@emc.com.tw>, Aarom Huang <aaron_huang@emc.com.tw>

From: Tom Lin <tom_lin@emc.com.tw>

The patch adds the function of update firmware.

Cc: Aarom Huang <aaron_huang@emc.com.tw>
Signed-off-by: Tom Lin(Lin Yen Yu) <tom_lin@emc.com.tw>
---
 drivers/input/mouse/elantech_i2c.c |  292 +++++++++++++++++++++++++++++++++++-
 1 file changed, 291 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech_i2c.c b/drivers/input/mouse/elantech_i2c.c
index db701b0..db7e58d 100644
--- a/drivers/input/mouse/elantech_i2c.c
+++ b/drivers/input/mouse/elantech_i2c.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
+#include <linux/firmware.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -20,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/stat.h>
 #include <linux/workqueue.h>
 
 #define DRIVER_NAME		"elantech_i2c"
@@ -51,7 +53,12 @@ enum etd_i2c_command {
 	ETP_X_AXIS_MAX_CMD,
 	ETP_Y_AXIS_MAX_CMD,
 	ETP_DPI_VALUE_CMD,
-	ETP_ENABLE_ABS_CMD
+	ETP_DISABLE_PROTECT_CMD,
+	ETP_ENABLE_ABS_CMD,
+	ETP_ENABLE_IAP_CMD,
+	ETP_CHECK_ENABLE_IAP_CMD,
+	ETP_CHECK_IAP_STATUS_CMD,
+	ETP_RETRY_IAP_CMD
 };
 
 static const u8 etp_hid_descriptor_cmd[] = {0x01, 0x00};
@@ -62,7 +69,13 @@ static const u8 etp_trace_num_xy_cmd[] = {0x05, 0x01};
 static const u8 etp_x_axis_max_cmd[] = {0x06, 0x01};
 static const u8 etp_y_axis_max_cmd[] = {0x07, 0x01};
 static const u8 etp_dpi_value_cmd[] = {0x08, 0x01};
+static const u8 etp_disable_protect_cmd[] = {0x01, 0x03, 0x00, 0x00};
 static const u8 etp_enable_abs_cmd[] = {0x00, 0x03, 0x01, 0x00};
+static const u8 etp_enable_iap_cmd[] = {0x05, 0x03, 0x34, 0x12};
+static const u8 etp_check_enable_iap_cmd[] = {0x05, 0x03};
+static const u8 etp_check_iap_status_cmd[] = {0x04, 0x03};
+static const u8 etp_retry_iap_cmd[] = {0x06, 0x03};
+static const u8 etp_iap_check_sun_cmd[] = {0x03, 0x03};
 
 /* The main device structure */
 struct elantech_i2c {
@@ -75,6 +88,7 @@ struct elantech_i2c {
 	unsigned int		width_x;
 	unsigned int		width_y;
 	int			irq;
+	int			update_fw_flag;
 	u8			pre_recv[28];
 };
 
@@ -137,11 +151,39 @@ static int elantech_i2c_command(struct i2c_client *client, int  command,
 		msg[1].len = data_len;
 		msg_num = 2;
 		break;
+	case ETP_DISABLE_PROTECT_CMD:
+		cmd = etp_disable_protect_cmd;
+		length = sizeof(etp_disable_protect_cmd);
+		msg_num = 1;
+		break;
 	case ETP_ENABLE_ABS_CMD:
 		cmd = etp_enable_abs_cmd;
 		length = sizeof(etp_enable_abs_cmd);
 		msg_num = 1;
 		break;
+	case ETP_ENABLE_IAP_CMD:
+		cmd = etp_enable_iap_cmd;
+		length = sizeof(etp_enable_iap_cmd);
+		msg_num = 1;
+		break;
+	case ETP_CHECK_ENABLE_IAP_CMD:
+		cmd = etp_check_enable_iap_cmd;
+		length = sizeof(etp_check_enable_iap_cmd);
+		msg[1].len = data_len;
+		msg_num = 2;
+		break;
+	case ETP_CHECK_IAP_STATUS_CMD:
+		cmd = etp_check_iap_status_cmd;
+		length = sizeof(etp_check_iap_status_cmd);
+		msg[1].len = data_len;
+		msg_num = 2;
+		break;
+	case ETP_RETRY_IAP_CMD:
+		cmd = etp_retry_iap_cmd;
+		length = sizeof(etp_retry_iap_cmd);
+		msg[1].len = data_len;
+		msg_num = 2;
+		break;
 	default:
 		dev_dbg(&client->dev, "%s command=%d unknow.\n",
 			 __func__, command);
@@ -171,6 +213,225 @@ static int elantech_i2c_command(struct i2c_client *client, int  command,
 
 	return ret;
 }
+/*
+*******************************************************************************
+* Update firmware
+* below routines export interface to sysfs file system.
+*******************************************************************************
+*/
+
+#define ELAN_FW_NAME		"elantech_i2c.bin"
+#define ELAN_FW_PASSWORD_1	0x12
+#define ELAN_FW_PASSWORD_2	0x34
+#define ELAN_FW_IAP_REG_L	0x01
+#define ELAN_FW_IAP_REG_H	0x06
+#define ELAN_FW_UPDATE_TIME	40
+/* IAP IAP ROM start address */
+#define ELAN_IAP_ROM_ADDR	0x0580
+/* 1 Page = 128byte */
+#define ELAN_FW_PAGE		128
+/* IAP Controls Register address */
+#define ELAN_IAP_CTL_ADDR	0x0304
+#define ELAN_FW_PAGE_COUNT	256
+#define ELAN_FW_SIZE		(ELAN_FW_PAGE_COUNT * ELAN_FW_PAGE)
+
+static bool elantech_i2c_hw_init(struct i2c_client *client);
+
+static int elantech_i2c_check_fw(struct elantech_i2c *elantech_i2c,
+					const struct firmware *fw)
+{
+	struct device *dev = &elantech_i2c->client->dev;
+
+	/* Firmware must match exact 32768 bytes = 256 128-byte blocks */
+	if (fw->size != ELAN_FW_SIZE) {
+		dev_err(dev, "invalid firmware size = %zu, expectec %d \n",
+							fw->size, ELAN_FW_SIZE);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int elantech_i2c_enable_IAP_mdoe(struct elantech_i2c *elantech_i2c)
+{
+	struct i2c_client *client = elantech_i2c->client;
+	struct device *dev = &elantech_i2c->client->dev;
+	int ret;
+	u8  buf_recv[2];
+
+	ret = elantech_i2c_command(client, ETP_DISABLE_PROTECT_CMD, buf_recv,
+								ETP_INF_LENGTH);
+	if (ret < 0) {
+		dev_err(dev, "Disable protect command fail\n");
+		return -1;
+	}
+
+	ret = elantech_i2c_command(client, ETP_ENABLE_IAP_CMD, buf_recv,
+								ETP_INF_LENGTH);
+	if (ret < 0) {
+		dev_err(dev, "To Enable IAP command is fail\n");
+		return -1;
+	}
+
+	ret = elantech_i2c_command(client, ETP_CHECK_ENABLE_IAP_CMD, buf_recv,
+								ETP_INF_LENGTH);
+	dev_info(dev, "buf_recv[0] = 0x%02x, buf_recv[1] = 0x%02x \n",
+						      buf_recv[0], buf_recv[1]);
+	if (buf_recv[1] != ELAN_FW_PASSWORD_1 ||
+	    buf_recv[0] != ELAN_FW_PASSWORD_2) {
+		dev_err(dev, "To change IAP mode is fail.\n");
+		return -1;
+	}
+	msleep(ELAN_FW_UPDATE_TIME);
+
+	ret = elantech_i2c_command(client, ETP_CHECK_IAP_STATUS_CMD, buf_recv,
+								ETP_INF_LENGTH);
+	if (((buf_recv[0] & 0x01) == 1) && ret >= 0)
+		return 0;
+	else
+		return -1;
+}
+
+static int elantech_i2c_write_fw_block(struct elantech_i2c *elantech_i2c,
+				       u16 block, const u8 *data)
+{
+	struct device *dev = &elantech_i2c->client->dev;
+	int ret;
+	int repeat = 3;
+	u8 write_date[130];
+	u8 buf_recv[4];
+
+	write_date[0] = ELAN_FW_IAP_REG_L;
+	write_date[1] = ELAN_FW_IAP_REG_H;
+	memcpy(&write_date[2], data, ELAN_FW_PAGE);
+
+	do {
+		/* @count: ELAN_FW_PAGE + IAP_REG 2 byte */
+		ret = i2c_master_send(elantech_i2c->client, write_date,
+							    (ELAN_FW_PAGE + 2));
+		msleep(ELAN_FW_UPDATE_TIME);
+		ret = elantech_i2c_command(elantech_i2c->client,
+			    ETP_CHECK_IAP_STATUS_CMD, buf_recv, ETP_INF_LENGTH);
+
+		if ((~buf_recv[0] & 0x10) && ret >= 0)
+			break;
+
+		memcpy(buf_recv, etp_retry_iap_cmd, sizeof(etp_retry_iap_cmd));
+		buf_recv[2] = (block * ELAN_FW_PAGE / 2) & 0xff;
+		buf_recv[3] = (block * ELAN_FW_PAGE / 2) >> 8;
+		i2c_master_send(elantech_i2c->client, buf_recv,
+							      sizeof(buf_recv));
+
+		dev_err(dev, "IAP retry PAGE address = %02X%02X %02X%02X\n",
+			    buf_recv[0], buf_recv[1], buf_recv[2], buf_recv[3]);
+
+		repeat--;
+	} while (repeat == 0);
+
+	if (repeat > 0)
+		return 0;
+	else
+		return -1;
+
+}
+
+static int elantech_i2c_firmware(struct elantech_i2c *elantech_i2c)
+{
+	struct device *dev = &elantech_i2c->client->dev;
+	int ret;
+	const struct firmware *fw;
+	const char *fw_name = ELAN_FW_NAME;
+	int i, j;
+	u16 boot_page_count;
+	u8 buf_recv[2];
+	u16 checksum;
+
+	ret = request_firmware(&fw, ELAN_FW_NAME, dev);
+	if (ret) {
+		dev_err(dev, "Could not load firmware from %s, %d\n",
+			fw_name, ret);
+		return ret;
+	}
+
+	ret = elantech_i2c_check_fw(elantech_i2c, fw);
+	if (ret) {
+		dev_err(dev, "Invalid Elan firmware from %s, %d\n", fw_name,
+									   ret);
+		goto done;
+	}
+
+	ret = elantech_i2c_enable_IAP_mdoe(elantech_i2c);
+	if (ret) {
+		dev_err(dev, "Invalid Elan enalbe IAP fail %d \n", ret);
+		goto done;
+	}
+
+	checksum = 0;
+	elantech_i2c_command(elantech_i2c->client, ETP_RETRY_IAP_CMD, buf_recv,
+								ETP_INF_LENGTH);
+	boot_page_count = (buf_recv[0] | buf_recv[1] << 8) * 2 / ELAN_FW_PAGE;
+	dev_info(dev, "Elan FW AP_Code start addr :0x%02X%02X \n",
+						      buf_recv[1], buf_recv[0]);
+
+	for (i = 0 ; i < ELAN_FW_PAGE_COUNT ; i++) {
+		size_t block = i;
+		size_t addr  = i * ELAN_FW_PAGE;
+		const u8 *data = &fw->data[addr];
+
+		if (i >= boot_page_count) {
+			ret = elantech_i2c_write_fw_block(elantech_i2c, block,
+									  data);
+			if (ret)
+				return -1;
+		}
+
+		for (j = 0; j < ELAN_FW_PAGE ; j += 2)
+			checksum += ((data[j+1] << 8) | data[j]);
+
+	}
+	dev_info(dev, "FW checksum %04X\n", checksum);
+	ret = 0;
+done:
+	release_firmware(fw);
+	return ret;
+}
+
+static ssize_t elantech_i2c_fw_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct elantech_i2c *elantech_i2c = dev_get_drvdata(dev);
+	int ret;
+
+	disable_irq(elantech_i2c->irq);
+	ret = elantech_i2c_firmware(elantech_i2c);
+	if (ret)
+		dev_err(dev, "firmware update failed. %d\n", ret);
+	else {
+		dev_err(dev, "firmware update succeeded\n");
+		elantech_i2c->update_fw_flag = 1;
+	}
+
+	enable_irq(elantech_i2c->irq);
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, elantech_i2c_fw_store);
+static struct attribute *elantech_i2c_sysfs_entries[] = {
+	&dev_attr_update_fw.attr,
+	NULL,
+};
+
+static const struct attribute_group elantech_i2c_sysfs_group = {
+	.attrs = elantech_i2c_sysfs_entries,
+};
+
+/*
+*******************************************************************************
+* Elan HID over i2c trackpad input device driver
+*******************************************************************************
+*/
 
 static bool elantech_i2c_hw_init(struct i2c_client *client)
 {
@@ -290,9 +551,28 @@ u8 crc8_byten(u8 *data, unsigned int length)
 static irqreturn_t elantech_i2c_isr(int irq, void *dev_id)
 {
 	struct elantech_i2c *elantech_i2c_priv = dev_id;
+	struct device *dev = &elantech_i2c_priv->client->dev;
 	unsigned char buf_recv[ETP_PACKET_LENGTH];
 	int rc;
 
+
+	if (elantech_i2c_priv->update_fw_flag == 1) {
+		rc = i2c_master_recv(elantech_i2c_priv->client, buf_recv,
+							      ETP_INF_LENGTH);
+		dev_info(dev, "Update FW check interrupt : %02X%02X \n",
+						buf_recv[1], buf_recv[0]);
+		if (buf_recv[0] == 0x00 && buf_recv[1] == 0x00 && rc == 2) {
+			elantech_i2c_priv->update_fw_flag = 0;
+			disable_irq_nosync(elantech_i2c_priv->irq);
+			elantech_i2c_hw_init(elantech_i2c_priv->client);
+			elantech_i2c_command(elantech_i2c_priv->client,
+				ETP_ENABLE_ABS_CMD, buf_recv, ETP_INF_LENGTH);
+			enable_irq(elantech_i2c_priv->irq);
+		}
+
+		return  IRQ_HANDLED;
+	}
+
 	rc = i2c_master_recv(elantech_i2c_priv->client, buf_recv, ETP_PACKET_LENGTH);
 	if (rc != ETP_PACKET_LENGTH)
 		goto elantech_isr_end;
@@ -422,6 +702,7 @@ static int elantech_i2c_probe(struct i2c_client *client,
 		ret = -EINVAL;
 		goto err_hw_init;
 	}
+
 	elantech_i2c_priv = elantech_i2c_priv_create(client);
 	if (!elantech_i2c_priv) {
 		ret = -EINVAL;
@@ -435,6 +716,13 @@ static int elantech_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, elantech_i2c_priv);
 	device_init_wakeup(&client->dev, 1);
 
+	ret = sysfs_create_group(&client->dev.kobj, &elantech_i2c_sysfs_group);
+	if (ret < 0) {
+		dev_err(&client->dev, "Cannot register Elan I2C dev attribute %d",
+					ret);
+		goto err_input_register_device;
+	}
+
 	return 0;
 
 err_input_register_device:
@@ -457,6 +745,8 @@ static int elantech_i2c_remove(struct i2c_client *client)
 		free_irq(elantech_i2c_priv->irq, elantech_i2c_priv);
 		input_unregister_device(elantech_i2c_priv->input);
 		kfree(elantech_i2c_priv);
+		sysfs_remove_group(&client->dev.kobj,
+					&elantech_i2c_sysfs_group);
 	}
 
 	return 0;
-- 
1.7.9.2

