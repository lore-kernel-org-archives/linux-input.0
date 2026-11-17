Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945912;
	b=XybjOPJuTAJ03yfb6GV4gwfdthGs6hjSvFk7jPzJ5nF3gYS6/qHy6EgblGi+CpKFU8bp
	 0PpxxW3XeKjjDBAr3dEhhoGMbxcNzD/yGell2BO+kSBcN33qSgLgpsmyCj9aJ4NlKI8Jb
	 ZOv4kgDbzjQXhNzx4a9qPFsL8oICtFaEa8zt+sOmGCMrWzO+9JgTba2RDDyCglFrgT1Yu
	 h850umU4k7IS/0bfuIvHJUMwrAU6XzjtqYewk+eiLzaUza9Xne/xhXnlu8ut78W60yteL
	 oiK18s2lkwXWUGAN+ZxvMgf8fN9bAX3op2/TulSvaDHxy3HyOlsr7SrHDF03q0IpuEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m0deLgsQ5BJNoqRsQzeAGYeWBAdDB6Fo43T1FAm6vZo=;
	b=Vh/ZtTaKuHzGEXCGuBTETJVD7dBU5ZXMC6KZqsW4aZnFGO72QMI2JjkS7cyKIS4FMQUp
	 G77lbCGi4kO4C2SsBG6YnNfpIR9mTKn8O6daolqz9XAb2zPeUxDKw8+43764JEqkG8RQg
	 QpXYzRNFJ1MHdGkkYKjE3wSG6jOvfnWOt5sIW/if8DCo3JYniH0cPbuE4G6nL6y01d5gj
	 6vyB1pev1yZ6swNgGLuhEoiNqRsfTsLy24Gk8oa9eP3DwBzUB3N3Jc4Je/po6lRu0fY+Y
	 UU++PFfLgnIcDvT6pybajd05lMJWVXLYSGBYeZCu/S8N2ryv4IZvaBmBhEjMbWAU9Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNaRhr3c;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F560A382B
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 140F560A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNaRhr3c
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a33359c1b3so97081f8f.3
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945909; x=1795550709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0deLgsQ5BJNoqRsQzeAGYeWBAdDB6Fo43T1FAm6vZo=;
        b=eNaRhr3cvj6DC2WVg2AA0/SS6NZA9ePpwyN1DPeDTfMOKvJK9mqAER1yB96e9jVSO0
         BCXwwHFRyStnJi85J044wcouxPi1qSf0rocDx4XcP1H2gqylL0TeKKTQUz9c/SsbFnuD
         vzZ6GQ2AV0lEoYIt1RyaHcByALs3q3CzpBh7CmWzJu63A/Pza4WTdlDBP4w2R/bVuS0a
         CWdto37BIXzWoT3DZ8LgW3tfifqrWPlDS6i3PVdSdosQu6QTnuhY+MrVqZvHhFTYnhiY
         ahzQ0wAyCSvwPIOOA6GHkfpKMyyh6rva4Uw/zf+OoHwxANC9jjDIsnI5WWFrlR7D/x+v
         /BlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945909; x=1795550709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0deLgsQ5BJNoqRsQzeAGYeWBAdDB6Fo43T1FAm6vZo=;
        b=AbYW3NpYyv1RT1dcZFt+otSvp7b+Txm6WDWmLLIlSq0ziwBO267Xs5O6l1TktKwcOa
         ZX6fvOFxw/piFYLhiX0nmcQr/lrnQbetmmS0Rv3YJZOnjZhEvSjOFynZqPnMgGRta4MZ
         Oh5LBg2VaFJSje1Vpv/kI58gzj7IblwWSDAkGtd+6Sgritkj7uULywMD+Pwo9L+pnGoF
         sIJMfRsKGrOxMMy9oiqRGsWF/5Yerz+awVLxrC2GQYeD12cCLIUtIjh1cJoUDDJFO/z9
         g001HMTe/EDyts5qhAJ6Y3Ax2GlSDffYp2Np5Prdp6t2BhfwAIeMCuFy3+kZDDb05Op5
         lOdQ==
X-Forwarded-Encrypted: i=1; AL+hErE3cQumSuhjYZ9pLfaKgU4x/W1/Birn55Z9qtqd0S2g7erRnZM2A6QOJMd9BkE7QjE2csjd5QXKzd74Ew==@vger.kernel.org
X-Gm-Message-State: APuU4Z8U1Gw5wmsoeJPi223bnj+iinHsxgdLJXw6oqx2Bjzavqhr5OHC
	O9w1adFS2F/9bo0YYN715Aq/AZZ6Xj4dwQFozoVle+iCYnrHDeGNsY98
X-Gm-Gg: AYBFou2QYmYaAQYsiyqP1wl0indwTsPG/DBN06cY/ZfJTUkcl2JjX6qmfNM0sSasLhy
	6jX/4ed/TGvp3dKRbGk/wEebtvkYvmmVLTnd50k4PpsJpuoUpwB8+aRs3gTrBImt2Hu3zgULP75
	Kncp45WW12QRDhoWEr2Mc1OGEdXcv6dwketmAY1VwT9yjNQe0l0YEbGrSA007KZZ+TGu4fDUJU8
	CJ4c6BpZEtLy3SG/CPiMXi+OA0C8NM9EEQwzZjTqxtIkZDm7pC7NM7xS8ChoQOA7PKotyO6QPLo
	/D5hWo9L6tn34PW8T+IFDmCyuvJ+XP/Ov9iRzY87YWQsQq+5J1pIyIfWNnCbHUsjqDe/QY8gITu
	bCV6bkSy6yfvDQW8mdsicztgla4Y3xqdNkF/3AAV0lomu48Ak8LwyR1zi3f819Zfz2VWznrrnJ9
	qNNWvB3js/vmn0vjkA8TaGaecWH+zZPYVgzUGUNIchkf1q3Hzg/NL4lR/jZxind9xX1dnWKJQI9
	Lqfx3UOHj7mScn99GyWRrocoyEdg7mTeagALm5LgzGSz2IN7qTLq2fKm0iEMuP/SORRV+J6stZZ
	H3vSt6s+qEMB/rfBIqqvT/sFn0j/
