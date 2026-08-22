Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6F390CBA
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434848; cv=none; b=EPVElTXqF6bedYzX/OpxqWWBWlrKrjO96l4z5aoMPV6kdFooo6hQkE8mLdzBreubYq8IUisBnRdimqH+o7KqA3BrxTcABOIjAcHpU0TX2+bTVkzl+dR9be5sHev7PTo0c3wIiw8ejsi4Qgfn4QzXFtRY7napEvnRrlzGrLEZ5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434848; c=relaxed/simple;
	bh=O1b4qJuU5h0jkjtN1tmFHZg98/5Kor0pOfpmFSJmhKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdZ1vg17JhfswJxf8vF+CHVBMLogWLI3mPwqgf8yQGJ76s7GQBCShaOXXMGeM7LgHHhP5S894p1b2ABT6p8ATSRqgn7Bv1CdE2DcDIyY6jsbj1sVcclJ6tJrg3kkIX6bqDtTkdpwPhaiHJ1VygSmHlS9t9T1bDm8xo0M9tJi9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv/DmAO0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv/DmAO0"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so3926030a12.0
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434839; x=1788039639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7d0fiyXH8Gw0QiNflyUYHvDRi8XIlp2AkUMiyQfpLiI=;
        b=Cv/DmAO0fbr4HMZI6EQTZ1jjqyYgFpkJODZ7fxs+QkhM/iphqwzhNkTIenH0HihBWb
         3AyRVV20O8AYDEsZ+SNdQ7tgUWJV/6g5z+o7+o2SpQdYrLIQMNwAsIns9oFyfMRb+SW/
         9pNZfSFNAPd5waFOWbY4wXqZJ++Cd/C/xMMXCdYOQSCl8U0MzlIzeWQS1M7EiYT1bRJD
         pGzw3Gc3a7y9qHEtk0/6gGTvY3W9jGTi1XmWX14ZFNHPCOm8ZXtQ+8EgmEHRroDVxPWT
         W06y0AkTSkxhS5I2dOhT1ypRjBkuPZPttybBv8WMzLBjo1Hk4OVyhOWsZ0QF2iEKidAe
         osZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434839; x=1788039639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7d0fiyXH8Gw0QiNflyUYHvDRi8XIlp2AkUMiyQfpLiI=;
        b=sh9uHpCleeB2a6RZAbch/QXByyGVtriwfDD9yi04V/T8BhcAXaRRO8C+5/8vsnuEU6
         /imTep6I2wIAm5eZZ3daM1GTBDO0Z+eQmdwMvmQBVFWIcjlN4TV/CTj6j28QZzkUOvz4
         ZdasrZVx17SigXTjcMPMN9QTHq94QX85IgMHbK+ytFF9/ZvbxcxY2x+4/K01/VoE03CC
         M06n6+DSY+Fk0nRcUJN1hCx9GoL7j+bpz2noURvMbQ4lyodIFyilDdiabDMiPkjaTqrr
         x13HnvCjXALqXVQeq+lmu0tQSS3pccGDxMyLpEqP5SOiaSLhZyxCJEgrW3wy+Cwg8kNs
         me9g==
X-Forwarded-Encrypted: i=1; AHgh+RqCu2b9CtrERz9uLxszY8eaDy0ghWxRxyOAZMdt4MMeJ+TQ+SKxooqdXB83Ek+4ZLr7p03LyBpsjlRwZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mL2WN2c+SP7KUgRtus5LZrMNw5+OAKrgOxYV4FA3VDdcM1A9YD
	kQaRuUISFnFo8fa1PFpg8GTedknbATOVFipbgfjxKBwIkL5+cP32/+CB
X-Gm-Gg: AR+sD129f8REmLnm484ZMWx3Nbr+rVvvPS2LTGoFqAVCOKhHJYreGO3dKm+hrAcTRY1
	6B2mlWRrINdXFYGwUVLm8KUcuKsVEuV8NGFKpupTWpJEZl04YV/TRlQhEZV9I/WgbGTtZdE9Sh6
	/H7t1Bl8EXjhpKJ6kQLgxqy7RLllZKOQRFgja3B2YmXXQPAwaW47XvoDa1tGxDtcgvsbvtUHuM8
	NrCRJP2qrhsaRu/KpW56CT+4ksJ/EzqB3uB6Ez4QKRSudsMvN6+s6E2aMZeYrEmfuOlqporKFr0
	E6akUZdxISDoTsM0+SDUCuw1/HBXDovZdE/xMtZGjebB3/QHRhTjz/QBQLQJxSldDTf+Nw7KUqt
	g1b+Bth9zM/dr/7nJtKYU0UAMohQVSS/4Z/cf3pnp1Pv4QDztT19O6TNOT6/btNg47SYxkkw16B
	DIUUJkonUErfms9Zv4EMGBmu3wnTpzTw7axcdUocnKESAhltf8+AQ38lMQKxs42NA+ZxQmtw==
X-Received: by 2002:a17:907:3e2a:b0:c21:7feb:4574 with SMTP id a640c23a62f3a-c246a2cece6mr1544595666b.1.1787434838519;
        Sat, 22 Aug 2026 14:40:38 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:38 -0700 (PDT)
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
Subject: [PATCH 06/13] HID: ft260: i2c: reduce bus-error message severity
Date: Sun, 23 Aug 2026 00:39:34 +0300
Message-ID: <20260822213941.98882-7-michael.zaidman@gmail.com>
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

The driver logged errors when the FT260 reported an I2C bus error or when
ft260_i2c_write / ft260_smbus_write failed after such a status. That was
meant to flag unexpected failures, but bus scans (i2cdetect, HWMON
discovery, transceiver monitoring, and similar) hit missing devices
routinely and should not spam dmesg with either:

  i2c bus error: %#02x
  ft260_i2c_write: failed with -5

Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
ft260_hid_output_report_check_status for actual HID/USB transport
failures, which are genuine errors.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 8db896f164cd..1ed3701eaaf7 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -565,7 +565,7 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	 * to 1, bit 1 is also set to 1.
 	 */
 	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
-		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
+		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
 	}
 
@@ -599,6 +599,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
+		hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -638,7 +639,6 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
 	int ret, wr_len, idx = 0;
-	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
@@ -669,7 +669,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
 							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			ft260_dbg("%s: failed with %d\n", __func__, ret);
 			return ret;
 		}
 
@@ -685,7 +685,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 			     u8 *data, u8 data_len, u8 flag)
 {
-	int ret = 0;
+	int ret;
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
@@ -710,7 +710,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
 	if (ret < 0)
-		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
+		ft260_dbg("%s: failed with %d\n", __func__, ret);
 
 	return ret;
 }
-- 
2.43.0

