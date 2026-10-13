Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9984B1468
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888043; cv=none; b=P+yGXMzzrpY81Xprxh+Bb0hheWqlNiYc9XhLxbkBarFBxiLS/iEOAm8dbML0Z7CEbHPcMQeh5h1rPK2ZUo/cavBBxrYO93/b/hFl/5ZGemI9d+MtSJLxhzybfsmS/utdfoXbOtJZu96yNkF51QjOGOnyxtCMICtsmFOHrFcCeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888043; c=relaxed/simple;
	bh=2tPy3L1V1Pj2mCJhMzzBqu81AbTRVnmuuSC7iBXZ+Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHLzU+02w6++BL5X3fbPwDpdKkXW1LpoD9jh9BTxUlNdH3JMmlh/ovkSA6DavEda25lwSkut2V4dEi8fQZGVROrrhPIBN0rgd6uEFpvsz28YQlBIheS312cScdXVLv580rGXE+GKtQ5+zxOTqjjeGb7IumDaTj3V6Ir26qWevno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3MfStnq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3MfStnq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so21230845e9.3
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888039; x=1792492839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sSCD00MHTVjn0PHz7qIzklKIm7L3L48OpEEZ46f3Bf8=;
        b=U3MfStnqS0UqsJQUFF6mtFQK6XbMNWk2qQpwOI8RvtCbDyMZAaF51lzGPUIokbcFw3
         doc9E2iiOgOF1Rg3sffUnhW2Tx96SovG3gVryZ9QI65FKXUd90Kz58g1RF4VgGVq6PKc
         ACsOMvfa8v3h4GHY9+NZ/wXRTa4qpNnjrLklWFkir+HC2Vq0r9DUFuzMNvosvUXA987n
         Hj4qjLXiD54nHaqgBpAIg7GWWxavoW75M3nwJjW0GljuzsxdIYmvEhHuAFy9S7oUoJDc
         hY8y6Hario4WrZ/O20dfWcIOEyCIqVHE3OJVm1pzX0ie2pDCNUZlefeo78JzUQlBFECg
         OIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888039; x=1792492839;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSCD00MHTVjn0PHz7qIzklKIm7L3L48OpEEZ46f3Bf8=;
        b=fMJKAr170QvBbQJHT9uNmvL3GyFH1lv2FYES+fkkx1WbXJwqDxViOw9erzAu7GZVkD
         1Zf9ZtSY3auxVBXch/ihDINCK5Jy9id+TVqRIPjOhPtMdFNVwKLU/5FxbEdIRf8RQDCK
         39LNYVgXEeqMOEhLKy6+1BQXWy3LQXjnQmWuHDzp/qXwFzH3AYaHrfU7Q/HT08o2exB4
         0VfaLs/enzMueu2N2w4aAQ7ILrm+JGwmuG8npgQ+ww1xTTF5GCA6EDscwRbpr7eG2EUK
         Xsy3BfiQ07zuccZmloeUG8McTnQjRvQ4MVRxtUJ6Svuuy2/3+QkhTMAKD/TMSgE72xB/
         cmVg==
X-Forwarded-Encrypted: i=1; AKwUvBwYEq/DNYxZMig54G44zXLaZaefA/6NNmofY0KkDday0k4cQ1y9WGewUF9d6K7llI1zVqpNNSfdXx9uBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIID9WJ1+4arHsxnYyCYKpCYp9ijr4tisekiqAgImZXuKR6fjYs
	9WyM9QdufS0WxDEkkJKiJrd11HgGShP3gJFR3bIh4b3o2t0vayE0/afK
X-Gm-Gg: AYBFou0x9Q5FX97AnZhF918N/SblSlEgXql66JAKVZKw9e0Cq8IomNyyiF/7MDLmwuR
	joRgM13JbmgPfYXmP3ZhCvta1ohC0CfNKUvF+VyqfvuMPp5YTykVfyxJjyLx7L99otY02CwHy7z
	vsPNnwtqSK4RRD5HeL+9g2ZuS8uubPJ9WCVwOf0hOqsLtBPqFciNvlvDk9pE5hdR149/79mgAfn
	VYBgHKNqtzaMpcmhnQ4kIKIuLaoHcWfBWA583P/HxY+MutIciYZzmt6CVd4sHBKgp5cx+55W9++
	5tSatsi7cWG0Q7PLXCyTEs8IeZ8eRNrPz8Kcic50XZJTG+r/M/ap+JVd3YbLOsHash+hr0LzpeM
	HosMHwhzgPXfaJ7I2YwyFksir6YD5X69803YRk+EKo7NHT964Z4HJt8u8M5+2lFicrOHMsgKfk8
	kZvyPsplWl7ACjzDtaNrIHHfFM89CWMp85d3w1aj3ZEv1CrxiH2ZwEy5uxwrJ6E75e5NcuvZhmd
	vp6CcqeIcyZYhkOoN/h2V42N8P0uKzCgQmZqHRATXgCZyxevOK0WQdO4pueBdsqDqqW
