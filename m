Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209398;
	b=Ng3GVwJuHiCeQwVWutpdCdn/d8pcsJBqi45pmvYPTGfXOK+wZUOYhFBs+H8Pmtyna5wa
	 hBMDRVQPzaLRkOTQ46ePxZST2tdubntHD8Y24KJgeom+sbSAGBdsfRJ7kGJ7lEHjisgFt
	 mdgTwZFbhMtQmGJR5PwSxEVOzSlF+00H1M20MPUTV/rD6mnQImsH+TU5YAaLK/u///i9n
	 fLqNCaBRMAiLZAGpqA9fPCRmcRI7t/vycQCnc4ciDsyie/frwug/vJ4HC1Zoiou6324cA
	 rb3AVMLO2tUxAHp/HF7X4i+4jtUQK2la8EkenOAWNrZYfw1I02uBq9svvDpew61Rtfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GDl7TMeM7yW8jg7wDo6KiyS79MwT5JH/tMhNqzmfKgU=;
	b=tpTnswWuABDkJtzaX2W2IfQr/nBfhA6384peDb6dGiOIkxUQWNcDgou0u6xvw/gWWHOA
	 LJcYMMPhjaTjxhovEeDURQjA7Q0jAHsn7dbjUyQwWgqVjJVDF4aFVk+rd5F4vbe1wGpJH
	 2LLa8h4wxAX+MhxxGFAlCBjIaD6bOJcdJX3RFF8oAiLU6mJwN4LzNXRcskYQFT+fI6kgv
	 ltqWYn8H8TniFB9TTz8z7In8yZSA/niOTBYSYUVhSdPClk0l1rOeKm3yuBUzvKc08f+w0
	 tFesX6UKXMJT4n+kla+Z/kFlw70isFVK1VlkvAw/nhC/A1p4lnxaINIUhzrIiBA3yYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cx0Ip58;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99768606A325
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99768606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cx0Ip58
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2023663eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794209397; x=1794814197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDl7TMeM7yW8jg7wDo6KiyS79MwT5JH/tMhNqzmfKgU=;
        b=0cx0Ip5897f/nWiXRQw9p+3bu2K86+BVtj9wHlqMbK4r6Tn/R7SOvFSpz4o2jLKSiY
         aNdFrGHn2WVi4Ax6C+oWtdHkMnAUVuWThNPcA2VQgWExabTakVxkwQ2fDpRsDBwA5iuv
         mjpHe0X/5szilY7YrhxKKP9Gq8M3pWNSCOVoroxc5D/7pJtiTV16NWWxzizV9UK8Ugsb
         O29kTjG8UjieHnMP6Z87i3AcYLOeyf0tEfiV03rftGpDc4mL6Yl4E2OA8vH5zHY+m4ZD
         hTSmZzLK5SB/31rgXYwkbFkAlv+3jx9b4MraDkveWcfg/0AwbIpLKjyZny8DbKcMaV2D
         qcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794209397; x=1794814197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GDl7TMeM7yW8jg7wDo6KiyS79MwT5JH/tMhNqzmfKgU=;
        b=vVIY1xfy+wN1swKe2+gqwkNy+D4Jg1e5j4/uC1morecfLNb4674dmDvRGTekh6aYso
         T0k4obFM/kMicD/vRVBqktiyH+ZhuyaNzmjT0PMWdMDBRhSQRbQtEFfUrlVuHzxey9kQ
         0ZHvQj7b9FlBDqJhCSanyKVAuBhMaRqJwYzgfvcQ6DP1i8wXpBZRQuO/EFZTEC+1VmeT
         s8kHylqtIXafCSiv6Vn9dVbVQebmWi1ZPq/x6lhm3XKl5BPinRqWWNhgVt6Yx2qQWhNH
         yCcHqNi87Ky/nn1u7SB5vESvBD4i+RHgdTSCXHUkZAVHf9OKlsbCCCkV8TyPNQ5hkjMr
         1wMA==
X-Forwarded-Encrypted: i=1; AL+hErHdvqV2typot867Ckn9F8kZ7RKFohbTRKo/adtmzQ52yW2tHI7YGDnMjpaUEXYHaBiwKGp2b/pfz2147Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ifa3O4jauxJQCQ+PAo5IXX9hnbhoEWjS9FKyn9Izgivgl4rxq
	HmAkQ4GEcYg1K+ZgulIiYYhIh/ifu8+Bc6RrPPVha1R4EBcxBGSCpHBr
