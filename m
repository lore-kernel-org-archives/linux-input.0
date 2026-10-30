Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399823;
	b=uh7RkOiJIHJyMH+h4KpGmjPQud4ZOJXZ5y/JOh0AUm0pRe+PosLy8DyU6Xs+0M/vgx4k
	 TJmqteEmx0Cmy1EcnPNdJFPvvN9sH6YGViDtlb+gxlJh1uIfFeUVcZGsVbFFgkX+9uyyi
	 x1loeVcwnAQrce/4t+GiUIpw5t0eD1aT7qXM3JrCijSggVsi1a9qq2Qm+zXNBBjLYKdU0
	 AmKiK1a/yVoha5rR47o0qpXuuU1JM1j/cKMKmR5+hAcvnuk76EiS7NfI0WvvaLIC77eZK
	 fSd8EAA7pD1L9OYY8ak0RE52+40C7OnBwGgSRvVKXgWTvkq2nWTLl7g+14sgfc5kIrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X6fmpxBs+rXefF0gs9PccrKQH7rkukCO6N881ebewIs=;
	b=44JdFcmyP20kg+W4DOKwEwH7lQpxUZ4PMLKEVM0gp91QgwmXvVU7eC50NlTKYVugUG1e
	 4T/GTwjl+k/ahOwPo6C3SN0nyFFLfFPs+EIpeweCZYyEJCjYm/XiPlx8CTsD9UwxTFQQT
	 2yB7LpKR2Bsn4GlS4sE203ryPvpZARvVp4dwuDBKdzrvuG0nDViraJ9wGvU9LXwjQXuxI
	 3SuOcLu/VAdiE3dD9lIQ6OZ1ITKWX/a5dh16jJt52UpwiPVG951kxI9XrBAFqt+jvQGc9
	 kjuLzgYKqJiKqet65rYIOvE841InTrgq2lM/thFuwFwh3ky1gIjsxb/wgEsLASjcHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwzNV6RU;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6336606A329
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6336606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwzNV6RU
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7698365e9.2
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399820; x=1794004620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X6fmpxBs+rXefF0gs9PccrKQH7rkukCO6N881ebewIs=;
        b=ZwzNV6RUsNEGiFIs5wo7esbA0VjzI5l7UWNDJ2UmHvINpEAzCXHtfkjey4UlPL71Ek
         kjBckskBE5+Pnnx0GEpmSahvNH6nJI74nP/FsQDgrp6RXbZlnpuMuis38DwRuu+cqb84
         iTt9R6Tgr1WY0OpArO5+wnaW+0qHmYH6BrhAJLaO5asXqs0M+doVfvw8/+epcyfs+q3v
         +xEPE9IKNkVbaHLq648gMHL3ITpWb2/UF21kTCvp7nyKmY+ZIjJenYHMx2qr/lks4IrV
         rkfIzzsufbqnweoxq7a9gVLECH+7E9SCBtUz9Z5Woxc7SDvfM0MmmVUbDwZs1sDNTfwo
         u5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399820; x=1794004620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X6fmpxBs+rXefF0gs9PccrKQH7rkukCO6N881ebewIs=;
        b=EU5gs9qgssTIXp9ruRvLbrUTM3Atfw+Z8MpCLAZUDIeYA9m5rXT6/RScg+JFv4bcl5
         2YzWYWBM3rVdxQ77fMr9Xc0aWR3/gQt8cfhiSYYiYgn2rWBWvoY8c9GXigcWoT6Xu/Ng
         CIuXgtTUzHVhQUgpcfgENUOST75vUMs20vjB4xoYjGYXLbscLmH56TsXUlu10LzaeVNo
         DnCQ3Y5g8TvxSbWx28OCF3zQtyV93uNzLC/rvQ8H1j2ZiTBtOpzjqx37l0gPtpm87Rw1
         iP3EVXD5BWgxo5YLUc3qaZEp1iRUGjCAnajZPhRBV1tIUTfktKXeQ5Knt2KLS/TSJb+T
         RQUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbkeUwKxRt4Wyb1x7CcoN5FloM0k4K6I65myWTUzIpvwPT/p6RsDPrcKMG7jvr5AQNGjTnD/F7q+VR7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJplRwebI27t4vW7yVRTe3f5Vg5BwKm3oGZE3v+wDDmXfdKpz5k
	9Q50c/EflZT5rsLDro9S353plo7jmQFNC6iP1dVsLCyNjF0YKf8wyg71
