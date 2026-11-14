Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697741;
	b=XCr8/4iwV0LYQOGYkF0TlMXd5yT2xg2Ig33FT1TS/IwXHaWyXsxaiQS3GSR5f55e2dUH
	 RE+1VhigBC4Wqz3GTIcYqlByqIn0A/YJuivl05ur1O0AoTLo2sho5j5pfLmB5vKFLRu6X
	 P7X5d8EEObEWS/LC1ziyDjb/FcorOqmtaiSmoClc/8j2n7wf0E73XAdTK9qfyVDv9onvx
	 rlHA7D+F7j1sspkneEw4gLj8WnSPzKhJjePbHU3S7HQDq0gxHZf+St8UYdLwo9s8tmc46
	 T0WAaEM2BKLDd4V7phNny1EdpnrupoZkJJ0p5AOTTYZQCEdAfjNKisZ+3trRNJNW7+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7KNLoigtoy0jfCladEDEWIuBv0zL9CIOAkihifWiusU=;
	b=BYc1v1jlS7BruErE/MdGA1jwtK1W7iDkwoX4zGadkydYrrQ9/bxgaHzHhIpftqbnK0+5
	 jAmmdCRkecXH8V+m3uwG6foPgp2S5gh2C4OVzoPZTAtIMK0BZU/th/ZE5vfens4rRiVMA
	 FdcTdtkfeuGnXt1qVrh7MUM3VV0Y0P5OikwdW3JdddZXstVocSP9SDrcVoOkOc8Nt2DbS
	 swzCIjUGJVIilXX5dH3UvIVM4Dn5h9IzJhS0luFPOsgzNUAfGQzACTtvOoUw6Y1IM+Xxh
	 4URQMUvgDh50U3IgrG0GwJ4ukieWC1PGTwbWPJ69710/N2XxXFOEO3+wr+g2eufXafw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kyNQ2rF4;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B860735F0
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0B860735F0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kyNQ2rF4
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so3378935e9.1
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697740; x=1795302540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KNLoigtoy0jfCladEDEWIuBv0zL9CIOAkihifWiusU=;
        b=kyNQ2rF4lJx/Ubp5k5Q/wpqc7NV0R5F+OuJaxcTguVFzatNBI0XJKa2ESUv+AmGmIw
         dcz2oJoBgziLIXal2jv3nBj1ntIzXB1Wfqwn4VR+TNyCrUN7EkPbV9EmfTzB+NexJmJ5
         iV/RBlYiuN1MRJ1gN0ig+euLqQSWHCWdKx4J4bIbm1346axGIJGfa+Q3e6zRSUCuRamB
         MmaNicsYr/12Aq0IJovaJKNC34LpPjOwNyBjrakp7OGBaf7RE3FyDstC+Eh0IxZ2ONnr
         tCe0kt/3z5ApAGHKzSstA/sMGK5AYRH2ZXQi/runCek1JR5t+583Sv6S5evujxULtj0Y
         N6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697740; x=1795302540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7KNLoigtoy0jfCladEDEWIuBv0zL9CIOAkihifWiusU=;
        b=V1kRvicwLBBN40wVCEPhabBXdHkwTZdHnpefWG/ucsAJ9eDtUqrP/birXXYQdvH+8H
         EqCQ98J0phE8fRijzQwy8xXUEpJuXMKUlGujZoNdJtM8ijYSMc05cAisw4NCekFboolX
         faHrLwR7c11rQMCYcJbaJ5w7hr225uZ62yQHKwarIJcALAVd6U/02Kl3LiA523YsAE7l
         JhowKiJtnYJFplNYfIDtRsSWq0cD2pMLc2XICBTGkRrgMhUCIixe811jDhCtqGz9t30g
         5fP6SB4lak5iELEZIU9ODpg39CX+NmUNem9Yz9NoYZCzObN/4lhXq+c6fewoN/Q9gCy/
         gg+A==
X-Forwarded-Encrypted: i=1; AL+hErF5KFiCPIMbxLYEHfpKB1IB3WqLPjabZC9cSwDlCdf6ZwgeQ9V360FrWAHLXioCG+RP25DHW+uO1Q4vAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gu+NVUtR73x4/C0CsQbVfctS0T/5Iiyhz6ljbZRNb/CvMGFfU
	IV26cDvMQTu1nGIEtqYXyn7St+pYuAAbOFjsKZj89myKG2irv31iqhqI
