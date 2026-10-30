Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399841;
	b=pwJtf+J8k/0cq9Nz51Ce95ghMtazNiDLKDVRI9i/3Ehhb3Sy9C/4PzC8y3SBAZmPcTWJ
	 dVy0lMpMPHqIUikl21Pu65KhC2i63HythE9kfH3NAxD47QtA54T7jHampbfVCso5jaPZf
	 Jam2Sp0sLXBM8J/QvMg6VbrOP+jvsSRuHqhNkDIZnZaA9uWipCtgRI2QebJ0GuK6qPDwA
	 lJP1EeUCy7g2sU0g1RzK7B4pC0cwPqy6THqY5CliKYGfPwxWcnFN+RSY1s5sOUn+H25Jt
	 yUlef0g05O88JYZyAo1OC7QglKWNd4PpcHhIeSw07QXfWGlqy06Or+aGW7J3wIj9EaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
	b=aD2TZonIitNCf3SM2Ln9vCWt4QvBDOKLotiMHMvaiKXYpJFHTakCbrho/g2X0HFNoGKn
	 eJ8wnMAyjsZu+R+8ydvQsVTkmAksdtUhJF5fjxYWczN430oMxVhHuNoS592zaR80nsydA
	 AaLQwAVz1mjpEB9UsOqCpHnlpHR4TzcKjbs3eBIDYLHq93ekiQLAn03i4umNevAaeiAZ/
	 zACyXfkxSGIl7vNgdNZafdzJuF3Zay45a9oN71n0z2Kz59g6vLNO8U2zcHr8s/001XGJK
	 jXKSZicgW9Ve7XXZYwprzRPXdKA2D5h14Q5KDTdwpWka0k3DoyKAU7nix7o3mT7nqmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5EpnNO;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC060A380F
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BDC060A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5EpnNO
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so12763625e9.2
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399839; x=1794004639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
        b=yd5EpnNOD2uZtleapc+hZXnJ+TEjXTpUZJmmTe21kU25Yu9fYu/s/whBTAuP3x/wM1
         V8WVki5h1ivcr/NvTgB/TSTWqpQTfTVwqIwYn553dt0xaJtEb4TuWmeWmnHx1JLLAAxE
         KzWhcuPfI4kmVS06PeLeQrrNtckKErC+nCg+N1oO+yVXbrfyqwLpyZ5NFcj4nE6Mqdg9
         X6rQHL3kift3MfQof0XedmmzQedYkMTMeFTRGx1/MGrKVve+vxLlUKZTBOQ2EtMfYtQO
         rkHZJIzfu/mf50nmcYlvQACKBaK5OR7zp48II0T/3RsRzqTqddDLj3P1fHHUCj57nHC4
         8jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399839; x=1794004639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
        b=L1QUVj45EWjwVd+UkSqdGU9IdqsYolHGhqp4BnBfFnyEcWD2ITaw2WIKmao9sviTuJ
         yzT63oFm4AisciaqR5i2A69bghCGxZeFfRUQTjYFLjev5xAzrtSZiZGULo/n4bQ8yOIx
         OtSzR0mvhmQBrBgPfY3Yu8Xf4Ouk94deNfbcMsGYUmHENdl0P7ib11uwWsFG/RFdAT03
         2LeaRSbenNJricLIwT8Gch4EFTf3PQF5r4Caqp5MhU4ar90YNzusjxLU6JJyYz0EZ9hU
         Ss8cmsvrRluByzDYeCVYQ/rfU7e0upfCH3oEbvFjxOs4QBa79a2tpaIgD2OUG7Bavjh2
         kLhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqFXfwolFoR1tBTLHmuuZMck+1Zyrm4YkC4LzodTczrn6Gq1wkOzTf1KmDdy/hMtVI5+m98VA99nWQ2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYL070aWz/s40rGFwuQk9fG2ZyRMaG/1/17gUjCy3syP3f3Kv0vD
	7NXTuOd5t3kSwEMsrFcKJbMccl//yZe3awG74Ymc9lU9mW/jslsD79tZ