X-Gm-Gg: AYBFou0fyMnKnWWTXG900E92U6sXK6XzIOnLwqJk8sLC7OCQepKUCSfDUJNKyebz/s8
	MZOLBM+y0/5XYXs4dy6rrpJud64+rTD/VnvbE+Z8Jc50nR/00QXqyr2VaBhMD7nKGvkcUxZiMEs
	K3HGurT67xIpaY1ouEbiARrMH0SfXd+PM/rrflUPUNJ8i01gCPk1xv//U0pXJHcgR/+FfRWpojp
	XNujd0VtPpezPtNMbG6e51vqPClpVsxECoZLvv/jr4hleuvdzuHLQJE0zmSBs7vUz8k15hCjYD1
	07dLrFRJN1y0FGJEM79A0nLE83khx0+y3k7ILyXj1jbSMfM1qPWkzw4foXEezzg8tvqG39pM6gE
	i5Q8EjqKSkW2/sZUuKzlz0YU/2m2fTI8kgMrG/dIpAKgzIdKFS8mFLAf4TtJ38iInhWn2eWPHcF
	jhEZ/nZIvDi1jLXo+R9D5+PgW4CnJmTrIW/YbQNMJfUQcfs7YtSvYG5lDuUFrwnQqRrSUUQZr9E
	5Qpb/uIfwdFAerh800w09RSY3E9PyzrVsD+oLE7Nc1Sh58L6f/wQLDImxHcDb/uTD/gXXOH21Nq
	J+SHwi5StZRxN7fS0g0ib8a+sRpj
X-Received: by 2002:a05:6000:22c8:b0:48e:4831:ae20 with SMTP id ffacd0b85a97d-48e6e305b92mr9190545f8f.37.1793399820039;
        Fri, 30 Oct 2026 15:37:00 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:36:59 -0700 (PDT)
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
	Daniel Beer <daniel.beer@igorinstitute.com>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v2 01/15] HID: ft260: add serial driver
Date: Sat, 31 Oct 2026 00:36:23 +0200
Message-ID: <20261030223637.86907-2-michael.zaidman@gmail.com>
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

From: Christina Quast <contact@christina-quast.de>

Add a TTY serial interface (/dev/ttyFTx) for FT260 USB HID devices,
providing baud rate configuration, data transfer, and termios settings
without requiring userspace HID report formatting.

The FT260 exposes I2C and UART through separate HID interfaces. Only
I2C was supported previously; UART required FTDI hidraw example code.

This is the v4 patch:
https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/

The follow-up v5 series stalled without being applied:
https://lore.kernel.org/linux-input/20240216-ft260_review5-v5-1-36db44673ac7@christina-quast.de/

Michael Zaidman ported it to the current driver:

- Adapt it to the I2C hardening merged upstream since v4: input-report
  length validation, the read_buf/raw_event race fix with read_lock,
  and SMBus block-read START/STOP handling.
- Make HID_FT260 depend on TTY, because the UART code is part of this
  driver.
- Stop the report dispatch after an I2C input report is consumed.
  Routing UART reports through ft260_raw_event() made v4 also report
  every I2C input report as unhandled.
- Correct the UART probe/remove lifetime, the TTY install, index and
  write return, the baud endianness, and the lock initialisation
  before hid_hw_open() (reported by Sashiko).

Signed-off-by: Christina Quast <contact@christina-quast.de>
Co-developed-by: Daniel Beer <daniel.beer@igorinstitute.com>
Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
Co-developed-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: fold Sashiko-reported lifetime and TTY fixes into this patch.
---
 drivers/hid/Kconfig     |  10 +-
 drivers/hid/hid-ft260.c | 853 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 802 insertions(+), 61 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..670bce481c42 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -386,12 +386,12 @@ config HID_EZKEY
 	Support for Ezkey BTC 8193 keyboard.
 
 config HID_FT260
-	tristate "FTDI FT260 USB HID to I2C host support"
-	depends on USB_HID && HIDRAW && I2C
+	tristate "FTDI FT260 USB HID to I2C/UART host support"
+	depends on USB_HID && HIDRAW && I2C && TTY
 	help
-	  Provides I2C host adapter functionality over USB-HID through FT260
-	  device. The customizable USB descriptor fields are exposed as sysfs
-	  attributes.
+	  Provides I2C host adapter and UART/TTY functionality over USB-HID
+	  through the FT260 device. The customizable USB descriptor fields
+	  are exposed as sysfs attributes.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called hid-ft260.
diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 64c9c940db46..982e2ca7a2de 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -13,6 +13,16 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/kfifo.h>
+#include <linux/tty_flip.h>
+#include <linux/minmax.h>
+#include <linux/unaligned.h>
+
+#define UART_COUNT_MAX		4	/* Number of UARTs this driver can handle */
+#define FIFO_SIZE	256
+#define TTY_WAKEUP_WATERMARK	(FIFO_SIZE / 2)
 
 #ifdef DEBUG
 static int ft260_debug = 1;
@@ -30,6 +40,7 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_REPORT_MAX_LENGTH (64)
 #define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
+#define FT260_UART_DATA_REPORT_ID(len) (FT260_UART_REPORT_MIN + (len - 1) / 4)
 
 #define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
 
@@ -43,7 +54,7 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
  * or optoe limit the i2c reads to 128 bytes. To not block other drivers out
  * of I2C for potentially troublesome amounts of time, we select the maximum
  * read payload length to be 180 bytes.
-*/
+ */
 #define FT260_RD_DATA_MAX (180)
 #define FT260_WR_DATA_MAX (60)
 
