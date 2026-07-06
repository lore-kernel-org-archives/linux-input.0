Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127442EEAC
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361186; cv=none; b=gP/r5KIvRCU/jwPt6B2Ub1lQDZ2NaejsbwYHrVY1wSRJEb/O8uxp5N9brLwysBlE67N3VnfvZ3wzPOmONnXNZ2gE+vCTTmWYsduIperc3XP2rD6TG2mDmFfubI/lfMJBAtWI+D+S5Alt17I22+S24GhElJL2cjw6+D97n1OwLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361186; c=relaxed/simple;
	bh=p9+cYVQ2u08MvGcOXF5V4GFGi2FvwBGT9zDzZdXMqQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bB2NOc+W2QaB5mIThZVxZwO+o/au4Dj0ttLDQcpAQ9KOxwDyhvhUZSrZbwWeXw7+qBtQCV00v++SoSOx6SAAqsbkJAlo5HcxWYImoDeOnYSU7XxyYJvZDYLhblCmocvrqQeQhtSdoOWB8PYzAOknvJc/9SMkeQoHJHOpXFmRINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf1f+seT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf1f+seT"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3800f0907d5so547198a91.0
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361182; x=1783965982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pub5fUhpk4oayvErkUKKCWSZSgtjI8UMcjChlJ+Q7qE=;
        b=Vf1f+seTiuK2YTeiHuW42W/zbFJQ1/PZiUPNNEgoG1rQS9R2O2cNtt69dE522nRfP6
         mBO81v6MVUTkB/C5v1GTy6LSa3zrdmht1Nb78qkgTJeybExAPVOwZO71zUZtLZkKrMA3
         jQer9nfp9Ltm3rmhC0zm0at5L1IuFij80SRLKpkzyAXfJzhWPhhGUsNvw6h4VnYfHgrI
         VA6iGyugrUBuQxGACuq67SI9MycBTwTEPXpvdR+MJZXQ4swDjL1prQIjw8jU12fIc+C6
         5tDHSCPvC8HEf2JoIxffAtMjQQUVZN8HGsjbx1ZGIbNVo+xR9c2rN2/s/EqD+lnkCI9/
         DL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361182; x=1783965982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pub5fUhpk4oayvErkUKKCWSZSgtjI8UMcjChlJ+Q7qE=;
        b=Xju17n0D3Erw98Xsd4t0JchY7pp+Vw1uH8mkM4fq1qdm5qj5ebGTpxtxbEaE+fte3+
         WmdTRNXGsuGXwxztAHYNtMkUxEGBSfYXrSnnUXOtQ0HQz6k7K+cA3OvAyIYrGlZNs/UP
         cPMs4ZWuuoNyENs4RzheB6JdEUU3awyvGxG/Tvr5PYEsGwXKyqzzA8guD9NGDCvJG0x5
         zl0rE/MelcWBCLA8Dmlh20/Mr+qrjCyrFRpDjU97DZuo/EUo74dZAy6iMZpIGlNF3Bqb
         Yub7UMulftTb8AQpbxZI5ZN48URqlU7N/ve3/Du8ll4ZiY+kG7lCsRbS+pTDBY8B2ceq
         9fCw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7T/MboAqwLzLK7sCk1AxNuSr9+og4HxEQ2ieLnwRjQOaVkK52QbPSy9hS/H4Z5HR3QLFdALEnwN8bEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvaAyUMshuMGRo8Wh9HXbqbw5BAjdXEV+XZycz7xl8kXtkuak
	I6Tim+H/1ZUkUkQr1otVpQ9D+sUSkcrk5D7SXieaqJANkpyqCccGFrDz5EhOT/lS
