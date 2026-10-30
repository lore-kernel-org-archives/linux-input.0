Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399825;
	b=43D46/acXF4Ge40v4UakkoMBjbc7aL1vrvHBiJF+r66TFyIkRULP0LCXm8Iph6DLykTz
	 dKM3zCR2d9yDFhlJr01lZJxtbo09LZa2HrQZTzcP7a1jqg+ooVNOIUmmIDQzRn6NYuko7
	 S3ZwJ0W+tGunDmEvq+/aITk9bj7cdNGdhBo9jhmxPCDofZ3Mq6LdBY7iCTQzPtf/ZKrny
	 5M6kQHMlOun/fnPz5LklKJSOlw6zTzQKXhPUt5lS6zR45p2RYGq5FuvAw7Z7w/Vl/iPaP
	 3n14swTt3xC/mO4j5MDsnQ7fbaDsoj3NEcQMIZA+azguA225dGM8JQmWEH4an9PWcAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pDau68YQ69gB9k94yrULuz68L3/xFc5uTEX+1SbrIXY=;
	b=lJetI2r6OWlJWICzJ+TV9FSD39Ej8od70H5w+zm4s6YTOMlv6oITlm7Nb/+MadQvQwrB
	 GqpYuwz0eyWxL8YWP5/98gFbGfGkCiPlpAhIZmT5mp49rVLBnfJ3Cb3KpZZ1B49EBx69k
	 c2UKgXXKriwqCVnC/oY3DgnMPkJ0zAdbYyW1QpJ+5v5XW6UJr2QlxifPTAyMiU7tQs9iK
	 VFON6N9c1IcEOHkWO6e/Cr7HXo7jihxGLTEovBsIeKasmuAyuPIsPEFRaiVbafNEq5f4z
	 Eum53KVk1XkrTvhRrBaoBfosOSLtl1bqxwGDCeLOHXgSMEwNGLFrSylFvOAj7QXZ3vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lGuwYAVZ;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D664606A32C
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D664606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lGuwYAVZ
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1175957f8f.1
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399822; x=1794004622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pDau68YQ69gB9k94yrULuz68L3/xFc5uTEX+1SbrIXY=;
        b=lGuwYAVZKK83FDEHUaUhHxoF4XYrieGg3rJFZosCIn3Ba9UZ9aXiSuVDMTa6kAcKpS
         ImjULn8C72apIXiSIwf+Czox3Bophi1K3KsLRhrmMQcA43TgHu56EunjLG7rdBJsLbUJ
         89fM8+1xFSg4f0QZA/702f6tyNHEKexdb6MpB4E8WKnkLkYBwNdvZBYS3581c2gefb+p
         mNJUcPG+MbdUeluflWJa7yZpvHnG891EcxpeeA+MYa1vQJLixcM4uCU6N3+5SlyIUTCy
         tt4iKF13d3EL0FHODSXqUhc7cju5hhFdpvBuFXM+yNpk97Ym3x2FJwHDtFwHcyimUv4O
         96eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399822; x=1794004622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pDau68YQ69gB9k94yrULuz68L3/xFc5uTEX+1SbrIXY=;
        b=FKnAz8mfSWN0SOxpZgEQFAM9ZZdC40R/9ldnQVn0CelpOkDmzDJeppoGaYPkWSM2Xt
         grqtO5fdXZoSYydqeUJzXIyE+Cvvft4HzGJABwSRTJzwwjDPYCzay/mhNeuqxknf3BuK
         0PdGW0x+N0jOajHcMmProAMs3z8dTBAF4HywpSB9/RzeTFTh0qlMmSwbfmv6AD2YqsJF
         lJJUNCG5N1EwaTQI3DLO9yODbVVlV1r/5cAHxvI5fhzLiNQzQAgY2CRphGTMekAPZkXm
         th8kHutqevAZx1jSrLG9AshvVvTLe8JBU/u7ImfQtaOqtHvHOqdxZdocORx6mR9ICJ8k
         GIZw==
