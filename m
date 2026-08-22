Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138738F92F
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434835; cv=none; b=sYc5xadcoSqK0hIsoeKslAlBQ13x7VWMQzYTIb4iRzauSNkSzjCxFbPu2cf2Ok0GTqizw7isr3L2g+ktzexPm12oeNZ4yriNKjxyj0bH7V1oSA98ePi2/PXkp+wVmDj+9zLCKkYgIwL24+064MovRj2kQpi8YXhxgMMvo6d47I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434835; c=relaxed/simple;
	bh=aD+HtX7tnz+ZeAsjCDqb4WQb1+koGa8J8vb951IkdCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBzr+EkzldzbBsxsr42xew9mLHOg35/upZtRQMvBBjkzKrY8vfXRhyGEs5uzLSAGr4Vmq0oSIyDud46fS0xaISr2nKNJaHqQAUxMWyIfM+lIvMeK5ZHvm7ZXP1Zqt+rp+y531YNTSQmH+zH+q8qMASOVydUxdRXYMBOZrxiRAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWBy7bDQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWBy7bDQ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2074710751so398417166b.1
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434826; x=1788039626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwHWguOsSrLzaE9O7187K9INJCM1brdEKh0/stGa2ZM=;
        b=JWBy7bDQmn+B6v/hRvno7toh4esvLJXh9Ta6lMzGW7vl/lj6waLrUXO2w152Ui5TqQ
         ZFVrtVaS2u8745Eb+vAEh2aKXuYSbfgVBgkK6Ob1RzzDVpgRYcjWvFJ7i/rdR+tGMjBM
         9ve+HskqCP3SV+n/LOjOqNm9tOErliX+hMzazPWbhk9R2i1ZANUYEj5af/6aPv90XJdZ
         TJZtv2ZO3bIZuht0NG084Xpl7CZRkdp8kz1GBx6Apa1kkyTGH0p+QsXsh6IJ9Q+BPUGK
         7GBSokN9SEOns5/BLVExhOD6AHwS/XEBxYhuiyPMntS1KezuELbVQfjiKMIE59LJJF1s
         lXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434826; x=1788039626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwHWguOsSrLzaE9O7187K9INJCM1brdEKh0/stGa2ZM=;
        b=JjNu+4b+sxGJBBD7WM+pOvi5toEE9lLpPBTgxmL/xTmszui/8SC1TiXP4M3zovGnoL
         YWzyS+vi9Wo+v6912FrqmLciFDio6VMjj0bkPeGZ99MK1mrZitUjX0D4YEccRaSwr9iH
         o6+Nnm470E58LG6ZBrO+aOxw47hMHWrsPuLeT+GVIJqCfy7BYT8/ylvF5Ph010L6Fa7r
         i1oIHiJh9N3gOQ3nCu8UV+inuHMQaoQtxCZpoIU/A4I4Fim6sWBXX6jJac81p24QKyLv
         s7wCXGmInSo6aybxMWBwfI5HRx1IRO5tGrJOkVxMIObNPo8+Y2AW1ADjMoa7IsZnFLOK
         fs/A==
X-Forwarded-Encrypted: i=1; AHgh+RqBH8Nkr+R6O8D3+Bpwu3qzO052gDAGb5+GNU7sh8CG/mioKEWqAdGN4RJn+nBBS/AFL8tuAgWtFmPGWA==@vger.kernel.org
X-Gm-Message-State: AFuF++lUxq/jRJk/1z6niVovBk8CvSJcRaHmxYWDAz3TRi1nOOUdAFas
	ML4z2SQEJNE4RqJj2ams10v/J3mXKeXBIcBIjFGkXhfmRH8Y4qVwiMzu