X-Gm-Gg: AYBFou1Fjszss/qM7mwnI1CrblqHqulVXBkp0jO5L4kuvQ9Iyv6XESfb6XWQnC6UUz1
	T5g3qI2WKaE+a/IRJFP6E+2iUq5rhmHWhYHdYdQWxCVoDf6DVdiGm89MlNLLhO2SAONqkiyq+qc
	Ox7zusbHQRZbKY8x6mg13TfQcqI/XojGXsxxsbMRo+IxzJSZ9I3VqPJT2lkXAlHTw2HIGoQ/XQA
	hhxJUtGJ5kvS9z34Sk/qNWXqdwK1oWX6O16A5BMs3NZcF5rdTBJ4WSfhQzriW7pUe75qzIdc9uN
	oLDkpAW6Xx0ZWjGVVRmKcq2fIirIF+CfeH5MyzcPvH5vE+l45TZki8cQwIj6i51nPxrD6lf/FTm
	PirOb0uZK5fH8uQmECKZUsq843JMgQwUrIVCJ/2bM8FVaxamwknfemZPMKjIZB3eZi7CI8NPUio
	sqye1H433t90ArbFMK/8k00bHmn2mngMj8zYvmcjo8+5UWzauUeo3q/LM+/qGWyc0HlO6manP4r
	jDzKjB7Ib5fjS5g99X+pZ5lDzog10zL+s1wVdgbfEpZGKBnVekNPpaEf7i80azloZT/M5vli7Gc
	Qm548pBke0EPgmYyxbein1WxTPMaA7ugcvI2/EEiOXiIpfYeDg==
X-Received: by 2002:a05:6000:1841:b0:48e:2108:4d28 with SMTP id ffacd0b85a97d-49c70de3881mr15657253f8f.13.1794697739565;
        Sat, 14 Nov 2026 15:08:59 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:59 -0800 (PST)
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
Subject: [PATCH v3 16/16] HID: ft260: use lock guards
Date: Sun, 15 Nov 2026 01:08:00 +0200
Message-ID: <20261114230800.1344401-17-michael.zaidman@gmail.com>
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

Convert the mutex_lock() and mutex_unlock() pairs to guard(mutex) from
linux/cleanup.h. The lock is released on each return, so the goto
labels that only unlock a mutex are removed, and the error paths
return directly.

ft260_uart_port_remove(), ft260_remove() and ft260_schedule_reset()
take a lock for one or two statements in the middle of the function.
They use scoped_guard(), which releases the lock at the end of the
block. The two remove functions do not hold the lock over the tty
hangup and the rest of the removal. ft260_schedule_reset() must not
hold it when it calls ft260_chip_put(), which takes the same lock.

The i2c_exit and smbus_exit labels stay, because they also set the
normal power mode with hid_hw_power().

No functional change.

Suggested-by: Bartosz Golaszewski <brgl@kernel.org>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
v3:
New patch (suggested by Bartosz Golaszewski). It is the last patch,
so the out-of-tree driver for kernels older than 6.5, which do not
have linux/cleanup.h, can leave it out.
---
 drivers/hid/hid-ft260.c | 119 +++++++++++++---------------------------
 1 file changed, 39 insertions(+), 80 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 53321c8d70fd..716b37cead7d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -532,11 +532,11 @@ static struct ft260_chip *ft260_chip_get(struct usb_device *udev)
 {
 	struct ft260_chip *chip;
 
-	mutex_lock(&ft260_chip_list_lock);
+	guard(mutex)(&ft260_chip_list_lock);
 	list_for_each_entry(chip, &ft260_chip_list, list) {
 		if (chip->udev == udev) {
 			kref_get(&chip->kref);
-			goto out;
+			return chip;
 		}
 	}
 
@@ -547,8 +547,6 @@ static struct ft260_chip *ft260_chip_get(struct usb_device *udev)
 		mutex_init(&chip->gpio_lock);
 		list_add_tail(&chip->list, &ft260_chip_list);
 	}
-out:
-	mutex_unlock(&ft260_chip_list_lock);
 	return chip;
 }
 
@@ -567,9 +565,8 @@ static void ft260_chip_put(struct ft260_chip *chip)
 	if (!chip)
 		return;
 
-	mutex_lock(&ft260_chip_list_lock);
+	guard(mutex)(&ft260_chip_list_lock);
 	kref_put(&chip->kref, ft260_chip_release);
-	mutex_unlock(&ft260_chip_list_lock);
 }
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
@@ -1034,12 +1031,11 @@ static int ft260_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	struct ft260_device *dev = i2c_get_adapdata(adapter);
 	struct hid_device *hdev = dev->hdev;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	ret = hid_hw_power(hdev, PM_HINT_FULLON);
 	if (ret < 0) {
 		hid_err(hdev, "failed to enter FULLON power mode: %d\n", ret);
-		mutex_unlock(&dev->lock);
 		return ret;
 	}
 
@@ -1063,7 +1059,6 @@ static int ft260_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	ret = num;
 i2c_exit:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
-	mutex_unlock(&dev->lock);
 	return ret;
 }
 