X-Received: by 2002:a05:600c:4ecf:b0:4bb:5345:606b with SMTP id 5b1f17b1804b1-4bb7da39144mr5060645e9.31.1794945908569;
        Tue, 17 Nov 2026 12:05:08 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:08 -0800 (PST)
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
Subject: [PATCH v4 03/16] HID: ft260: add GPIO support
Date: Tue, 17 Nov 2026 22:04:09 +0200
Message-ID: <20261117200423.19561-4-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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

Add gpiochip support for the FT260 multifunctional pins, including
GPIO2/GPIOA/GPIOG function selection via sysfs, and enable the
available GPIOs according to the active UART mode.

This supersedes the earlier pre-UART GPIO series:
https://lore.kernel.org/lkml/20230211115752.26276-2-michael.zaidman@gmail.com/

The change of the gpio_chip.set callback to return int, as the current
gpiolib API requires, is based on a patch by Rio Liu <rio@r26.me>.

A pin set or direction change reads the FT260_GPIO report from the
chip, changes the bits of that one pin and writes the report back. The
other pins keep the state that the chip has, not a cached copy that
can be zero. A change to output writes the direction and the value in
the same report, and the error of a failed write goes back to gpiolib.

The driver keeps in gpio_en the pins that work as GPIOs. A uart_mode
change removes from gpio_en the pins that the new flow control mode
uses and adds the UART pins that it leaves free. Pins outside the UART
do not change, and an unknown mode value is ignored. While uart_dcd_ri
selects DCD and RI, GPIO4 and GPIO5 stay out of gpio_en, also after a
uart_mode change.

The gpio_chip is embedded in ft260_device. The enabled-GPIO mask is
printed only when the "debug" module parameter is set.

The gpiochip is not devm: ft260_remove() frees dev before the devm
actions run, so it removes the chip itself before it stops the HID
device.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fixes for the issues reported by Sashiko:
- The GPIO state is read before a write, so a set does not clobber
  other pins with a zero shadow.
- Direction and value in one feature report.
- UART mode OFF clears only UART-owned bits; an out-of-range uart_mode
  index is rejected.

v3:
Fixes for the issues reported by Sashiko:
- The gpiochip is registered without devm and removed in
  ft260_remove(), so a GPIO write that races an unbind does not use
  the freed dev.
- The uart_dcd_ri setting is kept across UART mode changes, so a mode
  change does not give GPIO4 and GPIO5 back to the GPIO function while
  they are DCD and RI.

A new test, test_gpio_unbind.py, races writes to gpioN/value against
unbind of the gpiochip owner. With the v2 code, on a 7.3.0 KASAN
kernel (hid/for-next 720806515cb6 plus this series,
CONFIG_KASAN_GENERIC and PROVE_LOCKING), it failed in the first cycle:
KASAN reported a slab-use-after-free write of size 4 in
ft260_gpio_set(), on memory that kfree() in ft260_uart_port_destroy()
had freed, called from ft260_remove(). With this patch, 20 cycles pass
with no report.

Struct gpio_chip embedded in ft260_device, label from
devm_kasprintf(), the "initialize gpio chip" messages dropped and
"enabled GPIOs" moved to debug output (Bartosz Golaszewski).

v4:
ft260_uart_change_speed() does not take port->lock here any more,
because patch 2 takes it for the whole function since v4.
---
 drivers/hid/Kconfig     |  10 +-
 drivers/hid/hid-ft260.c | 615 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 575 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 670bce481c42..122a5b816d2c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -386,12 +386,12 @@ config HID_EZKEY
 	Support for Ezkey BTC 8193 keyboard.
 
 config HID_FT260
-	tristate "FTDI FT260 USB HID to I2C/UART host support"
-	depends on USB_HID && HIDRAW && I2C && TTY
+	tristate "FTDI FT260 USB HID to I2C/UART/GPIO host support"
+	depends on USB_HID && HIDRAW && I2C && TTY && GPIOLIB
 	help
-	  Provides I2C host adapter and UART/TTY functionality over USB-HID
-	  through the FT260 device. The customizable USB descriptor fields
-	  are exposed as sysfs attributes.
+	  Provides I2C host adapter, UART/TTY, and GPIO functionality over
+	  USB-HID through the FT260 device. The customizable USB descriptor
+	  fields are exposed as sysfs attributes.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called hid-ft260.
diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 869e7b924b30..acd92248256f 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -19,6 +19,8 @@
 #include <linux/tty_flip.h>
 #include <linux/minmax.h>
 #include <linux/unaligned.h>
+#include <linux/bits.h>
+#include <linux/gpio/driver.h>
 
 #ifdef DEBUG
 static int ft260_debug = 1;
@@ -57,6 +59,11 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 #define FT260_RD_DATA_MAX 180
 #define FT260_WR_I2C_DATA_MAX 60
 #define FT260_WR_UART_DATA_MAX 60
