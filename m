Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697712;
	b=qwbI4JuZx7L9SLU/wPmLWKfyWZkbdd0hQs+1p9VA5i0knQjhyaESVb3kf2a0MzkKmhk7
	 +pD1jhqHlLgbcuAXiTJnAiswTYAn33TAxFHAqMVBXOTbA76esX0oDh+XbqsZr7/TKh/mq
	 ND4SMj2jXDEYybQykz51PmYfYvXNpJc1Snyq/myA+g5opMg7zajEJPs7GulrfpLLCVcmZ
	 ZyhQCZTUKrjoNA/wwFpGTyf4SAHM5x5i67hdAdtFL70PMfpRr5Wm4isVlaHxG/UnIXLBr
	 KtxZ8cHI65mPM2Rg2RkSc8771A+zaQHjJ5+LyyK3ZFNn4MLjUzEcFmBNYsZgWqFaCEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+/CWoDIqqeCtib5JCXwTx7+EgJTnYfh/hIdHMQvRDIQ=;
	b=2k4gGdgFfFIK5Aqcb7RV6xB+9wI0TngT4rvNDcl/Ro5uAtnQkwOPptx+tQEJVgl+gL75
	 7eMJN/AAk0E2uVPWW0y5wOQ9iughYS33KwT2liJoCvh8KZzuhLNLapuUGhfbjNVobWXy9
	 36jR4ES0b7pRlGCnuVnOWrBR82GnWmKTzbw0H5Fb9AE9tw4Zax54o2m322lPpMPtxKaVq
	 lPVATR3N2wTGbNbDw6BPNoOCDA4nAvuzisI4psQtgwjEhU3UZzuLap0has+QpnGeheyUF
	 E77RRpGiARayDWdaNjQr3kmr4U4dxfk0FXYSPwmG8t28zC5pB+SGnKXsBEIuOeaZn/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wQQ+Ochf;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE1606A89B
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDAE1606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wQQ+Ochf
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-491aaed7565so963741f8f.2
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697710; x=1795302510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/CWoDIqqeCtib5JCXwTx7+EgJTnYfh/hIdHMQvRDIQ=;
        b=wQQ+Ochftq1WQDtul1Hl1qu54aLiQ0ExzWGXLrRcYfXwGIVMK6m3/lbIG3JZr+7pr4
         dsJn8SYQoayO6dqvZDJ3u5B4RnX8Edtj5bWxYqEqcuzX23qkgxJwb2kqA1ZR8uGQWuQC
         0gaRGB32C2bv3rlpS06AOzV2JjeM83u0yA2E//S9illMW6aDegJalg39K0FhTgz6eWIX
         /pJYmXSzzq77cicd6wAoYMwofaYI8d90UX2r7KN+L4RxI96rk0defxAH0n7sfmu6+pMB
         QKM+X4ME0d0BvzY6N17BNdssc5buL8iddqrKGIxMuIosy3EngzhoomaKgrqDvstNyMZF
         B/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697710; x=1795302510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/CWoDIqqeCtib5JCXwTx7+EgJTnYfh/hIdHMQvRDIQ=;
        b=brD5pTt7Z5wt4Rxlc58Vd1tapQBUZ1uP1iwfAzI4zbb38vWyTEPQuCMUW4fXu3ap1D
         thmurNpmoyid6wvXNvq6goie6prMr8SExkzSwDwQD0pLBphJ/pw+MY4HwbXCjyi1UL2R
         IZrmRPjHmehXbKvrm149klYvQEeLmgWytAnLYO2GWklk922aiAsmU2JlvpiLETL6Nic7
         Hh2ZDDQVlJ9OF3MlzxlElZGK4gWor6tjT6O5INJ2lPE1PSVyAFyoSXDhecHmJJMyzdyF
         j8wJwtXyqAxxDlj9aRyMt2i/rJUtED3BKm9KbgpYsNj+TNWA5ec1K3hl4NeqD/pp+x2D
         I36Q==
X-Forwarded-Encrypted: i=1; AL+hErHqKb6xmAkGDsfFIxf3osy41zQ72ViLbVDZQDaKWgYifYrlASliVUhjcH4seQOmp6QoEKmPTaS5wTK8ZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZhrQ1zowXcjkbfj4A+24ErqgoaC8LG4N4sP2krDU9RTExRwFF
	Dbv69BH6U/CKk9Yz+mSbFDmiSPv6qzkyq04MAeBo91TTJqnBSJ3OkG0+
