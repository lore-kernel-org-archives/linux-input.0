From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Thu, 12 May 2016 21:18:52 -0700
Message-ID: <20160513041852.GA8932@dtor-ws>
References: <1461923113-426-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461923113-426-1-git-send-email-jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "jeffrey.lin" <yajohn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, roger.yang-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, KP.li-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, albert.shieh-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jeffrey,
On Fri, Apr 29, 2016 at 05:45:13PM +0800, jeffrey.lin wrote:
> Raydium I2C touch driver.
> 
> Signed-off-by: jeffrey.lin <jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>

I was looking at the driver and there were a few issues (buffer
overflows, forgetting releasing firmware, general flow, etc), that I
tried correcting in the attached patch. Please try incorporating it into
yours (it should apply to this version of Raydium driver) and let me
know if it still works. There are a few questionable points that I
marked with "XXX FIXME" in the code, please respond to them by either
confirming that they are correct or fixing them.

Thanks.

-- 
Dmitry


Input: raydium misc changes

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/raydium_i2c_ts.c |  941 ++++++++++++++--------------
 1 file changed, 482 insertions(+), 459 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index cee46e8..1e4e3de 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -20,107 +20,105 @@
  * Contact Raydium Semiconductor Corporation at www.rad-ic.com
  */
 
-#include <linux/module.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
+#include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/input/mt.h>
-#include <linux/acpi.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <asm/unaligned.h>
-#include <linux/gpio/consumer.h>
 
-/* Device, Driver information */
-#define DEVICE_NAME	"raydium_i2c"
-
-/* Slave I2C mode*/
-#define RM_BOOT_BLDR	0x02
-#define RM_BOOT_MAIN	0x03
-
-/*I2C bl command */
-#define CMD_BOOT_PAGE_WRT	0x0B		/*send bl page write*/
-#define CMD_BOOT_WRT		0x11		/*send bl write*/
-#define CMD_BOOT_ACK		0x22		/*send ack*/
-#define CMD_BOOT_CHK		0x33		/*send data check*/
-#define CMD_BOOT_READ		0x44		/*send wait bl data ready*/
-#define BOOT_RDY		0xFF		/*bl data ready*/
-/*I2C main command*/
-#define CMD_QUERY_BANK		0x2B
-#define CMD_DATA_BANK		0x4D
-#define CMD_ENTER_SLEEP		0x4E
-#define CMD_BANK_SWITCH		0xAA
+/* Slave I2C mode */
+#define RM_BOOT_BLDR		0x02
+#define RM_BOOT_MAIN		0x03
 
-/* Touch relative info */
-#define MAX_RETRIES		3
-#define MAX_TOUCH_NUM		10
-#define MAX_PkG_SIZE		50
-#define BOOT_DELAY_MS	100
+/* I2C bootoloader commands */
+#define RM_CMD_BOOT_PAGE_WRT	0x0B		/* send bl page write */
+#define RM_CMD_BOOT_WRT		0x11		/* send bl write */
+#define RM_CMD_BOOT_ACK		0x22		/* send ack*/
+#define RM_CMD_BOOT_CHK		0x33		/* send data check */
+#define RM_CMD_BOOT_READ	0x44		/* send wait bl data ready*/
 
-/*Bootloader relative info */
-#define CMD_BOOT_HEADER_LEN		3	/*bl flash wrt cmd size*/
-#define RAYDIUM_TRANS_BUFSIZE	32	/*bl wrt pkg size*/
-#define MAX_BOOT_WRT_LEN	(RAYDIUM_TRANS_BUFSIZE + CMD_BOOT_HEADER_LEN)
-#define MAX_FW_UPDATE_RETRIES	30
+#define RM_BOOT_RDY		0xFF		/* bl data ready */
+
+/* I2C main commands */
+#define RM_CMD_QUERY_BANK	0x2B
+#define RM_CMD_DATA_BANK	0x4D
+#define RM_CMD_ENTER_SLEEP	0x4E
+#define RM_CMD_BANK_SWITCH	0xAA
+
+#define RM_RESET_MSG_ADDR	0x40000004
+#define RM_FASTBOOT_MSG_ADDR	0x50000620
+
+#define RM_MAX_READ_SIZE	63
+
+/* Touch relative info */
+#define RM_MAX_RETRIES		3
+#define RM_MAX_TOUCH_NUM	10
+#define RM_BOOT_DELAY_MS	100
+
+/* Offsets in contact data */
+#define RM_CONTACT_STATE_POS	0
+#define RM_CONTACT_X_POS	1
+#define RM_CONTACT_Y_POS	3
+#define RM_CONTACT_PRESSURE_POS	5 // XXX - check - original was 4
+#define RM_CONTACT_WIDTH_X_POS	6
+#define RM_CONTACT_WIDTH_Y_POS	7
+
+/* Bootloader relative info */
+#define RM_BL_WRT_CMD_SIZE	3	/* bl flash wrt cmd size */
+#define RM_BL_WRT_PKG_SIZE	32	/* bl wrt pkg size */
+#define RM_BL_WRT_LEN		(RM_BL_WRT_PKG_SIZE + RM_BL_WRT_CMD_SIZE)
+#define RM_FW_PAGE_SIZE		128
+#define RM_MAX_FW_RETRIES	30
+
+#define RM_POWERON_DELAY_USEC	500
+#define RM_RESET_DELAY_MSEC	50
 
 enum raydium_bl_cmd {
-	HEADER = 0,
-	PAGE_STR,
-	PKG_IDX,
-	DATA_STR,
+	BL_HEADER = 0,
+	BL_PAGE_STR,
+	BL_PKG_IDX,
+	BL_DATA_STR,
 };
 
 enum raydium_bl_ack {
-	ACK_NULL = 0,
-	WAIT_READY,
-	PATH_READY,
+	RAYDIUM_ACK_NULL = 0,
+	RAYDIUM_WAIT_READY,
+	RAYDIUM_PATH_READY,
 };
 
-#define RAYDIUM_PAGE_SIZE		128
-#define RAYDIUM_POWERON_DELAY_USEC	500
-#define RAYDIUM_RESET_DELAY_MSEC	50
-
-#define ADDR_INDEX		0x03
-#define DATA_INDEX		0x04
-
-#define HEADER_SIZE		4
-
 enum raydium_boot_mode {
 	RAYDIUM_TS_MAIN = 0,
 	RAYDIUM_TS_BLDR,
 };
 
