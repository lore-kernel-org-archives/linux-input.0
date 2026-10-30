Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399836;
	b=YHR05OrGGV5DpkAiUGVOMZ9Hcw7DyNOGuK1HkQ6XbPOZgxC7H3Z1LzSzsclLtGQsx1R8
	 rgdwMeQKrfJG+qjaED1FZ3j9zIhkoY+lm9q4r1OfyH4O16kdbZCJFcXsh3Xnn7kHCHZP2
	 tEIRz37wDEjNKDwd17mH+wEr+nuFfZ9UFanef0sEWiBiVNTF7g3AJKhRTlLbqhU7aJVyE
	 NiwlwcZeAnB4H7a0ouaNlve+MOJGU/ojObHx2XwlAQRLN7zQpRC3J7p3YwNfT9zLyDgzA
	 yHVs9ygATOOb9tXWFghJMxJkMrbIB//6W3ldHkTM28rbqKf4gmYy6mPmYgK7q0nOdJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tZyvsNnXMh56pai5U5Ss1kd8tGraHDrvslv6z3x9w14=;
	b=Qf9ZoJ84f6pdyd83NQ/gYNprZydPgk+lybtpMwolzjx946l4rF5skJ9laLADAUON9u1m
	 ZL9c9sPgLtyRpWY2wcgQEmnfKrlBRURpP02NV1+F68B+fNbbi6TrJosVBM4yS3wNbLkIC
	 A8/ZQlU7NKIPGJ0guwFdJyq81UuqPNzp5I7QJbym+SuURHuggJh6SZojOPqL96DzRFNiX
	 F3PIMgqwgTlhHuknGJxBYW5i9lHFNrCyatKbcM9pGcxzbrKWnm/7R7A0RJ6DL3PaoTVyq
	 10xFKt/zBCUudwTPOleXPLP+xpZItpowaQjv/Wi2nK+jrU8VOnd2o9FRND0iGqfghSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXsEmerP;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43860A262A
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B43860A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXsEmerP
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a208d93758so12993315e9.3
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399835; x=1794004635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZyvsNnXMh56pai5U5Ss1kd8tGraHDrvslv6z3x9w14=;
        b=lXsEmerPy41FiZUadHpGhU9/RRwjtTquaIaHnhtDYeUcOZvVZWKp/jBfv1dkqYKa4G
         W6DB2wLtmrbrxq0ocPiK9ZdVMNdgQcxNSH9xjXG5vkgP2Hr7XGCSMO/Rs45yyfvr+OJM
         G6N8WxO8cVxARay1xNjZbMXcnoBeicgNvfMpozJJdRP6ab9AaSDngIy/h6bpW0LM/JqN
         FyqmRiR8m96n8b+ukhxa4hDp2cW81X7TAchROnadfKxNc8U1e5i/X1C7TLwi9zs5msgr
         c8mWwuqXKMKeBFMu+7hjNd4iQYEqmcbfT8MZu51UlMbbadeXoWVG+KQdfV0frKVH8bqh
         hWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399835; x=1794004635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tZyvsNnXMh56pai5U5Ss1kd8tGraHDrvslv6z3x9w14=;
        b=tpWvBtG7s2PsNb8fBeVghgNWDwqYBD7MkrOu/hcOIHkfAQKn7LPQh+tHuqn1UHksqF
         Phej5k0qSMy2CzX8hHTh5Nkr8TNk5F7qgTO1VIfQ7sMVp/Ba0z/cOlAFz5xBh3s129A2
         rffsrQB63bEiX7vbhIhorBdzoxNPsQLv7NvE6Z3aiXDDShysbm5jvogrcNOznaTQY56y
         b0ou79rXjXtS4bt1PE5n4Vf4W1dbXaxW95arrKQhp8W8j76ddLzOAkhExRmUcq7wqotx
         Mzq29TlCPEx5sTQKEhm5ZuBYfAkdpATY//nQiK1Ae5uYjFUATClfcPFXRnS7vwnPbkS5
         Ge9g==
