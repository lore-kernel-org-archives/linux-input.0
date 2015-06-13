From: HungNien Chen <hn.chen@weidahitech.com>
Subject: [PATCH v6] Input: add a driver for wdt87xx touchscreen controller
Date: Sat, 13 Jun 2015 14:37:16 +0800
Message-ID: <1434177436-20788-1-git-send-email-hn.chen@weidahitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:1508 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbFMGiz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Jun 2015 02:38:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

Below is the modification this version:
1. remove the union structure declaration and use the buffer and offset to manupulate data
2. remove redundant comments and debug messages
3. remove useless include files
4. modify some inproper messages
5. have a reliable value for the checksum delay
6. modify some data structure declaration and shorten names of some variables
7. modify functions of request_irq and create_input_device to be more reasonable

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/Kconfig       |   12 +
 drivers/input/touchscreen/Makefile      |    1 +
 drivers/input/touchscreen/wdt87xx_i2c.c | 1328 +++++++++++++++++++++++++++++++
 3 files changed, 1341 insertions(+)
 create mode 100644 drivers/input/touchscreen/wdt87xx_i2c.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 80f6386..0c1a6cc 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -658,6 +658,18 @@ config TOUCHSCREEN_PIXCIR
 	  To compile this driver as a module, choose M here: the
 	  module will be called pixcir_i2c_ts.
 
