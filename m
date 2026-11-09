Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C6606A325
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 695C6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UYP0AoxB
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so633439c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794209399; x=1794814199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLa2TsfrRy1AdRRg9l7WHzKyohtBt7sUVnyih2ASIRU=;
        b=UYP0AoxBWzGSOddCygQ8h542yBnYyHc21NPwEWAZQ1ktmjf6/t+DGLHIsXlgAWzssu
         uXK8xi1qHX6rI4UXlXHK155V1vouj0cbeiwJoD7Y724Cc9QVh3WiR+mX9PwUtyDtW2W4
         KIQITDFRsu3eLzSJpAXQ2xGcW0E5gXbm6GT0bw4SvytjgCes6wQ/Td0L+hEON5FX4mQT
         NsQCQ9TpA3vbrvIGUep2JYcE8DWd0UrJ3CS6BZnRnSC4TMy6v4IV5PrMSv0HF4HgCYyL
         h7V8blixpnKdoDy5JMHKFZMDc6Dvu+4H5/303GNhU2fynb5Lc9wIJA58Mqxpqa1Qjofp
         UKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794209399; x=1794814199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLa2TsfrRy1AdRRg9l7WHzKyohtBt7sUVnyih2ASIRU=;
        b=Xc0UVZhVuPUnGUOkGpPT1nMXvvamgkLlo4NxiFkr+M/9oZ4geGgKzh0VE3mqiqp1l6
         7SyOqIL+XzSZW3PgG9eUkhS2r+4UvvINvBEzGj0po1kpq5vsfv5oA0rXXfYayGh/h3Be
         okDVgpBhaVxZFqaR26VN9NQPVP4MgFJGzu3ciHGO2DJ4HitvcUW6thRv1Em2pLI1/WkW
         1YQEpludjdJMi5vdngfQ1p0wmAodIw32tNmYWRYmsvOwfa2xqYtHYFcEu+7SUbtFojvS
         wfe+F2E4mQB8OVCHJWjOdkV6XPvtqgfO7hKN/0SHQDMSaCYdmaJDa2VuARbCK+79LNJD
         H1NA==
X-Forwarded-Encrypted: i=1; AL+hErE3RqJgBglCDgDcF5o6kXJK5iuX2A57hgmzmdxaAcLj3yAE5FR3WGTy1jQXgTb2Dw3zjKWGk5JzcsJeeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/n3cjY+7odxsTiFIDHmb5cTumzNImNrsusYBAO4UffiyEfLitl
	YVR1c9KYqhJxvnRsYLezMFhXONu7vM3a1McLjStiAJJljidUvUt3wUn8
X-Gm-Gg: AYBFou3k6Okx7i1n4jncizaahLWqmXiokn6N9i4WIusjxNgu8si3cjoOVMWxrdAnDtl
	PurWm+vG0IaLUBwceB2OoyIs3DbefjIxv8idLTsZVIV+zliiXKaMMB1sA/VVJcae2ihWAZnu++h
	FbPP/PogxbUf1URK1HSF673hivAmuc4HjjfIGI98Fh8ZjCwbYLrCvTPsw2dZXL7eJsm3+2dCsAT
	D7NA25FSoCKFbJx0f+PzxkegczLdNmAypcU2Emdu0bMZN1YgCkkDSlqHNPAAcxB/cXo8uIIbhHV
	rk8aPWE8EGXqelRhke9Mw0oJAlWL3y2dW1ZqGbQ6W2NTkzXHbPWJyB+zXXnum36NeW4kDcHoQCz
	QUZOCZhIJNI5zmLV0Wz6bnlmL6k0877UEa3Mi4ZN2IKCbyaOxHfros9zsdd7p2PRNORf6AL4+ek
	mib2Z82SxieicNtCUVuNJhgb6BTpsYNpQmDLNdmO6b06E3lnnbO1jUy0cQMidgBqa15VKOrdCos
	+zCE+HY4sMJFFqlPzP/gpMQ+940EcohJ4X4SQaJ+Wx0bgEOncNkJJKTL9U4w+WXAteC2/vk1sfg
	s+V6Ff9VSNEss3uD7jKM/XCAglfoUHfiovsWG1eJlLcKs1yfsI7iVnXnnryzSh/MdCQeojj9eIZ
	8rvw1y+A22lCDteqn
X-Received: by 2002:a05:7022:8b:b0:152:9e88:daaa with SMTP id a92af1059eb24-1b39fef8f2cmr5210143c88.36.1794209398263;
        Sun, 08 Nov 2026 23:29:58 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771f0e0fsm15265320c88.20.2026.11.08.23.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:29:57 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <wsa@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Hyunjung Ko <hj351016@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: lm8333 - remove driver
Date: Sun,  8 Nov 2026 23:29:50 -0800
Message-ID: <20261109072950.3474308-3-dmitry.torokhov@gmail.com>
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

