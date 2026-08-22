Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09755391832
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434851; cv=none; b=JKkAHlAhGJhjsD9OaHuQgErKB8jlWbF+VeFZe7AJJNP9qdxRXPTHb/b2QxeK2YXtDlbVhMPKJajTOD/by+Q5nes7fzwggD+YO1MuIBX7sym/kjRRz5F+OQhLsqfUl8U5LtdwImt56mi8iEw3Ycq4qzieReGsA8KplhqRisS6Azk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434851; c=relaxed/simple;
	bh=JemtDxSak9CH8m+QcA9xOVUHH1e+ZtvHVWtttn9IBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+JL6G19h2NAF5D9hqm3d2q1SulLgg2f+o9720cXra3jBL0Re06A29mkab7xwDgBMBypUVAM8hUVPykfq19U0uYD17UrEvVir3E9JfErxTTM3NSTQ0xnSCEAK9Utv2ZJnZuuQ5S0AnxQcPB/35jJTGip/jk5ftLUx5pyM8zhwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sqa1z+qs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqa1z+qs"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1c26d7e951so321238766b.0
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434842; x=1788039642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNdo+XJr21QNjnvuiWuBquyrAWvVkVmt97Y5Z2nWQBg=;
        b=Sqa1z+qsueW/5qmuQCC5EoVmrHwxTAuk3QedJpskUX/molW+AW1P7xNI+JtrXsZU+K
         n7LIQ80mIhsHl4hP5/RNb3eiTe5b5cQmt2NzZoZuPyU1pDeOQv4D8g8BV3JCaolPdgdv
         gknKmHgSfdSDa63VNmEWSaGdQgGidUneOHUUwVJoQHrIrdyDDU17WGf4YM6JwJD9n29v
         xZ+3XSW+pma447kO0tdERtzXgY5EdtVqS3azlj5b5AbxjiPQ2yGy773eGpD13heYbZiI
         TaiFEXaozAqGyXP0ge3SuUUvtZb5yVmv6CaFsa/Vl+KCfcpE2apdeaZLGWheccR6joOx
         IHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434842; x=1788039642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNdo+XJr21QNjnvuiWuBquyrAWvVkVmt97Y5Z2nWQBg=;
        b=pfYUIEY8HERRR0/wNLb+kRb7doq5gXqQVd+PD8g7WBPZcSRmPk3yRMVtSuw3dZfhuO
         N5bMXWpluh6ywQW37HYn/UGgXZYj0+kpDEE9HlHqiDqRNlV2rSyVtig8iqGxkmJLS20m
         /ZPJpS8uDhYQeHZZ1XSn3p6I9vaPvE82V93Bd2Rbw7U1jczBoC44Jliudxyt/c3Nv7O3
         esmFV11mPF0kzb789x55wvYJlJwsltlDBimQmPniyENnjg8o8yhqP0O+UOgUvK/7llqt
         bzi0njWfiCDicfPtvYUJ2knldyOsfUYH/wFmSNT54kDD8RfTD3yJmCQv7sffKKz8/Sd8
         MA7w==
X-Forwarded-Encrypted: i=1; AHgh+Rol/AkCgk2PaRoLwEeMLaX09eiQ1Ugs9O2YUDuwwnGSVnzR/DN9X6XUCFPjFv8eUQ4yj456++KCxm2V1w==@vger.kernel.org
X-Gm-Message-State: AFuF++lGc06jgGXsPxl9vNKPTKd/O8YUHR0QLxE44wuhaGq5RzZXBlrH
	MW0i3cv2g7TAiR1lBaCzOs7symKqbdh+2vUE6bzVdxGEvMUMj8FdGHpM
