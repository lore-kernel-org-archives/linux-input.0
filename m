Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697740;
	b=3DkRlb5OsAlfEdsHYYKdqgk9CyzUr0nSjRzqrbyOXqDHUIykCSkmSzWZ93Sc1Qh8xhj2
	 4ePix+KFMenN2ulbyp9Nn5CwaWK+SMkUqCdRqZfoQ0IRAwuSJN51jxhi4CbHvjp/HK0yW
	 YXPvjrcvi99zSPbm0pJI7iKJjLTGjt7wCc9PnlpR9ShTVZbchYjCcW/cfOLpclFO6BuMM
	 8J4X0+Sq+CScco1A/cdqR7A67HhmPta8Qin0o/xTcexqEmzbTc3I14x2MZ0xk/Z0LOiRv
	 ULGN8wTAl6kcCeuHPL4GN4Nk3dKYqsEwm6K2KJlkPCnjHU4yoIMvaCudxQrWZD3IxMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SDD6Onks1h/wGvw5iJ2UzUXgiX/fw+nDnVmY3zTL1Mc=;
	b=i7/Y2SC7XtLoU0YDdNA276mmc2hwHEk2dcIHmVS5gs2/OClMOUnsh2kXt0f0/d/i8anc
	 OzUp1pFyfJ9Q7H14On4l4mFvnXYCiFMU5JAMGfdX40+/2dc9pTrqiY90y/exBh+FSOb9d
	 5tl9cWlIG0VZfvbmlq/xgv73Cq3egyfsZcnkUqd9L+xbrk49N4vFvMr/NuET+VB9ORieD
	 nd/6UkMEQEXhWi+Ie0nCJv+bPUH6kyz49jmWMT0XR2jbaOsTbOrp+pOPc3MHi4NW/qbm/
	 THWWeXLkkQLzYe8fMk23mLU8CjJq+HuKsvWQbpHnIY9aLg31yMPbQBQkssovC6B0OXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBQRW8PQ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFE60735D7
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CEFE60735D7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBQRW8PQ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso858048f8f.2
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697737; x=1795302537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDD6Onks1h/wGvw5iJ2UzUXgiX/fw+nDnVmY3zTL1Mc=;
        b=rBQRW8PQNO6EaqDsUc/Pd/W/eOJIpiIMF5kXQ5DogkMPgYB5kekS+Icey3aUBu6ciu
         834WCcQCSE8uS42Qycj/AFe6VyWYMoFBheAx1HT1hHTbUlhfoxKIytdR/S1twxpcRhSE
         q9J2s6qtqdbY1cjvdoMuJmp2ebwHE+RuVgtIh+cLZFwAhnD4SsnZ7NyVbD6DsnfmOUwF
         nxL40b+x3x3SQ/Gu5K6Pw/WGWAZyQGMrLOOOY4+WitMUnKOxExn6E91Yxu7canZNGrrV
         vkFitY/i36O6ilo94Y4aqggXNbi7IUdqAcCnTXIxn+kbhJQs9pyh+Jhod7CmV/MTiCRm
         a1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697737; x=1795302537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDD6Onks1h/wGvw5iJ2UzUXgiX/fw+nDnVmY3zTL1Mc=;
        b=AACCS+12sph9/9ZNLuUSvW+9E70zadnHosI2c7bxSdVcEjYq/IrvLiTGzjzC34Eajt
         0wT7qWFRtiJ+MaHSS3MySU75j6jXoGFZX1BrMgmffkEHp7dZFAXry0ChhUGPhRZa+4C8
         IfiRNqszppVPLaua77JIsZOy/uPuM0px5FL247xBoA3+M45w0MW3aLFpIZSr23IcZQQ5
         qsfRNwMi4oI2LThhUA8jivAAKEHp5Ay+lXVe/Z22SJ9wRGm/uBHAmqrGZPBA2shXVoTw
         IAUKPmlo+lWjcuym6eJzGTBl6XB7pQFinOmucVzqfTOkvmg/y255rih6AL9wdXha6VJY
         W3SA==