The LM8333 keypad driver relies exclusively on legacy platform data,
has no Device Tree or generic device property support, and has no
users in mainline. The BSP board file it was originally written for
was never upstreamed, and the original author Wolfram Sang confirmed
in the mailing list discussion that it will likely never be converted
to Device Tree and agreed to dropping it.

Remove the driver and its platform data header.

Link: https://lore.kernel.org/r/Zr6I9RB5mibU_12N@google.com
Link: https://lore.kernel.org/r/Zr6PnlsdoyLoX261@shikoro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/Kconfig  |  11 --
 drivers/input/keyboard/Makefile |   1 -
 drivers/input/keyboard/lm8333.c | 213 --------------------------------
 include/linux/input/lm8333.h    |  24 ----
 4 files changed, 249 deletions(-)
 delete mode 100644 drivers/input/keyboard/lm8333.c
 delete mode 100644 include/linux/input/lm8333.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a1102115093d..cc6d22394c39 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -316,17 +316,6 @@ config KEYBOARD_HP7XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called jornada720_kbd.
 
-config KEYBOARD_LM8333
-	tristate "LM8333 keypad chip"
-	depends on I2C
-	select INPUT_MATRIXKMAP
-	help
-	  If you say yes here you get support for the National Semiconductor
-	  LM8333 keypad controller.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called lm8333.
-
 config KEYBOARD_LOCOMO
 	tristate "LoCoMo Keyboard Support"
 	depends on SHARP_LOCOMO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 282d41e346ba..110b250e6e51 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_KEYBOARD_IMX_BBM_SCMI)	+= imx-sm-bbm-key.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
 obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_LKKBD)		+= lkkbd.o