X-Gm-Gg: AfdE7cmlh71nXHDlrAWhsMtBo5w0SuUSHAaFJXgJlFFrIy8HJPzUi+QqEEh4B4kl0zF
	ULc1/KIDy3P6oG4kR+du+WSgjGsyMKUGMwcDFEaVY/f6cwInPyzIcjw4GDNVtRkF7A6sgSD7sTf
	93dWVTXiQaEdCt1u7dG+TtXYGRzFgj6qDKbChlxmcL0ZtQBfO7nqfMk4YPKWWzs7QQT6EB8TWEG
	YtbmjNXBQL3Mj3MGwKDA1Vdm40PCYWWqJYVXUNGhzvQPIePc1Sspnxwuwp0Urlnf7VpqrjJxupt
	OQnHLAUuIsXnxS9s4x5oNzBtmtJJSVeCoXv//TRvVIdTwgXhuKYduGBV6LlIFh8dPWUem88XOXY
	r1yySuyWJtHO09IN87I51PV8iI1vcvoy/HcKIc/CEm09Fp1ToTxbl4vX/xBBdNnEzu4D66fUo8f
	mgst/xJTzNRzuyR0e03mQdsPsHgcOw+nGsUhU2qC7s
X-Received: by 2002:a17:90b:1dc1:b0:37f:e8f6:8d4a with SMTP id 98e67ed59e1d1-3825c4070acmr6776065a91.0.1783361181798;
        Mon, 06 Jul 2026 11:06:21 -0700 (PDT)