-enum raydium_abs_idx {
-	POS_STATE = 0,/*1:touch, 0:no touch*/
-	POS_X,
-	POS_Y = 3,
-	POS_PRESSURE,
-	WIDTH_X,
-	WIDTH_Y,
+/* Response to RM_CMD_DATA_BANK request */
+struct raydium_data_info {
+	__le32 data_bank_addr;
+	u8 pkg_size;
+	u8 tp_info_size;
 };
 
 struct raydium_info {
-	u32 hw_ver;	/*device ver, __le32*/
+	__le32 hw_ver;		/*device version */
 	u8 main_ver;
 	u8 sub_ver;
-	u16 ft_ver;	/*test ver, __le16*/
+	__le16 ft_ver;		/* test version */
 	u8 x_num;
 	u8 y_num;
-	u16 x_max;	/*disp reso, __le16*/
-	u16 y_max;	/*disp reso, __le16*/
+	__le16 x_max;
+	__le16 y_max;
 	u8 x_res;		/* units/mm */
 	u8 y_res;		/* units/mm */
 };
 
-struct raydium_object {
-	u32 data_bank_addr;
-	u8 pkg_size;
-	u8 tp_info_size;
-};
-
 /* struct raydium_data - represents state of Raydium touchscreen device */
 struct raydium_data {
 	struct i2c_client *client;
@@ -130,136 +128,132 @@ struct raydium_data {
 	struct regulator *vccio;
 	struct gpio_desc *reset_gpio;
 
-	u32 query_bank_info;
-
 	struct raydium_info info;
-	struct raydium_object obj;
-	enum raydium_boot_mode boot_mode;
 
 	struct mutex sysfs_mutex;
-	struct completion cmd_done;
+
+	u8 *report_data;
+
+	u32 data_bank_addr;
+	u8 report_size;
+	u8 contact_size;
+
+	enum raydium_boot_mode boot_mode;
 
 	bool wake_irq_enabled;
 };
 
 static int raydium_i2c_send(struct i2c_client *client,
-	u8 addr, u8 *data, size_t len)
+			    u8 addr, const void *data, size_t len)
 {
-	u8 buf[MAX_PkG_SIZE + 1];
+	u8 *buf;
 	int tries = 0;
+	int ret;
+
+	buf = kmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	buf[0] = addr;
-	memcpy(&buf[1], data, len);
+	memcpy(buf + 1, data, len);
 
 	do {
-		if (i2c_master_send(client, buf, len + 1) == (len + 1))
-			return 0;
+		ret = i2c_master_send(client, buf, len + 1);
+		if (likely(ret == len + 1))
+			break;
+
 		msleep(20);
-	} while (++tries < MAX_RETRIES);
+	} while (++tries < RM_MAX_RETRIES);
 
-	dev_err(&client->dev, "%s: i2c send failed\n", __func__);
+	kfree(buf);
 
-	return -EIO;
+	if (unlikely(ret != len + 1)) {
+		if (ret >= 0)
+			ret = -EIO;
+		dev_err(&client->dev, "%s failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int raydium_i2c_read(struct i2c_client *client,
-	u8 addr, size_t len, void *data)
+			    u8 addr, void *data, size_t len)
 {
-	struct i2c_msg xfer[2];
+	struct i2c_msg xfer[] = {
+		{
+			.addr = client->addr,
+			.len = 1,
+			.buf = &addr,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = data,
+		}
+	};
 	int ret;
 
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &addr;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = len;
-	xfer[1].buf = data;
-
 	ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
-	if (ret < 0)
-		return ret;
-
-	if (ret != ARRAY_SIZE(xfer))
-		return -EIO;
+	if (unlikely(ret != ARRAY_SIZE(xfer)))
+		return ret < 0 ? ret : -EIO;
 
 	return 0;
 }
 
 static int raydium_i2c_read_message(struct i2c_client *client,
-	u32 addr, size_t len, void *data)
+				    u32 addr, void *data, size_t len)
 {
-	u8 buf[HEADER_SIZE];
-	u8 read_cnt, idx_i;
+	__be32 be_addr = cpu_to_be32(addr);
+	size_t xfer_len;
 	int error;
-	size_t pkg_size;
-
-	if (len % MAX_PkG_SIZE)
-		read_cnt = len / MAX_PkG_SIZE + 1;
-	else
-		read_cnt = len / MAX_PkG_SIZE;
-
-	idx_i = 0;
-	for (idx_i = 0; idx_i < read_cnt; idx_i++) {
-		pkg_size = (len > MAX_PkG_SIZE) ? MAX_PkG_SIZE : len;
 
-		len -= MAX_PkG_SIZE;
+	while (len) {
+		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
 
-		put_unaligned_be32(addr, buf);
-
-		/*set data bank*/
-		error = raydium_i2c_send(client, CMD_BANK_SWITCH,
-			(u8 *)buf, HEADER_SIZE);
-		/*read potints data*/
+		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
+					 &be_addr, sizeof(be_addr));
 		if (!error)
-			error = raydium_i2c_read(client, buf[ADDR_INDEX],
-				pkg_size,
-				data + idx_i*MAX_PkG_SIZE);
+			error = raydium_i2c_read(client, addr & 0xff,
+						 data, xfer_len);
+		if (error)
+			return error;
 
-		addr += MAX_PkG_SIZE;
-		idx_i++;
+		len -= xfer_len;
+		data += xfer_len;
 	}
 
-	return error;
+	return 0;
 }
 
 static int raydium_i2c_send_message(struct i2c_client *client,
-	size_t len, void *data)
+				    u32 addr, const void *data, size_t len)
 {
+	__be32 be_addr = cpu_to_be32(addr);
 	int error;
-	__le32 cmd;
-
-	cmd = get_unaligned_le32(data);
 
-	/*set data bank*/
-	error = raydium_i2c_send(client, CMD_BANK_SWITCH, (u8 *)&cmd,
-		HEADER_SIZE);
-
-	/*send message*/
+	error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
+				 &be_addr, sizeof(be_addr));
 	if (!error)
-		error = raydium_i2c_send(client, ((u8 *)data)[ADDR_INDEX],
-			data + DATA_INDEX, len);
+		error = raydium_i2c_send(client, addr & 0xff, data, len);
 
 	return error;
 }
 
 static int raydium_i2c_sw_reset(struct i2c_client *client)
 {
-	static const u8 soft_rst_cmd[] = {0x40, 0x00, 0x00, 0x04, 0x01};
+	const u8 soft_rst_cmd = 0x01;
 	int error;
 
-	error = raydium_i2c_send_message(client, ARRAY_SIZE(soft_rst_cmd),
-		(void *)soft_rst_cmd);
+	error = raydium_i2c_send_message(client, RM_RESET_MSG_ADDR,
+					 &soft_rst_cmd, sizeof(soft_rst_cmd));
 	if (error) {
 		dev_err(&client->dev, "software reset failed: %d\n", error);
 		return error;
 	}
 
-	msleep(RAYDIUM_RESET_DELAY_MSEC);
+	msleep(RM_RESET_DELAY_MSEC);
 
 	return 0;
 }
@@ -267,75 +261,78 @@ static int raydium_i2c_sw_reset(struct i2c_client *client)
 static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
