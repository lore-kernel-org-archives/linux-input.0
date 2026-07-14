Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB573644A3
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023968; cv=none; b=m2y2spOpraymepZZCH+uVHc3zMpgcY6+n5NwsIwm/+/xJm6xS85ZebE7YLM5zwaJBmryY79dfq/8ct9hZ9bvlTQNgnEFZb6z9+ZYqF9p+6DN/LF448nU0F5Lx3ikrrVCbi0ZVFunvDKRHkFdSdKfpHkeNc5wDvUhCYdNBR63pKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023968; c=relaxed/simple;
	bh=2rfBDz6/aloAhda8Bjfwnb+C9SSh/0BYfqyneCTuzHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac3g+wvNaiRiz2+iSRB2l0H4yfp+hE1zZ/N94OxB2id4YTH08xd7vQ2yEjpd7up79ZQ4FD9JatI3z43qREtUhnpZIETTKNuE3H/9gTvhmBbgCT5JC0u0FOp68rI2cjpqLA5RO0fvYRFiYR8hrgrI9BuleZvzZ6WI1UXYheta5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHLPBcCx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHLPBcCx"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e6391b114so61160185a.3
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784023965; x=1784628765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYpfVNjMZg6VKmRPIHIJ/7Pqr/xSIkWL+N548aPvh7g=;
        b=aHLPBcCxuQVJjBfL7xnqp28wn4koh70LBcUjbdAS6ZLisC+LpHQme7JMV16jF9lLW9
         lq3f7TlJTLFc5XSRNCAxlEUvTHwcW2211/BErjeqGjNYBP/e+F684jd6u4t4ROMQGCdP
         NQtkozEBArPyv7NBuxou2UFQ+/JbeY2dKVRsknjQCckqDBL/R9NruO7mzoXNIRCJil0l
         TN8BMnLNOYXNikOLIUqBiMXR/Va89e3eLi6KbRzoVy6fDGAaEBI9znojcD90Rgk4UyIL
         tIaj/B0iLUpsJzKeZT19vRVyLmCaaSM7Pgt32THT4zkS+cONc4grZjKIbknkED1+vf6p
         5ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023965; x=1784628765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYpfVNjMZg6VKmRPIHIJ/7Pqr/xSIkWL+N548aPvh7g=;
        b=MsyZHs0gEfjRsR2YY2c/ZVy2N7jlS2kg8dSv+/7aMNubKTnySGJeITYqA5UbCFUowG
         K6pzdldg+KRASd0y1WL6eMtUgVdwZRbY1j69jA6P/u8kcTRqcYfNO4xFujQAFmOYMtFV
         sx7ePuOryGA4fb6P4SXiMP779DWZc0WvdR+exDv5Kcnnoiycca7aLEFfwmtzMma2YUvk
         9Svc18vEOQkovY/kaNS2F/bYpxFDwtjfj0nI+UKtUtnbztntMqU5HvBp5aSmTuUwB5e+
         YdWSJ4ACDPpqw0l0OyB6NvAtLwKdOt6uhpviM2B15rCi1V3zauGZ4br0ONPt05KK1zvC
         hQ8w==
X-Forwarded-Encrypted: i=1; AHgh+RoL0VKF6CrgYxgd+69/aNoofTu5B+BCjK5myp7wXMv3i/9tfqVCgAnEAxwF0mNTfmxwkThK1SKVkLBgTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjecfoj7ftEK0QVMQOiJraLy/g+xNn+5sqWEi0+SAl9gyR4ih
	4B9MphDlhasIQiFTb/nCYPms+CUH089DJz3PuoyX/QnEP1m+EYObm8rl