@@ -81,7 +92,8 @@ enum {
 	FT260_UART_INTERRUPT_STATUS	= 0xB1,
 	FT260_UART_STATUS		= 0xE0,
 	FT260_UART_RI_DCD_STATUS	= 0xE1,
-	FT260_UART_REPORT		= 0xF0,
+	FT260_UART_REPORT_MIN		= 0xF0,
+	FT260_UART_REPORT_MAX		= 0xFE,
 };
 
 /* Feature Out */
@@ -132,6 +144,13 @@ enum {
 	FT260_FLAG_START_STOP_REPEATED	= 0x07,
 };
 
+/* Return values for ft260_get_interface_type func */
+enum {
+	FT260_IFACE_NONE,
+	FT260_IFACE_I2C,
+	FT260_IFACE_UART
+};
+
 #define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | report_id)
 
 /* Feature In reports */
@@ -220,12 +239,71 @@ struct ft260_i2c_read_request_report {
 	__le16 length;		/* data payload length */
 } __packed;
 
-struct ft260_i2c_input_report {
-	u8 report;		/* FT260_I2C_REPORT */
+struct ft260_input_report {
+	u8 report;		/* FT260_I2C_REPORT or FT260_UART_REPORT */
 	u8 length;		/* data payload length */
 	u8 data[2];		/* data payload */
 } __packed;
 
+/* UART reports */
+struct ft260_uart_write_request_report {
+	u8 report;		/* FT260_UART_REPORT */
+	u8 length;		/* data payload length */
+	u8 data[] __counted_by(length);	/* variable data payload */
+} __packed;
+
+struct ft260_configure_uart_request {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_SET_UART_CONFIG */
+	u8 flow_ctrl;		/* 0: OFF, 1: RTS_CTS, 2: DTR_DSR */
+				/* 3: XON_XOFF, 4: No flow ctrl */
+	/* The baudrate field is unaligned: */
+	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
+	u8 data_bit;		/* 7 or 8 */
+	u8 parity;		/* 0: no parity, 1: odd, 2: even, 3: high, 4: low */
+	u8 stop_bit;		/* 0: one stop bit, 2: 2 stop bits */
+	u8 breaking;		/* 0: no break */
+} __packed;
+
+/* UART flow control */
+enum {
+	FT260_UART_CFG_FLOW_CTRL_OFF		= 0x00,
+	FT260_UART_CFG_FLOW_CTRL_RTS_CTS	= 0x01,
+	FT260_UART_CFG_FLOW_CTRL_DTR_DSR	= 0x02,
+	FT260_UART_CFG_FLOW_CTRL_XON_XOFF	= 0x03,
+	FT260_UART_CFG_FLOW_CTRL_NONE		= 0x04,
+};
+
+/* UART data bits */
+enum {
+	FT260_UART_CFG_DATA_BITS_7		= 0x07,
+	FT260_UART_CFG_DATA_BITS_8		= 0x08,
+};
+
+/* UART parity */
+enum {
+	FT260_UART_CFG_PAR_NO			= 0x00,
+	FT260_UART_CFG_PAR_ODD			= 0x01,
+	FT260_UART_CFG_PAR_EVEN			= 0x02,
+	FT260_UART_CFG_PAR_HIGH			= 0x03,
+	FT260_UART_CFG_PAR_LOW			= 0x04,
+};
+
+/* UART stop bits */
+enum {
+	FT260_UART_CFG_STOP_ONE_BIT		= 0x00,
+	FT260_UART_CFG_STOP_TWO_BIT		= 0x02,
+};
+
+/* UART break */
+enum {
+	FT260_UART_CFG_BREAKING_NO		= 0x00,
+	FT260_UART_CFG_BREAKING_YES		= 0x01,
+};
+
+#define FT260_UART_CFG_BAUD_MIN 1200
+#define FT260_UART_CFG_BAUD_MAX 12000000
+
 static const struct hid_device_id ft260_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
 			 USB_DEVICE_ID_FT260) },
@@ -236,6 +314,22 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
+
+	bool ft260_is_serial;
+	struct list_head device_list;
+
+	/* tty_port lifetime is equal to device lifetime */
+	struct tty_port port;
+	unsigned int index;
+	struct kfifo xmit_fifo;
+	/* write_lock: lock to serialize access to xmit fifo */
+	spinlock_t write_lock;
+	struct uart_icount icount;
+
+	struct timer_list wakeup_timer;
+	struct work_struct wakeup_work;
+	bool reschedule_work;
+
 	struct completion wait;
 	struct mutex lock;
 	u8 write_buf[FT260_REPORT_MAX_LENGTH];
