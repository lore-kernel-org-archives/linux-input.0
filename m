Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697733;
	b=ylsyymSyW5yb+sGKwfXc5yLB5qIPOGtpc/28QFpZN8NiD7scIHACkWeA4Ziy7DZqsQ2N
	 RudumvdbAMEMsVTf3CLW648Sq4/fabPwFwvByJpaAoX2seHDXP5SXWYsj4vBZ6vpeejNV
	 FMFxkfedgHwfjjePedJgCSXOZErUkSnOJcfVSNglyuNV5NNz4zsflN/dIXMh1isPTQPhu
	 wcyIHPNrSSVK3fV5rH5xqule4H5Me8FsQiw5T//FUSuf5O2pk3awQlWdHumCDsFv/EFRK
	 x73YrzPdWx8bra28k5qv+iVkHCMfJR+qqpH+0zNL5nnePSEy3Wp/6JB6eTo+rgBYH7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0crtjAMKzzw1W0f3Ujf9h2uT0/bT08baQoD9Um1fE1E=;
	b=Hap2ioIXWJtcrvppQBbhe6GWe7XbtpqQx9htsArms/Xuiwx5f+tHe54cwcMzqud0ugQk
	 a6fQgmMu8t9zCqBkZRqtohi2E1jgs3DUQSob0vT2AZRsapvYiMS1Je2jPRrY9U5WS0JGB
	 2Tae1BPVbEUf1IOOm0hjNKuVGflBHWW3vfHl3+mmLDq7fhZgkP6flElCDfDlAidaf0lGN
	 xILshOdxvWlkN9GzWpdE89egrAXtMIyfTR7W5jp5zBKzkNWqw2DV4J4gSYSvMf+zeBJI7
	 IcGAzwSjjCuweoCTF1cZQjie1sw4cZCZ83MzsqYGKqe5HjCnyL3Cj2tmzSzFFSi+aCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=msfs8jkt;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5460A6F45
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B5460A6F45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=msfs8jkt
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490f38e9688so1471930f8f.0
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697731; x=1795302531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0crtjAMKzzw1W0f3Ujf9h2uT0/bT08baQoD9Um1fE1E=;
        b=msfs8jktw4EmuGCDbantx6NNqUh5AxG07lSq/ymkAp8NIWvmydvMcHlHi+5yRiP0HH
         12aunYx5OSNv5AMhydz3aIzeJuPYtvFXeHdjge752G9m1oywQRd/3LoDNJNM4vjk+hMK
         4DyW7j+vpI0xNNjlpkp1HlHYoLBFwp5cXZURDRfX4MF//GltKtWXws7iPrOY+xFX97N5
         Qc25Qcn0RJIGTjVJa1Ajao5/opbygAjxa4G8lCVd+bJqucJuKrtjl5H/Lqr8+52hgVlD
         ZM1lxUE6tdf9vjGv22+cqx8ZMV1iZ0J2ZqaYUXgE4xd0M1mDq2yetVxuDgG8a7Rva0N0
         YC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697731; x=1795302531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0crtjAMKzzw1W0f3Ujf9h2uT0/bT08baQoD9Um1fE1E=;
        b=hjA6gp8zrxvJIYOLcjEDxpbpoBaIoMHK4GhYd4Ymw5vCU1bnHpaeDh6C0HTs2Z1Ds/
         GT3tNWERMcQEp/P64rSnihBkrwoEoPTtzwwgHiTWPYWd+uwGhgbMHAylRzz2IVqcla5X
         xXxEVAYuJiIghLiK+6g0QWhssj9olHarSaaUuu9mEPbHeJ7D3w3v3esIn7j+0QVRZyjL
         eGqyml4Vlj9jXJh6swAadJdvrf3lbcDHr1fqPJ2osl5dIpxR2OEiHfrKgGfhjHBHpPR+
         djD5yFqPXV4O4zEnkBcgxzhbArjYxmkE785mheI/tvM/+lhVe1qxt5YlKauO3FXreGJm
         4p+Q==
X-Forwarded-Encrypted: i=1; AL+hErE63qdSoN2DNkk7Ryi8FjZxnmbjz0wGIduv2ckF02UcNdnHp7sgun4PW+6bRc612OlZb+sjv6fal7uIVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ejoeFoTVyxp6WNh79SLwbFoMGrp4ngcSSSBsljY2shKhGBsD6
	M9hizOFwieBlzx4MAlAjcyTxALe5RaqQMrcetkEerb/Nx5vaYOyJ1Onu
