Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D47393DEF
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245838; cv=none; b=Oomf9VH6XLkIo2hockGjTxXbflQx6CpJkxWkwBZJq1gmtPtCMx7pm7ou82ojDt59MI13zRaZZxDrNsTLi91Q8V98JyctzJUlJNpQqt3yCdDxfadvTOPrvW9eaWiAa2QC0uFw20RI/G8UHDJ8owQmJnra+cDGfYCzyg+73r7EK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245838; c=relaxed/simple;
	bh=R/ppOm6xLCcId/YOqpQGPwjUXFdluk3LWmR0Dr1CQt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOrtd8Vw6WAg1McNwSMuJrlf2aiC2uEcy/KKysYcRSrD8qRnq1/b/oFhyFtRSrTtM3SI/58l4cQ4VwpOwqgrnBXqY41AxBlnydFY+rh9F/0aaBrFfPgaeSD/nzn0e+gSYDnOVZYUMdboO/KqD8BI+fmNDIJMwl8bl6MzjUcdrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDW3giVW; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDW3giVW"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16ad92569b5so768277c88.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792245836; x=1792850636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWkTtPIrc9pYOzW7VOGtIbj3dOS0HMwe3RZwxPlEVFk=;
        b=JDW3giVWc53w/YDF7OhOvKJ2xCUPkbPqsCBF9wYdRrFrvXr9fVd/3jUjFI1Ix+aqBN
         yntW78IYVnhYj0M4lE7AwlTSjoU9yuQa1FVb2Y2769I6hcwOI6W3AtUA9BOce3V/hD7W
         SeI4ZQ89WDAWkqBxZ8N8Q2Sx43zcKpYF8SAElZCGOZdeuXLWtolKZwLaeMICM6Akfy8L
         DgDDGBuTEVc/yprBDfAJmtzU+C+tBrUjb/rBnaId91vv4RNvhyMsIQA10vl3xyMEpOEi
         vecWPjc9YA2xnO4uoply54A/bzydiLSFPJoP75Tm8VGvAZHnGodF7Sy47nz2DYOJq+Fi
         KJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245836; x=1792850636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pWkTtPIrc9pYOzW7VOGtIbj3dOS0HMwe3RZwxPlEVFk=;
        b=QYWbA5ZwRhthzSzvmv+NQQ4YMeSsHLLsxzeimIiJfFGIOH2XG2AFC0xHhjEyMqTfzO
         q4ECKhEtBT9Ek1JqOnqpnXQitogmQ2Nx1zqXo+bbUAo2KPrcBC/Udmfas6bJq627XGnD
         GLf4ZtuypfnY2ikfJaQOVmcCR2MuwpxCIA4UEpvGl2AUJnivfGrd30xVUgtdMLpfrNK+
         XCKZ8/qfLKFWJdQQCWGloaRVsMAEOl86ZL36aOW3+rgoNIRRzMC88QM/oI42T2nc2An6
         0QNig7vxKSMwcOeq710gu+fNTxFxtcAYQdU/236/C9SmOT+lX3roeqXu91iDbBrxUDMH
         NCJA==
X-Forwarded-Encrypted: i=1; AKwUvBxd71OxjLihkXiR3e9D5rflFjdYkIkMPTUTMO+GumGmU1brN6dDL42vUyGDyb9u5UCW2RkOyoDzyHbDug==@vger.kernel.org
X-Gm-Message-State: AFq9FYKfyaCX/jdh81qgK8p78gHXE9zBX7MPZkTcyLyYayr/Q25ofiGz
	59a+rDe/Q6CcoCw6xyt98BjYSRcl5dlpgPUFGcd76NsuOIfQ1Q0O6UPA
X-Gm-Gg: AYBFou04l4Dm6AWmLpUlzUiyHAFHzizzABzpWsS8OQ0vlstbYkr6ZA1U9eZOJknImto
	KghbHJ9Y+MIsukf5763AyVMEifaRPTg6/bprCrOvnIYYPBFtyKPzgXhWSo/wn4VGazdivPb2Jbh
	adfw5UCDv4mLxS5w1cs3TaGdpHsuJSVQ6E1QEy89fVRLCmLRaSa2k73huOQyjJFlaD6d95Z/QNk
	hytkAqfwuMM89QrktQmtboWrEM95rdF+7JeXpmbNGDV43Viq7/+PO+ZBbxxwAYqK1Jh/tbJjh/g
	KuNhe7qdpNdcrJi3QF7NpBrZ+8AloRjuBxSyEI1GcDGgaJTKpgjZVdlv7VeQn+6l+4BhyWmfvSW
	cNZKMcf7U6yweq8sTgZQhozEw2bPBnMfoVW9VA0fDyLTdRrw++4Hz9c+8Ul6Yl7QjVbvKsWe25B
	dZR0TzyE0O291iRAKacLZU/q/k6Z7LazZLkivoAHqo8PPWgdWs+uxue9TufBs50gPWfeweeEY=
X-Received: by 2002:a05:7023:d05:b0:16e:c820:b20d with SMTP id a92af1059eb24-1850cda6d0amr5523543c88.5.1792245835404;
        Sat, 17 Oct 2026 07:03:55 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm12727648c88.14.2026.10.17.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:03:54 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v9 2/2] HID: multitouch: give FF core ownership of haptic state
Date: Sat, 17 Oct 2026 11:03:32 -0300
Message-ID: <20261017140332.1480375-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017140332.1480375-1-qwe.aldo@gmail.com>
References: <20261017140332.1480375-1-qwe.aldo@gmail.com>
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
then frees it at final input device release. Scope cleanup frees the
clone on initialization failure. The multitouch driver keeps its
mapping allocation and needs no ownership tracking for the FF state.

Record the first successfully configured input in the mapping state
and skip FF initialization for later touchpad inputs. They share HID
reports, so separate FF instances would write the same report fields
under different mutexes.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c | 16 ++++++++++++++--
 drivers/hid/hid-haptic.h |  6 ++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 0a6126e..b0fb94f 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/input/mt.h>
 #include <linux/module.h>
 
@@ -92,6 +93,10 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 
 	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
 
+	/* The HID reports are shared; create only one FF instance. */
+	if (haptic->input_dev)
+		return 1;
+
 	error = hid_haptic_init(hdev, haptic, hi->input);
 	if (error) {
 		dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
@@ -99,6 +104,8 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 		return error;
 	}
 
+	haptic->input_dev = hi->input;
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
@@ -414,9 +421,11 @@ static void hid_haptic_destroy(struct ff_device *ff)
 }
 
 int hid_haptic_init(struct hid_device *hdev,
-		    struct hid_haptic_device *haptic,
+		    const struct hid_haptic_device *config,
 		    struct input_dev *dev)
 {
+	struct hid_haptic_device *haptic __free(kfree) =
+		kmemdup(config, sizeof(*config), GFP_KERNEL);
 	struct ff_device *ff;
 	int ret = 0, r;
 	struct ff_haptic_effect stop_effect = {
@@ -425,6 +434,9 @@ int hid_haptic_init(struct hid_device *hdev,
 	const char *prefix = "hid-haptic";
 	char *name;
 
+	if (!haptic)
+		return -ENOMEM;
+
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
 	haptic->max_duration_id = max(2u, haptic->max_duration_id);
@@ -517,7 +529,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->stop = hid_haptic_stop;
 	ff->destroy = hid_haptic_destroy;
 	__module_get(THIS_MODULE);
-	ff->private = haptic;
+	ff->private = no_free_ptr(haptic);
 	return 0;
 
 ff_cap_clear:
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
-- 
2.53.0