@@ -379,7 +473,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
-		hid_err(hdev, "%s: failed to start transfer, ret %d\n",
+		hid_dbg(hdev, "%s: failed to start transfer, ret %d\n",
 			__func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
@@ -609,7 +703,7 @@ static int ft260_i2c_write_read(struct ft260_device *dev, struct i2c_msg *msgs)
 		else
 			read_off = *msgs[0].buf;
 
-		pr_info("%s: off %#x rlen %d wlen %d\n", __func__,
+		ft260_dbg("%s: off %#x rlen %d wlen %d\n", __func__,
 			read_off, rd_len, wr_len);
 	}
 
@@ -826,7 +920,7 @@ static int ft260_get_system_config(struct hid_device *hdev,
 	return 0;
 }
 
-static int ft260_is_interface_enabled(struct hid_device *hdev)
+static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device *dev)
 {
 	struct ft260_get_system_status_report cfg;
 	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
@@ -843,21 +937,27 @@ static int ft260_is_interface_enabled(struct hid_device *hdev)
 	ft260_dbg("i2c_enable: 0x%02x\n", cfg.i2c_enable);
 	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
 
+	dev->ft260_is_serial = false;
+
 	switch (cfg.chip_mode) {
 	case FT260_MODE_ALL:
 	case FT260_MODE_BOTH:
-		if (interface == 1)
-			hid_info(hdev, "uart interface is not supported\n");
-		else
-			ret = 1;
+		if (interface == 1) {
+			ret = FT260_IFACE_UART;
+			dev->ft260_is_serial = true;
+		} else {
+			ret = FT260_IFACE_I2C;
+		}
 		break;
 	case FT260_MODE_UART:
-		hid_info(hdev, "uart interface is not supported\n");
+		ret = FT260_IFACE_UART;
+		dev->ft260_is_serial = true;
 		break;
 	case FT260_MODE_I2C:
-		ret = 1;
+		ret = FT260_IFACE_I2C;
 		break;
 	}
+
 	return ret;
 }
 
@@ -1001,51 +1101,478 @@ static const struct attribute_group ft260_attr_group = {
 	}
 };
 
