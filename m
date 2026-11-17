Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945932;
	b=2LOgTg4/7ZkObx46D5/6o3dWMBdA4B1Xmnd0VVDkZmFsINxITRCsDtVok1Lo+1JmfumK
	 nS54JjuqPkKO7VZ4Lu/D5qfM4FjeH57oJ9C/zHMQ93IqBXHAfNwUujLXAxKfFjHg6IbIf
	 WaFmRUp+W1sYryu2ExRqReUf6+u3lKZx75CcNL4QcYXyC9CLaR5jTu8dnAL2scSg53ZYP
	 UzC5H6KLSmyjEYvFtByK5dL+1ZjP8KaSVqJWYAf/KVUCre3sCsitlW5CI+/SIw9O4BEaN
	 3Q2fBFBXiaC9b1jDEuEkGwGF7DInl09Z5DB4h+Wmn0C/ERMlXCxXh+GyFCF8Uy0582g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Th+rcVsW0xkGEUkonwHob8ff183eupHjg3fCrT4Vn5o=;
	b=A4Nps73STHENZ+QHwqvfbffRfR63T26nxC54Gj9Sr4tjj+srLidVZjJnjinXZv+FVhle
	 2kdQhCEIHft/IW/07veV0OccR2GWno/oGHrmsfifUBZeBwQxRWxRhQ9PBEGqjxMoAPB1+
	 +5oGWH5fyLsG2ZTqGJiRnWlszKOgn3unaURdZDHVvTfw913x0XC0trcbemWU+3exYHwMa
	 EmSUDuqetpw/KtpZUvvwbqnfs6U8ExCaw6U/Q7bwwzuZ4qnOXVcF1snTJCxCswy9A8i0y
	 gTHQbGcpO2RmQuHTP48TI2o/wTTFO+1eBkx4qT9p0SevlQlDNW9/bj03Aowes/Hh2wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=es5pELrA;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45B606A899
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB45B606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=es5pELrA
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so1845645e9.2
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945930; x=1795550730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Th+rcVsW0xkGEUkonwHob8ff183eupHjg3fCrT4Vn5o=;
        b=es5pELrAOUr+g+3D7z8CtlE/OWafjfkfZUkZAhf8vdzOiZjtZ9HujkUjq8DdR3RS6l
         BgDw8xyrpuphSTgXLKoIKc1FV+AJkwk6n6bIxwE25Nt2IdFzhdHqw2Q011TEbOeejYDi
         pG1OWL3T1OPZdxwFTvM1Nx+Vy0BN3vvu34nUkmvPsQ805PLwbHtqYQ7K7nqQNgVT9GLe
         IiteJS3O6c8YTbBGJ1pg57bSsww8GhoCyWAV2dpoLHLDgZf097fAgYKZt9IXpvl2G5NF
         VLabas9KgXieSW44Nlu8MRTnNZcir1ch1dswPBqk0JErOu6zQHBvJqtQo2IkeWswQo6d
         DvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945930; x=1795550730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Th+rcVsW0xkGEUkonwHob8ff183eupHjg3fCrT4Vn5o=;
        b=RVpsSL1dgznxjD1KIo2JGnitu82EcLrW7iGN/DAMDHnGxJVr2Qzg8E1zYQ537gjFak
         VPKHQcMW5zs8hu0Uc82FMaAUML32oHsWbixBuPvCt3HRn+wPbGqbY6zZ66YvBXpRV1xr
         S9zIYU++r7PPEnwkWRJURZY436qTGoAmZgDTbNLXK/MRftdUQLaM444aUkXDnRr1wDJq
         Ev4OzeXfl6ztNvxgm9q6Tr7FZEb8trlsw2d7WMNxm9Vif9Oa3q+NzuNkQ1/9jLu8cWcz
         nqAXhYZtVy6GgHydzPB/fq+H1KUSyWYdrseOhmMaW8FbUUc7dXAcX9Ak28XNuHk94LlK
         Pabw==
X-Forwarded-Encrypted: i=1; AL+hErG/xKMVBoQNhSs65kMDsvW7RQgO6InSXr40kSLqM+ri0sLHOJqzNxpwReKjGu/eoc9/gL++QdyMoWrA7A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zj77m+Pq98WXte4mo7Z7I/KcmVlFZcm35XzS4YKVfrWXKZbXu
	OV6QbVTr+fklCr6nnPnurmUKZA9kQBh2bsouCE6CpB1dbO/CMWTgOc67
X-Gm-Gg: AYBFou0Mo8DqmuRxAJWVg33N44vtZHFTazpVnJZise6Q+PicB66afdOk7QMEfAHOG4A
	XKXseDkWWOCuAVwR/uGbQuXgo2Yg0785CiEEJR1mDJS++iIzL2ninaYcPvS9nGp+UTiTNpyNw0q
	2joRNPaejtJaT+33WqyZM4wY2Uu3e24J6shfkgCeXuizvs3J2Nff8XMcHeCOkhltFMcIhP/GhGT
	TbbTPefaLjwgq7KBfkAba+WGb2069kpxMt7wKtxnAyS0PfvqLwiuMVmLSowjHmeQsL2BbfqPOZh
	n3qulBlq0ezS1jgkggf109wgWhht8gVrFAVuGc9XKuI8LHQfHa6DMvo+immpF6GYwQqQishn3LN
	DoX/TwKgv0Xs5TtxB1OPpIRi8FVoIUc08bIcrOuJ1JI19ohJsas7mfGWKoEKvyLx936VaL4RdGg
	izoKXkkx7Ctvbd+/StGwVS071D6FmbqNkey1s1AYOH/iTaZCvb72vlK9UK6lcM/xHj5v1O8WsUD
	2g1ixKYlqZMyLL1/6QarjKVjCxDwfH3bDYLTJT0gkaBIzS+WqGW53lgEBQazuxXaQ+rcVWrrdWd
	lnN+2MHSs2EvVIVvTIUcaf3gHxKW
X-Received: by 2002:a05:600c:1d05:b0:4bb:73d5:ab33 with SMTP id 5b1f17b1804b1-4bb7da27094mr5436645e9.22.1794945930207;
        Tue, 17 Nov 2026 12:05:30 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:29 -0800 (PST)
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
Subject: [PATCH v4 12/16] HID: ft260: i2c: abort in-flight transfers with STOP before reset
Date: Tue, 17 Nov 2026 22:04:18 +0200
Message-ID: <20261117200423.19561-13-michael.zaidman@gmail.com>
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
index 096e46836d74..cf745db8e3f1 100644
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

