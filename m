Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB21C5499
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780188; cv=none; b=NP19R0mNePnjXnhGxBRULN3yAe84kV3aCnGEm38WgD2GSxvmny+stlFB5D2qRq8gLnHHeqzz4s2ts7opKUfFasiIDjbG6svjSWbn6Ec/CiEPxkBCuG2wfy6Ld1PszMm7vwlJlUK9ZE5nod9DDyPxuUT/X8ukH1rP29CnbqDkcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780188; c=relaxed/simple;
	bh=z99q+4jS1qUXEL6QiDspninof00PQ76INtiJ8XzQErA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDbxKUbrE4BuUiCCypCvaLju/K7ZEfBUy67LcAfHNEj7VlsCkfSM0KtvPSle9CWR25XdmTVuRxYj7aF3LfRMJvu0+OyMIRgSqpTwmCIg2Cfmm05lbO3P6xYRoRdMXC7OntJsoWXJwzBebBX262l196gp2LdNjZkzLlUJGHR0MR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI+wfI7J; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI+wfI7J"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso20008835e9.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782780186; x=1783384986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EU/r7lx6aT8TqQKRkjOJMDGUCG2zOVOTTvJBrER2oM=;
        b=SI+wfI7JASa6HrZygwYdZH98jvnkmfI6kz84RxiFMxdJ3ib0vM4KAMC6BvFi8uNySt
         6DO8Y1zAR4YnMFh7zQaxyRbtfNMZ1O7B9n6ny9ANZ/wdoKQTePYWj6d2PWDDSn8rk3iI
         tSya6coVpMdHreA3gdttMLoH3t2gxXmm9m2uiED37KR/prQiECf0QQS2jNsFY1IRCwzn
         7HRONz11BqZ7f3B25rrh4LyEZln3BeWiI3mn+HFu3YxnZTCkN/C8+A6Ga3XoHpwJf/8x
         wGNJaGbvCjdM4I2oGcyL37aXhJc3UY40r10SeWdR9pAWnmM/pgolSWjriCVD4BdDZ+Vb
         QA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782780186; x=1783384986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EU/r7lx6aT8TqQKRkjOJMDGUCG2zOVOTTvJBrER2oM=;
        b=UiAqMsJ24+VQpPi84TIFJxYCBjgT2eO7zZUhzoJzwnWnY78KMerdceZbsbxyzmyFER
         Yo+WeEYdjWdnjLZWzn00p7Mg8vZIr+TcAENns+7HRtBiaHF1qFg7MhY7OnEZtz6kRKhy
         5gM+Pp6HYF07OgHTWego54LtmiqSuwYKCDzEWGSasRqYU/Tq1XlGGBfWvQmBfGWV6AAF
         QlXT8Oe9HLHIo7W2Q3pIbObvW8p1LEEEIERINA28B3POgLAj9OTl3kDGMhzA2YArmkMj
         mDh/u3rFVk05hX3GyvOYVNgVxLd2RHIT6xOBP47FJh42nIpWDLaUNH4IogXyg46Cgd57
         T7Fg==
X-Gm-Message-State: AOJu0YyT6M3XAdf6VeGwPEGslE8Tg+y4YwkcbDvNx9SYBT9ZsivAKI6N
	X6pacNVLWWnOMObTMIaLbrqAPKpO4QV7A1RuXxoUnwxgUJqq1dhBnjd5KELVOW+azk0=