X-Received: by 2002:a05:600c:c3c1:10b0:4a1:ac66:5f93 with SMTP id 5b1f17b1804b1-4a1ac666305mr22437795e9.8.1791888039122;
        Tue, 13 Oct 2026 03:40:39 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:e22b:cb88:4091:8aab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm505948015e9.6.2026.10.13.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:38 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 4/7] HID: asus: Cycle the platform profile from the Zenbook Duo profile key
Date: Tue, 13 Oct 2026 12:40:01 +0200
Message-ID: <20261013104033.36079-5-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104033.36079-1-p.pisati@gmail.com>
References: <20261013104033.36079-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

The Zenbook Duo keyboard reports Fn+F, the performance mode key, as
vendor usage 0x9d. On the built-in keyboards of other ASUS laptops the
same key arrives through asus-wmi, which cycles the platform profile
in response. Do the same here so the key works on the detachable
keyboard too.

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
 most one cycle, return 1 from asus_event() instead of propagating
 its return value, and guard the call with
 IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE)]
Assisted-by: LLM
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
---
 drivers/hid/hid-asus.c | 67 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d69431615c27..b127f5c38f60 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -29,6 +29,7 @@
 #include <linux/input/mt.h>
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
+#include <linux/platform_profile.h>
 #include <linux/leds.h>
 
 #include "hid-ids.h"
@@ -115,6 +116,7 @@ enum asus_work_action_type {
 	FN_LOCK_SYNC,
 	BRIGHTNESS_SET,
 	WMI_FAN,
+	PLATFORM_PROFILE_CYCLE,
 };
 
 struct hid_raw_event_data {
@@ -423,6 +425,42 @@ static int asus_kbd_fn_lock_set(struct asus_drvdata *drvdata, bool enabled)
 	return 0;
 }
 
+static int asus_platform_profile_cycle(struct asus_drvdata *drvdata)
+{
+	struct asus_worker *worker = drvdata->worker;
+	struct asus_work_action *action, *pending;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
+		return 0;
+
+	spin_lock_irqsave(&worker->lock, flags);
+
+	/*
+	 * One pending cycle is enough: a key press cannot outrun the
+	 * worker, and a device repeating the key must not grow the list.
+	 */
+	list_for_each_entry(pending, &worker->actions, node) {
+		if (pending->type == PLATFORM_PROFILE_CYCLE)
+			goto unlock;
+	}
+
+	action = kzalloc_obj(struct asus_work_action, GFP_ATOMIC);
+	if (!action) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	action->type = PLATFORM_PROFILE_CYCLE;
+	INIT_LIST_HEAD(&action->node);
+	asus_worker_schedule(worker, action);
+
+unlock:
+	spin_unlock_irqrestore(&worker->lock, flags);
+	return ret;
+}
+
 static int asus_kbd_wmi_fan_send(struct asus_drvdata *drvdata, u8 *report_data,
 				 size_t report_size)
 {
@@ -459,8 +497,25 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR &&
 	    (usage->hid & HID_USAGE) != 0x00 &&
 	    (usage->hid & HID_USAGE) != 0xff && !usage->type) {
-		hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
-			 usage->hid & HID_USAGE);
+		/*
+		 * Some vendor usages do not map to a key and need special
+		 * handling.
+		 */
+		switch (usage->hid & HID_USAGE) {
+		case 0x9d: /* Zenbook Duo Fn+F: cycle the platform profile */
+			if (value) {
+				ret = asus_platform_profile_cycle(drvdata);
+				if (ret) {
+					hid_err(hdev, "Failed to cycle the platform profile: %d\n",
+						ret);
+					return ret;
+				}
+			}
+			return 1;
+		default:
+			hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
+				 usage->hid & HID_USAGE);
+		}
 	}
 
 	if (usage->type == EV_KEY && value) {
@@ -765,6 +820,7 @@ static void asus_work(struct work_struct *work)
 	struct asus_worker *worker = container_of(work, struct asus_worker, work);
 	struct asus_work_action *action = NULL;
 	unsigned long flags;
+	int ret;
 
 	/* Save the action to be performed and clear the flag */
 	spin_lock_irqsave(&worker->lock, flags);
@@ -788,6 +844,13 @@ static void asus_work(struct work_struct *work)
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

