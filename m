Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8EF390C84
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434843; cv=none; b=hB5eWJjPMp6mFheYUKI4s6rpIqLOhH39X8PLE50pi8aZpz2NyNzIlpjNZZofXLzqJBVI7GAjP9VU29Q6J7p6PrnEsn6dmoCiG9leDK6aDnOEuPiEKrNmuSxXFgvC5n35E40jx5B/WIlF3931+HIHHs9k+onkx/ONCVv8gjq1Vik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434843; c=relaxed/simple;
	bh=0m7Cttfvo8LCPzHjgNxVmLZjhMYzpm1CMfw2zEHoQgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7QUgug4Ga/W9OyU/vBwN4WJoksypwzd5nJMOael0QtSMfhm0WVuEQ2l/72FBU0w5TR30FyLUImCOD//d+bjBbSRzLsQXb216ItygyQwAprTS2SkxaLyC9QX9iXztgbaFMCJOHQCQqWwkCmOSdYWKdGmJ37G9Gr3ZjVBwvgS1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeqJnbvW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeqJnbvW"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1677c91969so261791866b.1
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434833; x=1788039633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUHq6orUk6dX8RpgoUJEImzKdwDguH+0tNnHHWNQJOY=;
        b=YeqJnbvW2zGfDH4IC40fjx6OludDcvdWfqlGyT4zTIhvKypbcM4CdGP5wYj9wisFs6
         pXPNoj0poJiswEfwNhfDU3glTOFnd+I3b7VLL6fbWXeyw/ocboMsLv+GH/yvstIcG22n
         z7tp+yIaZuaE8DS1xHO1CA/3Bcnjt1Y5Xk1BeuPJXi3XLxniOQHV086TPyWy7wHgx7c6
         QqB+Z+50Jq5tkDuC47yChB8s2mjj4fEAzZ+CEoRUxnYHpl8PFM0Q3+ac1NnUGcaClTkp
         Uoda074/XNyXJUzp0Svn1D0GoWV1U9InHElOHcVO5vNcuKNFnD2WfHeZ7kTn2ftgBol8
         MEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434833; x=1788039633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LUHq6orUk6dX8RpgoUJEImzKdwDguH+0tNnHHWNQJOY=;
        b=C8v1C4+V/Ru4aiCkfmjCvSXWv/s669ZgdtJqiOONVd+WXf3HmrKMuaHDsh1WRR5z/B
         hrWXQW7RAQv4ZGxN76pCUir8LbF+HKt8Xt4LCWD1MptqO3tcZz4h7Cr/qDWVl2T631mm
         y27/hCvwXCPY6ZaAYOjZWKQEO5cik+A9g06Cynxxwv/ywQAe8rV2P9wGgo7PDmJwZhSD
         BfN2uVurN3aoqrFPTijxpolf1zquFJWVoW/9tPAML6mq9bRFFYXFe4/UIw52giDeB65a
         U5jew3GxHtzbT9d7k273eelSJcKaJ9RC+yuRmCcKlLeKs4kIVItnEENsVFXO78UFAC+0
         yNGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0GzM9ghK/QlpWRoujZNoDGz48eOx4dDTjN2d2qRYZNYRzBBajXbIEifTs3c08QryzoBpf3NdwTj/usA==@vger.kernel.org
X-Gm-Message-State: AFuF++mHNWGHJwYe8W6pUfxm44lqHmMgBGwriuQneW+xgBI+QROkQ+0w
	80YVPi7fF26NLjyd044+WcKvzD8Z1yZnJRf8fheJE7fbmGqNVrz8rjw6
X-Gm-Gg: AR+sD13dThMGNiBXeldUGu/kX96YGevoA050/Tx3lIVAi4vByQcYm9xUIYmhCpdwB5j
	KjwNDkDY1DJzpJfl0ua/tAnTCUOXRUMSjd5k40VMVaWc+2o9xmyRcohSZ4N6iZ+7lMLn70xbm0n
	/pjktDoBXvmjgAUpoMKIinQQREI38drTkXwsvEv5i8Zgza4Cofuhv3yoDM49d73pHuF5Wpdsc3X
	jOU4f9ssVahmC082YXOU3sNmGrIW1O64onFXg3bON6ZH1JSth1/UzJSJMUxZuAKp5TXFKkJFFYC
	10xzvAFrJDDKr9PAKEefU9AKoXdhhSa19lUbfq18d8dlDY0HexLrw13u3EMVnz+BWBmC9OQ7e7k
	5tCuTd5WpN3YBB+47vIA3tPeDOqAAW7eZxUMYRQE1CpPP5F71/uJhQ05iW6kQSaFIB40VpDLZUp
	Y9G8vnDJdAkm10ZWvPq7iSLH0utT0IemKxuZ0Yl8D+aHLDlFu7WDN3Ii7fJugS6tyYcAzBfQ==