X-Gm-Gg: AYBFou08Za+SmBx4F/r8+FpEN+9X3bJa96Twt3QDlHKni+TZzSxRRdiaMraPaUp/Bja
	dehm8hG2+G9dUzPa7U4UI/fvJD5eTH1Q3ouws9/blasfQJZ/oXGHojLGDN5fovZYM39+U6NitIh
	1LGDTP5MoOBSQ+1F6Z8ldjEwk0pG4jRw65TY052KSaVjLsNFJxgOpTlOk/gTt+mH16vuMRAqOF7
	l0ejOgYhn+WPrmkaxCaG40J5+LFv+CSG8OdhdNRTObu3ia3vhQQPVKDgPQa8t4X/fiHfY5wdNRP
	jrB+cJhMlwsbKle4GW2F5T8teF7RhuCDNhiIN+CbYCr6Z4OHUGx8dpodqjP3CABFEeInnSYjI57
	iHOCrA5PZKXghAyZPfMHPYCG6gq/pkGL8VhOlowkoEU5/M18n+rEHtsCAkRKINKnLC+MGPjiLiR
	dROJJIbPZTBSzbXxR0eBNrkX+OOiG5/zFzKAyd0GuikjG5z73fmNxyLtUyUjDTVWy/UaYbYYyGL
	QcYG9ODYFA34wVIQOGD27z42rlV+wcN6NTfKfvWBoN2iBWzgDuQgnFv6UA0/KPij+WwNh0iDp/T
	mFcRSYsSjJ2RnnERzOerbBDX5tVT
X-Received: by 2002:a05:600c:3115:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4bb55aa4935mr137880785e9.32.1794697710085;
        Sat, 14 Nov 2026 15:08:30 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:29 -0800 (PST)
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
Subject: [PATCH v3 02/16] HID: ft260: uart: fix the serial driver
Date: Sun, 15 Nov 2026 01:07:46 +0200
Message-ID: <20261114230800.1344401-3-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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
FT260_WR_UART_DATA_MAX (60) array rather than a __counted_by()
flexible array, which describes a runtime-counted allocation this
path no longer makes.

The FT260 enters power-save after ~5s idle, which drops RX data at
higher baud rates. Keep a timed dummy wakeup, but only when needed:
skip it at 4800 baud or less and when EEPROM disables power-save;
avoid configuring baud or disabling the workaround twice. Arm the timer
when a baud change or the start of a tty session enables the
workaround.
Otherwise the chip can enter power-save before the first RX character
arrives, and that character is lost.

The received report length was validated against the actual HID report
size only on the I2C path. The UART path instead bounded the
device-supplied length against FT260_RD_DATA_MAX (180), which is the
maximum I2C read payload, not a bound on the report buffer. As a UART
payload cannot exceed FT260_WR_UART_DATA_MAX (60) bytes, a report
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
re-arm the timer.

Shut the wakeup timer down and cancel its work in
ft260_uart_port_remove(), before the tty hangup. A tty call during
removal can then not re-arm the timer, and the probe error path also
cancels the work. Return -ENODEV for an unknown chip mode, so that
probe does not return 0 after it frees dev. Keep the port list sorted
by index, so that a re-added port does not get an index that is in use.

Send UART data from a work item. The tty write() callback may not
sleep, and sending a USB report sleeps. The work item is the only user
of the TX buffer. It takes data out of the FIFO before it builds a
report and stops when the FIFO is empty, so a FIFO reset cannot make
it loop. When it is done, it wakes up the writers. In
ft260_uart_port_remove(), the work is disabled after the tty hangup,
which waits for a running write(), and before the FIFO is freed, so
neither of them uses the FIFO after it is freed.

Register the tty device last in ft260_uart_probe(), so that userspace
cannot open it before the UART is configured.

Pass UART reports to the tty code only on the UART interface. The I2C
interface has no initialized tty port.

A UART report carries at most 60 data bytes after a 2-byte header, and
the UART report IDs end at 0xFE (AN_394, sections 4.3 and 4.6.2). Limit
a TX report to 60 bytes, so that 61 or 62 bytes do not give the
undefined report ID 0xFF.

