Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399851;
	b=p7HRibvAmQOZdEROa5q8QUvkOxedt07BdPHKX1zI2ggRS2QIbVDgaTnAhm98XbBjPsGi
	 5BaLHtsU3eUb6nfOZ+UKpBixU58YN8fsLtdTN+5ln1sm/HS388o6XysjseRrrnpy5lLuQ
	 eBiZvCZhfEMDk0cwXso06Px68vg16Nxt4cqaBqSXB1ZJXv3diDMbbKaiVqqovPqAJwb5Q
	 cYo9Te2e/nUWD/3i5tnHFIbNlyMykvyNz1qyEJOPkLhA/pAUt7U7/qK9d79BhcM3AMV9T
	 W8o+E2oBQfXmo1+LX5fYa4kNsNsBcJJB9EMLnUpJxM4vpZEe/vdcFEeKrbyI+4uZnHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fU5eVFfcbBj5t8UtgLFsfacRqMKeyGT7y6OrNdnpgM0=;
	b=2zu22q2HWk2aeLTYRO6lhJ6YKPTCO2Z/JYrjZom3oYDxDOOPmqKt+UbKi3FZqpieoSXE
	 ir7edxH/G5cw+8/flCxTvmHDgUUt6YPT+U7LdVHnksi6+NszbA915er4lAJH+oIM2ob2t
	 NNvJJbpoyhsxI70t5J6jcEpQyAWR378DkSeKrcWdkNSKQmp1BgBQlqku9tZ9Z0J1jvBmk
	 dfzH++EmKafNwVHjocVCuWgd/ch0cgGjUcz0uGwFLJqv9qZejxSXNjer8e5oegxuU3eQu
	 /yT9TfCx2xSaMtIgw99X9c+JpJoVTihFfmc89MStuOukYmZb3VuFBIg0+KYrFIQCIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OlQQps6H;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F760A5BC1
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1F760A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OlQQps6H
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so6615165e9.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399849; x=1794004649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fU5eVFfcbBj5t8UtgLFsfacRqMKeyGT7y6OrNdnpgM0=;
        b=OlQQps6HfJ5IqFc8Mpj1yKcd1VMIXM7AnBE/wDZykR1J1RQXDuytx4PrSHL+vLxH4U
         fCSNLbo8nGNbx3D2GwQtwZdO14J2sPp+wr744WAnGN3q7GgeECUYdbgByij7xnOetg8q
         ZdIoRYW8fJkBTwfEMyC/NLXZU+SI9V/yxmKtBYkFc4OCg1XhwR5QNwn2SwSimiGPxVFE
         OgVBgMeIT3m0AreQNAxUJAu2cQIlMd8HrCVPH+yGNSCCSMKbzthJ4nIPdttfDAtStVZV
         +QwusS1Z2pEKvmewjaSh6SJpYU+SbqAgInc7XyMQB0kaflpheQVAuObNoMvaM2fYlD0f
         +oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399849; x=1794004649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fU5eVFfcbBj5t8UtgLFsfacRqMKeyGT7y6OrNdnpgM0=;
        b=c7wKuzyHCOxErRXJAr5Ft67Q9Lqk8jwcdzETmOLuvUZWCL2PTkfAulSnsJ6+yheho6
         UAqHvYaPAcQNmRVrrHXn6Gc9Th2Iy3iSQd6WAUJZqgffQANT3Lw16nG0P06EuFiJVFZ1
         28vYkP0wQZ1BuwLknjtNzd75ixV9WZ1gtjTy9eww9FYSJGLohESC4vN5j8cHyl17FUKX
         Za85k4jHKfUE8e3YLsU7CwxzBNYD7wFk0w1C1L5cc0G96UlGI2q13Dc8IkQaWhsL0ZJZ
         ZquCXWkFoURFZAqJlpm7+YhVPAtV3/aC5BxCw1RSuF9IauuFCn/s3vczL6BekP1txL8E
         B+1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwvlesPniNZFedYt+sqka/BRZo6pst7GWo2yoESBCrCN5YV3oq4IYmbYSNMzN7js6SBgRsS2XGHsG54pg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLScpA7Z6EIORBro3x/WGMDOXfU09O5McMjaXsyPFtqWt7ew+v7
	iD1YtQ7RuqVzs4uYPjtSMfRMcryXEV7vU4ZGbBNq18dywHcH1UNYOPS5
