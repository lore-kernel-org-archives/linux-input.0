Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A234D7D54
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552815; cv=none; b=jzgZxYZkL2n13+STjkGooVNS4jsYTC3ZSQt10lPX1Y2Xycm5xAwCHFUxLssfqTk329aub8q0m7MBoYslcRrP52cNslm4/24zVcAR3YxpMrHu84zdRfAbJTDMKUUGhyZFeMtiX6pIgNJtzUnO5xGVBs0PA9pWgkq/B4UrLepfJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552815; c=relaxed/simple;
	bh=/9vkH3jI+0nPN5di9i+75S14dSb0NLpdC+cOulXCaVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCsqu3oo8hplt1m4ovFafZsktxfSXLut2Cf9eQhkwLYegYhqyGPS8lqK64eiwGToyrVNOHe8mkk8Q3edPH3njnWZAFnM2y+LqTc1oJ/Dz0NqjyJkG/XD2SGYdAgJCMzN7FL2K8XBMeQwroJijDCQTv62el6PtWOLGtPPlT7d9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lklfzcnk; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lklfzcnk"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7a6e560f580so4475201137.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791552812; x=1792157612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iq9vc425G41XP3ZAyGqQlGizSWNXYB63JonuvWCi8I4=;
        b=lklfzcnkiONzJnaolQ63g9HMuoCPS+fmtSRqEyp5ySvv4DV0j0NlA7cX/DX4kAZff1
         jwSmUC+eDJSqX4GMxwJMcNbO7yS4PnlaCVg/1fIE0GVMU84HHC3tUWnYgiMfvxk1nedG
         ZygRBeadHvUkcVkOm2Am+UKSlc+SYlXji0QpK3s1gI5W7XCQRfBCV/CZRnsOWMstESgX
         fK+quxk7+L8Q2ToviYvC3OVybnPd4/9kUZFyrK7iVEQwQi7Vu72GeEWB00kQATtPDWtS
         NjVRTHrfLQPxZuqVPyCkNGbXph6vNSLEyeAAwhbI+Wjz076IgKQg5T3W6jcZIvK4EvaD
         vR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552812; x=1792157612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iq9vc425G41XP3ZAyGqQlGizSWNXYB63JonuvWCi8I4=;
        b=S7EEpil7dkhB29Cex0L6lrbs8W/nbs2mGlS2AWJv8ggRxF9hqfGgTLS08QyraBxNdx
         fYpTIPF/g+33cpOtlUvPOTv0P3q3oBaxFRZyMogI46dC0UoyxUZGbvq5ExdTn7SW+qr6
         OWC7KInHfY5T0yAD3ia/dbVGhrjCjmMNYgOPp9hip5iCVBHTOATQMLM/XITecde3jO/r
         PN/bRhHcRvHn4ceyPo7iQqmedK/sdES6ZVDT2BJaew34bDCNBNtrY16eax2iyVL+0b11
         oYtk1OPVsNHkzpNF0XKQWJX27Wdo3MInHgJBS9+RChvdtljiugK9ayETBK1Qi9C6T/lr
         apMQ==
X-Forwarded-Encrypted: i=1; AKwUvBz064GHx/Fvt32kp7wOBmSjGV5b14TI6VzPAXgJcwL3xlt1E7pvFoR8fah8x7ynp3+xZfMzizPhXbC/YA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI37As4oQ4w/UBJ1dL13LXAiO1n3go+C5JY+N8xFWvNb6loOTU5
	KTCHo52OGSGQ2ol4PGkW617w1QyzBd9GucDqFjEXGii439k64arQWtxf
X-Gm-Gg: AYBFou0Ap4d74G9dBe/vNTfMxMQ4WUhvsj9rq9TglX1QZaIPyOr+oidLd89YUK4elHT
	3fhSBAqHg8Ym4Z2UU9KMlVk3ywUku4vygiTkuFpHpnpZCx6cmt03AHy8AvoJrmk1j/TQ3cfru3G
	VNzMrVU9V+nc0qCCMJZmaLCcTii+d3QVS/mshm5VBgY0NIiHQ6xbYNSorjadMmDpSGEp+gbkS7B
	zl1GKbY0n0qKDuy4QVOboseMRQQclLd50KC4imr5FfbWGmyNJeZwdUunnJ9odvKxAnWfmlDAYnK
	v7I5CUbs7T7UK/PVA8drYMZHL3lPmqaKZcSOrlESG3XfNg5V9qps6+XDe6cu4qJ4InJrP8MaJs3
	EBXfy2/8w7IfvnFbaJwnwrICC5pXPatY1/QCEVoNFc5SUS3v5+5z+IVKnUGgsx7ecP0EdTmVcyc
	JYM35G5qSnDScHV8A2dQWugzevkzmKYrKpSUd6p5/ZIss78Igl0/Xub2Mr/dS/6w8=
