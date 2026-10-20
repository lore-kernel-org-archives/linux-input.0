Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488272;
	b=SBdVd/glibu2O1lc6BcUfzaQPaoYc7ZnOiEqQMeC9+t1IglXAG3/adOQKj7DTSTfRvAb
	 T7rITURwN95VV2+mpPKkoEvrYHRgrJNRma//zgVNa5EqOuaKlqUwFfyxM4aWkfCBm2wc2
	 mlK8lriwNXKaU8z7QodetnWP5V3pvyFoR9EPoRqzkHrgSF7ON+L6i1eb6zb5j7TIBtAwF
	 Bo+r6w/b4a9FQCePN3g/l7NZxOXJEeWj+ShvGxG0WkyBF6ygcqdF3xoUzlFopOaDSKoaf
	 +RAVCRaGcWrdhtwAGkjufFNXpyGl5IqNG1Tfkr2R1tXFiCokHHKG7p3JmDuXGRndWwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=slIbOgQbb1xp6o/OLxDet5tGdA8/Wwa2Tg8oQr7vIe8=;
	b=y8lU99yjp7L1LW1Lhn1yRLRcGnH02OO341KfH081PbpxcCV3vk8Mbv98Hi9nM3oPJ4Gk
	 NzNWVTK7L3waWk0m1bf9cBRMIs/jMRz99hqseqmOcMz4yOpPWUeb3kGpQ8Aq5BIbF8PJx
	 ZdVsVMWHRQ8aJx27tWlMWbcPU6avrxS7mQn7D1KlcWZl+QCR7fM8Xk0350LIDrcW4ar6E
	 rgiQZpBMQRSKP6VMTIh0fzYCha2pgPbBeUdhwYFEf7lveWq4jIg/tEWWjACzxtOHUwYmT
	 OxTIkZJD2J25v6nbULH3JbEVtBMAOuIlzuAt7V8F62QBS1y2Owrb7lAMLhkyVy4DHOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hccTCw6R;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E299606A329
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E299606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hccTCw6R
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso30727705e9.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488269; x=1793093069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slIbOgQbb1xp6o/OLxDet5tGdA8/Wwa2Tg8oQr7vIe8=;
        b=hccTCw6RFPKrk1BR2Cl+7yK9QrylAfKyL9h08x/9+j8C627S/CPIumIUlQsOb4TlOE
         2g+xmM6Mb+IUfcxDBOSxpGhWg/1yd9DjM1/duUMA9ghNB+2mE41xHTrj1FZL0yXLTkRF
         yo9O02AKig4CQIJ3JuoOfszK9IpRM+DErYVd4NqaY4QWAIwDi8zKdEoqjIGsOA97Zj/D
         qUpsvUTlKqARkJwgkxMk6D5MC0f5HYyzGhGpa+cLoZs8+WZxKeM1QCu5JfeiqYToSwAr
         VN2K6YTfbDr2yvDpAI2LTAx2owUSg3itbjTn0w4hoI7202Nnt4sfZbTFtCGkKx+oCdln
         n5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488269; x=1793093069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slIbOgQbb1xp6o/OLxDet5tGdA8/Wwa2Tg8oQr7vIe8=;
        b=c1zRxXBIAMF6yh1OvgFSXBylQlW/ZXjji8hUwgoL5/JK5vYTafV9YLbKOSvThDs4Q9
         yOwdjyTzGxonr1CZDlAaN8ExZXPcvBvYIAaBD2USTKp+NBPHXCTSva7EVGpfK3CdKgW9
         2HUukMUjcJ8phQ6xRnYIRwA+zppmSyH7iTy7+nAsJ++reqGXki/0M1HM2Sd0XftJvQsm
         ZSvfoQJgGBjs/ocn7HIULpIBgK3nihPydRBYTQop+VVyDsAHHpGACxx8Ab/dD8RfU2q3
         HqK0JnMCeT5hwc5vWcGeT8/T5RRUjCDfZW2oWmAx6kntctzTicHmiv0xxATV/t9SEflP
         3sQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXpLjD+QyfMbpLcbDy9sb85d1CVyNj2k46VcnrVh//lf13WWJFpeV667ZYoq9ODLRzzU8xb7SVs0Av3w==@vger.kernel.org
X-Gm-Message-State: AFq9FYI5pYefa3glUiDCfYvADPiW3pofSHYRuaN6surKQaTiQRONAxkP
	pLveH8E0yIYeIIh+tr50e9qfBP+8K7H3hHfriSQuAyij8ZSDSOkxeUtB
X-Gm-Gg: AYBFou3ucoRYYZSWr2S3bzCZdxEtm8PN80mgTQK2Av3t14U8TrYRHfKNZWsd+Pe+ye1
	NED+/4f7PiLn4vD4c32UntAut6+S28EBKuO7C29bKdENA/71s7monWQZ6r5kiqkVQ06NvKHJcYC
	XMvKO5iSytEe9g5UnGVm6amBx+L9MZLNDzwjw2a5Pb0wFD8BvxkWZA9+jAsz8hUVLbTt9Ao+ij5
	9u0An+SIevgUzMny5KtI9Lz0sneJ+QyEOB2KdAIR/u0CBkz3iaaGnTySXqjEdBlUgbzgVrpdxSf
	yv4wceELivgXs4pXz0eidNbok8mmTzD7MamaNHUfrDAjYHAiTCFZSyNKhSa7vjTsxzK+qlyJ2tt
	er0tyYer71vQaSNpTA8XO+hsDcK8G1CiErXdseoJdZTTtP3lGGXmoIXPABK5CnzUskjGn2LLsWj
	oP25B3V3REC+2Jaeh/y43QcswAnf4T8eEQSLiwRMID7obZctxa7lCRF7bI1h3YwJdQGqlkgbCQd
	kx8ZSwjnmZMJOXhlPll9TMgPwZ364I5CtBjw0zRoFs2dTWDZ0Lz4lB13tPKc/ol5hgd