X-Gm-Gg: AR+sD12+bbHiHIJpcdsHmlT/mj2QtXKDxolTo61dprxzyjbBbOYui1UPSMA6bb03ecs
	3UnpmtjyQwdgT+cZH9o3CZxMKii4fhy5w743KWQEmF/1RgBIRnWIJGKbnQ2ikCYb9H3pDBuDExO
	xliLfu307MIS6amLVvFZTxxq1E8e2IuL6C863GEUbjJaBaVnYhaJdlshbnCSMI3Ex51/R3h6sHg
	L86CLaVix+v70hRT4djDPww0BexDGkoWjkQVKXLSmS1m7vuNN1MFa7yNi9JjFv2mTKfviKrOI2q
	YuWStVKHbZ0UN99zm3rXXPrrIei5/NchKpLZSOa7CINM0BJnN4oSbew7kAgILr5uvoqtw8PWED4
	GgbvA6zxS5dVydvr/Cow+x4Ks6nly0VSOh7dSd6Dd/WCIiMUfoZDH3j0q/Z2ooWK+te8TPRPbp8
	cAneUEpAs+6CuWU1u8jv0Li9ii3lx8JSogh1x4wt2m6m7K9qDhGTKU1vHyJAM=
X-Received: by 2002:a17:907:a892:b0:c16:5cf0:3aff with SMTP id a640c23a62f3a-c246a62afb5mr1592238866b.18.1787434842064;
        Sat, 22 Aug 2026 14:40:42 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:41 -0700 (PDT)
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
Subject: [PATCH 08/13] HID: ft260: uart: add modem pins control via ioctl
Date: Sun, 23 Aug 2026 00:39:36 +0300
Message-ID: <20260822213941.98882-9-michael.zaidman@gmail.com>
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

Add TIOCMGET/TIOCMSET (and thus TIOCMBIS/TIOCMBIC) support so userspace
can drive DTR/RTS when the modem pins are in GPIO mode. This enables
programming an ESP32 over the FT260 with esptool, which resets the chip
via those lines.

Also key GPIO sysfs registration off chip_mode rather than USB interface
number 0, and include DCD/RI in UART mode 3/4 GPIO sets so the modem
mask matches the pins esptool needs.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 151 ++++++++++++++++++++++++++++++++++------
 1 file changed, 130 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 1da42b8756d8..554d8e3ddb6d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -16,6 +16,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/kfifo.h>
+#include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/minmax.h>
 #include <linux/unaligned.h>
@@ -182,7 +183,7 @@ enum {
 	FT260_GPIO_DIR_OUTPUT		= 0x01,
 };
 
-/* GPIO offsets */
+/* GPIO bit masks */
 enum {
 	FT260_GPIO_0			= (1 << 0),
 	FT260_GPIO_1			= (1 << 1),
@@ -215,7 +216,8 @@ enum {
 	FT260_GPIO_UART_MODE_1_SET	= (FT260_GPIO_UART_DTR_DSR),
 	FT260_GPIO_UART_MODE_2_SET	= (FT260_GPIO_UART_RTS_CTS),
 	FT260_GPIO_UART_MODE_3_SET	= (FT260_GPIO_UART_RTS_CTS |
-					   FT260_GPIO_UART_DTR_DSR),
+					   FT260_GPIO_UART_DTR_DSR |
+					   FT260_GPIO_UART_DCD_RI),
 	FT260_GPIO_UART_MODE_4_SET	= (FT260_GPIO_UART_MODE_3_SET),
 	FT260_GPIO_UART_DEFAULT		= (FT260_GPIO_UART_MODE_0_SET),
 	FT260_GPIO_UART_MODE_1_CLR	= (FT260_GPIO_UART_RX_TX |
@@ -226,6 +228,16 @@ enum {
 	FT260_GPIO_UART_MODES		= (5),
 };
 
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
@@ -440,6 +452,7 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
+	int chip_mode;
 	int iface_type;
 	int iface_id;
 	struct list_head device_list;
@@ -1097,7 +1110,27 @@ static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 value)
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
+	if (offset < FT260_GPIO_MAX) {
+		gpio->dirs |= 1 << offset;
+		if (value)
+			gpio->vals |= !!value << offset;
+		else
+			gpio->vals &= ~(1 << offset);
+	} else {
+		offset = offset - FT260_GPIO_MAX;
+		gpio->ex_dirs |= 1 << offset;
+		if (value)
+			gpio->ex_vals |= !!value << offset;
+		else
+			gpio->ex_vals &= ~(1 << offset);
+	}
 }
 
 static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
@@ -1138,7 +1171,7 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 			rep.gpio.ex_vals &= ~(1 << offset);
 	}
 
-	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
 		  rep.gpio.dirs, rep.gpio.vals,
 		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
 