Received: from kavandesktop.local.lan ([50.46.174.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae18f7sm5541585a91.3.2026.07.06.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:06:21 -0700 (PDT)
From: Kavan Smith <kavansmith82@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: michael.srba@seznam.cz,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kavan Smith <kavansmith82@gmail.com>
Subject: [PATCH] Input: zinitix - support the 6-byte/count touch report used by bt532
Date: Mon,  6 Jul 2026 11:08:25 -0700
Message-ID: <20260706180826.408989-1-kavansmith82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver assumes an 8-byte per-contact report stride with a per-finger
bitmask in report byte[2]. bt532 firmware (Samsung Galaxy Tab A 8.0,
msm8916-samsung-gt58) instead packs contacts at a 6-byte stride and reports
a finger COUNT in byte[2]. Under the 8-byte/bitmask assumption fingers 1+
are read misaligned, and a two-finger report (count 0x02) makes
for_each_set_bit() visit only slot 1, collapsing multitouch to a single
contact.

Add a per-compatible struct zinitix_chip_data that selects the report stride
and how byte[2] is interpreted, and attach it to the bt532 compatible (the
only in-tree user of it). All other compatibles keep the existing 8-byte,
bitmask behaviour unchanged. Contacts are parsed at the chip's stride, and
for count-style firmware every slot the chip marks with SUB_BIT_EXIST is
reported.

Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
---
 drivers/input/touchscreen/zinitix.c | 71 +++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -135,26 +135,47 @@
 #define CHIP_ON_DELAY				15 // ms
 #define FIRMWARE_ON_DELAY			40 // ms
 
+/*
+ * Two Zinitix touch-report layouts exist in the wild. The default is an 8-byte
+ * per-contact stride with a per-finger bitmask in report byte[2]. Some firmware
+ * (e.g. bt532 on the Samsung Galaxy Tab A 8.0) packs contacts at a 6-byte stride
+ * and reports a finger COUNT in byte[2] instead of a bitmask. Selected per
+ * compatible via the of_device_id .data below.
+ */
+struct zinitix_chip_data {
+	unsigned int coord_stride;	/* per-contact byte stride in the report */
+	bool finger_count;		/* byte[2] is a finger count, not a bitmask */
+};
+
+static const struct zinitix_chip_data zinitix_bt532_data = {
+	.coord_stride = 6,
+	.finger_count = true,
+};
+
 struct point_coord {
 	__le16	x;
 	__le16	y;
 	u8	width;
 	u8	sub_status;
-	// currently unused, but needed as padding:
-	u8	minor_width;
-	u8	angle;
+	/*
+	 * 8-byte-stride firmware appends two unused bytes here (minor_width,
+	 * angle); the report is parsed at the chip's coord_stride, so on that
+	 * firmware they are simply skipped rather than being part of this struct.
+	 */
 };
 
 struct touch_event {
 	__le16	status;
 	u8	finger_mask;
 	u8	time_stamp;
-	struct point_coord point_coord[MAX_SUPPORTED_FINGER_NUM];
+	/* raw per-contact bytes, parsed at the chip's coord_stride (max 8) */
+	u8	coords[MAX_SUPPORTED_FINGER_NUM * 8];
 };
 
 struct bt541_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
+	const struct zinitix_chip_data *chip;
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
 	u32 zinitix_mode;
@@ -444,6 +465,8 @@
 {
 	struct bt541_ts_data *bt541 = bt541_handler;
 	struct i2c_client *client = bt541->client;
+	unsigned int stride = bt541->chip ? bt541->chip->coord_stride : 8;
+	bool finger_count = bt541->chip ? bt541->chip->finger_count : false;
 	struct touch_event touch_event;
 	unsigned long finger_mask;
 	__le16 icon_events;
@@ -452,8 +475,11 @@
 
 	memset(&touch_event, 0, sizeof(struct touch_event));
 
+	/* header (status, finger_mask, time_stamp) + one stride per contact */
 	error = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
-				  &touch_event, sizeof(struct touch_event));
+				  &touch_event,
+				  offsetof(struct touch_event, coords) +
+					  MAX_SUPPORTED_FINGER_NUM * stride);
 	if (error) {
 		dev_err(&client->dev, "Failed to read in touchpoint struct\n");
 		goto out;
@@ -470,13 +496,31 @@
 		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
 	}
 
-	finger_mask = touch_event.finger_mask;
-	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
-		const struct point_coord *p = &touch_event.point_coord[i];
-
-		/* Only process contacts that are actually reported */
-		if (p->sub_status & SUB_BIT_EXIST)
-			zinitix_report_finger(bt541, i, p);
+	if (finger_count) {
+		/*
+		 * On this firmware byte[2] is a finger COUNT, not a bitmask: a
+		 * 2-finger report carries 0x02, so for_each_set_bit() would look
+		 * only at slot 1 and silently drop slot 0. The chip marks every
+		 * populated contact with SUB_BIT_EXIST, so iterate all slots and
+		 * report the present ones.
+		 */
+		for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
+			const struct point_coord *p =
+				(const struct point_coord *)&touch_event.coords[i * stride];
+
+			if (p->sub_status & SUB_BIT_EXIST)
+				zinitix_report_finger(bt541, i, p);
+		}
+	} else {
+		/* default: byte[2] is a per-finger bitmask */
+		finger_mask = touch_event.finger_mask;
+		for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
+			const struct point_coord *p =
+				(const struct point_coord *)&touch_event.coords[i * stride];
+
+			if (p->sub_status & SUB_BIT_EXIST)
+				zinitix_report_finger(bt541, i, p);
+		}
 	}
 
 	input_mt_sync_frame(bt541->input_dev);
@@ -627,6 +671,7 @@
 		return -ENOMEM;
 
 	bt541->client = client;
+	bt541->chip = device_get_match_data(&client->dev);
 	i2c_set_clientdata(client, bt541);
 
 	error = zinitix_init_regulators(bt541);
@@ -741,7 +786,7 @@
 	{ .compatible = "zinitix,bt431" },
 	{ .compatible = "zinitix,bt432" },
 	{ .compatible = "zinitix,bt531" },
-	{ .compatible = "zinitix,bt532" },
+	{ .compatible = "zinitix,bt532", .data = &zinitix_bt532_data },
 	{ .compatible = "zinitix,bt538" },
 	{ .compatible = "zinitix,bt541" },
 	{ .compatible = "zinitix,bt548" },