X-Gm-Gg: AYBFou0DngF3QUwz8AEar/AykGhjEgG4SCJD2lFtQyZPV+yB/j3RtCc/zaHT4MimFSH
	lkdyzoHCXntILQRty5Sbm4TmGsvRgNqJVhS4UwGsugxttEdFGh5FXvK1Td97MTJgAwx8bHBHXo7
	LIKUMkDq6OVSon8vg2T9zRf50ibt3ZOLRqFogwQB+hVEGiWFpVy+khb3uFSxv2a0sqVS+Oq/hiA
	uiD4Ma4bP/Mi04/R/KNh41zPtADXMOCyxkpMr5t2e2bk16wL9/T19PkuA/JjDO1chDjsbioAg7i
	nMJ2rHFR5BKQzz0pvLzpCWULkGl6ZHyMmCX5lo9ouvl3G/TP0CjWUGH8s45pPspErE/8+ER5eJP
	nIjoqHphP2pzaAE15uwzMLI3Wz8ZzUmxdY8k7ID4gXfv+RRKkpgLlS7iTJQUCDLpAoF1o/48un2
	8oKzUSIQmR/L8lwIX6a9AR5gl0HJ/Dij16l4OPCIFwZ4Hp5E4e2zGRK+qCjtUk8Suc7qq/r/cua
	URK/hSyvG+zTKDIyM7DE7ySSZXt75poQnc261CYMHe607ZOba/nBxcjUZPocRKuC3MJaf1L2u6P
	RKE8kXjAbmXnyVoca5bo/umE45pO
X-Received: by 2002:a05:600c:3b18:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4ac1932b542mr84346665e9.35.1793399848715;
        Fri, 30 Oct 2026 15:37:28 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:28 -0700 (PDT)
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
Subject: [PATCH v2 15/15] HID: ft260: i2c: recover a bus held by a slave
Date: Sat, 31 Oct 2026 00:36:37 +0200
Message-ID: <20261030223637.86907-16-michael.zaidman@gmail.com>
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

killed the bus: every transfer after it failed with bus_status 0x72.
The sysfs i2c_reset, unbind and bind of the HID interface, and rmmod
followed by insmod all left the status at 0x72.

Nine SCL pulses free the slave. Switching the I2C controller off gives
GPIO0 and GPIO1 back their GPIO function, so i2c_generic_scl_recovery()
can clock the line and make a STOP. ft260_i2c_abort() reads the status
after the reset and calls i2c_recover_bus() when BUS_BUSY is still set.
The error bit is no use there: the chip reports 0x60 right after the
reset and only shows 0x72 at the next START.

ft260_gpio_pin_set() and ft260_gpio_read_all() are the bodies of
ft260_gpio_direction_set() and ft260_gpio_get_all(), split out because
the recovery needs them without the gpio_en check, SCL and SDA are no
GPIOs while I2C runs, and without dev->lock, which the abort path
already holds.

With the patch the same i2cget still fails with -EPROTO and the next
i2ctransfer succeeds. A full i2cdetect scan of 112 addresses logs no
recovery, so an address NAK does not take this path.

Fixes: 2d68d67151eb ("HID: ft260: fix SMBus block read protocol handling")
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 193 +++++++++++++++++++++++++++++++++-------
 1 file changed, 162 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index cd1117c170e1..faa1e12cd2d5 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -188,6 +188,8 @@ enum {
 	FT260_GPIO_DIRECTION		= 0x01,
 	FT260_GPIO_DIR_INPUT		= 0x00,
 	FT260_GPIO_DIR_OUTPUT		= 0x01,
+	FT260_GPIO_SCL_OFFSET		= 0,	/* GPIO0 */
+	FT260_GPIO_SDA_OFFSET		= 1,	/* GPIO1 */
 };
 
 /* GPIO bit masks */