+config TOUCHSCREEN_WDT87XX_I2C
+	tristate "Weida HiTech I2C touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have an Weida WDT87XX I2C touchscreen
+	  connected to your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called wdt87xx_i2c.
+
 config TOUCHSCREEN_WM831X
 	tristate "Support for WM831x touchscreen controllers"
 	depends on MFD_WM831X
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 44deea7..fa3d33b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+= wacom_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_WDT87XX_I2C)	+= wdt87xx_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_WM831X)	+= wm831x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
new file mode 100644
index 0000000..c8ec8b9
--- /dev/null
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -0,0 +1,1328 @@
+/*
+ * Weida HiTech WDT87xx TouchScreen I2C driver
+ *
+ * Copyright (c) 2015  Weida Hi-Tech Co., Ltd.
+ * HN Chen <hn.chen@weidahitech.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/firmware.h>
+#include <linux/input/mt.h>
+#include <linux/acpi.h>
+#include <asm/unaligned.h>
+
+#define WDT87XX_NAME		"wdt87xx_i2c"
+#define	WDT87XX_DRV_VER		"0.9.5"
+#define	WDT87XX_FW_NAME		"wdt87xx_fw.bin"
+
+#define	WDT87XX_FW			1
+#define	WDT87XX_CFG			2
+
+#define MODE_ACTIVE			0x01
+#define MODE_READY			0x02
+#define MODE_IDLE			0x03
+#define MODE_SLEEP			0x04
+#define	MODE_STOP			0xFF
+
+#define	WDT_PKT_V0			0
+#define	WDT_PKT_V1			1
+
+#define WDT_MAX_FINGER			10
+#define	WDT_RAW_BUF_COUNT		54
+#define	WDT_V1_RAW_BUF_COUNT		74
+#define WDT_FIRMWARE_ID			0xa9e368f5
+
+#define	PG_SIZE				0x1000
+#define MAX_RETRIES			3
+
+#define	MAX_UNIT_AXIS			0x7FFF
+
+#define	PKT_READ_SIZE			72
+#define	PKT_WRITE_SIZE			80
+
+/* the finger definition of the report event */
+#define	FINGER_EV_OFFSET_ID		0
+#define	FINGER_EV_OFFSET_X		1
+#define	FINGER_EV_OFFSET_Y		3
+#define	FINGER_EV_SIZE			5
+
+#define	FINGER_EV_V1_OFFSET_ID		0
+#define	FINGER_EV_V1_OFFSET_W		1
+#define	FINGER_EV_V1_OFFSET_H		2
+#define	FINGER_EV_V1_OFFSET_X		3
+#define	FINGER_EV_V1_OFFSET_Y		5
+#define	FINGER_EV_V1_SIZE		7
+
+/* the definition of a report packet */
+#define	TOUCH_PK_OFFSET_REPORT_ID	0
+#define	TOUCH_PK_OFFSET_EVENT		1
+#define TOUCH_PK_OFFSET_SCAN_TIME	51
+#define	TOUCH_PK_OFFSET_FNGR_NUM	53
+
+#define	TOUCH_PK_V1_OFFSET_REPORT_ID	0
+#define	TOUCH_PK_V1_OFFSET_EVENT	1
+#define TOUCH_PK_V1_OFFSET_SCAN_TIME	71
+#define	TOUCH_PK_V1_OFFSET_FNGR_NUM	73
+
+/* the definition of the controller parameters */
+#define	CTL_PARAM_OFFSET_FW_ID		0
+#define	CTL_PARAM_OFFSET_PLAT_ID	2
+#define	CTL_PARAM_OFFSET_XMLS_ID1	4
+#define	CTL_PARAM_OFFSET_XMLS_ID2	6
+#define	CTL_PARAM_OFFSET_PHY_CH_X	8
+#define	CTL_PARAM_OFFSET_PHY_CH_Y	10
+#define	CTL_PARAM_OFFSET_PHY_X0		12
+#define	CTL_PARAM_OFFSET_PHY_X1		14
+#define	CTL_PARAM_OFFSET_PHY_Y0		16
+#define	CTL_PARAM_OFFSET_PHY_Y1		18
+#define	CTL_PARAM_OFFSET_PHY_W		22
+#define	CTL_PARAM_OFFSET_PHY_H		24
+
+/* communication commands */
+#define	PACKET_SIZE			56
+#define	VND_REQ_READ			0x06
+#define	VND_READ_DATA			0x07
+#define	VND_REQ_WRITE			0x08
+
+#define VND_CMD_START			0x00
+#define VND_CMD_STOP			0x01
+#define VND_CMD_RESET			0x09
+
+#define VND_CMD_ERASE			0x1A
+
+#define	VND_GET_CHECKSUM		0x66
+
+#define	VND_SET_DATA			0x83
+#define	VND_SET_COMMAND_DATA		0x84
+#define	VND_SET_CHECKSUM_CALC		0x86
+#define	VND_SET_CHECKSUM_LENGTH		0x87
+
+#define VND_CMD_SFLCK			0xFC
+#define VND_CMD_SFUNL			0xFD
+
+#define	CMD_SFLCK_KEY			0xC39B
+#define	CMD_SFUNL_KEY			0x95DA
+
+#define	STRIDX_PLATFORM_ID		0x80
+#define	STRIDX_PARAMETERS		0x81
+
+#define	CMD_BUF_SIZE			8
+#define	PKT_BUF_SIZE			64
+
+/* the definition of the command packet */
+#define	CMD_REPORT_ID_OFFSET		0x0
+#define	CMD_TYPE_OFFSET			0x1
+#define	CMD_INDEX_OFFSET		0x2
+#define	CMD_KEY_OFFSET			0x3
+#define	CMD_LENGTH_OFFSET		0x4
+#define	CMD_DATA_OFFSET			0x8
+
+/* the definition of firmware chunk tags */
+#define	FOURCC_ID_RIFF			0x46464952
+#define	FOURCC_ID_WHIF			0x46494857
+#define	FOURCC_ID_FRMT			0x544D5246
+#define	FOURCC_ID_FRWR			0x52575246
+#define	FOURCC_ID_CNFG			0x47464E43
+
+#define	CHUNK_ID_FRMT			FOURCC_ID_FRMT
+#define	CHUNK_ID_FRWR			FOURCC_ID_FRWR
+#define	CHUNK_ID_CNFG			FOURCC_ID_CNFG
+
+struct sys_param {
+	u16	fw_id;
+	u16	plat_id;
+	u16	xmls_id1;
+	u16	xmls_id2;
+	u16	phy_ch_x;
+	u16	phy_ch_y;
+	u16	phy_w;
+	u16	phy_h;
+};
+
+/* the definition for this driver needed */
+struct wdt_ts_data {
+	struct i2c_client	*client;
+	struct input_dev	*input_dev;
+/* to protect the operation in sysfs */
+	struct mutex		sysfs_mutex;
+	struct sys_param	param;
+	u8			phys[32];
+	u32			packet_type;
+	u32			max_x;
+	u32			max_y;
+};
+
+/* the definition of firmware data structure */
+struct chunk_info {
+	u32	target_start_addr;
+	u32	length;
+	u32	source_start_addr;
+	u32	version_number;
+	u32	attribute;
+	u32	temp;
+};
+
+struct chunk_data {
+	u32	ck_id;
+	u32	ck_size;
+	struct chunk_info	chunk_info;
+	u8	*data;
+};
+
+struct format_chunk {
+	u32	ck_id;
+	u32	ck_size;
+	u32	number_chunk;
+	u32	enable_flag;
+	u32	checksum;
+	u32	temp1;
+	u32	temp2;
+};
+
+struct chunk_info_ex {
+	struct chunk_info	chunk_info;
+	u8	*data;
+	u32	length;
+};
+
+static int wdt87xx_i2c_txrxdata(struct i2c_client *client, char *txdata,
+				int txlen, char *rxdata, int rxlen);
+static int wdt87xx_i2c_rxdata(struct i2c_client *client, char *rxdata,
+			      int length);
+static int wdt87xx_i2c_txdata(struct i2c_client *client, char *txdata,
+			      int length);
+static int wdt87xx_set_feature(struct i2c_client *client, u8 *buf,
+			       u32 buf_size);
+static int wdt87xx_get_feature(struct i2c_client *client, u8 *buf,
+			       u32 buf_size);
+static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
+			      u8 *buf, u32 buf_size);
+
+static int get_chunk_info(const struct firmware *fw, u32 chunk_four_cc,
+			  struct chunk_info_ex *fw_chunk_info,
+			  struct format_chunk *wif_format_chunk)
+{
+	const char	*data;
+	u32	data_len;
+	bool	is_found = 0;
+	u32	start_pos;
+	struct chunk_data	chunk;
+	u32	ck_id, ck_size;
+
+	data = fw->data;
+	data_len = fw->size;
+
+	/* check if the chunk is existed */
+	start_pos = 12 + sizeof(struct format_chunk);
+
+	while (start_pos < data_len && !is_found)	{
+		ck_id = get_unaligned_le32(&data[start_pos]);
+		ck_size = get_unaligned_le32(&data[start_pos + 4]);
+
+		/* the chunk is found */
+		if (ck_id == chunk_four_cc) {
+			chunk.ck_id = ck_id;
+			chunk.ck_size = ck_size;
+
+			chunk.data = (u8 *)&data[start_pos + 8
+				+ sizeof(struct chunk_info)];
+			chunk.chunk_info.target_start_addr =
+				get_unaligned_le32(&data[start_pos + 8]);
+			chunk.chunk_info.length =
+				get_unaligned_le32(&data[start_pos + 12]);
+			chunk.chunk_info.source_start_addr =
+				get_unaligned_le32(&data[start_pos + 16]);
+			chunk.chunk_info.version_number =
+				get_unaligned_le32(&data[start_pos + 20]);
+			chunk.chunk_info.attribute =
+				get_unaligned_le32(&data[start_pos + 24]);
+			chunk.chunk_info.temp =
+				get_unaligned_le32(&data[start_pos + 28]);
+
+			memcpy(&fw_chunk_info->chunk_info, &chunk.chunk_info,
+			       sizeof(struct chunk_info));
+			fw_chunk_info->length = chunk.chunk_info.length;
+			fw_chunk_info->data = chunk.data;
+
+			is_found = 1;
+		} else {
+			start_pos = start_pos + ck_size + 8;
+		}
+	}
+
+	if (is_found)
+		return 0;
+
+	return -ENODATA;
+}
+
+static int wdt87xx_get_sysparam(struct i2c_client *client)
+{
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+	struct sys_param *ctr_param = &wdt_dev->param;
+	u8	buffer[PKT_READ_SIZE];
+	int	err;
+
+	err = wdt87xx_get_string(client, STRIDX_PARAMETERS, buffer, 32);
+	if (err) {
+		dev_err(&client->dev, "get parameters failed\n");
+		return err;
+	}
+
+	ctr_param->xmls_id1 =
+		get_unaligned_le16(buffer + CTL_PARAM_OFFSET_XMLS_ID1);
+	ctr_param->xmls_id2 =
+		get_unaligned_le16(buffer + CTL_PARAM_OFFSET_XMLS_ID2);
+	ctr_param->phy_ch_x =
+		get_unaligned_le16(buffer + CTL_PARAM_OFFSET_PHY_CH_X);
+	ctr_param->phy_ch_y =
+		get_unaligned_le16(buffer + CTL_PARAM_OFFSET_PHY_CH_Y);
+	ctr_param->phy_w =
+		(get_unaligned_le16(buffer + CTL_PARAM_OFFSET_PHY_W) / 10);
+	ctr_param->phy_h =
+		(get_unaligned_le16(buffer + CTL_PARAM_OFFSET_PHY_H) / 10);
+
+	err = wdt87xx_get_string(client, STRIDX_PLATFORM_ID, buffer, 8);
+	if (err) {
+		dev_err(&client->dev, "get platform id failed\n");
+		return err;
+	}
+
+	ctr_param->plat_id = buffer[1];
+
+	buffer[0] = 0xf2;
+	err = wdt87xx_get_feature(client, buffer, 16);
+	if (err) {
+		dev_err(&client->dev, "get firmware id failed\n");
+		return err;
+	}
+
+	if (buffer[0] != 0xf2) {
+		dev_err(&client->dev, "wrong id of this packet: (0x%x)\n",
+			buffer[0]);
+		return -EINVAL;
+	}
+
+	ctr_param->fw_id = get_unaligned_le16(&buffer[1]);
+
+	if ((ctr_param->fw_id & 0xFFF) > 0x335)
+		wdt_dev->packet_type = WDT_PKT_V1;
+	else
+		wdt_dev->packet_type = WDT_PKT_V0;
+
+	dev_info(&client->dev,
+		 "fw_id: 0x%x, plat_id: 0x%x\nxml_id1: %4x, xml_id2: %4x\n",
+		 ctr_param->fw_id, ctr_param->plat_id,
+		 ctr_param->xmls_id1, ctr_param->xmls_id2);
+
+	return 0;
+}
+
+static int process_fw_data(struct i2c_client *client, const struct firmware *fw,
+			   struct format_chunk *wif_format_chunk)
+{
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+	struct chunk_info_ex	fw_chunk_info;
+	const u8	*data_buf;
+	int	err;
+	u32	length;
+	u8	fw_id;
+	u8	chip_id;
+	u32	data1, data2;
+
+	data_buf = fw->data;
+	length = fw->size;
+
+	data1 = get_unaligned_le32(data_buf);
+	data2 = get_unaligned_le32(data_buf + 8);
+	if (data1 != FOURCC_ID_RIFF || data2 != FOURCC_ID_WHIF) {
+		dev_err(&client->dev, "check fw tag failed\n");
+		return -EINVAL;
+	}
+
+	/* the length should be equal */
+	data1 = get_unaligned_le32(data_buf + 4);
+	if (data1 != length) {
+		dev_err(&client->dev, "check fw length failed\n");
+		return -EINVAL;
+	}
+
+	wif_format_chunk->ck_id = get_unaligned_le32(data_buf + 12);
+	wif_format_chunk->ck_size = get_unaligned_le32(data_buf + 16);
+	wif_format_chunk->number_chunk = get_unaligned_le32(data_buf + 20);
+	wif_format_chunk->enable_flag = get_unaligned_le32(data_buf + 24);
+	wif_format_chunk->checksum = get_unaligned_le32(data_buf + 28);
+	wif_format_chunk->temp1 = get_unaligned_le32(data_buf + 32);
+	wif_format_chunk->temp2 = get_unaligned_le32(data_buf + 36);
+
+	dev_info(&client->dev, "version check\n");
+
+	/* get the version number from the firmware */
+	err = get_chunk_info(fw, CHUNK_ID_FRWR, &fw_chunk_info,
+			     wif_format_chunk);
+	if (err) {
+		dev_err(&client->dev, "extract fw failed\n");
+		return -EBADR;
+	}
+
+	fw_id = ((fw_chunk_info.chunk_info.version_number >> 12) & 0xF);
+	chip_id = (((wdt_dev->param.fw_id) >> 12) & 0xF);
+
+	if (fw_id != chip_id) {
+		dev_err(&client->dev, "fw is not match: fw(%d), chip(%d)\n",
+			fw_id, chip_id);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/* functions for the sysfs implementation */
+static int wdt87xx_check_firmware(struct chunk_info_ex *fw_chunk_info,
+				  int ck_id)
+{
+	if (ck_id == CHUNK_ID_FRWR) {
+		u32 fw_id;
+
+		fw_id = get_unaligned_le32(fw_chunk_info->data);
+		if (fw_id == WDT_FIRMWARE_ID)
+			return 0;
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_set_feature(struct i2c_client *client, u8 *buf,
+			       u32 buf_size)
+{
+	int	err;
+	int	data_len = 0;
+	/* for set/get packets used */
+	u8	xfer_buffer[PKT_WRITE_SIZE];
+
+	/* set feature command packet */
+	xfer_buffer[data_len++] = 0x22;
+	xfer_buffer[data_len++] = 0x00;
+	if (buf[CMD_REPORT_ID_OFFSET] > 0xF) {
+		xfer_buffer[data_len++] = 0x30;
+		xfer_buffer[data_len++] = 0x03;
+		xfer_buffer[data_len++] = buf[CMD_REPORT_ID_OFFSET];
+	} else {
+		xfer_buffer[data_len++] = 0x30 | buf[CMD_REPORT_ID_OFFSET];
+		xfer_buffer[data_len++] = 0x03;
+	}
+	xfer_buffer[data_len++] = 0x23;
+	xfer_buffer[data_len++] = 0x00;
+	xfer_buffer[data_len++] = (buf_size & 0xFF);
+	xfer_buffer[data_len++] = ((buf_size & 0xFF00) >> 8);
+
+	memcpy(&xfer_buffer[data_len], buf, buf_size);
+
+	err = wdt87xx_i2c_txdata(client, xfer_buffer, data_len + buf_size);
+
+	if (err < 0) {
+		dev_err(&client->dev, "set feature failed\n");
+		return err;
+	}
+
+	mdelay(2);
+
+	return 0;
+}
+
+static int wdt87xx_get_feature(struct i2c_client *client, u8 *buf,
+			       u32 buf_size)
+{
+	int	err;
+	u8	tx_buffer[8];
+	u8	xfer_buffer[PKT_WRITE_SIZE];
+	int	data_len = 0;
+	u32	xfer_length = 0;
+
+	/* get feature command packet */
+	tx_buffer[data_len++] = 0x22;
+	tx_buffer[data_len++] = 0x00;
+	if (buf[CMD_REPORT_ID_OFFSET] > 0xF) {
+		tx_buffer[data_len++] = 0x30;
+		tx_buffer[data_len++] = 0x02;
+		tx_buffer[data_len++] = buf[CMD_REPORT_ID_OFFSET];
+	} else {
+		tx_buffer[data_len++] = 0x30 | buf[CMD_REPORT_ID_OFFSET];
+		tx_buffer[data_len++] = 0x02;
+	}
+	tx_buffer[data_len++] = 0x23;
+	tx_buffer[data_len++] = 0x00;
+
+	err = wdt87xx_i2c_txrxdata(client, tx_buffer, data_len, xfer_buffer,
+				   buf_size + 2);
+
+	if (err < 0) {
+		dev_err(&client->dev, "get feature failed\n");
+		return err;
+	}
+
+	/* check size and copy the return data */
+	xfer_length = get_unaligned_le16(xfer_buffer);
+
+	if (buf_size < xfer_length)
+		xfer_length = buf_size;
+
+	memcpy(buf, &xfer_buffer[2], xfer_length);
+
+	mdelay(2);
+
+	return 0;
+}
+
+static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
+			      u8 *buf, u32 buf_size)
+{
+	int	err;
+	u8	tx_buffer[8] = { 0x22, 0x00, 0x13, 0x0E,
+		0x00, 0x23, 0x00, 0x00 };
+	u8	xfer_buffer[PKT_WRITE_SIZE];
+	u32	xfer_length;
+
+	tx_buffer[4] = str_idx;
+
+	err = wdt87xx_i2c_txrxdata(client, tx_buffer, 7, xfer_buffer,
+				   buf_size + 2);
+
+	if (err < 0) {
+		dev_err(&client->dev, "get string failed\n");
+		return err;
+	}
+
+	if (xfer_buffer[1] != 0x03) {
+		dev_err(&client->dev, "wrong packet id: (%d)\n",
+			xfer_buffer[1]);
+		return -EINVAL;
+	}
+
+	xfer_length = xfer_buffer[0];
+
+	if (buf_size < xfer_length)
+		xfer_length = buf_size;
+
+	memcpy(buf, &xfer_buffer[2], xfer_length);
+
+	mdelay(2);
+
+	return 0;
+}
+
+static int wdt87xx_send_command(struct i2c_client *client, int cmd, int value)
+{
+	u8		cmd_buf[CMD_BUF_SIZE];
+
+	/* set the command packet */
+	cmd_buf[CMD_REPORT_ID_OFFSET] = VND_REQ_WRITE;
+	cmd_buf[CMD_TYPE_OFFSET] = VND_SET_COMMAND_DATA;
+	put_unaligned_le16((u16)cmd, &cmd_buf[CMD_INDEX_OFFSET]);
+
+	switch (cmd)	{
+	case	VND_CMD_START:
+	case	VND_CMD_STOP:
+	case	VND_CMD_RESET:
+		/* mode selector */
+		put_unaligned_le32((value & 0xFF), &cmd_buf[CMD_LENGTH_OFFSET]);
+		break;
+	case	VND_CMD_SFLCK:
+		put_unaligned_le16(CMD_SFLCK_KEY, &cmd_buf[CMD_KEY_OFFSET]);
+		break;
+	case	VND_CMD_SFUNL:
+		put_unaligned_le16(CMD_SFUNL_KEY, &cmd_buf[CMD_KEY_OFFSET]);
+		break;
+	case	VND_CMD_ERASE:
+	case	VND_SET_CHECKSUM_CALC:
+	case	VND_SET_CHECKSUM_LENGTH:
+		put_unaligned_le32(value, &cmd_buf[CMD_KEY_OFFSET]);
+		break;
+	default:
+		cmd_buf[CMD_REPORT_ID_OFFSET] = 0;
+		dev_err(&client->dev, "Invalid command: (%d)", cmd);
+		return -EINVAL;
+	}
+
+	return wdt87xx_set_feature(client, cmd_buf, sizeof(cmd_buf));
+}
+
+static int wdt87xx_write_data(struct i2c_client *client, const char *data,
+			      u32 address, int length)
+{
+	u32	addr_start, data_len;
+	u16	packet_size;
+	int	count = 0;
+	int	err;
+	const char	*source_data = 0;
+	u8	pkt_buf[PKT_BUF_SIZE];
+
+	source_data = data;
+	data_len = length;
+	addr_start = address;
+
+	/* address and length should be 4 bytes aligned */
+	if ((addr_start & 0x3) != 0 || (data_len & 0x3) != 0)	{
+		dev_err(&client->dev, "addr & len must be 4 bytes aligned %x, %x\n",
+			addr_start, data_len);
+		return -EFAULT;
+	}
+
+	packet_size = PACKET_SIZE;
+
+	pkt_buf[CMD_REPORT_ID_OFFSET] = VND_REQ_WRITE;
+	pkt_buf[CMD_TYPE_OFFSET] = VND_SET_DATA;
+
+	while (data_len) {
+		if (data_len < PACKET_SIZE)
+			packet_size = data_len;
+
+		put_unaligned_le16(packet_size,	&pkt_buf[CMD_INDEX_OFFSET]);
+		put_unaligned_le32(addr_start, &pkt_buf[CMD_LENGTH_OFFSET]);
+
+		memcpy(&pkt_buf[CMD_DATA_OFFSET], source_data, packet_size);
+
+		err = wdt87xx_set_feature(client, pkt_buf, sizeof(pkt_buf));
+
+		if (err)
+			break;
+
+		data_len = data_len - packet_size;
+		source_data = source_data + packet_size;
+		addr_start = addr_start + packet_size;
+
+		count++;
+		mdelay(4);
+
+		if ((count % 32) == 0)	{
+			count = 0;
+			msleep(20);
+		}
+	}
+
+	return err;
+}
+
+static u16 misr(u16 cur_value, u8 new_value)
+{
+	u32 a, b;
+	u32 bit0;
+	u32 y;
+
+	a = cur_value;
+	b = new_value;
+	bit0 = a ^ (b & 1);
+	bit0 ^= a >> 1;
+	bit0 ^= a >> 2;
+	bit0 ^= a >> 4;
+	bit0 ^= a >> 5;
+	bit0 ^= a >> 7;
+	bit0 ^= a >> 11;
+	bit0 ^= a >> 15;
+	y = (a << 1) ^ b;
+	y = (y & ~1) | (bit0 & 1);
+
+	return (u16)y;
+}
+
+static int wdt87xx_get_checksum(struct i2c_client *client, u32 *checksum,
+				u32 address, int length)
+{
+	int		err;
+	int		time_delay;
+	u8		pkt_buf[PKT_BUF_SIZE];
+	u8		cmd_buf[CMD_BUF_SIZE];
+
+	err = wdt87xx_send_command(client, VND_SET_CHECKSUM_LENGTH, length);
+	if (err) {
+		dev_err(&client->dev, "set checksum length failed\n");
+		return err;
+	}
+
+	err = wdt87xx_send_command(client, VND_SET_CHECKSUM_CALC, address);
+	if (err) {
+		dev_err(&client->dev, "calc checksum failed\n");
+		return err;
+	}
+
+	time_delay = (length + 1023) / 1024;
+	/* to wait for the operation to complete */
+	msleep(time_delay * 30);
+
+	memset(cmd_buf, 0, sizeof(cmd_buf));
+	cmd_buf[CMD_REPORT_ID_OFFSET] = VND_REQ_READ;
+	cmd_buf[CMD_TYPE_OFFSET] = VND_GET_CHECKSUM;
+	err = wdt87xx_set_feature(client, cmd_buf, sizeof(cmd_buf));
+	if (err) {
+		dev_err(&client->dev, "checksum set read failed\n");
+		return err;
+	}
+
+	memset(pkt_buf, 0, sizeof(pkt_buf));
+	pkt_buf[CMD_REPORT_ID_OFFSET] = VND_READ_DATA;
+	err = wdt87xx_get_feature(client, pkt_buf, sizeof(pkt_buf));
+	if (err) {
+		dev_err(&client->dev, "read checksum failed\n");
+		return err;
+	}
+
+	*checksum = get_unaligned_le16(&pkt_buf[CMD_DATA_OFFSET]);
+
+	return err;
+}
+
+static u16 fw_checksum(const u8 *data, u32 length)
+{
+	u32	i;
+	u16	checksum = 0;
+
+	for (i = 0; i < length; i++)
+		checksum = misr(checksum, data[i]);
+
+	return checksum;
+}
+
+static int wdt87xx_write_firmware(
+	struct i2c_client *client,
+	struct chunk_info_ex *fw_chunk_info, int type)
+{
+	int		err;
+	int		err1;
+	int		size;
+	int		start_addr;
+	int		page_size;
+	int		retry_count = 0;
+	int		is_equal = 0;
+	int		max_retries;
+	u32		calc_checksum = 0;
+	u32		read_checksum = 0;
+	const char	*data;
+
+	dev_info(&client->dev, "start 4k page program\n");
+
+	err = wdt87xx_send_command(client, VND_CMD_STOP, MODE_STOP);
+	if (err) {
+		dev_err(&client->dev, "stop report mode failed\n");
+		return err;
+	}
+
+	err = wdt87xx_send_command(client, VND_CMD_SFUNL, 0);
+	if (err) {
+		dev_err(&client->dev, "unlock failed\n");
+		goto write_fail;
+	}
+
+	mdelay(10);
+
+	start_addr = fw_chunk_info->chunk_info.target_start_addr;
+	size = fw_chunk_info->chunk_info.length;
+	data = fw_chunk_info->data;
+
+	max_retries = MAX_RETRIES;
+
+	dev_info(&client->dev, "%x, %x, %d\n", start_addr, size, max_retries);
+
+	while (size && !err) {
+		is_equal = 0;
+		if (size > PG_SIZE) {
+			page_size = PG_SIZE;
+			size = size - PG_SIZE;
+		} else {
+			page_size = size;
+			size = 0;
+		}
+
+		for (retry_count = 0; retry_count < max_retries && !is_equal;
+			retry_count++) {
+			err = wdt87xx_send_command(client, VND_CMD_ERASE,
+						   start_addr);
+			if (err) {
+				dev_err(&client->dev, "erase failed\n");
+				break;
+			}
+
+			msleep(50);
+
+			err = wdt87xx_write_data(client, data, start_addr,
+						 page_size);
+			if (err) {
+				dev_err(&client->dev, "write failed\n");
+				break;
+			}
+
+			read_checksum = 0;
+			err = wdt87xx_get_checksum(client, &read_checksum,
+						   start_addr, page_size);
+			if (err)
+				break;
+
+			calc_checksum = fw_checksum(data, page_size);
+
+			if (read_checksum == calc_checksum)
+				is_equal = 1;
+			else
+				dev_err(&client->dev,
+					"csum fail: (%d), (%d), (%d)\n",
+					retry_count,
+					read_checksum, calc_checksum);
+		}
+
+		if (retry_count == MAX_RETRIES) {
+			dev_err(&client->dev, "page write failed\n");
+			err = -EIO;
+		}
+
+		start_addr = start_addr + page_size;
+		data = data + page_size;
+		dev_info(&client->dev, "%x, %x\n", start_addr, size);
+	}
+write_fail:
+	err1 = wdt87xx_send_command(client, VND_CMD_SFLCK, 0);
+	if (err1)
+		dev_err(&client->dev, "lock failed\n");
+
+	mdelay(10);
+
+	err1 = wdt87xx_send_command(client, VND_CMD_START, 0);
+	if (err1)
+		dev_err(&client->dev, "start to report failed\n");
+
+	dev_info(&client->dev, "stop 4k page program : ");
+
+	if (err || err1)
+		dev_info(&client->dev, "fail\n");
+	else
+		dev_info(&client->dev, "pass\n");
+
+	if (err1)
+		return err1;
+
+	return err;
+}
+
+static int wdt87xx_sw_reset(struct i2c_client *client)
+{
+	int err;
+
+	dev_info(&client->dev, "reset device now\n");
+
+	err = wdt87xx_send_command(client, VND_CMD_RESET, 0);
+	if (err) {
+		dev_err(&client->dev, "reset failed\n");
+		return err;
+	}
+
+	/* wait the device to be ready */
+	msleep(200);
+
+	return 0;
+}
+
+static int wdt87xx_load_chunk(
+	struct i2c_client *client, const struct firmware *fw,
+	struct format_chunk *wif_format_chunk, u32 ck_id)
+{
+	int err;
+	struct chunk_info_ex	fw_chunk_info;
+
+	err = get_chunk_info(fw, ck_id, &fw_chunk_info, wif_format_chunk);
+	if (err) {
+		dev_err(&client->dev, "can not find the chunk\n");
+		goto failed;
+	}
+
+	/* check the bin file */
+	err = wdt87xx_check_firmware(&fw_chunk_info, ck_id);
+	if (err) {
+		dev_err(&client->dev, "check bin id: (%d)\n", ck_id);
+		goto failed;
+	}
+
+	err = wdt87xx_write_firmware(client, &fw_chunk_info, ck_id);
+	if (err)
+		dev_err(&client->dev, "write bin failed\n");
+
+failed:
+	return err;
+}
+
+static int wdt87xx_load_fw(struct device *dev, const char *fn, u8 type)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	const struct firmware *fw = 0;
+	int err;
+
+	struct format_chunk	wif_format_chunk;
+
+	err = request_firmware(&fw, fn, dev);
+	if (err) {
+		dev_err(&client->dev, "unable to open firmware %s: (%d)\n",
+			fn, err);
+		return err;
+	}
+
+	disable_irq(client->irq);
+
+	err = process_fw_data(client, fw, &wif_format_chunk);
+	if (err) {
+		dev_err(&client->dev, "bad fw file\n");
+		goto release_firmware;
+	}
+
+	if (type & WDT87XX_FW)	{
+		err = wdt87xx_load_chunk(client, fw, &wif_format_chunk,
+					 CHUNK_ID_FRWR);
+		if (err) {
+			dev_err(&client->dev, "load fw chunk failed\n");
+			goto release_firmware;
+		}
+	}
+
+	if (type & WDT87XX_CFG)	{
+		err = wdt87xx_load_chunk(client, fw, &wif_format_chunk,
+					 CHUNK_ID_CNFG);
+		if (err) {
+			dev_err(&client->dev, "load cfg chunk failed\n");
+			goto release_firmware;
+		}
+	}
+
+	err = wdt87xx_sw_reset(client);
+	if (err)
+		dev_err(&client->dev, "soft reset failed\n");
+
+	/* refresh the parameters */
+	wdt87xx_get_sysparam(client);
+release_firmware:
+	enable_irq(client->irq);
+	mdelay(10);
+
+	release_firmware(fw);
+	return err;
+}
+
+static ssize_t update_fw_store(
+	struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+	int err;
+	u8 option = 0;
+
+	if (count <= 0)
+		return -EINVAL;
+
+	err = kstrtou8(buf, 0, &option);
+	if (err)
+		return err;
+
+	dev_info(dev, "update option (%d)\n", option);
+	if (option < 1 || option > 3)	{
+		dev_err(&client->dev, "option is not supported\n");
+		return -1;
+	}
+
+	err = mutex_lock_interruptible(&wdt_dev->sysfs_mutex);
+	if (err)
+		return err;
+
+	err = wdt87xx_load_fw(dev, WDT87XX_FW_NAME, option);
+	if (err) {
+		dev_err(&client->dev, "the firmware update failed\n");
+		count = err;
+	}
+
+	mutex_unlock(&wdt_dev->sysfs_mutex);
+
+	return count;
+}
+
+static ssize_t fw_version_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", wdt_dev->param.fw_id);
+}
+
+static ssize_t plat_id_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", wdt_dev->param.plat_id);
+}
+
+static ssize_t config_csum_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+	u32 cfg_csum;
+
+	cfg_csum = wdt_dev->param.xmls_id1;
+	cfg_csum = (cfg_csum << 16) | wdt_dev->param.xmls_id2;
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", cfg_csum);
+}
+
+static DEVICE_ATTR_WO(update_fw);
+static DEVICE_ATTR_RO(fw_version);
+static DEVICE_ATTR_RO(plat_id);
+static DEVICE_ATTR_RO(config_csum);
+
+static struct attribute *wdt87xx_attrs[] = {
+	&dev_attr_update_fw.attr,
+	&dev_attr_fw_version.attr,
+	&dev_attr_plat_id.attr,
+	&dev_attr_config_csum.attr,
+	NULL
+};
+
+static const struct attribute_group wdt87xx_attr_group = {
+	.attrs = wdt87xx_attrs,
+};
+
+static int wdt87xx_i2c_txrxdata(struct i2c_client *client, char *txdata,
+				int txlen, char *rxdata, int rxlen)
+{
+	int err;
+
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= txlen,
+			.buf	= txdata,
+		},
+		{
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= rxlen,
+			.buf	= rxdata,
+		},
+	};
+
+	err = i2c_transfer(client->adapter, msgs, 2);
+
+	if (err < 0)
+		dev_err(&client->dev, "%s: i2c read error (%d)\n",
+			__func__, err);
+
+	return err < 0 ? err : (err != ARRAY_SIZE(msgs) ? -EIO : 0);
+}
+
+static int wdt87xx_i2c_rxdata(struct i2c_client *client,
+			      char *rxdata, int length)
+{
+	int err;
+
+	err = i2c_master_recv(client, rxdata, length);
+
+	if (err < 0)
+		dev_err(&client->dev, "%s: i2c read error (%d)\n",
+			__func__, err);
+
+	return err;
+}
+
+static int wdt87xx_i2c_txdata(struct i2c_client *client,
+			      char *txdata, int length)
+{
+	int err;
+
+	err = i2c_master_send(client, txdata, length);
+	if (err < 0)
+		dev_err(&client->dev, "%s: i2c write error (%d)\n",
+			__func__, err);
+
+	return err;
+}
+
+static irqreturn_t wdt87xx_ts_interrupt(int irq, void *dev_id)
+{
+	struct wdt_ts_data *wdt_dev = dev_id;
+	int err;
+	int i, fingers;
+	struct i2c_client	*client = wdt_dev->client;
+	struct input_dev	*input_dev = wdt_dev->input_dev;
+	struct sys_param	*param = &wdt_dev->param;
+	u8 raw_buf[WDT_V1_RAW_BUF_COUNT] = {0};
+	u8 *ptr_raw_buf = 0;
+
+	err = wdt87xx_i2c_rxdata(client, raw_buf, WDT_V1_RAW_BUF_COUNT);
+
+	if (err < 0) {
+		dev_err(&client->dev, "read v1 raw data failed\n");
+		goto irq_exit;
+	}
+
+	/* touch finger count */
+	fingers = raw_buf[TOUCH_PK_V1_OFFSET_FNGR_NUM];
+
+	/* skip this packet */
+	if (fingers == 0)
+		goto irq_exit;
+
+	ptr_raw_buf = &raw_buf[TOUCH_PK_V1_OFFSET_EVENT];
+	for (i = 0; i < WDT_MAX_FINGER; i++) {
+		int finger_id = (*ptr_raw_buf >> 3) - 1;
+
+		/* something wrong */
+		if (finger_id < 0)
+			break;
+
+		if (*ptr_raw_buf & 0x1) {
+			u32	coor_x, coor_y;
+			u8	w, h, p;
+			u16	value;
+
+			w = *(ptr_raw_buf + FINGER_EV_V1_OFFSET_W);
+			h = *(ptr_raw_buf + FINGER_EV_V1_OFFSET_H);
+			value = w * h;
+			p = (value >> 2);
+
+			coor_x = get_unaligned_le16(ptr_raw_buf +
+							FINGER_EV_V1_OFFSET_X);
+			coor_y = get_unaligned_le16(ptr_raw_buf +
+							FINGER_EV_V1_OFFSET_Y);
+
+			coor_y = DIV_ROUND_CLOSEST(
+				coor_y * param->phy_h, param->phy_w);
+
+			/* incorrect coordinate */
+			if (coor_x > wdt_dev->max_x || coor_y > wdt_dev->max_y)
+				break;
+
+			dev_dbg(&client->dev, "tip on (%d), x(%d), y(%d)\n",
+				i, coor_x, coor_y);
+
+			input_mt_slot(input_dev, finger_id);
+			input_mt_report_slot_state(
+				input_dev, MT_TOOL_FINGER, 1);
+			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, w);
+			input_report_abs(input_dev, ABS_MT_PRESSURE, p);
+			input_report_abs(input_dev, ABS_MT_POSITION_X, coor_x);
+			input_report_abs(input_dev, ABS_MT_POSITION_Y, coor_y);
+		}
+		ptr_raw_buf += FINGER_EV_V1_SIZE;
+	}
+
+	input_mt_sync_frame(input_dev);
+	input_sync(input_dev);
+
+irq_exit:
+	return IRQ_HANDLED;
+}
+
+static int wdt87xx_ts_request_irq(struct i2c_client *client)
+{
+	int err;
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+
+	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					wdt87xx_ts_interrupt, IRQF_ONESHOT,
+					client->name, wdt_dev);
+
+	if (err < 0) {
+		dev_err(&client->dev, "request threaded irq failed\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_ts_create_input_device(struct i2c_client *client)
+{
+	int err;
+	struct wdt_ts_data *wdt_dev = i2c_get_clientdata(client);
+	struct input_dev	*input_dev;
+	u32	res;
+
+	input_dev = devm_input_allocate_device(&client->dev);
+	if (!input_dev) {
+		dev_err(&client->dev, "failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	wdt_dev->input_dev = input_dev;
+
+	wdt_dev->max_x = MAX_UNIT_AXIS;
+	wdt_dev->max_y = DIV_ROUND_CLOSEST(
+		MAX_UNIT_AXIS * wdt_dev->param.phy_h, wdt_dev->param.phy_w);
+
+	res = DIV_ROUND_CLOSEST(MAX_UNIT_AXIS, wdt_dev->param.phy_w);
+
+	input_dev->name = "WDT87xx Touchscreen";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->phys = wdt_dev->phys;
+	input_dev->dev.parent = &wdt_dev->client->dev;
+
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
+			     wdt_dev->max_x, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
+			     wdt_dev->max_y, 0, 0);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_X, res);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_Y, res);
+
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 0xFF, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 0xFF, 0, 0);
+
+	input_mt_init_slots(input_dev, WDT_MAX_FINGER,
+			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(&client->dev, "failed to register input device\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_ts_probe(
+	struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct wdt_ts_data *wdt_dev;
+	int err;
+
+	dev_info(&client->dev, "wdt87xx : adapter=(%d), client irq:(%d)\n",
+		 client->adapter->nr, client->irq);
+
+	/* check if the I2C function is ok in this adaptor */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	wdt_dev = devm_kzalloc(&client->dev, sizeof(struct wdt_ts_data),
+			       GFP_KERNEL);
+	if (!wdt_dev)
+		return -ENOMEM;
+
+	wdt_dev->client = client;
+	mutex_init(&wdt_dev->sysfs_mutex);
+	i2c_set_clientdata(client, wdt_dev);
+
+	snprintf(wdt_dev->phys, sizeof(wdt_dev->phys), "i2c-%u-%04x/input0",
+		 client->adapter->nr, client->addr);
+
+	wdt87xx_get_sysparam(client);
+
+	err = wdt87xx_ts_create_input_device(client);
+	if (err < 0) {
+		dev_err(&client->dev, "create input device failed: (%d)\n",
+			err);
+		return err;
+	}
+
+	err = wdt87xx_ts_request_irq(client);
+	if (err < 0) {
+		dev_err(&client->dev, "request irq failed: (%d)\n", err);
+		return err;
+	}
+
+	err = sysfs_create_group(&client->dev.kobj, &wdt87xx_attr_group);
+	if (err) {
+		dev_err(&client->dev, "create sysfs failed: (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_ts_remove(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &wdt87xx_attr_group);
+
+	return 0;
+}
+
+static int __maybe_unused wdt87xx_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int err;
+
+	disable_irq(client->irq);
+
+	err = wdt87xx_send_command(client, VND_CMD_STOP, MODE_IDLE);
+	if (err)
+		dev_err(&client->dev, "%s: command stop failed\n",
+			__func__);
+
+	return err;
+}
+
+static int __maybe_unused wdt87xx_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int err;
+
+	/* once the chip is reset before resume,  */
+	/* we need some time to wait it is stable */
+	mdelay(100);
+
+	err = wdt87xx_send_command(client, VND_CMD_START, 0);
+	if (err)
+		dev_err(&client->dev, "%s: command start failed\n",
+			__func__);
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(wdt87xx_pm_ops, wdt87xx_suspend, wdt87xx_resume);
+
+static const struct i2c_device_id wdt87xx_dev_id[] = {
+	{ WDT87XX_NAME, 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, wdt87xx_dev_id);
+
+static const struct acpi_device_id wdt87xx_acpi_id[] = {
+	{ "WDHT0001", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, wdt87xx_acpi_id);
+
+static struct i2c_driver wdt87xx_driver = {
+	.probe		= wdt87xx_ts_probe,
+	.remove		= wdt87xx_ts_remove,
+	.id_table	= wdt87xx_dev_id,
+	.driver	= {
+		.name	= WDT87XX_NAME,
+		.owner	= THIS_MODULE,
+		.pm     = &wdt87xx_pm_ops,
+		.acpi_match_table = ACPI_PTR(wdt87xx_acpi_id),
+	},
+};
+
+module_i2c_driver(wdt87xx_driver);
+
+MODULE_AUTHOR("HN Chen <hn.chen@weidahitech.com>");
+MODULE_DESCRIPTION("WeidaHiTech WDT87XX Touchscreen driver");
+MODULE_VERSION(WDT87XX_DRV_VER);
+MODULE_LICENSE("GPL");
+
-- 
1.9.1