X-Gm-Gg: AR+sD12yvbpJXDRHh705nF2O3vZo4AGhzrnY8brbOd7rPcqLGOrCR3x30ZWduVG1lZ1
	YLM/UJI9Lab4T3pXYZ0hHG5VjBrqI5PLDSwahlot8e0wY/sA2c9kXT7fYW5/obpAtHj2+bEePa9
	jC7vcDNTMMI57RIwUsEUCaT2sdWjsMx9mNlLmDju9Tv+lechVDcIy2RfD2GBh06Gl01Gegm3TZq
	qijmuz180Z3mrxa4VBkwBYe+pw4iVicjADOgNp2pzwQPwXL6Uufo/59C+2wmXpkcT9teVxLZDL6
	xR78Z0HwYmbeEbYObdgrmJNhlgkeeE2EjfRXewEsVJd44iNCGCTq1GxQfksGVMjNrr9LCJuFGQm
	y237njGb5Qvr6F3MH1jhpEjHlxEgTjnMxq+EkCUObL07TEhvH/FWM7f+Ny4oZ1bDDpWW6ocLeK2
	5S/z2tFHWebszFo+8G+f0hgUALAAQoM9kYZTHUHdfyg04n3rOe6Us0QeCtFHM8tbq/SYXVKw==
X-Received: by 2002:a17:907:c8c7:b0:c24:680a:1c42 with SMTP id a640c23a62f3a-c2491c9a6eamr963194566b.7.1787434826382;
        Sat, 22 Aug 2026 14:40:26 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:25 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 02/13] HID: ft260: uart: bring-up fixes
Date: Sun, 23 Aug 2026 00:39:30 +0300
Message-ID: <20260822213941.98882-3-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the UART path so the serial interface added previously works
reliably in practice. This squashes the contiguous UART bring-up
fixes that followed the initial serial-driver addition.

The UART and I2C paths shared write_buf without proper separation,
so concurrent use could corrupt transfers on both channels. Give
UART its own TX buffer. The write request report is now built in
that fixed per-port buffer, so its payload member becomes a fixed
FT260_WR_UART_DATA_MAX (62) array rather than a __counted_by()
flexible array, which describes a runtime-counted allocation this
path no longer makes.

The FT260 enters power-save after ~5s idle, which drops RX data at
higher baud rates. Keep a timed dummy wakeup, but only when needed:
skip it below 4800 baud and when EEPROM disables power-save; wake
earlier before RX; avoid configuring baud or disabling the workaround
twice; and arm the timer when a tty session starts.

The received report length was validated against the actual HID report
size only on the I2C path. The UART path instead bounded the
device-supplied length against FT260_RD_DATA_MAX (180), which is the
maximum I2C read payload, not a bound on the report buffer. As a UART
payload cannot exceed FT260_WR_UART_DATA_MAX (62) bytes, a report
claiming more would make ft260_uart_receive_chars() push data past the
end of the report buffer into the tty flip buffer. Validate the length
against the received report size once, before dispatching on the report
type, and drop the two now-redundant FT260_RD_DATA_MAX checks.

Also fix RX data loss after reopening the device, improve TX
throughput, simplify HID interface-type detection, use kfifo_avail
for write-room, and ignore spurious UART interrupt status (0xb1)
reports instead of treating them as errors.

Also includes UART cleanup and refactoring to match the rest of the
driver style (including replacing kfifo_*_locked aliases with
kfifo_*_spinlocked).

This replaces the UART bring-up fix series:
https://lore.kernel.org/all/20240210215147.77629-1-michael.zaidman@gmail.com/

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 340 ++++++++++++++++++++++------------------
 1 file changed, 188 insertions(+), 152 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 3faedfc5c413..b6c408267a68 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * hid-ft260.c - FTDI FT260 USB HID to I2C host bridge
+ * FTDI FT260 USB HID to I2C/UART host bridge
  *
  * Copyright (c) 2021, Michael Zaidman <michaelz@xsightlabs.com>
  *
@@ -20,10 +20,6 @@
 #include <linux/minmax.h>
 #include <linux/unaligned.h>
 
-#define UART_COUNT_MAX		4	/* Number of UARTs this driver can handle */
-#define FIFO_SIZE	256
-#define TTY_WAKEUP_WATERMARK	(FIFO_SIZE / 2)
-
 #ifdef DEBUG
 static int ft260_debug = 1;
 #else
@@ -38,9 +34,12 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 			pr_info("%s: " format, __func__, ##arg);	  \
 	} while (0)
 
-#define FT260_REPORT_MAX_LENGTH (64)
-#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
-#define FT260_UART_DATA_REPORT_ID(len) (FT260_UART_REPORT_MIN + (len - 1) / 4)
+#define FT260_REPORT_MAX_LEN (64)
+#define FT260_DATA_REPORT_ID(min, len) (min + (len - 1) / 4)
+#define FT260_I2C_DATA_REPORT_ID(len) \
+		FT260_DATA_REPORT_ID(FT260_I2C_REPORT_MIN, len)
+#define FT260_UART_DATA_REPORT_ID(len) \
+		FT260_DATA_REPORT_ID(FT260_UART_REPORT_MIN, len)
 
 #define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
 
