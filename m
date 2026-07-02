Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADE1FF1DA
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020146; cv=none; b=TsNJzBFQ0hlVeYXWjCSIV5CLDq1fL55jIQGs9Xmk2qZwexU4N1weZVePb1y0JJ8d+qa/dwQmH8D63kCPjEn17gfBIVMrwWaDbpCYUeS4aBm/fhFKcjtpkkZkRiw+tYy8QhVV6NLI9GtwsmyxHngRGv5qkesHFYUs9PgOXDY98D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020146; c=relaxed/simple;
	bh=lDg7mPaMrJuyA4a5JT047YdkCP7xV4CskykPTzhUGoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ulWy7Uh1U+ok2l8OyDDLJMjui0w/4VMesC4QhIGbRC9GtfgKIhCtUJ9OB4zUyYP6eEyLQefVSI7cmURQkkF+ISfX+xx4fog2jIAtUj/UtFCctp+V8AEaVT4aHRCFOBPt552u/d9no0EUglHxJ3cb4B+0kaVLR7U56HokQ0nig5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lskvkdVA; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lskvkdVA"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso697980a34.1
        for <linux-input@vger.kernel.org>; Thu, 02 Jul 2026 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783020144; x=1783624944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3QmiCi8nlDSo8AinNYFGBg/s2BVFKV/5OCNteoXpkGk=;
        b=lskvkdVACGn4T35T2QvVww2DPq+ueEu04K3TpQrvWCf09X8/RQJFGUchj9vTAlZaKq
         xA3aMZxEwmMh5w/yWeESjyKXj0QubkRwv5mQgdht1qiBjT++OPPM+Fvi5mY2YBRydTxg
         FBxTa77GnRHTv3Ksig8cD1OTqGFil6UdGghlqnK0U19jSEdQbbOhXi4Jl3MRY/s7homO
         lmRsr2WwfRNJBqFS1Q94K+hNKbe+sHPi8IKnMmGgfSLH5OanqDz1cPJCLrXe1eZVd0IT
         40GYLexsDWlTWbOilmA1pkY+I/sczpL/iVgi33UlancLMRyzrFfZifIIYj4YcBpTLTZH
         Z0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783020144; x=1783624944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QmiCi8nlDSo8AinNYFGBg/s2BVFKV/5OCNteoXpkGk=;
        b=ZwJRleNzHvW9wGwWpriqU57W4eX3LDAhFwNkXeKPG9iHex+aQiOiL4wrW5Dj5Hn9GK
         8dXxMdBa51YZttQteWmmSK2coAFaQ12cgwIYqusjIqtAX9QpJRAAvUVj0cLj+VC5gYCn
         s3OuenU3vzVY3S1HuvmImch5W1PMmzYrEP+ybBfWBffv6PRiigH568tyaJmz/qBCDWwA
         KYs5cPCGc6eegqDyQacebppxvpunInteTOnyNiWBxy3JZX2m/GaFH2LNU7CZcwjqff2G
         VChyNJdrbPDMXY9ceX0FKjJkWes4sN7J0rp01/OFIcxLjY+YRnKH9uqG9NMKlnig0uaB
         nHNw==
X-Gm-Message-State: AOJu0Yw8nONAgMWdKIjxTzbLoesTxRSTb9JLYZawjA4l5VPf+t7Kf/w6
	uRV5ztfda+jW0X217ItsKG+R8ogZb+xnkz6BCrDpaY5ZTVDbA5pwSZno
X-Gm-Gg: AfdE7cmnDjkofOL/OWvX/XRxWzGPvxWlDwHyQe6c5P/3V+9Neyi9e2SmVWQSy+Ao037
	cbkhqR0/vGqCR1D3WfgjXk81uKmylATcYdj0TdGL3UsqAe+hyu2WlhwuuiyQco8c/F2PVTF8+bm
	OGmBL/Pz0HQki+h9M8vrb64DvoZeJ7kDKgdmPcScel1mHz8FqQjeCqucTmimt6Bj47WibBK9T7y
	jJoJ2MPSLkV3YwwNpXQo6qTucrFXsXECcfJjz0yvZ+E2pSeIY3fYs6V7H+i40sYoefpZHmVZnoz
	WmzzQQlJm9durZRZwWj+q5+00kdUnuO0/APcFv/M4ruVE9s/Jj8Pu+Jt8VJWGuLCexIIrmRZ7dK
	O+11GM0hmB2eVvKuGVWegBRmwCzSm6Nk/c+vNExhF5dtVMR7iVLYds0QTg6V3cqREQoiZFsGxCV
	coDYOtSxw8Ir+K