@@ -1283,8 +1316,6 @@ static int ft260_gpio_init(struct ft260_device *dev,
 	char prefix[] = "ft260_";
 	u8 mode = cfg->chip_mode;
 
-	hid_info(hdev, "initialize gpio chip\n");
-
 	dev->gpio_uart_mode[0] = (u16)FT260_GPIO_UART_MODE_0_SET;
 	dev->gpio_uart_mode[1] = (u16)FT260_GPIO_UART_MODE_1_SET;
 	dev->gpio_uart_mode[2] = (u16)FT260_GPIO_UART_MODE_2_SET;
@@ -1324,7 +1355,6 @@ static int ft260_gpio_init(struct ft260_device *dev,
 		goto exit;
 	}
 	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));
-	hid_info(hdev, "initialize gpio chip on %s\n", label);
 
 	dev->gc->label			= label;
 	dev->gc->direction_input	= ft260_gpio_direction_input;
@@ -1388,6 +1418,7 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 	ft260_dbg("wakeup_int: 0x%02x\n", cfg->enable_wakeup_int);
 
 	dev->power_saving_en = cfg->power_saving_en;
+	dev->chip_mode = cfg->chip_mode;
 
 	switch (cfg->chip_mode) {
 	case FT260_MODE_ALL:
@@ -1405,7 +1436,6 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 		break;
 	}
 
-	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1912,6 +1942,78 @@ static void ft260_uart_set_termios(struct tty_struct *tty,
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
+		return 0;
+	}
+
+	gpios = ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);
+
+	return (((gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
+		((gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
+		((gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
+		((gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
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
+		return 0;
+	}
+	rep.report = FT260_GPIO;
+	rep.gpio = port->gpio;
+
+	mutex_lock(&port->lock);
+
+	if (set & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
+	if (set & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
+	if (clear & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
+	if (clear & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
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
@@ -1988,6 +2090,8 @@ static const struct tty_operations ft260_uart_ops = {
 	.write_room		= ft260_uart_write_room,
 	.chars_in_buffer	= ft260_uart_chars_in_buffer,
 	.set_termios		= ft260_uart_set_termios,
+	.tiocmget		= ft260_uart_tiocmget,
+	.tiocmset		= ft260_uart_tiocmset,
 	.hangup			= ft260_uart_hangup,
 	.install		= ft260_uart_install,
 	.cleanup		= ft260_uart_cleanup,
@@ -2131,14 +2235,16 @@ static int ft260_i2c_probe(struct ft260_device *dev,
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
@@ -2199,7 +2305,8 @@ static int ft260_uart_probe(struct ft260_device *dev,
 
 	cfg->uart_mode = FT260_UART_CFG_FLOW_CTRL_NONE;
 
-	if (dev->iface_id == 0) {
+	if (dev->chip_mode & FT260_MODE_UART ||
+	    dev->chip_mode == FT260_MODE_ALL) {
 		ret = ft260_gpio_init(dev, cfg);
 		if (ret)
 			goto err_hid_report;
@@ -2274,11 +2381,11 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
-	ret = ft260_get_interface_type(dev, &cfg);
-	if (ret <= FT260_IFACE_NONE)
+	dev->iface_type = ft260_get_interface_type(dev, &cfg);
+	if (dev->iface_type <= FT260_IFACE_NONE)
 		goto err_hid_close;
 
-	if (ret == FT260_IFACE_I2C)
+	if (dev->iface_type == FT260_IFACE_I2C)
 		ret = ft260_i2c_probe(dev, &cfg);
 	else
 		ret = ft260_uart_probe(dev, &cfg);
@@ -2310,11 +2417,13 @@ static void ft260_remove(struct hid_device *hdev)
 					   dev->index);
 		ft260_uart_port_remove(dev);
 		/* dev is still needed, so we will free it in _destroy func */
-		if (dev->iface_id == 0)
+		if (dev->chip_mode & FT260_MODE_UART ||
+		    dev->chip_mode == FT260_MODE_ALL)
 			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 
 	} else {
-		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (dev->chip_mode == FT260_MODE_I2C)
+			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
 		kfree(dev);
 	}
-- 
2.43.0

