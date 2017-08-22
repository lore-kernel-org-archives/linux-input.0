From: Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Input: add support for HiDeep touchscreen
Date: Tue, 22 Aug 2017 18:03:38 +0900
Message-ID: <1503392618-26853-1-git-send-email-anthony.kim@hideep.com>
References: <1500965607-2446-1-git-send-email-anthony.kim@hideep.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500965607-2446-1-git-send-email-anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The HiDeep touchscreen device is a capacitive multi-touch controller
mainly for multi-touch supported devices use. It use I2C interface for
communication to IC and provide axis X, Y, Z locations for ten finger
touch through input event interface to userspace.

It support the Crimson and the Lime two type IC. They are different
the number of channel supported and FW size. But the working protocol
is same.

Signed-off-by: Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/input/touchscreen/hideep.txt          |   39 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/touchscreen/Kconfig                  |   11 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/hideep_core.c            | 1294 ++++++++++++++++++++
 drivers/input/touchscreen/hideep_core.h            |  221 ++++
 6 files changed, 1567 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
 create mode 100644 drivers/input/touchscreen/hideep_core.c
 create mode 100644 drivers/input/touchscreen/hideep_core.h

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
new file mode 100644
index 0000000..7a5b9a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
@@ -0,0 +1,39 @@
+* HiDeep Finger and Stylus touchscreen controller
+
+Required properties:
+- compatible		: must be "hideep,hideep-crimson"
+					or "hideep,hideep-lime".
+- reg			: I2C slave address, (e.g. 0x6C).
+- interrupt-parent : Interrupt controller to which the chip is connected.
+- interrupts : Interrupt to which the chip is connected.
+
+Optional properties:
+- vdd-supply	: It is the controller supply for controlling
+					 main voltage(3.3V) through the regulator.
+- vid-supply	: It is the controller supply for controlling
+					IO voltage(1.8V) through the regulator.
+- reset-gpios	: Define for reset gpio pin.
+						It is to use for reset IC.
+- touchscreen-size-x	: X axis size of touchscreen
+- touchscreen-size-y	: Y axis size of touchscreen
+- touchkey-use	: Using touchkey in system.
+
+Example:
+
+i2c@00000000 {
+
+	/* ... */
+
+	touchscreen@6c {
+		compatible = "hideep,hideep-lime";
+		reg = <0x6c>;
+		interrupt-parent = <&gpx1>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&ldo15_reg>";
+		vid-supply = <&ldo18_reg>;
+		reset-gpios = <&gpx1 5 0>;
+		touchscreen-size-x = 1079;
+		touchscreen-size-y = 1919;
+		touchkey-use;
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c03d201..aa2a301 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -131,6 +131,7 @@ gw	Gateworks Corporation
 hannstar	HannStar Display Corporation
 haoyu	Haoyu Microelectronic Co. Ltd.
 hardkernel	Hardkernel Co., Ltd
+hideep	HiDeep Inc.
 himax	Himax Technologies, Inc.
 hisilicon	Hisilicon Limited.
 hit	Hitachi Ltd.
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 64b30fe..13e11c7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1246,4 +1246,15 @@ config TOUCHSCREEN_ROHM_BU21023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21023_ts.
 
+config TOUCHSCREEN_HIDEEP
+	tristate "HiDeep Touch IC"
+	depends on I2C
+	help
+	  Say Y here if you have a touchscreen using HiDeep.
+
+	  If unsure, say N.
+
+	  To compile this driver as a moudle, choose M here : the
+	  module will be called hideep_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 6badce8..03ec3bb 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -103,3 +103,4 @@ obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
 obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
+obj-$(CONFIG_TOUCHSCREEN_HIDEEP) += hideep_core.o
diff --git a/drivers/input/touchscreen/hideep_core.c b/drivers/input/touchscreen/hideep_core.c
new file mode 100644
index 0000000..1d5887d
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_core.c
@@ -0,0 +1,1294 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/firmware.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/acpi.h>
+#include <linux/interrupt.h>
+#include <linux/sysfs.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <asm/unaligned.h>
+
+#include "hideep_core.h"
+
+static void hideep_reset_ic(struct hideep_ts *ts);
+
+static int hideep_pgm_w_mem(struct hideep_ts *ts, unsigned int addr,
+	struct pgm_packet *packet, unsigned int len)
+{
+	int ret = 0;
+	int i;
+
+	if ((len % 4) != 0)
+		return -1;
+
+	mutex_lock(&ts->i2c_mutex);
+
+	put_unaligned_be32((0x80 | (len / 4 - 1)), &packet->header.w[0]);
+	put_unaligned_be32(addr, &packet->header.w[1]);
+
+	for (i = 0; i < len / sizeof(unsigned int); i++)
+		put_unaligned_be32(packet->payload[i], &packet->payload[i]);
+
+	ret = i2c_master_send(ts->client, &packet->header.b[3],
+		(len + 5));
+
+	if (ret < 0)
+		goto err;
+
+err:
+	mutex_unlock(&ts->i2c_mutex);
+	return ret;
+}
+
+static int hideep_pgm_r_mem(struct hideep_ts *ts, unsigned int addr,
+	struct pgm_packet *packet, unsigned int len)
+{
+	int ret = 0;
+	int i;
+	unsigned char buff[len];
+
+	if ((len % 4) != 0)
+		return -1;
+
+	mutex_lock(&ts->i2c_mutex);
+
+	put_unaligned_be32((0x00 | (len / 4 - 1)), &packet->header.w[0]);
+	put_unaligned_be32(addr, &packet->header.w[1]);
+
+	ret = i2c_master_send(ts->client, &packet->header.b[3], 5);
+
+	if (ret < 0)
+		goto err;
+
+	ret = i2c_master_recv(ts->client, buff,	len);
+
+	if (ret < 0)
+		goto err;
+
+	for (i = 0; i < len / 4; i++)
+		packet->payload[i] = get_unaligned_be32(&buff[i * 4]);
+
+err:
+	mutex_unlock(&ts->i2c_mutex);
+	return ret;
+}
+
+static int hideep_pgm_r_reg(struct hideep_ts *ts, unsigned int addr,
+	unsigned int *val)
+{
+	int ret = 0;
+	struct pgm_packet packet;
+
+	put_unaligned_be32(0x00, &packet.header.w[0]);
+	put_unaligned_be32(addr, &packet.header.w[1]);
+
+	ret = hideep_pgm_r_mem(ts, addr, &packet, 4);
+
+	if (ret < 0)
+		goto err;
+
+	*val = packet.payload[0];
+
+err:
+	return ret;
+}
+
+static int hideep_pgm_w_reg(struct hideep_ts *ts, unsigned int addr,
+	unsigned int data)
+{
+	int ret = 0;
+	struct pgm_packet packet;
+
+	put_unaligned_be32(0x80, &packet.header.w[0]);
+	put_unaligned_be32(addr, &packet.header.w[1]);
+	packet.payload[0] = data;
+
+	ret = hideep_pgm_w_mem(ts, addr, &packet, 4);
+
+	return ret;
+}
+
+#define SW_RESET_IN_PGM(CLK) \
+{ \
+	hideep_pgm_w_reg(ts, SYSCON_WDT_CNT, CLK); \
+	hideep_pgm_w_reg(ts, SYSCON_WDT_CON, 0x03); \
+	hideep_pgm_w_reg(ts, SYSCON_WDT_CON, 0x01); \
+}
+
+#define SET_FLASH_PIO(CE) \
+	hideep_pgm_w_reg(ts, FLASH_CON, 0x01 | ((CE) << 1))
+#define SET_PIO_SIG(X, Y) \
+	hideep_pgm_w_reg(ts, FLASH_BASE + PIO_SIG + (X), Y)
+#define SET_FLASH_HWCONTROL() \
+	hideep_pgm_w_reg(ts, FLASH_CON, 0x00000000)
+
+#define NVM_W_SFR(x, y) \
+{ \
+	SET_FLASH_PIO(1); \
+	SET_PIO_SIG(x, y); \
+	SET_FLASH_PIO(0); \
+}
+
+static void get_dwz_from_binary(unsigned char *pres,
+	struct dwz_info *dwz_info)
+{
+	memcpy(dwz_info, pres + HIDEEP_DWZ_INFO_OFS,
+		sizeof(struct dwz_info));
+}
+
+static void hideep_sw_reset(struct hideep_ts *ts, unsigned int food)
+{
+	SW_RESET_IN_PGM(food);
+}
+
+static int hideep_enter_pgm(struct hideep_ts *ts)
+{
+	int ret = 0;
+	int retry_count = 10;
+	int retry = 0;
+	unsigned int status;
+	unsigned int pattern = 0xDF9DAF39;
+
+	while (retry < retry_count) {
+		i2c_master_send(ts->client, (unsigned char *)&pattern, 4);
+		mdelay(1);
+
+		/* flush invalid Tx load register */
+		hideep_pgm_w_reg(ts, ESI_TX_INVALID, 0x01);
+
+		hideep_pgm_r_reg(ts, SYSCON_PGM_ID, &status);
+
+		if (pattern != get_unaligned_be32(&status)) {
+			retry++;
+			dev_err(&ts->client->dev, "enter_pgm : error(%08x):",
+				get_unaligned_be32(&status));
+		} else {
+			dev_dbg(&ts->client->dev, "found magic code");
+			break;
+		}
+	}
+
+	if (retry < retry_count) {
+		hideep_pgm_w_reg(ts, SYSCON_WDT_CON, 0x00);
+		hideep_pgm_w_reg(ts, SYSCON_SPC_CON, 0x00);
+		hideep_pgm_w_reg(ts, SYSCON_CLK_ENA, 0xFF);
+		hideep_pgm_w_reg(ts, SYSCON_CLK_CON, 0x01);
+		hideep_pgm_w_reg(ts, SYSCON_PWR_CON, 0x01);
+		hideep_pgm_w_reg(ts, FLASH_TIM, 0x03);
+		hideep_pgm_w_reg(ts, FLASH_CACHE_CFG, 0x00);
+		hideep_pgm_w_reg(ts, FLASH_CACHE_CFG, 0x02);
+
+		mdelay(1);
+	} else {
+		ret = -1;
+	}
+
+	return ret;
+}
+static void hideep_nvm_unlock(struct hideep_ts *ts)
+{
+	unsigned int unmask_code = 0;
+
+	hideep_pgm_w_reg(ts, FLASH_CFG, NVM_SFR_RPAGE);
+
+	hideep_pgm_r_reg(ts, 0x0000000C, &unmask_code);
+
+	hideep_pgm_w_reg(ts, FLASH_CFG, NVM_DEFAULT_PAGE);
+
+	/* make it unprotected code */
+	unmask_code &= (~_PROT_MODE);
+
+	/* compare unmask code */
+	if (unmask_code != ts->nvm_mask)
+		dev_dbg(&ts->client->dev, "read mask code different 0x%x",
+			unmask_code);
+
+	hideep_pgm_w_reg(ts, FLASH_CFG, NVM_SFR_WPAGE);
+	SET_FLASH_PIO(0);
+
+	NVM_W_SFR(NVM_MASK_OFS, ts->nvm_mask);
+	SET_FLASH_HWCONTROL();
+	hideep_pgm_w_reg(ts, FLASH_CFG, NVM_DEFAULT_PAGE);
+}
+
+static int hideep_program_page(struct hideep_ts *ts,
+	unsigned int addr, struct pgm_packet *packet_w)
+{
+	int ret = 0;
+	unsigned int pio_cmd = WRONLY;
+	unsigned int pio_cmd_page_erase = PERASE;
+	unsigned int status;
+	int time_out = 0;
+	unsigned int end_flag = 124;
+
+	hideep_pgm_r_reg(ts, FLASH_STA, &status);
+	ret = (status == 0) ? -1:0;
+
+	addr = addr & ~(NVM_PAGE_SIZE - 1);
+
+	SET_FLASH_PIO(0);
+	SET_FLASH_PIO(1);
+
+	/* first erase */
+	SET_PIO_SIG(pio_cmd_page_erase  + addr, 0xFFFFFFFF);
+
+	SET_FLASH_PIO(0);
+	time_out = 0;
+
+	while (1) {
+		mdelay(1);
+		hideep_pgm_r_reg(ts, FLASH_STA, &status);
+		if ((status) != 0)
+			break;
+		if (time_out++ > 100)
+			break;
+	}
+	SET_FLASH_PIO(1);
+	/* first erase end*/
+
+	SET_PIO_SIG(pio_cmd + addr, get_unaligned_be32(&packet_w->payload[0]));
+
+	hideep_pgm_w_mem(ts, (FLASH_BASE + 0x400000) + pio_cmd,
+		packet_w, NVM_PAGE_SIZE);
+
+	SET_PIO_SIG(end_flag, get_unaligned_be32(&packet_w->payload[31]));
+
+	SET_FLASH_PIO(0);
+
+	mdelay(1);
+
+	while (1) {
+		hideep_pgm_r_reg(ts, FLASH_STA, &status);
+		if ((status) != 0)
+			break;
+	}
+	/* write routine end */
+
+	SET_FLASH_HWCONTROL();
+
+	return ret;
+}
+
+static int hideep_program_nvm(struct hideep_ts *ts, const unsigned char *ucode,
+	int len, int offset, unsigned char *old_fw)
+{
+	int i;
+	int ret = 0;
+	int len_r;
+	int len_w;
+	int addr = 0;
+	unsigned int pages;
+
+	struct pgm_packet packet_w;
+
+	ret = hideep_enter_pgm(ts);
+
+	hideep_nvm_unlock(ts);
+
+	pages = (len + NVM_PAGE_SIZE - 1) / NVM_PAGE_SIZE;
+	addr = offset;
+	len_r = len;
+	len_w = len_r;
+
+	dev_dbg(&ts->client->dev, "pages : %d", pages);
+	for (i = 0; i < pages; i++) {
+		if (len_r >= NVM_PAGE_SIZE)
+			len_w = NVM_PAGE_SIZE;
+
+		/* compare */
+		if (old_fw != NULL)
+			ret = memcmp(&ucode[addr], &old_fw[addr], len_w);
+
+		if (ret != 0 || old_fw == NULL) {
+			/* write page */
+			memcpy(packet_w.payload, &(ucode[addr]), len_w);
+
+			ret = hideep_program_page(ts, addr, &packet_w);
+			mdelay(1);
+			if (ret < 0)
+				dev_err(&ts->client->dev,
+					"hideep_program_nvm : error(%08x):",
+					addr);
+		}
+
+		addr += NVM_PAGE_SIZE;
+		len_r -= NVM_PAGE_SIZE;
+		len_w = len_r;
+	}
+
+	return ret;
+}
+
+static int hideep_verify_nvm(struct hideep_ts *ts, const unsigned char *ucode,
+	int len, int offset)
+{
+	int i, j;
+	int ret = 0;
+	unsigned char page_chk = 0;
+	unsigned int addr = offset;
+	unsigned int pages = (len + NVM_PAGE_SIZE - 1) / NVM_PAGE_SIZE;
+	int len_r = len;
+	int len_v = len_r;
+
+	struct pgm_packet packet_r;
+
+	for (i = 0; i < pages; i++) {
+		if (len_r >= NVM_PAGE_SIZE)
+			len_v = NVM_PAGE_SIZE;
+
+		hideep_pgm_r_mem(ts, 0x00000000 + addr, &packet_r,
+			NVM_PAGE_SIZE);
+
+		page_chk = memcmp(&(ucode[addr]), packet_r.payload, len_v);
+
+		if (page_chk != 0) {
+			u8 *read = (u8 *)packet_r.payload;
+
+			for (j = 0; j < NVM_PAGE_SIZE; j++)
+				dev_err(&ts->client->dev, "%02x : %02x",
+						ucode[addr+j], read[j]);
+
+			dev_err(&ts->client->dev, "verify : error(addr : %d)",
+				addr);
+
+			ret = -1;
+		}
+
+		addr += NVM_PAGE_SIZE;
+		len_r -= NVM_PAGE_SIZE;
+		len_v = len_r;
+	}
+
+	return ret;
+}
+
+static void hideep_read_nvm(struct hideep_ts *ts, unsigned char *data, int len,
+	int offset)
+{
+	int ret = 0;
+	int pages, i;
+	int len_r, len_v;
+	int addr = offset;
+
+	struct pgm_packet packet_r;
+
+	pages = (len + NVM_PAGE_SIZE - 1) / NVM_PAGE_SIZE;
+	len_r = len;
+	len_v = len_r;
+
+	hideep_reset_ic(ts);
+
+	ret = hideep_enter_pgm(ts);
+
+	hideep_nvm_unlock(ts);
+
+	for (i = 0; i < pages; i++) {
+		if (len_r >= NVM_PAGE_SIZE)
+			len_v = NVM_PAGE_SIZE;
+
+		hideep_pgm_r_mem(ts, 0x00000000 + addr, &packet_r,
+			NVM_PAGE_SIZE);
+
+		memcpy(&(data[i * NVM_PAGE_SIZE]), &packet_r.payload[0], len_v);
+
+		addr += NVM_PAGE_SIZE;
+		len_r -= NVM_PAGE_SIZE;
+		len_v = len_r;
+	}
+
+	hideep_sw_reset(ts, 1000);
+}
+
+static int hideep_fw_verify_run(struct hideep_ts *ts, unsigned char *fw,
+	size_t len, int offset)
+{
+	int ret = 0;
+	int retry = 3;
+
+	while (retry--) {
+		ret = hideep_verify_nvm(ts, fw, len, offset);
+		if (ret == 0) {
+			dev_dbg(&ts->client->dev, "update success");
+			break;
+		}
+		dev_err(&ts->client->dev, "download fw failed(%d)", retry);
+	}
+
+	ret = (retry == 0) ? -1:0;
+
+	return ret;
+}
+
+static int hideep_wr_firmware(struct hideep_ts *ts, unsigned char *code,
+	int len, int offset, bool mode)
+{
+	int ret = 0;
+	int firm_len;
+	unsigned char *ic_fw;
+	unsigned char *dwz_info;
+
+	ic_fw = kmalloc(ts->fw_size, GFP_KERNEL);
+	dwz_info = kmalloc(sizeof(struct dwz_info) + 64, GFP_KERNEL);
+
+	memset(dwz_info, 0x0, sizeof(struct dwz_info) + 64);
+
+	firm_len = len;
+	dev_dbg(&ts->client->dev, "fw len : %d, define size : %d",
+		firm_len, ts->fw_size);
+
+	if (firm_len > ts->fw_size)
+		firm_len = ts->fw_size;
+
+	dev_dbg(&ts->client->dev, "enter");
+	/* memory dump of target IC */
+	hideep_read_nvm(ts, ic_fw, firm_len, offset);
+	/* comparing & programming each page, if the memory of specified
+	 * page is exactly same, no need to update.
+	 */
+	ret = hideep_program_nvm(ts, code, firm_len, offset, ic_fw);
+
+	hideep_fw_verify_run(ts, code, firm_len, offset);
+	if (ret < 0) {
+		if (mode == true) {
+			/* clear dwz version, it will be store once again
+			 * after update success
+			 */
+			ts->dwz_info.release_ver = 0;
+			memcpy(&dwz_info[64], &ts->dwz_info,
+				sizeof(struct dwz_info));
+			ret = hideep_program_nvm(ts, dwz_info, HIDEEP_DWZ_LEN,
+				0x280, NULL);
+		}
+	}
+
+	get_dwz_from_binary(code, &ts->dwz_info);
+
+	hideep_sw_reset(ts, 1000);
+
+	kfree(ic_fw);
+	kfree(dwz_info);
+
+	return ret;
+}
+
+static int hideep_update_firmware(struct hideep_ts *ts, const char *fn)
+{
+	int ret = 0;
+	const struct firmware *fw_entry;
+	unsigned char *fw_buf;
+	unsigned int fw_length;
+
+	dev_dbg(&ts->client->dev, "enter");
+	ret = request_firmware(&fw_entry, fn, &ts->client->dev);
+
+	if (ret != 0) {
+		dev_err(&ts->client->dev, "request_firmware : fail(%d)", ret);
+		return ret;
+	}
+
+	fw_buf = (unsigned char *)fw_entry->data;
+	fw_length = (unsigned int)fw_entry->size;
+
+	/* chip specific code for flash fuse */
+	mutex_lock(&ts->dev_mutex);
+
+	ts->dev_state = state_updating;
+
+	ret = hideep_wr_firmware(ts, fw_buf, fw_length, 0, true);
+
+	ts->dev_state = state_normal;
+
+	mutex_unlock(&ts->dev_mutex);
+
+	release_firmware(fw_entry);
+
+	return ret;
+}
+
+static int hideep_load_dwz(struct hideep_ts *ts)
+{
+	int ret = 0;
+	struct pgm_packet packet_r;
+
+	ret = hideep_enter_pgm(ts);
+	if (ret < 0)
+		return ret;
+
+	mdelay(50);
+
+	ret = hideep_pgm_r_mem(ts, HIDEEP_DWZ_INFO_OFS, &packet_r,
+		sizeof(struct dwz_info));
+
+	memcpy(&ts->dwz_info, packet_r.payload,
+		sizeof(struct dwz_info));
+	hideep_sw_reset(ts, 10);
+
+	if (get_unaligned_le16(&ts->dwz_info.product_code) & 0x40) {
+		/* Crimson IC */
+		ts->fw_size = 1024 * 48;
+		ts->nvm_mask = 0x00310000;
+	} else {
+		/* Lime fw size */
+		ts->fw_size = 1024 * 64;
+		ts->nvm_mask = 0x0030027B;
+	}
+
+	dev_dbg(&ts->client->dev, "firmware release version : %04x",
+		get_unaligned_le16(&ts->dwz_info.release_ver));
+
+	mdelay(50);
+
+	return ret;
+}
+
+static int hideep_i2c_read(struct hideep_ts *ts, unsigned short addr,
+	unsigned short len, unsigned char *buf)
+{
+	int ret = -1;
+	unsigned short r_len, raddr;
+	int length;
+
+	length = len;
+	raddr = addr;
+
+	dev_dbg(&ts->client->dev, "addr = 0x%02x, len = %d", addr, len);
+
+	mutex_lock(&ts->i2c_mutex);
+
+	do {
+		if (length > MAX_I2C_BUFFER_SIZE)
+			r_len = MAX_I2C_BUFFER_SIZE;
+		else
+			r_len = length;
+
+		dev_dbg(&ts->client->dev, "addr = 0x%02x, len = %d",
+			raddr, r_len);
+
+		ret = i2c_master_send(ts->client, (char *)&raddr, 2);
+
+		if (ret < 0)
+			goto i2c_err;
+
+		ret = i2c_master_recv(ts->client, (char *)buf, r_len);
+		length -= MAX_I2C_BUFFER_SIZE;
+		buf += MAX_I2C_BUFFER_SIZE;
+		raddr += MAX_I2C_BUFFER_SIZE;
+
+		if (ret < 0)
+			goto i2c_err;
+	} while (length > 0);
+
+	mutex_unlock(&ts->i2c_mutex);
+
+	return  0;
+i2c_err:
+	mutex_unlock(&ts->i2c_mutex);
+	return -1;
+}
+
+static int hideep_i2c_write(struct hideep_ts *ts, unsigned short addr,
+	unsigned short len, unsigned char *buf)
+{
+	int ret = -1;
+	unsigned char data[len + 2];
+
+	dev_dbg(&ts->client->dev, "addr = 0x%02x, len = %d", addr, len);
+
+	mutex_lock(&ts->i2c_mutex);
+
+	// data mangling..
+	data[0] = (addr >> 0) & 0xFF;
+	data[1] = (addr >> 8) & 0xFF;
+	memcpy(&data[2], buf, len);
+
+	ret = i2c_master_send(ts->client, data, len + 2);
+
+	if (ret < 0)
+		goto i2c_err;
+
+	mutex_unlock(&ts->i2c_mutex);
+	return  0;
+
+i2c_err:
+	mutex_unlock(&ts->i2c_mutex);
+	return -1;
+}
+
+static void hideep_reset_ic(struct hideep_ts *ts)
+{
+	unsigned char cmd = 0x01;
+
+	if (!IS_ERR(ts->reset_gpio)) {
+		dev_dbg(&ts->client->dev, "hideep:enable the reset_gpio");
+		gpiod_set_value(ts->reset_gpio, 0);
+		mdelay(20);
+		gpiod_set_value(ts->reset_gpio, 1);
+	} else {
+		hideep_i2c_write(ts, HIDEEP_RESET_CMD, 1, &cmd);
+	}
+	mdelay(50);
+}
+
+static int hideep_pwr_on(struct hideep_ts *ts)
+{
+	int ret = 0;
+
+	if (!IS_ERR(ts->vcc_vdd)) {
+		dev_dbg(&ts->client->dev, "hideep:vcc_vdd is enable");
+		ret = regulator_enable(ts->vcc_vdd);
+		if (ret)
+			dev_err(&ts->client->dev,
+				"Regulator vdd enable failed ret=%d", ret);
+	}
+	usleep_range(999, 1000);
+
+	if (!IS_ERR(ts->vcc_vid)) {
+		dev_dbg(&ts->client->dev, "hideep:vcc_vid is enable");
+		ret = regulator_enable(ts->vcc_vid);
+		if (ret)
+			dev_err(&ts->client->dev,
+				"Regulator vcc_vid enable failed ret=%d", ret);
+	}
+	usleep_range(2999, 3000);
+
+	return ret;
+}
+
+static void hideep_pwr_off(void *data)
+{
+	struct hideep_ts *ts = data;
+
+	if (!IS_ERR(ts->reset_gpio))
+		gpiod_set_value(ts->reset_gpio, 0);
+
+	if (!IS_ERR(ts->vcc_vid))
+		regulator_disable(ts->vcc_vid);
+
+	if (!IS_ERR(ts->vcc_vdd))
+		regulator_disable(ts->vcc_vdd);
+}
+
+#define __GET_MT_TOOL_TYPE(X) ((X == 0x01) ? MT_TOOL_FINGER : MT_TOOL_PEN)
+
+static void pops_mt(struct hideep_ts *ts)
+{
+	int id;
+	int i;
+	int offset = sizeof(struct hideep_event);
+	struct hideep_event *event;
+
+	for (i = 0; i < ts->tch_count; i++) {
+		event = (struct hideep_event *)&ts->touch_event[i * offset];
+		id = (event->index >> 0) & 0x0F;
+		input_mt_slot(ts->input_dev, id);
+		input_mt_report_slot_state(ts->input_dev,
+			__GET_MT_TOOL_TYPE(event->type), false);
+		input_report_key(ts->input_dev, BTN_TOUCH, false);
+	}
+}
+
+static void push_mt(struct hideep_ts *ts)
+{
+	int id;
+	int i;
+	bool btn_up = 0;
+	bool btn_dn = 0;
+	bool btn_mv = 0;
+	int evt = 0;
+	int offset = sizeof(struct hideep_event);
+	struct hideep_event *event;
+
+	/* load multi-touch event to input system */
+	for (i = 0; i < ts->tch_count; i++) {
+		event = (struct hideep_event *)&ts->touch_event[i * offset];
+		id = (event->index >> 0) & 0x0F;
+		btn_up = (event->flag >> HIDEEP_MT_RELEASED) & 0x01;
+		btn_dn = (event->flag >> HIDEEP_MT_FIRST_CONTACT)
+			& 0x01;
+		btn_mv = (event->flag >> HIDEEP_MT_DRAG_MOVE) & 0x01;
+
+		if (btn_up)
+			clear_bit(id, &ts->tch_bit);
+		else
+			__set_bit(id, &ts->tch_bit);
+
+		dev_dbg(&ts->client->dev,
+			"type = %d, id = %d, i = %d, x = %d, y = %d, z = %d",
+			event->type, event->index, i,
+			get_unaligned_le16(&event->x),
+			get_unaligned_le16(&event->y),
+			get_unaligned_le16(&event->z));
+
+		input_mt_slot(ts->input_dev, id);
+		input_mt_report_slot_state(ts->input_dev,
+			__GET_MT_TOOL_TYPE(event->type),
+			(btn_up == 0));
+
+		if (btn_up == 0) {
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
+				get_unaligned_le16(&event->x));
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
+				get_unaligned_le16(&event->y));
+			input_report_abs(ts->input_dev, ABS_MT_PRESSURE,
+				get_unaligned_le16(&event->z));
+			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+				event->w);
+			evt++;
+		}
+	}
+
+	if (ts->tch_bit == 0)
+		evt = 0;
+
+	input_report_key(ts->input_dev, BTN_TOUCH, evt);
+	input_mt_sync_frame(ts->input_dev);
+}
+
+static void pops_ky(struct hideep_ts *ts)
+{
+	input_report_key(ts->input_dev, KEY_HOME, false);
+	input_report_key(ts->input_dev, KEY_MENU, false);
+	input_report_key(ts->input_dev, KEY_BACK, false);
+}
+
+static void push_ky(struct hideep_ts *ts)
+{
+	int i;
+	int pressed;
+	int key;
+	int status;
+	int code;
+
+	for (i = 0; i < ts->key_count; i++) {
+		key = ts->key_event[i + i * 2] & 0x0F;
+		status = ts->key_event[i + i * 2] & 0xF0;
+		code = 0;
+		pressed = false;
+
+		if (status & HIDEEP_KEY_PRESSED_MASK)
+			pressed = true;
+		else
+			pressed = false;
+
+		switch (key) {
+		case 0:
+			code = KEY_HOME;
+			break;
+		case 1:
+			code = KEY_MENU;
+			break;
+		case 2:
+			code = KEY_BACK;
+			break;
+		}
+		input_report_key(ts->input_dev, code, pressed);
+	}
+}
+
+static void hideep_put_event(struct hideep_ts *ts)
+{
+	/* mangling touch information */
+	if (ts->tch_count > 0)
+		push_mt(ts);
+
+	if (ts->key_count > 0)
+		push_ky(ts);
+
+	input_sync(ts->input_dev);
+}
+
+static int hideep_get_event(struct hideep_ts *ts)
+{
+	int ret;
+	int touch_count;
+	int event_size;
+
+	/* get touch event count */
+	dev_dbg(&ts->client->dev, "mt = %d, key = %d, lpm = %02x",
+		ts->tch_count, ts->key_count, ts->lpm_count);
+
+	/* get touch event information */
+	if (ts->tch_count > HIDEEP_MT_MAX)
+		ts->tch_count = 0;
+
+	if (ts->key_count > HIDEEP_KEY_MAX)
+		ts->key_count = 0;
+
+	touch_count = ts->tch_count + ts->key_count;
+
+	if (ts->tch_count > 0) {
+		event_size = ts->tch_count *
+			sizeof(struct hideep_event);
+		ret = hideep_i2c_read(ts, HIDEEP_TOUCH_DATA_ADDR,
+			event_size, ts->touch_event);
+
+		if (ret < 0) {
+			dev_err(&ts->client->dev, "read I2C error.");
+			return -1;
+		}
+	}
+
+	if (ts->key_count > 0) {
+		event_size = ts->key_count * 2;
+		ret = hideep_i2c_read(ts, HIDEEP_KEY_DATA_ADDR,
+			event_size, ts->key_event);
+		if (ret < 0) {
+			dev_err(&ts->client->dev, "read I2C error.");
+			return -1;
+		}
+	}
+
+	return touch_count;
+}
+
+static irqreturn_t hideep_irq_task(int irq, void *handle)
+{
+	unsigned char buff[2];
+	int ret;
+
+	struct hideep_ts *ts = (struct hideep_ts *) handle;
+
+	dev_dbg(&ts->client->dev, "state = 0x%x", ts->dev_state);
+
+	if (ts->dev_state == state_normal) {
+		ret = hideep_i2c_read(ts, HIDEEP_EVENT_COUNT_ADDR,
+			2, buff);
+		if (ret < 0) {
+			disable_irq(ts->client->irq);
+			ts->interrupt_state = 0;
+			return IRQ_HANDLED;
+		}
+
+		ts->tch_count = buff[0];
+		ts->key_count = buff[1] & 0x0f;
+		ts->lpm_count = buff[1] & 0xf0;
+
+		ret = hideep_get_event(ts);
+
+		if (ret >= 0)
+			hideep_put_event(ts);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int hideep_capability(struct hideep_ts *ts)
+{
+	int ret;
+
+	ts->input_dev->name = HIDEEP_TS_NAME;
+	ts->input_dev->id.bustype = BUS_I2C;
+
+	input_set_capability(ts->input_dev, EV_KEY, BTN_TOUCH);
+
+	if (ts->key_use) {
+		input_set_capability(ts->input_dev, EV_KEY, KEY_HOME);
+		input_set_capability(ts->input_dev, EV_KEY, KEY_MENU);
+		input_set_capability(ts->input_dev, EV_KEY, KEY_BACK);
+	}
+
+	input_set_abs_params(ts->input_dev, ABS_X, 0, ts->prop.max_x, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_Y, 0, ts->prop.max_y, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_PRESSURE, 0,
+		65535, 0, 0);
+
+	ret = input_mt_init_slots(ts->input_dev,
+		HIDEEP_MT_MAX, INPUT_MT_DIRECT);
+
+	if (ret)
+		return ret;
+
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_POSITION_X, 0, ts->prop.max_x, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_POSITION_Y, 0, ts->prop.max_y, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_PRESSURE, 0, 65535, 0, 0);
+	input_set_abs_params(ts->input_dev,
+		ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	return 0;
+}
+
+static void hideep_get_info(struct hideep_ts *ts)
+{
+	unsigned char val[4];
+
+	if (ts->prop.max_x == 0 || ts->prop.max_y == 0) {
+		hideep_i2c_read(ts, 0x28, 4, val);
+
+		ts->prop.max_x = get_unaligned_le16(&val[2]);
+		ts->prop.max_y = get_unaligned_le16(&val[0]);
+
+		dev_info(&ts->client->dev, "X : %d, Y : %d",
+			ts->prop.max_x, ts->prop.max_y);
+	}
+}
+
+static ssize_t hideep_update_fw(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct hideep_ts *ts = dev_get_drvdata(dev);
+	int mode, ret;
+	char *fw_name;
+
+	ret = kstrtoint(buf, 8, &mode);
+	if (ret)
+		return ret;
+
+	if (mode == 1) {
+		disable_irq(ts->client->irq);
+
+		ts->dev_state = state_updating;
+		fw_name = kasprintf(GFP_KERNEL, "hideep_ts_%04x.bin",
+			get_unaligned_le16(&ts->dwz_info.product_id));
+		ret = hideep_update_firmware(ts, fw_name);
+
+		kfree(fw_name);
+
+		enable_irq(ts->client->irq);
+
+		ts->dev_state = state_normal;
+		if (ret != 0)
+			dev_err(dev, "The firmware update failed(%d)", ret);
+	}
+
+	return count;
+}
+
+static ssize_t hideep_fw_version_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int len = 0;
+	struct hideep_ts *ts = dev_get_drvdata(dev);
+
+	dev_info(dev, "release version : %04x",
+		get_unaligned_le16(&ts->dwz_info.release_ver));
+
+	mutex_lock(&ts->dev_mutex);
+	len = scnprintf(buf, PAGE_SIZE,
+		"%04x\n", get_unaligned_le16(&ts->dwz_info.release_ver));
+	mutex_unlock(&ts->dev_mutex);
+
+	return len;
+}
+
+static ssize_t hideep_product_id_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int len = 0;
+	struct hideep_ts *ts = dev_get_drvdata(dev);
+
+	dev_info(dev, "product id : %04x",
+		get_unaligned_le16(&ts->dwz_info.product_id));
+
+	mutex_lock(&ts->dev_mutex);
+	len = scnprintf(buf, PAGE_SIZE,
+		"%04x\n", get_unaligned_le16(&ts->dwz_info.product_id));
+	mutex_unlock(&ts->dev_mutex);
+
+	return len;
+}
+
+static DEVICE_ATTR(version, 0664, hideep_fw_version_show, NULL);
+static DEVICE_ATTR(product_id, 0664, hideep_product_id_show, NULL);
+static DEVICE_ATTR(update_fw, 0664, NULL, hideep_update_fw);
+
+static struct attribute *hideep_ts_sysfs_entries[] = {
+	&dev_attr_version.attr,
+	&dev_attr_product_id.attr,
+	&dev_attr_update_fw.attr,
+	NULL,
+};
+
+static struct attribute_group hideep_ts_attr_group = {
+	.attrs = hideep_ts_sysfs_entries,
+};
+
+static int hideep_sysfs_init(struct hideep_ts *ts)
+{
+	int ret;
+	struct i2c_client *client = ts->client;
+
+	/* Create the files associated with this kobject */
+	ret = sysfs_create_group(&client->dev.kobj, &hideep_ts_attr_group);
+
+	dev_info(&ts->client->dev, "device : %s ", client->dev.kobj.name);
+
+	if (ret)
+		dev_err(&ts->client->dev, "%s: Fail create link error = %d\n",
+			 __func__, ret);
+
+	return ret;
+}
+
+static void hideep_sysfs_exit(void *data)
+{
+	struct hideep_ts *ts = data;
+
+	sysfs_remove_group(&ts->client->dev.kobj, &hideep_ts_attr_group);
+}
+
+static int __maybe_unused hideep_resume(struct device *dev)
+{
+	struct hideep_ts *ts = dev_get_drvdata(dev);
+	unsigned char sleep_cmd = 0x00;
+
+	mutex_lock(&ts->dev_mutex);
+
+	if (ts->dev_state == state_normal)
+		goto hideep_resume_exit;
+
+	dev_dbg(dev, "not waiting.");
+	ts->dev_state = state_normal;
+
+	hideep_i2c_write(ts, HIDEEP_SLEEP_CMD, 1, &sleep_cmd);
+	enable_irq(ts->client->irq);
+	ts->interrupt_state = 1;
+
+hideep_resume_exit:
+	mdelay(10);
+	hideep_reset_ic(ts);
+
+	mutex_unlock(&ts->dev_mutex);
+	return 0;
+}
+
+static int __maybe_unused hideep_suspend(struct device *dev)
+{
+	struct hideep_ts *ts = dev_get_drvdata(dev);
+	unsigned char sleep_cmd = 0x01;
+
+	mutex_lock(&ts->dev_mutex);
+	if (ts->dev_state == state_sleep)
+		goto hideep_suspend_exit;
+
+	dev_dbg(dev, "not waiting.");
+	ts->dev_state = state_sleep;
+
+	/* send sleep command.. */
+	pops_mt(ts);
+	if (ts->key_use)
+		pops_ky(ts);
+	input_sync(ts->input_dev);
+
+	/* default deep sleep */
+	hideep_i2c_write(ts, HIDEEP_SLEEP_CMD, 1, &sleep_cmd);
+	disable_irq(ts->client->irq);
+	ts->interrupt_state = 0;
+
+hideep_suspend_exit:
+	mutex_unlock(&ts->dev_mutex);
+	return 0;
+}
+
+
+#ifdef CONFIG_OF
+static int hideep_parse_dts(struct hideep_ts *ts)
+{
+	/* device tree information get */
+	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(pdata->reset_gpio))
+		return -EINVAL;
+
+	ts->vcc_vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(ts->vcc_vdd))
+		return -EINVAL;
+
+	ts->vcc_vid = devm_regulator_get(dev, "vid");
+	if (IS_ERR(ts->vcc_vid))
+		return -EINVAL;
+
+	ts->key_use = device_property_read_bool(&ts->client->dev,
+		"touchkey-use");
+
+	return 0;
+}
+#else
+static int hideep_parse_dts(struct hideep_ts *ts)
+{
+	return -EINVAL;
+}
+#endif
+
+static int hideep_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct hideep_ts *ts;
+
+	/* check i2c bus */
+	if (!i2c_check_functionality(client->adapter,
+		I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "check i2c device error");
+		return -ENODEV;
+	}
+
+	/* init hideep_ts */
+	ts = devm_kzalloc(&client->dev,
+		sizeof(struct hideep_ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+
+	if (client->dev.of_node) {
+		ret = hideep_parse_dts(ts);
+		if (ret)
+			return ret;
+	}
+
+	ts->client = client;
+
+	i2c_set_clientdata(client, ts);
+
+	mutex_init(&ts->i2c_mutex);
+	mutex_init(&ts->dev_mutex);
+
+	/* power on */
+	ret = hideep_pwr_on(ts);
+	if (ret) {
+		dev_err(&ts->client->dev, "power on failed");
+		return ret;
+	}
+
+	ret = devm_add_action(&ts->client->dev, hideep_pwr_off, ts);
+	if (ret) {
+		hideep_pwr_off(ts);
+		return ret;
+	}
+
+	ts->dev_state = state_init;
+	mdelay(30);
+
+	/* ic reset */
+	hideep_reset_ic(ts);
+
+	/* read info */
+	ret = hideep_load_dwz(ts);
+	if (ret < 0) {
+		dev_err(&client->dev, "fail to load dwz, ret = 0x%x", ret);
+		return ret;
+	}
+
+	/* init input device */
+	ts->input_dev = devm_input_allocate_device(&client->dev);
+	if (!ts->input_dev) {
+		dev_err(&client->dev, "can't allocate memory for input_dev");
+		return -ENOMEM;
+	}
+
+	touchscreen_parse_properties(ts->input_dev, true, &ts->prop);
+	hideep_get_info(ts);
+
+	ret = hideep_capability(ts);
+	if (ret) {
+		dev_err(&client->dev, "can't init input properties");
+		return ret;
+	}
+
+	ret = input_register_device(ts->input_dev);
+	if (ret) {
+		dev_err(&client->dev, "can't register input_dev");
+		return ret;
+	}
+
+	input_set_drvdata(ts->input_dev, ts);
+
+	dev_info(&ts->client->dev, "ts irq: %d", ts->client->irq);
+	if (IS_ERR(&ts->client->irq)) {
+		dev_err(&client->dev, "can't be assigned irq");
+		return -ENOMEM;
+	}
+
+	ret = devm_request_threaded_irq(&client->dev, ts->client->irq,
+		NULL, hideep_irq_task, IRQF_ONESHOT,
+		ts->client->name, ts);
+
+	disable_irq(ts->client->irq);
+	ts->interrupt_state = 0;
+
+	if (ret < 0) {
+		dev_err(&client->dev, "fail to get irq, ret = 0x%08x",
+			ret);
+		return ret;
+	}
+
+	ts->dev_state = state_normal;
+	enable_irq(ts->client->irq);
+	ts->interrupt_state = 1;
+
+	ret = hideep_sysfs_init(ts);
+	if (ret) {
+		dev_err(&client->dev, "fail init sys, ret = 0x%x", ret);
+		return ret;
+	}
+
+	ret = devm_add_action(&ts->client->dev, hideep_sysfs_exit, ts);
+	if (ret) {
+		hideep_sysfs_exit(ts);
+		return ret;
+	}
+
+	dev_info(&client->dev, "probe is ok!");
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static SIMPLE_DEV_PM_OPS(hideep_pm_ops, hideep_suspend, hideep_resume);
+#endif
+
+static const struct i2c_device_id hideep_dev_idtable[] = {
+	{ HIDEEP_I2C_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, hideep_dev_idtable);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hideep_acpi_id[] = {
+	{ "HIDP0001", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hideep_acpi_id);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id hideep_match_table[] = {
+	{ .compatible = "hideep,hideep-lime" },
+	{ .compatible = "hideep,hideep-crimson" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hideep_match_table);
+#endif
+
+static struct i2c_driver hideep_driver = {
+	.probe = hideep_probe,
+	.id_table = hideep_dev_idtable,
+	.driver = {
+		.name = HIDEEP_I2C_NAME,
+		.of_match_table = of_match_ptr(hideep_match_table),
+		.acpi_match_table = ACPI_PTR(hideep_acpi_id),
+		.pm = &hideep_pm_ops,
+	},
+};
+
+module_i2c_driver(hideep_driver);
+
+MODULE_DESCRIPTION("Driver for HiDeep Touchscreen Controller");
+MODULE_AUTHOR("anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/input/touchscreen/hideep_core.h b/drivers/input/touchscreen/hideep_core.h
new file mode 100644
index 0000000..be6f3da
--- /dev/null
+++ b/drivers/input/touchscreen/hideep_core.h
@@ -0,0 +1,221 @@
+/*
+ * Copyright (C) 2012-2017 Hideep, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foudation.
+ */
+
+#ifndef _LINUX_HIDEEP_CORE_H
+#define _LINUX_HIDEEP_CORE_H
+/*************************************************************************
+ * Buffer size
+ *************************************************************************/
+#define FRAME_HEADER_SIZE				8
+/* if size of system i2c buffer is smaller than this value, need to modify */
+#define MAX_I2C_BUFFER_SIZE				512
+
+/*************************************************************************
+ * board porting config
+ *************************************************************************/
+#define HIDEEP_TS_NAME					"HiDeep Touchscreen"
+#define HIDEEP_I2C_NAME					"hideep_ts"
+
+/*************************************************************************
+ * register addr
+ *************************************************************************/
+/* Touch & key event */
+#define HIDEEP_EVENT_COUNT_ADDR			0x240
+#define HIDEEP_TOUCH_DATA_ADDR			0x242
+#define HIDEEP_KEY_DATA_ADDR			0x2A6
+#define HIDEEP_RAW_DATA_ADDR			0x1000
+
+/* command list */
+#define HIDEEP_RESET_CMD				0x9800
+#define HIDEEP_INTCLR_CMD				0x9802
+#define HIDEEP_OPMODE_CMD				0x9804
+#define HIDEEP_SWTICH_CMD				0x9805
+#define HIDEEP_SLEEP_CMD				0x980D
+
+/*************************************************************************
+ * multi-touch & key definitions.
+ *************************************************************************/
+#define HIDEEP_MT_MAX					10
+#define HIDEEP_KEY_MAX					3
+
+/* multi touch event bit */
+#define HIDEEP_MT_ALWAYS_REPORT			0
+#define HIDEEP_MT_TOUCHED				1
+#define HIDEEP_MT_FIRST_CONTACT			2
+#define HIDEEP_MT_DRAG_MOVE				3
+#define HIDEEP_MT_RELEASED				4
+#define HIDEEP_MT_PINCH					5
+#define HIDEEP_MT_PRESSURE				6
+
+/* key event bit */
+#define HIDEEP_KEY_RELEASED				0x20
+#define HIDEEP_KEY_PRESSED				0x40
+#define HIDEEP_KEY_FIRST_PRESSED		0x80
+#define HIDEEP_KEY_PRESSED_MASK			0xC0
+
+/*************************************************************************
+ * HiDeep Event
+ *************************************************************************/
+struct hideep_event {
+	__le16 x;
+	__le16 y;
+	__le16 z;
+	unsigned char w;
+	unsigned char flag;
+	unsigned char type;
+	unsigned char index;
+} __packed;
+
+
+/*************************************************************************
+ * IC State
+ *************************************************************************/
+enum e_dev_state {
+	state_init = 1,
+	state_normal,
+	state_sleep,
+	state_updating,
+	state_debugging,
+};
+
+/*************************************************************************
+ * Firmware info
+ *************************************************************************/
+struct dwz_info {
+	__le32	code_start;
+	unsigned char code_crc[12];
+
+	__le32 c_code_start;
+	__le16 c_code_len;
+	__le16 gen_ver;
+
+	__le32 vr_start;
+	__le16 vr_len;
+	__le16 rsv0;
+
+	__le32 ft_start;
+	__le16 ft_len;
+	__le16 vr_version;
+
+	__le16 boot_ver;
+	__le16 core_ver;
+	__le16 custom_ver;
+	__le16 release_ver;
+
+	unsigned char factory_id;
+	unsigned char panel_type;
+	unsigned char model_name[6];
+	__le16 product_code;
+	__le16 extra_option;
+
+	__le16 product_id;
+	__le16 vendor_id;
+} __packed;
+
+struct hideep_ts {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+
+	struct touchscreen_properties prop;
+
+	struct gpio_desc *reset_gpio;
+
+	struct regulator *vcc_vdd;
+	struct regulator *vcc_vid;
+
+	struct mutex dev_mutex;
+	struct mutex i2c_mutex;
+
+	bool suspended;
+	enum e_dev_state dev_state;
+
+	long tch_bit;
+	unsigned int tch_count;
+	unsigned int key_count;
+	unsigned int lpm_count;
+
+	unsigned char touch_event[HIDEEP_MT_MAX * 10];
+	unsigned char key_event[HIDEEP_KEY_MAX * 2];
+	bool key_use;
+
+	struct dwz_info dwz_info;
+
+	int interrupt_state;
+	int fw_size;
+	int nvm_mask;
+} __packed;
+
+#define NVM_DEFAULT_PAGE		0
+#define NVM_SFR_WPAGE			1
+#define NVM_SFR_RPAGE			2
+
+#define PIO_SIG					0x00400000
+#define _PROT_MODE				0x03400000
+
+#define NVM_PAGE_SIZE			128
+
+#define HIDEEP_NVM_DOWNLOAD		0x10000000
+
+/*************************************************************************
+ * register map
+ *************************************************************************/
+#define YRAM_BASE				0x40000000
+#define PERIPHERAL_BASE			0x50000000
+#define ESI_BASE				(PERIPHERAL_BASE + 0x00000000)
+#define FLASH_BASE				(PERIPHERAL_BASE + 0x01000000)
+#define SYSCON_BASE				(PERIPHERAL_BASE + 0x02000000)
+
+#define SYSCON_MOD_CON			(SYSCON_BASE + 0x0000)
+#define SYSCON_SPC_CON			(SYSCON_BASE + 0x0004)
+#define SYSCON_CLK_CON			(SYSCON_BASE + 0x0008)
+#define SYSCON_CLK_ENA			(SYSCON_BASE + 0x000C)
+#define SYSCON_RST_CON			(SYSCON_BASE + 0x0010)
+#define SYSCON_WDT_CON			(SYSCON_BASE + 0x0014)
+#define SYSCON_WDT_CNT			(SYSCON_BASE + 0x0018)
+#define SYSCON_PWR_CON			(SYSCON_BASE + 0x0020)
+#define SYSCON_PGM_ID			(SYSCON_BASE + 0x00F4)
+
+#define FLASH_CON				(FLASH_BASE + 0x0000)
+#define FLASH_STA				(FLASH_BASE + 0x0004)
+#define FLASH_CFG				(FLASH_BASE + 0x0008)
+#define FLASH_TIM				(FLASH_BASE + 0x000C)
+#define FLASH_CACHE_CFG			(FLASH_BASE + 0x0010)
+
+#define ESI_TX_INVALID			(ESI_BASE + 0x0008)
+
+/*************************************************************************
+ * flash commands
+ *************************************************************************/
+#define MERASE					0x00010000
+#define SERASE					0x00020000
+#define PERASE					0x00040000
+#define PROG					0x00080000
+#define WRONLY					0x00100000
+
+#define NVM_MASK_OFS			0x0000000C
+
+/*************************************************************************
+ * DWZ info
+ *************************************************************************/
+#define HIDEEP_BOOT_SECTION		0x00000400
+#define HIDEEP_BOOT_LEN			0x00000400
+#define HIDEEP_DWZ_SECTION		0x00000280
+#define HIDEEP_DWZ_INFO_OFS		0x000002C0
+#define HIDEEP_DWZ_LEN			(HIDEEP_BOOT_SECTION \
+							- HIDEEP_DWZ_SECTION)
+
+struct pgm_packet {
+	union {
+		unsigned char b[8];
+		__be32 w[2];
+	} header;
+
+	__be32 payload[NVM_PAGE_SIZE / sizeof(unsigned int)];
+};
+
+#endif
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