+	struct raydium_data_info data_info;
+	__le32 query_bank_addr;
+
 	int error, retry_cnt;
 
-	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
-		error = raydium_i2c_read(client, CMD_DATA_BANK,
-			sizeof(ts->obj), (void *)&ts->obj);
-			ts->obj.data_bank_addr =
-				get_unaligned_le32(&ts->obj.data_bank_addr);
+	for (retry_cnt = 0; retry_cnt < RM_MAX_RETRIES; retry_cnt++) {
+		error = raydium_i2c_read(client, RM_CMD_DATA_BANK,
+					 &data_info, sizeof(data_info));
+		if (error)
+			continue;
 
-		if (!error) {
-			error = raydium_i2c_read(client, CMD_QUERY_BANK,
-				sizeof(ts->query_bank_info),
-				(void *)&ts->query_bank_info);
-			if (!error) {
-				error = raydium_i2c_read_message(client,
-					ts->query_bank_info, sizeof(ts->info),
-					(void *)&ts->info);
-
-				ts->info.hw_ver =
-					get_unaligned_le32(&ts->info.hw_ver);
-				ts->info.ft_ver =
-					get_unaligned_le16(&ts->info.ft_ver);
-				ts->info.x_max =
-					get_unaligned_le16(&ts->info.x_max);
-				ts->info.y_max =
-					get_unaligned_le16(&ts->info.y_max);
-				return 0;
-			}
-		}
+		ts->data_bank_addr = le32_to_cpu(data_info.data_bank_addr);
+		ts->report_size = data_info.pkg_size;
+		ts->contact_size = data_info.tp_info_size;
+
+		dev_dbg(&client->dev,
+			"data_bank_addr: %#08x, report_size: %d, contact_size: %d\n",
+			ts->data_bank_addr, ts->report_size, ts->contact_size);
+
+		error = raydium_i2c_read(client, RM_CMD_QUERY_BANK,
+					 &query_bank_addr,
+					 sizeof(query_bank_addr));
+		if (error)
+			continue;
+
+		error = raydium_i2c_read_message(client,
+						 le32_to_cpu(query_bank_addr),
+						 &ts->info, sizeof(ts->info));
+		if (error)
+			continue;
+
+		return 0;
 	}
-	dev_err(&client->dev, "Get touch data failed: %d\n", error);
 
