From: <hn.chen@weidahitech.com>
Subject: [PATCH] Input: wdt87xx_i2c - support new controller WDT8752
Date: Fri, 9 Sep 2016 18:42:19 +0800
Message-ID: <1473417739-10222-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:1633 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbcIIKkk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2016 06:40:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, HungNien Chen <hn.chen@weidahitech.com>

From: HungNien Chen <hn.chen@weidahitech.com>

To support WDT8752 is main modification of this version and description as
below:
1. Add definitions for WDT8752.
2. Modify wdt87xx_get_param to have the right method to communicate with the
controller. Also add wdt87xx_get_param_hid for retrieving parameters from
the controller.
3. Controller specific function pointers are selected when detected controller
and they are used in FW writing.
4. Add functions for WDT8752: wdt8752_send_command, wdt8752_write_data,
wdt8752_delay, wdt8752_checksum_check and some minor functions.
5. Modify supend/resume flow to support IDLE and SLEEP.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 963 +++++++++++++++++++++++++-------
 1 file changed, 749 insertions(+), 214 deletions(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index 2519617..27553cd 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -22,10 +22,15 @@
 #include <linux/acpi.h>
 #include <asm/unaligned.h>
 
-#define WDT87XX_NAME		"wdt87xx_i2c"
-#define WDT87XX_DRV_VER		"0.9.8"
-#define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
-#define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
+#define WDT87XX_NAME			"wdt87xx_i2c"
+#define WDT87XX_DRV_VER			"0.9.9"
+#define WDT87XX_FW_NAME			"wdt87xx_fw.bin"
+#define WDT87XX_CFG_NAME		"wdt87xx_cfg.bin"
+
+#define	PLT_WDT8756			0x00
+#define	PLT_WDT8752			0x01
+
+#define	RPT_ID_TOUCH			0x01
 
 #define MODE_ACTIVE			0x01
 #define MODE_READY			0x02
@@ -34,8 +39,7 @@
 #define MODE_STOP			0xFF
 
 #define WDT_MAX_FINGER			10
-#define WDT_RAW_BUF_COUNT		54
-#define WDT_V1_RAW_BUF_COUNT		74
+#define WDT_RAW_BUF_COUNT		76
 #define WDT_FIRMWARE_ID			0xa9e368f5
 
 #define PG_SIZE				0x1000
@@ -43,32 +47,23 @@
 
 #define MAX_UNIT_AXIS			0x7FFF
 
+#define	PKT_TX_SIZE			16
 #define PKT_READ_SIZE			72
 #define PKT_WRITE_SIZE			80
 
 /* the finger definition of the report event */
 #define FINGER_EV_OFFSET_ID		0
-#define FINGER_EV_OFFSET_X		1
-#define FINGER_EV_OFFSET_Y		3
-#define FINGER_EV_SIZE			5
-
-#define FINGER_EV_V1_OFFSET_ID		0
-#define FINGER_EV_V1_OFFSET_W		1
-#define FINGER_EV_V1_OFFSET_P		2
-#define FINGER_EV_V1_OFFSET_X		3
-#define FINGER_EV_V1_OFFSET_Y		5
-#define FINGER_EV_V1_SIZE		7
+#define FINGER_EV_OFFSET_W		1
+#define FINGER_EV_OFFSET_P		2
+#define FINGER_EV_OFFSET_X		3
+#define FINGER_EV_OFFSET_Y		5
+#define FINGER_EV_SIZE			7
 
 /* The definition of a report packet */
 #define TOUCH_PK_OFFSET_REPORT_ID	0
 #define TOUCH_PK_OFFSET_EVENT		1
-#define TOUCH_PK_OFFSET_SCAN_TIME	51
-#define TOUCH_PK_OFFSET_FNGR_NUM	53
-
-#define TOUCH_PK_V1_OFFSET_REPORT_ID	0
-#define TOUCH_PK_V1_OFFSET_EVENT	1
-#define TOUCH_PK_V1_OFFSET_SCAN_TIME	71
-#define TOUCH_PK_V1_OFFSET_FNGR_NUM	73
+#define TOUCH_PK_OFFSET_SCAN_TIME	71
+#define TOUCH_PK_OFFSET_FNGR_NUM	73
 
 /* The definition of the controller parameters */
 #define CTL_PARAM_OFFSET_FW_ID		0
@@ -84,6 +79,7 @@
 #define CTL_PARAM_OFFSET_PHY_W		22
 #define CTL_PARAM_OFFSET_PHY_H		24
 #define CTL_PARAM_OFFSET_FACTOR		32
+#define	CTL_PARAM_OFFSET_I2C_CFG	36
 
 /* The definition of the device descriptor */
 #define WDT_GD_DEVICE			1
@@ -95,6 +91,8 @@
 #define VND_REQ_READ			0x06
 #define VND_READ_DATA			0x07
 #define VND_REQ_WRITE			0x08
+#define VND_REQ_FW_INFO			0xF2
+#define	VND_REQ_CTRLER_INFO		0xF4
 
 #define VND_CMD_START			0x00
 #define VND_CMD_STOP			0x01
@@ -104,6 +102,8 @@
 
 #define VND_GET_CHECKSUM		0x66
 
+#define	VND_CMD_DEV_MODE		0x82
+
 #define VND_SET_DATA			0x83
 #define VND_SET_COMMAND_DATA		0x84
 #define VND_SET_CHECKSUM_CALC		0x86
@@ -155,12 +155,85 @@
 #define FW_CHUNK_PAYLOAD_OFFSET		32
 
 /* Controller requires minimum 300us between commands */
-#define WDT_COMMAND_DELAY_MS		2
-#define WDT_FLASH_WRITE_DELAY_MS	4
-#define	WDT_FLASH_ERASE_DELAY_MS	200
-#define WDT_FW_RESET_TIME		2500
+#define	WDT_CMD_DELAY_US		300
+#define W8752_ERASE4K_DELAY_MS		500
+#define WDT_FLASH_WRITE_DELAY_MS	2
+#define WDT_FW_RESET_TIME_MS		2500
+#define WDT_POLLING_PERIOD_MS		20
+#define W8756_ERASE4K_DELAY_MS		200
+
+/* The definition for WDT8752 */
+#define	W8752_READ_OFFSET_MASK		0x10000
+#define W8752_DEV_INFO_READ_OFFSET	0xC
+#define	W8752_PKT_HEADER_SZ		4
+#define	W8752_PKT_SIZE			60
+
+#define W8752_STATUS_OK			0x80
+#define	W8752_STATUS_BUSY		0xFE
+
+/* Communication commands of WDT8752 */
+#define	W8752_BASIC_COMMAND		0x85
+#define W8752_FW_COMMAND		0x91
+
+#define	W8755_FW_GET_DEV_INFO		0x73
+
+#define	W8752_SET_FLASH			0x83
+#define	W8752_SET_FLASH_ADDRESS		0x87
+#define	W8752_SET_CHECKSUM_CALC		0x88
+#define	W8752_GET_CHECKSUM		0x65
+
+#define	W8752_CMD_SFLOCK		0x00
+#define	W8752_CMD_SFUNLOCK		0x01
+#define	W8752_CMD_RESET			0x02
+#define	W8752_CMD_ERASE4K		0x03
+#define	W8752_CMD_DEV_MODE		0x82
+
+#define	W8752_DM_SENSING		0x1
+#define W8752_DM_DOZE			0x2
+#define W8755_DM_SLEEP			0x3
+#define	W8752_DM_COMMAND		0x90
+
+#define	W8752_SFLOCK_KEY		0x9B
+#define W8752_SFUNLOCK_KEY		0xDA
+
+/* The definition of the command packet of WDT8752 */
+#define	CMD_SIZE_OFFSET			0x2
+#define CMD_ID_OFFSET			0x4
+#define	CMD_DATA1_OFFSET		0x4
+#define	CMD_VALUE_OFFSET		0x5
+
+#define W8752_POLLING_PERIOD_US		5000
+#define W8752_FLASH_WRITE_DELAY_US	100
+
+#define W8752_PROG_SECTOR_SIZE		0x100
+
+#define W8752_HID_DESC_ADDR		0x20
+
+/* The definition of controller parameters of WDT8752 */
+#define W8752_PARAM_KEY			0x154f
+#define W8752_PARAM_KEY_OFFSET		0x2
+#define W8752_PLAT_ID_OFFSET		0x5
+#define W8752_PARAM_OFFSET		0xA
+#define	W8752_PARAM_LEN_OFFSET		0xC
+
+struct i2c_hid_desc {
+	u16	desc_length;
+	u16	bcd_version;
+	u16	rpt_desc_length;
+	u16	rpt_desc_register;
+	u16	input_register;
+	u16	max_input_length;
+	u16	output_register;
+	u16	max_output_length;
+	u16	cmd_register;
+	u16	data_register;
+	u16	vendor_id;
+	u16	product_id;
+	u16	version_id;
+	u32	reserved;
+} __packed;
 
-struct wdt87xx_sys_param {
+struct wdt87xx_param {
 	u16	fw_id;
 	u16	plat_id;
 	u16	xmls_id1;
@@ -174,17 +247,31 @@ struct wdt87xx_sys_param {
 	u32	max_y;
 	u16	vendor_id;
 	u16	product_id;
-};
+	u16	i2c_cfg;
+} __packed;
 
 struct wdt87xx_data {
 	struct i2c_client		*client;
 	struct input_dev		*input;
 	/* Mutex for fw update to prevent concurrent access */
 	struct mutex			fw_mutex;
-	struct wdt87xx_sys_param	param;
+	struct wdt87xx_param		param;
+	struct i2c_hid_desc		hid_desc;
 	u8				phys[32];
+	u32				plt_id;
+	bool				wake_irq_enabled;
+
+	/* Function ptrs for different controller body */
+	int (*send_cmd)(struct i2c_client *client, int cmd, int value);
+	int (*write_flash)(struct i2c_client *client, const char *data,
+			   u32 addr, size_t len);
+	int (*chksum_check)(struct i2c_client *client, const char *data,
+			    u32 addr, size_t len);
+	int (*delay)(struct i2c_client *client, u32 delay);
 };
 
+static int wdt8752_set_dev_mode(struct i2c_client *client, u8 mode);
+
 static int wdt87xx_i2c_xfer(struct i2c_client *client,
 			    void *txdata, size_t txlen,
 			    void *rxdata, size_t rxlen)
@@ -214,6 +301,8 @@ static int wdt87xx_i2c_xfer(struct i2c_client *client,
 		return error;
 	}
 
+	udelay(WDT_CMD_DELAY_US);
+
 	return 0;
 }
 
@@ -225,8 +314,8 @@ static int wdt87xx_get_desc(struct i2c_client *client, u8 desc_idx,
 
 	tx_buf[2] |= desc_idx & 0xF;
 
-	error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf),
-				 buf, len);
+	error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf), buf, len);
+
 	if (error) {
 		dev_err(&client->dev, "get desc failed: %d\n", error);
 		return error;
@@ -238,8 +327,6 @@ static int wdt87xx_get_desc(struct i2c_client *client, u8 desc_idx,
 		return -EINVAL;
 	}
 
-	mdelay(WDT_COMMAND_DELAY_MS);
-
 	return 0;
 }
 