Report 0xE1 is defined as FT260_UART_RI_DCD_STATUS, but AN_394 section
4.3 lists 0xE2 for "UART RI and DCD Status". Correct the value. The
macro has no user.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fixes for the issues reported by Sashiko: 0xB1 length check,
wakeup timer re-arm.

v3:
Fixes for the issues reported by Sashiko:
- Wakeup timer shut down and its work cancelled in
  ft260_uart_port_remove(), so a tty call during removal cannot
  re-arm it; the probe error path also cancels the work.
- -ENODEV for an unknown chip mode, so probe does not return 0 after
  it frees dev.
- Port list sorted by index, so a re-added port does not get an index
  that is in use.
- TX from a work item, because write() may not sleep; no shared
  buffer, no endless loop on a FIFO reset; disabled before the FIFO is
  freed.
- TTY registered last, so userspace cannot open it before the UART is
  configured.
- UART reports passed to the tty code only on the UART interface; the
  I2C interface has no tty port.
- TX report limited to 60 bytes, so 61 or 62 bytes do not give the
  undefined report ID 0xFF.
- Unneeded ft260_uart_wakeup() prototype removed, changelog text
  corrected.
- port_activate() sets the wakeup workaround from the baud rate and
  arms the timer only when it is on, as ft260_uart_change_speed() does.
---
 drivers/hid/hid-ft260.c | 409 +++++++++++++++++++++++-----------------
 1 file changed, 233 insertions(+), 176 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 982e2ca7a2de..8d72a22d7a07 100644
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
+#define FT260_WR_UART_DATA_MAX 60
 
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
@@ -314,25 +332,24 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
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
+	struct work_struct tx_work;
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
@@ -343,8 +360,7 @@ struct ft260_device {
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
-					unsigned char report_id, u8 *data,
-					size_t len)
+					u8 report_id, u8 *data, size_t len)
 {
 	u8 *buf;
 	int ret;
@@ -473,8 +489,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
-		hid_dbg(hdev, "%s: failed to start transfer, ret %d\n",
-			__func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -516,7 +530,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	int ret, wr_len, idx = 0;
 	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (len < 1)
 		return -EINVAL;
@@ -524,12 +538,12 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
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
@@ -565,7 +579,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (data_len >= sizeof(rep->data))
 		return -EINVAL;
@@ -585,6 +599,8 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 		  rep->report, addr, cmd, rep->length, len);
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	if (ret < 0)
+		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
 
 	return ret;
 }
@@ -703,8 +719,7 @@ static int ft260_i2c_write_read(struct ft260_device *dev, struct i2c_msg *msgs)
 		else
 			read_off = *msgs[0].buf;
 
-		ft260_dbg("%s: off %#x rlen %d wlen %d\n", __func__,
-			read_off, rd_len, wr_len);
+		ft260_dbg("off %#x rlen %d wlen %d\n", read_off, rd_len, wr_len);
 	}
 
 	ret = ft260_i2c_write(dev, addr, msgs[0].buf, wr_len,
@@ -937,27 +952,28 @@ static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device
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
+	default:
+		hid_err(hdev, "unknown chip mode: %d\n", cfg.chip_mode);
+		return -ENODEV;
 	}
 
+	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1101,12 +1117,34 @@ static const struct attribute_group ft260_attr_group = {
 	}
 };
 
-/***
- * START Serial dev part
- */
 static DEFINE_MUTEX(ft260_uart_list_lock);
 static LIST_HEAD(ft260_uart_device_list);
 
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
@@ -1123,8 +1161,8 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	int index = 0, ret = 0;
 	struct ft260_device *dev;
 
-	spin_lock_init(&port->write_lock);
-	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
+	spin_lock_init(&port->xmit_fifo_lock);
+	if (kfifo_alloc(&port->xmit_fifo, XMIT_FIFO_SIZE, GFP_KERNEL))
 		return -ENOMEM;
 
 	mutex_lock(&ft260_uart_list_lock);
@@ -1135,7 +1173,8 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	}
 
 	port->index = index;
-	list_add_tail(&port->device_list, &ft260_uart_device_list);
+	/* Before the first gap, or at the end: the list stays sorted */
+	list_add_tail(&port->device_list, &dev->device_list);
 	mutex_unlock(&ft260_uart_list_lock);
 
 	return ret;
