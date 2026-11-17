Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945941;
	b=A/If5WXgYv9Yk68+QEIKsqefioaHobU8xMeDc66yc4dPPdq4rDy7X+GOAuSRzVoDOdHC
	 M7+UR+jgvmGB7YuCzKcoJf1AnwHj30rWPijJ5iI99klM7UsUvIr+OYHz+eY2a/2+lqybK
	 QUzwTD/7LVTkHrBBhdR0sS59+G6NnEQ7tDXjIYioS5YJmjAo6W7YzXIO/0zkJtRFOEz/B
	 dJGdJ3EjGqqWmOHblQ8y+ZZ46TnKC2E0pA8ov5T210RbGwmw2n0whHnNjbzCdzLXOH3EZ
	 m4NklqW7RPO/IbiFrQxrH2RD42UfBdLT/NwowWFFmJMxTojmi+iB7zT0F3Ot4OFalvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z8AJQjCEcez6u6jc5ADyLEfjjVox8a4LLd4tc28T/G0=;
	b=QxJRFxZ9YGii0sQcVLZootoW+SHdHaBshqUD1GYzkY5rRZTXRMlkhdhfi1X7v98WXthK
	 9dwpRJlgSpn0eKI0v8DJCAifG/3AueEyATRtNpqWFkqBD61KH4y02K8BDTg2cWqXKQNDy
	 nKALV+G0Cct+f5DqPPq7s7Nym9olwaH02mRbNYJgrYZenOU0dHaT8k7lCXPfZftVClDbM
	 6taT4V7cyzTYCMt1QrgKaCPSjoY87b/U7Tvs4id+ckiqXJQMSs+2nLnM/2oJpklnqOiHH
	 VLA6DqW391FWljhBdjkj+3OF4kTxYtG2uxWio7yTWNsp++jIf1vmUhV+wyobkT3IQDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMDofS5d;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E30606B50E
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E30606B50E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMDofS5d
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a357b1c649so71621f8f.3
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945939; x=1795550739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8AJQjCEcez6u6jc5ADyLEfjjVox8a4LLd4tc28T/G0=;
        b=WMDofS5d35zwzGlup/nyFGFFYTAa7lq7V9U2EtVBgLClEFE5Rzqwl6jkmBmaC7LmHz
         jQQxj87Uny9tWeuWBoUP6o3QS6+g70MzttvYEFk2TximAjWzznj3r+CQ2PjA+Uzy3pZB
         xxI1iIiEnpxPMlxISEJ4BosswN0Ws+v8ilengxfXHdrWsdRFAuzkwoeTnNsPeuwrfdLa
         59sfXNJbbjzAJjG6qxFA4nH/vFfLx6TR5UrP1Dkw8KBSNnFoLLxRxqhqLIhjV/9ZAP0j
         9cdlqCT1HCoQc5nRZtXbzJC7QjVBlPXd7gNXxZyiau+aWbmhYhPiRtN+78rg0aWlSa63
         dD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945939; x=1795550739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8AJQjCEcez6u6jc5ADyLEfjjVox8a4LLd4tc28T/G0=;
        b=P95z2GfSArTParIPusNTfFTkCJTwazZmkRfAIvH2LXlHdT0Nf5EJ3j+Pxyw2J3sHC5
         5n4tl/9cIH98qnrcTLf0F2vyXJB1mgZdYwcQiuUUSRe5+RAcMG8d4YcW1Is8inFst1VS
         9C4k/ptL3gtw5c2zJR7MA6B7pvQdNUuIf3sTgSmLgzZYArcTfmXYc4AaqPIDg/7kL5bQ
         Dxta4pIERPGya2jmrNIYThbo4cmrWIkehP8dOpqonqx7zddPHnffzpgce7K1PgcwP5Vb
         3GFBPFEizO1Jj6WTWQJwioxeaPK0O6h6uFvaHHsjnnSs5e3LdCRL/OdgAV3bh89JidG8
         G+1Q==
X-Forwarded-Encrypted: i=1; AL+hErGMlab1vo4Ir/rpmUzQAYkc4HM0ueV157ctkmOF3d0YNR+Y/h43UkbeIxGJutRXLbjCZkGTTgWm5xxxAQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8iEq/MRAkUP6B/N3f8DBdf2n+lxaBcgAa/M4um6RrIzpeYDwvi
	Ch5jYrf6vp1Dqxw1u3DFQ0lVKN1dlrcCOgjmOMlPJuf8wT2SCivKwpFR