-	return -EINVAL;
+	dev_err(&client->dev, "failed to query device parameters: %d\n", error);
+	return error;
 }
 
 static int raydium_i2c_fastboot(struct i2c_client *client)
 {
-	static const u8 boot_cmd[] = { 0x50, 0x00, 0x06, 0x20 };
-	u8 buf[HEADER_SIZE];
+	u8 buf[4]; // XXX FIXME why size 4 and not 1?
 	int error;
 
-	error = raydium_i2c_read_message(client,
-		get_unaligned_be32(boot_cmd),
-		sizeof(boot_cmd), buf);
+	error = raydium_i2c_read_message(client, RM_FASTBOOT_MSG_ADDR,
+					 buf, sizeof(buf));
 
 	if (!error) {
 		if (buf[0] == RM_BOOT_BLDR) {
 			dev_dbg(&client->dev, "boot in fastboot mode\n");
 			return -EINVAL;
 		}
+
 		dev_dbg(&client->dev, "boot success -- 0x%x\n", client->addr);
 		return 0;
 	}
 
 	dev_err(&client->dev, "boot failed: %d\n", error);
-
 	return error;
 }
 
 static int raydium_i2c_check_fw_status(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
-	static const u8 bl_area[] = {0x62, 0x6f, 0x6f, 0x74};
-	static const u8 main_area[] = {0x66, 0x69, 0x72, 0x6d};
-	u8 buf[HEADER_SIZE];
+	static const u8 bl_area[] = { 0x62, 0x6f, 0x6f, 0x74 };
+	static const u8 main_area[] = { 0x66, 0x69, 0x72, 0x6d };
+	u8 buf[4];
 	int error;
 
-	error = raydium_i2c_read(client, CMD_BOOT_READ, HEADER_SIZE,
-		(void *)buf);
+	error = raydium_i2c_read(client, RM_CMD_BOOT_READ, buf, sizeof(buf));
 	if (!error) {
+		// XXX FIXME: why do we compare only 1st bytes? Do we even
+		// need 4-byte constants?
 		if (buf[0] == bl_area[0])
 			ts->boot_mode = RAYDIUM_TS_BLDR;
 		else if (buf[0] == main_area[0])
@@ -351,23 +348,28 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 	struct i2c_client *client = ts->client;
 	int error, retry_cnt;
 
-	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
+	for (retry_cnt = 0; retry_cnt < RM_MAX_RETRIES; retry_cnt++) {
 		error = raydium_i2c_fastboot(client);
 		if (error) {
 			/* Continue initializing if it's the last try */
-			if (retry_cnt < MAX_RETRIES - 1)
+			if (retry_cnt < RM_MAX_RETRIES - 1)
 				continue;
 		}
+
 		/* Wait for Hello packet */
-		msleep(BOOT_DELAY_MS);
+		msleep(RM_BOOT_DELAY_MS);
 
 		error = raydium_i2c_check_fw_status(ts);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to read device status: %d\n", error);
+			if (retry_cnt < RM_MAX_RETRIES - 1)
+				continue;
+		}
+
 		if (ts->boot_mode == RAYDIUM_TS_BLDR ||
-			ts->boot_mode == RAYDIUM_TS_MAIN)
+		    ts->boot_mode == RAYDIUM_TS_MAIN) {
 			break;
-		else if (error) {
-			dev_err(&client->dev,
-				"failed to read 'hello' packet: %d\n", error);
 		}
 	}
 
@@ -375,7 +377,7 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 		ts->boot_mode = RAYDIUM_TS_BLDR;
 
 	if (ts->boot_mode == RAYDIUM_TS_BLDR) {
-		ts->info.hw_ver = 0xffffffff;
+		ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
 		ts->info.main_ver = 0xff;
 		ts->info.sub_ver = 0xff;
 	} else {
@@ -386,52 +388,60 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 }
 
 static int raydium_i2c_bl_chk_state(struct i2c_client *client,
-		enum raydium_bl_ack state)
+				    enum raydium_bl_ack state)
 {
 	static const u8 ack_ok[] = { 0xFF, 0x39, 0x30, 0x30, 0x54 };
-	u8 rbuf[5];
+	u8 rbuf[sizeof(ack_ok)];
 	u8 retry;
 	int error;
 
-	if (state == ACK_NULL)
-		return 0;
+	for (retry = 0; retry < RM_MAX_FW_RETRIES; retry++) {
+		switch (state) {
+		case RAYDIUM_ACK_NULL:
+			return 0;
 
-	for (retry = 0; retry < MAX_FW_UPDATE_RETRIES; retry++) {
-		if (state == WAIT_READY) {
-			error = raydium_i2c_read(client, CMD_BOOT_CHK,
-				1, &rbuf[0]);
-			if (!error) {
-				if (rbuf[0] == BOOT_RDY)
-					return 0;
-			}
-		} else if (state == PATH_READY) {
-			error = raydium_i2c_read(client, CMD_BOOT_CHK,
-				sizeof(ack_ok), &rbuf[0]);
-			if (!error) {
-				if (!memcmp(rbuf, ack_ok, sizeof(ack_ok)))
-					return 0;
-			}
-		} else
+		case RAYDIUM_WAIT_READY:
+			error = raydium_i2c_read(client, RM_CMD_BOOT_CHK,
+						 &rbuf[0], 1);
+			if (!error && rbuf[0] == RM_BOOT_RDY)
+				return 0;
+
+			break;
+
+		case RAYDIUM_PATH_READY:
+			error = raydium_i2c_read(client, RM_CMD_BOOT_CHK,
+						 rbuf, sizeof(rbuf));
+			if (!error && !memcmp(rbuf, ack_ok, sizeof(ack_ok)))
+				return 0;
+
+			break;
+
+		default:
+			dev_err(&client->dev, "%s: invalid target state %d\n",
+				__func__, state);
 			return -EINVAL;
+		}
+
 		msleep(20);
 	}
 
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
-static int raydium_i2c_wrt_object(struct i2c_client *client,
-	u8 *data, size_t len, enum raydium_bl_ack state)
+static int raydium_i2c_write_object(struct i2c_client *client,
+				    const void *data, size_t len,
+				    enum raydium_bl_ack state)
 {
-	int error = 0;
+	int error;
 
-	error = raydium_i2c_send(client, CMD_BOOT_WRT, data, len);
+	error = raydium_i2c_send(client, RM_CMD_BOOT_WRT, data, len);
 	if (error) {
 		dev_err(&client->dev, "WRT obj command failed: %d\n",
 			error);
 		return error;
 	}
 
-	error = raydium_i2c_send(client, CMD_BOOT_ACK, (u8 *)NULL, 0);
+	error = raydium_i2c_send(client, RM_CMD_BOOT_ACK, NULL, 0);
 	if (error) {
 		dev_err(&client->dev, "Ack obj command failed: %d\n", error);
 		return error;
@@ -439,7 +449,7 @@ static int raydium_i2c_wrt_object(struct i2c_client *client,
 
 	error = raydium_i2c_bl_chk_state(client, state);
 	if (error) {
-		dev_err(&client->dev, "boot trigger state failed: %d\n", error);
+		dev_err(&client->dev, "BL check state failed: %d\n", error);
 		return error;
 	}
 
@@ -448,65 +458,67 @@ static int raydium_i2c_wrt_object(struct i2c_client *client,
 
 static bool raydium_i2c_boot_trigger(struct i2c_client *client)
 {
-	int error;
-	u8 u8_idx;
 	static const u8 cmd[7][6] = {
-			{0x08, 0x0C, 0x09, 0x00, 0x50, 0xD7},
-			{0x08, 0x04, 0x09, 0x00, 0x50, 0xA5},
-			{0x08, 0x04, 0x09, 0x00, 0x50, 0x00},
-			{0x08, 0x04, 0x09, 0x00, 0x50, 0xA5},
-			{0x08, 0x0C, 0x09, 0x00, 0x50, 0x00},
-			{0x06, 0x01, 0x00, 0x00, 0x00, 0x00},
-			{0x02, 0xA2, 0x00, 0x00, 0x00, 0x00},
-		};
-
-	/*sequtial cmd*/
-	for (u8_idx = 0 ; u8_idx < 7 ; u8_idx++) {
-		error = raydium_i2c_wrt_object(client, (u8 *)cmd[u8_idx],
-				sizeof(cmd[u8_idx]), WAIT_READY);
+		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0xD7 },
+		{ 0x08, 0x04, 0x09, 0x00, 0x50, 0xA5 },
+		{ 0x08, 0x04, 0x09, 0x00, 0x50, 0x00 },
+		{ 0x08, 0x04, 0x09, 0x00, 0x50, 0xA5 },
+		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0x00 },
+		{ 0x06, 0x01, 0x00, 0x00, 0x00, 0x00 },
+		{ 0x02, 0xA2, 0x00, 0x00, 0x00, 0x00 },
+	};
+	int i;
+	int error;
+
+	for (i = 0; i < 7; i++) {
+		error = raydium_i2c_write_object(client, cmd[i], sizeof(cmd[i]),
+						 RAYDIUM_WAIT_READY);
 		if (error) {
-			dev_err(&client->dev, "send boot trigger 1st_cmd failed: %d\n",
-				error);
+			dev_err(&client->dev,
+				"boot trigger failed at step %d: %d\n",
+				i, error);
 			return error;
 		}
 	}
+
 	return 0;
 }
 
 static bool raydium_i2c_fw_trigger(struct i2c_client *client)
 {
-	int error;
-	u8 u8_idx;
 	static const u8 cmd[5][11] = {
-			{0, 0x09, 0x71, 0x0C, 0x09, 0x00, 0x50, 0xD7, 0, 0, 0},
-			{0, 0x09, 0x71, 0x04, 0x09, 0x00, 0x50, 0xA5, 0, 0, 0},
-			{0, 0x09, 0x71, 0x04, 0x09, 0x00, 0x50, 0x00, 0, 0, 0},
-			{0, 0x09, 0x71, 0x04, 0x09, 0x00, 0x50, 0xA5, 0, 0, 0},
-			{0, 0x09, 0x71, 0x0C, 0x09, 0x00, 0x50, 0x00, 0, 0, 0},
-		};
-
-	/*sequtial cmd*/
-	for (u8_idx = 0 ; u8_idx < 5 ; u8_idx++) {
-		error = raydium_i2c_wrt_object(client, (u8 *)cmd[u8_idx],
-				sizeof(cmd[u8_idx]), ACK_NULL);
+		{ 0, 0x09, 0x71, 0x0C, 0x09, 0x00, 0x50, 0xD7, 0, 0, 0 },
+		{ 0, 0x09, 0x71, 0x04, 0x09, 0x00, 0x50, 0xA5, 0, 0, 0 },
+		{ 0, 0x09, 0x71, 0x04, 0x09, 0x00, 0x50, 0x00, 0, 0, 0 },
+		{ 0, 0x09, 0x71, 0x04, 0x09, 0x00, 0x50, 0xA5, 0, 0, 0 },
+		{ 0, 0x09, 0x71, 0x0C, 0x09, 0x00, 0x50, 0x00, 0, 0, 0 },
+	};
+	int i;
+	int error;
+
+	for (i = 0; i < 5; i++) {
+		error = raydium_i2c_write_object(client, cmd[i], sizeof(cmd[i]),
+						 RAYDIUM_ACK_NULL);
 		if (error) {
-			dev_err(&client->dev, "send fw trigger 1st_cmd failed: %d\n",
-				error);
+			dev_err(&client->dev,
+				"fw trigger failed at step %d: %d\n",
+				i, error);
 			return error;
 		}
 	}
+
 	return 0;
 }
 
 static int raydium_i2c_check_path(struct i2c_client *client)
 {
-	static const u8 cmd[] = {0x09, 0x00, 0x09, 0x00, 0x50, 0x10, 0x00};
+	static const u8 cmd[] = { 0x09, 0x00, 0x09, 0x00, 0x50, 0x10, 0x00 };
 	int error;
 
-	error = raydium_i2c_wrt_object(client, (u8 *)cmd, sizeof(cmd),
-			PATH_READY);
+	error = raydium_i2c_write_object(client, cmd, sizeof(cmd),
+					 RAYDIUM_PATH_READY);
 	if (error) {
-		dev_err(&client->dev, "send chk path cmd fail: %d\n", error);
+		dev_err(&client->dev, "check path command failed: %d\n", error);
 		return error;
 	}
 
@@ -515,49 +527,50 @@ static int raydium_i2c_check_path(struct i2c_client *client)
 
 static int raydium_i2c_enter_bl(struct i2c_client *client)
 {
-	static const u8 cal_cmd[] = {0x00, 0x01, 0x52};
+	static const u8 cal_cmd[] = { 0x00, 0x01, 0x52 };
 	int error;
 
-	error = raydium_i2c_wrt_object(client, (u8 *)cal_cmd,
-			sizeof(cal_cmd), ACK_NULL);
+	error = raydium_i2c_write_object(client, cal_cmd, sizeof(cal_cmd),
+					 RAYDIUM_ACK_NULL);
 	if (error) {
-		dev_err(&client->dev, "send jump loader cmd fail: %d\n", error);
+		dev_err(&client->dev, "enter bl command failed: %d\n", error);
 		return error;
 	}
-	msleep(BOOT_DELAY_MS);
+
+	msleep(RM_BOOT_DELAY_MS);
 	return 0;
 }
 
 static int raydium_i2c_leave_bl(struct i2c_client *client)
 {
-	static const u8 leave_cmd[] = {0x05, 0x00};
+	static const u8 leave_cmd[] = { 0x05, 0x00 };
 	int error;
 
-	error = raydium_i2c_wrt_object(client, (u8 *)leave_cmd,
-			sizeof(leave_cmd), ACK_NULL);
+	error = raydium_i2c_write_object(client, leave_cmd, sizeof(leave_cmd),
+					 RAYDIUM_ACK_NULL);
 	if (error) {
-		dev_err(&client->dev, "send leave bl cmd fail: %d\n", error);
+		dev_err(&client->dev, "leave bl command failed: %d\n", error);
 		return error;
 	}
-	msleep(BOOT_DELAY_MS);
+
+	msleep(RM_BOOT_DELAY_MS);
 	return 0;
 }
 
 static int raydium_i2c_write_checksum(struct i2c_client *client,
-	size_t length, u16 checksum)
+				      size_t length, u16 checksum)
 {
-	u8 checksum_cmd[] = {0x00, 0x05, 0x6D, 0x00, 0x00, 0x00, 0x00};
-	int error = 0;
+	u8 checksum_cmd[] = { 0x00, 0x05, 0x6D, 0x00, 0x00, 0x00, 0x00 };
+	int error;
 
-	checksum_cmd[3] = (u8)(length & 0xFF);
-	checksum_cmd[4] = (u8)((length & 0xFF00) >> 8);
-	checksum_cmd[5] = (u8)(checksum & 0xFF);
-	checksum_cmd[6] = (u8)((checksum & 0xFF00) >> 8);
+	put_unaligned_le16(length, &checksum_cmd[3]);
+	put_unaligned_le16(checksum, &checksum_cmd[5]);
 
-	error = raydium_i2c_wrt_object(client, (u8 *)checksum_cmd,
-			sizeof(checksum_cmd), ACK_NULL);
+	error = raydium_i2c_write_object(client,
+					 checksum_cmd, sizeof(checksum_cmd),
+					 RAYDIUM_ACK_NULL);
 	if (error) {
-		dev_err(&client->dev, "send wrt checksum cmd fail: %d\n",
+		dev_err(&client->dev, "failed to write checksum: %d\n",
 			error);
 		return error;
 	}
@@ -567,13 +580,13 @@ static int raydium_i2c_write_checksum(struct i2c_client *client,
 
 static int raydium_i2c_disable_watch_dog(struct i2c_client *client)
 {
-	static const u8 cmd[] = {0x0A, 0xAA};
-	int error = 0;
+	static const u8 cmd[] = { 0x0A, 0xAA };
+	int error;
 
-	error = raydium_i2c_wrt_object(client, (u8 *)cmd, sizeof(cmd),
-			WAIT_READY);
+	error = raydium_i2c_write_object(client, cmd, sizeof(cmd),
+					 RAYDIUM_WAIT_READY);
 	if (error) {
-		dev_err(&client->dev, "send disable watchdog cmd fail: %d\n",
+		dev_err(&client->dev, "disable watchdog command failed: %d\n",
 			error);
 		return error;
 	}
@@ -582,34 +595,38 @@ static int raydium_i2c_disable_watch_dog(struct i2c_client *client)
 }
 
 static int raydium_i2c_fw_write_page(struct i2c_client *client,
-				u8 *page, size_t len)
+				     u8 page_idx, const void *data, size_t len)
 {
+	u8 buf[RM_BL_WRT_LEN];
+	u8 pkg_idx = 1;
+	size_t xfer_len;
 	int error;
-	u8 buf[MAX_BOOT_WRT_LEN];
-	u8 u8_idx, div_cnt;
-
-	len -= CMD_BOOT_HEADER_LEN;
-
-	div_cnt = len % RAYDIUM_TRANS_BUFSIZE ?
-		len / RAYDIUM_TRANS_BUFSIZE + 1:len / RAYDIUM_TRANS_BUFSIZE;
 
-	for (u8_idx = 0 ; u8_idx < div_cnt ; u8_idx++) {
-		buf[HEADER] = page[0];
-		buf[PAGE_STR] = page[1];
-		buf[PKG_IDX] = u8_idx + 1;
+	while (len) {
+		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
 
-		memcpy(&buf[DATA_STR], page + DATA_STR +
-			u8_idx*RAYDIUM_TRANS_BUFSIZE,
-			RAYDIUM_TRANS_BUFSIZE);
+		buf[BL_HEADER] = 0x0b;
+		// XXX FIXME: is this correct? Do we really want all pages
+		// after 1st to have 0xff? Should it be a counter?
+		// Why do we need both pages and packages within pages?
+		buf[BL_PAGE_STR] = page_idx ? 0 : 0xff;
+		buf[BL_PKG_IDX] = pkg_idx;
+		memcpy(&buf[BL_DATA_STR], data, xfer_len);
 
-		error = raydium_i2c_wrt_object(client, (u8 *)buf, sizeof(buf),
-				WAIT_READY);
+		error = raydium_i2c_write_object(client, buf, xfer_len,
+						 RAYDIUM_WAIT_READY);
 		if (error) {
-			dev_err(&client->dev, "send page wrt cmd failed: %d\n",
-				error);
+			dev_err(&client->dev,
+				"page write command failed for page %d, chunk %d: %d\n",
+				page_idx, pkg_idx, error);
 			return error;
 		}
+
 		msleep(20);
+
+		data += xfer_len;
+		len -= xfer_len;
+		pkg_idx++;
 	}
 
 	return error;
@@ -619,124 +636,121 @@ static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
 					 const struct firmware *fw)
 {
 	struct i2c_client *client = ts->client;
-	u8 u8_idx;
+	const void *data;
+	size_t data_len;
+	size_t len;
+	int page_nr;
+	int i;
+	int error;
 	u16 fw_checksum;
-	u8 buf[RAYDIUM_PAGE_SIZE + CMD_BOOT_HEADER_LEN];
-	int page, n_fw_pages;
-	int error, fw_idx;
 
 	if (fw->size == 0) {
 		dev_err(&client->dev, "Invalid firmware length\n");
 		return -EINVAL;
 	}
 
-	if (fw->size % RAYDIUM_PAGE_SIZE)
-		n_fw_pages = fw->size/RAYDIUM_PAGE_SIZE + 1;
-	else
-		n_fw_pages = fw->size/RAYDIUM_PAGE_SIZE;
-
 	error = raydium_i2c_check_fw_status(ts);
 	if (error) {
 		dev_err(&client->dev, "Unable to access IC %d\n", error);
-			return error;
+		return error;
 	}
 
 	if (ts->boot_mode == RAYDIUM_TS_MAIN) {
-		for (u8_idx = 0; u8_idx < MAX_RETRIES; u8_idx++) {
+		for (i = 0; i < RM_MAX_RETRIES; i++) {
 			error = raydium_i2c_enter_bl(client);
 			if (!error) {
 				error = raydium_i2c_check_fw_status(ts);
 				if (error) {
-					dev_err(&client->dev, "Unable to access IC %d\n",
+					dev_err(&client->dev,
+						"unable to access IC: %d\n",
 						error);
 					return error;
 				}
+
 				if (ts->boot_mode == RAYDIUM_TS_BLDR)
 					break;
 			}
 		}
+
 		if (ts->boot_mode == RAYDIUM_TS_MAIN) {
-			dev_err(&client->dev, "Fail jump to boot loader %d\n",
-					error);
+			dev_err(&client->dev,
+				"failied to jump to boot loader: %d\n",
+				error);
 			return -EIO;
 		}
 	}
 
 	error = raydium_i2c_disable_watch_dog(client);
-	if (error) {
-		dev_err(&client->dev, "send disable watchdog cmd fail, %d\n",
-			error);
+	if (error)
 		return error;
-	}
 
 	error = raydium_i2c_check_path(client);
-	if (error) {
-		dev_err(&client->dev, "send chk path fail, %d\n", error);
+	if (error)
 		return error;
-	}
 
 	error = raydium_i2c_boot_trigger(client);
 	if (error) {
-		dev_err(&client->dev, "send boot trigger fail, %d\n", error);
+		dev_err(&client->dev, "send boot trigger fail: %d\n", error);
 		return error;
 	}
 
-	fw_checksum = 0;
-	fw_idx = 0;
-	for (page = 0 ; page < n_fw_pages ; page++) {
-		memset(buf, 0xFF, sizeof(buf));
-		buf[HEADER] = 0x0B;
-		if (page == 0)
-			buf[PAGE_STR] = 0x00;
-
-		for (u8_idx = 0; u8_idx < RAYDIUM_PAGE_SIZE; u8_idx++) {
-			if (fw_idx < fw->size) {
-				buf[DATA_STR + u8_idx] =
-					fw->data[page*RAYDIUM_PAGE_SIZE +
-					u8_idx];
-				fw_checksum += buf[3 + u8_idx];
-				fw_idx++;
-			}
-		}
+	data = fw->data;
+	data_len = fw->size;
+	page_nr = 0;
+
+	while (data_len) {
+		len = min_t(size_t, data_len, RM_FW_PAGE_SIZE);
+
+		error = raydium_i2c_fw_write_page(client, page_nr++, data, len);
+		if (error)
+			return error;
 
-		raydium_i2c_fw_write_page(client, (u8 *)buf, sizeof(buf));
+		// XXX FIXME: we already sleep in raydium_i2c_fw_write_page(),
+		// do we really need to sleep here as well?
 		msleep(20);
+
+		data += len;
+		data_len -= len;
 	}
 
 	error = raydium_i2c_leave_bl(client);
 	if (error) {
-		dev_err(&client->dev, "leave boot loader fail: %d\n", error);
+		dev_err(&client->dev,
+			"failed to leave boot loader: %d\n", error);
 		return error;
 	}
-	dev_err(&client->dev, "leave boot loader success\n");
+
+	dev_dbg(&client->dev, "left boot loader mode\n");
 
 	error = raydium_i2c_check_fw_status(ts);
 	if (error) {
-		dev_err(&client->dev, "Unable to access IC %d\n", error);
+		dev_err(&client->dev,
+			"failed to check fw status after write: %d\n",
+			error);
 		return error;
 	}
 
-	if (ts->boot_mode == RAYDIUM_TS_MAIN) {
-
-		error = raydium_i2c_fw_trigger(client);
-		if (error) {
-			dev_err(&client->dev, "send fw trigger fail, %d\n",
-				error);
-			return error;
-		}
-
-		error = raydium_i2c_write_checksum(client, fw->size,
-			fw_checksum);
-		if (error) {
-			dev_err(&client->dev, "write checksum fail %d\n",
-				error);
-			return error;
-		}
-	} else {
-		dev_err(&client->dev, "switch to main_fw fail %d\n", error);
+	if (ts->boot_mode != RAYDIUM_TS_MAIN) {
+		dev_err(&client->dev,
+			"failed to switch to main fw after writing firmware: %d\n",
+			error);
 		return -EINVAL;
 	}
 
+	error = raydium_i2c_fw_trigger(client);
+	if (error) {
+		dev_err(&client->dev, "failed to trigger fw: %d\n", error);
+		return error;
+	}
+
+	fw_checksum = 0;
+	for (i = 0; i < fw->size; i++)
+		fw_checksum += fw->data[i];
+
+	error = raydium_i2c_write_checksum(client, fw->size, fw_checksum);
+	if (error)
+		return error;
+
 	return 0;
 }
 
@@ -752,7 +766,7 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
 		dev_err(&client->dev, "Unable to open firmware %s\n", fw_file);
 		return error;
 	}
-	/*disable irq*/
+
 	disable_irq(client->irq);
 
 	error = raydium_i2c_do_update_firmware(ts, fw);
@@ -777,46 +791,48 @@ out_enable_irq:
 	enable_irq(client->irq);
 	msleep(100);
 
+	release_firmware(fw);
+
 	return error;
 }
 
 static void raydium_mt_event(struct raydium_data *ts)
 {
-	u8 data[MAX_PkG_SIZE];
-	int error, i;
-	int x, y, f_state, pressure, wx, wy;
-
-	error = raydium_i2c_read_message(ts->client, ts->obj.data_bank_addr,
-		ts->obj.pkg_size, (void *)data);
+	int i;
+	int error;
 
-	if (error < 0) {
+	error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
+					 ts->report_data, ts->report_size);
+	if (error) {
 		dev_err(&ts->client->dev, "%s: failed to read data: %d\n",
 			__func__, error);
 		return;
 	}
 
-	for (i = 0; i < MAX_TOUCH_NUM; i++) {
-		f_state = (data + i * ts->obj.tp_info_size)[POS_STATE];
-		pressure = (data + i * ts->obj.tp_info_size)[POS_PRESSURE];
-		wx = (data + i * ts->obj.tp_info_size)[WIDTH_X];
-		wy = (data + i * ts->obj.tp_info_size)[WIDTH_Y];
+
+	for (i = 0; i < ts->report_size / ts->contact_size; i++) {
+		u8 *contact = &ts->report_data[ts->contact_size * i];
+		bool state = contact[RM_CONTACT_STATE_POS];
+		u8 wx, wy;
 
 		input_mt_slot(ts->input, i);
-		input_mt_report_slot_state(ts->input,
-				MT_TOOL_FINGER, f_state != 0);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, state);
 
-		if (!f_state)
+		if (!state)
 			continue;
-		x = get_unaligned_le16(&data[i * ts->obj.tp_info_size + POS_X]);
-		y = get_unaligned_le16(&data[i * ts->obj.tp_info_size + POS_Y]);
-
-		input_report_abs(ts->input, ABS_MT_POSITION_X, x);
-		input_report_abs(ts->input, ABS_MT_POSITION_Y, y);
-		input_report_abs(ts->input, ABS_MT_PRESSURE, pressure);
-		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
-			max(wx, wy));
-		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
-			min(wx, wy));
+
+		input_report_abs(ts->input, ABS_MT_POSITION_X,
+				get_unaligned_le16(&contact[RM_CONTACT_X_POS]));
+		input_report_abs(ts->input, ABS_MT_POSITION_Y,
+				get_unaligned_le16(&contact[RM_CONTACT_Y_POS]));
+		input_report_abs(ts->input, ABS_MT_PRESSURE,
+				contact[RM_CONTACT_PRESSURE_POS]);
+
+		wx = contact[RM_CONTACT_WIDTH_X_POS];
+		wy = contact[RM_CONTACT_WIDTH_Y_POS];
+
+		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, max(wx, wy));
+		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR, min(wx, wy));
 	}
 
 	input_mt_sync_frame(ts->input);
@@ -833,31 +849,42 @@ static irqreturn_t raydium_i2c_irq(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
 
-static ssize_t raydium_calibrate(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t raydium_i2c_fw_ver_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
-	struct raydium_data *ts = dev_get_drvdata(dev);
-	struct i2c_client *client = ts->client;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct raydium_data *ts = i2c_get_clientdata(client);
+
+	return sprintf(buf, "%d.%d\n", ts->info.main_ver, ts->info.sub_ver);
+}
 
-	static const u8 cal_cmd[] = {0x00, 0x01, 0x9E};
-	int error = 0;
+static ssize_t raydium_i2c_hw_ver_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct raydium_data *ts = i2c_get_clientdata(client);
 
-	error = raydium_i2c_wrt_object(client, (u8 *)cal_cmd,
-			sizeof(cal_cmd), WAIT_READY);
-	if (error) {
-		dev_err(&client->dev, "send chk path cmd fail: %d\n", error);
-		return error;
-	}
+	return sprintf(buf, "%#04x\n", le32_to_cpu(ts->info.hw_ver));
+}
 
-	return error;
+static ssize_t raydium_i2c_boot_mode_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct raydium_data *ts = i2c_get_clientdata(client);
+
+	return sprintf(buf, "%s\n",
+		       ts->boot_mode == RAYDIUM_TS_MAIN ?
+				"Normal" : "Recovery");
 }
 
-static ssize_t write_update_fw(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t raydium_i2c_update_fw_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
 {
-	struct raydium_data *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct raydium_data *ts = i2c_get_clientdata(client);
 	int error;
 
 	error = mutex_lock_interruptible(&ts->sysfs_mutex);
@@ -871,38 +898,35 @@ static ssize_t write_update_fw(struct device *dev,
 	return error ?: count;
 }
 
-static ssize_t raydium_bootmode_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t raydium_i2c_calibrate_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
 {
-	struct raydium_data *ts = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", ts->boot_mode == RAYDIUM_TS_MAIN ?
-		"Normal" : "Recovery");
-}
-
-static ssize_t raydium_fw_ver_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct raydium_data *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct raydium_data *ts = i2c_get_clientdata(client);
+	static const u8 cal_cmd[] = { 0x00, 0x01, 0x9E };
+	int error;
 
-	return sprintf(buf, "%d.%d\n", ts->info.main_ver, ts->info.sub_ver);
-}
+	error = mutex_lock_interruptible(&ts->sysfs_mutex);
+	if (error)
+		return error;
 
-static ssize_t raydium_hw_ver_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct raydium_data *ts = dev_get_drvdata(dev);
+	error = raydium_i2c_write_object(client, cal_cmd, sizeof(cal_cmd),
+					 RAYDIUM_WAIT_READY);
+	if (error)
+		dev_err(&client->dev, "calibrate command failed: %d\n", error);
 
-	return sprintf(buf, "%04x\n", ts->info.hw_ver);
+	mutex_unlock(&ts->sysfs_mutex);
+	return error ?: count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, raydium_fw_ver_show, NULL);
-static DEVICE_ATTR(hw_version, S_IRUGO, raydium_hw_ver_show, NULL);
-static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_bootmode_show, NULL);
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw);
-static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_calibrate);
+static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);
+static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);
+static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);
 