@@ -1148,7 +1187,12 @@ static void ft260_uart_port_put(struct ft260_device *port)
 
 static void ft260_uart_port_remove(struct ft260_device *port)
 {
-	timer_delete_sync(&port->wakeup_timer);
+	/*
+	 * Shut down, not delete: a tty call before the hangup below
+	 * must not re-arm the timer.
+	 */
+	timer_shutdown_sync(&port->wakeup_timer);
+	cancel_work_sync(&port->wakeup_work);
 
 	mutex_lock(&ft260_uart_list_lock);
 	list_del(&port->device_list);
@@ -1156,12 +1200,15 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 
 	tty_port_tty_vhangup(&port->port);
 
-	spin_lock(&port->write_lock);
+	/* Disable, not cancel: a racing write must not queue it again */
+	disable_work_sync(&port->tx_work);
+
+	spin_lock(&port->xmit_fifo_lock);
 	kfifo_free(&port->xmit_fifo);
-	spin_unlock(&port->write_lock);
+	spin_unlock(&port->xmit_fifo_lock);
 }
 
-static struct ft260_device *ft260_uart_port_get(unsigned int index)
+static struct ft260_device *ft260_uart_port_get(int index)
 {
 	struct ft260_device *port;
 
@@ -1207,61 +1254,51 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 	struct kfifo *xmit = &port->xmit_fifo;
 	struct tty_struct *tty;
 	struct ft260_uart_write_request_report *rep;
-	int len, data_len, ret = 0;
+	int len, ret = 0;
 
 	tty = tty_port_tty_get(&port->port);
+	if (!tty)
+		return -EINVAL;
 
-	data_len = kfifo_len(xmit);
-	if (!tty || !data_len) {
-		ret = -EINVAL;
-		goto tty_out;
-	}
-
-	rep = (struct ft260_uart_write_request_report *)port->write_buf;
-
-	do {
-		len = min(data_len, FT260_WR_DATA_MAX);
+	rep = (struct ft260_uart_write_request_report *)port->uart_wr_buf;
 
+	while ((len = kfifo_out_spinlocked(xmit, rep->data,
+					   FT260_WR_UART_DATA_MAX,
+					   &port->xmit_fifo_lock)) > 0) {
 		rep->report = FT260_UART_DATA_REPORT_ID(len);
 		rep->length = len;
 
-		len = kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
-
-		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
-		if (ret < 0) {
-			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
-			goto tty_out;
-		}
+		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + 2);
+		if (ret < 0)
+			break;
 
-		data_len -= len;
 		port->icount.tx += len;
-	} while (data_len > 0);
-
-	len = kfifo_len(xmit);
-	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
-		tty_wakeup(tty);
-
-	ret = 0;
+	}
 
-tty_out:
+	tty_wakeup(tty);
 	tty_kref_put(tty);
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
-static int ft260_uart_receive_chars(struct ft260_device *port,
-				    u8 *data, u8 length)
+static void ft260_uart_tx_work(struct work_struct *work)
 {
-	struct hid_device *hdev = port->hdev;
-	int ret = 0;
+	struct ft260_device *port =
+		container_of(work, struct ft260_device, tx_work);
+	int ret;
 
-	if (length > FT260_RD_DATA_MAX) {
-		hid_err(hdev, "Received too much data (%d)\n", length);
-		return -EBADR;
-	}
+	ret = ft260_uart_transmit_chars(port);
+	if (ret < 0)
+		ft260_dbg("failed to transmit %d\n", ret);
+}
+
+static int ft260_uart_receive_chars(struct ft260_device *port, u8 *data, u8 length)
+{
+	int ret;
 
 	ret = tty_insert_flip_string(&port->port, data, length);
 	if (ret != length)
-		hid_err(hdev, "%d char not inserted to flip buffer\n", length - ret);
+		ft260_dbg("%d char not inserted to flip buf\n", length - ret);
+
 	port->icount.rx += ret;
 
 	if (ret)
@@ -1271,18 +1308,16 @@ static int ft260_uart_receive_chars(struct ft260_device *port,
 }
 
 static ssize_t ft260_uart_write(struct tty_struct *tty, const u8 *buf,
-				 size_t count)
+				 size_t cnt)
 {
 	struct ft260_device *port = tty->driver_data;
-	struct hid_device *hdev = port->hdev;
-	int len, ret;
+	ssize_t len;
 
-	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
-	ft260_dbg("count: %zu, len: %d", count, len);
+	len = kfifo_in_spinlocked(&port->xmit_fifo, buf, cnt,
+				  &port->xmit_fifo_lock);
+	ft260_dbg("count: %zu, len: %zd", cnt, len);
 
-	ret = ft260_uart_transmit_chars(port);
-	if (ret < 0)
-		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
+	schedule_work(&port->tx_work);
 
 	return len;
 }
