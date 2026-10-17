Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA533C3F4A
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255321; cv=none; b=m/IrVXiikERHs1WdTs7fPdkR+nYgJb0D4ZSg0eVwBR3VjhUbb1GyIri2CZh1dI/TEuk1OjNMN7DzT1j3rpJraRExYh4PT342QVdJmvBjZBzSm8LwA2SCjNFyXR8tlbNFUZ0z8nK/iy2vYTvPqK0aSVEDxz2fMrHWGzFxdwJSxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255321; c=relaxed/simple;
	bh=BemLKpzMV2cGNDiIiS5GnsqPgSEVdKRMSXgi3VNog9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ5VGQxEzzY1JB7VjLAhKU/lIzF4TgZPUrY+yxu1pM8wvAA3JaVwjBl/7rpMMTlf3CJwj9jxBLhF53r2RIyvdZdfDOP2kuR8mImCTo9EFgrUCcb1f/+4bmL5x+I4c9p/7eg+xsLEbOQhb0bqBKyNER/iHvjntNk16cPitjsIbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNLrRFv8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNLrRFv8"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917bab38b14so9273276d6.3
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255317; x=1792860117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNGfrzFy6C0Pbu+P9jw0rVj22bwJD+aan7KFDBDtGhU=;
        b=lNLrRFv8vbH7dLyOq2Qc6mW1Oh626FEP3ZZtBXfuzSWwJcslNYqcGEGiQdN+PuREC7
         kny4OwC84ufhNK/9iYHE7ritmmwfK3yY4JzxoeTPHoEfh2jlC6KA3B8xn5eKlUYpjBre
         wY37RQqhQOHf/x1KfmUZ9ousIsS2yGkiU63j+pEJ65UzNRF6z8zGACH+nGb/ezfVukKV
         dTMeqKwubTkWQtK0y7eCTbIBQgWqCMWFuFMBAMHLXHE4gonQIEJ6H4/EpckNvisTBAkO
         qiWRCTd/d7tNc9a/HUYjmTFO2VK8m/bkH+5l81MAucos6w8tqjvd09iZ2m6EYlzCUWAU
         vl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255317; x=1792860117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNGfrzFy6C0Pbu+P9jw0rVj22bwJD+aan7KFDBDtGhU=;
        b=iQqIFu47dzxZcVeFQhQFO+cAubCaeqRaubS4yKl7BApwEm6RuPr0oGd9+RvnKhvTW3
         F3HjcN6MHpfylOqtSBOHsyOVQMJPmhH3x4AlLIdxptj+DTZu08mOKYSZNnWQDDWUjYSV
         gMQz0qtnKM2EAS7gGBygwj+JszjOxqC1BgoehLwHkgYJpe9u3OLfzoiCcq/UKtmb+xWd
         Eser9mCCJN14r5CYTTNtg9Ja0nwhzXF+Jk8oMRNPhjKGgpEyGWxDNjBPSxpe1XXPe80V
         4vq3dRgO/SjYGlNqw7qC+XK7m/ZonPJQPj3osp4Iz/GHq63GqlYQMGdRZycpEe/nu/dA
         dMXw==
X-Forwarded-Encrypted: i=1; AKwUvBzQzJVTu2QJc4tM/hLPQMUGf4unAYub58z/5guh8dvt/14ecIXcYNJK8uMpURqzVuM9vAp0XfxSMa83ow==@vger.kernel.org
X-Gm-Message-State: AFq9FYIjg/XWkxi531xGLBmBIrlwOnCxbN0IXfkSi4vZv3pL8LcteP9o
	eFih3YeZ+/hxzAuh6vCFun5xczbia2LdMio/QN8llF6uQXFPYaFL6fvM