@@ -270,23 +357,23 @@ static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
 	rx_len = min_t(size_t, len, rx_buf[0]);
 	memcpy(buf, &rx_buf[2], rx_len);
 
-	mdelay(WDT_COMMAND_DELAY_MS);
-
 	return 0;
 }
 
 static int wdt87xx_get_feature(struct i2c_client *client,
-			       u8 *buf, size_t buf_size)
+			       u8 *buf, size_t len)
 {
-	u8 tx_buf[8];
+	u8 tx_buf[PKT_TX_SIZE];
 	u8 rx_buf[PKT_WRITE_SIZE];
 	size_t tx_len = 0;
-	size_t rx_len = buf_size + 2;
+	size_t rx_len = len + 2;
 	int error;
 
 	if (rx_len > sizeof(rx_buf))
 		return -EINVAL;
 
+	memset(tx_buf, 0, sizeof(tx_buf));
+
 	/* Get feature command packet */
 	tx_buf[tx_len++] = 0x22;
 	tx_buf[tx_len++] = 0x00;
@@ -307,16 +394,14 @@ static int wdt87xx_get_feature(struct i2c_client *client,
 		return error;
 	}
 
-	rx_len = min_t(size_t, buf_size, get_unaligned_le16(rx_buf));
+	rx_len = min_t(size_t, len, get_unaligned_le16(rx_buf));
 	memcpy(buf, &rx_buf[2], rx_len);
 
-	mdelay(WDT_COMMAND_DELAY_MS);
-
 	return 0;
 }
 
 static int wdt87xx_set_feature(struct i2c_client *client,
-			       const u8 *buf, size_t buf_size)
+			       const u8 *buf, size_t len)
 {
 	u8 tx_buf[PKT_WRITE_SIZE];
 	int tx_len = 0;
@@ -335,22 +420,21 @@ static int wdt87xx_set_feature(struct i2c_client *client,
 	}
 	tx_buf[tx_len++] = 0x23;
 	tx_buf[tx_len++] = 0x00;
-	tx_buf[tx_len++] = (buf_size & 0xFF);
-	tx_buf[tx_len++] = ((buf_size & 0xFF00) >> 8);
+	tx_buf[tx_len++] = (len & 0xFF);
+	tx_buf[tx_len++] = ((len & 0xFF00) >> 8);
 
-	if (tx_len + buf_size > sizeof(tx_buf))
+	if (tx_len + len > sizeof(tx_buf))
 		return -EINVAL;
 
-	memcpy(&tx_buf[tx_len], buf, buf_size);
-	tx_len += buf_size;
+	memcpy(&tx_buf[tx_len], buf, len);
+	tx_len += len;
 
 	error = i2c_master_send(client, tx_buf, tx_len);
 	if (error < 0) {
 		dev_err(&client->dev, "set feature failed: %d\n", error);
 		return error;
 	}
-
-	mdelay(WDT_COMMAND_DELAY_MS);
+	udelay(WDT_CMD_DELAY_US);
 
 	return 0;
 }