@@ -1077,12 +1072,11 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 
 	ft260_dbg("smbus size %d\n", size);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	ret = hid_hw_power(hdev, PM_HINT_FULLON);
 	if (ret < 0) {
 		hid_err(hdev, "power management error: %d\n", ret);
-		mutex_unlock(&dev->lock);
 		return ret;
 	}
 
@@ -1190,7 +1184,6 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 
 smbus_exit:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
-	mutex_unlock(&dev->lock);
 	return ret;
 }
 
@@ -1317,21 +1310,20 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 
 	ft260_dbg("offset %d val %d\n", offset, value);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	if (!(dev->gpio_en & BIT(offset))) {
 		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
-		ret = -EINVAL;
-		goto exit;
+		return -EINVAL;
 	}
 
-	mutex_lock(&dev->chip->gpio_lock);
+	guard(mutex)(&dev->chip->gpio_lock);
 
 	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf,
 					   sizeof(buf));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
-		goto unlock;
+		return ret;
 	}
 
 	rep.report = FT260_GPIO;
@@ -1357,16 +1349,11 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
-		goto unlock;
+		return ret;
 	}
 
 	dev->gpio = rep.gpio;
-	ret = 0;
-unlock:
-	mutex_unlock(&dev->chip->gpio_lock);
-exit:
-	mutex_unlock(&dev->lock);
-	return ret;
+	return 0;
 }
 
 /*
@@ -1383,12 +1370,12 @@ static int ft260_gpio_pin_set(struct ft260_device *dev, u32 offset,
 	struct ft260_gpio_write_request_report *rep;
 	struct hid_device *hdev = dev->hdev;
 
-	mutex_lock(&dev->chip->gpio_lock);
+	guard(mutex)(&dev->chip->gpio_lock);
 
 	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf, sizeof(buf));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
-		goto unlock;
+		return ret;
 	}
 
 	rep = (struct ft260_gpio_write_request_report *)&buf;
@@ -1422,20 +1409,16 @@ static int ft260_gpio_pin_set(struct ft260_device *dev, u32 offset,
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)rep, sizeof(*rep));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
-		goto unlock;
+		return ret;
 	}
 
 	dev->gpio = rep->gpio;
-	ret = 0;
-unlock:
-	mutex_unlock(&dev->chip->gpio_lock);
-	return ret;
+	return 0;
 }
 
 static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
 				    int value, int direction)
 {
-	int ret;
 	struct ft260_device *dev = gpiochip_get_data(gc);
 	struct hid_device *hdev = dev->hdev;
 
@@ -1446,17 +1429,14 @@ static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
 
 	ft260_dbg("offset %d val %d direction %d\n", offset, value, direction);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	if (!(dev->gpio_en & BIT(offset))) {
 		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
-		ret = -EIO;
-	} else {
-		ret = ft260_gpio_pin_set(dev, offset, value, direction);
+		return -EIO;
 	}
 
-	mutex_unlock(&dev->lock);
-	return ret;
+	return ft260_gpio_pin_set(dev, offset, value, direction);
 }
 
 static int ft260_gpio_direction_output(struct gpio_chip *gc,
@@ -1791,7 +1771,7 @@ static int ft260_i2c_clock_parse(const char *buf, unsigned int base, u16 *clock)
 			rep.name = conv(name);				       \
 			rep.report = id;				       \
 			rep.request = req;				       \
-			mutex_lock(&dev->lock);				       \
+			guard(mutex)(&dev->lock);			       \
 			ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep,   \
 							   sizeof(rep));       \
 			if (ret < 0)					       \
@@ -1800,7 +1780,6 @@ static int ft260_i2c_clock_parse(const char *buf, unsigned int base, u16 *clock)
 				func(hdev, req, name);			       \
 				ret = count;				       \
 			}						       \
-			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
 		}							       \
@@ -1975,7 +1954,7 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	if (kfifo_alloc(&port->xmit_fifo, XMIT_FIFO_SIZE, GFP_KERNEL))
 		return -ENOMEM;
 
-	mutex_lock(&ft260_uart_list_lock);
+	guard(mutex)(&ft260_uart_list_lock);
 	list_for_each_entry(dev, &ft260_uart_device_list, device_list) {
 		if (dev->index != index)
 			break;
@@ -1985,7 +1964,6 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	port->index = index;
 	/* Before the first gap, or at the end: the list stays sorted */
 	list_add_tail(&port->device_list, &dev->device_list);
-	mutex_unlock(&ft260_uart_list_lock);
 
 	return ret;
 }
@@ -2004,9 +1982,8 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 	timer_shutdown_sync(&port->wakeup_timer);
 	cancel_work_sync(&port->wakeup_work);
 