-static struct attribute *raydium_attributes[] = {
+static struct attribute *raydium_i2c_attributes[] = {
 	&dev_attr_update_fw.attr,
 	&dev_attr_boot_mode.attr,
 	&dev_attr_fw_version.attr,
@@ -911,15 +935,15 @@ static struct attribute *raydium_attributes[] = {
 	NULL
 };
 
-static struct attribute_group raydium_attribute_group = {
-	.attrs = raydium_attributes,
+static struct attribute_group raydium_i2c_attribute_group = {
+	.attrs = raydium_i2c_attributes,
 };
 
 static void raydium_i2c_remove_sysfs_group(void *_data)
 {
 	struct raydium_data *ts = _data;
 
-	sysfs_remove_group(&ts->client->dev.kobj, &raydium_attribute_group);
+	sysfs_remove_group(&ts->client->dev.kobj, &raydium_i2c_attribute_group);
 }
 
 static int raydium_i2c_power_on(struct raydium_data *ts)
@@ -946,7 +970,7 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
 		goto release_reset_gpio;
 	}
 
-	udelay(RAYDIUM_POWERON_DELAY_USEC);
+	udelay(RM_POWERON_DELAY_USEC);
 
 release_reset_gpio:
 	gpiod_set_value_cansleep(ts->reset_gpio, 0);
@@ -954,7 +978,7 @@ release_reset_gpio:
 	if (error)
 		return error;
 
-	msleep(RAYDIUM_RESET_DELAY_MSEC);
+	msleep(RM_RESET_DELAY_MSEC);
 
 	return 0;
 }
@@ -971,7 +995,7 @@ static void raydium_i2c_power_off(void *_data)
 }
 
 static int raydium_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+			     const struct i2c_device_id *id)
 {
 	union i2c_smbus_data dummy;
 	struct raydium_data *ts;
@@ -979,17 +1003,15 @@ static int raydium_i2c_probe(struct i2c_client *client,
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev,
-			"%s: i2c check functionality error\n", DEVICE_NAME);
+			"i2c check functionality error (need I2C_FUNC_I2C)\n");
 		return -ENXIO;
 	}
 