X-Gm-Gg: AYBFou1XJvRn4vRdH/lUOPx4hsBZB4jD9N5TV+66Ku1Npia5vwVa27WgfR+IdPTBfKX
	Q87bAiFtXeobMKLyXloz5e39db9OBReopGaBgQjQrayAVZa/iJJikfGKWllZAQld4g4yCP3AGhB
	kKawqb5t7tLW9rmLam7J0z5seSP+gtXZVuDqPmZZEFGQ8C1klXVlTzt8UGuHK2ryaI14HqyXyvE
	XH8R4iQGpr3z/xfUgS4VXKTnfHw7rne/62t4O0//wvs2hHj56YoWTSSkMgbSxG4PfBduGMI9LeB
	GhuRLEZwLW67mhdGjFFztlgfc1eUJJc1GNO4fQv8FYYrk8YG6gfpbyPyY+RQU+fT2izR0pnKwgk
	SaesXYVqzpnY9xjwqdIreR2knAlK3b7D9UwWhhvNObmyAZvS2w1CL6pYLDPj4oekceYipMvisBp
	k0FaHSQyRp+MvJNVK4vqDpCbqV0qP5CwNPnwdv9HrBOy85gHwsxOeiCcOqd9xJdioPg2c4beksk
	Buqd98wk4qlHHx/7Derumea6YmEOKoe2qRoEV7NWC/q/2RIsomrQfFvqlluBIn21N0RWFTZjgv0
	6JtWhd2Y899+VdDj+nPBtu001Ujg
X-Received: by 2002:a05:6000:490e:b0:492:bd2f:bdeb with SMTP id ffacd0b85a97d-49b022b3bb0mr21095488f8f.17.1794697731451;
        Sat, 14 Nov 2026 15:08:51 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:50 -0800 (PST)
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
Subject: [PATCH v3 12/16] HID: ft260: i2c: abort in-flight transfers with STOP before reset
Date: Sun, 15 Nov 2026 01:07:56 +0200
Message-ID: <20261114230800.1344401-13-michael.zaidman@gmail.com>
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

A transfer that ends without STOP leaves the FT260 I2C controller
with BUS_BUSY set. I2C reset (AN_394 section 4.4.15) restarts the
master but, with the driver still bound, status stays 0x60
(CTRL_IDLE | BUS_BUSY) even when SCL and SDA are pulled up. The
next START then fails with 0x72 (arbitration lost + error) and
further resets do not recover; only a USB replug did.

Add ft260_i2c_abort(): a STOP-only write (flag 0x04, zero payload)
then FT260_SET_I2C_RESET. Use it wherever the host tears down an
open transaction:

  - read wait timeout
  - read status check failure after the HID report arrived
  - write status poll failure after the report was sent
  - SMBus block read with an invalid count (count phase has no STOP)

Leave ft260_i2c_reset() alone for HID output failure (the request
may never have reached the controller), sysfs i2c_reset, and probe.

Tested on a UMFT260EV1A with a 24LC512 at 0x51. Five 1 ms read
timeouts each followed by STOP+reset left bus_status 0x20; raising
the timeout to 25 ms on the same loaded module then read 16 bytes
successfully.

This matters more with the 25/75 ms completion timeout from
"HID: ft260: i2c: reduce driver module loading time", which makes
read timeouts more likely than mainline's 5000 ms wait.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 43 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f51ba3df8890..5564ed62cc48 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -613,6 +613,33 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	return ret;
 }
 
+static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
+				   size_t len);
+
+/*
+ * STOP with no START and no payload. Used by ft260_i2c_abort() when
+ * tearing down an in-flight transfer: I2C reset alone can leave
+ * BUS_BUSY set even when SCL/SDA are idle, and the next START then
+ * fails with arbitration lost.
+ */
+static int ft260_i2c_stop(struct hid_device *hdev, u8 addr)
+{
+	u8 buf[4] = {
+		FT260_I2C_REPORT_MIN,
+		addr,
+		FT260_FLAG_STOP,
+		0,
+	};
+
+	return ft260_hid_output_report(hdev, buf, sizeof(buf));
+}
+
+static int ft260_i2c_abort(struct hid_device *hdev, u8 addr)
+{
+	ft260_i2c_stop(hdev, addr);
+	return ft260_i2c_reset(hdev);
+}
+
 static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 {
 	struct hid_device *hdev = dev->hdev;
@@ -682,7 +709,8 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len, u8 bus_busy)
+						u8 *data, int len, u8 addr,
+						u8 bus_busy)
 {
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
@@ -711,7 +739,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 	if (ret == 0)
 		return 0;
 
-	ft260_i2c_reset(hdev);
+	ft260_i2c_abort(hdev, addr);
 	return -EIO;
 }
 
@@ -750,7 +778,8 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4, bus_busy);
+							   wr_len + 4, addr,
+							   bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -791,7 +820,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len, addr,
 						   (flag & FT260_FLAG_STOP) ?
 						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
@@ -859,7 +888,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		timeout_jiffies = msecs_to_jiffies(timeout);
 		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -873,7 +902,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret < 0) {
 			ret = -EIO;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -1057,7 +1086,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 				hid_warn(hdev,
 					 "smbus block read: invalid count %u from slave 0x%02x\n",
 					 count, addr);
-				ft260_i2c_reset(hdev);
+				ft260_i2c_abort(hdev, addr);
 				ret = -EPROTO;
 				goto smbus_exit;
 			}
-- 
2.43.0