X-Received: by 2002:a05:600c:3b13:b0:4a0:2150:55fb with SMTP id 5b1f17b1804b1-4a1d75ad08amr255798495e9.4.1792488269351;
        Tue, 20 Oct 2026 02:24:29 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:f99e:1a52:655b:681])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e3csm3881282f8f.53.2026.10.20.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:24:28 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH v4 4/7] HID: asus: Cycle the platform profile from the Zenbook Duo profile key
Date: Tue, 20 Oct 2026 11:24:14 +0200
Message-ID: <20261020092423.36380-5-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
References: <20261020092423.36380-1-p.pisati@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

The Zenbook Duo keyboard reports Fn+F, the performance mode key, as
vendor usage 0x9d. On the built-in keyboards of other ASUS laptops the
same key arrives through asus-wmi, which cycles the platform profile
in response. Do the same here so the key works on the detachable
keyboard too. Other ASUS devices may use the same usage for something
else, so only handle it on the Zenbook Duo keyboards.

asus_event() runs from the HID input path, which for USB is the URB
completion handler, while platform_profile_cycle() takes a mutex, so run
it from the driver's worker like the Fn-lock toggle, and consume the
event. Queue at most one cycle at a time, so that a device repeating the
key cannot grow the worker's list. Only call it when the platform
profile class is reachable: it is not built on architectures without
ACPI, where HID_ASUS still is, and it may be a module while HID_ASUS is
built in.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
[pisati: defer platform_profile_cycle() to the worker and queue at
 most one cycle, only handle the usage on Zenbook Duo keyboards, return
 1 from asus_event() instead of propagating its return value, and
 guard the call with IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE)]
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/hid/hid-asus.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 68211ebe1290..739637f1964a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -29,6 +29,7 @@
 #include <linux/input/mt.h>
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
+#include <linux/platform_profile.h>
 #include <linux/leds.h>
 
 #include "hid-ids.h"
@@ -117,6 +118,7 @@ enum asus_work_action_type {
 	FN_LOCK_SYNC,
 	BRIGHTNESS_SET,
 	WMI_FAN,
+	PLATFORM_PROFILE_CYCLE,
 };
 
 struct hid_raw_event_data {
@@ -431,6 +433,36 @@ static int asus_kbd_fn_lock_set(struct asus_drvdata *drvdata, bool enabled)
 	return 0;
 }
 
+static int asus_platform_profile_cycle(struct asus_drvdata *drvdata)
+{
+	struct asus_worker *worker = drvdata->worker;
+	struct asus_work_action *action, *pending;
+
+	if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
+		return 0;
+
+	guard(spinlock_irqsave)(&worker->lock);
+
+	/*
+	 * One pending cycle is enough: a key press cannot outrun the
+	 * worker, and a device repeating the key must not grow the list.
+	 */
+	list_for_each_entry(pending, &worker->actions, node) {
+		if (pending->type == PLATFORM_PROFILE_CYCLE)
+			return 0;
+	}
+
+	action = kzalloc_obj(struct asus_work_action, GFP_ATOMIC);
+	if (!action)
+		return -ENOMEM;
+
+	action->type = PLATFORM_PROFILE_CYCLE;
+	INIT_LIST_HEAD(&action->node);
+	asus_worker_schedule(worker, action);
+
+	return 0;
+}
+
 static int asus_kbd_wmi_fan_send(struct asus_drvdata *drvdata, u8 *report_data,
 				 size_t report_size)
 {
@@ -467,6 +499,20 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR &&
 	    (usage->hid & HID_USAGE) != 0x00 &&
 	    (usage->hid & HID_USAGE) != 0xff && !usage->type) {
+		/* Zenbook Duo Fn+F: cycle the platform profile */
+		if ((drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) &&
+		    (usage->hid & HID_USAGE) == 0x9d) {
+			if (value) {
+				ret = asus_platform_profile_cycle(drvdata);
+				if (ret) {
+					hid_err(hdev, "Failed to cycle the platform profile: %d\n",
+						ret);
+					return ret;
+				}
+			}
+			return 1;
+		}
+
 		hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
 			 usage->hid & HID_USAGE);
 	}
@@ -773,6 +819,7 @@ static void asus_work(struct work_struct *work)
 	struct asus_worker *worker = container_of(work, struct asus_worker, work);
 	struct asus_work_action *action = NULL;
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * Dequeue the next action, if any. Once teardown has begun .removed
@@ -801,6 +848,13 @@ static void asus_work(struct work_struct *work)
 	case WMI_FAN:
 		asus_kbd_wmi_fan(worker->hdev, &action->data.fan_hid_data);
 		break;
+	case PLATFORM_PROFILE_CYCLE:
+		if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
+			break;
+		ret = platform_profile_cycle();
+		if (ret)
+			hid_dbg(worker->hdev, "Failed to cycle the platform profile: %d\n", ret);
+		break;
 	default:
 		hid_err(worker->hdev, "Invalid action type: %d\n", action->type);
 		break;
-- 
2.43.0

