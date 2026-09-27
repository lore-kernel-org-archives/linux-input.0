Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65603379960
	for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509480; cv=none; b=DvDLCCwV+I/TTDN9MQ5SRCSh46kZhKF8EDBrDt0687xnm2ylCyNns0e75CUv6lyhVi5Nqccv0k0zlHWZ3FGcykf25Urlg/YJxpONpREc5odmWJWKmT29mMHcQwfssXJbaXMN621df1muu52WUr6TQaXQ0dLdQjxR+7lfD7AfAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509480; c=relaxed/simple;
	bh=hf0wX8L+LlOnBK/0W9a1hoHrZm6rTBLmfL8ZB2OOX60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvhaQ90KK9qBjY2OyZLxN5NKJ+cdx211LZg4Wl/NRKCm7tUp2WlNgBybnTjYOrZl/nl/7WNHdTpH1aTL3jbpf0ebncn7uaJ4SU1UckGMvAMN25c0oHVDhoczkueGQzXWcrGjjjRtlIbrwBU0w6+hd0fjIujWF1xCsD0tApcj8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxdalUWk; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxdalUWk"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2bca99f463so80034966b.0
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509476; x=1791114276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kX6+iIntdcgKoHvnXvTvQFxv7ZWuRjd/+5VmFDIp/gY=;
        b=GxdalUWkBw7Y8/6w4QLEKPLA8Deq6SPAHHy5QGWsHiHbruosurjFfP0EpHjgRGy+ru
         TvPI7p20h+TNKAy3OuP0JPmjZTvLZ6kxgTPuHfvVq8Rzv5DymwYht9sVtMS+XACLrP4t
         x6xTSn8x7Qa5CwlBijdENpxRSE4raF0UqzmSDWmczrBql/ZEdEuLwDNWLQqAhTrV0B0Y
         rMyO5Z73lx9gzlANOhZwtqQT1fahjI+ITRkPkFSUB22FnEMuqlTkqyZRl789oWbwK6fY
         iGm9ap6nCp+6wlmgo9uBeu6eh1j1KmCFR2VXjYrSOCaAs/2PnMuDAuGyMIirUlsz5Y6l
         SHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509476; x=1791114276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kX6+iIntdcgKoHvnXvTvQFxv7ZWuRjd/+5VmFDIp/gY=;
        b=kFScPzge1XX5j/NmszvjELAMLdd0HfWQ4Z/B7QzVP84300IxNj+R6iiGZtg1020tZJ
         AB0pvG+8mGB1g7mrlrKje+AswPpSSqfK8905hFhtYpwIdRn2ldTrOUexzXCliAXj03pM
         PvRli2TfNMfOKVeIoRp4ZcJdHvPNCZom5BH2hJe0Y+7rbiZu6hHJkbMpUyzYgjXnBzv4
         E+DMsGGHc5CcxfSQMCR4jEr6fwATm7Lde7VFxVywXnNaKUGWjRBiaGeDrqOMi74s1j3M
         3K40zABd076BzsGQrvMaljqrx8WkoGzkfPD6cns5gD4jXsyyU8GTTvszWKtvBfG3J49N
         WWeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRAPzIBMyPM9cBvOS25bDh3WknHRDxOBfEUUFdMvSD+wSfLyrjFiE1vNYywTueP+j/yXrjGyhhW7F0dQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n3R5gDVmz7Zn3UmA0JQqZXcNQTIH9M5+PcK5vf1P8Bn9CQ4LCG
	eXwBipb7BSiLYMeJ5huOxlLDW4jUP75o4ucsYtn6TnsH/TKyVGnrDySb