X-Received: by 2002:a17:907:890e:b0:c24:7f65:9c8a with SMTP id a640c23a62f3a-c24926a1ae2mr925290666b.12.1787434833296;
        Sat, 22 Aug 2026 14:40:33 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:32 -0700 (PDT)
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
Subject: [PATCH 03/13] HID: ft260: add GPIO support on top of UART
Date: Sun, 23 Aug 2026 00:39:31 +0300
Message-ID: <20260822213941.98882-4-michael.zaidman@gmail.com>
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

Add gpiochip support for the FT260 multifunctional pins, including
GPIO2/GPIOA/GPIOG function selection via sysfs, and enable the
available GPIOs according to the active UART mode.

This supersedes the earlier pre-UART GPIO series:
https://lore.kernel.org/lkml/20230211115752.26276-2-michael.zaidman@gmail.com/

The gpio_chip.set callback returns int to match the current gpiolib
API, based on the adaptation originally contributed by Rio Liu
<rio@r26.me>.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/Kconfig     |  10 +-
 drivers/hid/hid-ft260.c | 660 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 586 insertions(+), 84 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e898adb331ba..8e161c440346 100644
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
index b6c408267a68..cc3b8f5791de 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -19,6 +19,7 @@
 #include <linux/tty_flip.h>
 #include <linux/minmax.h>
 #include <linux/unaligned.h>
+#include <linux/gpio/driver.h>
 
 #ifdef DEBUG
 static int ft260_debug = 1;
@@ -57,6 +58,11 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 #define FT260_RD_DATA_MAX (180)
 #define FT260_WR_I2C_DATA_MAX (60)
 #define FT260_WR_UART_DATA_MAX (62)
+#define FT260_GPIOCHIP "ft260_gpio"
+#define FT260_GPIO_MAX (6)
+#define FT260_GPIO_EX_MAX (8)
+#define FT260_GPIO_TOTAL (FT260_GPIO_MAX + FT260_GPIO_EX_MAX)
+#define FT260_GPIO_MASK (~(0xffff << FT260_GPIO_TOTAL))
 
 /*
  * Device interface configuration.
@@ -151,7 +157,69 @@ enum {
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
+enum {
+	FT260_GPIO_0			= (1 << 0),
+	FT260_GPIO_1			= (1 << 1),
+	FT260_GPIO_2			= (1 << 2),
+	FT260_GPIO_3			= (1 << 3),
+	FT260_GPIO_4			= (1 << 4),
+	FT260_GPIO_5			= (1 << 5),
+	FT260_GPIO_A			= (1 << (FT260_GPIO_MAX + 0)),
+	FT260_GPIO_B			= (1 << (FT260_GPIO_MAX + 1)),
+	FT260_GPIO_C			= (1 << (FT260_GPIO_MAX + 2)),
+	FT260_GPIO_D			= (1 << (FT260_GPIO_MAX + 3)),
+	FT260_GPIO_E			= (1 << (FT260_GPIO_MAX + 4)),
+	FT260_GPIO_F			= (1 << (FT260_GPIO_MAX + 5)),
+	FT260_GPIO_G			= (1 << (FT260_GPIO_MAX + 6)),
+	FT260_GPIO_H			= (1 << (FT260_GPIO_MAX + 7)),
+};
+
+/* GPIO groups */
+enum {
+	FT260_GPIO_WAKEUP		= (FT260_GPIO_3),
+	FT260_GPIO_I2C_DEFAULT		= (FT260_GPIO_0 | FT260_GPIO_1),
+	FT260_GPIO_UART_RX_TX		= (FT260_GPIO_C | FT260_GPIO_D),
+	FT260_GPIO_UART_DCD_RI		= (FT260_GPIO_4 | FT260_GPIO_5),
+	FT260_GPIO_UART_RTS_CTS		= (FT260_GPIO_B | FT260_GPIO_E),
+	FT260_GPIO_UART_DTR_DSR		= (FT260_GPIO_F | FT260_GPIO_H),
+	FT260_GPIO_UART_MODE_0_SET	= (FT260_GPIO_UART_RX_TX |
+					   FT260_GPIO_UART_DCD_RI |
+					   FT260_GPIO_UART_RTS_CTS |
+					   FT260_GPIO_UART_DTR_DSR),
+	FT260_GPIO_UART_MODE_1_SET	= (FT260_GPIO_UART_DTR_DSR),
+	FT260_GPIO_UART_MODE_2_SET	= (FT260_GPIO_UART_RTS_CTS),
+	FT260_GPIO_UART_MODE_3_SET	= (FT260_GPIO_UART_RTS_CTS |
+					   FT260_GPIO_UART_DTR_DSR),
+	FT260_GPIO_UART_MODE_4_SET	= (FT260_GPIO_UART_MODE_3_SET),
+	FT260_GPIO_UART_DEFAULT		= (FT260_GPIO_UART_MODE_0_SET),
+	FT260_GPIO_UART_MODE_1_CLR	= (FT260_GPIO_UART_RX_TX |
+					   FT260_GPIO_UART_RTS_CTS),
+	FT260_GPIO_UART_MODE_2_CLR	= (FT260_GPIO_UART_RX_TX |
+					   FT260_GPIO_UART_DTR_DSR),
+	FT260_GPIO_UART_MODE_3_CLR	= (FT260_GPIO_UART_RX_TX),
+	FT260_GPIO_UART_MODES		= (5),
+};
+
+#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
 
