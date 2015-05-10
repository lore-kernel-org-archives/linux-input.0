From: HungNien Chen <hn.chen@weidahitech.com>
Subject: [PATCH v3] Fix endian issues and remove the board specific codes
Date: Mon, 11 May 2015 01:11:39 +0800
Message-ID: <1431277899-28948-1-git-send-email-hn.chen@weidahitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:1979 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbEJRL7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 May 2015 13:11:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/Kconfig       |   12 +
 drivers/input/touchscreen/Makefile      |    1 +
 drivers/input/touchscreen/wdt87xx_i2c.c | 1509 +++++++++++++++++++++++++++++++
 3 files changed, 1522 insertions(+)
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
index 0000000..e3eef1c
--- /dev/null
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -0,0 +1,1509 @@
+/*
+ * Weida HiTech WDT87xx TouchScreen I2C driver
+ *
+ * Copyright (c) 2014  Weida HiTech Ltd.
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
+#define	WDT87XX_DRV_VER		"0.9.2"
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
+#define WDT_MAX_POINT			10
+#define	WDT_RAW_BUF_COUNT		54
+
+#define	PG_SIZE				0x1000
+#define MAX_RETRIES			3
+
+#define	WDT_UNITS_PER_MM		60
+
+/* the definition for one finger */
+#define	FINGER_EV_OFFSET_ID		0
+#define	FINGER_EV_OFFSET_X		1
+#define	FINGER_EV_OFFSET_Y		3
+#define	FINGER_EV_SIZE			5
+
+/* the definition for a packet */
+#define	TOUCH_PK_OFFSET_REPORT_ID	0
+#define	TOUCH_PK_OFFSET_EVENT		1
+#define TOUCH_PK_OFFSET_SCAN_TIME	51
+#define	TOUCH_PK_OFFSET_FNGR_NUM	53
+
+/* the definition for the controller parameters */
+#define	CTL_PARAM_OFFSET_FW_ID		0
+#define	CTL_PARAM_OFFSET_PLAT_ID	2
+#define	CTL_PARAM_OFFSET_XMLS_ID1	4
+#define	CTL_PARAM_OFFSET_XMLS_ID2	6
+#define	CTL_PARAM_OFFSET_PHY_X		8
+#define	CTL_PARAM_OFFSET_PHY_Y		10
+
+struct sys_param {
+	unsigned short	fw_id;
+	unsigned short	plat_id;
+	unsigned short	xmls_id1;
+	unsigned short	xmls_id2;
+	unsigned short	phy_x;
+	unsigned short	phy_y;
+} __packed;
+
+/* the definition for this driver needed */
+struct wdt87xx_ts_data {
+	struct i2c_client		*client;
+	struct input_dev		*input_dev;
+/* to protect the operation in sysfs */
+	struct mutex			sysfs_mutex;
+	unsigned int			max_retries;
+	struct sys_param		sys_param;
+	u8	finger_last_flag[WDT_MAX_POINT<<1];
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
+	unsigned char	report_id;
+	unsigned char	type;
+	unsigned short	index;
+	unsigned int	length;
+	} defined_data;
+	unsigned char	buffer[8];
+};
+
+/* the definition of packet structure */
+union req_data {
+	struct {
+	unsigned char	report_id;
+	unsigned char	type;
+	unsigned short	index;
+	unsigned int	length;
+	unsigned char	data[PACKET_SIZE];
+	} defined_data;
+	unsigned char	buffer[64];
+};
+
+/* the definition of firmware data structure */
+struct chunk_info {
+	unsigned int	target_start_addr;
+	unsigned int	length;
+	unsigned int	source_start_addr;
+	unsigned int	version_number;
+	unsigned int	attribute;
+	unsigned int	temp;
+};
+
+struct chunk_data {
+	unsigned int	ck_id;
+	unsigned int	ck_size;
+	struct chunk_info	chunk_info;
+	char		*data;
+};
+
+struct format_chunk {
+	unsigned int	ck_id;
+	unsigned int	ck_size;
+	unsigned int	number_chunk;
+	unsigned int	enable_flag;
+	unsigned int	checksum;
+	unsigned int	temp1;
+	unsigned int	temp2;
+};
+
+struct chunk_info_ex {
+	struct chunk_info	chunk_info;
+	char			*data;
+	unsigned int		length;
+};
+
+/* the definition of firmware chunk tags */
+#define		FOURCC_ID_RIFF		0x46464952
+#define		FOURCC_ID_WHIF		0x46494857
+#define		FOURCC_ID_FRMT		0x544D5246
+#define		FOURCC_ID_FRWR		0x52575246
+#define		FOURCC_ID_CNFG		0x47464E43
+
+#define		CHUNK_ID_FRMT		0x00
+#define		CHUNK_ID_FRWR		0x01
+#define		CHUNK_ID_CNFG		0x02
+
+/* for the touch report */
+static int	SCREEN_LOGICAL_MAX_X = 0x7FFF;
+static int	SCREEN_LOGICAL_MAX_Y = 0x7FFF;
+
+/* output the error message */
+#define dev_err(__dev, x...)		dev_err(__dev, x)
+
+static int wdt87xx_i2c_txrxdata(struct i2c_client *client, char *txdata,
+		int txlen, char *rxdata, int rxlen);
+static int wdt87xx_i2c_rxdata(struct i2c_client *client, char *rxdata,
+		int length);
+static int wdt87xx_i2c_txdata(struct i2c_client *client, char *txdata,
+		int length);
+static int wdt87xx_set_feature(struct i2c_client *client, unsigned char *buf,
+		unsigned int buf_size);
+static int wdt87xx_get_feature(struct i2c_client *client, unsigned char *buf,
+		unsigned int buf_size);
+static int wdt87xx_get_string(struct i2c_client *client, unsigned char str_idx,
+		unsigned char *buf, unsigned int buf_size);
+
+static unsigned int get_chunk_fourcc(unsigned int chunk_index)
+{
+	switch (chunk_index) {
+	case	CHUNK_ID_FRMT:
+		return FOURCC_ID_FRMT;
+	case	CHUNK_ID_FRWR:
+		return FOURCC_ID_FRWR;
+	case	CHUNK_ID_CNFG:
+		return FOURCC_ID_CNFG;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
+static int get_chunk_info(const struct firmware *fw, unsigned int chunk_index,
+	struct chunk_info_ex *fw_chunk_info,
+	struct format_chunk *wif_format_chunk)
+{
+	unsigned int	chunk_four_cc;
+	const char	*data = 0;
+	unsigned int	data_len = 0;
+	unsigned int	is_found = 0;
+
+	/* check the pointer is null */
+	if (!fw || !fw_chunk_info || !wif_format_chunk)
+		return -EINVAL;
+
+	chunk_four_cc = get_chunk_fourcc(chunk_index);
+
+	if (!chunk_four_cc)
+		return -EBADRQC;
+
+	data = fw->data;
+	data_len = fw->size;
+
+	/* check if the chunk is existed */
+	if (wif_format_chunk->enable_flag | chunk_index) {
+		unsigned int	start_pos = 12 + sizeof(struct format_chunk);
+		struct chunk_data	chunk;
+		unsigned int	ck_id, ck_size;
+
+		while (start_pos < data_len && !is_found)	{
+			ck_id = get_unaligned_le32(&data[start_pos]);
+			ck_size = get_unaligned_le32(&data[start_pos+4]);
+
+			/* the chunk is found */
+			if (ck_id == chunk_four_cc) {
+				chunk.ck_id = ck_id;
+				chunk.ck_size = ck_size;
+
+				chunk.data = (char *) &data[start_pos + 8
+					+ sizeof(struct chunk_info)];
+				chunk.chunk_info.target_start_addr =
+					get_unaligned_le32(&data[start_pos+8]);
+				chunk.chunk_info.length =
+					get_unaligned_le32(&data[start_pos+12]);
+				chunk.chunk_info.source_start_addr =
+					get_unaligned_le32(&data[start_pos+16]);
+				chunk.chunk_info.version_number =
+					get_unaligned_le32(&data[start_pos+20]);
+				chunk.chunk_info.attribute =
+					get_unaligned_le32(&data[start_pos+24]);
+				chunk.chunk_info.temp =
+					get_unaligned_le32(&data[start_pos+28]);
+
+				memcpy(&fw_chunk_info->chunk_info,
+					&chunk.chunk_info,
+					sizeof(struct chunk_info));
+
+				fw_chunk_info->length = chunk.chunk_info.length;
+				fw_chunk_info->data = chunk.data;
+
+				is_found = 1;
+			} else
+				start_pos = start_pos + ck_size + 8;
+		}
+	}
+
+	if (is_found)
+		return 0;
+
+	return -ENODATA;
+}
+
+static int wdt87xx_get_sysparam(struct i2c_client *client,
+		struct wdt87xx_ts_data *dev_wdt87xx)
+{
+	struct sys_param *ctr_param = &dev_wdt87xx->sys_param;
+	unsigned char	buffer[72];
+	int		err = 0;
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
+	ctr_param->phy_x =
+		get_unaligned_le16(buffer + CTL_PARAM_OFFSET_PHY_X);
+	ctr_param->phy_y =
+		get_unaligned_le16(buffer + CTL_PARAM_OFFSET_PHY_Y);
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
+		return -EBADRQC;
+	}
+
+	ctr_param->fw_id = get_unaligned_le16(&buffer[1]);
+
+	dev_dbg(&client->dev, "fw_id: 0x%x, plat_id: 0x%x\n",
+		ctr_param->fw_id, ctr_param->plat_id);
+	dev_dbg(&client->dev, "xml_id1: %4x, xml_id2: %4x\n",
+		ctr_param->xmls_id1, ctr_param->xmls_id2);
+
+	return 0;
+}
+
+int  process_fw_data(struct i2c_client *client, const struct firmware *fw,
+				struct format_chunk *wif_format_chunk)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	unsigned int	length = 0;
+	struct chunk_info_ex		fw_chunk_info;
+	int		err = 0;
+	unsigned int	*u32_data;
+	unsigned char	fw_id;
+	unsigned char	chip_id;
+	unsigned int	data1, data2;
+
+	/* check the pointer is null */
+	if (!fw || !wif_format_chunk)
+		return -EINVAL;
+
+	u32_data = (unsigned int *) fw->data;
+	length = fw->size;
+
+	data1 = get_unaligned_le32(&u32_data[0]);
+	data2 = get_unaligned_le32(&u32_data[2]);
+	if (data1 != FOURCC_ID_RIFF || data2 != FOURCC_ID_WHIF) {
+		dev_err(&client->dev, "Check data tag failed !\n");
+		return -EBADRQC;
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
+	chip_id = (((dev_wdt87xx->sys_param.fw_id) >> 12) & 0xF);
+
+	if (fw_id != chip_id) {
+		wdt87xx_get_sysparam(client, dev_wdt87xx);
+		chip_id = (((dev_wdt87xx->sys_param.fw_id) >> 12) & 0xF);
+
+		if (fw_id != chip_id) {
+			dev_err(&client->dev, "FW is not match: ");
+			dev_err(&client->dev, "fw(%d), chip(%d)\n",
+				fw_id, chip_id);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+/* functions for the sysfs implementation */
+static int wdt87xx_check_firmware(struct chunk_info_ex *fw_chunk_info,
+			int ck_id)
+{
+	unsigned int	data;
+
+	/* check the pointer is null */
+	if (!fw_chunk_info)
+		return -EINVAL;
+
+	if (ck_id == CHUNK_ID_FRWR) {
+		unsigned int	is_found = 0;
+		unsigned int firmware_id = 0xa9e368f5;
+
+		data = get_unaligned_le32(fw_chunk_info->data);
+		if (data == firmware_id)
+			is_found = 1;
+		else
+			return -EFAULT;
+
+		if (is_found)
+			return 0;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_set_feature(struct i2c_client *client, unsigned char *buf,
+		unsigned int buf_size)
+{
+	int	err = 0;
+	union req_data	*req_data_set = (union req_data *) buf;
+	int		data_len = 0;
+	/* for set/get packets used */
+	unsigned char		xfer_buffer[80];
+
+	/* buffer size must be smaller than 64 */
+	if (buf_size > 64)
+		buf_size = 64;
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
+static int wdt87xx_get_feature(struct i2c_client *client, unsigned char *buf,
+		unsigned int buf_size)
+{
+	int	err = 0;
+	unsigned char	tx_buffer[8];
+	unsigned char	xfer_buffer[80];
+	union req_data *req_data_get = (union req_data *) buf;
+	int		data_len = 0;
+	unsigned int	xfer_length = 0;
+
+	if (buf_size > 64)
+		buf_size = 64;
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
+static int wdt87xx_get_string(struct i2c_client *client, unsigned char str_idx,
+		unsigned char *buf, unsigned int buf_size)
+{
+	int	err = 0;
+	unsigned char	tx_buffer[8] = { 0x22, 0x00, 0x13, 0x0E,
+		0x00, 0x23, 0x00, 0x00 };
+	unsigned char	xfer_buffer[80];
+	unsigned int	xfer_length;
+
+	if (buf_size > 64)
+		buf_size = 64;
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
+		return -EBADRQC;
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
+	put_unaligned_le16((unsigned short) cmd,
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
+		const char *data, unsigned int address, int length)
+{
+	unsigned int	addr_start, data_len;
+	unsigned short	packet_size;
+	int		count = 0;
+	int		err = 0;
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
+static unsigned short  misr(unsigned short currentValue,
+		unsigned char newValue)
+{
+	unsigned int a, b;
+	unsigned int bit0;
+	unsigned int y;
+
+	a = currentValue;
+	b = newValue;
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
+	return (unsigned short) y;
+}
+
+static int wdt87xx_get_checksum(struct i2c_client *client,
+		unsigned int *checksum, unsigned int address, int length)
+{
+	int		err = 0;
+	int		time_delay = 0;
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
+static unsigned short fw_checksum(const unsigned char *data,
+		unsigned int length)
+{
+	unsigned int	i;
+	unsigned short	checksum = 0;
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
+		struct chunk_info_ex *fw_chunk_info, int type)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	int		err = 0;
+	int		err1 = 0;
+	int		size;
+	int		start_addr = 0;
+	int		page_size;
+	int		retry_count = 0;
+	int		is_equal = 0;
+	int		max_retries;
+	unsigned int	calc_checksum = 0;
+	unsigned int	read_checksum = 0;
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
+			else {
+				dev_err(&client->dev, "checksum fail: (%d)",
+					retry_count);
+				dev_err(&client->dev, ",(%d), (%d)\n",
+					read_checksum, calc_checksum);
+			}
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
+	int err = 0;
+
+	dev_info(&client->dev, "reset device now\n");
+
+	err = wdt87xx_send_command(client, VND_CMD_RESET, 0);
+	if (err) {
+		dev_err(&client->dev, "command reset fail (%d)\n", err);
+		return err;
+	}
+
+	msleep(100);
+
+	return 0;
+}
+
+static int wdt87xx_load_chunk(struct i2c_client *client,
+		const struct firmware *fw,
+		struct format_chunk *wif_format_chunk, unsigned int ck_id)
+{
+	int err = 0;
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
+		unsigned char type)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	const struct firmware *fw = 0;
+	int err = 0;
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
+
+	if (err)
+		dev_err(&client->dev, "software reset failed !\n");
+
+release_firmware:
+	enable_irq(client->irq);
+
+	mdelay(10);
+	release_firmware(fw);
+	return err;
+}
+
+static ssize_t wdt87xx_update_fw(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	int err;
+	unsigned char option = 0;
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
+static ssize_t wdt87xx_fw_id(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	struct sys_param *sys_param = &dev_wdt87xx->sys_param;
+	int err;
+
+	err = mutex_lock_interruptible(&dev_wdt87xx->sysfs_mutex);
+	if (err)
+		return err;
+
+	wdt87xx_get_sysparam(client, dev_wdt87xx);
+
+	mutex_unlock(&dev_wdt87xx->sysfs_mutex);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", sys_param->fw_id);
+}
+
+static ssize_t wdt87xx_plat_id(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	struct sys_param *sys_param = &dev_wdt87xx->sys_param;
+	int err;
+
+	err = mutex_lock_interruptible(&dev_wdt87xx->sysfs_mutex);
+	if (err)
+		return err;
+
+	wdt87xx_get_sysparam(client, dev_wdt87xx);
+
+	mutex_unlock(&dev_wdt87xx->sysfs_mutex);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", sys_param->plat_id);
+}
+
+static ssize_t wdt87xx_xmls_id1(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	struct sys_param *sys_param = &dev_wdt87xx->sys_param;
+	int err;
+
+	err = mutex_lock_interruptible(&dev_wdt87xx->sysfs_mutex);
+	if (err)
+		return err;
+
+	wdt87xx_get_sysparam(client, dev_wdt87xx);
+
+	mutex_unlock(&dev_wdt87xx->sysfs_mutex);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", sys_param->xmls_id1);
+}
+
+static ssize_t wdt87xx_xmls_id2(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	struct sys_param *sys_param = &dev_wdt87xx->sys_param;
+	int err;
+
+	err = mutex_lock_interruptible(&dev_wdt87xx->sysfs_mutex);
+	if (err)
+		return err;
+
+	wdt87xx_get_sysparam(client, dev_wdt87xx);
+
+	mutex_unlock(&dev_wdt87xx->sysfs_mutex);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", sys_param->xmls_id2);
+}
+
+
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, wdt87xx_update_fw);
+static DEVICE_ATTR(fw_id, S_IRUGO, wdt87xx_fw_id, NULL);
+static DEVICE_ATTR(plat_id, S_IRUGO, wdt87xx_plat_id, NULL);
+static DEVICE_ATTR(xmls_id1, S_IRUGO, wdt87xx_xmls_id1, NULL);
+static DEVICE_ATTR(xmls_id2, S_IRUGO, wdt87xx_xmls_id2, NULL);
+
+static struct attribute *wdt87xx_attrs[] = {
+	&dev_attr_update_fw.attr,
+	&dev_attr_fw_id.attr,
+	&dev_attr_plat_id.attr,
+	&dev_attr_xmls_id1.attr,
+	&dev_attr_xmls_id2.attr,
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
+static int wdt87xx_i2c_rxdata(struct i2c_client *client, char *rxdata,
+				int length)
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
+static int wdt87xx_i2c_txdata(struct i2c_client *client, char *txdata,
+			int length)
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
+	u8 raw_buf[64] = {0};
+	u8 *ptr_raw_buf = 0;
+
+	err = wdt87xx_i2c_rxdata(client, raw_buf, WDT_RAW_BUF_COUNT);
+
+	if (err < 0) {
+		dev_err(&client->dev, "read raw data fail (%d)\n", err);
+		goto leave_irq;
+	}
+
+	/* touch finger count */
+	points = raw_buf[TOUCH_PK_OFFSET_FNGR_NUM];
+
+	dev_dbg(&client->dev, "point: (%d)\n", points);
+
+	if (points == 0) {
+		for (i = 0; i < WDT_MAX_POINT; i++) {
+			/* force to send event of tip off */
+			if (dev_wdt87xx->finger_last_flag[i] != 0) {
+				dev_dbg(&client->dev, "tip off (%d)\n", i);
+				input_mt_slot(dev_wdt87xx->input_dev, i);
+				input_mt_report_slot_state(
+					dev_wdt87xx->input_dev,
+					MT_TOOL_FINGER, false);
+			}
+		}
+
+		memset(dev_wdt87xx->finger_last_flag, 0, WDT_MAX_POINT<<1);
+
+		input_mt_sync_frame(dev_wdt87xx->input_dev);
+		input_sync(dev_wdt87xx->input_dev);
+		goto leave_irq;
+	}
+
+	dev_dbg(&client->dev, "+++++++++\n");
+
+	ptr_raw_buf = &raw_buf[TOUCH_PK_OFFSET_EVENT];
+	for (i = 0; i < WDT_MAX_POINT; i++) {
+		int point_id = (*ptr_raw_buf >> 3) - 1;
+
+		if (point_id < 0)
+			continue;
+
+		/* tip off */
+		if (((*ptr_raw_buf & 0x1) == 0) &&
+			(dev_wdt87xx->finger_last_flag[point_id] != 0)) {
+			dev_dbg(&client->dev, "tip on (%d)\n", point_id);
+			input_mt_slot(dev_wdt87xx->input_dev, point_id);
+			input_mt_report_slot_state(dev_wdt87xx->input_dev,
+				MT_TOOL_FINGER, false);
+		} else  /* tip on */
+		if (*ptr_raw_buf & 0x1) {
+			unsigned int	point_x, point_y;
+
+			point_x = get_unaligned_le16(ptr_raw_buf +
+				FINGER_EV_OFFSET_X);
+			point_y = get_unaligned_le16(ptr_raw_buf +
+				FINGER_EV_OFFSET_Y);
+
+			/* incorrect coordinate */
+			if (point_x > 0x7FFF ||	point_y > 0x7FFF)
+				continue;
+
+			dev_dbg(&client->dev, "tip on (%d), x(%d), y(%d)\n",
+				i, point_x, point_y);
+
+			input_mt_slot(dev_wdt87xx->input_dev, point_id);
+			input_mt_report_slot_state(dev_wdt87xx->input_dev,
+				MT_TOOL_FINGER, true);
+			input_report_abs(dev_wdt87xx->input_dev,
+				ABS_MT_TOUCH_MAJOR, 1);
+			input_report_abs(dev_wdt87xx->input_dev,
+				ABS_MT_POSITION_X, point_x);
+			input_report_abs(dev_wdt87xx->input_dev,
+				ABS_MT_POSITION_Y, point_y);
+		}
+		dev_wdt87xx->finger_last_flag[point_id] = (*ptr_raw_buf & 0x1);
+		ptr_raw_buf += FINGER_EV_SIZE;
+	}
+
+	input_mt_sync_frame(dev_wdt87xx->input_dev);
+	input_sync(dev_wdt87xx->input_dev);
+
+leave_irq:
+	return IRQ_HANDLED;
+}
+
+
+static int wdt87xx_ts_request_irq(struct i2c_client *client)
+{
+	int err = 0;
+	struct wdt87xx_ts_data *dev_wdt87xx;
+
+	dev_wdt87xx = i2c_get_clientdata(client);
+
+	err = request_threaded_irq(client->irq, NULL, wdt87xx_ts_interrupt,
+		IRQF_ONESHOT, client->name, dev_wdt87xx);
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
+	int err = 0;
+	struct wdt87xx_ts_data *dev_wdt87xx;
+	struct input_dev	*input_dev;
+
+	dev_wdt87xx = (struct wdt87xx_ts_data *) i2c_get_clientdata(client);
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&client->dev, "%s: failed to allocate input device\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	dev_wdt87xx->input_dev = input_dev;
+
+	input_dev->name = "WDT87xx Touchscreen";
+	input_dev->id.bustype = BUS_I2C;
+
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+
+	/* for single touch */
+	set_bit(ABS_X, input_dev->absbit);
+	set_bit(ABS_Y, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_X, 0, SCREEN_LOGICAL_MAX_X, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, SCREEN_LOGICAL_MAX_Y, 0, 0);
+	input_abs_set_res(input_dev, ABS_X, WDT_UNITS_PER_MM);
+	input_abs_set_res(input_dev, ABS_Y, WDT_UNITS_PER_MM);
+
+	input_mt_init_slots(input_dev, WDT_MAX_POINT,
+		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+
+	set_bit(ABS_MT_TOUCH_MAJOR, input_dev->absbit);
+	set_bit(ABS_MT_POSITION_X, input_dev->absbit);
+	set_bit(ABS_MT_POSITION_Y, input_dev->absbit);
+	set_bit(ABS_MT_WIDTH_MAJOR, input_dev->absbit);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
+				SCREEN_LOGICAL_MAX_X, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
+				SCREEN_LOGICAL_MAX_Y, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 0xFF, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, 200, 0, 0);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_X, WDT_UNITS_PER_MM);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_Y, WDT_UNITS_PER_MM);
+
+	set_bit(ABS_PRESSURE, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 0xFF, 0, 0);
+
+	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
+		WDT_MAX_POINT, 0, 0);
+
+	set_bit(EV_ABS, input_dev->evbit);
+	set_bit(EV_SYN, input_dev->evbit);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(&client->dev, "register input device fail (%d)\n",
+			err);
+		input_free_device(input_dev);
+		dev_wdt87xx->input_dev = 0;
+		return err;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_ts_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx;
+	int err = 0;
+
+	dev_dbg(&client->dev, "wdt87xx : adapter=(%d), client irq:(%d)\n",
+		client->adapter->nr, client->irq);
+
+	/* check if the I2C function is ok in this adaptor */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	dev_dbg(&client->dev, "kzalloc\n");
+	dev_wdt87xx = devm_kzalloc(&client->dev,
+		sizeof(struct wdt87xx_ts_data), GFP_KERNEL);
+	if (!dev_wdt87xx) {
+		err = -ENOMEM;
+		goto exit_alloc_data_fail;
+	}
+
+	dev_dbg(&client->dev, "i2c_set_clientdata\n");
+
+	dev_wdt87xx->client = client;
+	mutex_init(&dev_wdt87xx->sysfs_mutex);
+	i2c_set_clientdata(client, dev_wdt87xx);
+	dev_wdt87xx->max_retries = MAX_RETRIES;
+
+	dev_dbg(&client->dev, "wdt87xx_ts_request_irq\n");
+	err = wdt87xx_ts_request_irq(client);
+	if (err < 0) {
+		dev_err(&client->dev, "request irq fail (%d)\n", err);
+		goto exit_irq_request;
+	}
+
+	dev_dbg(&client->dev, "wdt87xx_ts_create_input_device\n");
+	err = wdt87xx_ts_create_input_device(client);
+	if (err < 0) {
+		dev_err(&client->dev, "create input device fail (%d)\n", err);
+		goto exit_create_input_device;
+	}
+
+	dev_dbg(&client->dev, "sysfs_create_group\n");
+	err = sysfs_create_group(&client->dev.kobj, &wdt87xx_attr_group);
+	if (err) {
+		dev_err(&client->dev, "create sysfs fail (%d)\n", err);
+		goto exit_sysfs_group;
+	}
+
+	enable_irq(client->irq);
+
+	dev_dbg(&client->dev, "%s leave\n", __func__);
+
+	return 0;
+
+exit_sysfs_group:
+	if (dev_wdt87xx->input_dev)
+		input_unregister_device(dev_wdt87xx->input_dev);
+exit_create_input_device:
+	if (client->irq)
+		free_irq(client->irq, dev_wdt87xx);
+exit_irq_request:
+exit_alloc_data_fail:
+	return err;
+}
+
+static int wdt87xx_ts_remove(struct i2c_client *client)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx =
+		(struct wdt87xx_ts_data *) i2c_get_clientdata(client);
+
+	dev_dbg(&client->dev, "==%s==\n", __func__);
+
+	sysfs_remove_group(&client->dev.kobj, &wdt87xx_attr_group);
+
+	if (client->irq)
+		free_irq(client->irq, dev_wdt87xx);
+
+	if (dev_wdt87xx->input_dev)
+		input_unregister_device(dev_wdt87xx->input_dev);
+
+	return 0;
+}
+
+static int __maybe_unused wdt87xx_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int err = 0;
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
+	int err = 0;
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