@@ -56,7 +55,8 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
  * read payload length to be 180 bytes.
  */
 #define FT260_RD_DATA_MAX (180)
-#define FT260_WR_DATA_MAX (60)
+#define FT260_WR_I2C_DATA_MAX (60)
+#define FT260_WR_UART_DATA_MAX (62)
 
 /*
  * Device interface configuration.
@@ -90,7 +90,7 @@ enum {
 	FT260_I2C_REPORT_MAX		= 0xDE,
 	FT260_GPIO			= 0xB0,
 	FT260_UART_INTERRUPT_STATUS	= 0xB1,
-	FT260_UART_STATUS		= 0xE0,
+	FT260_UART_SETTINGS		= 0xE0,
 	FT260_UART_RI_DCD_STATUS	= 0xE1,
 	FT260_UART_REPORT_MIN		= 0xF0,
 	FT260_UART_REPORT_MAX		= 0xFE,
@@ -144,7 +144,7 @@ enum {
 	FT260_FLAG_START_STOP_REPEATED	= 0x07,
 };
 
-/* Return values for ft260_get_interface_type func */
+/* USB interface type values */
 enum {
 	FT260_IFACE_NONE,
 	FT260_IFACE_I2C,
@@ -190,6 +190,18 @@ struct ft260_get_i2c_status_report {
 	u8 reserved;
 } __packed;
 
+struct ft260_get_uart_settings_report {
+	u8 report;		/* FT260_UART_SETTINGS */
+	u8 flow_ctrl;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
+				/* 3 - XON_XOFF, 4 - No flow control */
+	/* The baudrate field is unaligned */
+	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
+	u8 data_bit;		/* 7 or 8 */
+	u8 parity;		/* 0: no parity, 1: odd, 2: even, 3: high, 4: low */
+	u8 stop_bit;		/* 0: one stop bit, 2: 2 stop bits */
+	u8 breaking;		/* 0: no break */
+} __packed;
+
 /* Feature Out reports */
 
 struct ft260_set_system_clock_report {
@@ -229,7 +241,7 @@ struct ft260_i2c_write_request_report {
 	u8 address;		/* 7-bit I2C address */
 	u8 flag;		/* I2C transaction condition */
 	u8 length;		/* data payload length */
-	u8 data[FT260_WR_DATA_MAX]; /* data payload */
+	u8 data[FT260_WR_I2C_DATA_MAX]; /* data payload */
 } __packed;
 
 struct ft260_i2c_read_request_report {
@@ -246,18 +258,19 @@ struct ft260_input_report {
 } __packed;
 
 /* UART reports */
+
 struct ft260_uart_write_request_report {
 	u8 report;		/* FT260_UART_REPORT */
 	u8 length;		/* data payload length */
-	u8 data[] __counted_by(length);	/* variable data payload */
+	u8 data[FT260_WR_UART_DATA_MAX]; /* data payload */
 } __packed;
 
-struct ft260_configure_uart_request {
+struct ft260_configure_uart_request_report {
 	u8 report;		/* FT260_SYSTEM_SETTINGS */
 	u8 request;		/* FT260_SET_UART_CONFIG */
 	u8 flow_ctrl;		/* 0: OFF, 1: RTS_CTS, 2: DTR_DSR */
 				/* 3: XON_XOFF, 4: No flow ctrl */
-	/* The baudrate field is unaligned: */
+	/* The baudrate field is unaligned */
 	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
 	u8 data_bit;		/* 7 or 8 */
 	u8 parity;		/* 0: no parity, 1: odd, 2: even, 3: high, 4: low */
@@ -292,6 +305,11 @@ enum {
 	FT260_CFG_BAUD_MAX		= 12000000,
 };
 
+#define FT260_UART_EN_PW_SAVE_BAUD	(4800)
+
+#define UART_COUNT_MAX (4) /* Number of supported UARTs */
+#define XMIT_FIFO_SIZE (PAGE_SIZE)
+
 static const struct hid_device_id ft260_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
 			 USB_DEVICE_ID_FT260) },
@@ -302,26 +320,22 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
-
-	bool ft260_is_serial;
+	int iface_type;
 	struct list_head device_list;
-
-	/* tty_port lifetime is equal to device lifetime */
 	struct tty_port port;
+	/* tty port index */
 	unsigned int index;
 	struct kfifo xmit_fifo;
-	/* write_lock: lock to serialize access to xmit fifo */
-	spinlock_t write_lock;
+	spinlock_t xmit_fifo_lock;
 	struct uart_icount icount;
-
 	struct timer_list wakeup_timer;
 	struct work_struct wakeup_work;
 	bool reschedule_work;
-
-
+	bool power_saving_en;
 	struct completion wait;
 	struct mutex lock;
-	u8 write_buf[FT260_REPORT_MAX_LENGTH];
+	u8 i2c_wr_buf[FT260_REPORT_MAX_LEN];
+	u8 uart_wr_buf[FT260_REPORT_MAX_LEN];
 	unsigned long need_wakeup_at;
 	/* Protects read_buf, read_idx and read_len against ft260_raw_event() */
 	spinlock_t read_lock;
@@ -332,8 +346,7 @@ struct ft260_device {
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
-					unsigned char report_id, u8 *data,
-					size_t len)
+					u8 report_id, u8 *data, size_t len)
 {
 	u8 *buf;
 	int ret;
@@ -462,8 +475,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
-		hid_dbg(hdev, "%s: failed to start transfer, ret %d\n",
-			__func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -505,7 +516,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	int ret, wr_len, idx = 0;
 	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (len < 1)
 		return -EINVAL;
@@ -513,12 +524,12 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	rep->flag = FT260_FLAG_START;
 
 	do {
-		if (len <= FT260_WR_DATA_MAX) {
+		if (len <= FT260_WR_I2C_DATA_MAX) {
 			wr_len = len;
 			if (flag == FT260_FLAG_START_STOP)
 				rep->flag |= FT260_FLAG_STOP;
 		} else {
-			wr_len = FT260_WR_DATA_MAX;
+			wr_len = FT260_WR_I2C_DATA_MAX;
 		}
 
 		rep->report = FT260_I2C_DATA_REPORT_ID(wr_len);
@@ -554,7 +565,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (data_len >= sizeof(rep->data))
 		return -EINVAL;
@@ -574,6 +585,8 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 		  rep->report, addr, cmd, rep->length, len);
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	if (ret < 0)
+		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
 
 	return ret;
 }
@@ -692,8 +705,7 @@ static int ft260_i2c_write_read(struct ft260_device *dev, struct i2c_msg *msgs)
 		else
 			read_off = *msgs[0].buf;
 
-		ft260_dbg("%s: off %#x rlen %d wlen %d\n", __func__,
-			read_off, rd_len, wr_len);
+		ft260_dbg("off %#x rlen %d wlen %d\n", read_off, rd_len, wr_len);
 	}
 
 	ret = ft260_i2c_write(dev, addr, msgs[0].buf, wr_len,
@@ -926,27 +938,25 @@ static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device
 	ft260_dbg("i2c_enable: 0x%02x\n", cfg.i2c_enable);
 	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
 
-	dev->ft260_is_serial = false;
+	dev->power_saving_en = cfg.power_saving_en;
 
 	switch (cfg.chip_mode) {
 	case FT260_MODE_ALL:
 	case FT260_MODE_BOTH:
-		if (interface == 1) {
+		if (interface == 1)
 			ret = FT260_IFACE_UART;
-			dev->ft260_is_serial = true;
-		} else {
+		else
 			ret = FT260_IFACE_I2C;
-		}
 		break;
 	case FT260_MODE_UART:
 		ret = FT260_IFACE_UART;
-		dev->ft260_is_serial = true;
 		break;
 	case FT260_MODE_I2C:
 		ret = FT260_IFACE_I2C;
 		break;
 	}
 
+	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1090,12 +1100,36 @@ static const struct attribute_group ft260_attr_group = {
 	}
 };
 
-/***
- * START Serial dev part
- */
 static DEFINE_MUTEX(ft260_uart_list_lock);
 static LIST_HEAD(ft260_uart_device_list);
 
+static void ft260_uart_wakeup(struct ft260_device *dev);
+
+static int ft260_get_uart_settings(struct hid_device *hdev,
+				   struct ft260_get_uart_settings_report *cfg)
+{
+	int ret;
+	int len = sizeof(struct ft260_get_uart_settings_report);
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_UART_SETTINGS,
+					   (u8 *)cfg, len);
+	if (ret < 0) {
+		hid_err(hdev, "failed to retrieve uart settings\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void ft260_uart_wakeup_workaraund_enable(struct ft260_device *port,
+						bool enable)
+{
+	if (port->power_saving_en) {
+		port->reschedule_work = enable;
+		ft260_dbg("%s wakeup workaround",
+			  enable ? "activate" : "deactivate");
+	}
+}
+
 static struct ft260_device *ft260_dev_by_index(int index)
 {
 	struct ft260_device *port;
@@ -1112,8 +1146,8 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	int index = 0, ret = 0;
 	struct ft260_device *dev;
 
-	spin_lock_init(&port->write_lock);
-	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
+	spin_lock_init(&port->xmit_fifo_lock);
+	if (kfifo_alloc(&port->xmit_fifo, XMIT_FIFO_SIZE, GFP_KERNEL))
 		return -ENOMEM;
 
 	mutex_lock(&ft260_uart_list_lock);
@@ -1143,19 +1177,18 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 	list_del(&port->device_list);
 	mutex_unlock(&ft260_uart_list_lock);
 
-	spin_lock(&port->write_lock);
+	spin_lock(&port->xmit_fifo_lock);
 	kfifo_free(&port->xmit_fifo);
-	spin_unlock(&port->write_lock);
+	spin_unlock(&port->xmit_fifo_lock);
 
 	mutex_lock(&port->port.mutex);
-	port->reschedule_work = false;
 	tty_port_tty_hangup(&port->port, false);
 	mutex_unlock(&port->port.mutex);
 
 	ft260_uart_port_put(port);
 }
 
-static struct ft260_device *ft260_uart_port_get(unsigned int index)
+static struct ft260_device *ft260_uart_port_get(int index)
 {
 	struct ft260_device *port;
 
@@ -1211,30 +1244,24 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 		goto tty_out;
 	}
 
-	rep = (struct ft260_uart_write_request_report *)port->write_buf;
+	rep = (struct ft260_uart_write_request_report *)port->uart_wr_buf;
 
 	do {
-		len = min(data_len, FT260_WR_DATA_MAX);
+		len = min(data_len, FT260_WR_UART_DATA_MAX);
 
 		rep->report = FT260_UART_DATA_REPORT_ID(len);
 		rep->length = len;
 
-		len = kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
+		len = kfifo_out_spinlocked(xmit, rep->data, len, &port->xmit_fifo_lock);
 
-		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
-		if (ret < 0) {
-			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
+		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + 2);
+		if (ret < 0)
 			goto tty_out;
-		}
 
 		data_len -= len;
 		port->icount.tx += len;
 	} while (data_len > 0);
 
-	len = kfifo_len(xmit);
-	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
-		tty_wakeup(tty);
-
 	ret = 0;
 
 tty_out:
@@ -1242,20 +1269,14 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 	return ret;
 }
 
-static int ft260_uart_receive_chars(struct ft260_device *port,
-				    u8 *data, u8 length)
+static int ft260_uart_receive_chars(struct ft260_device *port, u8 *data, u8 length)
 {
-	struct hid_device *hdev = port->hdev;
-	int ret = 0;
-
-	if (length > FT260_RD_DATA_MAX) {
-		hid_err(hdev, "Received too much data (%d)\n", length);
-		return -EBADR;
-	}
+	int ret;
 
 	ret = tty_insert_flip_string(&port->port, data, length);
 	if (ret != length)
-		hid_err(hdev, "%d char not inserted to flip buffer\n", length - ret);
+		ft260_dbg("%d char not inserted to flip buf\n", length - ret);
+
 	port->icount.rx += ret;
 
 	if (ret)
@@ -1265,26 +1286,26 @@ static int ft260_uart_receive_chars(struct ft260_device *port,
 }
 
 static ssize_t ft260_uart_write(struct tty_struct *tty, const u8 *buf,
-				 size_t count)
+				 size_t cnt)
 {
 	struct ft260_device *port = tty->driver_data;
-	struct hid_device *hdev = port->hdev;
-	int len, ret;
+	ssize_t len, ret, diff;
 
-	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
-	ft260_dbg("count: %zu, len: %d", count, len);
+	len = kfifo_in_spinlocked(&port->xmit_fifo, buf, cnt,
+				  &port->xmit_fifo_lock);
+	ft260_dbg("count: %zu, len: %zd", cnt, len);
 
 	ret = ft260_uart_transmit_chars(port);
 	if (ret < 0) {
-		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
+		ft260_dbg("failed to transmit %zd\n", ret);
 		return 0;
 	}
 
 	ret = kfifo_len(&port->xmit_fifo);
 	if (ret > 0) {
-		hid_dbg(hdev, "Failed to  all kfifo data bytes\n");
-		ft260_dbg("return: %d", len - ret);
-		return len - ret;
+		diff = len - ret;
+		ft260_dbg("failed to send %zd out of %zd bytes\n", diff, len);
+		return diff;
 	}
 
 	return len;
@@ -1294,7 +1315,7 @@ static unsigned int ft260_uart_write_room(struct tty_struct *tty)
 {
 	struct ft260_device *port = tty->driver_data;
 
-	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
+	return kfifo_avail(&port->xmit_fifo);
 }
 
 static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
@@ -1310,7 +1331,8 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 {
 	struct hid_device *hdev = port->hdev;
 	unsigned int baud;
-	struct ft260_configure_uart_request req;
+	struct ft260_configure_uart_request_report req;
+	bool wakeup_workaraund = false;
 	int ret;
 
 	memset(&req, 0, sizeof(req));
@@ -1324,7 +1346,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		break;
 	case CS5:
 	case CS6:
-		hid_err(hdev, "Invalid data bit size, setting to default (8 bit)\n");
+		hid_err(hdev, "invalid data bit size, setting a default\n");
 		req.data_bit = FT260_CFG_DATA_BITS_8;
 		termios->c_cflag &= ~CSIZE;
 		termios->c_cflag |= CS8;
@@ -1349,11 +1371,17 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	if (baud == 0 || baud < FT260_CFG_BAUD_MIN || baud > FT260_CFG_BAUD_MAX) {
 		struct tty_struct *tty = tty_port_tty_get(&port->port);
 
-		hid_err(hdev, "Invalid baud rate %d\n", baud);
+		hid_err(hdev, "invalid baud rate %d\n", baud);
 		baud = 9600;
 		tty_encode_baud_rate(tty, baud, baud);
 		tty_kref_put(tty);
 	}
+
+	if (baud > FT260_UART_EN_PW_SAVE_BAUD)
+		wakeup_workaraund = true;
+
+	ft260_uart_wakeup_workaraund_enable(port, wakeup_workaraund);
+
 	put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);
 
 	if (termios->c_cflag & CRTSCTS)
@@ -1361,7 +1389,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	else
 		req.flow_ctrl = FT260_CFG_FLOW_CTRL_OFF;
 
-	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
+	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
 	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
 		  req.data_bit, req.parity,
@@ -1372,7 +1400,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
+		hid_err(hdev, "failed to change termios: %d\n", ret);
 
 	return ret;
 }
@@ -1422,8 +1450,8 @@ static int ft260_uart_proc_show(struct seq_file *m, void *v)
 {
 	int i;
 
-	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n",
-			"", "", "");
+	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n", "", "", "");
+
 	for (i = 0; i < UART_COUNT_MAX; i++) {
 		struct ft260_device *port = ft260_uart_port_get(i);
 
@@ -1478,15 +1506,16 @@ static const struct tty_operations ft260_uart_ops = {
 	.get_icount		= ft260_uart_get_icount,
 };
 
-/* The FT260 has a "power saving mode" that causes the device to switch
+/*
+ * The FT260 has a "power saving mode" that causes the device to switch
  * to a 30 kHz oscillator if there's no activity for 5 seconds.
- * Unfortunately this mode can only be disabled by reprogramming
+ * Unfortunately, this mode can only be disabled by reprogramming
  * internal fuses, which requires an additional programming voltage.
  *
- * One effect of this mode is to cause data loss on a fast UART that
- * transmits after being idle for longer than 5 seconds. We work around
- * this by sending a dummy report at least once per 4 seconds if the
- * UART is in use.
+ * One effect of this mode is to cause data loss on an Rx line at baud
+ * rates higher than 4800 after being idle for longer than 5 seconds.
+ * We work around this by sending a dummy report at least once per 4.8
+ * seconds if the UART is in use.
  */
 static void ft260_uart_start_wakeup(struct timer_list *t)
 {
@@ -1500,53 +1529,68 @@ static void ft260_uart_start_wakeup(struct timer_list *t)
 	}
 }
 
-static void ft260_uart_do_wakeup(struct work_struct *work)
+static void ft260_uart_wakeup(struct ft260_device *dev)
 {
-	struct ft260_device *dev =
-		container_of(work, struct ft260_device, wakeup_work);
-	struct ft260_get_chip_version_report version;
+	struct ft260_get_chip_version_report ver;
 	int ret;
 
 	if (dev->reschedule_work) {
 		ret = ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
-					  (u8 *)&version, sizeof(version));
+						   (u8 *)&ver, sizeof(ver));
 		if (ret < 0)
-			hid_err(dev->hdev,
-				"%s: failed to start transfer, ret %d\n",
-				__func__, ret);
+			hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
 	}
 }
 