X-Forwarded-Encrypted: i=1; AL+hErHVlsv7/sGBSRKj7ew0xMWokFWTwI8zHm5preGgcddnpZrW5MMbcVqdOWGynmoOboyZ3IAlIbU/n/hSrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/X9/f/WNbITi4OviSRR/B7G29O+3HmHdtcGtQl3FM+94HHVi2n
	ZrdJm+AJzkNBHTWLd4jTVWBFp35zIjlqq7sz80SnEfVOLxYhBH2Pd27/
X-Gm-Gg: AYBFou3zMwLEzS4BiGsUpYFVLS/RtdzGzULfmpLND+7wa8xowQhiSVt4LFW2D3/8j0X
	aOgc5Mn4HVm8Tt/lgyYMzrgjsK4wBbTezT+ncVC8KuaqYeUDYvO0ns1nS1BKSEGINIMypvrRlyI
	ouwrEqWojzo7KwfinyL5GxhMpSbIPn2MaUGC0kI7lLaxxKcNdzQd/OQMDVSytjB87oUXXytn4g6
	uToZNQn4joSTNdrD5hS7TBkxWKXey/N85IfSb5QWaPXVe30a4hgJN7jWMDxAeHvHdLh52XlX+7i
	ZAWNyqEcwj1MTNmJHfqCV2AAHQ70FD8HQlqztOZM76qSuGKTsNJsmd2Bkooa8i9cRiFE/kxzT/C
	TLUYy2l9Vx41Jfu5F1khz1FZwp4eS6N7qMB5jQcu6HLGf4qDfpy3dtd+d57m/UQAt+A4dIM6lWD
	JN6FWvx+EUv0ACGC/F1w1atHYLEI3Ahe1E+3gb1HrcFfraEHNCuq7uoeLOrOyRDLdXIWnuNS2lA
	DsfBug43u4DgDkpsyLzbDpN3UjqKQCH4QXI2XeYzt52mspXQc4tY3vutFCKcEVP3V+eUbTiZGJq
	eouUhwocmVg3xAeULY58xwO0BgKVfW396fnhsEZnJxczaHrhMw==
X-Received: by 2002:a05:6000:29c9:b0:493:1004:96f7 with SMTP id ffacd0b85a97d-49c747700f2mr9385007f8f.54.1794697737477;
        Sat, 14 Nov 2026 15:08:57 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:57 -0800 (PST)
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
Subject: [PATCH v3 15/16] HID: ft260: i2c: recover a bus held by a slave
Date: Sun, 15 Nov 2026 01:07:59 +0200
Message-ID: <20261114230800.1344401-16-michael.zaidman@gmail.com>
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

An SMBus block read takes the first byte the slave sends as the block
length. An EEPROM has no length byte, it answers with stored data, and
ft260_smbus_xfer() rejects a value above I2C_SMBUS_BLOCK_MAX. That
count phase carries no STOP, so the slave keeps SDA low while it waits
for the next clock. FT260_SET_I2C_RESET restarts the controller but
does not clock the bus, the chip cannot put a STOP on the line, and
every later START ends in arbitration lost.

A 24c02 holds 0x68 at offset 0x80, so on that bus

  i2cget -y 0 0x50 0x80 s
  ft260 0003:0403:6030.0011: smbus block read: invalid count 104 from slave 0x50

killed the bus: every transfer after it failed with bus_status 0x72
(bus busy, controller idle, arbitration lost, error). The sysfs
i2c_reset, unbind and bind of the HID interface, and rmmod followed by
insmod all left the status at 0x72.

The fix is the I2C bus recovery: nine SCL pulses let the slave clock
out the rest of its byte and release SDA. The I2C controller of the
FT260 cannot send them, but SCL and SDA are GPIO0 and GPIO1 of the
chip. ft260_i2c_prepare_recovery() switches the I2C controller off,
which turns the two pins into GPIOs, and i2c_generic_scl_recovery()
drives them to make the pulses and a STOP.
ft260_i2c_unprepare_recovery() switches the controller on again.