-static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
+/***
+ * START Serial dev part
+ */
+static DEFINE_MUTEX(ft260_uart_list_lock);
+static LIST_HEAD(ft260_uart_device_list);
+
+static struct ft260_device *ft260_dev_by_index(int index)
+{
+	struct ft260_device *port;
+
+	list_for_each_entry(port, &ft260_uart_device_list, device_list) {
+		if (index == port->index)
+			return port;
+	}
+	return NULL;
+}
+
+static int ft260_uart_add_port(struct ft260_device *port)
 {
+	int index = 0, ret = 0;
 	struct ft260_device *dev;
-	struct ft260_get_chip_version_report version;
+
+	spin_lock_init(&port->write_lock);
+	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
+		return -ENOMEM;
+
+	mutex_lock(&ft260_uart_list_lock);
+	list_for_each_entry(dev, &ft260_uart_device_list, device_list) {
+		if (dev->index != index)
+			break;
+		index++;
+	}
+
+	port->index = index;
+	list_add_tail(&port->device_list, &ft260_uart_device_list);
+	mutex_unlock(&ft260_uart_list_lock);
+
+	return ret;
+}
+
+static void ft260_uart_port_put(struct ft260_device *port)
+{
+	tty_port_put(&port->port);
+}
+
+static void ft260_uart_port_remove(struct ft260_device *port)
+{
+	timer_delete_sync(&port->wakeup_timer);
+
+	mutex_lock(&ft260_uart_list_lock);
+	list_del(&port->device_list);
+	mutex_unlock(&ft260_uart_list_lock);
+
+	tty_port_tty_vhangup(&port->port);
+
+	spin_lock(&port->write_lock);
+	kfifo_free(&port->xmit_fifo);
+	spin_unlock(&port->write_lock);
+}
+
+static struct ft260_device *ft260_uart_port_get(unsigned int index)
+{
+	struct ft260_device *port;
+
+	if (index >= UART_COUNT_MAX)
+		return NULL;
+
+	mutex_lock(&ft260_uart_list_lock);
+	port = ft260_dev_by_index(index);
+	if (port)
+		tty_port_get(&port->port);
+	mutex_unlock(&ft260_uart_list_lock);
+
+	return port;
+}
+
+static int ft260_uart_open(struct tty_struct *tty, struct file *filp)
+{
 	int ret;
+	struct ft260_device *port = tty->driver_data;
 
-	if (!hid_is_usb(hdev))
-		return -EINVAL;
+	ret = tty_port_open(&port->port, tty, filp);
 
-	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
+	return ret;
+}
 
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "failed to parse HID\n");
-		return ret;
+static void ft260_uart_close(struct tty_struct *tty, struct file *filp)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	tty_port_close(&port->port, tty, filp);
+}
+
+static void ft260_uart_hangup(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	tty_port_hangup(&port->port);
+}
+
+static int ft260_uart_transmit_chars(struct ft260_device *port)
+{
+	struct hid_device *hdev = port->hdev;
+	struct kfifo *xmit = &port->xmit_fifo;
+	struct tty_struct *tty;
+	struct ft260_uart_write_request_report *rep;
+	int len, data_len, ret = 0;
+
+	tty = tty_port_tty_get(&port->port);
+
+	data_len = kfifo_len(xmit);
+	if (!tty || !data_len) {
+		ret = -EINVAL;
+		goto tty_out;
 	}
 
-	ret = hid_hw_start(hdev, 0);
+	rep = (struct ft260_uart_write_request_report *)port->write_buf;
+
+	do {
+		len = min(data_len, FT260_WR_DATA_MAX);
+
+		rep->report = FT260_UART_DATA_REPORT_ID(len);
+		rep->length = len;
+
+		len = kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
+
+		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
+		if (ret < 0) {
+			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
+			goto tty_out;
+		}
+
+		data_len -= len;
+		port->icount.tx += len;
+	} while (data_len > 0);
+
+	len = kfifo_len(xmit);
+	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
+		tty_wakeup(tty);
+
+	ret = 0;
+
+tty_out:
+	tty_kref_put(tty);
+	return ret;
+}
+
+static int ft260_uart_receive_chars(struct ft260_device *port,
+				    u8 *data, u8 length)
+{
+	struct hid_device *hdev = port->hdev;
+	int ret = 0;
+
+	if (length > FT260_RD_DATA_MAX) {
+		hid_err(hdev, "Received too much data (%d)\n", length);
+		return -EBADR;
+	}
+
+	ret = tty_insert_flip_string(&port->port, data, length);
+	if (ret != length)
+		hid_err(hdev, "%d char not inserted to flip buffer\n", length - ret);
+	port->icount.rx += ret;
+
+	if (ret)
+		tty_flip_buffer_push(&port->port);
+
+	return ret;
+}
+
+static ssize_t ft260_uart_write(struct tty_struct *tty, const u8 *buf,
+				 size_t count)
+{
+	struct ft260_device *port = tty->driver_data;
+	struct hid_device *hdev = port->hdev;
+	int len, ret;
+
+	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
+	ft260_dbg("count: %zu, len: %d", count, len);
+
+	ret = ft260_uart_transmit_chars(port);
+	if (ret < 0)
+		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
+
+	return len;
+}
+
+static unsigned int ft260_uart_write_room(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
+}
+
+static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	return kfifo_len(&port->xmit_fifo);
+}
+
+static int ft260_uart_change_speed(struct ft260_device *port,
+				   struct ktermios *termios,
+				    struct ktermios *old)
+{
+	struct hid_device *hdev = port->hdev;
+	unsigned int baud;
+	struct ft260_configure_uart_request req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+
+	req.report = FT260_SYSTEM_SETTINGS;
+	req.request = FT260_SET_UART_CONFIG;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS7:
+		req.data_bit = FT260_UART_CFG_DATA_BITS_7;
+		break;
+	case CS5:
+	case CS6:
+		hid_err(hdev, "Invalid data bit size, setting to default (8 bit)\n");
+		req.data_bit = FT260_UART_CFG_DATA_BITS_8;
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
+		break;
+	default:
+	case CS8:
+		req.data_bit = FT260_UART_CFG_DATA_BITS_8;
+		break;
+	}
+
+	req.stop_bit = (termios->c_cflag & CSTOPB) ?
+		FT260_UART_CFG_STOP_TWO_BIT : FT260_UART_CFG_STOP_ONE_BIT;
+
+	if (termios->c_cflag & PARENB) {
+		req.parity = (termios->c_cflag & PARODD) ?
+			FT260_UART_CFG_PAR_ODD : FT260_UART_CFG_PAR_EVEN;
+	} else {
+		req.parity = FT260_UART_CFG_PAR_NO;
+	}
+
+	baud = tty_termios_baud_rate(termios);
+	if (baud == 0 || baud < FT260_UART_CFG_BAUD_MIN || baud > FT260_UART_CFG_BAUD_MAX) {
+		struct tty_struct *tty = tty_port_tty_get(&port->port);
+
+		hid_err(hdev, "Invalid baud rate %d\n", baud);
+		baud = 9600;
+		if (tty) {
+			tty_encode_baud_rate(tty, baud, baud);
+			tty_kref_put(tty);
+		}
+	}
+	put_unaligned_le32(baud, &req.baudrate);
+
+	if (termios->c_cflag & CRTSCTS)
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
+	else
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
+
+	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
+		  req.flow_ctrl, baud);
+	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
+		  req.data_bit, req.parity,
+		  req.stop_bit, req.breaking);
+
+	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
+	req.breaking = FT260_UART_CFG_BREAKING_NO;
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
+	if (ret < 0)
+		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
+
+	return ret;
+}
+
+static int ft260_uart_get_icount(struct tty_struct *tty,
+		struct serial_icounter_struct *icount)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	memcpy(icount, &port->icount, sizeof(struct uart_icount));
+
+	return 0;
+}
+
+static void ft260_uart_set_termios(struct tty_struct *tty,
+		const struct ktermios *old_termios)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	ft260_uart_change_speed(port, &tty->termios, NULL);
+}
+
+static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	int idx = tty->index;
+	struct ft260_device *port = ft260_uart_port_get(idx);
+	int ret;
+
+	if (!port)
+		return -ENODEV;
+
+	ret = tty_standard_install(driver, tty);
 	if (ret) {
-		hid_err(hdev, "failed to start HID HW\n");
+		ft260_uart_port_put(port);
 		return ret;
 	}
 