X-Gm-Gg: AYBFou18L+iITMhXbONzdp1fddI1DisOlSkAxtxqzq8xfT00/cry67tfzFSLD+sLX+8
	pSOD3kvU2ZUJ9fW/2Z3jXIplx8ONc4Rs8zoVpW/sHb6lRS81eFbVD105PaUdhmELRSl1nTZWvs/
	Ftn82iG2fiSY0C2SsMiMrMeuvakpedm+41XDkahZpM1GVvhJXS/ceXq0Z8UmJA/PVaCFRbtOOnB
	grJM9TkEZsukcXZKRarDRTRIgo4lgcS2T7Zox7qNHuwmhKHlFlMEmucg2uBpp+017XaIc/2nrgG
	+W6wBzKJaWkg236UB0PzNUHNTZ+kxRK5/7LDOuOc3R9+uxVvuqEo7MS1b+FT1MvAHcSeELhiVTg
	KmHvCgD87t3aD9Q9M0i7V1IiuIpt8Nf1icExsi1lYa4nb6RpyMZ3lO7OPsPNc0MbNDBKDnYrAto
	2bF6Cn/ItPkay/IDKabypU3qf2mLIt6Ym+CvY82NZ2Qq1ynpWZCB8fq0hZa+nVJDatv0vdgWorz
	gHzj1jyZyFc1jlGuYTylG+PJF4g6v/H7Fx6DLsDGYsNv6L+td7kWYSb6dHxkruMW6NxAwqSs0v2
	TzsbcGbAzKuut8fu9Y5zMzT7fuF+b2SZoZ/9OMIU09fDpD3THrr7Ipq03ph8f9EyxMGqzMKfD6M
	L9hJEcc9yKumyD8B0
X-Received: by 2002:a05:701b:2506:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1b39fec935amr5689437c88.15.1794209396353;
        Sun, 08 Nov 2026 23:29:56 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771f0e0fsm15265320c88.20.2026.11.08.23.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:29:55 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <wsa@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Hyunjung Ko <hj351016@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: lm8323 - remove driver
Date: Sun,  8 Nov 2026 23:29:49 -0800
Message-ID: <20261109072950.3474308-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109072950.3474308-1-dmitry.torokhov@gmail.com>
References: <20261109072950.3474308-1-dmitry.torokhov@gmail.com>
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

The LM8323 keypad driver relies exclusively on legacy platform data,
has no Device Tree or generic device property support, and has no users
in mainline (including the Nokia N810 DTS, which never added support
for it). Its PWM/LED handling and unbind lifetime are broken, and after
hardware-tested IRQ fixes in 2011 the driver has for over a decade only
received mechanical API conversions and static-analysis cleanups
without hardware testing.

An inquiry on the mailing list asking whether anyone still uses or
wishes to keep the driver received no objections. Remove the driver
and its platform data header.

Link: https://lore.kernel.org/r/Zr6I9RB5mibU_12N@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/Kconfig       |  11 -
 drivers/input/keyboard/Makefile      |   1 -
 drivers/input/keyboard/lm8323.c      | 813 ---------------------------
 include/linux/platform_data/lm8323.h |  34 --
 4 files changed, 859 deletions(-)
 delete mode 100644 drivers/input/keyboard/lm8323.c
 delete mode 100644 include/linux/platform_data/lm8323.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d8c64f333462..a1102115093d 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -316,17 +316,6 @@ config KEYBOARD_HP7XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called jornada720_kbd.
 
-config KEYBOARD_LM8323
-	tristate "LM8323 keypad chip"
-	depends on I2C
-	depends on LEDS_CLASS
-	help
-	  If you say yes here you get support for the National Semiconductor
-	  LM8323 keypad controller.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called lm8323.
-
 config KEYBOARD_LM8333
 	tristate "LM8333 keypad chip"
 	depends on I2C
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 60bb7baf802f..282d41e346ba 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_KEYBOARD_IMX_BBM_SCMI)	+= imx-sm-bbm-key.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
 obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_LKKBD)		+= lkkbd.o
-obj-$(CONFIG_KEYBOARD_LM8323)		+= lm8323.o
 obj-$(CONFIG_KEYBOARD_LM8333)		+= lm8333.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
