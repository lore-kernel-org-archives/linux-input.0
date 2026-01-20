Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355C3A1CEA
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939330; cv=none; b=OGCBWAdg+8jVfeaA5UvZMrcjSyBUQOKGHVqIxJXXjJYatD9hJyDIOi3dhoEimd5lCcSmBJzZmMTeCMVqBQIczC1sqpYNVB3VWAOr8iiZClrONoKSBxfRN6emSdWCVp1L62WIQXAvmbcqxPR91OwM4soJ3StRrujTJyqr+vUeyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939330; c=relaxed/simple;
	bh=6MEVPmY+/4uufPcJ2T8jNc5x6LCDzPCUZ1cUQcoT9mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv806AobagCtY995RW5F7GlkBbCnBN9hbhP3Flhb3nTS6OmHCTlWT7sxQ6HM90QHRWFE+nIvstdpXWyGWKwyoi5q09ptemHhbWpgWXiKZyDQW/ponywrBbg/aJaIY8qK9lHcVp4G4JprqQxV0dcMR1FXpgsns6h7leFND7NuJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SThdaPJs; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SThdaPJs"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5eea75115ceso126519137.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939326; x=1769544126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sAyltQ9Ju5LJsjrxN+RFppegkQgHbMR0ZkUv+EPidQ=;
        b=SThdaPJszRpKCEegJr78IL91zuLxSA2L86WqdHUDzjjfWPxkrNxLzEEXEXioP2iNO0
         HKFpWdW8DKMzXaITpxfA6qwdNUQc9hk1+mH+Ss+19+5T2VoJ6IwrcKr7JBCJJGNqto9J
         wvYnN4EF7WAphpnIh+bsRp5SsnrY16ZKGUhh0GgrDjlHbVjZVvTy3kkAqPrFdVgFeZHn
         r4ljjhYpmQyQ8slKmnRTuT2N/xnPPuQ+v8/jz5zyhIQCBGL1GDcl3YTO/bw0S6aDFfei
         oMguctXgkUHeEyiaK1KU7+PirAHUmpGDgmK+dhVOgx6+lOjjcxJTYKTsDIq9Nde+hLf9
         0QQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939326; x=1769544126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6sAyltQ9Ju5LJsjrxN+RFppegkQgHbMR0ZkUv+EPidQ=;
        b=nXradC7QGLbMiHqZ57bckGKXCN6eY5jKNSD1Plu2izsxZ6jQ9gH5Y4VEe5wH7BRf0Q
         QBC/TUNNtrHkJGcJZntoXa6WuC1+QG6Ob2BnsxEVUg/5TsQc1P6HOL/+cLS9hAHrvXri
         VDx8jvLb7krV0PF4xhLoRqONLqt/PLBUU3DSRmxaNSx5DBxx87owTXHrNiOj1NACtLlb
         dqltOtrRVxiXknp5lBpgkQSCqEQywu5Lrv/aI+SKOHLjuQq8TlAB8AawDQGl0Z6Ev1/6
         rGL4YJS9Rece+NdJIn5NuxPpHCLGVWIETLw7QmUIK/yeFOH6nn6G3WVu0BV2Hh/SqmzG
         Xk2A==
X-Forwarded-Encrypted: i=1; AJvYcCWXFghCdlJEiGbR/2ayI2ac5du/7SsulGkMoRNB6hTWrsKxoLWPgr0wE2iII51oThh4MIhYmVYbqnTaxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRukdc3vHXgzujucqzeUJYea4Qkr4a9pBnysKq02Ewz7KpcsD
	isHtdsoERZIILPWYFc3YiGy5evXIboLbqmbfQkGCX57uKkjm3V60D5+6
X-Gm-Gg: AZuq6aJHLwVER/C5nniJOCDbpOqNy+vWo8ygJ0fx1N1MUz7OlTxoAVu4iWIHJDHDUJS
	qq5pKpVk1V1S+hM5VS3wNoxb1xRdS7swCGo1m9OsansggUBxCKdhG57YSh7MkRZTZiEloT9rJJW
	js25Q7GuDHwaHsAwnx0Kr4tEWAK572NUxRitDYXeOr+unbcGCu6KRhuP880SrJCjDzrQFEt/SbU
	j2owsnd6KJToAVajgxuiB/ryBvpnwYOjEo9U+Lmx19JVSfLYrIIxdheKFy25OSjSaiAHkFQ7nUJ
	E4cb/iaqy93BEp7HyIB22dM0MVifYPslZzBzFThge1GkceMgxjnHXccGeu/oZQXYUOOcLjLIxuA
	SL7LVy80yHggLVuqcdoy7Hm8CgkBnN5IOk5B1AXb8qNZ6WcfhNd+0UUBKMB52Qal+zX63vX5M2T
	I3f4G4nFJ+PSHY9Fr2H3WcH3/edjXWt8FsFPEY8n9Sg56CwsIdSFm3AziiRsMpo4oNlceqrQ==