-	ts = devm_kzalloc(&client->dev, sizeof(struct raydium_data),
-		GFP_KERNEL);
+	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
 	mutex_init(&ts->sysfs_mutex);
-	init_completion(&ts->cmd_done);
 
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
@@ -1013,7 +1035,7 @@ static int raydium_i2c_probe(struct i2c_client *client,
 	}
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
-		GPIOD_OUT_LOW);
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
 		if (error != -EPROBE_DEFER) {
@@ -1037,7 +1059,7 @@ static int raydium_i2c_probe(struct i2c_client *client,
 
 	/* Make sure there is something at this address */
 	if (i2c_smbus_xfer(client->adapter, client->addr, 0,
-			I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy) < 0) {
+			   I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy) < 0) {
 		dev_err(&client->dev, "nothing at this address\n");
 		return -ENXIO;
 	}
@@ -1057,20 +1079,20 @@ static int raydium_i2c_probe(struct i2c_client *client,
 	ts->input->name = "Raydium Touchscreen";
 	ts->input->id.bustype = BUS_I2C;
 
-	/* Multitouch input params setup */
-	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0,
-		ts->info.x_max, 0, 0);
+	input_set_drvdata(ts->input, ts);
+
+	input_set_abs_params(ts->input, ABS_MT_POSITION_X,
+			     0, le32_to_cpu(ts->info.x_max), 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_POSITION_Y,
-		0, ts->info.y_max, 0, 0);
-	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
-	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
+			     0, le32_to_cpu(ts->info.y_max), 0, 0);
 	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->info.x_res);
 	input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->info.y_res);
 