-static void ft260_uart_shutdown(struct tty_port *tport)
+static void ft260_uart_do_wakeup(struct work_struct *work)
+{
+	struct ft260_device *dev =
+		container_of(work, struct ft260_device, wakeup_work);
+
+	ft260_uart_wakeup(dev);
+}
+
+static void ft260_uart_port_shutdown(struct tty_port *tport)
 {
 	struct ft260_device *port =
 		container_of(tport, struct ft260_device, port);
 
-	port->reschedule_work = false;
+	ft260_uart_wakeup_workaraund_enable(port, false);
 }
 
-static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
+static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *tty)
 {
-	struct ft260_device *port =
-		container_of(tport, struct ft260_device, port);
+	int ret;
+	int baudrate;
+	struct ft260_get_uart_settings_report cfg;
+	struct ft260_device *port = container_of(tport, struct ft260_device, port);
 
-	/*
-	 * Set the TTY IO error marker - we will only clear this
-	 * once we have successfully opened the port.
-	 */
 	set_bit(TTY_IO_ERROR, &tty->flags);
 
-	spin_lock(&port->write_lock);
+	spin_lock(&port->xmit_fifo_lock);
 	kfifo_reset(&port->xmit_fifo);
-	spin_unlock(&port->write_lock);
+	spin_unlock(&port->xmit_fifo_lock);
 
-	ft260_uart_change_speed(port, &tty->termios, NULL);
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 
-	if (port->reschedule_work) {
-		mod_timer(&port->wakeup_timer, jiffies +
-			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
-	}
+	/*
+	 * The port setting may remain intact after session termination.
+	 * Then, when reopening the port without configuring the port
+	 * setting, we need to retrieve the baud rate from the device to
+	 * reactivate the wakeup workaround if needed.
+	 */
+	ret = ft260_get_uart_settings(port->hdev, &cfg);
+	if (ret)
+		return ret;
+
+	baudrate = get_unaligned_le32(&cfg.baudrate);
+	if (baudrate > FT260_UART_EN_PW_SAVE_BAUD)
+		ft260_uart_wakeup_workaraund_enable(port, true);
+
+	ft260_dbg("configured baudrate = %d", baudrate);
+
+	mod_timer(&port->wakeup_timer, jiffies +
+		  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
 
 	return 0;
 }
@@ -1560,8 +1604,8 @@ static void ft260_uart_port_destroy(struct tty_port *tport)
 }
 
 static const struct tty_port_operations ft260_uart_port_ops = {
-	.shutdown = ft260_uart_shutdown,
-	.activate = ft260_uart_activate,
+	.shutdown = ft260_uart_port_shutdown,
+	.activate = ft260_uart_port_activate,
 	.destruct = ft260_uart_port_destroy,
 };
 
@@ -1610,14 +1654,13 @@ static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
 
 static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 {
-	struct ft260_configure_uart_request req;
+	struct ft260_configure_uart_request_report req;
 	int ret;
 	struct device *devt;
 
 	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
-	// FIXME: Do I need that if I have cancel_work_sync?
 	// FIXME: are all kfifo access secured by lock? with irq or not?
-	dev->reschedule_work = false;
+	ft260_uart_wakeup_workaraund_enable(dev, true);
 	/* Work not started at this point */
 	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
 
@@ -1638,10 +1681,10 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 		ret = PTR_ERR(devt);
 		goto err_register_tty;
 	}
-	hid_info(hdev, "Registering device /dev/%s%d\n",
+	hid_info(hdev, "registering device /dev/%s%d\n",
 		ft260_tty_driver->name, dev->index);
 
-	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
+	/* Configure UART to 9600n8 */
 	req.report	= FT260_SYSTEM_SETTINGS;
 	req.request	= FT260_SET_UART_CONFIG;
 	req.flow_ctrl	= FT260_CFG_FLOW_CTRL_NONE;
@@ -1653,8 +1696,7 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0) {
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
-			ret);
+		hid_err(hdev, "failed to configure uart: %d\n", ret);
 		goto err_hid_report;
 	}
 