X-Forwarded-Encrypted: i=1; AKwUvBzoYaSXQH2DLIy310LU1i/uJWBGkcG1ptu7rm5BzcqzYW1QDGZI3pMrAshEzvICgKzG2ZPtsqvcaIyyQQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI0fiGo4ZJLc1yYWopqyf5q5iNaKAFx349ev06mWQ1VLcBufy31
	5QfW7r1L/S8Sj5g/uneopXHcvaPy+Ywz7KCgkLVldi5O+5xDNQ+RvC+T
X-Gm-Gg: AYBFou0jpe3+Dg0l+FhgW0WxoSWEgf/JkhYbn0o4dCZpMZf2cSClMYuXfQOJ2cNQTI6
	dnD/7A4kZ+djlzeNVRcy271bU44gNLydmPScg0Rl7cUealTDyPyeyOUYaFGaTYofGbv8gJf8g4V
	e8Jg6+QuSb+MhXebbtxS/UihOYP7eE7O5AJ/IfBg1gfMAY2MxYegSqbUNwZDuUW6AQoqAwCV2uy
	ZrW27terLUwkwWBeoODgLbLGJqYH4UI4zqvADMcw1oFpOMltVbcs2hhD3B02kDeKFq/sqXDwqzb
	/9LQHdInKnFhxesZPX7UMfcFChmE5WH/NqRos+A2IDj+Yu0J+xVMEOmmq01QS2KNnYSQRlK/8Zp
	nprkAiE8au+bXC1ljlmgvV+AhRN8KcV4Q+Sc+2kBjkNHpur7DqlHwdQhhiiOEsCHTaQXgeSIGyt
	KmzleHFNmr7XczxCgNVkymiDjD7xV4Iz6iUTam295hIyvqTaM5tiX7uy/BgXrr6fvjbqlOw8pYy
	2rBMYPUbnck6t4RK8yi/jNy7JRGgm3IMNLWvaifeuII7jD7nZHCp1ybsmucwWW6IjgZIN1rtb87
	pcN7pMIdhyWQCbdvqEB9KB1VHdhTDGlGVsfh0MLY00SeCHHQUA==
X-Received: by 2002:a05:6000:605:b0:487:1ac0:32af with SMTP id ffacd0b85a97d-48e6e50d8d8mr8933085f8f.51.1793399822221;
        Fri, 30 Oct 2026 15:37:02 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:01 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v2 02/15] HID: ft260: uart: fix the serial driver
Date: Sat, 31 Oct 2026 00:36:24 +0200
Message-ID: <20261030223637.86907-3-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the serial driver added by the previous patch, a port of
Christina Quast's v4, so that it works reliably on hardware.

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
driver style: replace the kfifo_*_locked aliases with
kfifo_*_spinlocked, and drop the parentheses around single-value
defines, which coding-style asks for only when the value is an
expression.

This replaces the UART bring-up fix series:
https://lore.kernel.org/all/20240210215147.77629-1-michael.zaidman@gmail.com/

Do not treat UART interrupt status (0xB1) as a payload length. When
re-enabling the power-save wakeup workaround after a baud change,
re-arm the timer (reported by Sashiko).

Report 0xE1 is defined as FT260_UART_RI_DCD_STATUS, but AN_394 section
4.3 lists 0xE2 for "UART RI and DCD Status". Correct the value. The
macro has no user, because the DCD and RI levels arrive in the 0xB1
interrupt report, which ft260_raw_event() handles.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: 0xB1 length check and wakeup timer re-arm (reported by Sashiko).
---
 drivers/hid/hid-ft260.c | 332 +++++++++++++++++++++++-----------------
 1 file changed, 189 insertions(+), 143 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 982e2ca7a2de..c859486cb28c 100644
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
@@ -38,11 +34,14 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 			pr_info("%s: " format, __func__, ##arg);	  \
 	} while (0)
 
-#define FT260_REPORT_MAX_LENGTH (64)
-#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
-#define FT260_UART_DATA_REPORT_ID(len) (FT260_UART_REPORT_MIN + (len - 1) / 4)
+#define FT260_REPORT_MAX_LEN 64
+#define FT260_DATA_REPORT_ID(min, len) (min + (len - 1) / 4)
+#define FT260_I2C_DATA_REPORT_ID(len) \
+		FT260_DATA_REPORT_ID(FT260_I2C_REPORT_MIN, len)
+#define FT260_UART_DATA_REPORT_ID(len) \
+		FT260_DATA_REPORT_ID(FT260_UART_REPORT_MIN, len)
 