X-Gm-Gg: AZFdTZcbi3z76KIPAfsaqeL29XDwjJ0Ozi+TvI88AFhQWYiXlzV1hRdTINcaP9Nbpjy
	5u3+x1PFIebmW8HxY3b133D7DMTNKii/Obr5JbAG8yzu936I0yehPAvi/abytebRLUaLODDQhmZ
	b5ZVdlkSCyBaRHq0QWeBQmVIsS0JvAmuzpABi9+zt43pDJcbWKvVtXyQ3f+XqiHZdmL7fn9qnIM
	yUW8Ho4Y7d26JrNLfJ2JlAFeIKzeU2lanj1V20D5BYbt+5ThkQAMQA6NsMZrikdDBpQ7d0mxzuR
	2s6CvrUSkgxluB6GNdmMp1xaQfX0TapoY6yp2+rVGH5XiC4Tvxdk4a6+mW5II6+q/0nkLWrELEk
	wYWXkSeDGc4jEcxTACtMAHx0KqGlY2EGhgXIdR6SQQVrGY4O+R/q/IfWPp7L85aE9NKE0Vqn+IU
	DHohvVVE9TUF7tbkBuJHpomzL6zOnCBTseQYyxEHxwvkTgY+BUPsD6HTH1WzPNZ2wzwnCP0yTBz
	o64WabT2wm9p7iAe8OsSzsOvSRI9od+GocpXhZPA9xoZsuF0tSGBbxi3abiAmEl/tPmhF7H+ixV
	RipELyVMGMkzWh8RN2BFrdZQQJHzL8KHEHxJNxShp3yPPwSrbA==
X-Received: by 2002:a05:6000:2210:b0:48f:d7cd:a5ac with SMTP id ffacd0b85a97d-4a62d6d4ca5mr1313576f8f.0.1794945938785;
        Tue, 17 Nov 2026 12:05:38 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:38 -0800 (PST)
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
Subject: [PATCH v4 16/16] HID: ft260: use lock guards
Date: Tue, 17 Nov 2026 22:04:22 +0200
Message-ID: <20261117200423.19561-17-michael.zaidman@gmail.com>
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

Convert the mutex_lock() and mutex_unlock() pairs to guard(mutex) from
linux/cleanup.h. The lock is released on each return, so the goto
labels that only unlock a mutex are removed, and the error paths
return directly.

ft260_uart_port_remove(), ft260_uart_port_get(),
ft260_uart_port_destroy() and ft260_schedule_reset() take a lock for
one or two statements. They use scoped_guard(), which releases the
lock at the end of the block. ft260_uart_port_remove() does not hold
port->lock over the tty hangup and the rest of the removal.
ft260_schedule_reset() must not hold ft260_chip_list_lock when it
calls ft260_chip_put(), which takes the same lock.

ft260_i2c_xfer() and ft260_smbus_xfer() set the normal power mode with
hid_hw_power() once, at the end. The i2c_exit and smbus_exit labels are
removed: ft260_i2c_xfer() has one return path after the transfer, and
each error case in the ft260_smbus_xfer() switch ends with break. So no
function mixes goto with a guard, as include/linux/cleanup.h asks.

No functional change.

Suggested-by: Bartosz Golaszewski <brgl@kernel.org>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
v3:
New patch (suggested by Bartosz Golaszewski). It is the last patch,
so the out-of-tree driver for kernels older than 6.5, which do not
have linux/cleanup.h, can leave it out.

v4:
The scoped_guard() list follows the patch 2 changes of v4:
ft260_uart_port_get() and ft260_uart_port_destroy() added,
ft260_remove() removed.

Fix for the issue reported by Sashiko:
- The i2c_exit and smbus_exit labels removed, so goto and guard are
  not mixed in one function.
---
 drivers/hid/hid-ft260.c | 164 +++++++++++++---------------------------
 1 file changed, 54 insertions(+), 110 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index b398a3e84d67..1e4726cc335b 100644
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
 
@@ -1050,21 +1046,13 @@ static int ft260_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 		else
 			ret = ft260_i2c_write(dev, msgs->addr, msgs->buf,
 					      msgs->len, FT260_FLAG_START_STOP);
-		if (ret < 0)
-			goto i2c_exit;
-
 	} else {
 		/* Combined write then read message */
 		ret = ft260_i2c_write_read(dev, msgs);
-		if (ret < 0)
-			goto i2c_exit;
 	}
 
-	ret = num;
-i2c_exit:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
-	mutex_unlock(&dev->lock);
-	return ret;
+	return ret < 0 ? ret : num;
 }
 
 static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
@@ -1077,12 +1065,11 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 
 	ft260_dbg("smbus size %d\n", size);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	ret = hid_hw_power(hdev, PM_HINT_FULLON);
 	if (ret < 0) {
 		hid_err(hdev, "power management error: %d\n", ret);
-		mutex_unlock(&dev->lock);
 		return ret;
 	}
 
@@ -1100,7 +1087,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 			ret = ft260_smbus_write(dev, addr, cmd, NULL, 0,
 						FT260_FLAG_START);
 			if (ret)