X-Gm-Gg: AYBFou1Xd1n++JefHttZeiAz1eWkTQRJx5sPc4bOt7qS2EK8UzfKk1VebqrHxa2/ftC
	OSzOduouKiN65/wdsUjD2RBu/Oc8z4bSG2HipZHIbTEJHs7IpwoHQmjn3exicvn3k4eMYjjP1sR
	CD9B4MScNyg5/eWpZNwspkDu6fE38yrXg05v3MriASxJydEXSl9luTrNEWJT5y2jHtzMbtrn8Es
	GD9cYjx9IKO6dIoQCtzBfUPblCGVuemP+DJ0yJNd4eUas0cGZn5mIbBke1vbaVyqHIE/yJ1nBaz
	guRUjgMYIKkrCftFnmwLz5kh53lM5lwApABgvVE79ii3vbrbc5Tw78CsLypxeFPe0UyLLljcQ1V
	rcTTYfugu8OYrvtpANddFXBJaBwB6pDRaufzNYrM0vRIg8n/o5y9rbzIALyELd+iaD2D7Ht/bNC
	EU9K80uWcyQwVodYm+nFwXBMhQoemcl4nB0JIdRayP9mJE7IMAr1evyq0tge7uOAk=
X-Received: by 2002:a05:6214:5508:b0:919:56d7:4052 with SMTP id 6a1803df08f44-91bdf0f0c84mr55566726d6.24.1792255317297;
        Sat, 17 Oct 2026 09:41:57 -0700 (PDT)
Received: from beelink ([187.15.140.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm51061296d6.1.2026.10.17.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:56 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v11 2/2] HID: multitouch: give FF core ownership of haptic state
Date: Sat, 17 Oct 2026 13:41:39 -0300
Message-ID: <20261017164139.1791033-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017164139.1791033-1-qwe.aldo@gmail.com>
References: <20261017164139.1791033-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open evdev fd can delay input_ff_destroy() until after HID unbind.
The descriptor mapping state is devres managed and cannot serve as
ff->private for that lifetime.

Clone the mapped state in hid_haptic_init(). Transfer the allocation
to ff->private only after input_ff_create() succeeds; the input core
then frees it at final input device release. Scope cleanup releases
the clone and its subresources on initialization failure.

On devices with multiple inputs, attach FF to the multitouch touchpad
input whose pressure uses gram or newton units. An earlier touchpad
report without a multitouch collection or haptic pressure must not
consume the single FF instance. Other inputs skip FF initialization
and do not acquire INPUT_PROP_PRESSUREPAD from the haptic setup. The
HID reports are shared, so multiple FF instances would write the same
fields under different mutexes.

Validate the touchpad class and initialize FF before setting up MT
slots. Enable pointer emulation, total force and contact pressure
accounting on the input that owns FF. If no input receives FF, disable
haptic mode before input reports can be processed.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c     | 131 ++++++++++++++++++-----------------
 drivers/hid/hid-haptic.h     |   6 +-
 drivers/hid/hid-multitouch.c |  61 ++++++++++------
 3 files changed, 109 insertions(+), 89 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 0a6126e..ec2a891 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/input/mt.h>
 #include <linux/module.h>
 
@@ -90,7 +91,9 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 	if (!haptic->auto_trigger_report || !haptic->manual_trigger_report)
 		return 0;
 
-	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
+	/* The HID reports are shared; create only one FF instance. */
+	if (haptic->input_dev)
+		return 1;
 
 	error = hid_haptic_init(hdev, haptic, hi->input);
 	if (error) {
@@ -99,6 +102,9 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 		return error;
 	}
 
+	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
+	haptic->input_dev = hi->input;
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
@@ -377,53 +383,76 @@ static int hid_haptic_erase(struct input_dev *dev, int effect_id)
 	return 0;
 }
 
-static void hid_haptic_stop(struct ff_device *ff)
+static void hid_haptic_stop_work(struct hid_haptic_device *haptic)
 {
-	struct hid_haptic_device *haptic = ff->private;
-
 	if (haptic->wq) {
 		destroy_workqueue(haptic->wq);
 		haptic->wq = NULL;
 	}
 }
 