-	ret = hid_hw_open(hdev);
-	if (ret) {
-		hid_err(hdev, "failed to open HID HW\n");
-		goto err_hid_stop;
+	tty->driver_data = port;
+	return 0;
+}
+
+static void ft260_uart_cleanup(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	tty->driver_data = NULL;	/* Bug trap */
+	ft260_uart_port_put(port);
+}
+
+static int ft260_uart_proc_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n",
+			"", "", "");
+	for (i = 0; i < UART_COUNT_MAX; i++) {
+		struct ft260_device *port = ft260_uart_port_get(i);
+
+		if (port) {
+			seq_printf(m, "%d: uart:FT260", i);
+			if (capable(CAP_SYS_ADMIN)) {
+				seq_printf(m, " tx:%d rx:%d",
+						port->icount.tx, port->icount.rx);
+				if (port->icount.frame)
+					seq_printf(m, " fe:%d",
+							port->icount.frame);
+				if (port->icount.parity)
+					seq_printf(m, " pe:%d",
+							port->icount.parity);
+				if (port->icount.brk)
+					seq_printf(m, " brk:%d",
+							port->icount.brk);
+				if (port->icount.overrun)
+					seq_printf(m, " oe:%d",
+							port->icount.overrun);
+				if (port->icount.cts)
+					seq_printf(m, " cts:%d",
+							port->icount.cts);
+				if (port->icount.dsr)
+					seq_printf(m, " dsr:%d",
+							port->icount.dsr);
+				if (port->icount.rng)
+					seq_printf(m, " rng:%d",
+							port->icount.rng);
+				if (port->icount.dcd)
+					seq_printf(m, " dcd:%d",
+							port->icount.dcd);
+			}
+			ft260_uart_port_put(port);
+			seq_putc(m, '\n');
+		}
 	}
+	return 0;
+}
 