@@ -395,20 +479,389 @@ static int wdt87xx_send_command(struct i2c_client *client, int cmd, int value)
 	return wdt87xx_set_feature(client, cmd_buf, sizeof(cmd_buf));
 }
 
+static u16 misr(u16 cur_value, u16 new_value)
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
+static u16 wdt87xx_calculate_checksum(const u8 *data, size_t len, int byte_mode)
+{
+	u16 checksum = 0;
+	u16 *pdata_u16;
+	size_t i;
+
+	if (byte_mode)
+		for (i = 0; i < len; i++)
+			checksum = misr(checksum, (u16)data[i]);
+	else {
+		pdata_u16 = (u16 *)data;
+		for (i = 0; i < (len >> 1); i++)
+			checksum = misr(checksum, *pdata_u16++);
+	}
+
+	return checksum;
+}
+
+static int wdt8752_send_command(struct i2c_client *client, int cmd, int value)
+{
+	u8 cmd_buf[PKT_BUF_SIZE];
+	size_t size = 2;
+
+	/* Set the command packet and the packet size is variable in 8752 */
+	cmd_buf[CMD_REPORT_ID_OFFSET] = VND_REQ_WRITE;
+	cmd_buf[CMD_TYPE_OFFSET] = W8752_BASIC_COMMAND;
+
+	switch (cmd) {
+	case VND_CMD_STOP:
+		/*
+		 * Command STOP with STOP value, enter the command loop mode
+		 * for operating the flash in 8752
+		 */
+		if (value == MODE_STOP)
+			return wdt8752_set_dev_mode(client, W8752_DM_COMMAND);
+
+		/* Remap the value of mode to the right one */
+		if (value != MODE_ACTIVE)
+			value--;
+
+	case VND_CMD_DEV_MODE:
+		cmd_buf[CMD_TYPE_OFFSET] = W8752_FW_COMMAND;
+		cmd_buf[CMD_ID_OFFSET] = W8752_CMD_DEV_MODE;
+		cmd_buf[CMD_VALUE_OFFSET] = value;
+		break;
+
+	case VND_CMD_START:
+		return wdt8752_set_dev_mode(client, W8752_DM_SENSING);
+
+	case VND_CMD_RESET:
+		cmd_buf[CMD_ID_OFFSET] = W8752_CMD_RESET;
+		size = 1;
+		break;
+
+	case VND_CMD_SFLCK:
+		cmd_buf[CMD_ID_OFFSET] = W8752_CMD_SFLOCK;
+		cmd_buf[CMD_VALUE_OFFSET] = W8752_SFLOCK_KEY;
+		break;
+
+	case VND_CMD_SFUNL:
+		cmd_buf[CMD_ID_OFFSET] = W8752_CMD_SFUNLOCK;
+		cmd_buf[CMD_VALUE_OFFSET] = W8752_SFUNLOCK_KEY;
+		break;
+
+	case VND_CMD_ERASE:
+		cmd_buf[CMD_ID_OFFSET] = W8752_CMD_ERASE4K;
+		put_unaligned_le32(value, &cmd_buf[CMD_VALUE_OFFSET]);
+		size = 5;
+		break;
+
+	default:
+		cmd_buf[CMD_REPORT_ID_OFFSET] = 0;
+		dev_err(&client->dev, "Invalid command: %d\n", cmd);
+		return -EINVAL;
+	}
+
+	put_unaligned_le16(size, &cmd_buf[CMD_SIZE_OFFSET]);
+
+	return wdt87xx_set_feature(client, cmd_buf, W8752_PKT_HEADER_SZ + size);
+}
+
+static int wdt8752_exec_read_pkt(struct i2c_client *client, u8 type,
+				 u8 *data, size_t len, int offset)
+{
+	u8 pkt_buf[PKT_BUF_SIZE];
+	int error;
+	size_t size;
+
+	/*
+	 * Some vendor commands can read the data structure from controller,
+	 * set the mask to indicate the offset.
+	 */
+	if (offset & W8752_READ_OFFSET_MASK)
+		size = offset & 0xFF;
+	else
+		size = len;
+
+	pkt_buf[CMD_REPORT_ID_OFFSET] = VND_REQ_READ;
+	pkt_buf[CMD_TYPE_OFFSET] = type;
+	put_unaligned_le16(size, &pkt_buf[CMD_SIZE_OFFSET]);
+
+	error = wdt87xx_set_feature(client, pkt_buf, W8752_PKT_HEADER_SZ);
+	if (error)
+		return error;
+
+	pkt_buf[CMD_REPORT_ID_OFFSET] = VND_READ_DATA;
+	pkt_buf[CMD_TYPE_OFFSET] = type;
+	error = wdt87xx_get_feature(client, pkt_buf, PKT_BUF_SIZE);
+	if (error)
+		return error;
+
+	if (pkt_buf[CMD_REPORT_ID_OFFSET] != VND_READ_DATA) {
+		dev_err(&client->dev, "wrong id of fw response: 0x%x\n",
+			pkt_buf[CMD_REPORT_ID_OFFSET]);
+		return -EINVAL;
+	}
+	memcpy(data, &pkt_buf[CMD_DATA1_OFFSET], len);
+
+	return 0;
+}
+
+static int wdt8752_get_device_mode(struct i2c_client *client, u8 *pmode)
+{
+	u8	cmd_buf[PKT_BUF_SIZE];
+	int	error;
+
+	error = wdt8752_exec_read_pkt(client, W8755_FW_GET_DEV_INFO, cmd_buf,
+				      W8752_PKT_SIZE, W8752_READ_OFFSET_MASK |
+				      W8752_DEV_INFO_READ_OFFSET);
+	if (error)
+		return error;
+
+	*pmode = cmd_buf[0];
+	return 0;
+}
+
+static int wdt8752_set_dev_mode(struct i2c_client *client, u8 mode)
+{
+	int count = 20;
+	int error;
+	u8 mode_r;
+
+	do {
+		error = wdt8752_send_command(client, W8752_CMD_DEV_MODE, mode);
+		if (error)
+			return error;
+
+		udelay(W8752_POLLING_PERIOD_US);
+		error = wdt8752_get_device_mode(client, &mode_r);
+		if (error)
+			return error;
+	} while (mode != mode_r && count-- > 0);
+
+	if (mode != mode_r) {
+		dev_err(&client->dev, "failed to change mode: 0x%x, 0x%x\n",
+			mode, mode_r);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+static int wdt8752_exec_write_pkt(struct i2c_client *client, u8 type, u8 *data,
+				  size_t len)
+{
+	u8 pkt_buf[PKT_BUF_SIZE];
+
+	pkt_buf[CMD_REPORT_ID_OFFSET] = VND_REQ_WRITE;
+	pkt_buf[CMD_TYPE_OFFSET] = type;
+	put_unaligned_le16(len, &pkt_buf[CMD_SIZE_OFFSET]);
+
+	memcpy(&pkt_buf[CMD_DATA1_OFFSET], data, len);
+
+	return wdt87xx_set_feature(client, pkt_buf, W8752_PKT_HEADER_SZ + len);
+}
+
+static int wdt8752_delay(struct i2c_client *client, u32 delay)
+{
+	u8 rc = W8752_STATUS_BUSY;
+	u8 raw_buf[PKT_BUF_SIZE];
+	int count;
+	int error;
+
+	count = (delay / WDT_POLLING_PERIOD_MS) + 1;
+
+	do {
+		msleep(WDT_POLLING_PERIOD_MS);
+
+		error = i2c_master_recv(client, raw_buf, 3);
+		if (error < 0) {
+			dev_err(&client->dev, "read raw data failed: (%d)\n",
+				error);
+			return error;
+		}
+
+		rc = raw_buf[2];
+	} while (rc != W8752_STATUS_OK && count-- > 0);
+
+	return 0;
+}
+
+static int wdt8752_checksum_check(struct i2c_client *client, const char *data,
+				  u32 addr, size_t len)
+{
+	u8 pkt_buf[PKT_BUF_SIZE];
+	int time_delay;
+	int error;
+	u16 dev_chksum, fw_chksum;
+
+	put_unaligned_le32(addr, &pkt_buf[0]);
+	put_unaligned_le32(len, &pkt_buf[4]);
+
+	error = wdt8752_exec_write_pkt(client, W8752_SET_CHECKSUM_CALC,
+				       pkt_buf, 8);
+	if (error) {
+		dev_err(&client->dev, "failed to write chksum_calc\n");
+		return error;
+	}
+
+	/*
+	 * It takes about 2ms for every 1K bytes doing the checksum in FW.
+	 * Wait here for the operation to complete.
+	 */
+	time_delay = DIV_ROUND_UP(len, 1024);
+	error = wdt8752_delay(client, time_delay * 4);
+	if (error)
+		return error;
+
+	error = wdt8752_exec_read_pkt(client, W8752_GET_CHECKSUM, pkt_buf,
+				      W8752_PKT_SIZE, 0);
+	if (error) {
+		dev_err(&client->dev, "failed to read chksum\n");
+		return error;
+	}
+
+	dev_chksum = get_unaligned_le16(pkt_buf);
+
+	/* Calculate the checksum in u16 */
+	fw_chksum = wdt87xx_calculate_checksum(data, len, 0);
+	if (dev_chksum == fw_chksum)
+		return 0;
+
+	dev_err(&client->dev, "checksum fail: %d vs %d\n",
+		dev_chksum, fw_chksum);
+	return -EAGAIN;
+}
+
+static int wdt8752_flash_write_sector(struct i2c_client *client, u8 *data,
+				      u32 addr, size_t len)
+{
+	int st_addr;
+	size_t pkt_size;
+	u8 *pdata;
+	int error;
+	u8 pkt_buf[PKT_BUF_SIZE];
+
+	/* Address and length should be 4 bytes aligned */
+	if ((addr & 0x3) != 0 || (len & 0x3) != 0) {
+		dev_err(&client->dev,
+			"addr & len must be 4 bytes aligned %x, %zu\n",
+			addr, len);
+		return -EINVAL;
+	}
+
+	st_addr = addr;
+	pdata = data;
+
+	put_unaligned_le32(addr, &pkt_buf[0]);
+
+	/* initialize the programming address first */
+	error = wdt8752_exec_write_pkt(client, W8752_SET_FLASH_ADDRESS, pkt_buf,
+				       sizeof(u32));
+	if (error) {
+		dev_err(&client->dev, "failed to set flash address: 0x%x\n",
+			addr);
+		return error;
+	}
+
+	while (len) {
+		pkt_size = min_t(size_t, len, W8752_PKT_SIZE);
+
+		error = wdt8752_exec_write_pkt(client, W8752_SET_FLASH, pdata,
+					       pkt_size);
+		if (error) {
+			dev_dbg(&client->dev, "failed to program flash: 0x%x\n",
+				st_addr);
+			return error;
+		}
+
+		len -= pkt_size;
+		pdata += pkt_size;
+		st_addr += pkt_size;
+
+		udelay(W8752_FLASH_WRITE_DELAY_US);
+	}
+
+	return 0;
+}
+
+static int wdt8752_write_data(struct i2c_client *client, const char *data,
+			      u32 addr, size_t len)
+{
+	int error;
+	u8 *pdata = (u8 *)data;
+	u32 write_size;
+
+	if (addr & (W8752_PROG_SECTOR_SIZE - 1)) {
+		dev_err(&client->dev, "start addr must be sector aligned\n");
+		return -EINVAL;
+	}
+
+	while (len) {
+		write_size = min_t(size_t, len, W8752_PROG_SECTOR_SIZE);
+
+		error = wdt8752_flash_write_sector(client, pdata, addr,
+						   write_size);
+
+		if (error)
+			return error;
+
+		pdata += W8752_PROG_SECTOR_SIZE;
+		addr += W8752_PROG_SECTOR_SIZE;
+		len -= write_size;
+	}
+
+	return 0;
+}
+
+static int wdt87xx_delay(struct i2c_client *client, u32 delay)
+{
+	/*
+	 * According to the spec, 4k erase takes the longest time in operations
+	 * and W8756 have to wait it at most 200 ms
+	 */
+	if (delay > W8756_ERASE4K_DELAY_MS)
+		delay = W8756_ERASE4K_DELAY_MS;
+
+	if (delay > WDT_POLLING_PERIOD_MS)
+		msleep(delay);
+	else
+		udelay(delay * 1000);
+
+	return 0;
+}
+
 static int wdt87xx_sw_reset(struct i2c_client *client)
 {
 	int error;
+	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
 
 	dev_dbg(&client->dev, "resetting device now\n");
 
-	error = wdt87xx_send_command(client, VND_CMD_RESET, 0);
+	error = wdt->send_cmd(client, VND_CMD_RESET, 0);
+
 	if (error) {
 		dev_err(&client->dev, "reset failed\n");
 		return error;
 	}
 
 	/* Wait the device to be ready */
-	msleep(WDT_FW_RESET_TIME);
+	msleep(WDT_FW_RESET_TIME_MS);
 
 	return 0;
 }
@@ -426,32 +879,16 @@ static const void *wdt87xx_get_fw_chunk(const struct firmware *fw, u32 id)
 
 		chunk_size = get_unaligned_le32(fw->data +
 						pos + FW_CHUNK_SIZE_OFFSET);
-		pos += chunk_size + 2 * sizeof(u32); /* chunk ID + size */
+		/* chunk ID + size */
+		pos += chunk_size + 2 * sizeof(u32);
 	}
 
 	return NULL;
 }
 