+#define FT260_GPIOCHIP "ft260_gpio"
+#define FT260_GPIO_0_5_COUNT 6
+#define FT260_GPIO_A_H_COUNT 8
+#define FT260_GPIO_TOTAL (FT260_GPIO_0_5_COUNT + FT260_GPIO_A_H_COUNT)
+#define FT260_GPIO_MASK GENMASK(FT260_GPIO_TOTAL - 1, 0)
 
 /*
  * Device interface configuration.
@@ -151,7 +158,65 @@ enum {
 	FT260_IFACE_UART
 };
 
-#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | report_id)
+/* Multi-function pin functions */
+enum {
+	FT260_MFPIN_GPIO		= 0x00,
+	FT260_MFPIN_SUSPOUT		= 0x01,
+	FT260_MFPIN_PWREN		= 0x02,
+	FT260_MFPIN_TX_ACTIVE		= 0x03,
+	FT260_MFPIN_TX_LED		= 0x04,
+	FT260_MFPIN_RX_LED		= 0x05,
+	FT260_MFPIN_BCD_DET		= 0x06,
+};
+
+enum {
+	FT260_GPIO_VALUE		= 0x00,
+	FT260_GPIO_DIRECTION		= 0x01,
+	FT260_GPIO_DIR_INPUT		= 0x00,
+	FT260_GPIO_DIR_OUTPUT		= 0x01,
+};
+
+/* GPIO offsets */
+#define FT260_GPIO_0		BIT(0)
+#define FT260_GPIO_1		BIT(1)
+#define FT260_GPIO_2		BIT(2)
+#define FT260_GPIO_3		BIT(3)
+#define FT260_GPIO_4		BIT(4)
+#define FT260_GPIO_5		BIT(5)
+#define FT260_GPIO_A		BIT(FT260_GPIO_0_5_COUNT + 0)
+#define FT260_GPIO_B		BIT(FT260_GPIO_0_5_COUNT + 1)
+#define FT260_GPIO_C		BIT(FT260_GPIO_0_5_COUNT + 2)
+#define FT260_GPIO_D		BIT(FT260_GPIO_0_5_COUNT + 3)
+#define FT260_GPIO_E		BIT(FT260_GPIO_0_5_COUNT + 4)
+#define FT260_GPIO_F		BIT(FT260_GPIO_0_5_COUNT + 5)
+#define FT260_GPIO_G		BIT(FT260_GPIO_0_5_COUNT + 6)
+#define FT260_GPIO_H		BIT(FT260_GPIO_0_5_COUNT + 7)
+
+/* GPIO groups */
+#define FT260_GPIO_WAKEUP		FT260_GPIO_3
+#define FT260_GPIO_I2C_DEFAULT		(FT260_GPIO_0 | FT260_GPIO_1)
+#define FT260_GPIO_UART_RX_TX		(FT260_GPIO_C | FT260_GPIO_D)
+#define FT260_GPIO_UART_DCD_RI		(FT260_GPIO_4 | FT260_GPIO_5)
+#define FT260_GPIO_UART_RTS_CTS		(FT260_GPIO_B | FT260_GPIO_E)
+#define FT260_GPIO_UART_DTR_DSR		(FT260_GPIO_F | FT260_GPIO_H)
+#define FT260_GPIO_UART_MODE_0_SET	(FT260_GPIO_UART_RX_TX | \
+					 FT260_GPIO_UART_DCD_RI | \
+					 FT260_GPIO_UART_RTS_CTS | \
+					 FT260_GPIO_UART_DTR_DSR)
+#define FT260_GPIO_UART_MODE_1_SET	FT260_GPIO_UART_DTR_DSR
+#define FT260_GPIO_UART_MODE_2_SET	FT260_GPIO_UART_RTS_CTS
+#define FT260_GPIO_UART_MODE_3_SET	(FT260_GPIO_UART_RTS_CTS | \
+					 FT260_GPIO_UART_DTR_DSR)
+#define FT260_GPIO_UART_MODE_4_SET	FT260_GPIO_UART_MODE_3_SET
+#define FT260_GPIO_UART_DEFAULT		FT260_GPIO_UART_MODE_0_SET
+#define FT260_GPIO_UART_MODE_1_CLR	(FT260_GPIO_UART_RX_TX | \
+					 FT260_GPIO_UART_RTS_CTS)
+#define FT260_GPIO_UART_MODE_2_CLR	(FT260_GPIO_UART_RX_TX | \
+					 FT260_GPIO_UART_DTR_DSR)
+#define FT260_GPIO_UART_MODE_3_CLR	FT260_GPIO_UART_RX_TX
+#define FT260_GPIO_UART_MODES		5
+
+#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
 