ft260_i2c_abort() starts the recovery after the controller reset if
the bus status still has BUS_BUSY set. It does not test the error bit,
because the reset clears it: right after the reset the chip reports
0x60 (bus busy, controller idle).

Split ft260_gpio_pin_set() out of ft260_gpio_direction_set() and
ft260_gpio_read_all() out of ft260_gpio_get_all(). The recovery needs
them without the gpio_en check and without dev->lock: SCL and SDA are
not GPIOs while I2C runs, and the abort path already holds dev->lock.

In chip modes 0 and 3 the recovery runs on the I2C interface, and the
gpiochip and the modem lines run on the UART interface. Each interface
has its own ft260_device and lock, and both read, change and write the
chip-wide FT260_GPIO report. The two interfaces of one chip already
share an ft260_chip for the TN_189 reset; it now also holds a lock for
that report. The recovery changes the report from the I2C interface, so
tiocmset() reads it under this lock and no longer starts from its
cached copy.

With the patch, the same i2cget still fails with -EPROTO, because the
count is invalid, but the bus is free again: a plain read of the same
EEPROM, i2ctransfer -y 0 w1@0x50 0x00 r4, succeeds. A read from an
address that no slave answers (an address NAK) does not start the
recovery: a full i2cdetect scan of 112 addresses logs no "recovering"
line.

Fixes: 2d68d67151eb ("HID: ft260: fix SMBus block read protocol handling")
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v3:
Recovery info per adapter in struct ft260_device, not one static
copy, because i2c_init_recovery() writes into it for each adapter.

Fix for the issue reported by Sashiko:
- GPIO report lock in the ft260_chip, shared by the I2C and UART
  interfaces of one chip, so a GPIO write from one interface is not
  lost by a write from the other; tiocmset() reads the report.
---
 drivers/hid/hid-ft260.c | 233 +++++++++++++++++++++++++++++++++-------
 1 file changed, 196 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 80b300893658..53321c8d70fd 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -189,6 +189,8 @@ enum {
 	FT260_GPIO_DIRECTION		= 0x01,
 	FT260_GPIO_DIR_INPUT		= 0x00,
 	FT260_GPIO_DIR_OUTPUT		= 0x01,
+	FT260_GPIO_SCL_OFFSET		= 0,	/* GPIO0 */
+	FT260_GPIO_SDA_OFFSET		= 1,	/* GPIO1 */
 };
 
 /* GPIO bit masks */
@@ -467,6 +469,8 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 
 struct ft260_device {
 	struct i2c_adapter adap;
+	/* Per adapter: i2c_init_recovery() writes into it */
+	struct i2c_bus_recovery_info rinfo;
 	struct hid_device *hdev;
 	int chip_mode;
 	int iface_type;
@@ -508,7 +512,8 @@ struct ft260_device {
 /*
  * The I2C and the UART interface of one chip are two HID devices, each
  * with its own ft260_device. They share one ft260_chip, so that only
- * one of them queues the TN_189 reset.
+ * one of them queues the TN_189 reset. Both also read, change and write
+ * the chip-wide FT260_GPIO report.
  */
 struct ft260_chip {
 	struct list_head list;
@@ -516,6 +521,8 @@ struct ft260_chip {
 	struct usb_device *udev;
 	/* A TN_189 reset is queued; protected by ft260_chip_list_lock */
 	bool reset_pending;
+	/* Serializes the read-modify-write of the FT260_GPIO report */
+	struct mutex gpio_lock;
 };
 
 static LIST_HEAD(ft260_chip_list);
@@ -537,6 +544,7 @@ static struct ft260_chip *ft260_chip_get(struct usb_device *udev)
 	if (chip) {
 		kref_init(&chip->kref);
 		chip->udev = usb_get_dev(udev);
+		mutex_init(&chip->gpio_lock);
 		list_add_tail(&chip->list, &ft260_chip_list);
 	}
 out:
@@ -550,6 +558,7 @@ static void ft260_chip_release(struct kref *kref)
 
 	list_del(&chip->list);
 	usb_put_dev(chip->udev);
+	mutex_destroy(&chip->gpio_lock);
 	kfree(chip);
 }
 
@@ -618,6 +627,22 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	return 0;
 }
 
+/*
+ * Enable or disable the I2C controller. With the controller disabled
+ * GPIO0 and GPIO1 carry their GPIO function instead of SCL and SDA.
+ */
+static int ft260_i2c_set_mode(struct hid_device *hdev, u8 enable)
+{
+	struct ft260_set_i2c_mode_report report;
+
+	report.report = FT260_SYSTEM_SETTINGS;
+	report.request = FT260_SET_I2C_MODE;
+	report.i2c_enable = enable;
+
+	return ft260_hid_feature_report_set(hdev, (u8 *)&report,
+					    sizeof(report));
+}
+
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 				   size_t len);
 