X-Gm-Gg: AfdE7ckESnm1aauuiDlfi3Eu8dFJw7i7Kjb+C2XYADWriHCLOKCiMMEh6Dza9cM9ZW0
	EWKwW/Fp3Yi8nfKoKXVaqaBANKKSIaAq7i12QQ2h9xEFwXHhGSqwwCPL4phCXfXw2+8BjCBs2B0
	oC8+Qfn3xtXv2H/IW4ALaGiNyucH5Wv+8IfcG380Sm0RGHBcvOr0cs1GLNkWNfEBY2g7iNdFbUW
	Hqb1A/K3prXpACkN2y09fyV3RVxvbosgLZJLI3bWWW37Nf4eYulM6WyuOwCRTdTMIa3WI6LK3jy
	Z4Z8BgRuXELkm1CbhDritBCq2pAg7fcUq8YXFf5UkHndG0ZeWs5wFRqPM/NcWN02COopGGb0G6j
	HZ+mqJEAYh0junPi5h7c8HxU/r5sPTHpIJ/W/XLfjIezu6vSkNxJaMlpUAkK2QQLFyl5+2XvqRV
	o0jfLkJFQCrvjtNifDkMVMhQjVu8VANLpptb7iK0XXrCmB6yoeWdATXsae2OaHZXt1QyVEgIJc1
	SLt3YEJwGu+
X-Received: by 2002:a05:600c:46c9:b0:493:b24e:649b with SMTP id 5b1f17b1804b1-493b827c8ccmr25844095e9.6.1782780185616;
        Mon, 29 Jun 2026 17:43:05 -0700 (PDT)
Received: from snakeroot ([2a05:87c3:2001:7400:25e9:cccc:54ef:5829])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cb0896sm29909195e9.13.2026.06.29.17.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 17:43:05 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-input@vger.kernel.org
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] HID: corsair-void: Check size of status and firmware events before reading them
Date: Tue, 30 Jun 2026 01:40:01 +0100
Message-ID: <20260630004003.579171-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malformed status and firmware events could cause an out-of-bounds read since
the size wasn't being checked. Check the size and warn on unexpected values to
avoid this.

Fixes: 6ea2a6fd3872 ("HID: corsair-void: Add Corsair Void headset family driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-corsair-void.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index 5e9a5b8f7f16..fdcc4b8cd272 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -92,6 +92,9 @@
 #define CORSAIR_VOID_STATUS_REPORT_ID		0x64
 #define CORSAIR_VOID_FIRMWARE_REPORT_ID		0x66
 
+#define CORSAIR_VOID_STATUS_REPORT_SIZE		5
+#define CORSAIR_VOID_FIRMWARE_REPORT_SIZE	5
+
 #define CORSAIR_VOID_USB_SIDETONE_REQUEST	0x1
 #define CORSAIR_VOID_USB_SIDETONE_REQUEST_TYPE	0x21
 #define CORSAIR_VOID_USB_SIDETONE_VALUE		0x200
@@ -742,6 +745,11 @@ static int corsair_void_raw_event(struct hid_device *hid_dev,
 
 	/* Description of packets are documented at the top of this file */
 	if (hid_report->id == CORSAIR_VOID_STATUS_REPORT_ID) {
+		if (size != CORSAIR_VOID_STATUS_REPORT_SIZE) {
+			hid_warn(hid_dev, "unexpected status report of size %d", size);
+			return 1;
+		}
+
 		drvdata->mic_up = FIELD_GET(CORSAIR_VOID_MIC_MASK, data[2]);
 		drvdata->connected = (data[3] == CORSAIR_VOID_WIRELESS_CONNECTED) ||
 				     drvdata->is_wired;
@@ -750,6 +758,11 @@ static int corsair_void_raw_event(struct hid_device *hid_dev,
 					      FIELD_GET(CORSAIR_VOID_CAPACITY_MASK, data[2]),
 					      data[3], data[4]);
 	} else if (hid_report->id == CORSAIR_VOID_FIRMWARE_REPORT_ID) {
+		if (size != CORSAIR_VOID_FIRMWARE_REPORT_SIZE) {
+			hid_warn(hid_dev, "unexpected firmware report of size %d", size);
+			return 1;
+		}
+
 		drvdata->fw_receiver_major = data[1];
 		drvdata->fw_receiver_minor = data[2];
 		drvdata->fw_headset_major = data[3];
-- 
2.53.0