-	input_set_drvdata(ts->input, ts);
+	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
 
-	error = input_mt_init_slots(ts->input, MAX_TOUCH_NUM,
-		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	error = input_mt_init_slots(ts->input, RM_MAX_TOUCH_NUM,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 	if (error) {
 		dev_err(&client->dev,
 			"failed to initialize MT slots: %d\n", error);
@@ -1084,15 +1106,16 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-		raydium_i2c_irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-			client->name, ts);
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, raydium_i2c_irq,
+					  IRQF_ONESHOT, client->name, ts);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		return error;
 	}
 
-	error = sysfs_create_group(&client->dev.kobj, &raydium_attribute_group);
+	error = sysfs_create_group(&client->dev.kobj,
+				   &raydium_i2c_attribute_group);
 	if (error) {
 		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
 			error);
@@ -1116,11 +1139,11 @@ static void __maybe_unused raydium_enter_sleep(struct i2c_client *client)
 	static const u8 sleep_cmd[] = { 0x5A, 0xff, 0x00, 0x0f };
 	int error;
 
-	error = raydium_i2c_send(client, CMD_ENTER_SLEEP, (u8 *)sleep_cmd,
-		sizeof(sleep_cmd));
+	error = raydium_i2c_send(client, RM_CMD_ENTER_SLEEP,
+				 sleep_cmd, sizeof(sleep_cmd));
 	if (error)
 		dev_err(&client->dev,
-			"Send sleep failed: %d\n", error);
+			"sleep command failed: %d\n", error);
 }
 
 static int __maybe_unused raydium_i2c_suspend(struct device *dev)