-obj-$(CONFIG_KEYBOARD_LM8333)		+= lm8333.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
deleted file mode 100644
index 84e1faf1f5ab..000000000000
--- a/drivers/input/keyboard/lm8333.c
+++ /dev/null
@@ -1,213 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * LM8333 keypad driver
- * Copyright (C) 2012 Wolfram Sang, Pengutronix <kernel@pengutronix.de>
- */
-
-#include <linux/i2c.h>
-#include <linux/input.h>
-#include <linux/input/matrix_keypad.h>
-#include <linux/input/lm8333.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#define LM8333_FIFO_READ		0x20
-#define LM8333_DEBOUNCE			0x22
-#define LM8333_READ_INT			0xD0
-#define LM8333_ACTIVE			0xE4
-#define LM8333_READ_ERROR		0xF0
-
-#define LM8333_KEYPAD_IRQ		(1 << 0)
-#define LM8333_ERROR_IRQ		(1 << 3)
-
-#define LM8333_ERROR_KEYOVR		0x04
-#define LM8333_ERROR_FIFOOVR		0x40
-
-#define LM8333_FIFO_TRANSFER_SIZE	16
-
-#define LM8333_NUM_ROWS		8
-#define LM8333_NUM_COLS		16
-#define LM8333_ROW_SHIFT	4
-
-struct lm8333 {
-	struct i2c_client *client;
-	struct input_dev *input;
-	unsigned short keycodes[LM8333_NUM_ROWS << LM8333_ROW_SHIFT];
-};
-
-/* The accessors try twice because the first access may be needed for wakeup */
-#define LM8333_READ_RETRIES 2
-
-int lm8333_read8(struct lm8333 *lm8333, u8 cmd)
-{
-	int retries = 0, ret;
-
-	do {
-		ret = i2c_smbus_read_byte_data(lm8333->client, cmd);
-	} while (ret < 0 && retries++ < LM8333_READ_RETRIES);
-
-	return ret;
-}
-
-int lm8333_write8(struct lm8333 *lm8333, u8 cmd, u8 val)
-{
-	int retries = 0, ret;
-
-	do {
-		ret = i2c_smbus_write_byte_data(lm8333->client, cmd, val);
-	} while (ret < 0 && retries++ < LM8333_READ_RETRIES);
-
-	return ret;
-}
-
-int lm8333_read_block(struct lm8333 *lm8333, u8 cmd, u8 len, u8 *buf)
-{
-	int retries = 0, ret;
-
-	do {
-		ret = i2c_smbus_read_i2c_block_data(lm8333->client,
-						    cmd, len, buf);
-	} while (ret < 0 && retries++ < LM8333_READ_RETRIES);
-
-	return ret;
-}
-
-static void lm8333_key_handler(struct lm8333 *lm8333)
-{
-	struct input_dev *input = lm8333->input;
-	u8 keys[LM8333_FIFO_TRANSFER_SIZE];
-	u8 code, pressed;
-	int i, ret;
-
-	ret = lm8333_read_block(lm8333, LM8333_FIFO_READ,
-				LM8333_FIFO_TRANSFER_SIZE, keys);
-	if (ret != LM8333_FIFO_TRANSFER_SIZE) {
-		dev_err(&lm8333->client->dev,
-			"Error %d while reading FIFO\n", ret);
-		return;
-	}
-
-	for (i = 0; i < LM8333_FIFO_TRANSFER_SIZE && keys[i]; i++) {
-		pressed = keys[i] & 0x80;
-		code = keys[i] & 0x7f;
-
-		input_event(input, EV_MSC, MSC_SCAN, code);
-		input_report_key(input, lm8333->keycodes[code], pressed);
-	}
-
-	input_sync(input);
-}
-
-static irqreturn_t lm8333_irq_thread(int irq, void *data)
-{
-	struct lm8333 *lm8333 = data;
-	u8 status = lm8333_read8(lm8333, LM8333_READ_INT);
-
-	if (!status)
-		return IRQ_NONE;
-
-	if (status & LM8333_ERROR_IRQ) {
-		u8 err = lm8333_read8(lm8333, LM8333_READ_ERROR);
-
-		if (err & (LM8333_ERROR_KEYOVR | LM8333_ERROR_FIFOOVR)) {
-			u8 dummy[LM8333_FIFO_TRANSFER_SIZE];
-
-			lm8333_read_block(lm8333, LM8333_FIFO_READ,
-					LM8333_FIFO_TRANSFER_SIZE, dummy);
-		}
-		dev_err(&lm8333->client->dev, "Got error %02x\n", err);
-	}
-
-	if (status & LM8333_KEYPAD_IRQ)
-		lm8333_key_handler(lm8333);
-
-	return IRQ_HANDLED;
-}
-
-static int lm8333_probe(struct i2c_client *client)
-{
-	const struct lm8333_platform_data *pdata =
-			dev_get_platdata(&client->dev);
-	struct lm8333 *lm8333;
-	struct input_dev *input;
-	int err, active_time;
-
-	if (!pdata)
-		return -EINVAL;
-
-	active_time = pdata->active_time ?: 500;
-	if (active_time / 3 <= pdata->debounce_time / 3) {
-		dev_err(&client->dev, "Active time not big enough!\n");
-		return -EINVAL;
-	}
-
-	lm8333 = devm_kzalloc(&client->dev, sizeof(*lm8333), GFP_KERNEL);
-	if (!lm8333)
-		return -ENOMEM;
-
-	input = devm_input_allocate_device(&client->dev);
-	if (!input)
-		return -ENOMEM;
-
-	lm8333->client = client;
-	lm8333->input = input;
-
-	input->name = client->name;
-	input->id.bustype = BUS_I2C;
-
-	input_set_capability(input, EV_MSC, MSC_SCAN);
-
-	err = matrix_keypad_build_keymap(pdata->matrix_data,
-					 LM8333_NUM_ROWS, LM8333_NUM_COLS,
-					 lm8333->keycodes, input);
-	if (err)
-		return err;
-
-	if (pdata->debounce_time) {
-		err = lm8333_write8(lm8333, LM8333_DEBOUNCE,
-				    pdata->debounce_time / 3);
-		if (err)
-			dev_warn(&client->dev, "Unable to set debounce time\n");
-	}
-
-	if (pdata->active_time) {
-		err = lm8333_write8(lm8333, LM8333_ACTIVE,
-				    pdata->active_time / 3);
-		if (err)
-			dev_warn(&client->dev, "Unable to set active time\n");
-	}
-
-	err = devm_request_threaded_irq(&client->dev, client->irq,
-					NULL, lm8333_irq_thread,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					"lm8333", lm8333);
-	if (err)
-		return err;
-
-	err = input_register_device(input);
-	if (err)
-		return err;
-
-	i2c_set_clientdata(client, lm8333);
-	return 0;
-}
-
-static const struct i2c_device_id lm8333_id[] = {
-	{ .name = "lm8333" },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm8333_id);
-
-static struct i2c_driver lm8333_driver = {
-	.driver = {
-		.name		= "lm8333",
-	},
-	.probe		= lm8333_probe,
-	.id_table	= lm8333_id,
-};
-module_i2c_driver(lm8333_driver);
-
-MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
-MODULE_DESCRIPTION("LM8333 keyboard driver");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/input/lm8333.h b/include/linux/input/lm8333.h
deleted file mode 100644
index 906da5fc06e0..000000000000
--- a/include/linux/input/lm8333.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * public include for LM8333 keypad driver - same license as driver
- * Copyright (C) 2012 Wolfram Sang, Pengutronix <kernel@pengutronix.de>
- */
-
-#ifndef _LM8333_H
-#define _LM8333_H
-
-struct lm8333;
-
-struct lm8333_platform_data {
-	/* Keymap data */
-	const struct matrix_keymap_data *matrix_data;
-	/* Active timeout before enter HALT mode in microseconds */
-	unsigned active_time;
-	/* Debounce interval in microseconds */
-	unsigned debounce_time;
-};
-
-extern int lm8333_read8(struct lm8333 *lm8333, u8 cmd);
-extern int lm8333_write8(struct lm8333 *lm8333, u8 cmd, u8 val);
-extern int lm8333_read_block(struct lm8333 *lm8333, u8 cmd, u8 len, u8 *buf);
-
-#endif /* _LM8333_H */
-- 
2.56.0.506.g506a7eabc5-goog