@@ -1291,7 +1326,7 @@ static unsigned int ft260_uart_write_room(struct tty_struct *tty)
 {
 	struct ft260_device *port = tty->driver_data;
 
-	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
+	return kfifo_avail(&port->xmit_fifo);
 }
 
 static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
@@ -1307,7 +1342,8 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 {
 	struct hid_device *hdev = port->hdev;
 	unsigned int baud;
-	struct ft260_configure_uart_request req;
+	struct ft260_configure_uart_request_report req;
+	bool wakeup_workaraund = false;
 	int ret;
 
 	memset(&req, 0, sizeof(req));
@@ -1321,7 +1357,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		break;
 	case CS5:
 	case CS6:
-		hid_err(hdev, "Invalid data bit size, setting to default (8 bit)\n");
+		hid_err(hdev, "invalid data bit size, setting a default\n");
 		req.data_bit = FT260_UART_CFG_DATA_BITS_8;
 		termios->c_cflag &= ~CSIZE;
 		termios->c_cflag |= CS8;
@@ -1346,13 +1382,21 @@ static int ft260_uart_change_speed(struct ft260_device *port,
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
@@ -1360,7 +1404,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	else
 		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
 
-	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
+	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
 	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
 		  req.data_bit, req.parity,
@@ -1371,7 +1415,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
+		hid_err(hdev, "failed to change termios: %d\n", ret);
 
 	return ret;
 }
@@ -1425,8 +1469,8 @@ static int ft260_uart_proc_show(struct seq_file *m, void *v)
 {
 	int i;
 
-	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n",
-			"", "", "");
+	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n", "", "", "");
+
 	for (i = 0; i < UART_COUNT_MAX; i++) {
 		struct ft260_device *port = ft260_uart_port_get(i);
 
@@ -1481,15 +1525,16 @@ static const struct tty_operations ft260_uart_ops = {
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
@@ -1503,53 +1548,69 @@ static void ft260_uart_start_wakeup(struct timer_list *t)
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
+	ft260_uart_wakeup_workaraund_enable(port,
+					    baudrate > FT260_UART_EN_PW_SAVE_BAUD);
+
+	ft260_dbg("configured baudrate = %d", baudrate);
+
+	if (port->reschedule_work)
 		mod_timer(&port->wakeup_timer, jiffies +
 			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
-	}
 
 	return 0;
 }
@@ -1563,8 +1624,8 @@ static void ft260_uart_port_destroy(struct tty_port *tport)
 }
 
 static const struct tty_port_operations ft260_uart_port_ops = {
-	.shutdown = ft260_uart_shutdown,
-	.activate = ft260_uart_activate,
+	.shutdown = ft260_uart_port_shutdown,
+	.activate = ft260_uart_port_activate,
 	.destruct = ft260_uart_port_destroy,
 };
 
@@ -1613,14 +1674,14 @@ static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
 
 static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 {
-	struct ft260_configure_uart_request req;
+	struct ft260_configure_uart_request_report req;
 	int ret;
 	struct device *devt;
 
 	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
-	// FIXME: Do I need that if I have cancel_work_sync?
+	INIT_WORK(&dev->tx_work, ft260_uart_tx_work);
 	// FIXME: are all kfifo access secured by lock? with irq or not?
-	dev->reschedule_work = false;
+	ft260_uart_wakeup_workaraund_enable(dev, true);
 	/* Work not started at this point */
 	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
 
@@ -1632,19 +1693,8 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 		hid_err(hdev, "failed to add port\n");
 		goto err_port;
 	}
-	devt = tty_port_register_device_attr(&dev->port,
-					     ft260_tty_driver,
-					     dev->index, &hdev->dev,
-					     dev, NULL);
-	if (IS_ERR(devt)) {
-		hid_err(hdev, "failed to register tty port\n");
-		ret = PTR_ERR(devt);
-		goto err_register_tty;
-	}
-	hid_info(hdev, "Registering device /dev/%s%d\n",
-		ft260_tty_driver->name, dev->index);
 
-	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
+	/* Configure UART to 9600n8 */
 	req.report	= FT260_SYSTEM_SETTINGS;
 	req.request	= FT260_SET_UART_CONFIG;
 	req.flow_ctrl	= FT260_UART_CFG_FLOW_CTRL_NONE;
@@ -1656,16 +1706,25 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0) {
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
-			ret);
+		hid_err(hdev, "failed to configure uart: %d\n", ret);
+		goto err_hid_report;
+	}
+
+	devt = tty_port_register_device_attr(&dev->port,
+					     ft260_tty_driver,
+					     dev->index, &hdev->dev,
+					     dev, NULL);
+	if (IS_ERR(devt)) {
+		hid_err(hdev, "failed to register tty port\n");
+		ret = PTR_ERR(devt);
 		goto err_hid_report;
 	}