@@ -1128,7 +1151,7 @@ static int __maybe_unused raydium_i2c_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct raydium_data *ts = i2c_get_clientdata(client);
 
-	/* Command not support in BLDR recovery mode */
+	/* Sleep is not available in BLDR recovery mode */
 	if (ts->boot_mode != RAYDIUM_TS_MAIN)
 		return -ENOMEM;
 
@@ -1168,22 +1191,23 @@ static SIMPLE_DEV_PM_OPS(raydium_i2c_pm_ops,
 			 raydium_i2c_suspend, raydium_i2c_resume);
 
 static const struct i2c_device_id raydium_i2c_id[] = {
-	{ DEVICE_NAME, 0 },
-	{ }
+	{ "raydium_i2c" , 0 },
+	{ "rm32380", 0 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, raydium_i2c_id);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id raydium_acpi_id[] = {
 	{ "RAYD0001", 0 },
-	{ }
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(acpi, raydium_acpi_id);
 #endif
 
 #ifdef CONFIG_OF
 static const struct of_device_id raydium_of_match[] = {
-	{ .compatible = "raydium,rm32380",},
+	{ .compatible = "raydium,rm32380", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, raydium_of_match);
@@ -1199,7 +1223,6 @@ static struct i2c_driver raydium_i2c_driver = {
 		.of_match_table = of_match_ptr(raydium_of_match),
 	},
 };
-
 module_i2c_driver(raydium_i2c_driver);
 
 MODULE_AUTHOR("Raydium");
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