@@ -1675,9 +1717,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (!hid_is_usb(hdev))
 		return -EINVAL;
-
-	/* We cannot used devm_kzalloc here, because port has to survive until
-	 * destroy function call
+	/*
+	 * We cannot use devm_kzalloc here because the port has to survive
+	 * until destroy function call.
 	 */
 	dev = kzalloc_obj(*dev, GFP_KERNEL);
 	if (!dev) {
@@ -1726,15 +1768,12 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
-	if (!dev->ft260_is_serial) {
+	if (ret == FT260_IFACE_I2C)
 		ret = ft260_i2c_probe(hdev, dev);
-		if (ret)
-			goto err_hid_close;
-	} else {
+	else
 		ret = ft260_uart_probe(hdev, dev);
-		if (ret)
-			goto err_hid_close;
-	}
+	if (ret)
+		goto err_hid_close;
 
 	return 0;
 
@@ -1755,13 +1794,12 @@ static void ft260_remove(struct hid_device *hdev)
 	if (!dev)
 		return;
 
-	if (dev->ft260_is_serial) {
-		// FIXME:
+	if (dev->iface_type == FT260_IFACE_UART) {
 		cancel_work_sync(&dev->wakeup_work);
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
 		ft260_uart_port_remove(dev);
-		/* dev still needed, so we will free it in _destroy func */
+		/* dev is still needed, so we will free it in _destroy func */
 	} else {
 		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
@@ -1784,6 +1822,12 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		return -1;
 	}
 
+	if (xfer->length > size - offsetof(struct ft260_input_report, data)) {
+		hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
+			xfer->report, xfer->length);
+		return -1;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		bool complete_read;
@@ -1791,13 +1835,6 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
 			  xfer->report, xfer->length, size);
 
-		if (xfer->length > size -
-		    offsetof(struct ft260_input_report, data)) {
-			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
-				xfer->report, xfer->length);
-			return -1;
-		}
-
 		/*
 		 * Hold read_lock so a timed-out ft260_i2c_read() cannot
 		 * clear read_buf between the NULL check and the memcpy.
@@ -1824,12 +1861,11 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 		return 0;
 
-	} else if (xfer->length > FT260_RD_DATA_MAX) {
-		hid_err(hdev, "received data too long (%d)\n", xfer->length);
-		return -EBADR;
 	} else if (xfer->report >= FT260_UART_REPORT_MIN &&
 		   xfer->report <= FT260_UART_REPORT_MAX) {
 		return ft260_uart_receive_chars(dev, xfer->data, xfer->length);
+	} else if (xfer->report == FT260_UART_INTERRUPT_STATUS) {
+		return 0;
 	}
 	hid_err(hdev, "unhandled report %#02x\n", xfer->report);
 
@@ -1874,7 +1910,7 @@ static int __init ft260_driver_init(void)
 		goto err_reg_driver;
 	}
 
-	ret = hid_register_driver(&(ft260_driver));
+	ret = hid_register_driver(&ft260_driver);
 	if (ret) {
 		pr_err("hid_register_driver failed: %d\n", ret);
 		goto err_reg_hid;
@@ -1892,7 +1928,7 @@ static int __init ft260_driver_init(void)
 
 static void __exit ft260_driver_exit(void)
 {
-	hid_unregister_driver(&(ft260_driver));
+	hid_unregister_driver(&ft260_driver);
 	tty_unregister_driver(ft260_tty_driver);
 	tty_driver_kref_put(ft260_tty_driver);
 }
-- 
2.43.0