-	ret = ft260_hid_feature_report_get(hdev, FT260_CHIP_VERSION,
-					   (u8 *)&version, sizeof(version));
-	if (ret < 0) {
-		hid_err(hdev, "failed to retrieve chip version\n");
-		goto err_hid_close;
+static const struct tty_operations ft260_uart_ops = {
+	.open			= ft260_uart_open,
+	.close			= ft260_uart_close,
+	.write			= ft260_uart_write,
+	.write_room		= ft260_uart_write_room,
+	.chars_in_buffer	= ft260_uart_chars_in_buffer,
+	.set_termios		= ft260_uart_set_termios,
+	.hangup			= ft260_uart_hangup,
+	.install		= ft260_uart_install,
+	.cleanup		= ft260_uart_cleanup,
+	.proc_show		= ft260_uart_proc_show,
+	.get_icount		= ft260_uart_get_icount,
+};
+
+/* The FT260 has a "power saving mode" that causes the device to switch
+ * to a 30 kHz oscillator if there's no activity for 5 seconds.
+ * Unfortunately this mode can only be disabled by reprogramming
+ * internal fuses, which requires an additional programming voltage.
+ *
+ * One effect of this mode is to cause data loss on a fast UART that
+ * transmits after being idle for longer than 5 seconds. We work around
+ * this by sending a dummy report at least once per 4 seconds if the
+ * UART is in use.
+ */
+static void ft260_uart_start_wakeup(struct timer_list *t)
+{
+	struct ft260_device *dev =
+		container_of(t, struct ft260_device, wakeup_timer);
+
+	if (dev->reschedule_work) {
+		schedule_work(&dev->wakeup_work);
+		mod_timer(&dev->wakeup_timer, jiffies +
+			msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
 	}
+}
 
-	hid_info(hdev, "chip code: %02x%02x %02x%02x\n",
-		 version.chip_code[0], version.chip_code[1],
-		 version.chip_code[2], version.chip_code[3]);
+static void ft260_uart_do_wakeup(struct work_struct *work)
+{
+	struct ft260_device *dev =
+		container_of(work, struct ft260_device, wakeup_work);
+	struct ft260_get_chip_version_report version;
+	int ret;
 
-	ret = ft260_is_interface_enabled(hdev);
-	if (ret <= 0)
-		goto err_hid_close;
+	if (dev->reschedule_work) {
+		ret = ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
+					  (u8 *)&version, sizeof(version));
+		if (ret < 0)
+			hid_err(dev->hdev,
+				"%s: failed to start transfer, ret %d\n",
+				__func__, ret);
+	}
+}
+
+static void ft260_uart_shutdown(struct tty_port *tport)
+{
+	struct ft260_device *port =
+		container_of(tport, struct ft260_device, port);
+
+	port->reschedule_work = false;
+}
+
+static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
+{
+	struct ft260_device *port =
+		container_of(tport, struct ft260_device, port);
+
+	/*
+	 * Set the TTY IO error marker - we will only clear this
+	 * once we have successfully opened the port.
+	 */
+	set_bit(TTY_IO_ERROR, &tty->flags);
+
+	spin_lock(&port->write_lock);
+	kfifo_reset(&port->xmit_fifo);
+	spin_unlock(&port->write_lock);
+
+	ft260_uart_change_speed(port, &tty->termios, NULL);
+	clear_bit(TTY_IO_ERROR, &tty->flags);
+
+	if (port->reschedule_work) {
+		mod_timer(&port->wakeup_timer, jiffies +
+			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
+	}
+
+	return 0;
+}
+
+static void ft260_uart_port_destroy(struct tty_port *tport)
+{
+	struct ft260_device *port =
+		container_of(tport, struct ft260_device, port);
+
+	kfree(port);
+}
+
+static const struct tty_port_operations ft260_uart_port_ops = {
+	.shutdown = ft260_uart_shutdown,
+	.activate = ft260_uart_activate,
+	.destruct = ft260_uart_port_destroy,
+};
+
+static struct tty_driver *ft260_tty_driver;
+
+static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
+{
+	int ret;
 
 	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n",
 		hdev->version >> 8, hdev->version & 0xff, hdev->name,
@@ -1061,10 +1588,6 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	snprintf(dev->adap.name, sizeof(dev->adap.name),
 		 "FT260 usb-i2c bridge");
 
-	mutex_init(&dev->lock);
-	spin_lock_init(&dev->read_lock);
-	init_completion(&dev->wait);
-
 	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
 	if (ret)
 		ft260_i2c_reset(hdev);
@@ -1073,7 +1596,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = i2c_add_adapter(&dev->adap);
 	if (ret) {
 		hid_err(hdev, "failed to add i2c adapter\n");
-		goto err_hid_close;
+		return ret;
 	}
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
@@ -1081,15 +1604,157 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_err(hdev, "failed to create sysfs attrs\n");
 		goto err_i2c_free;
 	}
-
 	return 0;
 
 err_i2c_free:
 	i2c_del_adapter(&dev->adap);
+	return ret;
+}
+
+static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
+{
+	struct ft260_configure_uart_request req;
+	int ret;
+	struct device *devt;
+
+	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
+	// FIXME: Do I need that if I have cancel_work_sync?
+	// FIXME: are all kfifo access secured by lock? with irq or not?
+	dev->reschedule_work = false;
+	/* Work not started at this point */
+	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
+
+	tty_port_init(&dev->port);
+	dev->port.ops = &ft260_uart_port_ops;
+
+	ret = ft260_uart_add_port(dev);
+	if (ret) {
+		hid_err(hdev, "failed to add port\n");
+		goto err_port;
+	}
+	devt = tty_port_register_device_attr(&dev->port,
+					     ft260_tty_driver,
+					     dev->index, &hdev->dev,
+					     dev, NULL);
+	if (IS_ERR(devt)) {
+		hid_err(hdev, "failed to register tty port\n");
+		ret = PTR_ERR(devt);
+		goto err_register_tty;
+	}
+	hid_info(hdev, "Registering device /dev/%s%d\n",
+		ft260_tty_driver->name, dev->index);
+
+	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
+	req.report	= FT260_SYSTEM_SETTINGS;
+	req.request	= FT260_SET_UART_CONFIG;
+	req.flow_ctrl	= FT260_UART_CFG_FLOW_CTRL_NONE;
+	put_unaligned_le32(9600, &req.baudrate);
+	req.data_bit	= FT260_UART_CFG_DATA_BITS_8;
+	req.parity	= FT260_UART_CFG_PAR_NO;
+	req.stop_bit	= FT260_UART_CFG_STOP_ONE_BIT;
+	req.breaking	= FT260_UART_CFG_BREAKING_NO;
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
+	if (ret < 0) {
+		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
+			ret);
+		goto err_hid_report;
+	}
+
+	return 0;
+
+err_hid_report:
+	tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
+err_register_tty:
+	ft260_uart_port_remove(dev);
+err_port:
+	timer_delete_sync(&dev->wakeup_timer);
+	return ret;
+}
+
+static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct ft260_device *dev;
+	struct ft260_get_chip_version_report version;
+	int ret;
+
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
+	/* We cannot used devm_kzalloc here, because port has to survive until
+	 * destroy function call
+	 */
+	dev = kzalloc_obj(*dev, GFP_KERNEL);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto alloc_fail;
+	}
+	hid_set_drvdata(hdev, dev);
+	mutex_init(&dev->lock);
+	spin_lock_init(&dev->read_lock);
+	init_completion(&dev->wait);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "failed to parse HID\n");
+		goto hid_fail;
+	}
+
+	ret = hid_hw_start(hdev, 0);
+	if (ret) {
+		hid_err(hdev, "failed to start HID HW\n");
+		goto hid_fail;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "failed to open HID HW\n");
+		goto err_hid_stop;
+	}
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_CHIP_VERSION,
+					   (u8 *)&version, sizeof(version));
+	if (ret < 0) {
+		hid_err(hdev, "failed to retrieve chip version\n");
+		goto err_hid_close;
+	}
+
+	hid_info(hdev, "chip code: %02x%02x %02x%02x\n",
+		 version.chip_code[0], version.chip_code[1],
+		 version.chip_code[2], version.chip_code[3]);
+
+	ret = ft260_get_interface_type(hdev, dev);
+	if (ret <= FT260_IFACE_NONE)
+		goto err_hid_close;
+
+	hid_set_drvdata(hdev, dev);
+	dev->hdev = hdev;
+
+	if (!dev->ft260_is_serial) {
+		ret = ft260_i2c_probe(hdev, dev);
+		if (ret)
+			goto err_hid_close;
+	} else {
+		ret = ft260_uart_probe(hdev, dev);
+		if (ret)
+			goto err_uart;
+	}
+
+	return 0;
+
+err_uart:
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+	tty_port_put(&dev->port);
+	return ret;
+
 err_hid_close:
 	hid_hw_close(hdev);
 err_hid_stop:
 	hid_hw_stop(hdev);