@@ -554,6 +556,22 @@ static int ft260_i2c_reset(struct hid_device *hdev)
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
 
@@ -575,10 +593,46 @@ static int ft260_i2c_stop(struct hid_device *hdev, u8 addr)
 	return ft260_hid_output_report(hdev, buf, sizeof(buf));
 }
 
-static int ft260_i2c_abort(struct hid_device *hdev, u8 addr)
+static int ft260_i2c_bus_status(struct ft260_device *dev)
 {
-	ft260_i2c_stop(hdev, addr);
-	return ft260_i2c_reset(hdev);
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
+{
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
@@ -680,7 +734,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 	if (ret == 0)
 		return 0;
 
-	ft260_i2c_abort(hdev, addr);
+	ft260_i2c_abort(dev, addr);
 	return -EIO;
 }
 
@@ -829,7 +883,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		timeout_jiffies = msecs_to_jiffies(timeout);
 		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
-			ft260_i2c_abort(hdev, addr);
+			ft260_i2c_abort(dev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -843,7 +897,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret < 0) {
 			ret = -EIO;
-			ft260_i2c_abort(hdev, addr);
+			ft260_i2c_abort(dev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -1027,7 +1081,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 				hid_warn(hdev,
 					 "smbus block read: invalid count %u from slave 0x%02x\n",
 					 count, addr);
-				ft260_i2c_abort(hdev, addr);
+				ft260_i2c_abort(dev, addr);
 				ret = -EPROTO;
 				goto smbus_exit;
 			}
@@ -1237,34 +1291,23 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 	return ret;
 }
 
-static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
-				    int value, int direction)
+/*
+ * Set the direction and the value of one pin. Takes no lock and does
+ * not look at gpio_en, so the I2C bus recovery can drive SCL and SDA
+ * while it holds dev->lock and while the pins are not GPIOs.
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
-
 	ret = ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf, sizeof(buf));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
-		goto exit;
+		return ret;
 	}
 
 	rep = (struct ft260_gpio_write_request_report *)&buf;
@@ -1298,12 +1341,36 @@ static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)rep, sizeof(*rep));
 	if (unlikely(ret < 0)) {
 		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
-		goto exit;
+		return ret;
 	}
 
 	dev->gpio = rep->gpio;
-	ret = 0;
-exit:
+	return 0;
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
@@ -1321,11 +1388,10 @@ static int ft260_gpio_direction_input(struct gpio_chip *gc, u32 offset)
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
@@ -1342,6 +1408,11 @@ static int ft260_gpio_get_all(struct gpio_chip *gc, int item)
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
@@ -1360,6 +1431,65 @@ static int ft260_gpio_get(struct gpio_chip *gc, u32 offset)
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
+static struct i2c_bus_recovery_info ft260_i2c_recovery = {
+	.recover_bus		= i2c_generic_scl_recovery,
+	.set_scl		= ft260_i2c_set_scl,
+	.get_scl		= ft260_i2c_get_scl,
+	.set_sda		= ft260_i2c_set_sda,
+	.prepare_recovery	= ft260_i2c_prepare_recovery,
+	.unprepare_recovery	= ft260_i2c_unprepare_recovery,
+};
+
 static int ft260_gpio_init(struct ft260_device *dev,
 			   struct ft260_get_system_status_report *cfg)
 {
@@ -2331,6 +2461,7 @@ static int ft260_i2c_probe(struct ft260_device *dev,
 	dev->adap.class = I2C_CLASS_HWMON;
 	dev->adap.algo = &ft260_i2c_algo;
 	dev->adap.quirks = &ft260_i2c_quirks;
+	dev->adap.bus_recovery_info = &ft260_i2c_recovery;
 	dev->adap.dev.parent = &hdev->dev;
 	snprintf(dev->adap.name, sizeof(dev->adap.name),
 		 "FT260 usb-i2c bridge");
-- 
2.43.0