@@ -171,10 +236,10 @@ struct ft260_get_system_status_report {
 	u8 uart_mode;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
 				/* 3 - XON_XOFF, 4 - No flow control */
 	u8 hid_over_i2c_en;	/* 0 - disabled, 1 - enabled */
-	u8 gpio2_function;	/* 0 - GPIO,  1 - SUSPOUT, */
+	u8 gpio2_func;		/* 0 - GPIO,  1 - SUSPOUT, */
 				/* 2 - PWREN, 4 - TX_LED */
-	u8 gpioA_function;	/* 0 - GPIO, 3 - TX_ACTIVE, 4 - TX_LED */
-	u8 gpioG_function;	/* 0 - GPIO, 2 - PWREN, */
+	u8 gpioa_func;		/* 0 - GPIO, 3 - TX_ACTIVE, 4 - TX_LED */
+	u8 gpiog_func;		/* 0 - GPIO, 2 - PWREN, */
 				/* 5 - RX_LED, 6 - BCD_DET */
 	u8 suspend_out_pol;	/* 0 - active-high, 1 - active-low */
 	u8 enable_wakeup_int;	/* 0 - disabled, 1 - enabled */
@@ -202,6 +267,18 @@ struct ft260_get_uart_settings_report {
 	u8 breaking;		/* 0: no break */
 } __packed;
 
+struct ft260_gpio_state {
+	u8 vals;		/* GPIO[0-5] values in bits 0 - 5 */
+	u8 dirs;		/* GPIO[0-5] directions, 0 - in, 1 - out */
+	u8 ex_vals;		/* GPIO[A-H] values in bits 0 - 7 */
+	u8 ex_dirs;		/* GPIO[A-H] directions, 0 - in, 1 - out */
+} __packed;
+
+struct ft260_gpio_read_request_report {
+	u8 report;		/* FT260_GPIO */
+	struct ft260_gpio_state	gpio;
+} __packed;
+
 /* Feature Out reports */
 
 struct ft260_set_system_clock_report {
@@ -223,6 +300,12 @@ struct ft260_set_uart_mode_report {
 				/* 3 - XON_XOFF, 4 - No flow control */
 } __packed;
 
+struct ft260_set_uart_dcd_ri_report {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_ENABLE_UART_DCD_RI */
+	u8 uart_dcd_ri;		/* Pins func: 0 - GPIO4,GPIO5, 1 - DCD,RI */
+} __packed;
+
 struct ft260_set_i2c_reset_report {
 	u8 report;		/* FT260_SYSTEM_SETTINGS */
 	u8 request;		/* FT260_SET_I2C_RESET */
@@ -234,6 +317,33 @@ struct ft260_set_i2c_speed_report {
 	__le16 clock;		/* I2C bus clock in range 60-3400 KHz */
 } __packed;
 
+struct ft260_set_gpio2_func_report {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_SELECT_GPIO2_FUNC */
+	u8 gpio2_func;		/* Pin func: 0 - GPIO, 1 - SUSPOUT, */
+				/* 2 - PWREN# (active-low), 4 - TX_LED */
+} __packed;
+
+struct ft260_set_gpioa_func_report {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_SELECT_GPIOA_FUNC */
+	u8 gpioa_func;		/* Pin func: 0 - GPIO, */
+				/* 3 - TX_ACTIVE, 4 - TX_LED */
+} __packed;
+
+struct ft260_set_gpiog_func_report {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_SELECT_GPIOG_FUNC */
+	u8 gpiog_func;		/* Pin func: 0 - GPIO, */
+				/* 2 - PWREN# (active-low), */
+				/* 5 - RX_LED, 6 - BCD_DET */
+} __packed;
+
+struct ft260_gpio_write_request_report {
+	u8 report;		/* FT260_GPIO */
+	struct ft260_gpio_state	gpio;
+} __packed;
+
 /* Data transfer reports */
 
 struct ft260_i2c_write_request_report {
@@ -333,6 +443,7 @@ struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
 	int iface_type;
+	int iface_id;
 	struct list_head device_list;
 	struct tty_port port;
 	/* tty port index */
@@ -359,6 +470,11 @@ struct ft260_device {
 	u16 read_idx;
 	u16 read_len;
 	u16 clock;
+	u16 gpio_en;
+	struct gpio_chip gc;
+	struct ft260_gpio_state gpio;
+	u16 gpio_uart_mode[FT260_GPIO_UART_MODES];
+	bool uart_dcd_ri;
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
@@ -391,8 +507,6 @@ static int ft260_hid_feature_report_set(struct hid_device *hdev, u8 *data,
 	if (!buf)
 		return -ENOMEM;
 
-	buf[0] = FT260_SYSTEM_SETTINGS;
-
 	ret = hid_hw_raw_request(hdev, buf[0], buf, len, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
 
@@ -405,6 +519,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	struct ft260_set_i2c_reset_report report;
 	int ret;
 
+	report.report = FT260_SYSTEM_SETTINGS;
 	report.request = FT260_SET_I2C_RESET;
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&report, sizeof(report));
@@ -922,6 +1037,341 @@ static const struct i2c_algorithm ft260_i2c_algo = {
 	.functionality = ft260_functionality,
 };
 
+static void ft260_gpio_en_set(struct ft260_device *dev, u16 bitmap)
+{
+	dev->gpio_en |= bitmap & FT260_GPIO_MASK;
+}
+
+static void ft260_gpio_en_clr(struct ft260_device *dev, u16 bitmap)
+{
+	dev->gpio_en &= ~bitmap & FT260_GPIO_MASK;
+}
+
+static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 value)
+{
+	u16 bitmap;
+	struct ft260_device *dev = hid_get_drvdata(hdev);
+
+	switch (req) {
+	case FT260_SET_I2C_MODE:
+		bitmap = FT260_GPIO_I2C_DEFAULT;
+		break;
+	case FT260_SET_UART_MODE:
+		switch (value) {
+		case FT260_UART_CFG_FLOW_CTRL_OFF:
+			bitmap = FT260_GPIO_UART_MODE_0_SET;
+			break;
+		case FT260_UART_CFG_FLOW_CTRL_RTS_CTS:
+			bitmap = FT260_GPIO_UART_MODE_1_CLR;
+			break;
+		case FT260_UART_CFG_FLOW_CTRL_DTR_DSR:
+			bitmap = FT260_GPIO_UART_MODE_2_CLR;
+			break;
+		case FT260_UART_CFG_FLOW_CTRL_XON_XOFF:
+		case FT260_UART_CFG_FLOW_CTRL_NONE:
+			bitmap = FT260_GPIO_UART_MODE_3_CLR;
+			break;
+		default:
+			return;
+		}
+		ft260_gpio_en_clr(dev, bitmap);
+		bitmap = dev->gpio_uart_mode[value];
+		if (dev->uart_dcd_ri)
+			bitmap &= ~FT260_GPIO_UART_DCD_RI;
+		ft260_gpio_en_set(dev, bitmap);
+		goto exit;
+
+	case FT260_ENABLE_UART_DCD_RI:
+		dev->uart_dcd_ri = value != FT260_MFPIN_GPIO;
+		bitmap = FT260_GPIO_UART_DCD_RI;
+		break;
+
+	case FT260_SELECT_GPIO2_FUNC:
+		bitmap = FT260_GPIO_2;
+		break;
+	case FT260_SELECT_GPIOA_FUNC:
+		bitmap = FT260_GPIO_A;
+		break;
+	case FT260_SELECT_GPIOG_FUNC:
+		bitmap = FT260_GPIO_G;
+		break;
+	default:
+		return;
+	}
+
+	if (value == FT260_MFPIN_GPIO)
+		ft260_gpio_en_set(dev, bitmap);
+	else
+		ft260_gpio_en_clr(dev, bitmap);
+exit:
+	ft260_dbg("%s: enabled GPIOs: %04x\n", dev_name(&hdev->dev),
+		  dev->gpio_en);
+}
+
+static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
+{
+	int ret = 0;
+	struct ft260_gpio_read_request_report buf;
+	struct ft260_gpio_write_request_report rep;
+	struct ft260_device *dev = gpiochip_get_data(gc);
+	struct hid_device *hdev = dev->hdev;
+
+	if (offset >= FT260_GPIO_TOTAL) {
+		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
+		return -EINVAL;
+	}
+
+	ft260_dbg("offset %d val %d\n", offset, value);
+
+	mutex_lock(&dev->lock);
+
+	if (!(dev->gpio_en & BIT(offset))) {
+		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf,
+					   sizeof(buf));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	rep.report = FT260_GPIO;
+	rep.gpio = buf.gpio;
+
+	if (offset < FT260_GPIO_0_5_COUNT) {
+		if (value)
+			rep.gpio.vals |= !!value << offset;
+		else
+			rep.gpio.vals &= ~BIT(offset);
+	} else {
+		offset = offset - FT260_GPIO_0_5_COUNT;
+		if (value)
+			rep.gpio.ex_vals |= !!value << offset;
+		else
+			rep.gpio.ex_vals &= ~BIT(offset);
+	}
+
+	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
+		  rep.gpio.dirs, rep.gpio.vals,
+		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	dev->gpio = rep.gpio;
+	ret = 0;
+exit:
+	mutex_unlock(&dev->lock);
+	return ret;
+}
+
+static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
+				    int value, int direction)
+{
+	int ret;
+	struct ft260_gpio_read_request_report buf;
+	struct ft260_gpio_write_request_report *rep;
+	struct ft260_device *dev = gpiochip_get_data(gc);
+	struct hid_device *hdev = dev->hdev;
+
+	if (offset >= FT260_GPIO_TOTAL) {
+		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
+		return -EINVAL;
+	}
+
+	ft260_dbg("offset %d val %d direction %d\n", offset, value, direction);
+
+	mutex_lock(&dev->lock);
+
+	if (!(dev->gpio_en & BIT(offset))) {
+		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
+		ret = -EIO;
+		goto exit;
+	}
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf, sizeof(buf));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	rep = (struct ft260_gpio_write_request_report *)&buf;
+
+	if (direction == FT260_GPIO_DIR_OUTPUT) {
+		if (offset < FT260_GPIO_0_5_COUNT) {
+			rep->gpio.dirs |= BIT(offset);
+			if (value)
+				rep->gpio.vals |= BIT(offset);
+			else
+				rep->gpio.vals &= ~BIT(offset);
+		} else {
+			u32 ex = offset - FT260_GPIO_0_5_COUNT;
+
+			rep->gpio.ex_dirs |= BIT(ex);
+			if (value)
+				rep->gpio.ex_vals |= BIT(ex);
+			else
+				rep->gpio.ex_vals &= ~BIT(ex);
+		}
+	} else if (offset < FT260_GPIO_0_5_COUNT) {
+		rep->gpio.dirs &= ~BIT(offset);
+	} else {
+		rep->gpio.ex_dirs &= ~BIT(offset - FT260_GPIO_0_5_COUNT);
+	}
+
+	ft260_dbg("dirs %#02x val %#02x ex_dirs %#02x ex_vals %#02x\n",
+		  rep->gpio.dirs, rep->gpio.vals,
+		  rep->gpio.ex_dirs, rep->gpio.ex_vals);
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)rep, sizeof(*rep));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	dev->gpio = rep->gpio;
+	ret = 0;
+exit:
+	mutex_unlock(&dev->lock);
+	return ret;
+}
+
+static int ft260_gpio_direction_output(struct gpio_chip *gc,
+				       u32 offset, int value)
+{
+	return ft260_gpio_direction_set(gc, offset, value,
+					FT260_GPIO_DIR_OUTPUT);
+}
+
+static int ft260_gpio_direction_input(struct gpio_chip *gc, u32 offset)
+{
+	return ft260_gpio_direction_set(gc, offset, 0,
+					FT260_GPIO_DIR_INPUT);
+}
+
+static int ft260_gpio_get_all(struct gpio_chip *gc, int item)
+{
+	int ret;
+	struct ft260_gpio_read_request_report rep;
+	struct ft260_device *dev = gpiochip_get_data(gc);
+	struct hid_device *hdev = dev->hdev;
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&rep, sizeof(rep));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	if (item == FT260_GPIO_VALUE)
+		ret = (rep.gpio.ex_vals << FT260_GPIO_0_5_COUNT) | rep.gpio.vals;
+	else
+		ret = (rep.gpio.ex_dirs << FT260_GPIO_0_5_COUNT) | rep.gpio.dirs;
+exit:
+	return ret;
+}
+
+static int ft260_gpio_get_direction(struct gpio_chip *gc, u32 offset)
+{
+	int ret = ft260_gpio_get_all(gc, FT260_GPIO_DIRECTION);
+
+	if (ret < 0)
+		return ret;
+	return !((ret >> offset) & 1);
+}
+
+static int ft260_gpio_get(struct gpio_chip *gc, u32 offset)
+{
+	int ret = ft260_gpio_get_all(gc, FT260_GPIO_VALUE);
+
+	if (ret < 0)
+		return ret;
+	return (ret >> offset) & 1;
+}
+
+static int ft260_gpio_init(struct ft260_device *dev,
+			   struct ft260_get_system_status_report *cfg)
+{
+	int ret;
+	struct ft260_get_chip_version_report ver;
+	struct ft260_gpio_read_request_report gbuf;
+	struct hid_device *hdev = dev->hdev;
+	u8 mode = cfg->chip_mode;
+
+	dev->gpio_uart_mode[0] = (u16)FT260_GPIO_UART_MODE_0_SET;
+	dev->gpio_uart_mode[1] = (u16)FT260_GPIO_UART_MODE_1_SET;
+	dev->gpio_uart_mode[2] = (u16)FT260_GPIO_UART_MODE_2_SET;
+	dev->gpio_uart_mode[3] = (u16)FT260_GPIO_UART_MODE_3_SET;
+	dev->gpio_uart_mode[4] = (u16)FT260_GPIO_UART_MODE_4_SET;
+
+	if (mode == FT260_MODE_ALL)
+		mode = FT260_MODE_BOTH;
+
+	if (mode & FT260_MODE_UART) {
+		if (cfg->uart_mode < FT260_GPIO_UART_MODES)
+			dev->gpio_en |= dev->gpio_uart_mode[cfg->uart_mode];
+		else
+			dev->gpio_en |= FT260_GPIO_UART_DEFAULT;
+	} else {
+		dev->gpio_en |= FT260_GPIO_UART_DEFAULT;
+	}
+
+	if (!(mode & FT260_MODE_I2C))
+		dev->gpio_en |= FT260_GPIO_I2C_DEFAULT;
+
+	if (cfg->gpio2_func == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_2;
+	if (cfg->enable_wakeup_int == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_3;
+	if (cfg->gpioa_func == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_A;
+	if (cfg->gpiog_func == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_G;
+
+	ft260_dbg("%s: enabled GPIOs: %04x\n", dev_name(&hdev->dev),
+		  dev->gpio_en);
+
+	dev->gc.label = devm_kasprintf(&hdev->dev, GFP_KERNEL, "ft260_%s",
+				       dev_name(&hdev->dev));
+	if (!dev->gc.label)
+		return -ENOMEM;
+
+	dev->gc.direction_input		= ft260_gpio_direction_input;
+	dev->gc.direction_output	= ft260_gpio_direction_output;
+	dev->gc.get_direction		= ft260_gpio_get_direction;
+	dev->gc.set			= ft260_gpio_set;
+	dev->gc.get			= ft260_gpio_get;
+	dev->gc.base			= -1;
+	dev->gc.ngpio			= FT260_GPIO_TOTAL;
+	dev->gc.can_sleep		= true;
+	dev->gc.parent			= &hdev->dev;
+
+	/* Wakeup chip */
+	(void)ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
+					(u8 *)&ver, sizeof(ver));
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&gbuf,
+					   sizeof(gbuf));
+	if (ret < 0)
+		hid_warn(hdev, "cannot read GPIO state: %d\n", ret);
+	else
+		dev->gpio = gbuf.gpio;
+
+	/*
+	 * Not devm: ft260_remove() must remove the gpiochip before it
+	 * stops the HID device and frees dev.
+	 */
+	ret = gpiochip_add_data(&dev->gc, dev);
+	if (ret < 0)
+		hid_err(hdev, "cannot add GPIO chip %d\n", ret);
+	return ret;
+}
+
 static int ft260_get_system_config(struct hid_device *hdev,
 				   struct ft260_get_system_status_report *cfg)
 {
@@ -937,29 +1387,36 @@ static int ft260_get_system_config(struct hid_device *hdev,
 	return 0;
 }
 
-static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device *dev)
+static int ft260_get_interface_type(struct ft260_device *dev,
+				    struct ft260_get_system_status_report *cfg)
+
 {
-	struct ft260_get_system_status_report cfg;
-	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
-	int interface = usbif->cur_altsetting->desc.bInterfaceNumber;
 	int ret;
+	struct hid_device *hdev = dev->hdev;
+	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
+
+	dev->iface_id = usbif->cur_altsetting->desc.bInterfaceNumber;
 
-	ret = ft260_get_system_config(hdev, &cfg);
+	ret = ft260_get_system_config(hdev, cfg);
 	if (ret < 0)
 		return ret;
 
-	ft260_dbg("interface:  0x%02x\n", interface);
-	ft260_dbg("chip mode:  0x%02x\n", cfg.chip_mode);
-	ft260_dbg("clock_ctl:  0x%02x\n", cfg.clock_ctl);
-	ft260_dbg("i2c_enable: 0x%02x\n", cfg.i2c_enable);
-	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
+	ft260_dbg("interface:  0x%02x\n", dev->iface_id);
+	ft260_dbg("chip mode:  0x%02x\n", cfg->chip_mode);
+	ft260_dbg("clock_ctl:  0x%02x\n", cfg->clock_ctl);
+	ft260_dbg("i2c_enable: 0x%02x\n", cfg->i2c_enable);
+	ft260_dbg("uart_mode:  0x%02x\n", cfg->uart_mode);
+	ft260_dbg("gpio2_func: 0x%02x\n", cfg->gpio2_func);
+	ft260_dbg("gpioA_func: 0x%02x\n", cfg->gpioa_func);
+	ft260_dbg("gpioG_func: 0x%02x\n", cfg->gpiog_func);
+	ft260_dbg("wakeup_int: 0x%02x\n", cfg->enable_wakeup_int);
 
-	dev->power_saving_en = cfg.power_saving_en;
+	dev->power_saving_en = cfg->power_saving_en;
 
-	switch (cfg.chip_mode) {
+	switch (cfg->chip_mode) {
 	case FT260_MODE_ALL:
 	case FT260_MODE_BOTH:
-		if (interface == 1)
+		if (dev->iface_id == 1)
 			ret = FT260_IFACE_UART;
 		else
 			ret = FT260_IFACE_I2C;
@@ -971,7 +1428,7 @@ static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device
 		ret = FT260_IFACE_I2C;
 		break;
 	default:
-		hid_err(hdev, "unknown chip mode: %d\n", cfg.chip_mode);
+		hid_err(hdev, "unknown chip mode: %d\n", cfg->chip_mode);
 		return -ENODEV;
 	}
 
@@ -1003,6 +1460,10 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", le16_to_cpu(*field));
 }
 
+static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
+{
+}
+
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
@@ -1023,37 +1484,42 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 		FT260_ATTR_SHOW(name, ft260_get_i2c_status_report,	       \
 				FT260_I2C_STATUS, __le16, ft260_word_show)
 
-#define FT260_ATTR_STORE(name, reptype, id, req, type, ctype, func)	       \
+#define FT260_ATTR_STORE(name, reptype, id, req, type, ctype, strtou, func)    \
 	static ssize_t name##_store(struct device *kdev,		       \
 				    struct device_attribute *attr,	       \
 				    const char *buf, size_t count)	       \
 	{								       \
 		struct reptype rep;					       \
 		struct hid_device *hdev = to_hid_device(kdev);		       \
+		struct ft260_device *dev = hid_get_drvdata(hdev);	       \
 		type name;						       \
 		int ret;						       \
 									       \
-		if (!func(buf, 10, (ctype *)&name)) {			       \
+		if (!strtou(buf, 10, (ctype *)&name)) {			       \
 			rep.name = name;				       \
 			rep.report = id;				       \
 			rep.request = req;				       \
+			mutex_lock(&dev->lock);				       \
 			ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep,   \
 							   sizeof(rep));       \
-			if (!ret)					       \
-				ret = count;				       \
+			if (ret < 0)					       \
+				hid_err(hdev, "%s: failed!\n", __func__);      \
+			else						       \
+				func(hdev, req, name);			       \
+			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
 		}							       \
 		return ret;						       \
 	}
 
-#define FT260_BYTE_ATTR_STORE(name, reptype, req)			       \
+#define FT260_BYTE_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u8, u8, kstrtou8)
+				 u8, u8, kstrtou8, func)
 
-#define FT260_WORD_ATTR_STORE(name, reptype, req)			       \
+#define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 __le16, u16, kstrtou16)
+				 __le16, u16, kstrtou16, func)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
@@ -1067,27 +1533,46 @@ static DEVICE_ATTR_RO(suspend_status);
 FT260_SSTAT_ATTR_SHOW(hid_over_i2c_en);
 static DEVICE_ATTR_RO(hid_over_i2c_en);
 
