From: HungNien Chen <hn.chen@weidahitech.com>
Subject: [PATCH v5] Fix the resolution issue in ChromeOS
Date: Fri, 29 May 2015 12:27:29 +0800
Message-ID: <1432873649-32484-1-git-send-email-hn.chen@weidahitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:1547 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbE2E1U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 May 2015 00:27:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/Kconfig       |   12 +
 drivers/input/touchscreen/Makefile      |    1 +
 drivers/input/touchscreen/wdt87xx_i2c.c | 1404 +++++++++++++++++++++++++++++++
 3 files changed, 1417 insertions(+)
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
index 0000000..4998ad5
--- /dev/null
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -0,0 +1,1404 @@
+/*
+ * Weida HiTech WDT87xx TouchScreen I2C driver
+ *
+ * Copyright (c) 2015  Weida HiTech Ltd.
+ * HN Chen <hn.chen@weidahitech.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * Note: this is a I2C device driver and report touch events througt the
+ *			input device
+ */
+
+
+#include <linux/version.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/ioc4.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <linux/firmware.h>
+#include <linux/gpio.h>
+#include <linux/input/mt.h>
+#include <asm/unaligned.h>
+#include <linux/acpi.h>
+
+#define WDT87XX_NAME		"wdt87xx_i2c"
+#define	WDT87XX_DRV_VER		"0.9.4"
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
+/* the definition for one finger */
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
+/* the definition for a packet */
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
+/* the definition for the controller parameters */
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
+struct sys_param {
+	u16	fw_id;
+	u16	plat_id;
+	u16	xmls_id1;
+	u16	xmls_id2;
+	u16	phy_ch_x;
+	u16	phy_ch_y;
+	u16	phy_w;
+	u16	phy_h;
+} __packed;
+
+/* the definition for this driver needed */
+struct wdt87xx_ts_data {
+	struct i2c_client	*client;
+	struct input_dev	*input_dev;
+/* to protect the operation in sysfs */
+	struct mutex		sysfs_mutex;
+	u32			max_retries;
+	struct sys_param	param;
+	u8	phys[32];
+	u32			packet_type;
+	u32			max_x;
+	u32			max_y;
+};
+
+/* communacation commands */
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
+#define	STRIDX_PLATFORM_ID		0x80
+#define	STRIDX_PARAMETERS		0x81
+
+
+/* the definition of command structure */
+union cmd_data {
+	struct {
+	u8	report_id;
+	u8	type;
+	u16	index;
+	u32	length;
+	} defined_data;
+	u8	buffer[8];
+};
+
+/* the definition of packet structure */
+union req_data {
+	struct {
+	u8	report_id;
+	u8	type;
+	u16	index;
+	u32	length;
+	u8	data[PACKET_SIZE];
+	} defined_data;
+	u8	buffer[64];
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
+	u8		*data;
+	u32		length;
+};
+
+/* the definition of firmware chunk tags */
+#define		FOURCC_ID_RIFF		0x46464952
+#define		FOURCC_ID_WHIF		0x46494857
+#define		FOURCC_ID_FRMT		0x544D5246
+#define		FOURCC_ID_FRWR		0x52575246
+#define		FOURCC_ID_CNFG		0x47464E43
+
+#define		CHUNK_ID_FRMT		FOURCC_ID_FRMT
+#define		CHUNK_ID_FRWR		FOURCC_ID_FRWR
+#define		CHUNK_ID_CNFG		FOURCC_ID_CNFG
+
+
+static int wdt87xx_i2c_txrxdata(struct i2c_client *client, char *txdata,
+		int txlen, char *rxdata, int rxlen);
+static int wdt87xx_i2c_rxdata(struct i2c_client *client, char *rxdata,
+		int length);
+static int wdt87xx_i2c_txdata(struct i2c_client *client, char *txdata,
+		int length);
+static int wdt87xx_set_feature(struct i2c_client *client, u8 *buf,
+		u32 buf_size);
+static int wdt87xx_get_feature(struct i2c_client *client, u8 *buf,
+		u32 buf_size);
+static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
+		u8 *buf, u32 buf_size);
+
+static int get_chunk_info(const struct firmware *fw, u32 chunk_four_cc,
+	struct chunk_info_ex *fw_chunk_info,
+	struct format_chunk *wif_format_chunk)
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
+		ck_size = get_unaligned_le32(&data[start_pos+4]);
+
+		/* the chunk is found */
+		if (ck_id == chunk_four_cc) {
+			chunk.ck_id = ck_id;
+			chunk.ck_size = ck_size;
+
+			chunk.data = (u8 *) &data[start_pos + 8
+				+ sizeof(struct chunk_info)];
+			chunk.chunk_info.target_start_addr =
+				get_unaligned_le32(&data[start_pos+8]);
+			chunk.chunk_info.length =
+				get_unaligned_le32(&data[start_pos+12]);
+			chunk.chunk_info.source_start_addr =
+				get_unaligned_le32(&data[start_pos+16]);
+			chunk.chunk_info.version_number =
+				get_unaligned_le32(&data[start_pos+20]);
+			chunk.chunk_info.attribute =
+				get_unaligned_le32(&data[start_pos+24]);
+			chunk.chunk_info.temp =
+				get_unaligned_le32(&data[start_pos+28]);
+
+			memcpy(&fw_chunk_info->chunk_info,
+				&chunk.chunk_info,
+				sizeof(struct chunk_info));
+			fw_chunk_info->length = chunk.chunk_info.length;
+			fw_chunk_info->data = chunk.data;
+
+			is_found = 1;
+		} else
+		start_pos = start_pos + ck_size + 8;
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
+	struct wdt87xx_ts_data *dev_wdt87xx =
+		(struct wdt87xx_ts_data *) i2c_get_clientdata(client);
+	struct sys_param *ctr_param = &dev_wdt87xx->param;
+	u8	buffer[PKT_READ_SIZE];
+	int	err;
+
+	err = wdt87xx_get_string(client, STRIDX_PARAMETERS, buffer, 32);
+	if (err) {
+		dev_err(&client->dev, "get parameters error (%d)\n", err);
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
+		dev_err(&client->dev, "get platform id error (%d)\n", err);
+		return err;
+	}
+
+	ctr_param->plat_id = buffer[1];
+
+	buffer[0] = 0xf2;
+	err = wdt87xx_get_feature(client, buffer, 16);
+	if (err) {
+		dev_err(&client->dev, "get firmware id error (%d)\n", err);
+		return err;
+	}
+
+	if (buffer[0] != 0xf2) {
+		dev_err(&client->dev, "fw id packet error: %x\n", buffer[0]);
+		return -EINVAL;
+	}
+
+	ctr_param->fw_id = get_unaligned_le16(&buffer[1]);
+
+	if ((ctr_param->fw_id & 0xFFF) > 0x335)
+		dev_wdt87xx->packet_type = WDT_PKT_V1;
+	else
+		dev_wdt87xx->packet_type = WDT_PKT_V0;
+
+	dev_dbg(&client->dev,
+		"fw_id: 0x%x, plat_id: 0x%x\nxml_id1: %4x, xml_id2: %4x\n",
+		ctr_param->fw_id, ctr_param->plat_id,
+		ctr_param->xmls_id1, ctr_param->xmls_id2);
+
+	return 0;
+}
+
+static int process_fw_data(struct i2c_client *client,
+	const struct firmware *fw, struct format_chunk *wif_format_chunk)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	struct chunk_info_ex		fw_chunk_info;
+	int	err;
+	u32	*u32_data;
+	u32	length;
+	u8	fw_id;
+	u8	chip_id;
+	u32	data1, data2;
+
+	u32_data = (u32 *) fw->data;
+	length = fw->size;
+
+	data1 = get_unaligned_le32(&u32_data[0]);
+	data2 = get_unaligned_le32(&u32_data[2]);
+	if (data1 != FOURCC_ID_RIFF || data2 != FOURCC_ID_WHIF) {
+		dev_err(&client->dev, "Check data tag failed !\n");
+		return -EINVAL;
+	}
+
+	/* the length should be equal */
+	data1 = get_unaligned_le32(&u32_data[1]);
+	if (data1 != length) {
+		dev_err(&client->dev, "Check data length failed !\n");
+		return -EINVAL;
+	}
+
+	wif_format_chunk->ck_id = get_unaligned_le32(&u32_data[3]);
+	wif_format_chunk->ck_size = get_unaligned_le32(&u32_data[4]);
+	wif_format_chunk->number_chunk = get_unaligned_le32(&u32_data[5]);
+	wif_format_chunk->enable_flag = get_unaligned_le32(&u32_data[6]);
+	wif_format_chunk->checksum = get_unaligned_le32(&u32_data[7]);
+	wif_format_chunk->temp1 = get_unaligned_le32(&u32_data[8]);
+	wif_format_chunk->temp2 = get_unaligned_le32(&u32_data[9]);
+
+	dev_dbg(&client->dev, "version checking\n");
+
+	/* get the version number from the firmware */
+	err = get_chunk_info(fw, CHUNK_ID_FRWR, &fw_chunk_info,
+		wif_format_chunk);
+	if (err) {
+		dev_err(&client->dev, "can not extract data !\n");
+		return -EBADR;
+	}
+
+	fw_id = ((fw_chunk_info.chunk_info.version_number >> 12) & 0xF);
+	chip_id = (((dev_wdt87xx->param.fw_id) >> 12) & 0xF);
+
+	if (fw_id != chip_id) {
+		dev_err(&client->dev, "FW is not match: fw(%d), chip(%d)\n",
+			fw_id, chip_id);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/* functions for the sysfs implementation */
+static int wdt87xx_check_firmware(struct chunk_info_ex *fw_chunk_info,
+	int ck_id)
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
+	u32 buf_size)
+{
+	int	err;
+	union req_data	*req_data_set = (union req_data *) buf;
+	int		data_len = 0;
+	/* for set/get packets used */
+	u8		xfer_buffer[PKT_WRITE_SIZE];
+
+	/* set feature command packet */
+	xfer_buffer[data_len++] = 0x22;
+	xfer_buffer[data_len++] = 0x00;
+	if (req_data_set->defined_data.report_id > 0xF) {
+		xfer_buffer[data_len++] = 0x30;
+		xfer_buffer[data_len++] = 0x03;
+		xfer_buffer[data_len++] = req_data_set->defined_data.report_id;
+	} else {
+		xfer_buffer[data_len++] = 0x30 |
+			req_data_set->defined_data.report_id;
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
+		dev_err(&client->dev, "error no: (%d)\n", err);
+		return err;
+	}
+
+	mdelay(2);
+
+	return 0;
+}
+
+static int wdt87xx_get_feature(struct i2c_client *client, u8 *buf,
+	u32 buf_size)
+{
+	int	err;
+	u8	tx_buffer[8];
+	u8	xfer_buffer[PKT_WRITE_SIZE];
+	union req_data *req_data_get = (union req_data *) buf;
+	int		data_len = 0;
+	u32	xfer_length = 0;
+
+	/* get feature command packet */
+	tx_buffer[data_len++] = 0x22;
+	tx_buffer[data_len++] = 0x00;
+	if (req_data_get->defined_data.report_id > 0xF) {
+		tx_buffer[data_len++] = 0x30;
+		tx_buffer[data_len++] = 0x02;
+		tx_buffer[data_len++] = req_data_get->defined_data.report_id;
+	} else {
+		tx_buffer[data_len++] = 0x30 |
+			req_data_get->defined_data.report_id;
+		tx_buffer[data_len++] = 0x02;
+	}
+	tx_buffer[data_len++] = 0x23;
+	tx_buffer[data_len++] = 0x00;
+
+	err = wdt87xx_i2c_txrxdata(client, tx_buffer, data_len, xfer_buffer,
+			buf_size + 2);
+
+	if (err < 0) {
+		dev_err(&client->dev, "error no: (%d)\n", err);
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
+	u8 *buf, u32 buf_size)
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
+		buf_size + 2);
+
+	if (err < 0) {
+		dev_err(&client->dev, "error no: (%d)\n", err);
+		return err;
+	}
+
+	if (xfer_buffer[1] != 0x03) {
+		dev_err(&client->dev, "error str id: (%d)\n", xfer_buffer[1]);
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
+
+static int wdt87xx_send_command(struct i2c_client *client, int cmd, int value)
+{
+	union cmd_data	cmd_data_send;
+
+	/* set the command packet */
+	cmd_data_send.defined_data.report_id = VND_REQ_WRITE;
+	cmd_data_send.defined_data.type = VND_SET_COMMAND_DATA;
+	put_unaligned_le16((u16) cmd,
+		&cmd_data_send.defined_data.index);
+
+	switch (cmd)	{
+	case	VND_CMD_START:
+	case	VND_CMD_STOP:
+	case	VND_CMD_RESET:
+		/* mode selector */
+		put_unaligned_le32((value & 0xFF),
+			&cmd_data_send.defined_data.length);
+		break;
+	case	VND_CMD_SFLCK:
+		put_unaligned_le16(0xC39B, &cmd_data_send.buffer[3]);
+		break;
+	case	VND_CMD_SFUNL:
+		put_unaligned_le16(0x95DA, &cmd_data_send.buffer[3]);
+		break;
+	case	VND_CMD_ERASE:
+	case	VND_SET_CHECKSUM_CALC:
+	case	VND_SET_CHECKSUM_LENGTH:
+		put_unaligned_le32(value, &cmd_data_send.buffer[3]);
+		break;
+	default:
+		cmd_data_send.defined_data.report_id = 0;
+		dev_err(&client->dev, "Invalid command: (%d)", cmd);
+		return -EINVAL;
+	}
+
+	return wdt87xx_set_feature(client, &cmd_data_send.buffer[0],
+		sizeof(cmd_data_send));
+}
+
+static int wdt87xx_write_data(struct i2c_client *client,
+	const char *data, u32 address, int length)
+{
+	u32	addr_start, data_len;
+	u16	packet_size;
+	int		count = 0;
+	int		err;
+	union req_data	req_data_set;
+	const char	*source_data = 0;
+
+	source_data = data;
+	data_len = length;
+	addr_start = address;
+
+	/* address and length should be 4 bytes alignment */
+	if ((addr_start & 0x3) != 0 || (data_len & 0x3) != 0)	{
+		dev_err(&client->dev, "addr & len must be aligned %x, %x\n",
+			addr_start, data_len);
+		return -EFAULT;
+	}
+
+	packet_size = PACKET_SIZE;
+
+	req_data_set.defined_data.report_id = VND_REQ_WRITE;
+	req_data_set.defined_data.type = VND_SET_DATA;
+
+	while (data_len) {
+		if (data_len < PACKET_SIZE)
+			packet_size = data_len;
+
+		put_unaligned_le16(packet_size,
+			&req_data_set.defined_data.index);
+		put_unaligned_le32(addr_start,
+			&req_data_set.defined_data.length);
+
+		memcpy(req_data_set.defined_data.data,
+			source_data, packet_size);
+
+		err = wdt87xx_set_feature(client, req_data_set.buffer, 64);
+
+		if (err)
+			break;
+
+		data_len = data_len - packet_size;
+		source_data = source_data + packet_size;
+		addr_start = addr_start + packet_size;
+
+		count++;
+
+		mdelay(4);
+
+		if ((count % 64) == 0)	{
+			count = 0;
+			dev_dbg(&client->dev, "#");
+		}
+	}
+
+	dev_dbg(&client->dev, "#\n");
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
+	bit0 = a^(b&1);
+	bit0 ^= a>>1;
+	bit0 ^= a>>2;
+	bit0 ^= a>>4;
+	bit0 ^= a>>5;
+	bit0 ^= a>>7;
+	bit0 ^= a>>11;
+	bit0 ^= a>>15;
+	y = (a<<1)^b;
+	y = (y&~1) | (bit0&1);
+
+	return (u16) y;
+}
+
+static int wdt87xx_get_checksum(struct i2c_client *client,
+	u32 *checksum, u32 address, int length)
+{
+	int		err;
+	int		time_delay;
+	union req_data	req_data_get;
+	union cmd_data	cmd_data_get;
+
+	err = wdt87xx_send_command(client, VND_SET_CHECKSUM_LENGTH, length);
+	if (err) {
+		dev_err(&client->dev, "set checksum length fail (%d)\n", err);
+		return err;
+	}
+
+	err = wdt87xx_send_command(client, VND_SET_CHECKSUM_CALC, address);
+	if (err) {
+		dev_err(&client->dev, "calc checksum fail (%d)\n", err);
+		return err;
+	}
+
+	time_delay = (length + 1023) / 1024;
+	/* to wait the operation compeletion */
+	msleep(time_delay * 10);
+
+	cmd_data_get.defined_data.report_id = VND_REQ_READ;
+	cmd_data_get.defined_data.type = VND_GET_CHECKSUM;
+	cmd_data_get.defined_data.index = 0;
+	cmd_data_get.defined_data.length = 0;
+
+	err = wdt87xx_set_feature(client, cmd_data_get.buffer, 8);
+	if (err) {
+		dev_err(&client->dev, "checksum set read fail (%d)\n", err);
+		return err;
+	}
+
+	memset(req_data_get.buffer, 0, 64);
+	req_data_get.defined_data.report_id = VND_READ_DATA;
+	err = wdt87xx_get_feature(client, req_data_get.buffer, 64);
+	if (err) {
+		dev_err(&client->dev, "read checksum fail (%d)\n", err);
+		return err;
+	}
+
+	*checksum = get_unaligned_le16(&req_data_get.buffer[8]);
+
+	return err;
+}
+
+static u16 fw_checksum(const u8 *data, u32 length)
+{
+	u32	i;
+	u16	checksum = 0;
+
+	checksum = 0x0000;
+
+	for (i = 0; i < length; i++)
+		checksum = misr(checksum, data[i]);
+
+	return checksum;
+}
+
+static int wdt87xx_write_firmware(struct i2c_client *client,
+	struct chunk_info_ex *fw_chunk_info, int type)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	int		err;
+	int		err1;
+	int		size;
+	int		start_addr;
+	int		page_size;
+	int		retry_count = 0;
+	int		is_equal = 0;
+	int		max_retries;
+	u32	calc_checksum = 0;
+	u32	read_checksum = 0;
+	const char	*data;
+
+	dev_info(&client->dev, "start 4k page program\n");
+
+	err = wdt87xx_send_command(client, VND_CMD_STOP, MODE_STOP);
+	if (err) {
+		dev_err(&client->dev, "command stop fail (%d)\n", err);
+		return err;
+	}
+
+	err = wdt87xx_send_command(client, VND_CMD_SFUNL, 0);
+	if (err) {
+		dev_err(&client->dev, "command sfunl fail (%d)\n", err);
+		goto write_fail;
+	}
+
+	mdelay(10);
+
+	start_addr = fw_chunk_info->chunk_info.target_start_addr;
+	size = fw_chunk_info->chunk_info.length;
+	data = fw_chunk_info->data;
+
+	max_retries = dev_wdt87xx->max_retries;
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
+				start_addr);
+			if (err) {
+				dev_err(&client->dev, "erase fail (%d)\n",
+					err);
+				break;
+			}
+
+			msleep(50);
+
+			err = wdt87xx_write_data(client, data, start_addr,
+				page_size);
+			if (err) {
+				dev_err(&client->dev, "write data fail (%d)\n",
+					err);
+				break;
+			}
+
+			read_checksum = 0;
+			err = wdt87xx_get_checksum(client, &read_checksum,
+				start_addr, page_size);
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
+			dev_err(&client->dev, "write page fail\n");
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
+		dev_err(&client->dev, "command sflck fail (%d)\n", err1);
+
+	mdelay(10);
+
+	err1 = wdt87xx_send_command(client, VND_CMD_START, 0);
+	if (err1)
+		dev_err(&client->dev, "command start fail (%d)\n", err1);
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
+		dev_err(&client->dev, "command reset fail (%d)\n", err);
+		return err;
+	}
+
+	/* wait the device to be ready */
+	msleep(200);
+
+	return 0;
+}
+
+static int wdt87xx_load_chunk(struct i2c_client *client,
+	const struct firmware *fw,
+	struct format_chunk *wif_format_chunk, u32 ck_id)
+{
+	int err;
+	struct chunk_info_ex	fw_chunk_info;
+
+	err = get_chunk_info(fw, ck_id, &fw_chunk_info, wif_format_chunk);
+	if (err) {
+		dev_err(&client->dev, "can not get the fw !\n");
+		goto failed;
+	}
+
+	/* Check for incorrect bin file */
+	err = wdt87xx_check_firmware(&fw_chunk_info, ck_id);
+	if (err) {
+		dev_err(&client->dev, "invalid chunk : (%d)\n", ck_id);
+		goto failed;
+	}
+
+	err = wdt87xx_write_firmware(client, &fw_chunk_info, ck_id);
+	if (err)
+		dev_err(&client->dev, "write firmware failed : (%d)\n",
+			ck_id);
+
+failed:
+	return err;
+}
+
+static int wdt87xx_load_fw(struct device *dev, const char *fn,
+	u8 type)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	const struct firmware *fw = 0;
+	int err;
+
+	struct format_chunk	wif_format_chunk;
+
+	err = request_firmware(&fw, fn, dev);
+	if (err) {
+		dev_err(&client->dev, "unable to open firmware %s\n", fn);
+		return err;
+	}
+
+	disable_irq(client->irq);
+
+	err = process_fw_data(client, fw, &wif_format_chunk);
+	if (err) {
+		dev_err(&client->dev, "bad fw file !\n");
+		goto release_firmware;
+	}
+
+	if (type & WDT87XX_FW)	{
+		err = wdt87xx_load_chunk(client, fw, &wif_format_chunk,
+			CHUNK_ID_FRWR);
+		if (err) {
+			dev_err(&client->dev, "load fw chunk failed !\n");
+			goto release_firmware;
+		}
+	}
+
+	if (type & WDT87XX_CFG)	{
+		err = wdt87xx_load_chunk(client, fw, &wif_format_chunk,
+			CHUNK_ID_CNFG);
+		if (err) {
+			dev_err(&client->dev, "load cfg chunk failed !\n");
+			goto release_firmware;
+		}
+	}
+
+	err = wdt87xx_sw_reset(client);
+	if (err)
+		dev_err(&client->dev, "software reset failed !\n");
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
+static ssize_t wdt87xx_update_fw(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
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
+	err = mutex_lock_interruptible(&dev_wdt87xx->sysfs_mutex);
+	if (err)
+		return err;
+
+	err = wdt87xx_load_fw(dev, WDT87XX_FW_NAME, option);
+	if (err) {
+		dev_err(&client->dev, "the firmware update failed(%d)\n",
+			err);
+		count = err;
+	}
+
+	mutex_unlock(&dev_wdt87xx->sysfs_mutex);
+
+	return count;
+}
+
+static ssize_t wdt87xx_fw_version(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", dev_wdt87xx->param.fw_id);
+}
+
+static ssize_t wdt87xx_plat_id(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", dev_wdt87xx->param.plat_id);
+}
+
+static ssize_t wdt87xx_config_csum(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	u32 cfg_csum;
+
+	cfg_csum = dev_wdt87xx->param.xmls_id1;
+	cfg_csum = (cfg_csum << 16) | dev_wdt87xx->param.xmls_id2;
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", cfg_csum);
+}
+
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, wdt87xx_update_fw);
+static DEVICE_ATTR(fw_version, S_IRUGO, wdt87xx_fw_version, NULL);
+static DEVICE_ATTR(plat_id, S_IRUGO, wdt87xx_plat_id, NULL);
+static DEVICE_ATTR(config_csum, S_IRUGO, wdt87xx_config_csum, NULL);
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
+static int wdt87xx_i2c_txrxdata(struct i2c_client *client,
+	char *txdata, int txlen, char *rxdata, int rxlen)
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
+	char *rxdata, int length)
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
+	char *txdata, int length)
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
+	struct wdt87xx_ts_data *dev_wdt87xx =
+		(struct wdt87xx_ts_data *) dev_id;
+	int err;
+	int i, points;
+	struct i2c_client *client = dev_wdt87xx->client;
+	u8 raw_buf[WDT_V1_RAW_BUF_COUNT] = {0};
+	u8 *ptr_raw_buf = 0;
+
+	err = wdt87xx_i2c_rxdata(client, raw_buf, WDT_V1_RAW_BUF_COUNT);
+
+	if (err < 0) {
+		dev_err(&client->dev, "read v1 raw data fail (%d)\n", err);
+		goto irq_exit;
+	}
+
+	/* touch finger count */
+	points = raw_buf[TOUCH_PK_V1_OFFSET_FNGR_NUM];
+
+	dev_dbg(&client->dev, "point: (%d)\n", points);
+
+	/* skip this packet */
+	if (points == 0)
+		goto irq_exit;
+
+	dev_dbg(&client->dev, "+++++++++\n");
+
+	ptr_raw_buf = &raw_buf[TOUCH_PK_V1_OFFSET_EVENT];
+	for (i = 0; i < WDT_MAX_FINGER; i++) {
+		int point_id = (*ptr_raw_buf >> 3) - 1;
+
+		/* something wrong */
+		if (point_id < 0)
+			break;
+
+		if (*ptr_raw_buf & 0x1) {
+			u32	point_x, point_y;
+			u8	w, h, p;
+			u16	value;
+
+			w = *(ptr_raw_buf + FINGER_EV_V1_OFFSET_W);
+			h = *(ptr_raw_buf + FINGER_EV_V1_OFFSET_H);
+			value = w * h;
+			p = (value >> 2);
+
+			point_x = get_unaligned_le16(ptr_raw_buf +
+				FINGER_EV_V1_OFFSET_X);
+			point_y = get_unaligned_le16(ptr_raw_buf +
+				FINGER_EV_V1_OFFSET_Y);
+
+			point_y = DIV_ROUND_CLOSEST(point_y *
+				dev_wdt87xx->param.phy_h,
+				dev_wdt87xx->param.phy_w);
+
+			/* incorrect coordinate */
+			if (point_x > dev_wdt87xx->max_x ||
+				point_y > dev_wdt87xx->max_y)
+				break;
+
+			dev_dbg(&client->dev, "tip on (%d), x(%d), y(%d)\n",
+				i, point_x, point_y);
+
+			input_mt_slot(dev_wdt87xx->input_dev, point_id);
+			input_mt_report_slot_state(dev_wdt87xx->input_dev,
+				MT_TOOL_FINGER, 1);
+			input_report_abs(dev_wdt87xx->input_dev,
+				ABS_MT_TOUCH_MAJOR, w);
+			input_report_abs(dev_wdt87xx->input_dev,
+				ABS_MT_PRESSURE, p);
+			input_report_abs(dev_wdt87xx->input_dev,
+				ABS_MT_POSITION_X, point_x);
+			input_report_abs(dev_wdt87xx->input_dev,
+				ABS_MT_POSITION_Y, point_y);
+		}
+		ptr_raw_buf += FINGER_EV_V1_SIZE;
+	}
+
+	input_mt_sync_frame(dev_wdt87xx->input_dev);
+	input_sync(dev_wdt87xx->input_dev);
+
+irq_exit:
+	return IRQ_HANDLED;
+}
+
+static int wdt87xx_ts_request_irq(struct i2c_client *client)
+{
+	int err;
+	struct wdt87xx_ts_data *dev_wdt87xx;
+
+	dev_wdt87xx = i2c_get_clientdata(client);
+
+	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+		wdt87xx_ts_interrupt, IRQF_ONESHOT, client->name, dev_wdt87xx);
+
+	if (err < 0) {
+		dev_err(&client->dev, "%s: request threaded irq fail (%d)\n",
+			__func__, err);
+		return err;
+	}
+
+	disable_irq_nosync(client->irq);
+
+	return 0;
+}
+
+static int wdt87xx_ts_create_input_device(struct i2c_client *client)
+{
+	int err;
+	struct wdt87xx_ts_data *dev_wdt87xx;
+	struct input_dev	*input_dev;
+	u32	resolution;
+
+	dev_wdt87xx = (struct wdt87xx_ts_data *) i2c_get_clientdata(client);
+
+	input_dev = devm_input_allocate_device(&client->dev);
+	if (!input_dev) {
+		dev_err(&client->dev, "%s: failed to allocate input device\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	dev_wdt87xx->input_dev = input_dev;
+
+	dev_wdt87xx->max_x = MAX_UNIT_AXIS;
+	dev_wdt87xx->max_y = DIV_ROUND_CLOSEST(MAX_UNIT_AXIS *
+		dev_wdt87xx->param.phy_h, dev_wdt87xx->param.phy_w);
+
+	resolution = DIV_ROUND_CLOSEST(MAX_UNIT_AXIS, dev_wdt87xx->param.phy_w);
+
+	input_dev->name = "WDT87xx Touchscreen";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->phys = dev_wdt87xx->phys;
+	input_dev->dev.parent = &dev_wdt87xx->client->dev;
+
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+
+	/* for single touch */
+	input_set_abs_params(input_dev, ABS_X, 0, dev_wdt87xx->max_x, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, dev_wdt87xx->max_y, 0, 0);
+	input_abs_set_res(input_dev, ABS_X, resolution);
+	input_abs_set_res(input_dev, ABS_Y, resolution);
+
+	input_mt_init_slots(input_dev, WDT_MAX_FINGER,
+		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
+		dev_wdt87xx->max_x, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
+		dev_wdt87xx->max_y, 0, 0);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_X, resolution);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_Y, resolution);
+
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 0xFF, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 0xFF, 0, 0);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(&client->dev, "register input device fail (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_ts_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx;
+	int err;
+
+	dev_info(&client->dev, "wdt87xx : adapter=(%d), client irq:(%d)\n",
+		client->adapter->nr, client->irq);
+
+	/* check if the I2C function is ok in this adaptor */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	dev_dbg(&client->dev, "kzalloc\n");
+	dev_wdt87xx = devm_kzalloc(&client->dev,
+		sizeof(struct wdt87xx_ts_data), GFP_KERNEL);
+	if (!dev_wdt87xx)
+		return -ENOMEM;
+
+	dev_dbg(&client->dev, "i2c_set_clientdata\n");
+
+	dev_wdt87xx->client = client;
+	mutex_init(&dev_wdt87xx->sysfs_mutex);
+	i2c_set_clientdata(client, dev_wdt87xx);
+	dev_wdt87xx->max_retries = MAX_RETRIES;
+	snprintf(dev_wdt87xx->phys, sizeof(dev_wdt87xx->phys),
+		"i2c-%u-%04x/input0", client->adapter->nr, client->addr);
+
+	wdt87xx_get_sysparam(client);
+
+	dev_dbg(&client->dev, "wdt87xx_ts_create_input_device\n");
+	err = wdt87xx_ts_create_input_device(client);
+	if (err < 0) {
+		dev_err(&client->dev, "create input device fail (%d)\n", err);
+		return err;
+	}
+
+	dev_dbg(&client->dev, "wdt87xx_ts_request_irq\n");
+	err = wdt87xx_ts_request_irq(client);
+	if (err < 0) {
+		dev_err(&client->dev, "request irq fail (%d)\n", err);
+		return err;
+	}
+
+	dev_dbg(&client->dev, "sysfs_create_group\n");
+	err = sysfs_create_group(&client->dev.kobj, &wdt87xx_attr_group);
+	if (err) {
+		dev_err(&client->dev, "create sysfs fail (%d)\n", err);
+		return err;
+	}
+	enable_irq(client->irq);
+	dev_dbg(&client->dev, "%s leave\n", __func__);
+
+	return 0;
+}
+
+static int wdt87xx_ts_remove(struct i2c_client *client)
+{
+	dev_dbg(&client->dev, "==%s==\n", __func__);
+
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
+	dev_dbg(&client->dev, "enter %s\n", __func__);
+
+	disable_irq(client->irq);
+
+	err = wdt87xx_send_command(client, VND_CMD_STOP, MODE_IDLE);
+	if (err)
+		dev_err(&client->dev, "%s: command stop fail (%d)\n",
+			__func__, err);
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
+		dev_err(&client->dev, "%s: command start fail (%d)\n",
+			__func__, err);
+
+	enable_irq(client->irq);
+
+	dev_dbg(&client->dev, "leave %s\n", __func__);
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