-static int wdt87xx_get_sysparam(struct i2c_client *client,
-				struct wdt87xx_sys_param *param)
+static void wdt87xx_parse_param(struct wdt87xx_data *wdt, u8 *buf, size_t len)
 {
-	u8 buf[PKT_READ_SIZE];
-	int error;
-
-	error = wdt87xx_get_desc(client, WDT_GD_DEVICE, buf, 18);
-	if (error) {
-		dev_err(&client->dev, "failed to get device desc\n");
-		return error;
-	}
-
-	param->vendor_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_VID);
-	param->product_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_PID);
-
-	error = wdt87xx_get_string(client, STRIDX_PARAMETERS, buf, 34);
-	if (error) {
-		dev_err(&client->dev, "failed to get parameters\n");
-		return error;
-	}
+	struct wdt87xx_param *param = &wdt->param;
 
 	param->xmls_id1 = get_unaligned_le16(buf + CTL_PARAM_OFFSET_XMLS_ID1);
 	param->xmls_id2 = get_unaligned_le16(buf + CTL_PARAM_OFFSET_XMLS_ID2);
@@ -460,6 +897,9 @@ static int wdt87xx_get_sysparam(struct i2c_client *client,
 	param->phy_w = get_unaligned_le16(buf + CTL_PARAM_OFFSET_PHY_W) / 10;
 	param->phy_h = get_unaligned_le16(buf + CTL_PARAM_OFFSET_PHY_H) / 10;
 
+	/* Get the report mode */
+	param->i2c_cfg = get_unaligned_le16(buf + CTL_PARAM_OFFSET_I2C_CFG);
+
 	/* Get the scaling factor of pixel to logical coordinate */
 	param->scaling_factor =
 			get_unaligned_le16(buf + CTL_PARAM_OFFSET_FACTOR);
@@ -467,34 +907,61 @@ static int wdt87xx_get_sysparam(struct i2c_client *client,
 	param->max_x = MAX_UNIT_AXIS;
 	param->max_y = DIV_ROUND_CLOSEST(MAX_UNIT_AXIS * param->phy_h,
 					 param->phy_w);
+}
 
-	error = wdt87xx_get_string(client, STRIDX_PLATFORM_ID, buf, 8);
-	if (error) {
-		dev_err(&client->dev, "failed to get platform id\n");
+static int wdt87xx_get_param_hid(struct wdt87xx_data *wdt)
+{
+	u8 buf[PKT_READ_SIZE];
+	int error;
+	struct i2c_client *client = wdt->client;
+	struct wdt87xx_param *param = &wdt->param;
+
+	put_unaligned_le16(W8752_HID_DESC_ADDR, buf);
+
+	error = wdt87xx_i2c_xfer(client, buf, 2, &wdt->hid_desc,
+				 sizeof(wdt->hid_desc));
+	if (error < 0) {
+		dev_err(&client->dev, "failed to get hid desc\n");
 		return error;
 	}
 
-	param->plat_id = buf[1];
+	param->vendor_id = wdt->hid_desc.vendor_id;
+	param->product_id = wdt->hid_desc.product_id;
 
-	buf[0] = 0xf2;
-	error = wdt87xx_get_feature(client, buf, 16);
-	if (error) {
-		dev_err(&client->dev, "failed to get firmware id\n");
+	return 0;
+}
+
+static int wdt87xx_get_param_private(struct wdt87xx_data *wdt)
+{
+	u8 buf[PKT_READ_SIZE];
+	int error, str_len;
+	struct i2c_client *client = wdt->client;
+	struct wdt87xx_param *param = &wdt->param;
+
+	error = wdt87xx_get_desc(client, WDT_GD_DEVICE, buf, 18);
+	if (error < 0) {
+		dev_err(&client->dev, "failed to get device desc\n");
 		return error;
 	}
 
-	if (buf[0] != 0xf2) {
-		dev_err(&client->dev, "wrong id of fw response: 0x%x\n",
-			buf[0]);
-		return -EINVAL;
+	param->vendor_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_VID);
+	param->product_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_PID);
+
+	str_len = wdt87xx_get_string(client, STRIDX_PARAMETERS, buf, 38);
+	if (str_len < 0) {
+		dev_err(&client->dev, "failed to get parameters\n");
+		return str_len;
 	}
 
-	param->fw_id = get_unaligned_le16(&buf[1]);
+	wdt87xx_parse_param(wdt, buf, str_len);
 
-	dev_info(&client->dev,
-		 "fw_id: 0x%x, plat_id: 0x%x, xml_id1: %04x, xml_id2: %04x\n",
-		 param->fw_id, param->plat_id,
-		 param->xmls_id1, param->xmls_id2);
+	error = wdt87xx_get_string(client, STRIDX_PLATFORM_ID, buf, 8);
+	if (error < 0) {
+		dev_err(&client->dev, "failed to get platform id\n");
+		return error;
+	}
+
+	param->plat_id = buf[1];
 
 	return 0;
 }
@@ -548,8 +1015,15 @@ static int wdt87xx_validate_firmware(struct wdt87xx_data *wdt,
 	return 0;
 }
 
-static int wdt87xx_validate_fw_chunk(const void *data, int id)
+static int wdt87xx_validate_fw_chunk(struct i2c_client *client,
+				     const void *data, int id)
 {
+	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
+
+	/* There is no fw_id tag could be checked in 8752 */
+	if (wdt->plt_id == PLT_WDT8752)
+		return 0;
+
 	if (id == CHUNK_ID_FRWR) {
 		u32 fw_id;
 
@@ -562,37 +1036,37 @@ static int wdt87xx_validate_fw_chunk(const void *data, int id)
 }
 
 static int wdt87xx_write_data(struct i2c_client *client, const char *data,
-			      u32 address, int length)
+			      u32 addr, size_t len)
 {
-	u16 packet_size;
+	size_t pkt_size;
 	int count = 0;
 	int error;
 	u8 pkt_buf[PKT_BUF_SIZE];
 
 	/* Address and length should be 4 bytes aligned */
-	if ((address & 0x3) != 0 || (length & 0x3) != 0) {
+	if ((addr & 0x3) != 0 || (len & 0x3) != 0) {
 		dev_err(&client->dev,
-			"addr & len must be 4 bytes aligned %x, %x\n",
-			address, length);
+			"addr & len must be 4 bytes aligned %x, %zu\n",
+			addr, len);
 		return -EINVAL;
 	}
 
-	while (length) {
-		packet_size = min(length, PACKET_SIZE);
+	while (len) {
+		pkt_size = min_t(size_t, len, PACKET_SIZE);
 
 		pkt_buf[CMD_REPORT_ID_OFFSET] = VND_REQ_WRITE;
 		pkt_buf[CMD_TYPE_OFFSET] = VND_SET_DATA;
-		put_unaligned_le16(packet_size, &pkt_buf[CMD_INDEX_OFFSET]);
-		put_unaligned_le32(address, &pkt_buf[CMD_LENGTH_OFFSET]);
-		memcpy(&pkt_buf[CMD_DATA_OFFSET], data, packet_size);
+		put_unaligned_le16(pkt_size, &pkt_buf[CMD_INDEX_OFFSET]);
+		put_unaligned_le32(addr, &pkt_buf[CMD_LENGTH_OFFSET]);
+		memcpy(&pkt_buf[CMD_DATA_OFFSET], data, pkt_size);
 
 		error = wdt87xx_set_feature(client, pkt_buf, sizeof(pkt_buf));
 		if (error)
 			return error;
 
-		length -= packet_size;
-		data += packet_size;
-		address += packet_size;
+		len -= pkt_size;
+		data += pkt_size;
+		addr += pkt_size;
 
 		/* Wait for the controller to finish the write */
 		mdelay(WDT_FLASH_WRITE_DELAY_MS);
@@ -606,61 +1080,30 @@ static int wdt87xx_write_data(struct i2c_client *client, const char *data,
 	return 0;
 }
 
-static u16 misr(u16 cur_value, u8 new_value)
-{
-	u32 a, b;
-	u32 bit0;
-	u32 y;
+static int wdt87xx_checksum_check(struct i2c_client *client, const char *data,
+				  u32 addr, size_t len)
 
-	a = cur_value;
-	b = new_value;
-	bit0 = a ^ (b & 1);
-	bit0 ^= a >> 1;
-	bit0 ^= a >> 2;
-	bit0 ^= a >> 4;
-	bit0 ^= a >> 5;
-	bit0 ^= a >> 7;
-	bit0 ^= a >> 11;
-	bit0 ^= a >> 15;
-	y = (a << 1) ^ b;
-	y = (y & ~1) | (bit0 & 1);
-
-	return (u16)y;
-}
-
-static u16 wdt87xx_calculate_checksum(const u8 *data, size_t length)
-{
-	u16 checksum = 0;
-	size_t i;
-
-	for (i = 0; i < length; i++)
-		checksum = misr(checksum, data[i]);
-
-	return checksum;
-}
-
-static int wdt87xx_get_checksum(struct i2c_client *client, u16 *checksum,
-				u32 address, int length)
 {
 	int error;
 	int time_delay;
 	u8 pkt_buf[PKT_BUF_SIZE];
 	u8 cmd_buf[CMD_BUF_SIZE];
+	u16 dev_chksum, fw_chksum;
 
-	error = wdt87xx_send_command(client, VND_SET_CHECKSUM_LENGTH, length);
+	error = wdt87xx_send_command(client, VND_SET_CHECKSUM_LENGTH, len);
 	if (error) {
 		dev_err(&client->dev, "failed to set checksum length\n");
 		return error;
 	}
 
-	error = wdt87xx_send_command(client, VND_SET_CHECKSUM_CALC, address);
+	error = wdt87xx_send_command(client, VND_SET_CHECKSUM_CALC, addr);
 	if (error) {
 		dev_err(&client->dev, "failed to set checksum address\n");
 		return error;
 	}
 
 	/* Wait the operation to complete */
-	time_delay = DIV_ROUND_UP(length, 1024);
+	time_delay = DIV_ROUND_UP(len, 1024);
 	msleep(time_delay * 30);
 
 	memset(cmd_buf, 0, sizeof(cmd_buf));
@@ -680,82 +1123,81 @@ static int wdt87xx_get_checksum(struct i2c_client *client, u16 *checksum,
 		return error;
 	}
 
-	*checksum = get_unaligned_le16(&pkt_buf[CMD_DATA_OFFSET]);
-	return 0;
+	dev_chksum = get_unaligned_le16(&pkt_buf[CMD_DATA_OFFSET]);
+
+	/* Calculate the checksum in bytes */
+	fw_chksum = wdt87xx_calculate_checksum(data, len, 1);
+	if (dev_chksum == fw_chksum)
+		return 0;
+
+	dev_err(&client->dev,
+		"checksum fail: %d vs %d\n", dev_chksum, fw_chksum);
+	return -EAGAIN;
 }
 
 static int wdt87xx_write_firmware(struct i2c_client *client, const void *chunk)
 {
-	u32 start_addr = get_unaligned_le32(chunk + FW_CHUNK_TGT_START_OFFSET);
-	u32 size = get_unaligned_le32(chunk + FW_CHUNK_PAYLOAD_LEN_OFFSET);
+	u32 st_addr = get_unaligned_le32(chunk + FW_CHUNK_TGT_START_OFFSET);
+	size_t len = get_unaligned_le32(chunk + FW_CHUNK_PAYLOAD_LEN_OFFSET);
 	const void *data = chunk + FW_CHUNK_PAYLOAD_OFFSET;
 	int error;
 	int err1;
-	int page_size;
+	int pg_size;
 	int retry = 0;
-	u16 device_checksum, firmware_checksum;
+	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
 
 	dev_dbg(&client->dev, "start 4k page program\n");
 
-	error = wdt87xx_send_command(client, VND_CMD_STOP, MODE_STOP);
+	error = wdt->send_cmd(client, VND_CMD_STOP, MODE_STOP);
 	if (error) {
-		dev_err(&client->dev, "stop report mode failed\n");
+		dev_err(&client->dev, "failed to stop report\n");
 		return error;
 	}
 
-	error = wdt87xx_send_command(client, VND_CMD_SFUNL, 0);
+	error = wdt->send_cmd(client, VND_CMD_SFUNL, 0);
 	if (error) {
-		dev_err(&client->dev, "unlock failed\n");
+		dev_err(&client->dev, "failed to unlock flash\n");
 		goto out_enable_reporting;
 	}
 
-	mdelay(10);
+	msleep(20);
 
-	while (size) {
-		dev_dbg(&client->dev, "%s: %x, %x\n", __func__,
-			start_addr, size);
+	while (len) {
+		dev_dbg(&client->dev, "%s: %x, %zu\n", __func__, st_addr, len);
 
-		page_size = min_t(u32, size, PG_SIZE);
-		size -= page_size;
+		pg_size = min_t(size_t, len, PG_SIZE);
 
 		for (retry = 0; retry < MAX_RETRIES; retry++) {
-			error = wdt87xx_send_command(client, VND_CMD_ERASE,
-						     start_addr);
+			error = wdt->send_cmd(client, VND_CMD_ERASE, st_addr);
 			if (error) {
 				dev_err(&client->dev,
-					"erase failed at %#08x\n", start_addr);
+					"erase failed at %#08x\n", st_addr);
 				break;
 			}
 
-			msleep(WDT_FLASH_ERASE_DELAY_MS);
-
-			error = wdt87xx_write_data(client, data, start_addr,
-						   page_size);
+			error = wdt->delay(client, W8752_ERASE4K_DELAY_MS);
 			if (error) {
 				dev_err(&client->dev,
-					"write failed at %#08x (%d bytes)\n",
-					start_addr, page_size);
+					"delay failed at %#08x\n", st_addr);
 				break;
 			}
 
-			error = wdt87xx_get_checksum(client, &device_checksum,
-						     start_addr, page_size);
+			error = wdt->write_flash(client, data, st_addr,
+						 pg_size);
 			if (error) {
 				dev_err(&client->dev,
-					"failed to retrieve checksum for %#08x (len: %d)\n",
-					start_addr, page_size);
+					"write failed at %#08x (%d bytes)\n",
+					st_addr, pg_size);
 				break;
 			}
 
-			firmware_checksum =
-				wdt87xx_calculate_checksum(data, page_size);
-
-			if (device_checksum == firmware_checksum)
+			error = wdt->chksum_check(client, data, st_addr,
+						  pg_size);
+			if (error != -EAGAIN)
 				break;
 
-			dev_err(&client->dev,
-				"checksum fail: %d vs %d, retry %d\n",
-				device_checksum, firmware_checksum, retry);
+			dev_err(&client->dev, "checksum retry (%d) at 0x%x\n",
+				retry, st_addr);
 		}
 
 		if (retry == MAX_RETRIES) {
@@ -763,22 +1205,22 @@ static int wdt87xx_write_firmware(struct i2c_client *client, const void *chunk)
 			error = -EIO;
 			goto out_lock_device;
 		}
-
-		start_addr = start_addr + page_size;
-		data = data + page_size;
+		len -= pg_size;
+		st_addr += pg_size;
+		data += pg_size;
 	}
 
 out_lock_device:
-	err1 = wdt87xx_send_command(client, VND_CMD_SFLCK, 0);
+	err1 = wdt->send_cmd(client, VND_CMD_SFLCK, 0);
 	if (err1)
-		dev_err(&client->dev, "lock failed\n");
+		dev_err(&client->dev, "failed to lock flash\n");
 
-	mdelay(10);
+	msleep(20);
 
 out_enable_reporting:
-	err1 = wdt87xx_send_command(client, VND_CMD_START, 0);
+	err1 = wdt->send_cmd(client, VND_CMD_START, 0);
 	if (err1)
-		dev_err(&client->dev, "start to report failed\n");
+		dev_err(&client->dev, "failed to restart to report\n");
 
 	return error ? error : err1;
 }
@@ -796,7 +1238,7 @@ static int wdt87xx_load_chunk(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	error = wdt87xx_validate_fw_chunk(chunk, ck_id);
+	error = wdt87xx_validate_fw_chunk(client, chunk, ck_id);
 	if (error) {
 		dev_err(&client->dev, "invalid chunk (type %d): %d\n",
 			ck_id, error);
@@ -814,6 +1256,70 @@ static int wdt87xx_load_chunk(struct i2c_client *client,
 	return 0;
 }
 
+static int wdt87xx_get_param(struct wdt87xx_data *wdt)
+{
+	u8 buf[PKT_READ_SIZE];
+	int error;
+	struct i2c_client *client = wdt->client;
+	struct wdt87xx_param *param = &wdt->param;
+	u16 param_key;
+
+	buf[CMD_REPORT_ID_OFFSET] = VND_REQ_CTRLER_INFO;
+	error = wdt87xx_get_feature(client, buf, PACKET_SIZE);
+	if (error)
+		dev_err(&client->dev, "failed to get i2c cfg\n");
+
+	param_key = get_unaligned_le16(buf + W8752_PARAM_KEY_OFFSET);
+	if (buf[CMD_REPORT_ID_OFFSET] == VND_REQ_CTRLER_INFO &&
+	    param_key == W8752_PARAM_KEY) {
+		param->plat_id = buf[W8752_PLAT_ID_OFFSET];
+		wdt87xx_parse_param(wdt, buf + W8752_PARAM_OFFSET,
+				    get_unaligned_le16(buf +
+						       W8752_PARAM_LEN_OFFSET));
+		wdt->plt_id = PLT_WDT8752;
+		wdt->send_cmd = wdt8752_send_command;
+		wdt->write_flash = wdt8752_write_data;
+		wdt->delay = wdt8752_delay;
+		wdt->chksum_check = wdt8752_checksum_check;
+		error = wdt87xx_get_param_hid(wdt);
+	} else {
+		wdt->send_cmd = wdt87xx_send_command;
+		wdt->write_flash = wdt87xx_write_data;
+		wdt->delay = wdt87xx_delay;
+		wdt->chksum_check = wdt87xx_checksum_check;
+		error = wdt87xx_get_param_private(wdt);
+	}
+
+	if (error < 0)
+		return error;
+
+	dev_info(&client->dev, "pid: %04x, vid: %04x, w: %d, h: %d, i_sz: %d\n",
+		 param->vendor_id, param->product_id, param->phy_w,
+		 param->phy_h, wdt->hid_desc.max_input_length);
+
+	buf[CMD_REPORT_ID_OFFSET] = VND_REQ_FW_INFO;
+	error = wdt87xx_get_feature(client, buf, 16);
+	if (error) {
+		dev_err(&client->dev, "failed to get firmware id\n");
+		return error;
+	}
+
+	if (buf[CMD_REPORT_ID_OFFSET] != VND_REQ_FW_INFO) {
+		dev_err(&client->dev, "wrong id of fw response: 0x%x\n",
+			buf[CMD_REPORT_ID_OFFSET]);
+		return -EINVAL;
+	}
+
+	param->fw_id = get_unaligned_le16(&buf[1]);
+
+	dev_info(&client->dev,
+		 "fw_id: 0x%x, i2c_cfg: 0x%x, xml_id1: %04x, xml_id2: %04x\n",
+		 param->fw_id, param->i2c_cfg,
+		 param->xmls_id1, param->xmls_id2);
+
+	return 0;
+}
+
 static int wdt87xx_do_update_firmware(struct i2c_client *client,
 				      const struct firmware *fw,
 				      unsigned int chunk_id)
@@ -846,10 +1352,10 @@ static int wdt87xx_do_update_firmware(struct i2c_client *client,
 	}
 
 	/* Refresh the parameters */
-	error = wdt87xx_get_sysparam(client, &wdt->param);
+	error = wdt87xx_get_param(wdt);
 	if (error)
 		dev_err(&client->dev,
-			"failed to refresh system parameters: %d\n", error);
+			"failed to refresh parameters: %d\n", error);
 out:
 	enable_irq(client->irq);
 	mutex_unlock(&wdt->fw_mutex);
@@ -857,8 +1363,8 @@ out:
 	return error ? error : 0;
 }
 
-static int wdt87xx_update_firmware(struct device *dev,
-				   const char *fw_name, unsigned int chunk_id)
+static int wdt87xx_update_firmware(struct device *dev, const char *fw_name,
+				   unsigned int chunk_id)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	const struct firmware *fw;
@@ -950,30 +1456,29 @@ static const struct attribute_group wdt87xx_attr_group = {
 	.attrs = wdt87xx_attrs,
 };
 
-static void wdt87xx_report_contact(struct input_dev *input,
-				   struct wdt87xx_sys_param *param,
-				   u8 *buf)
+static void wdt87xx_report_contact(struct wdt87xx_data *wdt,
+				   struct wdt87xx_param *param, u8 *buf)
 {
+	struct input_dev *input = wdt->input;
 	int finger_id;
 	u32 x, y, w;
 	u8 p;
 
-	finger_id = (buf[FINGER_EV_V1_OFFSET_ID] >> 3) - 1;
+	finger_id = (buf[FINGER_EV_OFFSET_ID] >> 3) - 1;
 	if (finger_id < 0)
 		return;
 
-	/* Check if this is an active contact */
-	if (!(buf[FINGER_EV_V1_OFFSET_ID] & 0x1))
+	if (!(buf[FINGER_EV_OFFSET_ID] & 0x1))
 		return;
 
-	w = buf[FINGER_EV_V1_OFFSET_W];
+	w = buf[FINGER_EV_OFFSET_W];
 	w *= param->scaling_factor;
 
-	p = buf[FINGER_EV_V1_OFFSET_P];
+	p = buf[FINGER_EV_OFFSET_P];
 
-	x = get_unaligned_le16(buf + FINGER_EV_V1_OFFSET_X);
+	x = get_unaligned_le16(buf + FINGER_EV_OFFSET_X);
 
-	y = get_unaligned_le16(buf + FINGER_EV_V1_OFFSET_Y);
+	y = get_unaligned_le16(buf + FINGER_EV_OFFSET_Y);
 	y = DIV_ROUND_CLOSEST(y * param->phy_h, param->phy_w);
 
 	/* Refuse incorrect coordinates */
@@ -997,23 +1502,30 @@ static irqreturn_t wdt87xx_ts_interrupt(int irq, void *dev_id)
 	struct i2c_client *client = wdt->client;
 	int i, fingers;
 	int error;
-	u8 raw_buf[WDT_V1_RAW_BUF_COUNT] = {0};
+	int offset = 0;
+	u8 raw_buf[WDT_RAW_BUF_COUNT] = {0};
+
+	if (wdt->hid_desc.max_input_length) {
+		offset = 2;
+		error = i2c_master_recv(client, raw_buf,
+					wdt->hid_desc.max_input_length);
+	} else {
+		error = i2c_master_recv(client, raw_buf, WDT_RAW_BUF_COUNT);
+	}
 
-	error = i2c_master_recv(client, raw_buf, WDT_V1_RAW_BUF_COUNT);
 	if (error < 0) {
-		dev_err(&client->dev, "read v1 raw data failed: %d\n", error);
+		dev_err(&client->dev, "read raw data failed: %d\n", error);
 		goto irq_exit;
 	}
 
-	fingers = raw_buf[TOUCH_PK_V1_OFFSET_FNGR_NUM];
+	fingers = raw_buf[offset + TOUCH_PK_OFFSET_FNGR_NUM];
 	if (!fingers)
 		goto irq_exit;
 
 	for (i = 0; i < WDT_MAX_FINGER; i++)
-		wdt87xx_report_contact(wdt->input,
-				       &wdt->param,
-				       &raw_buf[TOUCH_PK_V1_OFFSET_EVENT +
-						i * FINGER_EV_V1_SIZE]);
+		wdt87xx_report_contact(wdt, &wdt->param,
+				       &raw_buf[offset + TOUCH_PK_OFFSET_EVENT +
+				       i * FINGER_EV_SIZE]);
 
 	input_mt_sync_frame(wdt->input);
 	input_sync(wdt->input);
@@ -1030,6 +1542,7 @@ static int wdt87xx_ts_create_input_device(struct wdt87xx_data *wdt)
 	int error;
 
 	input = devm_input_allocate_device(dev);
+
 	if (!input) {
 		dev_err(dev, "failed to allocate input device\n");
 		return -ENOMEM;
@@ -1089,7 +1602,7 @@ static int wdt87xx_ts_probe(struct i2c_client *client,
 	snprintf(wdt->phys, sizeof(wdt->phys), "i2c-%u-%04x/input0",
 		 client->adapter->nr, client->addr);
 
-	error = wdt87xx_get_sysparam(client, &wdt->param);
+	error = wdt87xx_get_param(wdt);
 	if (error)
 		return error;
 
@@ -1106,6 +1619,12 @@ static int wdt87xx_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	error = device_init_wakeup(&client->dev, true);
+	if (error) {
+		dev_err(&client->dev, "inii wakeup failed: %d\n", error);
+		return error;
+	}
+
 	error = sysfs_create_group(&client->dev.kobj, &wdt87xx_attr_group);
 	if (error) {
 		dev_err(&client->dev, "create sysfs failed: %d\n", error);
@@ -1125,16 +1644,22 @@ static int wdt87xx_ts_remove(struct i2c_client *client)
 static int __maybe_unused wdt87xx_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
 	int error;
+	int mode = MODE_IDLE;
 
 	disable_irq(client->irq);
 
-	error = wdt87xx_send_command(client, VND_CMD_STOP, MODE_IDLE);
+	if (device_may_wakeup(dev))
+		wdt->wake_irq_enabled = (enable_irq_wake(client->irq) == 0);
+	else if (wdt->plt_id == PLT_WDT8752)
+		mode = MODE_SLEEP;
+
+	error = wdt->send_cmd(client, VND_CMD_STOP, mode);
 	if (error) {
 		enable_irq(client->irq);
 		dev_err(&client->dev,
-			"failed to stop device when suspending: %d\n",
-			error);
+			"failed to stop device when suspending: %d\n", error);
 		return error;
 	}
 
@@ -1144,19 +1669,28 @@ static int __maybe_unused wdt87xx_suspend(struct device *dev)
 static int __maybe_unused wdt87xx_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
+	u8 raw_buf[3] = {0};
 	int error;
 
+	if (device_may_wakeup(dev)) {
+		if (wdt->wake_irq_enabled)
+			disable_irq_wake(client->irq);
+	} else {
+		/* WDT8752 should wakeup device by read operation first */
+		if (wdt->plt_id == PLT_WDT8752)
+			i2c_master_recv(client, raw_buf, 3);
+	}
 	/*
 	 * The chip may have been reset while system is resuming,
 	 * give it some time to settle.
 	 */
 	mdelay(100);
 
-	error = wdt87xx_send_command(client, VND_CMD_START, 0);
+	error = wdt->send_cmd(client, VND_CMD_START, 0);
 	if (error)
 		dev_err(&client->dev,
-			"failed to start device when resuming: %d\n",
-			error);
+			"failed to start device when resuming: %d\n", error);
 
 	enable_irq(client->irq);
 
@@ -1169,6 +1703,7 @@ static const struct i2c_device_id wdt87xx_dev_id[] = {
 	{ WDT87XX_NAME, 0 },
 	{ }
 };
+
 MODULE_DEVICE_TABLE(i2c, wdt87xx_dev_id);
 
 static const struct acpi_device_id wdt87xx_acpi_id[] = {
-- 
1.9.1