+FT260_SSTAT_ATTR_SHOW(gpio2_func);
+FT260_BYTE_ATTR_STORE(gpio2_func, ft260_set_gpio2_func_report,
+		      FT260_SELECT_GPIO2_FUNC, ft260_gpio_en_update);
+static DEVICE_ATTR_RW(gpio2_func);
+
+FT260_SSTAT_ATTR_SHOW(gpioa_func);
+FT260_BYTE_ATTR_STORE(gpioa_func, ft260_set_gpioa_func_report,
+		      FT260_SELECT_GPIOA_FUNC, ft260_gpio_en_update);
+static DEVICE_ATTR_RW(gpioa_func);
+
+FT260_SSTAT_ATTR_SHOW(gpiog_func);
+FT260_BYTE_ATTR_STORE(gpiog_func, ft260_set_gpiog_func_report,
+		      FT260_SELECT_GPIOG_FUNC, ft260_gpio_en_update);
+static DEVICE_ATTR_RW(gpiog_func);
+
 FT260_SSTAT_ATTR_SHOW(power_saving_en);
 static DEVICE_ATTR_RO(power_saving_en);
 
 FT260_SSTAT_ATTR_SHOW(i2c_enable);
 FT260_BYTE_ATTR_STORE(i2c_enable, ft260_set_i2c_mode_report,
-		      FT260_SET_I2C_MODE);
+		      FT260_SET_I2C_MODE, ft260_gpio_en_update);
 static DEVICE_ATTR_RW(i2c_enable);
 
 FT260_SSTAT_ATTR_SHOW(uart_mode);
 FT260_BYTE_ATTR_STORE(uart_mode, ft260_set_uart_mode_report,
-		      FT260_SET_UART_MODE);
+		      FT260_SET_UART_MODE, ft260_gpio_en_update);
 static DEVICE_ATTR_RW(uart_mode);
 
