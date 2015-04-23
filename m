From: HungNien Chen <hn.chen@weidahitech.com>
Subject: [PATCH] [Input: add a driver for wdt87xx touchscreen controller]  The main function of this driver is to report touch events and update firmware for the controller.
Date: Fri, 24 Apr 2015 00:21:31 +0800
Message-ID: <1429806091-5089-1-git-send-email-hn.chen@weidahitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2120 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966423AbbDWQ1j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 12:27:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/Kconfig       |   12 +
 drivers/input/touchscreen/Makefile      |    1 +
 drivers/input/touchscreen/wdt87xx_i2c.c | 1495 +++++++++++++++++++++++++++++++
 3 files changed, 1508 insertions(+)
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
index 0000000..c77296c
--- /dev/null
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -0,0 +1,1495 @@
+/*
+ * drivers/input/touchscreen/wdt87xx_i2c.c
+ *
+ * Weida HiTech WDT87xx TouchScreen I2C driver
+ *
+ * Copyright (c) 2014  Weida HiTech Ltd.
+ * HN Chen <hn.chen@weidahitech.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
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
+
+#ifdef	CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
+
+#define WDT87XX_NAME		"wdt87xx_i2c"
+#define	WDT87XX_DRV_VER		"0.9.0"
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
+/* the definition for one touch point */
+struct  wdt_touch_point_event_st {
+	unsigned char		id;
+	unsigned short		x;
+	unsigned short		y;
+} __packed;
+
+
+/* the definition for a packet */
+struct  wdt_touch_events_st {
+	unsigned char		report_id;
+	struct  wdt_touch_point_event_st	touch_event[WDT_MAX_POINT];
+	unsigned short		scan_time;
+	unsigned char		num_touches;
+} __packed;
+
+/* the definition for the chip parameters */
+struct	sys_param_st {
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
+	struct	sys_param_st		sys_param;
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
+union cmd_data_un {
+	struct {
+	char		report_id;
+	char		type;
+	unsigned short	index;
+	unsigned int	length;
+	} defined_data;
+	char	buffer[8];
+};
+
+/* the definition of packet structure */
+union req_data_un {
+	struct {
+	char		report_id;
+	char		type;
+	unsigned short	index;
+	unsigned int	length;
+	char		data[PACKET_SIZE];
+	} defined_data;
+	char	buffer[64];
+};
+
+/* the definition of firmware data structure */
+struct chunk_info_st {
+	unsigned int	target_start_addr;
+	unsigned int	length;
+	unsigned int	source_start_addr;
+	unsigned int	version_number;
+	unsigned int	attribute;
+	unsigned int	temp;
+};
+
+struct chunk_data_st {
+	unsigned int	ck_id;
+	unsigned int	ck_size;
+	struct chunk_info_st	chunk_info;
+	char		*chunk_data;
+};
+
+struct format_chunk_st {
+	unsigned int	ck_id;
+	unsigned int	ck_size;
+	unsigned int	number_chunk;
+	unsigned int	enable_flag;
+	unsigned int	checksum;
+	unsigned int	temp1;
+	unsigned int	temp2;
+};
+
+struct chunk_info_ex_st {
+	struct chunk_info_st	chunk_info;
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
+/* the definition of gpio & data irq */
+#ifndef	CONFIG_ACPI
+/*
+ * for kernel version >= 3.18.0, the gpio number is 338
+ * #define DINT_GPIO_NUM	338
+ */
+#define		DINT_GPIO_NUM		82
+#endif
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
+static int wdt87xx_set_feature(struct i2c_client *client, char *buf,
+		unsigned int buf_size);
+static int wdt87xx_get_feature(struct i2c_client *client, char *buf,
+		unsigned int buf_size);
+static int wdt87xx_get_string(struct i2c_client *client, char str_idx,
+		char *buf, unsigned int buf_size);
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
+	struct chunk_info_ex_st *chunk_info_ex,
+	struct format_chunk_st *format_chunk)
+{
+	unsigned int	chunk_four_cc;
+	const char	*data = 0;
+	unsigned int	data_len = 0;
+	unsigned int	is_found = 0;
+
+	/* check the pointer is null */
+	if (!fw || !chunk_info_ex || !format_chunk)
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
+	if (format_chunk->enable_flag | chunk_index) {
+		unsigned int	chunk_start_pos = 12
+			+ sizeof(struct format_chunk_st);
+		struct chunk_data_st	*chunk_data = 0;
+
+		while (chunk_start_pos < data_len && !is_found)	{
+			chunk_data = (struct chunk_data_st *)
+				&data[chunk_start_pos];
+
+			/* the chunk is found */
+			if (chunk_data->ck_id == chunk_four_cc)	{
+				memcpy((void *) &chunk_info_ex->chunk_info,
+					(void *) &chunk_data->chunk_info,
+					sizeof(struct chunk_info_st));
+				chunk_info_ex->length =
+					chunk_data->chunk_info.length;
+				chunk_info_ex->data =
+					(char *) &data[chunk_start_pos + 8
+					+ sizeof(struct chunk_info_st)];
+
+				is_found = 1;
+			} else {
+				chunk_start_pos = chunk_start_pos
+					+ chunk_data->ck_size + 8;
+			}
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
+	struct sys_param_st *sys_param = &dev_wdt87xx->sys_param;
+	char		buffer[72];
+	unsigned int	*u32_data;
+	int		err = 0;
+
+	err = wdt87xx_get_string(client, STRIDX_PARAMETERS, buffer, 32);
+	if (err) {
+		dev_err(&client->dev, "get parameters error (%d)\n", err);
+		return err;
+	}
+
+	memcpy((void *) &dev_wdt87xx->sys_param, buffer,
+		sizeof(struct sys_param_st));
+
+	err = wdt87xx_get_string(client, STRIDX_PLATFORM_ID, buffer, 8);
+	if (err) {
+		dev_err(&client->dev, "get platform id error (%d)\n", err);
+		return err;
+	}
+
+	dev_wdt87xx->sys_param.plat_id = buffer[1];
+
+	buffer[0] = 0xf2;
+	err = wdt87xx_get_feature(client, buffer, 16);
+	if (err) {
+		dev_err(&client->dev, "get firmware id error (%d)\n", err);
+		return err;
+	}
+
+	if (buffer[0] != 0xf2) {
+		dev_err(&client->dev, "fw id packet error !\n");
+		return -EBADRQC;
+	}
+
+	u32_data = (unsigned int *) &buffer[1];
+	sys_param->fw_id = ((*u32_data) & 0xFFFF);
+
+	dev_err(&client->dev, "fw_id: 0x%x, plat_id: 0x%x\n",
+		sys_param->fw_id, sys_param->plat_id);
+	dev_err(&client->dev, "xml_id1: %4x, xml_id2: %4x\n",
+		sys_param->xmls_id1, sys_param->xmls_id2);
+
+	return 0;
+}
+
+int  process_fw_data(struct i2c_client *client, const struct firmware *fw,
+				struct format_chunk_st *format_chunk)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	unsigned int	length = 0;
+	struct chunk_info_ex_st		chunk_info_ex;
+	int		err = 0;
+	unsigned int	*u32_data;
+	char		fw_id;
+	char		chip_id;
+
+	/* check the pointer is null */
+	if (!fw || !format_chunk)
+		return -EINVAL;
+
+	u32_data = (unsigned int *) fw->data;
+	length = fw->size;
+
+	if (u32_data[0] != FOURCC_ID_RIFF || u32_data[2] != FOURCC_ID_WHIF) {
+		dev_err(&client->dev, "Check data tag failed !\n");
+		return -EBADRQC;
+	}
+
+	/* the length should be equal */
+	if (length != u32_data[1]) {
+		dev_err(&client->dev, "Check data length failed !\n");
+		return -EINVAL;
+	}
+
+	memcpy(format_chunk, &u32_data[3], sizeof(struct format_chunk_st));
+
+	dev_dbg(&client->dev, "version checking\n");
+
+	/* get the version number from the firmware */
+	err = get_chunk_info(fw, CHUNK_ID_FRWR, &chunk_info_ex,
+		format_chunk);
+	if (err) {
+		dev_err(&client->dev, "can not extract data !\n");
+		return -EBADR;
+	}
+
+	fw_id = ((chunk_info_ex.chunk_info.version_number >> 12) & 0xF);
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
+static int wdt87xx_check_firmware(struct chunk_info_ex_st *chunk_info_ex,
+			int ck_id)
+{
+	/* check the pointer is null */
+	if (!chunk_info_ex)
+		return -EINVAL;
+
+	if (ck_id == CHUNK_ID_FRWR) {
+		unsigned int	is_found = 0;
+		unsigned char firmware_id[] = { 0xf5, 0x68, 0xe3, 0xa9 };
+
+		if (memcmp(chunk_info_ex->data, firmware_id, 4) == 0)
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
+static int wdt87xx_set_feature(struct i2c_client *client, char *buf,
+		unsigned int buf_size)
+{
+	int	err = 0;
+	union req_data_un	*req_data = (union req_data_un *) buf;
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
+	if (req_data->defined_data.report_id > 0xF) {
+		xfer_buffer[data_len++] = 0x30;
+		xfer_buffer[data_len++] = 0x03;
+		xfer_buffer[data_len++] = (req_data->defined_data.report_id);
+	} else {
+		xfer_buffer[data_len++] = 0x30 |
+			(req_data->defined_data.report_id);
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
+static int wdt87xx_get_feature(struct i2c_client *client, char *buf,
+		unsigned int buf_size)
+{
+	int	err = 0;
+	char	tx_buffer[8];
+	char	xfer_buffer[80];
+	union req_data_un *req_data = (union req_data_un *) buf;
+	int		data_len = 0;
+	unsigned int	xfer_length = 0;
+
+	if (buf_size > 64)
+		buf_size = 64;
+
+	/* get feature command packet */
+	tx_buffer[data_len++] = 0x22;
+	tx_buffer[data_len++] = 0x00;
+	if (req_data->defined_data.report_id > 0xF) {
+		tx_buffer[data_len++] = 0x30;
+		tx_buffer[data_len++] = 0x02;
+		tx_buffer[data_len++] = (req_data->defined_data.report_id);
+	} else {
+		tx_buffer[data_len++] = 0x30 |
+			(req_data->defined_data.report_id);
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
+	xfer_length = (unsigned int) xfer_buffer[1];
+	xfer_length = (xfer_length << 8) | xfer_buffer[0];
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
+static int wdt87xx_get_string(struct i2c_client *client, char str_idx,
+		char *buf, unsigned int buf_size)
+{
+	int	err = 0;
+	char	tx_buffer[8] = { 0x22, 0x00, 0x13, 0x0E,
+		0x00, 0x23, 0x00, 0x00 };
+	char	xfer_buffer[80];
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
+	union cmd_data_un	cmd_data;
+
+	/* set the command packet */
+	cmd_data.defined_data.report_id = VND_REQ_WRITE;
+	cmd_data.defined_data.type = VND_SET_COMMAND_DATA;
+	cmd_data.defined_data.index = (unsigned short) cmd;
+
+	switch (cmd)	{
+	case	VND_CMD_START:
+	case	VND_CMD_STOP:
+	case	VND_CMD_RESET:
+		/* mode selector */
+		cmd_data.defined_data.length = (char) (value & 0xFF);
+		break;
+	case	VND_CMD_SFLCK:
+		put_unaligned_le16(0xC39B, &cmd_data.buffer[3]);
+		break;
+	case	VND_CMD_SFUNL:
+		put_unaligned_le16(0x95DA, &cmd_data.buffer[3]);
+		break;
+	case	VND_CMD_ERASE:
+	case	VND_SET_CHECKSUM_CALC:
+	case	VND_SET_CHECKSUM_LENGTH:
+		put_unaligned_le32(value, &cmd_data.buffer[3]);
+		break;
+	default:
+		cmd_data.defined_data.report_id = 0;
+		dev_err(&client->dev, "Invalid command: (%d)", cmd);
+		return -EINVAL;
+	}
+
+	return wdt87xx_set_feature(client, &cmd_data.buffer[0],
+		sizeof(cmd_data));
+}
+
+static int wdt87xx_write_data(struct i2c_client *client,
+		const char *data, unsigned int address, int length)
+{
+	unsigned int	addr_start, data_len, packet_size;
+	int		count = 0;
+	int		err = 0;
+	union req_data_un	req_data;
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
+	req_data.defined_data.report_id = VND_REQ_WRITE;
+	req_data.defined_data.type = VND_SET_DATA;
+
+	while (data_len) {
+		if (data_len < PACKET_SIZE)
+			packet_size = data_len;
+
+		req_data.defined_data.index = packet_size;
+		req_data.defined_data.length = addr_start;
+
+		memcpy(req_data.defined_data.data, source_data, packet_size);
+
+		err = wdt87xx_set_feature(client, req_data.buffer, 64);
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
+	union req_data_un	req_data;
+	union cmd_data_un	cmd_data;
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
+	cmd_data.defined_data.report_id = VND_REQ_READ;
+	cmd_data.defined_data.type = VND_GET_CHECKSUM;
+	cmd_data.defined_data.index = 0;
+	cmd_data.defined_data.length = 0;
+
+	err = wdt87xx_set_feature(client, cmd_data.buffer, 8);
+	if (err) {
+		dev_err(&client->dev, "checksum set read fail (%d)\n", err);
+		return err;
+	}
+
+	memset(req_data.buffer, 0, 64);
+	req_data.defined_data.report_id = VND_READ_DATA;
+	err = wdt87xx_get_feature(client, req_data.buffer, 64);
+	if (err) {
+		dev_err(&client->dev, "read checksum fail (%d)\n", err);
+		return err;
+	}
+
+	*checksum = (req_data.buffer[9] << 8) | (req_data.buffer[8]);
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
+		struct chunk_info_ex_st *chunk_info_ex, int type)
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
+	start_addr = chunk_info_ex->chunk_info.target_start_addr;
+	size = chunk_info_ex->chunk_info.length;
+	data = chunk_info_ex->data;
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
+		struct format_chunk_st *format_chunk, unsigned int ck_id)
+{
+	int err = 0;
+	struct chunk_info_ex_st		chunk_info_ex;
+
+	err = get_chunk_info(fw, ck_id, &chunk_info_ex, format_chunk);
+	if (err) {
+		dev_err(&client->dev, "can not get the fw !\n");
+		goto failed;
+	}
+
+	/* Check for incorrect bin file */
+	err = wdt87xx_check_firmware(&chunk_info_ex, ck_id);
+	if (err) {
+		dev_err(&client->dev, "invalid chunk : (%d)\n", ck_id);
+		goto failed;
+	}
+
+	err = wdt87xx_write_firmware(client, &chunk_info_ex, ck_id);
+	if (err)
+		dev_err(&client->dev, "write firmware failed : (%d)\n",
+			ck_id);
+
+failed:
+	return err;
+}
+
+static int wdt87xx_load_fw(struct device *dev, const char *fn, int type)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	const struct firmware *fw = 0;
+	int err = 0;
+	struct format_chunk_st	format_chunk;
+
+	err = request_firmware(&fw, fn, dev);
+	if (err) {
+		dev_err(&client->dev, "unable to open firmware %s\n", fn);
+		return err;
+	}
+
+	disable_irq(client->irq);
+
+	err = process_fw_data(client, fw, &format_chunk);
+	if (err) {
+		dev_err(&client->dev, "bad fw file !\n");
+		goto release_firmware;
+	}
+
+	if (type & WDT87XX_FW)	{
+		err = wdt87xx_load_chunk(client, fw, &format_chunk,
+			CHUNK_ID_FRWR);
+		if (err) {
+			dev_err(&client->dev, "load fw chunk failed !\n");
+			goto release_firmware;
+		}
+	}
+
+	if (type & WDT87XX_CFG)	{
+		err = wdt87xx_load_chunk(client, fw, &format_chunk,
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
+	int err = 0;
+	int option = 0;
+
+	if (count > 0)
+		option = buf[0] - '0';
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
+static ssize_t wdt87xx_max_retries(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+
+	int option = 0;
+
+	if (count > 0)
+		option = buf[0] - '0';
+
+	dev_wdt87xx->max_retries = option;
+	dev_info(dev, "max retries (%d)\n", option);
+
+	return count;
+}
+
+static ssize_t wdt87xx_show_info(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
+	struct sys_param_st *sys_param = &dev_wdt87xx->sys_param;
+
+	wdt87xx_get_sysparam(client, dev_wdt87xx);
+
+	return scnprintf(buf, PAGE_SIZE, "%x,%x,%4x,%4x\n", sys_param->fw_id,
+			sys_param->plat_id, sys_param->xmls_id1,
+			sys_param->xmls_id2);
+}
+
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, wdt87xx_update_fw);
+static DEVICE_ATTR(max_retries, S_IWUSR, NULL, wdt87xx_max_retries);
+static DEVICE_ATTR(show_info, S_IRUGO, wdt87xx_show_info, NULL);
+
+static struct attribute *wdt87xx_attrs[] = {
+			&dev_attr_update_fw.attr,
+			&dev_attr_max_retries.attr,
+			&dev_attr_show_info.attr,
+			NULL
+};
+
+static const struct attribute_group wdt87xx_attr_group = {
+			.attrs = wdt87xx_attrs,
+};
+
+static int wdt87xx_i2c_txrxdata(struct i2c_client *client, char *txdata,
+				int txlen, char *rxdata, int rxlen)
+{
+	int err = 0;
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
+	return err;
+}
+
+static int wdt87xx_i2c_rxdata(struct i2c_client *client, char *rxdata,
+				int length)
+{
+	int err = 0;
+
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= length,
+			.buf	= rxdata,
+		},
+	};
+
+	err = i2c_transfer(client->adapter, msgs, 1);
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
+	int err = 0;
+
+	struct i2c_msg msg[] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= length,
+			.buf	= txdata,
+		},
+	};
+
+	err = i2c_transfer(client->adapter, msg, 1);
+	if (err < 0)
+		dev_err(&client->dev, "%s: i2c write error (%d)\n",
+			__func__, err);
+
+	return err;
+}
+
+static void wdt87xx_ts_handle_irq(struct wdt87xx_ts_data *data)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx = data;
+	int err = 0;
+	int i, points;
+	struct i2c_client *client = dev_wdt87xx->client;
+	struct wdt_touch_events_st	*ptr_touch_event = 0;
+	u8 raw_buf[64] = {0};
+
+	static u8 points_last_flag[WDT_MAX_POINT<<1] = {0};
+
+	err = wdt87xx_i2c_rxdata(client, raw_buf, WDT_RAW_BUF_COUNT);
+
+	if (err < 0) {
+		dev_err(&client->dev, "read raw data fail (%d)\n", err);
+		return;
+	}
+
+	/* touch finger count */
+	points = raw_buf[53];
+
+	dev_dbg(&client->dev, "point: (%d)\n", points);
+
+	if (points == 0) {
+		for (i = 0; i < WDT_MAX_POINT; i++) {
+			/* force to send event of tip off */
+			if (points_last_flag[i] != 0) {
+				dev_dbg(&client->dev, "tip off (%d)\n", i);
+				input_mt_slot(dev_wdt87xx->input_dev, i);
+				input_mt_report_slot_state(
+					dev_wdt87xx->input_dev,
+					MT_TOOL_FINGER, false);
+			}
+		}
+
+		memset(points_last_flag, 0, sizeof(points_last_flag));
+
+		input_sync(dev_wdt87xx->input_dev);
+		return;
+	}
+
+	ptr_touch_event = (struct wdt_touch_events_st *) raw_buf;
+
+	dev_dbg(&client->dev, "+++++++++\n");
+
+	for (i = 0; i < WDT_MAX_POINT; i++) {
+		int point_id = (ptr_touch_event->touch_event[i].id >> 3) - 1;
+
+		if (point_id < 0)
+			continue;
+
+		/* tip off */
+		if (((ptr_touch_event->touch_event[i].id & 0x1) == 0) &&
+			(points_last_flag[point_id] != 0)) {
+			dev_dbg(&client->dev, "tip on (%d)\n", point_id);
+			input_mt_slot(dev_wdt87xx->input_dev, point_id);
+			input_mt_report_slot_state(dev_wdt87xx->input_dev,
+				MT_TOOL_FINGER, false);
+		} else  /* tip on */
+		if (ptr_touch_event->touch_event[i].id & 0x1) {
+			unsigned int	point_x, point_y;
+
+			/* incorrect coordinate */
+			if (ptr_touch_event->touch_event[i].x > 0x7FFF ||
+				ptr_touch_event->touch_event[i].y > 0x7FFF)
+				continue;
+
+			point_x = ptr_touch_event->touch_event[i].x;
+			point_y = ptr_touch_event->touch_event[i].y;
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
+		points_last_flag[point_id] =
+			(ptr_touch_event->touch_event[i].id & 0x1);
+	}
+
+	input_sync(dev_wdt87xx->input_dev);
+}
+
+static irqreturn_t wdt87xx_ts_interrupt(int irq, void *dev_id)
+{
+	struct wdt87xx_ts_data *dev_wdt87xx =
+		(struct wdt87xx_ts_data *) dev_id;
+
+	wdt87xx_ts_handle_irq(dev_wdt87xx);
+
+	return IRQ_HANDLED;
+}
+
+static int wdt87xx_ts_request_irq(struct i2c_client *client)
+{
+	int err = 0;
+	struct wdt87xx_ts_data *dev_wdt87xx;
+
+	dev_wdt87xx = (struct wdt87xx_ts_data *) i2c_get_clientdata(client);
+
+/*
+ * once using the ACPI, we shall get the irq number from the client
+ * if it is not in the ACPI, we shall get a irq number from the gpio
+ */
+#ifndef	CONFIG_ACPI
+	client->irq = 0;
+
+	/* request a selected gpio */
+	err = gpio_request(DINT_GPIO_NUM, "GPIO DINT");
+	if (err < 0) {
+		dev_err(&client->dev, "%s: request gpio fail (%d)\n",
+			__func__, err);
+		return -EINVAL;
+	}
+
+	/* request a irq no */
+	client->irq = gpio_to_irq(DINT_GPIO_NUM);
+	if (client->irq < 0) {
+		dev_err(&client->dev, "%s: request irq fail (%d)\n",
+			__func__, client->irq);
+		return -EINVAL;
+	}
+
+	gpio_direction_input(DINT_GPIO_NUM);
+	gpio_set_value(DINT_GPIO_NUM, 1);
+#endif
+
+	irq_set_irq_type(client->irq, IRQ_TYPE_EDGE_FALLING);
+
+	err = request_threaded_irq(client->irq, NULL, wdt87xx_ts_interrupt,
+		IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+		client->name, dev_wdt87xx);
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
+
+	input_mt_init_slots(input_dev, WDT_MAX_POINT, INPUT_MT_DIRECT);
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
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		err = -ENODEV;
+		goto exit_check_functionality_fail;
+	}
+
+	dev_dbg(&client->dev, "kzalloc\n");
+	dev_wdt87xx = (struct wdt87xx_ts_data *)
+		kzalloc(sizeof(struct wdt87xx_ts_data), GFP_KERNEL);
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
+		goto exit_gpio_request_fail;
+	}
+
+	dev_dbg(&client->dev, "wdt87xx_ts_create_input_device\n");
+	err = wdt87xx_ts_create_input_device(client);
+	if (err < 0) {
+		dev_err(&client->dev, "create input device fail (%d)\n", err);
+		goto exit_input_register_device_fail;
+	}
+
+	dev_dbg(&client->dev, "sysfs_create_group\n");
+	err = sysfs_create_group(&client->dev.kobj, &wdt87xx_attr_group);
+	if (err) {
+		dev_err(&client->dev, "create sysfs fail (%d)\n", err);
+		goto err_free_object;
+	}
+
+	enable_irq(client->irq);
+
+	dev_dbg(&client->dev, "%s leave\n", __func__);
+
+	return 0;
+
+err_free_object:
+exit_input_register_device_fail:
+	input_free_device(dev_wdt87xx->input_dev);
+
+
+exit_gpio_request_fail:
+#ifndef	CONFIG_ACPI
+	gpio_free(DINT_GPIO_NUM);
+#endif
+	if (client->irq)
+		free_irq(client->irq, dev_wdt87xx);
+
+	i2c_set_clientdata(client, NULL);
+
+	kfree(dev_wdt87xx);
+exit_alloc_data_fail:
+exit_check_functionality_fail:
+
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
+	input_unregister_device(dev_wdt87xx->input_dev);
+	input_free_device(dev_wdt87xx->input_dev);
+
+#ifndef CONFIG_ACPI
+	gpio_free(DINT_GPIO_NUM);
+#endif
+
+	if (client->irq)
+		free_irq(client->irq, dev_wdt87xx);
+
+	i2c_set_clientdata(client, NULL);
+	kfree(dev_wdt87xx);
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
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id wdt87xx_acpi_id[] = {
+	{ "WDHT0001", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, wdt87xx_acpi_id);
+#endif
+
+static struct i2c_driver wdt87xx_driver = {
+	.probe		= wdt87xx_ts_probe,
+	.remove		= wdt87xx_ts_remove,
+	.id_table	= wdt87xx_dev_id,
+	.driver	= {
+		.name	= WDT87XX_NAME,
+		.owner	= THIS_MODULE,
+		.pm     = &wdt87xx_pm_ops,
+#ifdef CONFIG_ACPI
+		.acpi_match_table = ACPI_PTR(wdt87xx_acpi_id),
+#endif
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