@@ -171,10 +239,10 @@ struct ft260_get_system_status_report {
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
@@ -202,6 +270,18 @@ struct ft260_get_uart_settings_report {
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
@@ -223,6 +303,12 @@ struct ft260_set_uart_mode_report {
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
@@ -234,6 +320,33 @@ struct ft260_set_i2c_speed_report {
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
@@ -280,32 +393,32 @@ struct ft260_configure_uart_request_report {
 
 /* UART interface configuration */
 enum {
-	FT260_CFG_FLOW_CTRL_OFF		= 0x00,
-	FT260_CFG_FLOW_CTRL_RTS_CTS	= 0x01,
-	FT260_CFG_FLOW_CTRL_DTR_DSR	= 0x02,
-	FT260_CFG_FLOW_CTRL_XON_XOFF	= 0x03,
-	FT260_CFG_FLOW_CTRL_NONE	= 0x04,
+	FT260_UART_CFG_FLOW_CTRL_OFF		= 0x00,
+	FT260_UART_CFG_FLOW_CTRL_RTS_CTS	= 0x01,
+	FT260_UART_CFG_FLOW_CTRL_DTR_DSR	= 0x02,
+	FT260_UART_CFG_FLOW_CTRL_XON_XOFF	= 0x03,
+	FT260_UART_CFG_FLOW_CTRL_NONE		= 0x04,
 
-	FT260_CFG_DATA_BITS_7		= 0x07,
-	FT260_CFG_DATA_BITS_8		= 0x08,
+	FT260_UART_CFG_DATA_BITS_7		= 0x07,
+	FT260_UART_CFG_DATA_BITS_8		= 0x08,
 
-	FT260_CFG_PAR_NO		= 0x00,
-	FT260_CFG_PAR_ODD		= 0x01,
-	FT260_CFG_PAR_EVEN		= 0x02,
-	FT260_CFG_PAR_HIGH		= 0x03,
-	FT260_CFG_PAR_LOW		= 0x04,
+	FT260_UART_CFG_PAR_NO			= 0x00,
+	FT260_UART_CFG_PAR_ODD			= 0x01,
+	FT260_UART_CFG_PAR_EVEN			= 0x02,
+	FT260_UART_CFG_PAR_HIGH			= 0x03,
+	FT260_UART_CFG_PAR_LOW			= 0x04,
 
-	FT260_CFG_STOP_ONE_BIT		= 0x00,
-	FT260_CFG_STOP_TWO_BIT		= 0x02,
+	FT260_UART_CFG_STOP_ONE_BIT		= 0x00,
+	FT260_UART_CFG_STOP_TWO_BIT		= 0x02,
 
-	FT260_CFG_BREAKING_NO		= 0x00,
-	FT260_CFG_BEAKING_YES		= 0x01,
+	FT260_UART_CFG_BREAKING_NO		= 0x00,
+	FT260_UART_CFG_BEAKING_YES		= 0x01,
 
-	FT260_CFG_BAUD_MIN		= 1200,
-	FT260_CFG_BAUD_MAX		= 12000000,
+	FT260_UART_CFG_BAUD_MIN			= 1200,
+	FT260_UART_CFG_BAUD_MAX			= 12000000,
 };
 
-#define FT260_UART_EN_PW_SAVE_BAUD	(4800)
+#define FT260_UART_EN_PW_SAVE_BAUD (4800)
 
 #define UART_COUNT_MAX (4) /* Number of supported UARTs */
 #define XMIT_FIFO_SIZE (PAGE_SIZE)
@@ -321,6 +434,7 @@ struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
 	int iface_type;
+	int iface_id;
 	struct list_head device_list;
 	struct tty_port port;
 	/* tty port index */
@@ -343,6 +457,10 @@ struct ft260_device {
 	u16 read_idx;
 	u16 read_len;
 	u16 clock;
+	u16 gpio_en;
+	struct gpio_chip *gc;
+	struct ft260_gpio_state gpio;
+	u16 gpio_uart_mode[FT260_GPIO_UART_MODES];
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
@@ -375,8 +493,6 @@ static int ft260_hid_feature_report_set(struct hid_device *hdev, u8 *data,
 	if (!buf)
 		return -ENOMEM;
 
-	buf[0] = FT260_SYSTEM_SETTINGS;
-
 	ret = hid_hw_raw_request(hdev, buf[0], buf, len, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
 
@@ -389,6 +505,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	struct ft260_set_i2c_reset_report report;
 	int ret;
 
+	report.report = FT260_SYSTEM_SETTINGS;
 	report.request = FT260_SET_I2C_RESET;
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&report, sizeof(report));
@@ -906,6 +1023,322 @@ static const struct i2c_algorithm ft260_i2c_algo = {
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
+
+	case FT260_SET_I2C_MODE:
+		bitmap = FT260_GPIO_I2C_DEFAULT;
+		break;
+	case FT260_SET_UART_MODE:
+		switch (value) {
+		case FT260_UART_CFG_FLOW_CTRL_OFF:
+			bitmap = (u16)FT260_GPIO_MASK;
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
+		ft260_gpio_en_set(dev, bitmap);
+		goto exit;
+
+	case FT260_ENABLE_UART_DCD_RI:
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
+	hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
+}
+
+static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
+{
+	int ret = 0;
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
+	if (!(dev->gpio_en & (1 << offset))) {
+		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	rep.report = FT260_GPIO;
+	rep.gpio = dev->gpio;
+
+	if (offset < FT260_GPIO_MAX) {
+		if (value)
+			rep.gpio.vals |= !!value << offset;
+		else
+			rep.gpio.vals &= ~(1 << offset);
+	} else {
+		offset = offset - FT260_GPIO_MAX;
+		if (value)
+			rep.gpio.ex_vals |= !!value << offset;
+		else
+			rep.gpio.ex_vals &= ~(1 << offset);
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
+	if (!(dev->gpio_en & (1 << offset))) {
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
+	if (direction == FT260_GPIO_DIR_OUTPUT)
+		if (offset < FT260_GPIO_MAX)
+			rep->gpio.dirs |= 1 << offset;
+		else
+			rep->gpio.ex_dirs |= 1 << (offset - FT260_GPIO_MAX);
+	else
+		if (offset < FT260_GPIO_MAX)
+			rep->gpio.dirs &= ~(1 << offset);
+		else
+			rep->gpio.ex_dirs &= ~(1 << (offset - FT260_GPIO_MAX));
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
+	mutex_unlock(&dev->lock);
+
+	if (direction == FT260_GPIO_DIR_OUTPUT)
+		ft260_gpio_set(gc, offset, value);
+
+	return 0;
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
+		ret = (rep.gpio.ex_vals << FT260_GPIO_MAX) | rep.gpio.vals;
+	else
+		ret = (rep.gpio.ex_dirs << FT260_GPIO_MAX) | rep.gpio.dirs;
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
+	int label_sz;
+	char *label;
+	struct ft260_get_chip_version_report ver;
+	struct hid_device *hdev = dev->hdev;
+	char prefix[] = "ft260_";
+	u8 mode = cfg->chip_mode;
+
+	hid_info(hdev, "initialize gpio chip\n");
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
+	if (mode & FT260_MODE_UART)
+		dev->gpio_en |= dev->gpio_uart_mode[cfg->uart_mode];
+	else
+		dev->gpio_en |= FT260_GPIO_UART_DEFAULT;
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
+	hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
+
+	dev->gc = devm_kzalloc(&hdev->dev, sizeof(*dev->gc), GFP_KERNEL);
+	if (!dev->gc)
+		return -ENOMEM;
+
+	label_sz = strlen(dev_name(&hdev->dev)) + strlen(prefix) + 1;
+	label = devm_kzalloc(&hdev->dev, label_sz, GFP_KERNEL);
+	if (!label) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));
+	hid_info(hdev, "initialize gpio chip on %s\n", label);
+
+	dev->gc->label			= label;
+	dev->gc->direction_input	= ft260_gpio_direction_input;
+	dev->gc->direction_output	= ft260_gpio_direction_output;
+	dev->gc->get_direction		= ft260_gpio_get_direction;
+	dev->gc->set			= ft260_gpio_set;
+	dev->gc->get			= ft260_gpio_get;
+	dev->gc->base			= -1;
+	dev->gc->ngpio			= FT260_GPIO_TOTAL;
+	dev->gc->can_sleep		= true;
+	dev->gc->parent			= &hdev->dev;
+
+	/* Wakeup chip */
+	(void)ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
+					(u8 *)&ver, sizeof(ver));
+
+	ret = devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);
+	if (ret < 0)
+		hid_err(hdev, "cannot add GPIO chip %d\n", ret);
+exit:
+	return ret;
+}
+
 static int ft260_get_system_config(struct hid_device *hdev,
 				   struct ft260_get_system_status_report *cfg)
 {
@@ -921,29 +1354,36 @@ static int ft260_get_system_config(struct hid_device *hdev,
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
 
-	ret = ft260_get_system_config(hdev, &cfg);
+	dev->iface_id = usbif->cur_altsetting->desc.bInterfaceNumber;
+
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
@@ -984,6 +1424,10 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", le16_to_cpu(*field));
 }
 
+static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
+{
+}
+
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
@@ -1004,37 +1448,42 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
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
@@ -1048,27 +1497,46 @@ static DEVICE_ATTR_RO(suspend_status);
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
@@ -1092,7 +1560,11 @@ static const struct attribute_group ft260_attr_group = {
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
@@ -1342,33 +1814,33 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS7:
-		req.data_bit = FT260_CFG_DATA_BITS_7;
+		req.data_bit = FT260_UART_CFG_DATA_BITS_7;
 		break;
 	case CS5:
 	case CS6:
 		hid_err(hdev, "invalid data bit size, setting a default\n");
-		req.data_bit = FT260_CFG_DATA_BITS_8;
+		req.data_bit = FT260_UART_CFG_DATA_BITS_8;
 		termios->c_cflag &= ~CSIZE;
 		termios->c_cflag |= CS8;
 		break;
 	default:
 	case CS8:
-		req.data_bit = FT260_CFG_DATA_BITS_8;
+		req.data_bit = FT260_UART_CFG_DATA_BITS_8;
 		break;
 	}
 
 	req.stop_bit = (termios->c_cflag & CSTOPB) ?
-		FT260_CFG_STOP_TWO_BIT : FT260_CFG_STOP_ONE_BIT;
+		FT260_UART_CFG_STOP_TWO_BIT : FT260_UART_CFG_STOP_ONE_BIT;
 
 	if (termios->c_cflag & PARENB) {
 		req.parity = (termios->c_cflag & PARODD) ?
-			FT260_CFG_PAR_ODD : FT260_CFG_PAR_EVEN;
+			FT260_UART_CFG_PAR_ODD : FT260_UART_CFG_PAR_EVEN;
 	} else {
-		req.parity = FT260_CFG_PAR_NO;
+		req.parity = FT260_UART_CFG_PAR_NO;
 	}
 
 	baud = tty_termios_baud_rate(termios);
-	if (baud == 0 || baud < FT260_CFG_BAUD_MIN || baud > FT260_CFG_BAUD_MAX) {
+	if (baud == 0 || baud < FT260_UART_CFG_BAUD_MIN || baud > FT260_UART_CFG_BAUD_MAX) {
 		struct tty_struct *tty = tty_port_tty_get(&port->port);
 
 		hid_err(hdev, "invalid baud rate %d\n", baud);
@@ -1385,9 +1857,9 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);
 
 	if (termios->c_cflag & CRTSCTS)
-		req.flow_ctrl = FT260_CFG_FLOW_CTRL_RTS_CTS;
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
 	else
-		req.flow_ctrl = FT260_CFG_FLOW_CTRL_OFF;
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
 
 	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
@@ -1395,12 +1867,18 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_CFG_BREAKING_NO;
+	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
+	req.breaking = FT260_UART_CFG_BREAKING_NO;
+
+	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
 		hid_err(hdev, "failed to change termios: %d\n", ret);
+	else
+		ft260_gpio_en_update(hdev, FT260_SET_UART_MODE, req.flow_ctrl);
+
+	mutex_unlock(&port->lock);
 
 	return ret;
 }
@@ -1611,9 +2089,11 @@ static const struct tty_port_operations ft260_uart_port_ops = {
 
 static struct tty_driver *ft260_tty_driver;
 
-static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
+static int ft260_i2c_probe(struct ft260_device *dev,
+			   struct ft260_get_system_status_report *cfg)
 {
 	int ret;
+	struct hid_device *hdev = dev->hdev;
 
 	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n",
 		hdev->version >> 8, hdev->version & 0xff, hdev->name,
@@ -1640,11 +2120,16 @@ static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
 		return ret;
 	}
 
+	ret = ft260_gpio_init(dev, cfg);
+	if (ret)
+		goto err_i2c_free;
+
 	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
 	if (ret < 0) {
 		hid_err(hdev, "failed to create sysfs attrs\n");
 		goto err_i2c_free;
 	}
+
 	return 0;
 
 err_i2c_free:
@@ -1652,14 +2137,15 @@ static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
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
-	// FIXME: are all kfifo access secured by lock? with irq or not?
 	ft260_uart_wakeup_workaraund_enable(dev, true);
 	/* Work not started at this point */
 	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
@@ -1687,12 +2173,12 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 	/* Configure UART to 9600n8 */
 	req.report	= FT260_SYSTEM_SETTINGS;
 	req.request	= FT260_SET_UART_CONFIG;
-	req.flow_ctrl	= FT260_CFG_FLOW_CTRL_NONE;
+	req.flow_ctrl	= FT260_UART_CFG_FLOW_CTRL_NONE;
 	put_unaligned_le32(cpu_to_le32(9600), &req.baudrate);
-	req.data_bit	= FT260_CFG_DATA_BITS_8;
-	req.parity	= FT260_CFG_PAR_NO;
-	req.stop_bit	= FT260_CFG_STOP_ONE_BIT;
-	req.breaking	= FT260_CFG_BREAKING_NO;
+	req.data_bit	= FT260_UART_CFG_DATA_BITS_8;
+	req.parity	= FT260_UART_CFG_PAR_NO;
+	req.stop_bit	= FT260_UART_CFG_STOP_ONE_BIT;
+	req.breaking	= FT260_UART_CFG_BREAKING_NO;
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0) {
@@ -1700,6 +2186,20 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
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
+			goto err_hid_report;
+		}
+	}
+
 	return 0;
 
 err_hid_report:
@@ -1713,6 +2213,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ft260_device *dev;
 	struct ft260_get_chip_version_report version;
+	struct ft260_get_system_status_report cfg;
 	int ret;
 
 	if (!hid_is_usb(hdev))
@@ -1727,6 +2228,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto alloc_fail;
 	}
 	hid_set_drvdata(hdev, dev);
+	dev->hdev = hdev;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -1757,21 +2259,18 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 version.chip_code[0], version.chip_code[1],
 		 version.chip_code[2], version.chip_code[3]);
 
-	ret = ft260_get_interface_type(hdev, dev);
-	if (ret <= FT260_IFACE_NONE)
-		goto err_hid_close;
-
-	hid_set_drvdata(hdev, dev);
-	dev->hdev = hdev;
-
 	mutex_init(&dev->lock);
 	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
+	ret = ft260_get_interface_type(dev, &cfg);
+	if (ret <= FT260_IFACE_NONE)
+		goto err_hid_close;
+
 	if (ret == FT260_IFACE_I2C)
-		ret = ft260_i2c_probe(hdev, dev);
+		ret = ft260_i2c_probe(dev, &cfg);
 	else
-		ret = ft260_uart_probe(hdev, dev);
+		ret = ft260_uart_probe(dev, &cfg);
 	if (ret)
 		goto err_hid_close;
 
@@ -1800,6 +2299,9 @@ static void ft260_remove(struct hid_device *hdev)
 					   dev->index);
 		ft260_uart_port_remove(dev);
 		/* dev is still needed, so we will free it in _destroy func */
+		if (dev->iface_id == 0)
+			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+
 	} else {
 		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
-- 
2.43.0