+hid_fail:
+	kfree(dev);
+alloc_fail:
 	return ret;
 }
 
@@ -1100,21 +1765,34 @@ static void ft260_remove(struct hid_device *hdev)
 	if (!dev)
 		return;
 
-	sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
-	i2c_del_adapter(&dev->adap);
+	if (dev->ft260_is_serial) {
+		timer_delete_sync(&dev->wakeup_timer);
+		cancel_work_sync(&dev->wakeup_work);
+		tty_port_unregister_device(&dev->port, ft260_tty_driver,
+					   dev->index);
+		ft260_uart_port_remove(dev);
+	} else {
+		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		i2c_del_adapter(&dev->adap);
+	}
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
+
+	if (dev->ft260_is_serial)
+		ft260_uart_port_put(dev);
+	else
+		kfree(dev);
 }
 
 static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			   u8 *data, int size)
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
-	struct ft260_i2c_input_report *xfer = (void *)data;
+	struct ft260_input_report *xfer = (void *)data;
 	unsigned long irqflags;
 
-	if (size < offsetof(struct ft260_i2c_input_report, data)) {
+	if (size < offsetof(struct ft260_input_report, data)) {
 		hid_err(hdev, "short report %d\n", size);
 		return -1;
 	}
@@ -1127,7 +1805,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			  xfer->report, xfer->length, size);
 
 		if (xfer->length > size -
-		    offsetof(struct ft260_i2c_input_report, data)) {
+		    offsetof(struct ft260_input_report, data)) {
 			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
 				xfer->report, xfer->length);
 			return -1;
@@ -1157,9 +1835,17 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		if (complete_read)
 			complete(&dev->wait);
 
-	} else {
-		hid_err(hdev, "unhandled report %#02x\n", xfer->report);
+		return 0;
+
+	} else if (xfer->length > FT260_RD_DATA_MAX) {
+		hid_err(hdev, "received data too long (%d)\n", xfer->length);
+		return -EBADR;
+	} else if (xfer->report >= FT260_UART_REPORT_MIN &&
+		   xfer->report <= FT260_UART_REPORT_MAX) {
+		return ft260_uart_receive_chars(dev, xfer->data, xfer->length);
 	}
+	hid_err(hdev, "unhandled report %#02x\n", xfer->report);
+
 	return 0;
 }
 
@@ -1171,7 +1857,62 @@ static struct hid_driver ft260_driver = {
 	.raw_event	= ft260_raw_event,
 };
 
-module_hid_driver(ft260_driver);
-MODULE_DESCRIPTION("FTDI FT260 USB HID to I2C host bridge");
+static int __init ft260_driver_init(void)
+{
+	int ret;
+
+	ft260_tty_driver = tty_alloc_driver(UART_COUNT_MAX,
+		TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(ft260_tty_driver)) {
+		pr_err("tty_alloc_driver failed: %d\n",
+			(int)PTR_ERR(ft260_tty_driver));
+		return PTR_ERR(ft260_tty_driver);
+	}
+
+	ft260_tty_driver->driver_name = "ft260_ser";
+	ft260_tty_driver->name = "ttyFT";
+	ft260_tty_driver->major = 0;
+	ft260_tty_driver->minor_start = 0;
+	ft260_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
+	ft260_tty_driver->subtype = SERIAL_TYPE_NORMAL;
+	ft260_tty_driver->init_termios = tty_std_termios;
+	ft260_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	ft260_tty_driver->init_termios.c_ispeed = 9600;
+	ft260_tty_driver->init_termios.c_ospeed = 9600;
+	tty_set_operations(ft260_tty_driver, &ft260_uart_ops);
+
+	ret = tty_register_driver(ft260_tty_driver);
+	if (ret) {
+		pr_err("tty_register_driver failed: %d\n", ret);
+		goto err_reg_driver;
+	}
+
+	ret = hid_register_driver(&(ft260_driver));
+	if (ret) {
+		pr_err("hid_register_driver failed: %d\n", ret);
+		goto err_reg_hid;
+	}
+
+	return 0;
+
+err_reg_hid:
+	tty_unregister_driver(ft260_tty_driver);
+err_reg_driver:
+	tty_driver_kref_put(ft260_tty_driver);
+
+	return ret;
+}
+
+static void __exit ft260_driver_exit(void)
+{
+	hid_unregister_driver(&(ft260_driver));
+	tty_unregister_driver(ft260_tty_driver);
+	tty_driver_kref_put(ft260_tty_driver);
+}
+
+module_init(ft260_driver_init);
+module_exit(ft260_driver_exit);
+
+MODULE_DESCRIPTION("FTDI FT260 USB HID to I2C host bridge and TTY driver");
 MODULE_AUTHOR("Michael Zaidman <michael.zaidman@gmail.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