X-Gm-Gg: AfdE7cnryR0bmX06uFcExY3QM7QIf+iTkP3Pfs4H3VGnbn/m9GVaOn2mN9ZKzWY2znx
	Dt8j438A00UwlKMyS0k7wXCk05GXtvq8uRVvYfnttgHLqRce+14AkC0Zzu7wS5Si0asKr5z/DWH
	9YVYJ8m5aM44v+HKdnBy2OhviUUPsCYhfb7zW9rLeGDmYPeNAG90tbWnqTkk9fucqKm1VJYHw7r
	Y8iIgf84NGq5SzswnR6Uv7DGlYyVjOl3BwSOj7+/Mqe0nJY3eKNnio8yP0a0hUdarJ55/vE/+0M
	ohpO75p/dvW8GyvoyCjoExgqaNdpUGBb6bDBgSOAWFCu7KPVPpYXd4aUgD6Ylbl0k9gUIv6dwOX
	n0mQWlmYd+sQGXRJrbwgh0kuV+kszRaSAuy8/K20FQuRy089mPayNJRdcprJD5y+sGIfegS6s9D
	MQFXILGsitNK7vxv2SOkMZL29gJ+0PMtTMPE318RcKYvpN
X-Received: by 2002:a05:620a:1991:b0:916:1806:302d with SMTP id af79cd13be357-92ef2bc9bc6mr1331703885a.58.1784023965571;
        Tue, 14 Jul 2026 03:12:45 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfcb0dsm1463056185a.25.2026.07.14.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:12:45 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: [PATCH 3/3] HID: magicmouse: report charge status over Bluetooth
Date: Tue, 14 Jul 2026 06:12:35 -0400
Message-ID: <20260714101235.99447-4-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714101235.99447-1-signshop.alec@gmail.com>
References: <20260714101235.99447-1-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Battery input report 0x90 carries a status byte that the generic HID
battery code does not map to HID_BAT_CHARGING, so charge_status keeps
its POWER_SUPPLY_STATUS_DISCHARGING default and user space never learns
whether the device is on external power (e.g. a Magic Trackpad 2 shows
"discharging" by default even while charging, and cannot report
"discharging" the moment the cable is pulled at 100%).

Parse the status byte in raw_event and set the battery charge status
accordingly (bit 1 = external power, bit 0 = charge complete), notifying
user space with power_supply_changed(). The bit meanings were determined
by observation on a Magic Trackpad 2 rather than from documentation.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alec Hall <signshop.alec@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 6d0e76314b10..8bb791efef3a 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/power_supply.h>
 
 #include "hid-ids.h"
 
@@ -60,6 +61,10 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define MOUSE_REPORT_ID    0x29
 #define MOUSE2_REPORT_ID   0x12
 #define DOUBLE_REPORT_ID   0xf7
+/* Battery Input Report 0x90 = [report_id, status, capacity]. */
+#define MAGICMOUSE_BATTERY_REPORT_ID	0x90
+#define MAGICMOUSE_BATTERY_POWERED	0x02	/* external power connected */
+#define MAGICMOUSE_BATTERY_CHARGED	0x01	/* charge complete (on charger) */
 #define USB_BATTERY_TIMEOUT_SEC 60
 
 /* These definitions are not precise, but they're close enough.  (Bits
@@ -383,6 +388,35 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 }
 
+/*
+ * The battery report carries a charge-status byte the generic HID battery code
+ * doesn't map, so translate the vendor status bits into a power_supply status.
+ * This makes charging/discharging honest -- e.g. "discharging" as soon as the
+ * cable is pulled, even at 100%.
+ */
+static void magicmouse_report_charge_status(struct hid_device *hdev, u8 status)
+{
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+	struct hid_battery *bat = hid_get_battery(hdev);
+	int cs;
+
+	if (!bat || !bat->ps)
+		return;
+
+	if (!(status & MAGICMOUSE_BATTERY_POWERED))
+		cs = POWER_SUPPLY_STATUS_DISCHARGING;
+	else if (status & MAGICMOUSE_BATTERY_CHARGED)
+		cs = POWER_SUPPLY_STATUS_FULL;
+	else
+		cs = POWER_SUPPLY_STATUS_CHARGING;
+
+	if (bat->charge_status != cs) {
+		bat->charge_status = cs;
+		power_supply_changed(bat->ps);
+	}
+#endif
+}
+
 static int magicmouse_raw_event(struct hid_device *hdev,
 		struct hid_report *report, u8 *data, int size)
 {
@@ -394,6 +428,9 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	if (size < 1)
 		return 0;
 
+	if (data[0] == MAGICMOUSE_BATTERY_REPORT_ID && size >= 3)
+		magicmouse_report_charge_status(hdev, data[1]);
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
-- 
2.55.0

