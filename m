Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90817331A7B
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785011742; cv=none; b=aPVFhnxiSHSxHRU3ZIlvNredb6XErWh0+Hna0lOCxS6KkAGDw8HG3mfOxH1aZOVKpK8vKBDbIZz04gGEvxE2W+Pgt3uQeHU3QkxTwM6p/XTjVXyke1V4CC6V+MEIE213ceC9uAdCuBLvGm+GBOKx/muHsf0+tgHUy+a3xDwVOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785011742; c=relaxed/simple;
	bh=JI/1p4HiUb1gV1m1gIBwh7JAsAjpmArIYKEU5U/bgvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkmDtV8XVR6rUa5awaw8oOabWyN3uI9S1XlctrYmD1Smr3b1n1/h391jsAIE1ftJ2wJnJCILPjD1UrOPcJDA8yVaX8k25hrDX+QVA56EUT005iWTX+IVE72doY9MPd5B8Pweorv2j50XMJw2F+yrH6suUtUGMT4OJdNiy9FOwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGcN6Oiu; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGcN6Oiu"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e67555e24so94455685a.3
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785011740; x=1785616540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2iGM0CeFJssdANSG6zo2+MACo+ipwveei6/ZK3TugU=;
        b=oGcN6OiuHYRMKiFYCc3AhzSNDUb1p8NAS3j+3gwNo0QX0Dk/VRhfIr3B/xbvZHWn/G
         GgSCQTf+vyRvDCXAuQK0HyH4gHgFu+Rz4KVzERspAtDct9bV1SUi2DaqaQY/lMlRJ6Mv
         d2MkIi+pB5lPMZDguJVu5gydCm5a5WtRTmjeeVJyAfiYstpGdvwLeWqtoBa0ApzAmSpG
         rs63Vy/x6cUyvYBejzMa54TdXhZqrJRYCzr+bA7vIUsVz3t2OjvzIXZ/+319mCmYCGtA
         X1EoRiCWnHakrhu2jZagk0SFung9PUKMmze27bwDJFsMfz0W565yhxsMd5bQoeufZVkc
         +0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785011740; x=1785616540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2iGM0CeFJssdANSG6zo2+MACo+ipwveei6/ZK3TugU=;
        b=A52WbVouWEmb7//0z/xUnJ57Kb80NIm7AmYTHHKjVlNjgI0p2rqjSgopdCCkqi7NBs
         rSZ/+/7w83ATSpQw77Kdq16IkiX2kpjLxb8uGFIwzyeFabYShDczGCnZEYBiLEyOCAiH
         uAeYBjUeK9nuqjVoJYQDfqZcHJUgkEWJ/BO3yWTT+qfkbhK2+PymM5Uav/lNUAZsAC5a
         WNBrYMtDYto13f8HfLBAOjsMH3n7c6a+NWAja/LKw6VL2lll4TMAbyJg+6GRnonhBide
         Yw1hlzBpTkUSv6/vuW84eyIkNaPP6keI0XcqwngC+MVBlI/bt/Ki8vkBS1SKzUqGbe2o
         vaWQ==
X-Gm-Message-State: AOJu0Yy2rQ9Gx67PffNMZ/8QKyN1Rb7vmVrlzZtwgjKDZGNg2UwhDk/Z
	pV3O9N6J8RaimCp14ZFKgd9sUXH//FWNLxEXCy/M52jJ9/CeT2e+rOUG
X-Gm-Gg: AR+sD124930U6iWUDOvMDhae4UnA/FL60A6H9hFjKElYkmllClVj7xwF3KRPf64guUJ
	P74ks24ZkDvTzcjBFOTLD4i5L3fh0gdLfkUQ2lTfCvixE9pLoRKcK/hxtfxA1BmSimhYj5OMSWC
	5rbXsuzoLyvnZfRC0/xS/22hJfbSaqjmAg7MsZw3DNNZBcuN6mQ0X85wL6Og3B4rF/5uki3fPxr
	i5SUUmuC0I4qEYfbbu4OkDG/uXlKo500Gv57UGWmGnotHbRzd9ESmACpGCCiVRl0uVtzepmiWow
	QDt38VVviR2WK3A3FArz33GRigyyDHYNobmQaZUk0r2meKsvlU7Sv/5cKgfcEe1sgHJypYGTrcD
	Go/ObQrl6uK0ictSRvTlYt31AT6EMQCdwmtVBSKlRDyvEaAKBcyYrMSuJSOC7ANDfSWipMlHFl7
	8TeTYIwncBnOBMy1IBUQ==
X-Received: by 2002:a05:620a:25d0:b0:932:dff0:93a8 with SMTP id af79cd13be357-932dff094b6mr311021385a.5.1785011740248;
        Sat, 25 Jul 2026 13:35:40 -0700 (PDT)
Received: from karch-btw.home.kod ([2600:4040:55d9:6c00:2cdb:f30a:f539:7b03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de636183sm214403985a.27.2026.07.25.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 13:35:39 -0700 (PDT)
From: Christopher Kodama <ckhordiasma@gmail.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christopher Kodama <ckhordiasma@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: magicmouse: re-enable multitouch after reset-resume
Date: Sat, 25 Jul 2026 16:34:46 -0400
Message-ID: <20260725203446.35001-1-ckhordiasma@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Apple Magic Trackpad 2 (USB) is reset across a power transition
(e.g. resume from hibernation) it drops out of multitouch mode: it keeps
sending report ID 0x02 on its HID_TYPE_USBMOUSE interface, but the packet
shrinks from 21 to 8 bytes and the trackpad2 handler drops it (size < 12).
Clicks still work but pointer motion is lost until the device is re-plugged
or the driver reloaded.

Re-enable multitouch from .reset_resume via the workqueue.  Only
.reset_resume is needed; suspend-to-idle keeps the device powered and
retains multitouch.

Fixes: 87a2f10395c8 ("HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: Christopher Kodama <ckhordiasma@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 802a3479e..2bd1303e6 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -995,6 +995,22 @@ static void magicmouse_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+#ifdef CONFIG_PM
+static int magicmouse_reset_resume(struct hid_device *hdev)
+{
+	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
+	/* The device drops out of multitouch mode on resume; re-send the
+	 * enable report.  Only the HID_TYPE_USBMOUSE interface accepts it, and
+	 * it must be deferred. Sending it inline here is too early.
+	 */
+	if (msc && hdev->type == HID_TYPE_USBMOUSE)
+		schedule_delayed_work(&msc->work, msecs_to_jiffies(500));
+
+	return 0;
+}
+#endif
+
 static const __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 					   unsigned int *rsize)
 {
@@ -1058,6 +1074,9 @@ static struct hid_driver magicmouse_driver = {
 	.event = magicmouse_event,
 	.input_mapping = magicmouse_input_mapping,
 	.input_configured = magicmouse_input_configured,
+#ifdef CONFIG_PM
+	.reset_resume = magicmouse_reset_resume,
+#endif
 };
 module_hid_driver(magicmouse_driver);
 
-- 
2.55.0