-static void hid_haptic_destroy(struct ff_device *ff)
+static void hid_haptic_stop(struct ff_device *ff)
+{
+	hid_haptic_stop_work(ff->private);
+}
+
+static void hid_haptic_free_resources(struct hid_haptic_device *haptic)
 {
-	struct hid_haptic_device *haptic = ff->private;
 	int r;
 
-	hid_haptic_stop(ff);
+	hid_haptic_stop_work(haptic);
 
 	kfree(haptic->stop_effect.report_buf);
-	haptic->stop_effect.report_buf = NULL;
 
 	if (haptic->effect) {
-		for (r = 0; r < ff->max_effects; r++)
+		for (r = 0; r < FF_MAX_EFFECTS; r++)
 			kfree(haptic->effect[r].report_buf);
 		kfree(haptic->effect);
 	}
-	haptic->effect = NULL;
 
 	kfree(haptic->duration_map);
-	haptic->duration_map = NULL;
-
 	kfree(haptic->hid_usage_map);
-	haptic->hid_usage_map = NULL;
+}
+
+static void hid_haptic_free_state(struct hid_haptic_device *haptic)
+{
+	if (haptic) {
+		hid_haptic_free_resources(haptic);
+		kfree(haptic);
+	}
+}
+
+DEFINE_FREE(hid_haptic_state, struct hid_haptic_device *, hid_haptic_free_state(_T));
+
+static void hid_haptic_destroy(struct ff_device *ff)
+{
+	struct hid_haptic_device *haptic = ff->private;
+
+	hid_haptic_free_resources(haptic);
 
 	module_put(THIS_MODULE);
 }
 
 int hid_haptic_init(struct hid_device *hdev,
-		    struct hid_haptic_device *haptic,
+		    const struct hid_haptic_device *config,
 		    struct input_dev *dev)
 {
+	struct hid_haptic_device *haptic __free(hid_haptic_state) =
+		kmemdup(config, sizeof(*config), GFP_KERNEL);
 	struct ff_device *ff;
-	int ret = 0, r;
+	int ret, r;
 	struct ff_haptic_effect stop_effect = {
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
-	const char *prefix = "hid-haptic";
-	char *name;
+	if (!haptic)
+		return -ENOMEM;
+
+	/* The mapping state does not own these allocations. */
+	haptic->hid_usage_map = NULL;
+	haptic->duration_map = NULL;
+	haptic->effect = NULL;
+	haptic->stop_effect.report_buf = NULL;
+	haptic->wq = NULL;
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -431,16 +460,12 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	haptic->hid_usage_map = kcalloc(haptic->max_waveform_id + 1,
 					sizeof(u16), GFP_KERNEL);
-	if (!haptic->hid_usage_map) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!haptic->hid_usage_map)
+		return -ENOMEM;
 	haptic->duration_map = kcalloc(haptic->max_duration_id + 1,
 				       sizeof(u32), GFP_KERNEL);
-	if (!haptic->duration_map) {
-		ret = -ENOMEM;
-		goto usage_map;
-	}
+	if (!haptic->duration_map)
+		return -ENOMEM;
 
 	if (haptic->max_waveform_id != haptic->max_duration_id)
 		dev_warn(&hdev->dev,
@@ -460,21 +485,19 @@ int hid_haptic_init(struct hid_device *hdev,
 	haptic->manual_trigger_report_len =
 		hid_report_len(haptic->manual_trigger_report);
 	mutex_init(&haptic->manual_trigger_mutex);
-	name = kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
-	if (name) {
-		sprintf(name, "%s %s", prefix, hdev->name);
+	{
+		char *name __free(kfree) = kasprintf(GFP_KERNEL,
+						     "hid-haptic %s", hdev->name);
+
+		if (!name)
+			return -ENOMEM;
 		haptic->wq = create_singlethread_workqueue(name);
-		kfree(name);
-	}
-	if (!haptic->wq) {
-		ret = -ENOMEM;
-		goto duration_map;
 	}
+	if (!haptic->wq)
+		return -ENOMEM;
 	haptic->effect = kzalloc_objs(struct hid_haptic_effect, FF_MAX_EFFECTS);
-	if (!haptic->effect) {
-		ret = -ENOMEM;
-		goto output_queue;
-	}
+	if (!haptic->effect)
+		return -ENOMEM;
 	for (r = 0; r < FF_MAX_EFFECTS; r++) {
 		haptic->effect[r].report_buf =
 			hid_alloc_report_buf(haptic->manual_trigger_report,
@@ -482,8 +505,7 @@ int hid_haptic_init(struct hid_device *hdev,
 		if (!haptic->effect[r].report_buf) {
 			dev_err(&hdev->dev,
 				"Failed to allocate a buffer for an effect.\n");
-			ret = -ENOMEM;
-			goto buffer_free;
+			return -ENOMEM;
 		}
 		haptic->effect[r].input_dev = dev;
 		INIT_WORK(&haptic->effect[r].work, haptic_work_handler);
@@ -494,8 +516,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	if (!haptic->stop_effect.report_buf) {
 		dev_err(&hdev->dev,
 			"Failed to allocate a buffer for stop effect.\n");
-		ret = -ENOMEM;
-		goto buffer_free;
+		return -ENOMEM;
 	}
 	haptic->stop_effect.input_dev = dev;
 	INIT_WORK(&haptic->stop_effect.work, haptic_work_handler);
@@ -507,7 +528,9 @@ int hid_haptic_init(struct hid_device *hdev,
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
-		goto ff_cap_clear;
+		__clear_bit(FF_HAPTIC, dev->ffbit);
+		__clear_bit(EV_FF, dev->evbit);
+		return ret;
 	}
 
 	ff = dev->ff;
@@ -517,30 +540,8 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->stop = hid_haptic_stop;
 	ff->destroy = hid_haptic_destroy;
 	__module_get(THIS_MODULE);
-	ff->private = haptic;
+	ff->private = no_free_ptr(haptic);
 	return 0;
-
-ff_cap_clear:
-	__clear_bit(FF_HAPTIC, dev->ffbit);
-	__clear_bit(EV_FF, dev->evbit);
-	kfree(haptic->stop_effect.report_buf);
-	haptic->stop_effect.report_buf = NULL;
-buffer_free:
-	while (--r >= 0)
-		kfree(haptic->effect[r].report_buf);
-	kfree(haptic->effect);
-	haptic->effect = NULL;
-output_queue:
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
-duration_map:
-	kfree(haptic->duration_map);
-	haptic->duration_map = NULL;
-usage_map:
-	kfree(haptic->hid_usage_map);
-	haptic->hid_usage_map = NULL;
-exit:
-	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_init);
 
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 6332991..661b605 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -69,7 +69,8 @@ int hid_haptic_input_mapping(struct hid_device *hdev,
 int hid_haptic_input_configured(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_input *hi);
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+int hid_haptic_init(struct hid_device *hdev,
+		    const struct hid_haptic_device *config,
 		    struct input_dev *dev);
 void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
@@ -108,7 +109,8 @@ static inline
 void hid_haptic_reset(struct hid_device *hdev, struct hid_haptic_device *haptic)
 {}
 static inline
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+int hid_haptic_init(struct hid_device *hdev,
+		    const struct hid_haptic_device *config,
 		    struct input_dev *dev)
 {
 	return 0;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 154dc94..34aefe8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -174,6 +174,7 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_haptic_device *haptic;	/* haptic related configuration */
+	struct input_dev *haptic_pressure_input;
 	int haptic_init_error;
 	struct hid_device *hdev;	/* hid_device we're attached to */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING) */
@@ -963,9 +964,12 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_TIPPRESSURE:
 			set_abs(hi->input, ABS_MT_PRESSURE, field,
 				cls->sn_pressure);
-			td->is_haptic_touchpad =
-				hid_haptic_check_pressure_unit(td->haptic,
-							       hi, field);
+			if (!td->haptic_pressure_input &&
+			    field->application == HID_DG_TOUCHPAD &&
+			    hid_haptic_check_pressure_unit(td->haptic, hi, field)) {
+				td->haptic_pressure_input = hi->input;
+				td->is_haptic_touchpad = true;
+			}
 			MT_STORE_FIELD(p);
 			return 1;
 		case HID_DG_SCANTIME:
@@ -1087,7 +1091,9 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 
 	app->num_received = 0;
 	app->left_button_state = 0;
-	if (td->is_haptic_touchpad)
+	if (td->is_haptic_touchpad &&
+	    app->application == HID_DG_TOUCHPAD &&
+	    td->haptic->input_dev == input)
 		hid_haptic_pressure_reset(td->haptic);
 }
 
@@ -1240,7 +1246,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			minor = minor >> 1;
 		}
 
-		if (td->is_haptic_touchpad)
+		if (td->is_haptic_touchpad &&
+		    app->application == HID_DG_TOUCHPAD &&
+		    td->haptic->input_dev == input)
 			hid_haptic_pressure_increase(td->haptic, *slot->p);
 
 		x = hdev->quirks & HID_QUIRK_X_INVERT ?
@@ -1443,8 +1451,10 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (cls->is_indirect)
 		app->mt_flags |= INPUT_MT_POINTER;
 
-	if (td->is_haptic_touchpad)
-		app->mt_flags |= INPUT_MT_TOTAL_FORCE;
+	if (td->is_haptic_touchpad &&
+	    app->application == HID_DG_TOUCHPAD &&
+	    td->haptic->input_dev == input)
+		app->mt_flags |= INPUT_MT_POINTER | INPUT_MT_TOTAL_FORCE;
 
 	if (app->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
 		app->mt_flags |= INPUT_MT_DROP_UNUSED;
@@ -1956,22 +1966,11 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct hid_report *report;
 	int ret;
 
-	if (td->is_haptic_touchpad && (td->mtclass.name == MT_CLS_WIN_8 ||
-	    td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
-	    td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
-		if (hi->application == HID_DG_TOUCHPAD) {
-			ret = hid_haptic_input_configured(hdev, td->haptic, hi);
-			if (ret < 0) {
-				td->haptic_init_error = ret;
-				td->is_haptic_touchpad = false;
-				return ret;
-			}
-			if (ret == 0)
-				td->is_haptic_touchpad = false;
-		}
-	} else {
+	if (td->is_haptic_touchpad &&
+	    td->mtclass.name != MT_CLS_WIN_8 &&
+	    td->mtclass.name != MT_CLS_WIN_8_FORCE_MULTI_INPUT &&
+	    td->mtclass.name != MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)
 		td->is_haptic_touchpad = false;
-	}
 
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
 		rdata = mt_find_report_data(td, report);
@@ -1983,6 +1982,22 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		mt_application = rdata->application;
 
 		if (rdata->is_mt_collection) {
+			if (td->is_haptic_touchpad &&
+			    hi->application == HID_DG_TOUCHPAD &&
+			    mt_application->application == HID_DG_TOUCHPAD &&
+			    td->haptic_pressure_input == hi->input &&
+			    !td->haptic->input_dev) {
+				ret = hid_haptic_input_configured(hdev, td->haptic,
+								  hi);
+				if (ret < 0) {
+					td->haptic_init_error = ret;
+					td->is_haptic_touchpad = false;
+					return ret;
+				}
+				if (ret == 0)
+					td->is_haptic_touchpad = false;
+			}
+
 			ret = mt_touch_input_configured(hdev, hi,
 							mt_application);
 			if (ret)
@@ -2211,6 +2226,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_hw_stop(hdev);
 		return ret;
 	}
+	if (!td->haptic->input_dev)
+		td->is_haptic_touchpad = false;
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
-- 
2.53.0