deleted file mode 100644
index 8eac63b2d304..000000000000
--- a/drivers/input/keyboard/lm8323.c
+++ /dev/null
@@ -1,813 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * drivers/i2c/chips/lm8323.c
- *
- * Copyright (C) 2007-2009 Nokia Corporation
- *
- * Written by Daniel Stone <daniel.stone@nokia.com>
- *            Timo O. Karjalainen <timo.o.karjalainen@nokia.com>
- *
- * Updated by Felipe Balbi <felipe.balbi@nokia.com>
- */
-
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/sched.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
-#include <linux/input.h>
-#include <linux/leds.h>
-#include <linux/platform_data/lm8323.h>
-#include <linux/pm.h>
-#include <linux/slab.h>
-#include <linux/string_choices.h>
-
-/* Commands to send to the chip. */
-#define LM8323_CMD_READ_ID		0x80 /* Read chip ID. */
-#define LM8323_CMD_WRITE_CFG		0x81 /* Set configuration item. */
-#define LM8323_CMD_READ_INT		0x82 /* Get interrupt status. */
-#define LM8323_CMD_RESET		0x83 /* Reset, same as external one */
-#define LM8323_CMD_WRITE_PORT_SEL	0x85 /* Set GPIO in/out. */
-#define LM8323_CMD_WRITE_PORT_STATE	0x86 /* Set GPIO pullup. */
-#define LM8323_CMD_READ_PORT_SEL	0x87 /* Get GPIO in/out. */
-#define LM8323_CMD_READ_PORT_STATE	0x88 /* Get GPIO pullup. */
-#define LM8323_CMD_READ_FIFO		0x89 /* Read byte from FIFO. */
-#define LM8323_CMD_RPT_READ_FIFO	0x8a /* Read FIFO (no increment). */
-#define LM8323_CMD_SET_ACTIVE		0x8b /* Set active time. */
-#define LM8323_CMD_READ_ERR		0x8c /* Get error status. */
-#define LM8323_CMD_READ_ROTATOR		0x8e /* Read rotator status. */
-#define LM8323_CMD_SET_DEBOUNCE		0x8f /* Set debouncing time. */
-#define LM8323_CMD_SET_KEY_SIZE		0x90 /* Set keypad size. */
-#define LM8323_CMD_READ_KEY_SIZE	0x91 /* Get keypad size. */
-#define LM8323_CMD_READ_CFG		0x92 /* Get configuration item. */
-#define LM8323_CMD_WRITE_CLOCK		0x93 /* Set clock config. */
-#define LM8323_CMD_READ_CLOCK		0x94 /* Get clock config. */
-#define LM8323_CMD_PWM_WRITE		0x95 /* Write PWM script. */
-#define LM8323_CMD_START_PWM		0x96 /* Start PWM engine. */
-#define LM8323_CMD_STOP_PWM		0x97 /* Stop PWM engine. */
-
-/* Interrupt status. */
-#define INT_KEYPAD			0x01 /* Key event. */
-#define INT_ROTATOR			0x02 /* Rotator event. */
-#define INT_ERROR			0x08 /* Error: use CMD_READ_ERR. */
-#define INT_NOINIT			0x10 /* Lost configuration. */
-#define INT_PWM1			0x20 /* PWM1 stopped. */
-#define INT_PWM2			0x40 /* PWM2 stopped. */
-#define INT_PWM3			0x80 /* PWM3 stopped. */
-
-/* Errors (signalled by INT_ERROR, read with CMD_READ_ERR). */
-#define ERR_BADPAR			0x01 /* Bad parameter. */
-#define ERR_CMDUNK			0x02 /* Unknown command. */
-#define ERR_KEYOVR			0x04 /* Too many keys pressed. */
-#define ERR_FIFOOVER			0x40 /* FIFO overflow. */
-
-/* Configuration keys (CMD_{WRITE,READ}_CFG). */
-#define CFG_MUX1SEL			0x01 /* Select MUX1_OUT input. */
-#define CFG_MUX1EN			0x02 /* Enable MUX1_OUT. */
-#define CFG_MUX2SEL			0x04 /* Select MUX2_OUT input. */
-#define CFG_MUX2EN			0x08 /* Enable MUX2_OUT. */
-#define CFG_PSIZE			0x20 /* Package size (must be 0). */
-#define CFG_ROTEN			0x40 /* Enable rotator. */
-
-/* Clock settings (CMD_{WRITE,READ}_CLOCK). */
-#define CLK_RCPWM_INTERNAL		0x00
-#define CLK_RCPWM_EXTERNAL		0x03
-#define CLK_SLOWCLKEN			0x08 /* Enable 32.768kHz clock. */
-#define CLK_SLOWCLKOUT			0x40 /* Enable slow pulse output. */
-
-/* The possible addresses corresponding to CONFIG1 and CONFIG2 pin wirings. */
-#define LM8323_I2C_ADDR00		(0x84 >> 1)	/* 1000 010x */
-#define LM8323_I2C_ADDR01		(0x86 >> 1)	/* 1000 011x */
-#define LM8323_I2C_ADDR10		(0x88 >> 1)	/* 1000 100x */
-#define LM8323_I2C_ADDR11		(0x8A >> 1)	/* 1000 101x */
-
-/* Key event fifo length */
-#define LM8323_FIFO_LEN			15
-
-/* Commands for PWM engine; feed in with PWM_WRITE. */
-/* Load ramp counter from duty cycle field (range 0 - 0xff). */
-#define PWM_SET(v)			(0x4000 | ((v) & 0xff))
-/* Go to start of script. */
-#define PWM_GOTOSTART			0x0000
-/*
- * Stop engine (generates interrupt).  If reset is 1, clear the program
- * counter, else leave it.
- */
-#define PWM_END(reset)			(0xc000 | (!!(reset) << 11))
-/*
- * Ramp.  If s is 1, divide clock by 512, else divide clock by 16.
- * Take t clock scales (up to 63) per step, for n steps (up to 126).
- * If u is set, ramp up, else ramp down.
- */
-#define PWM_RAMP(s, t, n, u)		((!!(s) << 14) | ((t) & 0x3f) << 8 | \
-					 ((n) & 0x7f) | ((u) ? 0 : 0x80))
-/*
- * Loop (i.e. jump back to pos) for a given number of iterations (up to 63).
- * If cnt is zero, execute until PWM_END is encountered.
- */
-#define PWM_LOOP(cnt, pos)		(0xa000 | (((cnt) & 0x3f) << 7) | \
-					 ((pos) & 0x3f))
-/*
- * Wait for trigger.  Argument is a mask of channels, shifted by the channel
- * number, e.g. 0xa for channels 3 and 1.  Note that channels are numbered
- * from 1, not 0.
- */
-#define PWM_WAIT_TRIG(chans)		(0xe000 | (((chans) & 0x7) << 6))
-/* Send trigger.  Argument is same as PWM_WAIT_TRIG. */
-#define PWM_SEND_TRIG(chans)		(0xe000 | ((chans) & 0x7))
-
-struct lm8323_pwm {
-	int			id;
-	int			fade_time;
-	int			brightness;
-	int			desired_brightness;
-	bool			enabled;
-	bool			running;
-	/* pwm lock */
-	struct mutex		lock;
-	struct work_struct	work;
-	struct led_classdev	cdev;
-	struct lm8323_chip	*chip;
-};
-
-struct lm8323_chip {
-	/* device lock */
-	struct mutex		lock;
-	struct i2c_client	*client;
-	struct input_dev	*idev;
-	bool			kp_enabled;
-	bool			pm_suspend;
-	unsigned		keys_down;
-	char			phys[32];
-	unsigned short		keymap[LM8323_KEYMAP_SIZE];
-	int			size_x;
-	int			size_y;
-	int			debounce_time;
-	int			active_time;
-	struct lm8323_pwm	pwm[LM8323_NUM_PWMS];
-};
-
-#define client_to_lm8323(c)	container_of(c, struct lm8323_chip, client)
-#define dev_to_lm8323(d)	container_of(d, struct lm8323_chip, client->dev)
-#define cdev_to_pwm(c)		container_of(c, struct lm8323_pwm, cdev)
-#define work_to_pwm(w)		container_of(w, struct lm8323_pwm, work)
-
-#define LM8323_MAX_DATA 8
-
-/*
- * To write, we just access the chip's address in write mode, and dump the
- * command and data out on the bus.  The command byte and data are taken as
- * sequential u8s out of varargs, to a maximum of LM8323_MAX_DATA.
- */
-static int lm8323_write(struct lm8323_chip *lm, int len, ...)
-{
-	int ret, i;
-	va_list ap;
-	u8 data[LM8323_MAX_DATA];
-
-	va_start(ap, len);
-
-	if (unlikely(len > LM8323_MAX_DATA)) {
-		dev_err(&lm->client->dev, "tried to send %d bytes\n", len);
-		va_end(ap);
-		return 0;
-	}
-
-	for (i = 0; i < len; i++)
-		data[i] = va_arg(ap, int);
-
-	va_end(ap);
-
-	/*
-	 * If the host is asleep while we send the data, we can get a NACK
-	 * back while it wakes up, so try again, once.
-	 */
-	ret = i2c_master_send(lm->client, data, len);
-	if (unlikely(ret == -EREMOTEIO))
-		ret = i2c_master_send(lm->client, data, len);
-	if (unlikely(ret != len))
-		dev_err(&lm->client->dev, "sent %d bytes of %d total\n",
-			len, ret);
-
-	return ret;
-}
-
-/*
- * To read, we first send the command byte to the chip and end the transaction,
- * then access the chip in read mode, at which point it will send the data.
- */
-static int lm8323_read(struct lm8323_chip *lm, u8 cmd, u8 *buf, int len)
-{
-	int ret;
-
-	/*
-	 * If the host is asleep while we send the byte, we can get a NACK
-	 * back while it wakes up, so try again, once.
-	 */
-	ret = i2c_master_send(lm->client, &cmd, 1);
-	if (unlikely(ret == -EREMOTEIO))
-		ret = i2c_master_send(lm->client, &cmd, 1);
-	if (unlikely(ret != 1)) {
-		dev_err(&lm->client->dev, "sending read cmd 0x%02x failed\n",
-			cmd);
-		return 0;
-	}
-
-	ret = i2c_master_recv(lm->client, buf, len);
-	if (unlikely(ret != len))
-		dev_err(&lm->client->dev, "wanted %d bytes, got %d\n",
-			len, ret);
-
-	return ret;
-}
-
-/*
- * Set the chip active time (idle time before it enters halt).
- */
-static void lm8323_set_active_time(struct lm8323_chip *lm, int time)
-{
-	lm8323_write(lm, 2, LM8323_CMD_SET_ACTIVE, time >> 2);
-}
-
-/*
- * The signals are AT-style: the low 7 bits are the keycode, and the top
- * bit indicates the state (1 for down, 0 for up).
- */
-static inline u8 lm8323_whichkey(u8 event)
-{
-	return event & 0x7f;
-}
-
-static inline int lm8323_ispress(u8 event)
-{
-	return (event & 0x80) ? 1 : 0;
-}
-
-static void process_keys(struct lm8323_chip *lm)
-{
-	u8 event;
-	u8 key_fifo[LM8323_FIFO_LEN + 1];
-	int old_keys_down = lm->keys_down;
-	int ret;
-	int i = 0;
-
-	/*
-	 * Read all key events from the FIFO at once. Next READ_FIFO clears the
-	 * FIFO even if we didn't read all events previously.
-	 */
-	ret = lm8323_read(lm, LM8323_CMD_READ_FIFO, key_fifo, LM8323_FIFO_LEN);
-
-	if (ret < 0) {
-		dev_err(&lm->client->dev, "Failed reading fifo\n");
-		return;
-	}
-	key_fifo[ret] = 0;
-
-	while ((event = key_fifo[i++])) {
-		u8 key = lm8323_whichkey(event);
-		int isdown = lm8323_ispress(event);
-		unsigned short keycode = lm->keymap[key];
-
-		dev_vdbg(&lm->client->dev, "key 0x%02x %s\n",
-			 key, str_down_up(isdown));
-
-		if (lm->kp_enabled) {
-			input_event(lm->idev, EV_MSC, MSC_SCAN, key);
-			input_report_key(lm->idev, keycode, isdown);
-			input_sync(lm->idev);
-		}
-
-		if (isdown)
-			lm->keys_down++;
-		else
-			lm->keys_down--;
-	}
-
-	/*
-	 * Errata: We need to ensure that the chip never enters halt mode
-	 * during a keypress, so set active time to 0.  When it's released,
-	 * we can enter halt again, so set the active time back to normal.
-	 */
-	if (!old_keys_down && lm->keys_down)
-		lm8323_set_active_time(lm, 0);
-	if (old_keys_down && !lm->keys_down)
-		lm8323_set_active_time(lm, lm->active_time);
-}
-
-static void lm8323_process_error(struct lm8323_chip *lm)
-{
-	u8 error;
-
-	if (lm8323_read(lm, LM8323_CMD_READ_ERR, &error, 1) == 1) {
-		if (error & ERR_FIFOOVER)
-			dev_vdbg(&lm->client->dev, "fifo overflow!\n");
-		if (error & ERR_KEYOVR)
-			dev_vdbg(&lm->client->dev,
-					"more than two keys pressed\n");
-		if (error & ERR_CMDUNK)
-			dev_vdbg(&lm->client->dev,
-					"unknown command submitted\n");
-		if (error & ERR_BADPAR)
-			dev_vdbg(&lm->client->dev, "bad command parameter\n");
-	}
-}
-
-static void lm8323_reset(struct lm8323_chip *lm)
-{
-	/* The docs say we must pass 0xAA as the data byte. */
-	lm8323_write(lm, 2, LM8323_CMD_RESET, 0xAA);
-}
-
-static int lm8323_configure(struct lm8323_chip *lm)
-{
-	int keysize = (lm->size_x << 4) | lm->size_y;
-	int clock = (CLK_SLOWCLKEN | CLK_RCPWM_EXTERNAL);
-	int debounce = lm->debounce_time >> 2;
-	int active = lm->active_time >> 2;
-
-	/*
-	 * Active time must be greater than the debounce time: if it's
-	 * a close-run thing, give ourselves a 12ms buffer.
-	 */
-	if (debounce >= active)
-		active = debounce + 3;
-
-	lm8323_write(lm, 2, LM8323_CMD_WRITE_CFG, 0);
-	lm8323_write(lm, 2, LM8323_CMD_WRITE_CLOCK, clock);
-	lm8323_write(lm, 2, LM8323_CMD_SET_KEY_SIZE, keysize);
-	lm8323_set_active_time(lm, lm->active_time);
-	lm8323_write(lm, 2, LM8323_CMD_SET_DEBOUNCE, debounce);
-	lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_STATE, 0xff, 0xff);
-	lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_SEL, 0, 0);
-
-	/*
-	 * Not much we can do about errors at this point, so just hope
-	 * for the best.
-	 */
-
-	return 0;
-}
-
-static void pwm_done(struct lm8323_pwm *pwm)
-{
-	guard(mutex)(&pwm->lock);
-
-	pwm->running = false;
-	if (pwm->desired_brightness != pwm->brightness)
-		schedule_work(&pwm->work);
-}
-
-/*
- * Bottom half: handle the interrupt by posting key events, or dealing with
- * errors appropriately.
- */
-static irqreturn_t lm8323_irq(int irq, void *_lm)
-{
-	struct lm8323_chip *lm = _lm;
-	u8 ints;
-	int i;
-
-	guard(mutex)(&lm->lock);
-
-	while ((lm8323_read(lm, LM8323_CMD_READ_INT, &ints, 1) == 1) && ints) {
-		if (likely(ints & INT_KEYPAD))
-			process_keys(lm);
-		if (ints & INT_ROTATOR) {
-			/* We don't currently support the rotator. */
-			dev_vdbg(&lm->client->dev, "rotator fired\n");
-		}
-		if (ints & INT_ERROR) {
-			dev_vdbg(&lm->client->dev, "error!\n");
-			lm8323_process_error(lm);
-		}
-		if (ints & INT_NOINIT) {
-			dev_err(&lm->client->dev, "chip lost config; "
-						  "reinitialising\n");
-			lm8323_configure(lm);
-		}
-		for (i = 0; i < LM8323_NUM_PWMS; i++) {
-			if (ints & (INT_PWM1 << i)) {
-				dev_vdbg(&lm->client->dev,
-					 "pwm%d engine completed\n", i);
-				pwm_done(&lm->pwm[i]);
-			}
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Read the chip ID.
- */
-static int lm8323_read_id(struct lm8323_chip *lm, u8 *buf)
-{
-	int bytes;
-
-	bytes = lm8323_read(lm, LM8323_CMD_READ_ID, buf, 2);
-	if (unlikely(bytes != 2))
-		return -EIO;
-
-	return 0;
-}
-
-static void lm8323_write_pwm_one(struct lm8323_pwm *pwm, int pos, u16 cmd)
-{
-	lm8323_write(pwm->chip, 4, LM8323_CMD_PWM_WRITE, (pos << 2) | pwm->id,
-		     (cmd & 0xff00) >> 8, cmd & 0x00ff);
-}
-
-/*
- * Write a script into a given PWM engine, concluding with PWM_END.
- * If 'kill' is nonzero, the engine will be shut down at the end
- * of the script, producing a zero output. Otherwise the engine
- * will be kept running at the final PWM level indefinitely.
- */
-static void lm8323_write_pwm(struct lm8323_pwm *pwm, int kill,
-			     int len, const u16 *cmds)
-{
-	int i;
-
-	for (i = 0; i < len; i++)
-		lm8323_write_pwm_one(pwm, i, cmds[i]);
-
-	lm8323_write_pwm_one(pwm, i++, PWM_END(kill));
-	lm8323_write(pwm->chip, 2, LM8323_CMD_START_PWM, pwm->id);
-	pwm->running = true;
-}
-
-static void lm8323_pwm_work(struct work_struct *work)
-{
-	struct lm8323_pwm *pwm = work_to_pwm(work);
-	int div512, perstep, steps, hz, up, kill;
-	u16 pwm_cmds[3];
-	int num_cmds = 0;
-
-	guard(mutex)(&pwm->lock);
-
-	/*
-	 * Do nothing if we're already at the requested level,
-	 * or previous setting is not yet complete. In the latter
-	 * case we will be called again when the previous PWM script
-	 * finishes.
-	 */
-	if (pwm->running || pwm->desired_brightness == pwm->brightness)
-		return;
-
-	kill = (pwm->desired_brightness == 0);
-	up = (pwm->desired_brightness > pwm->brightness);
-	steps = abs(pwm->desired_brightness - pwm->brightness);
-
-	/*
-	 * Convert time (in ms) into a divisor (512 or 16 on a refclk of
-	 * 32768Hz), and number of ticks per step.
-	 */
-	if ((pwm->fade_time / steps) > (32768 / 512)) {
-		div512 = 1;
-		hz = 32768 / 512;
-	} else {
-		div512 = 0;
-		hz = 32768 / 16;
-	}
-
-	perstep = (hz * pwm->fade_time) / (steps * 1000);
-
-	if (perstep == 0)
-		perstep = 1;
-	else if (perstep > 63)
-		perstep = 63;
-
-	while (steps) {
-		int s;
-
-		s = min(126, steps);
-		pwm_cmds[num_cmds++] = PWM_RAMP(div512, perstep, s, up);
-		steps -= s;
-	}
-
-	lm8323_write_pwm(pwm, kill, num_cmds, pwm_cmds);
-	pwm->brightness = pwm->desired_brightness;
-}
-
-static void lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
-				      enum led_brightness brightness)
-{
-	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
-	struct lm8323_chip *lm = pwm->chip;
-
-	scoped_guard(mutex, &pwm->lock) {
-		pwm->desired_brightness = brightness;
-	}
-
-	if (in_interrupt()) {
-		schedule_work(&pwm->work);
-	} else {
-		/*
-		 * Schedule PWM work as usual unless we are going into suspend
-		 */
-		scoped_guard(mutex, &lm->lock) {
-			if (likely(!lm->pm_suspend))
-				schedule_work(&pwm->work);
-			else
-				lm8323_pwm_work(&pwm->work);
-		}
-	}
-}
-
-static ssize_t lm8323_pwm_show_time(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct led_classdev *led_cdev = dev_get_drvdata(dev);
-	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
-
-	return sprintf(buf, "%d\n", pwm->fade_time);
-}
-
-static ssize_t lm8323_pwm_store_time(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct led_classdev *led_cdev = dev_get_drvdata(dev);
-	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
-	int ret, time;
-
-	ret = kstrtoint(buf, 10, &time);
-	/* Numbers only, please. */
-	if (ret)
-		return ret;
-
-	pwm->fade_time = time;
-
-	return strlen(buf);
-}
-static DEVICE_ATTR(time, 0644, lm8323_pwm_show_time, lm8323_pwm_store_time);
-
-static struct attribute *lm8323_pwm_attrs[] = {
-	&dev_attr_time.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(lm8323_pwm);
-
-static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
-		    const char *name)
-{
-	struct lm8323_pwm *pwm;
-	int err;
-
-	BUG_ON(id > 3);
-
-	pwm = &lm->pwm[id - 1];
-
-	pwm->id = id;
-	pwm->fade_time = 0;
-	pwm->brightness = 0;
-	pwm->desired_brightness = 0;
-	pwm->running = false;
-	pwm->enabled = false;
-	INIT_WORK(&pwm->work, lm8323_pwm_work);
-	mutex_init(&pwm->lock);
-	pwm->chip = lm;
-
-	if (name) {
-		pwm->cdev.name = name;
-		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
-		pwm->cdev.groups = lm8323_pwm_groups;
-
-		err = devm_led_classdev_register(dev, &pwm->cdev);
-		if (err) {
-			dev_err(dev, "couldn't register PWM %d: %d\n", id, err);
-			return err;
-		}
-		pwm->enabled = true;
-	}
-
-	return 0;
-}
-
-static ssize_t lm8323_show_disable(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct lm8323_chip *lm = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%u\n", !lm->kp_enabled);
-}
-
-static ssize_t lm8323_set_disable(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct lm8323_chip *lm = dev_get_drvdata(dev);
-	int ret;
-	unsigned int i;
-
-	ret = kstrtouint(buf, 10, &i);
-	if (ret)
-		return ret;
-
-	guard(mutex)(&lm->lock);
-
-	lm->kp_enabled = !i;
-
-	return count;
-}
-static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
-
-static struct attribute *lm8323_attrs[] = {
-	&dev_attr_disable_kp.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(lm8323);
-
-static int lm8323_probe(struct i2c_client *client)
-{
-	struct lm8323_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct input_dev *idev;
-	struct lm8323_chip *lm;
-	int pwm;
-	int i, err;
-	unsigned long tmo;
-	u8 data[2];
-
-	if (!pdata || !pdata->size_x || !pdata->size_y) {
-		dev_err(&client->dev, "missing platform_data\n");
-		return -EINVAL;
-	}
-
-	if (pdata->size_x > 8) {
-		dev_err(&client->dev, "invalid x size %d specified\n",
-			pdata->size_x);
-		return -EINVAL;
-	}
-
-	if (pdata->size_y > 12) {
-		dev_err(&client->dev, "invalid y size %d specified\n",
-			pdata->size_y);
-		return -EINVAL;
-	}
-
-	lm = devm_kzalloc(&client->dev, sizeof(*lm), GFP_KERNEL);
-	if (!lm)
-		return -ENOMEM;
-
-	idev = devm_input_allocate_device(&client->dev);
-	if (!idev)
-		return -ENOMEM;
-
-	lm->client = client;
-	lm->idev = idev;
-	mutex_init(&lm->lock);
-
-	lm->size_x = pdata->size_x;
-	lm->size_y = pdata->size_y;
-	dev_vdbg(&client->dev, "Keypad size: %d x %d\n",
-		 lm->size_x, lm->size_y);
-
-	lm->debounce_time = pdata->debounce_time;
-	lm->active_time = pdata->active_time;
-
-	lm8323_reset(lm);
-
-	/*
-	 * Nothing's set up to service the IRQ yet, so just spin for max.
-	 * 100ms until we can configure.
-	 */
-	tmo = jiffies + msecs_to_jiffies(100);
-	while (lm8323_read(lm, LM8323_CMD_READ_INT, data, 1) == 1) {
-		if (data[0] & INT_NOINIT)
-			break;
-
-		if (time_after(jiffies, tmo)) {
-			dev_err(&client->dev,
-				"timeout waiting for initialisation\n");
-			break;
-		}
-
-		msleep(1);
-	}
-
-	lm8323_configure(lm);
-
-	/* If a true probe check the device */
-	if (lm8323_read_id(lm, data) != 0) {
-		dev_err(&client->dev, "device not found\n");
-		return -ENODEV;
-	}
-
-	for (pwm = 0; pwm < LM8323_NUM_PWMS; pwm++) {
-		err = init_pwm(lm, pwm + 1, &client->dev,
-			       pdata->pwm_names[pwm]);
-		if (err)
-			return err;
-	}
-
-	lm->kp_enabled = true;
-
-	idev->name = pdata->name ? : "LM8323 keypad";
-	snprintf(lm->phys, sizeof(lm->phys),
-		 "%s/input-kp", dev_name(&client->dev));
-	idev->phys = lm->phys;
-
-	idev->evbit[0] = BIT(EV_KEY) | BIT(EV_MSC);
-	__set_bit(MSC_SCAN, idev->mscbit);
-	for (i = 0; i < LM8323_KEYMAP_SIZE; i++) {
-		__set_bit(pdata->keymap[i], idev->keybit);
-		lm->keymap[i] = pdata->keymap[i];
-	}
-	__clear_bit(KEY_RESERVED, idev->keybit);
-
-	if (pdata->repeat)
-		__set_bit(EV_REP, idev->evbit);
-
-	err = input_register_device(idev);
-	if (err) {
-		dev_dbg(&client->dev, "error registering input device\n");
-		return err;
-	}
-
-	err = devm_request_threaded_irq(&client->dev, client->irq,
-					NULL, lm8323_irq,
-					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					"lm8323", lm);
-	if (err) {
-		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
-		return err;
-	}
-
-	i2c_set_clientdata(client, lm);
-
-	device_init_wakeup(&client->dev, 1);
-	enable_irq_wake(client->irq);
-
-	return 0;
-}
-
-/*
- * We don't need to explicitly suspend the chip, as it already switches off
- * when there's no activity.
- */
-static int lm8323_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm8323_chip *lm = i2c_get_clientdata(client);
-	int i;
-
-	irq_set_irq_wake(client->irq, 0);
-	disable_irq(client->irq);
-
-	scoped_guard(mutex, &lm->lock) {
-		lm->pm_suspend = true;
-	}
-
-	for (i = 0; i < 3; i++)
-		if (lm->pwm[i].enabled)
-			led_classdev_suspend(&lm->pwm[i].cdev);
-
-	return 0;
-}
-
-static int lm8323_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm8323_chip *lm = i2c_get_clientdata(client);
-	int i;
-
-	scoped_guard(mutex, &lm->lock) {
-		lm->pm_suspend = false;
-	}
-
-	for (i = 0; i < 3; i++)
-		if (lm->pwm[i].enabled)
-			led_classdev_resume(&lm->pwm[i].cdev);
-
-	enable_irq(client->irq);
-	irq_set_irq_wake(client->irq, 1);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(lm8323_pm_ops, lm8323_suspend, lm8323_resume);
-
-static const struct i2c_device_id lm8323_id[] = {
-	{ .name = "lm8323" },
-	{ }
-};
-
-static struct i2c_driver lm8323_i2c_driver = {
-	.driver = {
-		.name		= "lm8323",
-		.pm		= pm_sleep_ptr(&lm8323_pm_ops),
-		.dev_groups	= lm8323_groups,
-	},
-	.probe		= lm8323_probe,
-	.id_table	= lm8323_id,
-};
-MODULE_DEVICE_TABLE(i2c, lm8323_id);
-
-module_i2c_driver(lm8323_i2c_driver);
-
-MODULE_AUTHOR("Timo O. Karjalainen <timo.o.karjalainen@nokia.com>");
-MODULE_AUTHOR("Daniel Stone");
-MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
-MODULE_DESCRIPTION("LM8323 keypad driver");
-MODULE_LICENSE("GPL");
-
diff --git a/include/linux/platform_data/lm8323.h b/include/linux/platform_data/lm8323.h
deleted file mode 100644
index 311999260614..000000000000
--- a/include/linux/platform_data/lm8323.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * lm8323.h - Configuration for LM8323 keypad driver.
- */
-
-#ifndef __LINUX_LM8323_H
-#define __LINUX_LM8323_H
-
-#include <linux/types.h>
-
-/*
- * Largest keycode that the chip can send, plus one,
- * so keys can be mapped directly at the index of the
- * LM8323 keycode instead of subtracting one.
- */
-#define LM8323_KEYMAP_SIZE	(0x7f + 1)
-
-#define LM8323_NUM_PWMS		3
-
-struct lm8323_platform_data {
-	int debounce_time; /* Time to watch for key bouncing, in ms. */
-	int active_time; /* Idle time until sleep, in ms. */
-
-	int size_x;
-	int size_y;
-	bool repeat;
-	const unsigned short *keymap;
-
-	const char *pwm_names[LM8323_NUM_PWMS];
-
-	const char *name; /* Device name. */
-};
-
-#endif /* __LINUX_LM8323_H */
-- 
2.56.0.506.g506a7eabc5-goog