X-Received: by 2002:a05:6102:f0d:b0:7a7:198b:674b with SMTP id ada2fe7eead31-7cb373b8a07mr636123137.32.1791552812364;
        Fri, 09 Oct 2026 06:33:32 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb3411becasm1612276137.0.2026.10.09.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:33:32 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v4] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri,  9 Oct 2026 10:33:16 -0300
Message-ID: <20261009133316.3371188-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009110509.2432308-1-qwe.aldo@gmail.com>
References: <20261009110509.2432308-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_probe() allocates td->haptic with devm_kzalloc(), tying its
lifetime to the HID device's driver unbind.  hid_haptic_init() then
stores the pointer in ff->private and installs hid_haptic_destroy()
as the force-feedback destroy callback.

When the HID device is removed while a process still holds an evdev
fd, devres frees td->haptic at unbind time.  hid_haptic_destroy()
runs later from input_dev_release() and dereferences freed memory.
The input core then calls kfree(ff->private) on the same pointer,
double-freeing it.

The existing get_device()/put_device() pair in init/destroy pins the
struct hid_device but does not keep its devres allocations alive,
since devres runs at driver unbind, not at the final device kref put.

Replace devm_kzalloc() with plain kzalloc() so the haptic struct
survives driver unbind.  Track ownership explicitly:

 - Add an 'owner' back-pointer (to td->haptic) and an 'ff_owned'
   flag to struct hid_haptic_device.

 - hid_haptic_destroy() NULLs *owner under a lock before the input
   core frees ff->private, so td->haptic becomes NULL and later
   kfree(td->haptic) calls are harmless.

 - hid_haptic_release() safely frees the struct only when the FF
   subsystem does not own it.

 - In mt_remove(), hid_haptic_detach() disconnects the back-pointer
   before hid_hw_stop() so a deferred destroy (from a still-open
   evdev fd) does not write into the devres-freed mt_device.

Additionally, reorder hid_haptic_init() to call try_module_get() and
get_device() before input_ff_create(), eliminating the input_free
error path that called input_ff_destroy() without setting a return
code -- which left td->haptic as a dangling pointer on those
(theoretical) failures.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v4: track ownership explicitly with an owner back-pointer, an
    ff_owned flag, and hid_haptic_release()/hid_haptic_detach()
    helpers.  Reorder hid_haptic_init() so try_module_get() and
    get_device() run before input_ff_create(), eliminating the
    input_free error path that left ret == 0 on failure.  In
    mt_remove(), detach the back-pointer before hid_hw_stop() so a
    deferred destroy from a still-open evdev fd does not write into
    the devres-freed mt_device.  All findings from Sashiko AI review
    on v1-v3 are addressed.
v3: drop kfree(haptic) from hid_haptic_destroy() -- input_ff_destroy()
    already calls kfree(ff->private) after the callback.  Handle
    hid_hw_start() failure with conditional kfree.
v2: do not free td->haptic on hid_hw_start() failure.
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

 drivers/hid/hid-haptic.c     | 73 ++++++++++++++++++++++++++----------
 drivers/hid/hid-haptic.h     | 14 +++++++
 drivers/hid/hid-multitouch.c | 27 ++++++++++---
 3 files changed, 89 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb..e4e6eb3 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -10,6 +10,8 @@
 
 #include "hid-haptic.h"
 
+static DEFINE_MUTEX(haptic_owner_lock);
+
 void hid_haptic_feature_mapping(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_field *field, struct hid_usage *usage)
@@ -383,6 +385,12 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	struct hid_device *hdev = haptic->hdev;
 	int r;
 
+	mutex_lock(&haptic_owner_lock);
+	if (haptic->owner)
+		*haptic->owner = NULL;
+	haptic->owner = NULL;
+	mutex_unlock(&haptic_owner_lock);
+
 	if (hdev)
 		put_device(&hdev->dev);
 
@@ -408,6 +416,37 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	module_put(THIS_MODULE);
 }
 