@@ -639,10 +664,46 @@ static int ft260_i2c_stop(struct hid_device *hdev, u8 addr)
 	return ft260_hid_output_report(hdev, buf, sizeof(buf));
 }
 
-static int ft260_i2c_abort(struct hid_device *hdev, u8 addr)
+static int ft260_i2c_bus_status(struct ft260_device *dev)
+{
+	struct ft260_get_i2c_status_report report;
+	int ret;
+
+	ret = ft260_hid_feature_report_get(dev->hdev, FT260_I2C_STATUS,
+					   (u8 *)&report, sizeof(report));
+	if (ret < 0)
+		return ret;
+
+	return report.bus_status;
+}
+
+/*
+ * I2C reset does not clock the bus. A slave left in the middle of a
+ * byte keeps SDA low, the chip cannot put a STOP on the bus, and every
+ * later START fails with arbitration lost. The chip reports this as
+ * BUS_BUSY once the reset is done; only driving SCL as a GPIO frees the
+ * slave, so fall back to bus recovery.
+ */
+static int ft260_i2c_abort(struct ft260_device *dev, u8 addr)
 {
-	ft260_i2c_stop(hdev, addr);
-	return ft260_i2c_reset(hdev);
+	int ret;
+
+	ft260_i2c_stop(dev->hdev, addr);
+
+	ret = ft260_i2c_reset(dev->hdev);
+	if (ret < 0)
+		return ret;
+
+	ret = ft260_i2c_bus_status(dev);
+	if (ret < 0)
+		return ret;
+
+	if (ret & FT260_I2C_STATUS_BUS_BUSY) {
+		ft260_dbg("bus_status %#02x, recovering\n", ret);
+		return i2c_recover_bus(&dev->adap);
+	}
+
+	return 0;
 }
 
 static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
@@ -744,7 +805,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 	if (ret == 0)
 		return 0;
 
-	ft260_i2c_abort(hdev, addr);
+	ft260_i2c_abort(dev, addr);
 	return -EIO;
 }
 
@@ -893,7 +954,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		timeout_jiffies = msecs_to_jiffies(timeout);
 		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
-			ft260_i2c_abort(hdev, addr);
+			ft260_i2c_abort(dev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -907,7 +968,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret < 0) {
 			ret = -EIO;
-			ft260_i2c_abort(hdev, addr);
+			ft260_i2c_abort(dev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -1091,7 +1152,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 				hid_warn(hdev,
 					 "smbus block read: invalid count %u from slave 0x%02x\n",
 					 count, addr);
-				ft260_i2c_abort(hdev, addr);
+				ft260_i2c_abort(dev, addr);
 				ret = -EPROTO;
 				goto smbus_exit;
 			}
@@ -1264,11 +1325,13 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 		goto exit;
 	}
 