-				goto smbus_exit;
+				break;
 
 			ret = ft260_i2c_read(dev, addr, &data->byte, 1,
 					     FT260_FLAG_START_STOP_REPEATED);
@@ -1114,7 +1101,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 			ret = ft260_smbus_write(dev, addr, cmd, NULL, 0,
 						FT260_FLAG_START);
 			if (ret)
-				goto smbus_exit;
+				break;
 
 			ret = ft260_i2c_read(dev, addr, (u8 *)&data->word, 2,
 					     FT260_FLAG_START_STOP_REPEATED);
@@ -1141,12 +1128,12 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 			ret = ft260_smbus_write(dev, addr, cmd, NULL, 0,
 						FT260_FLAG_START);
 			if (ret)
-				goto smbus_exit;
+				break;
 
 			ret = ft260_i2c_read(dev, addr, &count, 1,
 					     FT260_FLAG_START_REPEATED);
 			if (ret)
-				goto smbus_exit;
+				break;
 
 			if (count == 0 || count > I2C_SMBUS_BLOCK_MAX) {
 				hid_warn(hdev,
@@ -1154,7 +1141,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 					 count, addr);
 				ft260_i2c_abort(dev, addr);
 				ret = -EPROTO;
-				goto smbus_exit;
+				break;
 			}
 
 			data->block[0] = count;
@@ -1172,7 +1159,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 			ret = ft260_smbus_write(dev, addr, cmd, NULL, 0,
 						FT260_FLAG_START);
 			if (ret)
-				goto smbus_exit;
+				break;
 
 			ret = ft260_i2c_read(dev, addr, data->block + 1,
 					     data->block[0],
@@ -1188,9 +1175,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 		ret = -EOPNOTSUPP;
 	}
 
-smbus_exit:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
-	mutex_unlock(&dev->lock);
 	return ret;
 }
 
@@ -1317,21 +1302,20 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 
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
@@ -1357,16 +1341,11 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
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
@@ -1383,12 +1362,12 @@ static int ft260_gpio_pin_set(struct ft260_device *dev, u32 offset,
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
@@ -1422,20 +1401,16 @@ static int ft260_gpio_pin_set(struct ft260_device *dev, u32 offset,
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
 
@@ -1446,17 +1421,14 @@ static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
 
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
@@ -1791,7 +1763,7 @@ static int ft260_i2c_clock_parse(const char *buf, unsigned int base, u16 *clock)
 			rep.name = conv(name);				       \
 			rep.report = id;				       \
 			rep.request = req;				       \
-			mutex_lock(&dev->lock);				       \
+			guard(mutex)(&dev->lock);			       \
 			ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep,   \
 							   sizeof(rep));       \
 			if (ret < 0)					       \
@@ -1800,7 +1772,6 @@ static int ft260_i2c_clock_parse(const char *buf, unsigned int base, u16 *clock)
 				func(hdev, req, name);			       \
 				ret = count;				       \
 			}						       \
-			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
 		}							       \
@@ -1975,7 +1946,7 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	if (kfifo_alloc(&port->xmit_fifo, XMIT_FIFO_SIZE, GFP_KERNEL))
 		return -ENOMEM;
 
-	mutex_lock(&ft260_uart_list_lock);
+	guard(mutex)(&ft260_uart_list_lock);
 	list_for_each_entry(dev, &ft260_uart_device_list, device_list) {
 		if (dev->index != index)
 			break;
@@ -1983,7 +1954,6 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	}
 
 	if (index >= UART_COUNT_MAX) {
-		mutex_unlock(&ft260_uart_list_lock);
 		hid_err(port->hdev, "all %d tty indexes are in use\n",
 			UART_COUNT_MAX);
 		kfifo_free(&port->xmit_fifo);
@@ -1993,7 +1963,6 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	port->index = index;
 	/* Before the first gap, or at the end: the list stays sorted */
 	list_add_tail(&port->device_list, &dev->device_list);
-	mutex_unlock(&ft260_uart_list_lock);
 
 	return ret;
 }
@@ -2009,9 +1978,8 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 	 * Before the hangup: an open that has not set port->tty yet
 	 * cannot be hung up, so its activate must see the flag.
 	 */
