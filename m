Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDF38A733
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235394; cv=none; b=IORog7qOpjz8wrZhjW2EMxGM0FGvlUFo6ykMxxT4HkosOIYN0t/E3bmj1+VMqpVURq9xOuGk/fho7EgFzDVjsFlEKNFV6gwkrs6ZpfiwmvAK0h1FFBZfqNkOzOJbIveEstevH0avgYUP+S94NLNQewHrFgt/oVcGpg0o8Ijl50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235394; c=relaxed/simple;
	bh=G806QbV/ZYx86cpxSf4S/CG6nWQGqpe5b92lmMemBHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrH6aWys/y5YEcmiAB1hbZ8rD+z7emx6RVMvLXgPVAXEb1OrAcVL5X2OOObU6mZQdTz1BJQM45qC1c5Nlyhfkep/7u/1HdyrJ2lAzfMYvq9F6bOYtRpKJL4vrHWnM8zvNqJO2DbwfxeMbSdVZofgcFewSRWGx0Ws6wb4NR9NPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJyBy4bv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJyBy4bv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-519f6a10d9bso95431cf.3
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235393; x=1782840193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oHQXEOFG3YOYq+LCQTZ0I7k3GN8EZK7/Y6BCkSFL3Y=;
        b=FJyBy4bvudw6O0Gn2LLPkzR6p3b4ZJLpF1jiruuLR3QuqjJw6QEDqyw58x/zri6OUy
         ND+jbwb9Whd8kaA6U6gO7+BzgCzqJTEmYss35V+aiM+RLy9DUkXXN+o8LQOSb3YAAKYP
         sJ11TwHKBCzWQMoVFfuGD36AFjxnRB8J8qn2Ymr/6ggoF8YWgGk1jQdx0z8EgxUZRwC3
         FpvFRUS2RjZeGCG1oI8cNXa+0N3ucX4QVb1q1+HCioPuLH0fHBm6yeFbWKbXTGtxn4H7
         Xk5mpCcuiq46CNEQ6HpGlhn+/mFjySSMemnbEDoXRexuWan5nFwacVcQ3S4uVku0s+G2
         wivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235393; x=1782840193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oHQXEOFG3YOYq+LCQTZ0I7k3GN8EZK7/Y6BCkSFL3Y=;
        b=kuxC17OtP+/9PJRXXh6o+SmA5c5PAE2EgStWAORSpgy7l8/F++AbXaMjPeSNrW/XxX
         ToQj4FPSbHNCt1AhiEA0FP/HUL5H8wTP+zwrKG+KaEnSMGHP2k5stPqshTZ61yB+/Kpd
         Z81aeOfx1yzFMroGQYFc7l0d7iL3478esPBRBKSH/n38yQvV6Oq6sTqqgVa8ctCfn8B5
         jdn4FtXvuQBCXfGOneUP6BsQMG2c1pXCpvgeMHfglDKcyBdkbEpEBnWIO22Aj5xHMefq
         73Ibu8Nql7UnzGZv1rVLJiFU3imYPQZvlijaI6Bh9sla4tCRLw0+lJRggmPONTU0MWQU
         NCuQ==
X-Gm-Message-State: AOJu0YxbxJ8nE6mqxy3IL/xGNW5slYQ9ooKV34Y6cP8ivF7KHCcE60Kl
	eBdruT7o0ckcfIxyLNUA9MWudxtnpcXf1B/hx9YT/sZbMYW1JUEcCocx
X-Gm-Gg: AfdE7cktShhWHH8ZWEb04YjLgHBa/NpNrS9YN0Ri7t1LD/Rb8aD7IaFbX/HSBFZAjwz
	YVEOMC7S1YUG3LakBOCJ6ER0tkzEQ4xg+MAa46Y0sORHy/4dkg11tWp6/tgr9NHn9kqwcrrZfag
	yiUU9Fp3uZeW1JqZSs8yumA11cdtqe3lrmgqQ8A59J0H2IzVfZ0+aYQqxiPEWg+RKcCMFFsn/In
	t83i8yb5QaRs2EWIWQVCx0rDGJYeKQUlfpKYGus6wHLxYWm2M/TZ6tWt1TBPfSjr8B8VdSL5Fdw
	g9uLYB69elfsWD3TDzbbaKukQ3NCj0Eg/Mu/6hcEyLQhM5DIOvsGkCIVgbKV3R1VVuKbjkhC4zI
	MoXQzP08shOnNEgsCEIy6dLIh5LzsC0ZyOKKLmuC/xvBftscetSbROxCxuhjGiA0LM0/pwTiSTT
	ao85dViWhdByLyEx1fOyDIcepEGhlo1ZOMiKZt4kcKhzpC3rFs
X-Received: by 2002:a05:622a:40cc:b0:516:df59:32cf with SMTP id d75a77b69052e-519e4905cd7mr296133481cf.7.1782235392368;
        Tue, 23 Jun 2026 10:23:12 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:11 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 01/10] HID: steelseries: Fix ARCTIS_1_X device mislabeling
Date: Tue, 23 Jun 2026 13:23:01 -0400
Message-ID: <20260623172310.272708-2-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SteelSeries Arctis 1 Wireless for Xbox (0x12b6) was labelled as the
plain Arctis 1 Wireless. Rename USB_DEVICE_ID_STEELSERIES_ARCTIS_1 to
USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X, along with the matching quirk flag
and device table entry. The device ID value is unchanged.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-ids.h         |  4 ++--
 drivers/hid/hid-quirks.c      |  2 +-
 drivers/hid/hid-steelseries.c | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..915e936cbf8b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1377,8 +1377,8 @@
 
 #define USB_VENDOR_ID_STEELSERIES	0x1038
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1  0x12b6
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9  0x12c2
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X	0x12b6
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9	0x12c2
 
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 57d8efdd9b89..f546179858c2 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -747,7 +747,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_STEELSERIES)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SUNPLUS)
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index f98435631aa1..fd38ee3ea6fc 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -18,7 +18,7 @@
 #include "hid-ids.h"
 
 #define STEELSERIES_SRWS1		BIT(0)
-#define STEELSERIES_ARCTIS_1		BIT(1)
+#define STEELSERIES_ARCTIS_1_X		BIT(1)
 #define STEELSERIES_ARCTIS_9		BIT(2)
 
 struct steelseries_device {
@@ -374,7 +374,7 @@ static void steelseries_headset_fetch_battery(struct hid_device *hdev)
 {
 	int ret = 0;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1)
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X)
 		ret = steelseries_headset_request_battery(hdev,
 			arctis_1_battery_request, sizeof(arctis_1_battery_request));
 	else if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
@@ -638,7 +638,7 @@ static int steelseries_headset_raw_event(struct hid_device *hdev,
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
 		return 0;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1) {
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
 		hid_dbg(sd->hdev,
 			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
 		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
@@ -725,8 +725,8 @@ static const struct hid_device_id steelseries_devices[] = {
 	  .driver_data = STEELSERIES_SRWS1 },
 
 	{ /* SteelSeries Arctis 1 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1),
-	  .driver_data = STEELSERIES_ARCTIS_1 },
+	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
+	  .driver_data = STEELSERIES_ARCTIS_1_X },
 
 	{ /* SteelSeries Arctis 9 Wireless for XBox */
 	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
-- 
2.54.0