X-Gm-Gg: AYBFou0zTuBp8ujr4oN4btSJdoXxIoC1RcTpBLnWOCvtN1guI9Baas0t4K1dw7FlFot
	FvDtkTOTCAcWu+EhbXnovdSx+/y8P/weXLNj93b++bclLLa//stIQ5H38h12aTCutMdlmHRmJxI
	4fmQiUw9Ka6IUap/vKYPo0+g48Y2qyoTC8crGHtv1puvXeS6CN+NZ6R7LZlUMbS1KWO4QLYOULr
	uGgw3j3/PYVP98tOQ49NGgBlrFrzEL0CuVWn2b4f54Nbp1avH6mlVdv+WnFrmXdoEs+pUYoE56U
	oj70AU7p3KeK1ZCbo7rYX5B/zkZN019t7DHJ8KzKeCIwgdcgzagi5BYevTyUbKoyJhoJ1JI6Tat
	L3v9Mlf4ISrb+EPZcJUabEYNgTEaz1diPOz3/WiF5yrLfcor+4Tx0fZRoxvGuiB4XlC0gyWKMNc
	9e1Tf1sYzhAAvxeUFrQ1GagbfJlxAZy2c9Wxl5hPw1snE+bNH5w/gbocEbWRTaVo6+MVA1xHhZ6
	9jz/FO1s3wWWi5d+UfhEic1T91IwpxbLUywESns/Ti58alT/sTQAIki6teBbA0OC5shvnsM00qU
	6dp07e23gps=
X-Received: by 2002:a17:906:628b:b0:c26:3377:752b with SMTP id a640c23a62f3a-c2ac21fa2bemr891918966b.3.1790509476432;
        Sun, 27 Sep 2026 04:44:36 -0700 (PDT)