+FT260_BYTE_ATTR_STORE(uart_dcd_ri, ft260_set_uart_dcd_ri_report,
+		      FT260_ENABLE_UART_DCD_RI, ft260_gpio_en_update);
+static DEVICE_ATTR_WO(uart_dcd_ri);
+
 FT260_SSTAT_ATTR_SHOW(clock_ctl);
 FT260_BYTE_ATTR_STORE(clock_ctl, ft260_set_system_clock_report,
-		      FT260_SET_CLOCK);
+		      FT260_SET_CLOCK, ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(clock_ctl);
 
 FT260_I2CST_ATTR_SHOW(clock);
 FT260_WORD_ATTR_STORE(clock, ft260_set_i2c_speed_report,
-		      FT260_SET_I2C_CLOCK_SPEED);
+		      FT260_SET_I2C_CLOCK_SPEED, ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(clock);
 
 static ssize_t i2c_reset_store(struct device *kdev,
@@ -1111,7 +1596,11 @@ static const struct attribute_group ft260_attr_group = {
 		  &dev_attr_hid_over_i2c_en.attr,
 		  &dev_attr_power_saving_en.attr,
 		  &dev_attr_i2c_enable.attr,
+		  &dev_attr_gpio2_func.attr,
+		  &dev_attr_gpioa_func.attr,
+		  &dev_attr_gpiog_func.attr,
 		  &dev_attr_uart_mode.attr,
+		  &dev_attr_uart_dcd_ri.attr,
 		  &dev_attr_clock_ctl.attr,
 		  &dev_attr_i2c_reset.attr,
 		  &dev_attr_clock.attr,
@@ -1458,6 +1947,8 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
 		hid_err(hdev, "failed to change termios: %d\n", ret);
+	else
+		ft260_gpio_en_update(hdev, FT260_SET_UART_MODE, req.flow_ctrl);
 
 	mutex_unlock(&port->lock);
 	return ret;
@@ -1693,9 +2184,11 @@ static const struct tty_port_operations ft260_uart_port_ops = {
 
 static struct tty_driver *ft260_tty_driver;
 
-static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
+static int ft260_i2c_probe(struct ft260_device *dev,
+			   struct ft260_get_system_status_report *cfg)
 {
 	int ret;
+	struct hid_device *hdev = dev->hdev;
 
 	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n",
 		hdev->version >> 8, hdev->version & 0xff, hdev->name,
@@ -1722,27 +2215,35 @@ static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
 		return ret;
 	}
 
+	ret = ft260_gpio_init(dev, cfg);
+	if (ret)
+		goto err_i2c_free;
+
 	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
 	if (ret < 0) {
 		hid_err(hdev, "failed to create sysfs attrs\n");
-		goto err_i2c_free;
+		goto err_gpio_remove;
 	}
+
 	return 0;
 
+err_gpio_remove:
+	gpiochip_remove(&dev->gc);
 err_i2c_free:
 	i2c_del_adapter(&dev->adap);
 	return ret;
 }
 
-static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
+static int ft260_uart_probe(struct ft260_device *dev,
+			    struct ft260_get_system_status_report *cfg)
 {
 	struct ft260_configure_uart_request_report req;
-	int ret;
+	struct hid_device *hdev = dev->hdev;
 	struct device *devt;
+	int ret;
 
 	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
 	INIT_WORK(&dev->tx_work, ft260_uart_tx_work);
-	// FIXME: are all kfifo access secured by lock? with irq or not?
 	ft260_uart_wakeup_workaraund_enable(dev, true);
 	/* Work not started at this point */
 	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
@@ -1774,6 +2275,20 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 		goto err_hid_report;
 	}
 
+	cfg->uart_mode = FT260_UART_CFG_FLOW_CTRL_NONE;
+
+	if (dev->iface_id == 0) {
+		ret = ft260_gpio_init(dev, cfg);
+		if (ret)
+			goto err_hid_report;
+
+		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (ret < 0) {
+			hid_err(hdev, "failed to create sysfs attrs\n");
+			goto err_gpio_remove;
+		}
+	}
+
 	devt = tty_port_register_device_attr(&dev->port,
 					     ft260_tty_driver,
 					     dev->index, &hdev->dev,
@@ -1781,13 +2296,19 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 	if (IS_ERR(devt)) {
 		hid_err(hdev, "failed to register tty port\n");
 		ret = PTR_ERR(devt);
-		goto err_hid_report;
+		goto err_register_tty;
 	}
 	hid_info(hdev, "registering device /dev/%s%d\n",
 		ft260_tty_driver->name, dev->index);
 
 	return 0;
 
+err_register_tty:
+	if (dev->gc.parent)
+		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+err_gpio_remove:
+	if (dev->gc.parent)
+		gpiochip_remove(&dev->gc);
 err_hid_report:
 	ft260_uart_port_remove(dev);
 err_port:
@@ -1799,6 +2320,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ft260_device *dev;
 	struct ft260_get_chip_version_report version;
+	struct ft260_get_system_status_report cfg;
 	int ret;
 
 	if (!hid_is_usb(hdev))
@@ -1813,6 +2335,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto alloc_fail;
 	}
 	hid_set_drvdata(hdev, dev);
+	dev->hdev = hdev;
 	mutex_init(&dev->lock);
 	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
@@ -1846,19 +2369,16 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 version.chip_code[0], version.chip_code[1],
 		 version.chip_code[2], version.chip_code[3]);
 
-	ret = ft260_get_interface_type(hdev, dev);
+	ret = ft260_get_interface_type(dev, &cfg);
 	if (ret <= FT260_IFACE_NONE)
 		goto err_hid_close;
 
-	hid_set_drvdata(hdev, dev);
-	dev->hdev = hdev;
-
-	if (dev->iface_type == FT260_IFACE_I2C) {
-		ret = ft260_i2c_probe(hdev, dev);
+	if (ret == FT260_IFACE_I2C) {
+		ret = ft260_i2c_probe(dev, &cfg);
 		if (ret)
 			goto err_hid_close;
 	} else {
-		ret = ft260_uart_probe(hdev, dev);
+		ret = ft260_uart_probe(dev, &cfg);
 		if (ret)
 			goto err_uart;
 	}
@@ -1892,11 +2412,16 @@ static void ft260_remove(struct hid_device *hdev)
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
 		ft260_uart_port_remove(dev);
+		if (dev->iface_id == 0)
+			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 	} else {
 		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
 	}
 
+	if (dev->gc.parent)
+		gpiochip_remove(&dev->gc);
+
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-- 
2.43.0