X-Gm-Gg: AYBFou1/B4zQG6J/y4SqfcxIBjfDbIa65FWxVOe8lf2X3bDSz3tmfxjiBr46QaGaclM
	wsOyBiaooGm1mKacek1omr/kL5V07/wwHFw02mGPKtlrLUukOzx+MlRLr+K+Cq25Zcf2LHXPFpk
	zZdiZnP4ZyQFGI7zLpsUPqg/aVdnwZQN/dOT1ve/JwCoBAh1pfrlwMmjtcO1LQlT5m7+whmbock
	QHKOy6CGNbtuH1BCCNe7CXT5REjDA6e/HlFXWiWuOkkMOHaYHEKOvABUao9puCIn66vqiLc20RM
	p0b7/XSpqYRhj/Iq1CGVWRrnfXs6py5ylzEFZq3AX8SakjOUXigl5KpAOQiwRps0LCsEe2cVlyo
	zXanOXP8AIxxinEm2xzSUduRu1+xVOUT/+fZw7wnv98cXmdIkmvGB6ZKnKBxoFg50+szff5g4YZ
	GV16nZ+4DxkokfoIcHVIqxpP7FO6OlPcyGL3rsvtjLJMMADKUkYruKZlU7cJ4NZeCKhFcB3WsLb
	YSDMYlEzmBgtyY02OH7StwJ293Hd70ZoTNZwQ4VdLYN97q5rPVVCAXp1XEQZTiqBwvJDNzazxc/
	wKPHl2HQdEquoxKvkvF0Gda3FNXo
X-Received: by 2002:a05:600c:1f93:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4ac182dbc34mr81626205e9.14.1793399838726;
        Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
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
	Michael Zaidman <michael.zaidman@gmail.com>,
	Chris Keeser <chriskeeser@meta.com>
Subject: [PATCH v2 10/15] HID: ft260: i2c: fix large write transaction failure
Date: Sat, 31 Oct 2026 00:36:32 +0200
Message-ID: <20261030223637.86907-11-michael.zaidman@gmail.com>
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

Fixes a regression from commit 5afac727defa ("HID: ft260: missed NACK
from busy device"), which waited for bus-idle after every HID write
report except when the report flag was exactly FT260_FLAG_START.

Multi-report I2C writes keep the bus busy between chunks for atomicity.
Treating those middle reports like a final STOP caused ft260_xfer_status()
to spin on -EAGAIN after the second HID report and fail large writes.
Write-then-read combined transfers still worked.

Pass the bus-busy check policy from the caller: ft260_i2c_write() and
ft260_smbus_write() wait for idle only when the report they send carries
STOP; intermediate chunks and the command phase of a combined transfer
do not.

The SMBus side matters for register reads. The command phase is written
with FT260_FLAG_START and no STOP, because a repeated START read follows
and the controller deliberately keeps the bus busy to keep the
transaction atomic. Checking the busy bit there makes
ft260_xfer_status() return -EAGAIN on every retry and the command write
fail with -EIO, which breaks probing of clients that read registers:

  ads1x19 6-0040: Failed to read config register: -5
  leds-pca963x: probe of 6-0008 failed with error -5

Fixes: 5afac727defa ("HID: ft260: missed NACK from busy device")
Reported-by: Chris Keeser <chriskeeser@meta.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/35
Tested-by: Chris Keeser <chriskeeser@meta.com>
Reported-by: Bruno Giacomazzi <brunoceg1@gmail.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/42
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index dca0250f2c25..65835e13fa2a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -576,9 +576,14 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	}
 
 	dev->clock = le16_to_cpu(report.clock);
-	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
-		  dev->clock);
+	ft260_dbg("bus_status %#02x, clock %u, bus_busy %#02x\n",
+		  report.bus_status, dev->clock, bus_busy);
 
+	/*
+	 * Do not check the busy bit for combined transactions
+	 * since the controller keeps the bus busy between writing
+	 * and reading IOs to ensure an atomic operation.
+	 */
 	if (report.bus_status & (FT260_I2C_STATUS_CTRL_BUSY | bus_busy))
 		return -EAGAIN;
 
@@ -612,13 +617,10 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len)
+						u8 *data, int len, u8 bus_busy)
 {
-	u8 bus_busy;
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
-	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)data;
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
@@ -635,16 +637,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		ft260_dbg("wait %d usec, len %d\n", usec, len);
 	}
 
-	/*
-	 * Do not check the busy bit for combined transactions
-	 * since the controller keeps the bus busy between writing
-	 * and reading IOs to ensure an atomic operation.
-	 */
-	if (rep->flag == FT260_FLAG_START)
-		bus_busy = 0;
-	else
-		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
-
 	do {
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret != -EAGAIN)
@@ -661,6 +653,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
+	u8 bus_busy = 0;
 	int ret, wr_len, idx = 0;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
@@ -673,8 +666,10 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	do {
 		if (len <= FT260_WR_I2C_DATA_MAX) {
 			wr_len = len;
-			if (flag == FT260_FLAG_START_STOP)
+			if (flag == FT260_FLAG_START_STOP) {
 				rep->flag |= FT260_FLAG_STOP;
+				bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+			}
 		} else {
 			wr_len = FT260_WR_I2C_DATA_MAX;
 		}
@@ -690,7 +685,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4);
+							   wr_len + 4, bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -731,7 +726,9 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+						   (flag & FT260_FLAG_STOP) ?
+						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
 		ft260_dbg("failed with %d\n", ret);
 
-- 
2.43.0