Received: from localhost.localdomain (84-216-182-59.customers.ownit.se. [84.216.182.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7356d1csm338411266b.18.2026.09.27.04.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:44:36 -0700 (PDT)
From: Pooyan Azad <pooyan.azadparvar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Herlangga Maulani <w1zardsec@proton.me>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: raydium_i2c_ts - validate report parameters
Date: Sun, 27 Sep 2026 13:44:25 +0200
Message-ID: <20260927114425.442803-1-pooyan.azadparvar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller supplies packet and per-contact sizes used to allocate and
parse touch reports. The driver trusts these values without validation.

A packet size smaller than the two-byte checksum makes report_size wrap,
allowing the IRQ handler to read beyond the report buffer. A zero or
undersized contact size can cause a divide by zero or make the contact
parser read beyond a record.

Validate both sizes before publishing them, and reject reports that
describe more contacts than the input device has slots.

Allocate the report buffer once valid main firmware information is
available, and resize it if a firmware update changes the packet size.
This also handles devices that probe in bootloader mode, where the packet
size is not known yet.

Finally, return main firmware query failures from initialization so probe
and firmware update do not continue with invalid report parameters. Keep
bootloader HWID query failures non-fatal so the recovery interface remains
available.

Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
Link: https://lore.kernel.org/all/20260728135127.48971-1-meatuni001@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>
---
This partially overlaps Muhammad Bilal's earlier patch linked above. That
patch propagates both main and bootloader query errors. This version keeps
bootloader HWID errors non-fatal so recovery remains available, and moves
report-buffer allocation into the main query path so size changes can be
handled safely.

Compile-tested with:

  make O=/tmp/raydium-build W=1 -j$(nproc) \
    drivers/input/touchscreen/raydium_i2c_ts.o

 drivers/input/touchscreen/raydium_i2c_ts.c | 64 +++++++++++++---------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 0256055abcef..1d7f53d0b9fe 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -64,6 +64,7 @@
 #define RM_CONTACT_PRESSURE_POS	5
 #define RM_CONTACT_WIDTH_X_POS	6
 #define RM_CONTACT_WIDTH_Y_POS	7
+#define RM_MIN_CONTACT_SIZE	(RM_CONTACT_WIDTH_Y_POS + 1)
 
 /* Bootloader relative info */
 #define RM_BL_WRT_CMD_SIZE	3	/* bl flash wrt cmd size */
@@ -331,7 +332,10 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
 	struct raydium_data_info data_info;
+	struct raydium_info info;
 	__le32 query_bank_addr;
+	u8 *report_data;
+	u8 report_size;
 
 	int error, retry_cnt;
 
@@ -341,26 +345,22 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 		if (error)
 			continue;
 
-		/*
-		 * Warn user if we already allocated memory for reports and
-		 * then the size changed (due to firmware update?) and keep
-		 * old size instead.
-		 */
-		if (ts->report_data && ts->pkg_size != data_info.pkg_size) {
-			dev_warn(&client->dev,
-				 "report size changes, was: %d, new: %d\n",
-				 ts->pkg_size, data_info.pkg_size);
-		} else {
-			ts->pkg_size = data_info.pkg_size;
-			ts->report_size = ts->pkg_size - RM_PACKET_CRC_SIZE;
+		if (data_info.pkg_size < RM_PACKET_CRC_SIZE) {
+			dev_err(&client->dev,
+				"invalid report sizes: packet=%u contact=%u\n",
+				data_info.pkg_size, data_info.tp_info_size);
+			return -EINVAL;
 		}
 
-		ts->contact_size = data_info.tp_info_size;
-		ts->data_bank_addr = le32_to_cpu(data_info.data_bank_addr);
-
-		dev_dbg(&client->dev,
-			"data_bank_addr: %#08x, report_size: %d, contact_size: %d\n",
-			ts->data_bank_addr, ts->report_size, ts->contact_size);
+		report_size = data_info.pkg_size - RM_PACKET_CRC_SIZE;
+		if (data_info.tp_info_size < RM_MIN_CONTACT_SIZE ||
+		    data_info.tp_info_size > report_size ||
+		    report_size / data_info.tp_info_size > RM_MAX_TOUCH_NUM) {
+			dev_err(&client->dev,
+				"invalid report sizes: packet=%u contact=%u\n",
+				data_info.pkg_size, data_info.tp_info_size);
+			return -EINVAL;
+		}
 
 		error = raydium_i2c_read(client, RM_CMD_QUERY_BANK,
 					 &query_bank_addr,
@@ -369,10 +369,29 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 			continue;
 
 		error = raydium_i2c_read(client, le32_to_cpu(query_bank_addr),
-					 &ts->info, sizeof(ts->info));
+					 &info, sizeof(info));
 		if (error)
 			continue;
 
+		if (!ts->report_data || ts->pkg_size != data_info.pkg_size) {
+			report_data = devm_krealloc(&client->dev, ts->report_data,
+						    data_info.pkg_size, GFP_KERNEL);
+			if (!report_data)
+				return -ENOMEM;
+
+			ts->report_data = report_data;
+		}
+
+		ts->pkg_size = data_info.pkg_size;
+		ts->report_size = report_size;
+		ts->contact_size = data_info.tp_info_size;
+		ts->data_bank_addr = le32_to_cpu(data_info.data_bank_addr);
+		ts->info = info;
+
+		dev_dbg(&client->dev,
+			"data_bank_addr: %#08x, report_size: %d, contact_size: %d\n",
+			ts->data_bank_addr, ts->report_size, ts->contact_size);
+
 		return 0;
 	}
 
@@ -428,7 +447,7 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 	if (ts->boot_mode == RAYDIUM_TS_BLDR)
 		raydium_i2c_query_ts_bootloader_info(ts);
 	else
-		raydium_i2c_query_ts_info(ts);
+		error = raydium_i2c_query_ts_info(ts);
 
 	return error;
 }
@@ -1116,11 +1135,6 @@ static int raydium_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	ts->report_data = devm_kmalloc(&client->dev,
-				       ts->pkg_size, GFP_KERNEL);
-	if (!ts->report_data)
-		return -ENOMEM;
-
 	ts->input = devm_input_allocate_device(&client->dev);
 	if (!ts->input) {
 		dev_err(&client->dev, "Failed to allocate input device\n");
-- 
2.43.0