-#define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
+#define FT260_WAKEUP_NEEDED_AFTER_MS 4800 /* 5s minus 200ms margin */
 
 /*
  * The ft260 input report format defines 62 bytes for the data payload, but
@@ -55,8 +54,9 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
  * of I2C for potentially troublesome amounts of time, we select the maximum
  * read payload length to be 180 bytes.
  */
-#define FT260_RD_DATA_MAX (180)
-#define FT260_WR_DATA_MAX (60)
+#define FT260_RD_DATA_MAX 180
+#define FT260_WR_I2C_DATA_MAX 60
+#define FT260_WR_UART_DATA_MAX 62
 
 /*
  * Device interface configuration.
@@ -90,8 +90,8 @@ enum {
 	FT260_I2C_REPORT_MAX		= 0xDE,
 	FT260_GPIO			= 0xB0,
 	FT260_UART_INTERRUPT_STATUS	= 0xB1,
-	FT260_UART_STATUS		= 0xE0,
-	FT260_UART_RI_DCD_STATUS	= 0xE1,
+	FT260_UART_SETTINGS		= 0xE0,
+	FT260_UART_RI_DCD_STATUS	= 0xE2,
 	FT260_UART_REPORT_MIN		= 0xF0,
 	FT260_UART_REPORT_MAX		= 0xFE,
 };
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
@@ -304,6 +317,11 @@ enum {
 #define FT260_UART_CFG_BAUD_MIN 1200
 #define FT260_UART_CFG_BAUD_MAX 12000000
 
+#define FT260_UART_EN_PW_SAVE_BAUD 4800
+
+#define UART_COUNT_MAX 4 /* Number of supported UARTs */
+#define XMIT_FIFO_SIZE PAGE_SIZE
+
 static const struct hid_device_id ft260_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
 			 USB_DEVICE_ID_FT260) },
@@ -314,25 +332,23 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
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
+	/* Protects xmit_fifo */
+	spinlock_t xmit_fifo_lock;
 	struct uart_icount icount;
-
 	struct timer_list wakeup_timer;
 	struct work_struct wakeup_work;
 	bool reschedule_work;
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
@@ -343,8 +359,7 @@ struct ft260_device {
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
-					unsigned char report_id, u8 *data,
-					size_t len)
+					u8 report_id, u8 *data, size_t len)
 {
 	u8 *buf;
 	int ret;
@@ -473,8 +488,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
-		hid_dbg(hdev, "%s: failed to start transfer, ret %d\n",
-			__func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -516,7 +529,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	int ret, wr_len, idx = 0;
 	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (len < 1)
 		return -EINVAL;
@@ -524,12 +537,12 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
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
@@ -565,7 +578,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (data_len >= sizeof(rep->data))
 		return -EINVAL;
@@ -585,6 +598,8 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 		  rep->report, addr, cmd, rep->length, len);
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	if (ret < 0)
+		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
 
 	return ret;
 }
@@ -703,8 +718,7 @@ static int ft260_i2c_write_read(struct ft260_device *dev, struct i2c_msg *msgs)
 		else
 			read_off = *msgs[0].buf;
 