+	mutex_lock(&dev->chip->gpio_lock);
+
 	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf,
 					   sizeof(buf));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
-		goto exit;
+		goto unlock;
 	}
 
 	rep.report = FT260_GPIO;
@@ -1294,44 +1357,38 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
-		goto exit;
+		goto unlock;
 	}
 
 	dev->gpio = rep.gpio;
 	ret = 0;
+unlock:
+	mutex_unlock(&dev->chip->gpio_lock);
 exit:
 	mutex_unlock(&dev->lock);
 	return ret;
 }
 
-static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
-				    int value, int direction)
+/*
+ * Set the direction and the value of one pin. Takes only
+ * chip->gpio_lock and does not look at gpio_en, so the I2C bus recovery
+ * can drive SCL and SDA while it holds dev->lock and while the pins are
+ * not GPIOs.
+ */
+static int ft260_gpio_pin_set(struct ft260_device *dev, u32 offset,
+			      int value, int direction)
 {
 	int ret;
 	struct ft260_gpio_read_request_report buf;
 	struct ft260_gpio_write_request_report *rep;
-	struct ft260_device *dev = gpiochip_get_data(gc);
 	struct hid_device *hdev = dev->hdev;
 
-	if (offset >= FT260_GPIO_TOTAL) {
-		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
-		return -EINVAL;
-	}
-
-	ft260_dbg("offset %d val %d direction %d\n", offset, value, direction);
-
-	mutex_lock(&dev->lock);
-
-	if (!(dev->gpio_en & BIT(offset))) {
-		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
-		ret = -EIO;
-		goto exit;
-	}
+	mutex_lock(&dev->chip->gpio_lock);
 
 	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf, sizeof(buf));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
-		goto exit;
+		goto unlock;
 	}
 
 	rep = (struct ft260_gpio_write_request_report *)&buf;
@@ -1365,12 +1422,39 @@ static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)rep, sizeof(*rep));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
-		goto exit;
+		goto unlock;
 	}
 
 	dev->gpio = rep->gpio;
 	ret = 0;
-exit:
+unlock:
+	mutex_unlock(&dev->chip->gpio_lock);
+	return ret;
+}
+
+static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
+				    int value, int direction)
+{
+	int ret;
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
+	} else {
+		ret = ft260_gpio_pin_set(dev, offset, value, direction);
+	}
+
 	mutex_unlock(&dev->lock);
 	return ret;
 }
@@ -1388,11 +1472,10 @@ static int ft260_gpio_direction_input(struct gpio_chip *gc, u32 offset)
 					FT260_GPIO_DIR_INPUT);
 }
 
-static int ft260_gpio_get_all(struct gpio_chip *gc, int item)
+static int ft260_gpio_read_all(struct ft260_device *dev, int item)
 {
 	int ret;
 	struct ft260_gpio_read_request_report rep;
-	struct ft260_device *dev = gpiochip_get_data(gc);
 	struct hid_device *hdev = dev->hdev;
 
 	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&rep, sizeof(rep));
@@ -1409,6 +1492,11 @@ static int ft260_gpio_get_all(struct gpio_chip *gc, int item)
 	return ret;
 }
 
+static int ft260_gpio_get_all(struct gpio_chip *gc, int item)
+{
+	return ft260_gpio_read_all(gpiochip_get_data(gc), item);
+}
+
 static int ft260_gpio_get_direction(struct gpio_chip *gc, u32 offset)
 {
 	int ret = ft260_gpio_get_all(gc, FT260_GPIO_DIRECTION);
@@ -1427,6 +1515,56 @@ static int ft260_gpio_get(struct gpio_chip *gc, u32 offset)
 	return (ret >> offset) & 1;
 }
 