X-Received: by 2002:a05:6102:3a07:b0:5ef:a312:e70c with SMTP id ada2fe7eead31-5f1a55d2200mr6149316137.20.1768939325072;
        Tue, 20 Jan 2026 12:02:05 -0800 (PST)
Received: from benjamin-desktop-fedora.mynetworksettings.com ([141.154.77.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7298472sm1112863585a.53.2026.01.20.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:02:04 -0800 (PST)
From: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
To: srimanachanta@gmail.com
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] HID: steelseries: Clean up hid send_report functions
Date: Tue, 20 Jan 2026 15:02:00 -0500
Message-ID: <20260120200202.1225216-2-benjaminwheeler0510@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120200202.1225216-1-benjaminwheeler0510@gmail.com>
References: <20260112041941.40531-1-srimanachanta@gmail.com>
 <20260120200202.1225216-1-benjaminwheeler0510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions do the same thing, so combine them into one with a
parameter.
Use helper functions to keep callsites the same.

Signed-off-by: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
---
 drivers/hid/hid-steelseries.c | 45 ++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index a0046fbc830b..63b086fa6df0 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -829,9 +829,13 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	return 0;
 }
 
-/* Helper function to send feature reports */
-static int steelseries_send_feature_report(struct hid_device *hdev,
-					   const u8 *data, size_t len)
+/**
+ * Send an hid report to the device.
+ * Supported types are output reports and feature reports.
+ */
+static int __steelseries_send_report(struct hid_device *const hdev,
+				     const u8 *const data, const size_t len,
+				     const enum hid_report_type type)
 {
 	u8 *buf;
 	int ret;
@@ -840,8 +844,9 @@ static int steelseries_send_feature_report(struct hid_device *hdev,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(hdev, data[0], buf, len, HID_FEATURE_REPORT,
+	ret = hid_hw_raw_request(hdev, data[0], buf, len, type,
 				 HID_REQ_SET_REPORT);
+
 	kfree(buf);
 
 	if (ret < 0)
@@ -852,28 +857,19 @@ static int steelseries_send_feature_report(struct hid_device *hdev,
 	return 0;
 }
 
-/* Helper function to send output reports */
-static int steelseries_send_output_report(struct hid_device *hdev,
-					  const u8 *data, size_t len)
+static inline int steelseries_send_feature_report(struct hid_device *const hdev,
+						  const u8 *const data,
+						  const size_t len)
 {
-	u8 *buf;
-	int ret;
-
-	buf = kmemdup(data, len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	/* Use raw_request with OUTPUT_REPORT type for devices without Interrupt OUT */
-	ret = hid_hw_raw_request(hdev, data[0], buf, len, HID_OUTPUT_REPORT,
-				 HID_REQ_SET_REPORT);
-	kfree(buf);
-
-	if (ret < 0)
-		return ret;
-	if (ret < len)
-		return -EIO;
+	return __steelseries_send_report(hdev, data, len, HID_FEATURE_REPORT);
+}
 
-	return 0;
+static inline int steelseries_send_output_report(struct hid_device *const hdev,
+						 const u8 *const data,
+						 const size_t len)
+{
+	// NOTE: Output report (HID_OUTPUT_REPORT) is for devices without Interrupt OUT
+	return __steelseries_send_report(hdev, data, len, HID_OUTPUT_REPORT);
 }
 
 /* Sidetone level attribute */
@@ -2170,3 +2166,4 @@ MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
 MODULE_AUTHOR("Simon Wood <simon@mungewell.org>");
 MODULE_AUTHOR("Christian Mayer <git@mayer-bgk.de>");
 MODULE_AUTHOR("Sriman Achanta <srimanachanta@gmail.com>");
+MODULE_AUTHOR("Benjamin Wheeler <benjaminwheeler0510@gmail.com>");
-- 
2.52.0