X-Forwarded-Encrypted: i=1; AKwUvBw8x9jR0VafNagelT0EB1o1sLQXSD1WRxdPmydO4/p673j79XpsqlfL0wROt9AULJlN4YBVho/1HidYGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK45rIVdHkTIWjDBa9g8a8xJAnvzb5q1eqxw75tJpa3JhhVavTl
	5+WAyluC9dwfPQcaWaJdjZZm4cW+iXXWHGUviQEx8Rsy1u8AI8oELhzl
X-Gm-Gg: AYBFou0R/EReSG1mWP0EjHv/mwYnadfV2r086lrBkjgsVgK2+yvbtHerUMZLyS7+EbJ
	iu1mOkT/MvKAfb2J9dixH4Xmswq8io7r10/4hhH2As0DkEbvHdYSXNUEnX5f1ZJ7U92Dx7SnkCg
	2F/efxIZR9FFrjXqg3Qi1B/+yNu/tR2yDO+zFHTaSMx9KmmCoZHQx87uSbQRSZeUo42F92Cxt+M
	jLSH+EJKrCYS5dtQ1o2uxEOXEiCjD1Me9tt8uhMzHHWgj/1OSQv1BIU4NI1z00iwtZu1NkXVHiO
	gfThgX+9+g/tmp+1Cps7khpMA+G7B7gddSgIQE+qvRqcMBHksCZXv8MMQQrycnQH3ZRAKXXNg5r
	ZUsumYCaR3X8ntfbp3yPISYFJKqXAqUOObiLR4JkOF//DHnnk4hSAA2192aE62YYuvZEDTcaDLm
	y/sD3qGvHcaiM7Jo4HEqJEYkHpvqJLORQVlzpvu/RnyrS6c+sJ4gK2joeGWwlyix4M/i5Zj7jNd
	ChCrgovh0d4JRIVJRFX597gcoGR/+PESBznZiPvrVY90lPWXs5wzKZ73BowB/d//VXWFUvz0r8E
	31EmTZ/dnl6l8tt8ZotkbySYvPtF0n2y+bcsA8HB1xRk/gW2RQ==
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4ac17d168b1mr89453445e9.11.1793399834458;
        Fri, 30 Oct 2026 15:37:14 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:14 -0700 (PDT)
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
Subject: [PATCH v2 08/15] HID: ft260: uart: add modem pins control via ioctl
Date: Sat, 31 Oct 2026 00:36:30 +0200
Message-ID: <20261030223637.86907-9-michael.zaidman@gmail.com>
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

Add TIOCMGET/TIOCMSET (and thus TIOCMBIS/TIOCMBIC) support so userspace
can drive DTR/RTS when the modem pins are in GPIO mode. This enables
programming an ESP32 over the FT260 with esptool, which resets the chip
via those lines.

Also key GPIO sysfs registration off chip_mode rather than USB interface
number 0, and include DCD/RI in UART mode 3/4 GPIO sets so the modem
mask matches the pins esptool needs.

The RTS, CTS, DTR and DSR pins are active-low, so TIOCMGET inverts the
sense of those four lines and TIOCMSET drives 0 to assert them. DCD and
RI are not inverted. Rio Liu found and fixed the polarity.

Keep the errno from ft260_get_interface_type() so a failed status read
does not probe-succeed after teardown. Return -EINVAL when the modem
pins are not in GPIO mode, propagate gpio_get_all() errors from
TIOCMGET, and copy the GPIO shadow under the port lock for TIOCMSET
(reported by Sashiko).

Co-developed-by: Rio Liu <rio@r26.me>
Signed-off-by: Rio Liu <rio@r26.me>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: polarity fix folded in (Rio Liu); preserve get_interface_type
errno; tiocmget/tiocmset error paths and locked shadow copy (reported
by Sashiko).
---
 drivers/hid/hid-ft260.c | 150 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 131 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 4b0b55c98f90..4106066b6a89 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -16,6 +16,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/kfifo.h>
+#include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
@@ -183,7 +184,7 @@ enum {
 	FT260_GPIO_DIR_OUTPUT		= 0x01,
 };
 
-/* GPIO offsets */
+/* GPIO bit masks */
 #define FT260_GPIO_0		BIT(0)
 #define FT260_GPIO_1		BIT(1)
 #define FT260_GPIO_2		BIT(2)