+	hid_info(hdev, "registering device /dev/%s%d\n",
+		ft260_tty_driver->name, dev->index);
 
 	return 0;
 
 err_hid_report:
-	tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
-err_register_tty:
 	ft260_uart_port_remove(dev);
 err_port:
 	timer_delete_sync(&dev->wakeup_timer);
@@ -1680,9 +1739,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
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
@@ -1730,7 +1789,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_set_drvdata(hdev, dev);
 	dev->hdev = hdev;
 
-	if (!dev->ft260_is_serial) {
+	if (dev->iface_type == FT260_IFACE_I2C) {
 		ret = ft260_i2c_probe(hdev, dev);
 		if (ret)
 			goto err_hid_close;
@@ -1765,9 +1824,7 @@ static void ft260_remove(struct hid_device *hdev)
 	if (!dev)
 		return;
 
-	if (dev->ft260_is_serial) {
-		timer_delete_sync(&dev->wakeup_timer);
-		cancel_work_sync(&dev->wakeup_work);
+	if (dev->iface_type == FT260_IFACE_UART) {
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
 		ft260_uart_port_remove(dev);
@@ -1779,7 +1836,7 @@ static void ft260_remove(struct hid_device *hdev)
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	if (dev->ft260_is_serial)
+	if (dev->iface_type == FT260_IFACE_UART)
 		ft260_uart_port_put(dev);
 	else
 		kfree(dev);
@@ -1797,6 +1854,13 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -1804,13 +1868,6 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -1837,12 +1894,12 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 		return 0;
 
-	} else if (xfer->length > FT260_RD_DATA_MAX) {
-		hid_err(hdev, "received data too long (%d)\n", xfer->length);
-		return -EBADR;
-	} else if (xfer->report >= FT260_UART_REPORT_MIN &&
+	} else if (dev->iface_type == FT260_IFACE_UART &&
+		   xfer->report >= FT260_UART_REPORT_MIN &&
 		   xfer->report <= FT260_UART_REPORT_MAX) {
 		return ft260_uart_receive_chars(dev, xfer->data, xfer->length);
+	} else if (xfer->report == FT260_UART_INTERRUPT_STATUS) {
+		return 0;
 	}
 	hid_err(hdev, "unhandled report %#02x\n", xfer->report);
 
@@ -1887,7 +1944,7 @@ static int __init ft260_driver_init(void)
 		goto err_reg_driver;
 	}
 
-	ret = hid_register_driver(&(ft260_driver));
+	ret = hid_register_driver(&ft260_driver);
 	if (ret) {
 		pr_err("hid_register_driver failed: %d\n", ret);
 		goto err_reg_hid;
@@ -1905,7 +1962,7 @@ static int __init ft260_driver_init(void)
 
 static void __exit ft260_driver_exit(void)
 {
-	hid_unregister_driver(&(ft260_driver));
+	hid_unregister_driver(&ft260_driver);
 	tty_unregister_driver(ft260_tty_driver);
 	tty_driver_kref_put(ft260_tty_driver);
 }
-- 
2.43.0

