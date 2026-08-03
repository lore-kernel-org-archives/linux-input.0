Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22A443AAD
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782830; cv=none; b=RDqVZLcQGeDQ2b0uaATeDb9JChsWJufGGWi4HdPmtqkIduT0Z7xt4n/tcGg5PsrffkNqIUbg0V36F38Gqt/gHtFvmKJ4Jk+uh9quhykFHv95Q/04+c+X5X0VwaVMmDOPJD1LBBYd0hRuyuMVNcTCKABN39QbVHsn68qDE52vGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782830; c=relaxed/simple;
	bh=Yoi3lubzRKWVWpcvd3Ifx+IIKQYam/xYCacTplW9mOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5sn27eo6Epf7XDRhWO35kHKAl7/NoB0XyAXpDJf1uluQuvRHcakRB0pJ47EWBLioaZPcQJk2iOUKUQ+/7GbU/q3YWlwch3CUmosaoi6EDOjDHqrwt2vTRFuNnJdHcswvuHT8t1VQzjIiQeYWmbOAGsjFpEtbSYKrg4Yqtydfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbny/eZZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbny/eZZ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso2651543a12.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782825; x=1786387625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhNt75xrdH23XiQfHURUjEm4mC5u0bmXUDGMCww7WdI=;
        b=Wbny/eZZnYcxHGcyDYuqUE5R5b8+1HuCkouS6P99ImtVDUfIY6wge9Uerdtwr94PS2
         ouaeTKPyKpess511lqIqgJvPqAX7tP5zMT59A2Zn0TPcdmckpKgFewOWp9SQB9654y74
         MN5YFZd0bY0KZIkkT9t7Q6XxyAvOC/oLWVCrjNsqR+ScuvNjvQvVaWyRxd4fRqWYTSk7
         B/zNxqhyz02yZxu+s5kaJZflI1Y8tuNAUfsNbLqXr2hlgWKCymX99XaBzbQENBwttgk1
         n2VqhFThaKl8EUI32VJs6WEWJ/ITPgka6fDkMlgGIFwqc/LCkZ/9mYPjMesG1e44FkPz
         Fqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782825; x=1786387625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhNt75xrdH23XiQfHURUjEm4mC5u0bmXUDGMCww7WdI=;
        b=i8QPTZCByiOUcqp9DVDcHGSZZtKXwhksH5CKSvQuunFz1hnB2B20ta/yonfyoeuyax
         Y3wyW7161wB45IsumCz3dTxLnRjomvYpgPKEoapXcc9GxYTyZPfj+Hh8M+t78ZixdT8E
         eKZDXCtGY/OKuxfPE7vwo2VlknjIZf6r0ezObv2D4HSR1VCMGts0ncdOszeJdxA7yJRw
         wjxD+6BnOZwW0gvAdbOrqlI7BTtsyL5JovFlErsp+O4LiYD+d9c+akJM1xP80sxQYWIc
         kcNSTicM+GS/tIXwvubDZGxlOrOB7BizyT//WemmAce4K0UKWHyuvOmYwOhHBI9Vvk9L
         XYkA==
X-Gm-Message-State: AOJu0Yz/9Heh/H5KntrYVTCQ8EDs2fai4ZprllMbuKbW0Vz/Rm3AE7qO
	YGuBJZndBw32evF3j2kHzv5MfMDX5+5mufYjbIJm89sQ+EFUPC8J/eky
X-Gm-Gg: AR+sD11saRCS1mV5m5OJOq5crKID5yc3uc1JVmQuud1+avXMsUwLQ9RMUy3jZcq/rmT
	lipNcfxkGvL8jViNn1JQmkQv05gs1OROGbv9yLeZOrDDNAAMUYb0aAd0gxgxgLIZrMCa2OYtEht
	SsSRNtLTjm6wdMbRslS4BRKOG6ofYCkXSMqsi+Ebb7IFzv+fqajW8FbRArXpQJj16XlnrCv1RIw
	G92XZ/0iMXI03GpSGNAqE7+4dyjv78QNr75XmsPi2w14bhPoxZGT8jxGmjEdYhOfiKme+yNSKR3
	QfTRHjd42bTXMVkG0BavgGrUTVVryJV8IxcD0k8Toa9eo8wmp1yUZGf0Byegw9z/WZysuNddcbX
	+I7ElNG0vRtWsa1sctsPEL0P3uZM3WuPNj5GYT+ANig3mlR9sLceFfHBeHRXAr4SFah4P3CTbf/
	HHhhspPSjv4rcmXpX/Ef5GBM3MDuNfPOJr/v3XnmYIiCZx6hC8FPaLpFeGiOo/BsL28wHuoYglx
	qx0Gq/Ajyd0NKSaEBvm0ev7oiAlfCgCZh3Ni7oQcUuG+Yb9ep2c