+void hid_haptic_release(struct hid_haptic_device **owner)
+{
+	struct hid_haptic_device *haptic;
+
+	mutex_lock(&haptic_owner_lock);
+	haptic = *owner;
+	if (haptic) {
+		haptic->owner = NULL;
+		*owner = NULL;
+		if (!haptic->ff_owned)
+			kfree(haptic);
+	}
+	mutex_unlock(&haptic_owner_lock);
+}
+EXPORT_SYMBOL_GPL(hid_haptic_release);
+
+bool hid_haptic_detach(struct hid_haptic_device **owner)
+{
+	bool ff_owned = false;
+
+	mutex_lock(&haptic_owner_lock);
+	if (*owner) {
+		(*owner)->owner = NULL;
+		ff_owned = (*owner)->ff_owned;
+	}
+	mutex_unlock(&haptic_owner_lock);
+
+	return ff_owned;
+}
+EXPORT_SYMBOL_GPL(hid_haptic_detach);
+
 int hid_haptic_init(struct hid_device *hdev,
 		    struct hid_haptic_device *haptic,
 		    struct input_dev *dev)
@@ -419,8 +458,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
-	int (*flush)(struct input_dev *dev, struct file *file);
-	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -501,11 +538,23 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
-	flush = dev->flush;
-	event = dev->event;
+	if (!try_module_get(THIS_MODULE)) {
+		dev_err(&hdev->dev, "Failed to increase module count.\n");
+		ret = -ENODEV;
+		goto stop_buffer_free;
+	}
+	if (!get_device(&hdev->dev)) {
+		dev_err(&hdev->dev, "Failed to get hdev device.\n");
+		ret = -ENODEV;
+		module_put(THIS_MODULE);
+		goto stop_buffer_free;
+	}
+
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
+		put_device(&hdev->dev);
+		module_put(THIS_MODULE);
 		goto stop_buffer_free;
 	}
 
@@ -515,23 +564,9 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
 	ff->destroy = hid_haptic_destroy;
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		goto input_free;
-	}
-	if (!get_device(&hdev->dev)) {
-		dev_err(&hdev->dev, "Failed to get hdev device.\n");
-		module_put(THIS_MODULE);
-		goto input_free;
-	}
+	haptic->ff_owned = true;
 	return 0;
 
-input_free:
-	input_ff_destroy(dev);
-	/* Restore dev flush and event */
-	dev->flush = flush;
-	dev->event = event;
-	return ret;
 stop_buffer_free:
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 6332991..0a44993 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -6,6 +6,7 @@
  */
 
 #include <linux/hid.h>
+#include <linux/slab.h>
 
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
 #define HID_HAPTIC_ORDINAL_WAVEFORMSTOP 2
@@ -29,6 +30,8 @@ struct hid_haptic_effect_node {
 struct hid_haptic_device {
 	struct input_dev *input_dev;
 	struct hid_device *hdev;
+	struct hid_haptic_device **owner;
+	bool ff_owned;
 	struct hid_report *auto_trigger_report;
 	struct mutex auto_trigger_mutex;
 	struct workqueue_struct *wq;
@@ -75,6 +78,8 @@ void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 				  __s32 pressure);
+void hid_haptic_release(struct hid_haptic_device **owner);
+bool hid_haptic_detach(struct hid_haptic_device **owner);
 #else
 static inline
 void hid_haptic_feature_mapping(struct hid_device *hdev,
@@ -126,4 +131,13 @@ static inline
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 				  __s32 pressure)
 {}
+static inline void hid_haptic_release(struct hid_haptic_device **owner)
+{
+	kfree(*owner);
+	*owner = NULL;
+}
+static inline bool hid_haptic_detach(struct hid_haptic_device **owner)
+{
+	return false;
+}
 #endif
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c..961ddeb 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2132,10 +2132,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc(&hdev->dev, sizeof(*(td->haptic)), GFP_KERNEL);
+	td->haptic = kzalloc(sizeof(*(td->haptic)), GFP_KERNEL);
 	if (!td->haptic)
 		return -ENOMEM;
 
+	td->haptic->owner = &td->haptic;
 	td->haptic->hdev = hdev;
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
@@ -2181,12 +2182,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto err_free_haptic;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto err_free_haptic;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2195,8 +2198,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_NOGET;
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret)
+	if (ret) {
+		hid_haptic_release(&td->haptic);
 		return ret;
+	}
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -2206,9 +2211,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
 	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+		hid_haptic_release(&td->haptic);
 
 	return 0;
+
+err_free_haptic:
+	hid_haptic_release(&td->haptic);
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)
@@ -2248,11 +2257,17 @@ static int mt_resume(struct hid_device *hdev)
 static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
+	bool ff_owned;
 
 	timer_shutdown_sync(&td->release_timer);
 
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
+	ff_owned = hid_haptic_detach(&td->haptic);
 	hid_hw_stop(hdev);
+	if (!ff_owned)
+		hid_haptic_release(&td->haptic);
+	else
+		td->haptic = NULL;
 }
 
 static void mt_on_hid_hw_open(struct hid_device *hdev)
-- 
2.43.0