-	mutex_lock(&port->lock);
-	port->removed = true;
-	mutex_unlock(&port->lock);
+	scoped_guard(mutex, &port->lock)
+		port->removed = true;
 
 	/*
 	 * Shut down, not delete: a tty call before the hangup below
@@ -2038,16 +2006,14 @@ static struct ft260_device *ft260_uart_port_get(int index)
 	if (index >= UART_COUNT_MAX)
 		return NULL;
 
-	mutex_lock(&ft260_uart_list_lock);
+	guard(mutex)(&ft260_uart_list_lock);
 	port = ft260_dev_by_index(index);
 	if (port) {
-		mutex_lock(&port->lock);
-		removed = port->removed;
-		mutex_unlock(&port->lock);
+		scoped_guard(mutex, &port->lock)
+			removed = port->removed;
 		if (removed || !tty_port_get(&port->port))
 			port = NULL;
 	}
-	mutex_unlock(&ft260_uart_list_lock);
 
 	return port;
 }
@@ -2190,11 +2156,9 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	bool wakeup_workaraund = false;
 	int ret;
 
-	mutex_lock(&port->lock);
-	if (port->removed) {
-		mutex_unlock(&port->lock);
+	guard(mutex)(&port->lock);
+	if (port->removed)
 		return -ENODEV;
-	}
 
 	memset(&req, 0, sizeof(req));
 
@@ -2270,7 +2234,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	else
 		ft260_gpio_en_update(hdev, FT260_SET_UART_MODE, req.flow_ctrl);
 
-	mutex_unlock(&port->lock);
 	return ret;
 }
 
@@ -2303,14 +2266,12 @@ static int ft260_uart_tiocmget(struct tty_struct *tty)
 	int gpios, ret = 0;
 	u16 gpio_en;
 
-	mutex_lock(&port->lock);
-	if (port->removed) {
-		mutex_unlock(&port->lock);
+	guard(mutex)(&port->lock);
+	if (port->removed)
 		return -ENODEV;
-	}
+
 	gpio_en = port->gpio_en;
 	gpios = ft260_gpio_get_all(&port->gc, FT260_GPIO_VALUE);
-	mutex_unlock(&port->lock);
 	if (gpios < 0)
 		return gpios;
 
@@ -2351,11 +2312,9 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 	struct hid_device *hdev = port->hdev;
 	unsigned int mask = 0;
 
-	mutex_lock(&port->lock);
-	if (port->removed) {
-		mutex_unlock(&port->lock);
+	guard(mutex)(&port->lock);
+	if (port->removed)
 		return -ENODEV;
-	}
 
 	if (ft260_uart_pins_are_gpio(port->gpio_en, FT260_GPIO_UART_RTS_CTS))
 		mask |= TIOCM_RTS;
@@ -2363,19 +2322,16 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 		mask |= TIOCM_DTR;
 	set &= mask;
 	clear &= mask;
-	if (!(set | clear)) {
-		mutex_unlock(&port->lock);
+	if (!(set | clear))
 		return 0;
-	}
 
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
@@ -2397,16 +2353,11 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
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
@@ -2558,11 +2509,9 @@ static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *t
 	struct ft260_get_uart_settings_report cfg;
 	struct ft260_device *port = container_of(tport, struct ft260_device, port);
 
-	mutex_lock(&port->lock);
-	if (port->removed) {
-		mutex_unlock(&port->lock);
+	guard(mutex)(&port->lock);
+	if (port->removed)
 		return -ENODEV;
-	}
 
 	set_bit(TTY_IO_ERROR, &tty->flags);
 
@@ -2579,10 +2528,8 @@ static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *t
 	 * reactivate the wakeup workaround if needed.
 	 */
 	ret = ft260_get_uart_settings(port->hdev, &cfg);
-	if (ret) {
-		mutex_unlock(&port->lock);
+	if (ret)
 		return ret;
-	}
 
 	baudrate = get_unaligned_le32(&cfg.baudrate);
 	ft260_uart_wakeup_workaraund_enable(port,
@@ -2594,7 +2541,6 @@ static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *t
 		mod_timer(&port->wakeup_timer, jiffies +
 			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
 
-	mutex_unlock(&port->lock);
 	return 0;
 }
 
@@ -2608,9 +2554,8 @@ static void ft260_uart_port_destroy(struct tty_port *tport)
 	 * ttys[] table until its last close, and an open of a new port
 	 * with the same index would find it.
 	 */
-	mutex_lock(&ft260_uart_list_lock);
-	list_del_init(&port->device_list);
-	mutex_unlock(&ft260_uart_list_lock);
+	scoped_guard(mutex, &ft260_uart_list_lock)
+		list_del_init(&port->device_list);
 
 	ft260_chip_put(port->chip);
 	kfree(port);
@@ -2809,9 +2754,8 @@ static struct workqueue_struct *ft260_reset_wq;
 
 static void ft260_chip_reset_done(struct ft260_chip *chip)
 {
-	mutex_lock(&ft260_chip_list_lock);
+	guard(mutex)(&ft260_chip_list_lock);
 	chip->reset_pending = false;
-	mutex_unlock(&ft260_chip_list_lock);
 }
 
 static void ft260_reset_and_rebind(struct work_struct *ws)
@@ -2921,10 +2865,10 @@ static int ft260_schedule_reset(struct usb_interface *usbif)
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
-- 
2.43.0

