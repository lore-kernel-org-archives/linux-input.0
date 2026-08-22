Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742093932D4
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434862; cv=none; b=hN6XDZQzpicQjsrx0e0Drox54xFzm+b62HqbO9e88SNfvMkMuNcz42gQGmLEHdymYXP62a5GR2UPvgExgjp1n2/uXfxAPyCkf6uznqQtZI7ExK7JxLvi3dRXz5tUkQ4nbwmtO6a08ezSnatOtr+BDF/jUmDQ7Rh6qRqXigaL2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434862; c=relaxed/simple;
	bh=IP4K+y+s3kto6i7CgO79hJGPSKvInsmESILBbssd/80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuyO0WuOyVTWkFS/Ox7IK61JEDrMFkZK9xl7xBHs9czTyqR8wEsX/dfkn0KFdn5GLB7DljfkdMin3phO/0PZIlSZcXqGGz7l1AzchSyB2Qrf4jZ5oRrja+NYNJhuzqJ9pOCSvfwNUYPGiUe2IWlce9FhCJXSY5fbGmyFluWYrp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqXClZv/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqXClZv/"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c207cb16cf5so349517566b.1
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434851; x=1788039651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qg1KAy+mSZMSfDHaheDRm1TaMRLDEaVjJ1MAUbT2Qc=;
        b=cqXClZv/ypz/2NVes789SP1HBhY9X2xtbc8gJtx1/loMaYEw0LSp9TPmfxv9M4HpSk
         7qccz38FKSnguvHAK8iYZjfmRNeaFusUkPy+WlwSGnJ9reP5OMB19axjSLTL8NTN8+mx
         6MWYNMN0W6BO8Z076+eey8BtgYOnXaiGXxBJbeZyDzLa/wkEd8seoO7tBcB93L4qP9cU
         96yzQUh4bxxJbXePDizj8duPiNdKTxDGXCjhfP6d8Gh1E5hJ7JBCEQJZ2oo0/Rfcw8AN
         885hs+IaKQZ3vcuRk4fIKQEAQkfGRI69PfWlniLd8XvIOI+SAiCIcrlF14c8ylRwGCAC
         0sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434851; x=1788039651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qg1KAy+mSZMSfDHaheDRm1TaMRLDEaVjJ1MAUbT2Qc=;
        b=legmMSd4pzUKv+gZFCpdtAlvqFml1UpfHEO/RXXdyyKagP7nW/+OzedO3NIj8x6BD7
         7W/VXRMX2XDUDmyhNn0hF6V1fKh8E2+3+ywE2FF1ZJLIXUC9EL0N/r0oPDJDL9Oa+opP
         MHFf82DZP+VCyZ0NfBx1uVis8yXEl6eRd/MFcHCBQddnQki1hEaiw03OJHKBOfS09+nQ
         EcmXd2Ozl44rjyHwdtK7rCG18Sk8NqHXPPIIEmK8IQojwMkOrpbJbwdxoadOveFPauBD
         gg9f5QB4K8XgRUjJjrTIgiQNYmkcmcktECSYz6xybX6DDyQB8N1KaSq11AZV2iux3E/+
         3rDw==
X-Forwarded-Encrypted: i=1; AHgh+RrS9RJIgAsRm7sVDnFoDFqnXBrWAW35fXrqMbLsjuvKusliJPwinJRlf0y8SQMplmzrWpYmPThmnCItnw==@vger.kernel.org
X-Gm-Message-State: AFuF++mkUOpncxZ1/hb8q2E9e5EZNKJFEv9zLwGdtOiuzwCBhBVflo5p
	bBX5hZN94amixU7cqvicgxB6TEOI1BBRzalst9iFGsI+cDGXpfvnVfiB
X-Gm-Gg: AR+sD12PKoB8BTDH86DfhfPOYxhN9lW5U8SeQSo62kTR45v31UNR9N1Uzm9/6hA88MT
	UU0eNRQAX2FYKynckcUOarLhd5n3JQZ1o+AruAF+T9gQYxUb90aZxKD8iaQiK+7PBGKWmc/wXt3
	ADxEk6Uc0ekYdcbGuaZGoECf2sAbaxsGNypjdD2HS/eKZLGG2CfUljxebxbflFQE0F5u15Zp3RG
	AfAUd+4vqIF0N0zv9EZ/MSpyFjbUNqJTle7qOKUN7voysys5Zl2/34Pz9wbrI2gsOhvotPESX+w
	z7pe9+iZmEX6pf9nzzxSDnz3iM/1Y9+T0kRHE1DD1bWxy45lM+xx74IV44Qi9NiC8ehDYvO2e7+
	Jgf7o6DcawCiFa9vzNFaf4/EXI+D2RqAjk1/oUM0O3nbc9Owc0jCwtCviOntKf318rJcJNocn3R
	U+Iwme3FkZBG4fBdGx+KMKzjEkuWbZR68HpTJO/5WddhVpirSFauHespdY6BU=
X-Received: by 2002:a17:907:e1c6:20b0:c20:d90b:2ccf with SMTP id a640c23a62f3a-c246a306b53mr1173876266b.7.1787434851479;
        Sat, 22 Aug 2026 14:40:51 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:51 -0700 (PDT)
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
Subject: [PATCH 13/13] HID: ft260: i2c: abort in-flight transfers with STOP before reset
Date: Sun, 23 Aug 2026 00:39:41 +0300
Message-ID: <20260822213941.98882-14-michael.zaidman@gmail.com>
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
index 9ae688f6208f..a35a1af2d7e5 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -538,6 +538,33 @@ static int ft260_i2c_reset(struct hid_device *hdev)
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
@@ -607,7 +634,8 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len, u8 bus_busy)
+						u8 *data, int len, u8 addr,
+						u8 bus_busy)
 {
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
@@ -636,7 +664,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 	if (ret == 0)
 		return 0;
 
-	ft260_i2c_reset(hdev);
+	ft260_i2c_abort(hdev, addr);
 	return -EIO;
 }
 
@@ -675,7 +703,8 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4, bus_busy);
+							   wr_len + 4, addr,
+							   bus_busy);
 		if (ret < 0) {
 			ft260_dbg("%s: failed with %d\n", __func__, ret);
 			return ret;
@@ -716,7 +745,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len, addr,
 						   (flag & FT260_FLAG_STOP) ?
 						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
@@ -784,7 +813,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		timeout_jiffies = msecs_to_jiffies(timeout);
 		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -798,7 +827,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret < 0) {
 			ret = -EIO;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -982,7 +1011,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
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

