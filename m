Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B62331ED2
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567423; cv=none; b=SUFDZsF3xl9prn0Gr3NGtp4GdEIgSbUborR4i20v4ow6nLuJawSmt6aGJqeAIbuUIPSksX4D01ZP0968hVxq0z1H67XQqdfpih7gdv8fDLrAEK8TzjE2QX9FWW0ONm9vpdwTovG2lhbdfn6KdrrWZoJVEEzKOtsXrIVkiX2lanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567423; c=relaxed/simple;
	bh=WQNwgjQgqLh614zgEQd5dYud9CIecwJNHMP14YesoSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nshu433qTO0MnoPKUm4lZ9V6ZcUbVBL2VdLo253DFzUDYTTqat3Dqm45WudUjW62HgNxr0ozj7q949+NsPSb0CHKZMpv9JURWd/AJYS7N7hQJ8rjHQ/IK5uUDfJXXeETYUQLmCbEiK6ucg9WX5TYK7qzwlcBCWMgfPkZntShc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXkVuC+C; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXkVuC+C"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e99ef0902so21663685a.2
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567421; x=1784172221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IESag8wrXP/IknbrY2Nqri6wopkQJC3RSm7mIQIUGUE=;
        b=OXkVuC+CIqeqm/QHyUA5yVLRBbVoDHmz4E+gMQ74P3xIXUKSN+d+WBx8U1fh4NsnCt
         253WyK3cfic16B4lhZR9+gnHKajK/Szuzq4L2A/v0JF3j2rAYOTxHzC5Cwme8nOPhwit
         0HoD49V3yJKTbgSiUk14UnGGIbzeoLgUVXaeeUSNfZ1P/9jU5BXY1F+2olNtoFBl5wKQ
         /j77KsPBvrfHMIfI3WPsGq8X32gm6Bketbq3SjMfl/DxFqyNcj3OxO4M9OVTBsMUmcRN
         V661KJ9NR2+T2qUCqTKXStl/YXtHhtt6BOc4TXCGR80VrsBl6kvmp8r125A/P1mY51YZ
         8LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567421; x=1784172221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IESag8wrXP/IknbrY2Nqri6wopkQJC3RSm7mIQIUGUE=;
        b=Vx3S4P+iF+0zh2RO36QQa95Uv3d2LFkZ925aHz3RHgCE2VT7BmYqZyBkYhSbX5eX3g
         Pu0w43S5X0Aq55y3zl6PznxOdUKsWzHOONJZRzkcjPxEPiv8pSD/j8rgIAtFAPGP94Q8
         IEejfGnOChVAxYzghHc1c+QqKtxCtMhvHqwzeKDqhabYZh8xvy2mDR8RM5UCMr9ux+Za
         QUE0/wrfKQpdnVnemDkf5bwPOBCvkgiYq4GheBYInrIOFsSBIcvwntxMWr9XVA6sMsag
         EWYJrjNjtLkRPD8p52hVd0E0OFALeBgfbUEdULUO9dLuqvcgCLWxjjAKKIL+y6VG8Npc
         58yw==
X-Gm-Message-State: AOJu0Yw7d447pkxv0Yc2P0I0tvUqU5EcXtEagQBeE+1xmDFCWyjyEAmm
	Nq5kAKe+iFpucNm+J11IheYg0ggQ3qX2iASKtx4m9ao//nasDzoDHrRH
X-Gm-Gg: AfdE7cnFKWo6Blws2ADHtv5BMavKtIpjuK+txNMfFx5P50PfloGVP3klLyRspImDW/k
	fd695fq4ERD/NC0DGcKtoQr8dhu08B4KtYa+IrSj0dvNoDWQgoHATUjib8ox2T4i9xbwM6fEoEm
	ocdQdbeLAYRc03nLPP36OSMndsvDoe8CcH+ovN9MKvBzBDmo1hLVmPfjKpv5R3M3SW7cIAZwynj
	1iloEB8D/FFy8GwosVsnI/a3RiHEqoMiaiFlqUveJLrVfZyZI14CDq8gXOhhIrVTlwxmjMpApYW
	WjdkHDJAH85yRorx0l7LQ3RQLbwp7l8/v38zB9WCUP2JDiMo/Xmwy0zRPjtTeoCLMRhqIF8Xe2/
	Rqt3N9Si4Oivxv9S+GptkQjA4LRsQYEKmO1lvg0fAIOziO1yaW0JoWTDgjmnm+g/vlOcpntv1Oz
	yGnUq3f9uFKPkMX49wGzye02HAm3b3fPmOlNmI+dqfCdwNk31pHhhZv1lpX1ONTn/wFEWQMAclO
	9fg2fKy
X-Received: by 2002:a05:620a:29c2:b0:92e:45e0:2588 with SMTP id af79cd13be357-92ecf5dc66emr563233785a.55.1783567421167;
        Wed, 08 Jul 2026 20:23:41 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:40 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 1/9] HID: steelseries: Fix ARCTIS_1_X device mislabeling
Date: Wed,  8 Jul 2026 23:23:08 -0400
Message-ID: <20260709032316.1908460-2-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

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
2.55.0