-		ft260_dbg("%s: off %#x rlen %d wlen %d\n", __func__,
-			read_off, rd_len, wr_len);
+		ft260_dbg("off %#x rlen %d wlen %d\n", read_off, rd_len, wr_len);
 	}
 
 	ret = ft260_i2c_write(dev, addr, msgs[0].buf, wr_len,
@@ -937,27 +951,25 @@ static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device
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
 
@@ -1101,12 +1113,36 @@ static const struct attribute_group ft260_attr_group = {
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
@@ -1123,8 +1159,8 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	int index = 0, ret = 0;
 	struct ft260_device *dev;
 
-	spin_lock_init(&port->write_lock);
-	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
+	spin_lock_init(&port->xmit_fifo_lock);
+	if (kfifo_alloc(&port->xmit_fifo, XMIT_FIFO_SIZE, GFP_KERNEL))
 		return -ENOMEM;
 
 	mutex_lock(&ft260_uart_list_lock);
@@ -1156,12 +1192,12 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 
 	tty_port_tty_vhangup(&port->port);
 
-	spin_lock(&port->write_lock);
+	spin_lock(&port->xmit_fifo_lock);
 	kfifo_free(&port->xmit_fifo);
-	spin_unlock(&port->write_lock);
+	spin_unlock(&port->xmit_fifo_lock);
 }
 
-static struct ft260_device *ft260_uart_port_get(unsigned int index)
+static struct ft260_device *ft260_uart_port_get(int index)
 {
 	struct ft260_device *port;
 
@@ -1217,30 +1253,24 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
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
@@ -1248,20 +1278,14 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
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
@@ -1271,18 +1295,18 @@ static int ft260_uart_receive_chars(struct ft260_device *port,
 }
 
 static ssize_t ft260_uart_write(struct tty_struct *tty, const u8 *buf,
-				 size_t count)
+				 size_t cnt)
 {
 	struct ft260_device *port = tty->driver_data;
-	struct hid_device *hdev = port->hdev;
-	int len, ret;
+	ssize_t len, ret;
 
-	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
-	ft260_dbg("count: %zu, len: %d", count, len);
+	len = kfifo_in_spinlocked(&port->xmit_fifo, buf, cnt,
+				  &port->xmit_fifo_lock);
+	ft260_dbg("count: %zu, len: %zd", cnt, len);
 
 	ret = ft260_uart_transmit_chars(port);
 	if (ret < 0)
-		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
+		ft260_dbg("failed to transmit %zd\n", ret);
 
 	return len;
 }
@@ -1291,7 +1315,7 @@ static unsigned int ft260_uart_write_room(struct tty_struct *tty)
 {
 	struct ft260_device *port = tty->driver_data;
 
-	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
+	return kfifo_avail(&port->xmit_fifo);
 }
 
 static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
@@ -1307,7 +1331,8 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 {
 	struct hid_device *hdev = port->hdev;
 	unsigned int baud;
-	struct ft260_configure_uart_request req;
+	struct ft260_configure_uart_request_report req;
+	bool wakeup_workaraund = false;
 	int ret;
 
 	memset(&req, 0, sizeof(req));
@@ -1321,7 +1346,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		break;
 	case CS5:
 	case CS6:
-		hid_err(hdev, "Invalid data bit size, setting to default (8 bit)\n");
+		hid_err(hdev, "invalid data bit size, setting a default\n");
 		req.data_bit = FT260_UART_CFG_DATA_BITS_8;
 		termios->c_cflag &= ~CSIZE;
 		termios->c_cflag |= CS8;
@@ -1346,13 +1371,21 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	if (baud == 0 || baud < FT260_UART_CFG_BAUD_MIN || baud > FT260_UART_CFG_BAUD_MAX) {
 		struct tty_struct *tty = tty_port_tty_get(&port->port);
 
-		hid_err(hdev, "Invalid baud rate %d\n", baud);
+		hid_err(hdev, "invalid baud rate %d\n", baud);
 		baud = 9600;
 		if (tty) {
 			tty_encode_baud_rate(tty, baud, baud);
 			tty_kref_put(tty);
 		}
 	}
+	if (baud > FT260_UART_EN_PW_SAVE_BAUD)
+		wakeup_workaraund = true;
+
+	ft260_uart_wakeup_workaraund_enable(port, wakeup_workaraund);
+	if (port->reschedule_work)
+		mod_timer(&port->wakeup_timer, jiffies +
+			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
+
 	put_unaligned_le32(baud, &req.baudrate);
 
 	if (termios->c_cflag & CRTSCTS)
@@ -1360,7 +1393,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	else
 		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
 
-	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
+	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
 	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
 		  req.data_bit, req.parity,
@@ -1371,7 +1404,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
+		hid_err(hdev, "failed to change termios: %d\n", ret);
 
 	return ret;
 }
@@ -1425,8 +1458,8 @@ static int ft260_uart_proc_show(struct seq_file *m, void *v)
 {
 	int i;
 
-	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n",
-			"", "", "");
+	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n", "", "", "");
+
 	for (i = 0; i < UART_COUNT_MAX; i++) {
 		struct ft260_device *port = ft260_uart_port_get(i);
 
@@ -1481,15 +1514,16 @@ static const struct tty_operations ft260_uart_ops = {
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
@@ -1503,53 +1537,68 @@ static void ft260_uart_start_wakeup(struct timer_list *t)
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
 {
-	struct ft260_device *port =
-		container_of(tport, struct ft260_device, port);
+	struct ft260_device *dev =
+		container_of(work, struct ft260_device, wakeup_work);
 
-	port->reschedule_work = false;
+	ft260_uart_wakeup(dev);
 }
 
-static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
+static void ft260_uart_port_shutdown(struct tty_port *tport)
 {
 	struct ft260_device *port =
 		container_of(tport, struct ft260_device, port);
 
-	/*
-	 * Set the TTY IO error marker - we will only clear this
-	 * once we have successfully opened the port.
-	 */
+	ft260_uart_wakeup_workaraund_enable(port, false);
+}
+
+static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *tty)
+{
+	int ret;
+	int baudrate;
+	struct ft260_get_uart_settings_report cfg;
+	struct ft260_device *port = container_of(tport, struct ft260_device, port);
+
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
@@ -1563,8 +1612,8 @@ static void ft260_uart_port_destroy(struct tty_port *tport)
 }
 
 static const struct tty_port_operations ft260_uart_port_ops = {
-	.shutdown = ft260_uart_shutdown,
-	.activate = ft260_uart_activate,
+	.shutdown = ft260_uart_port_shutdown,
+	.activate = ft260_uart_port_activate,
 	.destruct = ft260_uart_port_destroy,
 };
 
@@ -1613,14 +1662,13 @@ static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
 
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
 
@@ -1641,10 +1689,10 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
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
 	req.flow_ctrl	= FT260_UART_CFG_FLOW_CTRL_NONE;
@@ -1656,8 +1704,7 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0) {
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
-			ret);
+		hid_err(hdev, "failed to configure uart: %d\n", ret);
 		goto err_hid_report;
 	}
 
@@ -1680,9 +1727,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
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
@@ -1730,7 +1777,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_set_drvdata(hdev, dev);
 	dev->hdev = hdev;
 
-	if (!dev->ft260_is_serial) {
+	if (dev->iface_type == FT260_IFACE_I2C) {
 		ret = ft260_i2c_probe(hdev, dev);
 		if (ret)
 			goto err_hid_close;
@@ -1765,7 +1812,7 @@ static void ft260_remove(struct hid_device *hdev)
 	if (!dev)
 		return;
 
-	if (dev->ft260_is_serial) {
+	if (dev->iface_type == FT260_IFACE_UART) {
 		timer_delete_sync(&dev->wakeup_timer);
 		cancel_work_sync(&dev->wakeup_work);
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
@@ -1779,7 +1826,7 @@ static void ft260_remove(struct hid_device *hdev)
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	if (dev->ft260_is_serial)
+	if (dev->iface_type == FT260_IFACE_UART)
 		ft260_uart_port_put(dev);
 	else
 		kfree(dev);
@@ -1797,6 +1844,13 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		return -1;
 	}
 
+	if (xfer->report != FT260_UART_INTERRUPT_STATUS &&
+	    xfer->length > size - offsetof(struct ft260_input_report, data)) {
+		hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
+			xfer->report, xfer->length);
+		return -1;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		bool complete_read;
@@ -1804,13 +1858,6 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -1837,12 +1884,11 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
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
 
@@ -1887,7 +1933,7 @@ static int __init ft260_driver_init(void)
 		goto err_reg_driver;
 	}
 
-	ret = hid_register_driver(&(ft260_driver));
+	ret = hid_register_driver(&ft260_driver);
 	if (ret) {
 		pr_err("hid_register_driver failed: %d\n", ret);
 		goto err_reg_hid;
@@ -1905,7 +1951,7 @@ static int __init ft260_driver_init(void)
 
 static void __exit ft260_driver_exit(void)
 {
-	hid_unregister_driver(&(ft260_driver));
+	hid_unregister_driver(&ft260_driver);
 	tty_unregister_driver(ft260_tty_driver);
 	tty_driver_kref_put(ft260_tty_driver);
 }
-- 
2.43.0

