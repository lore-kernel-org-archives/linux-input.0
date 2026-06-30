Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893263C2B92
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840581; cv=none; b=lc/KxUnD14wck2lrVzMACg1ANVCvnj37lipjlzXhncbLqvRo3S38izscfbLISLEWtkLzBCo4TtVKu/o8iXjP09LFH8TcaDBTsFgUomVC5qibD4RDxtdavUgQt3C2OZTRk8vj75RGNNzt3gfASiv6tqBwjweiSuTuxMNgdXwG13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840581; c=relaxed/simple;
	bh=G806QbV/ZYx86cpxSf4S/CG6nWQGqpe5b92lmMemBHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL9vgdijHMxjK24ikHG+yPRc5Nh3EH1mwM9CUWiLeGewpb7Ze660Q+dJVGTMtyHNgTt4M2B6GssWkC0KdoEQpYUXjekErYX4MUZFuNNYSg/uii/B5qhRDjczzf3gAD2GcOSkouzFwxPoAHicY1v6s3M1gVVdyRaCSbnfPUHe8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNM58W2M; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNM58W2M"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ee88fce572so33016276d6.1
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840580; x=1783445380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oHQXEOFG3YOYq+LCQTZ0I7k3GN8EZK7/Y6BCkSFL3Y=;
        b=FNM58W2MQ5lHjvNKQyZmDGq7TlW2g/fZc/7q3hFEvRnmiIndVYJdsCF6FcC/HI5ZnI
         yZiBI7bP/fccYRYUUmwURrocQl4f25u3NbB7uHNOlz9Mx7wr+YnlsPxqDqFhJCAiD11d
         TfpEleIqjwAQwFuNyA18A2XmRyd8dBkbD6Bhk2eeOdbJM+81MK7AFnVTaLcfDQozFqmD
         i+cQV6SPN9E1OLIzIVAoucKaze2BlAkBAM+SIThdJd0136oZYh7b6ApdKlo22OR7TiDm
         Gp6BjmefpJudbEhxb8wfCZP86uA8gNq4m0kmZwAu/r7h+KPgEVrCGTndPt5eaVR3IfsM
         XZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840580; x=1783445380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/oHQXEOFG3YOYq+LCQTZ0I7k3GN8EZK7/Y6BCkSFL3Y=;
        b=R6PrANtcksa8JSJmbFoz6WNB5fJASzZ60adn+HhjvLJz0eb8LOntrFD5Zp0gMihnYo
         LR4ofy4r7Igb28ndeQTU0px9b0zNSJXX0UpeUOBvrqbhnzyNUEuIoXIkPw4aXFrM7yFv
         z3O8LKXpy74CfpGNmke89yLmpdE/4gp6zkEZdgLjWkRV/FX7LoVBFD7fIU+9x8islGHp
         HRFVGm/8C6gFsD/hkkIX+xECqKpzHXqgsKww5DkFtkb+SqH/i6GuiUkfxpNd5ZRLAtZK
         kLpwnwa1oH4oS9I9y3ndsV6gKAAVLSI1UxyJaI4xz4SyRSIK750jgQACZP2dD5Bs6arn
         sGHw==
X-Gm-Message-State: AOJu0YyWoLaRcgYLNC00vjIurOhn6wjmcbgsD8i+sBLIP1yIOhDwizPJ
	e7QTHjnZ2p/WrFs9+o/A74S7bbPLK4GRgOyUI8DPrm03zF2vBUQBTwLX
X-Gm-Gg: AfdE7clCGa8y9Gs+yBFDnVsMuLx1NrUZUebL/ebIMP2nNsOtOaWA5VM8t/ZaiWXSu4P
	dP9wI9bzufrQJYf60eYL4ldcTVENZUbQdttfOq4bxrTv0eMTp4ll9aq9YFYfF3UZA6bCEUIrzaW
	i498S1IgKkPCV1BcsTrb2l0x0aWBqbph+hAb/wMyj31/j5Qm3zPAx3HGv7EceVmyYdy78kD/psq
	I2Ynh4AH1nklgz0NX0OSRcsci8UzrFAPgYxgTxIPrryGBgDk3/ERX1/xisbbes5dkTKCdsOgK1r
	6ffjljayJ2lHkOXJYWAdIp9C25fnfDHoWrPz5a9wIsj8P3gPBWv4Xo9cVObz5VG/ISYTds2QOlp
	AnWsaZk+GnFdPQJlNPE/Oj2ti7O0Q+UoO1qLYPuZRs+QBr6Ea1w+vd1pwCuuCMhv40KeRXxaj+G
	dWBFwCPfYhijQFfvZvPEsrBBk84VyUHjcMottn8L61k6aH8+67
X-Received: by 2002:ad4:4711:0:b0:8e9:f5de:d628 with SMTP id 6a1803df08f44-8f1bcb511a0mr53103156d6.55.1782840579608;
        Tue, 30 Jun 2026 10:29:39 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:39 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 1/9] HID: steelseries: Fix ARCTIS_1_X device mislabeling
Date: Tue, 30 Jun 2026 13:29:22 -0400
Message-ID: <7269dc6e0de511a1e89ae4a1296c7f957890f52e.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
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