X-Received: by 2002:a05:6a20:93a0:b0:3c3:bbe6:95b1 with SMTP id adf61e73a8af0-3c92a5d6d57mr11389147637.24.1785782825402;
        Mon, 03 Aug 2026 11:47:05 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:47:04 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:46 -0700
Subject: [PATCH 21/21] HID: haptic: move FF initialization into
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-21-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.16-dev-b242f

Refactor hid_haptic_init() to take a direct pointer to input_dev and
integrate its invocation into hid_haptic_input_configured().

Update hid-multitouch to rely on the refactored callback to perform the
force-feedback initialization during the registration loop. This ensures
that force-feedback capabilities are set up before the input device is
registered and exposed to userspace, closing the registration race.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-haptic.c     | 45 +++++++++++++++++---------------------------
 drivers/hid/hid-haptic.h     |  6 ++++--
 drivers/hid/hid-multitouch.c | 10 +---------
 3 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index deadab28cdbe..5d365a9767dd 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -82,16 +82,24 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_input *hi)
 {
+	int error;
 
-	if (hi->application == HID_DG_TOUCHPAD) {
-		if (haptic->auto_trigger_report &&
-		    haptic->manual_trigger_report) {
-			__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
-			return 1;
-		}
+	if (hi->application != HID_DG_TOUCHPAD)
+		return -1;
+
+	if (!haptic->auto_trigger_report || !haptic->manual_trigger_report)
+		return 0;
+
+	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
+
+	error = hid_haptic_init(hdev, haptic, hi->input);
+	if (error) {
+		dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
+			 hdev->name);
 		return 0;
 	}
-	return -1;
+
+	return 1;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
 
@@ -401,11 +409,9 @@ static void hid_haptic_destroy(struct ff_device *ff)
 }
 
 int hid_haptic_init(struct hid_device *hdev,
-		    struct hid_haptic_device **haptic_ptr)
+		    struct hid_haptic_device *haptic,
+		    struct input_dev *dev)
 {
-	struct hid_haptic_device *haptic = *haptic_ptr;
-	struct input_dev *dev = NULL;
-	struct hid_input *hidinput;
 	struct ff_device *ff;
 	int ret = 0, r;
 	struct ff_haptic_effect stop_effect = {
@@ -447,19 +453,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	for (r = 0; r < haptic->auto_trigger_report->maxfield; r++)
 		parse_auto_trigger_field(haptic, haptic->auto_trigger_report->field[r]);
 
-	list_for_each_entry(hidinput, &hdev->inputs, list) {
-		if (hidinput->application == HID_DG_TOUCHPAD) {
-			dev = hidinput->input;
-			break;
-		}
-	}
-
-	if (!dev) {
-		dev_err(&hdev->dev, "Failed to find the input device\n");
-		ret = -ENODEV;
-		goto duration_map;
-	}
-
 	haptic->input_dev = dev;
 	haptic->manual_trigger_report_len =
 		hid_report_len(haptic->manual_trigger_report);
@@ -535,10 +528,6 @@ int hid_haptic_init(struct hid_device *hdev,
 
 input_free:
 	input_ff_destroy(dev);
-	/* Do not let double free happen, input_ff_destroy will call
-	 * hid_haptic_destroy.
-	 */
-	*haptic_ptr = NULL;
 	/* Restore dev flush and event */
 	dev->flush = flush;
 	dev->event = event;
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index c6539ac04c1d..6332991a7844 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -69,7 +69,8 @@ int hid_haptic_input_mapping(struct hid_device *hdev,
 int hid_haptic_input_configured(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_input *hi);
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device **haptic_ptr);
+int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+		    struct input_dev *dev);
 void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
@@ -107,7 +108,8 @@ static inline
 void hid_haptic_reset(struct hid_device *hdev, struct hid_haptic_device *haptic)
 {}
 static inline
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device **haptic_ptr)
+int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+		    struct input_dev *dev)
 {
 	return 0;
 }
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index edb37b4c867e..15218e92aaa4 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2189,16 +2189,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
-	if (td->is_haptic_touchpad) {
-		if (hid_haptic_init(hdev, &td->haptic)) {
-			dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
-				 hdev->name);
-			td->is_haptic_touchpad = false;
-			devm_kfree(&hdev->dev, td->haptic);
-		}
-	} else {
+	if (!td->is_haptic_touchpad)
 		devm_kfree(&hdev->dev, td->haptic);
-	}
 
 	return 0;
 }

-- 
2.55.0.629.g250fe7f194-goog