X-Received: by 2002:a05:6830:448a:b0:7e9:eb13:d042 with SMTP id 46e09a7af769-7eb48ae8a36mr4552908a34.8.1783020143675;
        Thu, 02 Jul 2026 12:22:23 -0700 (PDT)
Received: from desktop ([2806:2f0:9260:f072:92d3:78b1:9863:130a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb544a26basm3238309a34.18.2026.07.02.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 12:22:23 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: [PATCH] HID: input: read battery capacity from its actual report offset
Date: Thu,  2 Jul 2026 13:21:39 -0600
Message-ID: <20260702192139.114809-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hidinput_query_battery_capacity() assumes the state-of-charge value is
the first byte following the report ID (buf[1]) and ignores where the
battery field actually sits within the report.

The Apple Magic Trackpad 2 (USB-C, 004C:0324) precedes the
AbsoluteStateOfCharge byte with a byte of status flags in its battery
input report (report 0x90). Over Bluetooth the capacity is obtained through
this generic query path, so it returns the flags byte instead of the
charge level and reports a bogus, near-constant value (~4%) regardless
of the real charge. A raw query returns:

  report 0x90 -> [0x90, 0x04, 0x31]
                        ^flags ^SoC = 0x31 = 49%

while the device is actually at ~49%. (Over USB the battery is fetched
by the magicmouse driver's own path and is unaffected.)

Store the battery field's offset within the report at setup time and
use it when querying, so the capacity is read from its real position.
The report event path already parses the field correctly through the
HID core; only the explicit GET_REPORT query was wrong.

Devices whose capacity field is the first field in the report have a
report_offset of 0 and are unaffected (buf[1 + 0] == buf[1]).

Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
---
Tested on an Apple Magic Trackpad 2 (USB-C, 004C:0324) over Bluetooth on
v7.1.0: /sys/class/power_supply/hid-*-battery/capacity went from a stuck
4% to the real ~49%, matching what the device reports over USB.

 drivers/hid/hid-input.c | 17 +++++++++++++----
 include/linux/hid.h     |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600ca..b55cbe7f6 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -432,17 +432,25 @@ static int hidinput_scale_battery_capacity(struct hid_battery *bat,
 static int hidinput_query_battery_capacity(struct hid_battery *bat)
 {
 	int ret;
+	/*
+	 * The capacity field may not be the first field in the report: some
+	 * devices (e.g. the Apple Magic Trackpad 2 over Bluetooth) precede it
+	 * with status flags. Read it from its actual byte offset in the report
+	 * (report_offset is in bits; the leading byte is the report id).
+	 */
+	int offset = 1 + bat->report_offset / 8;
+	int len = offset + 1;
 
-	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
+	u8 *buf __free(kfree) = kmalloc(max(len, 4), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, 4,
+	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, max(len, 4),
 				 bat->report_type, HID_REQ_GET_REPORT);
-	if (ret < 2)
+	if (ret < len)
 		return -ENODATA;
 
-	return hidinput_scale_battery_capacity(bat, buf[1]);
+	return hidinput_scale_battery_capacity(bat, buf[offset]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -593,6 +601,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	bat->max = max;
 	bat->report_type = report_type;
 	bat->report_id = field->report->id;
+	bat->report_offset = field->report_offset;
 	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	bat->status = HID_BATTERY_UNKNOWN;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 47dc0bc89..51b21f980 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -642,6 +642,7 @@ enum hid_battery_status {
  * @max: maximum battery value from HID descriptor
  * @report_type: HID report type (input/feature)
  * @report_id: HID report ID for this battery
+ * @report_offset: bit offset of the capacity field within its report
  * @charge_status: current charging status
  * @status: battery reporting status
  * @capacity: current battery capacity (0-100)
@@ -657,6 +658,7 @@ struct hid_battery {
 	__s32 max;
 	__s32 report_type;
 	__s32 report_id;
+	__s32 report_offset;
 	__s32 charge_status;
 	enum hid_battery_status status;
 	__s32 capacity;

base-commit: b7556c8e713c88596046a906c7c4385218d44736
-- 
2.54.0