@@ -213,7 +214,8 @@ enum {
 #define FT260_GPIO_UART_MODE_1_SET	FT260_GPIO_UART_DTR_DSR
 #define FT260_GPIO_UART_MODE_2_SET	FT260_GPIO_UART_RTS_CTS
 #define FT260_GPIO_UART_MODE_3_SET	(FT260_GPIO_UART_RTS_CTS | \
-					 FT260_GPIO_UART_DTR_DSR)
+					 FT260_GPIO_UART_DTR_DSR | \
+					 FT260_GPIO_UART_DCD_RI)
 #define FT260_GPIO_UART_MODE_4_SET	FT260_GPIO_UART_MODE_3_SET
 #define FT260_GPIO_UART_DEFAULT		FT260_GPIO_UART_MODE_0_SET
 #define FT260_GPIO_UART_MODE_1_CLR	(FT260_GPIO_UART_RX_TX | \
@@ -223,6 +225,16 @@ enum {
 #define FT260_GPIO_UART_MODE_3_CLR	FT260_GPIO_UART_RX_TX
 #define FT260_GPIO_UART_MODES		5
 
+/* UART modem control GPIO offsets */
+enum {
+	FT260_GPIO_UART_DCD		= (4),
+	FT260_GPIO_UART_RI		= (5),
+	FT260_GPIO_UART_RTS		= (7),
+	FT260_GPIO_UART_CTS		= (10),
+	FT260_GPIO_UART_DTR		= (11),
+	FT260_GPIO_UART_DSR		= (13),
+};
+
 #define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
@@ -449,6 +461,7 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
+	int chip_mode;
 	int iface_type;
 	int iface_id;
 	struct list_head device_list;
@@ -1106,7 +1119,27 @@ static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 value)
 	else
 		ft260_gpio_en_clr(dev, bitmap);
 exit:
-	hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
+	hid_info(hdev, "enabled GPIOs: %04x, bitmap %04x\n",
+		 dev->gpio_en, bitmap);
+}
+
+static void ft260_gpio_output_cfg(struct ft260_gpio_state *gpio,
+				  u32 offset, int value)
+{
+	if (offset < FT260_GPIO_0_5_COUNT) {
+		gpio->dirs |= BIT(offset);
+		if (value)
+			gpio->vals |= !!value << offset;
+		else
+			gpio->vals &= ~BIT(offset);
+	} else {
+		offset = offset - FT260_GPIO_0_5_COUNT;
+		gpio->ex_dirs |= BIT(offset);
+		if (value)
+			gpio->ex_vals |= !!value << offset;
+		else
+			gpio->ex_vals &= ~BIT(offset);
+	}
 }
 
 static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
@@ -1155,7 +1188,7 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 			rep.gpio.ex_vals &= ~BIT(offset);
 	}
 
-	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
 		  rep.gpio.dirs, rep.gpio.vals,
 		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
 
@@ -1307,8 +1340,6 @@ static int ft260_gpio_init(struct ft260_device *dev,
 	char prefix[] = "ft260_";
 	u8 mode = cfg->chip_mode;
 
-	hid_info(hdev, "initialize gpio chip\n");
-
 	dev->gpio_uart_mode[0] = (u16)FT260_GPIO_UART_MODE_0_SET;
 	dev->gpio_uart_mode[1] = (u16)FT260_GPIO_UART_MODE_1_SET;
 	dev->gpio_uart_mode[2] = (u16)FT260_GPIO_UART_MODE_2_SET;
@@ -1352,7 +1383,6 @@ static int ft260_gpio_init(struct ft260_device *dev,
 		goto exit;
 	}
 	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));
-	hid_info(hdev, "initialize gpio chip on %s\n", label);
 
 	dev->gc->label			= label;
 	dev->gc->direction_input	= ft260_gpio_direction_input;
@@ -1423,6 +1453,7 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 	ft260_dbg("wakeup_int: 0x%02x\n", cfg->enable_wakeup_int);
 
 	dev->power_saving_en = cfg->power_saving_en;
+	dev->chip_mode = cfg->chip_mode;
 
 	switch (cfg->chip_mode) {
 	case FT260_MODE_ALL:
@@ -1440,7 +1471,6 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 		break;
 	}
 
-	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1941,6 +1971,80 @@ static void ft260_uart_set_termios(struct tty_struct *tty,
 	ft260_uart_change_speed(port, &tty->termios, NULL);
 }
 