-	mutex_lock(&ft260_uart_list_lock);
-	list_del(&port->device_list);
-	mutex_unlock(&ft260_uart_list_lock);
+	scoped_guard(mutex, &ft260_uart_list_lock)
+		list_del(&port->device_list);
 
 	tty_port_tty_vhangup(&port->port);
 
@@ -2025,11 +2002,10 @@ static struct ft260_device *ft260_uart_port_get(int index)
 	if (index >= UART_COUNT_MAX)
 		return NULL;
 
-	mutex_lock(&ft260_uart_list_lock);
+	guard(mutex)(&ft260_uart_list_lock);
 	port = ft260_dev_by_index(index);
 	if (port)
 		tty_port_get(&port->port);
-	mutex_unlock(&ft260_uart_list_lock);
 
 	return port;
 }
@@ -2224,7 +2200,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	mutex_lock(&port->lock);
+	guard(mutex)(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
@@ -2232,8 +2208,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	else
 		ft260_gpio_en_update(hdev, FT260_SET_UART_MODE, req.flow_ctrl);
 
-	mutex_unlock(&port->lock);
-
 	return ret;
 }
 
@@ -2266,20 +2240,16 @@ static int ft260_uart_tiocmget(struct tty_struct *tty)
 	 */
 	int mask = FT260_GPIO_UART_MODE_4_SET;
 
-	mutex_lock(&port->lock);
-	if (port->removed) {
-		mutex_unlock(&port->lock);
+	guard(mutex)(&port->lock);
+	if (port->removed)
 		return -ENODEV;
-	}
 	if ((port->gpio_en & mask) != mask) {
 		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
 			  port->gpio_en, mask);
-		mutex_unlock(&port->lock);
 		return -EINVAL;
 	}
 
 	gpios = ft260_gpio_get_all(&port->gc, FT260_GPIO_VALUE);
-	mutex_unlock(&port->lock);
 	if (gpios < 0)
 		return gpios;
 
@@ -2301,26 +2271,22 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 	struct hid_device *hdev = port->hdev;
 	int mask = FT260_GPIO_UART_MODE_4_SET;
 
-	mutex_lock(&port->lock);
-	if (port->removed) {
-		mutex_unlock(&port->lock);
+	guard(mutex)(&port->lock);
+	if (port->removed)
 		return -ENODEV;
-	}
 	if ((port->gpio_en & mask) != mask) {
 		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
 			  port->gpio_en, mask);
-		mutex_unlock(&port->lock);
 		return -EINVAL;
 	}
 
-	mutex_lock(&port->chip->gpio_lock);
+	guard(mutex)(&port->chip->gpio_lock);
 
 	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf,
 					   sizeof(buf));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
-		ret = -EIO;
-		goto unlock;
+		return -EIO;
 	}
 
 	rep.report = FT260_GPIO;
@@ -2342,16 +2308,11 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
-		ret = -EIO;
-		goto unlock;
+		return -EIO;
 	}
 
 	port->gpio = rep.gpio;
-	ret = 0;
-unlock:
-	mutex_unlock(&port->chip->gpio_lock);
-	mutex_unlock(&port->lock);
-	return ret;
+	return 0;
 }
 
 static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
@@ -2733,9 +2694,8 @@ static struct workqueue_struct *ft260_reset_wq;
 
 static void ft260_chip_reset_done(struct ft260_chip *chip)
 {
-	mutex_lock(&ft260_chip_list_lock);
+	guard(mutex)(&ft260_chip_list_lock);
 	chip->reset_pending = false;
-	mutex_unlock(&ft260_chip_list_lock);
 }
 
 static void ft260_reset_and_rebind(struct work_struct *ws)
@@ -2845,10 +2805,10 @@ static int ft260_schedule_reset(struct usb_interface *usbif)
 		return -ENOMEM;
 	}
 
-	mutex_lock(&ft260_chip_list_lock);
-	pending = chip->reset_pending;
-	chip->reset_pending = true;
-	mutex_unlock(&ft260_chip_list_lock);
+	scoped_guard(mutex, &ft260_chip_list_lock) {
+		pending = chip->reset_pending;
+		chip->reset_pending = true;
+	}
 	if (pending) {
 		ft260_chip_put(chip);
 		kfree(rw);
@@ -3092,9 +3052,8 @@ static void ft260_remove(struct hid_device *hdev)
 		 * The hangup does not wait for a TIOCMGET or TIOCMSET
 		 * that is running; they hold the lock while they use hdev.
 		 */
-		mutex_lock(&dev->lock);
-		dev->removed = true;
-		mutex_unlock(&dev->lock);
+		scoped_guard(mutex, &dev->lock)
+			dev->removed = true;
 		if (dev->chip_mode & FT260_MODE_UART ||
 		    dev->chip_mode == FT260_MODE_ALL ||
 		    dev->chip_mode == FT260_MODE_BOTH)
-- 
2.43.0