+/*
+ * I2C bus recovery. Turning the I2C controller off gives GPIO0 and
+ * GPIO1 back their GPIO function, so i2c_generic_scl_recovery() can
+ * clock the slave out of the byte it holds and put a STOP on the bus.
+ * A pin is released by making it an input, the bus pull-ups then drive
+ * it high.
+ */
+static void ft260_i2c_set_pin(struct i2c_adapter *adap, u32 offset, int val)
+{
+	struct ft260_device *dev = i2c_get_adapdata(adap);
+
+	ft260_gpio_pin_set(dev, offset, 0,
+			   val ? FT260_GPIO_DIR_INPUT : FT260_GPIO_DIR_OUTPUT);
+}
+
+static void ft260_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+	ft260_i2c_set_pin(adap, FT260_GPIO_SCL_OFFSET, val);
+}
+
+static void ft260_i2c_set_sda(struct i2c_adapter *adap, int val)
+{
+	ft260_i2c_set_pin(adap, FT260_GPIO_SDA_OFFSET, val);
+}
+
+static int ft260_i2c_get_scl(struct i2c_adapter *adap)
+{
+	struct ft260_device *dev = i2c_get_adapdata(adap);
+	int ret = ft260_gpio_read_all(dev, FT260_GPIO_VALUE);
+
+	if (ret < 0)
+		return ret;
+
+	return (ret >> FT260_GPIO_SCL_OFFSET) & 1;
+}
+
+static void ft260_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct ft260_device *dev = i2c_get_adapdata(adap);
+
+	ft260_i2c_set_mode(dev->hdev, 0);
+}
+
+static void ft260_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct ft260_device *dev = i2c_get_adapdata(adap);
+
+	ft260_i2c_set_mode(dev->hdev, 1);
+}
+
 static int ft260_gpio_init(struct ft260_device *dev,
 			   struct ft260_get_system_status_report *cfg)
 {
@@ -2158,6 +2296,7 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 {
 	int ret;
 	struct ft260_device *port = tty->driver_data;
+	struct ft260_gpio_read_request_report buf;
 	struct ft260_gpio_write_request_report rep;
 	struct hid_device *hdev = port->hdev;
 	int mask = FT260_GPIO_UART_MODE_4_SET;
@@ -2173,8 +2312,19 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 		mutex_unlock(&port->lock);
 		return -EINVAL;
 	}
+
+	mutex_lock(&port->chip->gpio_lock);
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf,
+					   sizeof(buf));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
+		ret = -EIO;
+		goto unlock;
+	}
+
 	rep.report = FT260_GPIO;
-	rep.gpio = port->gpio;
+	rep.gpio = buf.gpio;
 
 	if (set & TIOCM_RTS)
 		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
@@ -2192,14 +2342,16 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
-		mutex_unlock(&port->lock);
-		return -EIO;
+		ret = -EIO;
+		goto unlock;
 	}
 
 	port->gpio = rep.gpio;
+	ret = 0;
+unlock:
+	mutex_unlock(&port->chip->gpio_lock);
 	mutex_unlock(&port->lock);
-
-	return 0;
+	return ret;
 }
 
 static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
@@ -2414,6 +2566,13 @@ static int ft260_i2c_probe(struct ft260_device *dev,
 	dev->adap.class = I2C_CLASS_HWMON;
 	dev->adap.algo = &ft260_i2c_algo;
 	dev->adap.quirks = &ft260_i2c_quirks;
+	dev->rinfo.recover_bus = i2c_generic_scl_recovery;
+	dev->rinfo.set_scl = ft260_i2c_set_scl;
+	dev->rinfo.get_scl = ft260_i2c_get_scl;
+	dev->rinfo.set_sda = ft260_i2c_set_sda;
+	dev->rinfo.prepare_recovery = ft260_i2c_prepare_recovery;
+	dev->rinfo.unprepare_recovery = ft260_i2c_unprepare_recovery;
+	dev->adap.bus_recovery_info = &dev->rinfo;
 	dev->adap.dev.parent = &hdev->dev;
 	snprintf(dev->adap.name, sizeof(dev->adap.name),
 		 "FT260 usb-i2c bridge");
-- 
2.43.0