+static int ft260_uart_tiocmget(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+	int gpios;
+
+	/*
+	 * The modem lines control via ioctl is allowed only
+	 * when the related pins are in the gpio mode.
+	 */
+	int mask = FT260_GPIO_UART_MODE_4_SET;
+
+	if ((port->gpio_en & mask) != mask) {
+		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
+			  port->gpio_en, mask);
+		return -EINVAL;
+	}
+
+	gpios = ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);
+	if (gpios < 0)
+		return gpios;
+
+	return ((!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
+		(!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
+		(!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
+		(!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
+		((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
+		((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0));
+}
+
+static int ft260_uart_tiocmset(struct tty_struct *tty,
+			       unsigned int set, unsigned int clear)
+{
+	int ret;
+	struct ft260_device *port = tty->driver_data;
+	struct ft260_gpio_write_request_report rep;
+	struct hid_device *hdev = port->hdev;
+	int mask = FT260_GPIO_UART_MODE_4_SET;
+
+	if ((port->gpio_en & mask) != mask) {
+		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
+			  port->gpio_en, mask);
+		return -EINVAL;
+	}
+	rep.report = FT260_GPIO;
+
+	mutex_lock(&port->lock);
+	rep.gpio = port->gpio;
+
+	if (set & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
+	if (set & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
+	if (clear & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
+	if (clear & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
+
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
+		  rep.gpio.dirs, rep.gpio.vals,
+		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
+		mutex_unlock(&port->lock);
+		return -EIO;
+	}
+
+	port->gpio = rep.gpio;
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
 static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
@@ -2021,6 +2125,8 @@ static const struct tty_operations ft260_uart_ops = {
 	.write_room		= ft260_uart_write_room,
 	.chars_in_buffer	= ft260_uart_chars_in_buffer,
 	.set_termios		= ft260_uart_set_termios,
+	.tiocmget		= ft260_uart_tiocmget,
+	.tiocmset		= ft260_uart_tiocmset,
 	.hangup			= ft260_uart_hangup,
 	.install		= ft260_uart_install,
 	.cleanup		= ft260_uart_cleanup,
@@ -2164,14 +2270,16 @@ static int ft260_i2c_probe(struct ft260_device *dev,
 		return ret;
 	}
 
-	ret = ft260_gpio_init(dev, cfg);
-	if (ret)
-		goto err_i2c_free;
+	if (cfg->chip_mode == FT260_MODE_I2C) {
+		ret = ft260_gpio_init(dev, cfg);
+		if (ret)
+			goto err_i2c_free;
 
-	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
-	if (ret < 0) {
-		hid_err(hdev, "failed to create sysfs attrs\n");
-		goto err_i2c_free;
+		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (ret < 0) {
+			hid_err(hdev, "failed to create sysfs attrs\n");
+			goto err_i2c_free;
+		}
 	}
 
 	return 0;
@@ -2232,7 +2340,8 @@ static int ft260_uart_probe(struct ft260_device *dev,
 
 	cfg->uart_mode = FT260_UART_CFG_FLOW_CTRL_NONE;
 
-	if (dev->iface_id == 0) {
+	if (dev->chip_mode & FT260_MODE_UART ||
+	    dev->chip_mode == FT260_MODE_ALL) {
 		ret = ft260_gpio_init(dev, cfg);
 		if (ret)
 			goto err_hid_report;
@@ -2311,8 +2420,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = ft260_get_interface_type(dev, &cfg);
 	if (ret <= FT260_IFACE_NONE)
 		goto err_hid_close;
+	dev->iface_type = ret;
 
-	if (ret == FT260_IFACE_I2C) {
+	if (dev->iface_type == FT260_IFACE_I2C) {
 		ret = ft260_i2c_probe(dev, &cfg);
 		if (ret)
 			goto err_hid_close;
@@ -2353,10 +2463,12 @@ static void ft260_remove(struct hid_device *hdev)
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
 		ft260_uart_port_remove(dev);
-		if (dev->iface_id == 0)
+		if (dev->chip_mode & FT260_MODE_UART ||
+		    dev->chip_mode == FT260_MODE_ALL)
 			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 	} else {
-		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (dev->chip_mode == FT260_MODE_I2C)
+			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
 	}
 
-- 
2.43.0

