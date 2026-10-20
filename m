Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.90.84.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489996;
	b=b+9Yi4vVjq5CQ+JAc5UpETSaUVk/WtkVb3qPUaQrsW8QCC2CBCEjkKq4YXdqzzKss1PU
	 DJaKPuXoRet4qT6qpSoL3sF0uk5rwCkfNNS8WrMDQAA/BS9TNspT0yv0HIbMr57YOGSpx
	 DVllk1mihT8qTcyKIbD8QnsGCgig6Eg8pzhq8YzD1xGbweQ09U1ECJH+Rm3NNwutGd3my
	 7+mJiQaqTSQdyw35Wn+DWAoU/SHlp2QIuuZNk5Kiu567b1nEQYDhPgP+de0OSDRIfq54+
	 nj2x/qzMcBl41cC4JV+z0Jn9h0Hf3KyGlPxKkuy64C9doZLRQZ5ABCMxi9RWHKfrPoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489996;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lFQxO8k+vj500HfjNLXzltOIsVCC27jFZ9/nZ8FupzE=;
	b=xuSfZ6tHr2vv+9any+on73ChNXyNm0rTYhvW3TLNltsoyLY1T9RkZ22it8KEAtUXQSyQ
	 3sCmrC5RrfnoLhrflUywuvoNv8dBc3XEgiKtzGPAL9NkMrJuv0XSU6qn9brMjh9QuQ+L1
	 laQwhUZwgSSET8lS+jJx4p8gi823nVjfgwAvLZk8OvQiBHArxBZ17xyodItig3xoxuLwe
	 R0ZYQIh965MBUZZfbUsxonsfag7VEDeGbBDpBqMAhmlrsno4tfjtoYIvyCu7wZWo2Cefn
	 HI2mQv9KrutgRnwPuWMALCE/VLbsTIB66DD3gHlNIw/hAMUi7jVku23zNRzsautO1yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tuxedocomputers.com;
	spf=pass smtp.mailfrom=tuxedocomputers.com;
	dkim=pass header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.a=rsa-sha256 header.s=default header.b=T0SbFbqE;
	arc=none smtp.remote-ip=157.90.84.7
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58626606A319;
	Tue, 20 Oct 2026 09:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58626606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.a=rsa-sha256 header.s=default header.b=T0SbFbqE
Received: from [127.0.1.1] (business-024-134-105-141.24.134.pools.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id B82242FC0069;
	Tue, 20 Oct 2026 11:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1792489987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFQxO8k+vj500HfjNLXzltOIsVCC27jFZ9/nZ8FupzE=;
	b=T0SbFbqE9gyNM8z2cnh85vmxivkJrPusKGS2ZsNF6j72gv1UbEi9eNM53e/85OJ3zelQwt
	PCjXgYpwxz/5UoXGAEgfQMrEQOzOjAq3ZHUJKl+ol1pqRGjzOKBhb62mImOGe9GvrjLk9e
	s6woTfAgUOYoXPxkc2nsBFoYL1TCVfw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
Date: Tue, 20 Oct 2026 11:51:49 +0200
Subject: [PATCH v7 3/3] HID: lamparray: blank lamps across suspend and
 restore on resume
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-hid-lamparray-v7-3-47418b667b47@tuxedocomputers.com>
References: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
In-Reply-To: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Cristian Mazzotta <cmmazzo@icloud.com>, 
 Werner Sembach <wse@tuxedocomputers.com>, Armin Wolf <W_Armin@gmx.de>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Aaron Erhardt <aer@tuxedocomputers.com>
X-Mailer: b4 0.15.2

From: Cristian Mazzotta <cmmazzo@icloud.com>

The helper installs no PM callbacks, so lamps keep their last state
across suspend. Firmware is not required to turn them off in low power
states, and on devices where it does not, they stay lit for the whole
suspend.

On an Acer Predator PT14-52T, system power draw during s2idle is 12.35W
with the lamps lit and 3.14W with them blanked, measured at the charger.

Add lamparray_suspend(), which writes zeroes to the color channels
while leaving the cached RGB and brightness untouched, and
lamparray_resume(), which restores that cache. Both return early when
use_leds_uapi is 0 so a userspace driver keeps full control. hid-generic
gains suspend and resume callbacks to drive them, and calls
lamparray_resume() from reset_resume as well.

Some devices return to firmware control across a hibernate transition
while still reporting AutonomousMode = 0, and ignore host lamp updates
until the value genuinely transitions. Force a 1 -> 0 on resume
before restoring state.

Co-developed-by: Aaron Erhardt <aer@tuxedocomputers.com>
Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
Signed-off-by: Cristian Mazzotta <cmmazzo@icloud.com>
---
 drivers/hid/hid-generic.c     | 29 ++++++++++++++++++++++-
 drivers/hid/hid-lamparray.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid-lamparray.h | 29 +++++++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index fde772c5014bb..f78c62f796fbb 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -102,9 +102,34 @@ static int hid_generic_probe(struct hid_device *hdev,
 
 static int hid_generic_reset_resume(struct hid_device *hdev)
 {
+	struct lamparray *la = hid_get_drvdata(hdev);
+
 	if (hdev->claimed & HID_CLAIMED_INPUT)
 		hidinput_reset_resume(hdev);
 
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
+		lamparray_resume(la);
+
+	return 0;
+}
+
+static int hid_generic_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	struct lamparray *la = hid_get_drvdata(hdev);
+
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
+		lamparray_suspend(la);
+
+	return 0;
+}
+
+static int hid_generic_resume(struct hid_device *hdev)
+{
+	struct lamparray *la = hid_get_drvdata(hdev);
+
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
+		lamparray_resume(la);
+
 	return 0;
 }
 
@@ -129,8 +154,10 @@ static struct hid_driver hid_generic = {
 	.id_table = hid_table,
 	.match = hid_generic_match,
 	.probe = hid_generic_probe,
-	.reset_resume = hid_generic_reset_resume,
 	.remove = hid_generic_remove,
+	.reset_resume = pm_ptr(hid_generic_reset_resume),
+	.suspend = pm_ptr(hid_generic_suspend),
+	.resume = pm_ptr(hid_generic_resume),
 };
 module_hid_driver(hid_generic);
 
diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
index fb3082f6d19a0..5c97cafbd25d2 100644
--- a/drivers/hid/hid-lamparray.c
+++ b/drivers/hid/hid-lamparray.c
@@ -852,6 +852,60 @@ void lamparray_unregister(struct lamparray *la)
 }
 EXPORT_SYMBOL_GPL(lamparray_unregister);
 
+/*
+ * Blank all lamps on suspend rather than handing control back to the firmware,
+ * which may not turn them off in low power states. On an Acer Predator PT14-52T,
+ * system power draw during s2idle was ~12.35W with lamps lit, and ~3.14W with
+ * them blanked; the lighting accounted for ~75% of the power draw during suspend.
+ * Since writing zeroes is well defined on all lamparray devices, always do it.
+ * This is ignored if use_leds_uapi is 0; let userspace keep full control.
+ */
+void lamparray_suspend(struct lamparray *la)
+{
+	struct lamparray_device *ldev;
+
+	if (!la)
+		return;
+
+	ldev = &la->ldev;
+
+	if (!ldev->use_leds_uapi)
+		return;
+
+	mutex_lock(&ldev->dev_lock);
+	lamparray_hw_set_state(ldev, 0, 0, 0, 0);
+	mutex_unlock(&ldev->dev_lock);
+
+	hid_hw_wait(ldev->hdev);
+}
+EXPORT_SYMBOL_GPL(lamparray_suspend);
+
+void lamparray_resume(struct lamparray *la)
+{
+	struct lamparray_device *ldev;
+
+	if (!la)
+		return;
+
+	ldev = &la->ldev;
+
+	if (!ldev->use_leds_uapi)
+		return;
+
+	/*
+	 * After a S4 transition, some devices report
+	 * AutonomousMode = 0 while still ignoring host lamp updates.
+	 * Writing 0 again does nothing; forcing a 1 -> 0
+	 * will guarantee the device will update.
+	 */
+	lamparray_hw_set_autonomous(ldev, true);
+	hid_hw_wait(ldev->hdev);
+	lamparray_hw_set_autonomous(ldev, false);
+
+	lamparray_restore_state(ldev);
+}
+EXPORT_SYMBOL_GPL(lamparray_resume);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Tim Guttzeit <tgu@tuxedocomputers.com>");
 MODULE_AUTHOR("Aaron Erhardt <aer@tuxedocomputers.com>");
diff --git a/include/linux/hid-lamparray.h b/include/linux/hid-lamparray.h
index 6124878859392..dc9df938e5b7e 100644
--- a/include/linux/hid-lamparray.h
+++ b/include/linux/hid-lamparray.h
@@ -66,6 +66,27 @@ struct lamparray *lamparray_register(struct hid_device *hdev,
  */
 void lamparray_unregister(struct lamparray *la);
 
+/**
+ * lamparray_suspend() - blank all lamps ahead of sleep transition
+ * @la: LampArray handle returned by lamparray_register()
+ *
+ * Writes zeroes to the rgb and brightness values, unless the use_leds_uapi
+ * sysfs attribute is 0, in which case, it will return early before writing
+ * anything. The cached state is left untouched so lamparray_resume() can
+ * restore it.
+ */
+void lamparray_suspend(struct lamparray *la);
+
+/**
+ * lamparray_resume() - restore host control and LampArray state
+ * @la: LampArray handle returned by lamparray_register()
+ *
+ * Disables autonomous mode (in case device returns to firmware control after suspend)
+ * and restores the cached state of the device. If the use_leds_uapi attribute is 0,
+ * it will return early and prevent any unwanted writing.
+ */
+void lamparray_resume(struct lamparray *la);
+
 #else /* !CONFIG_HID_LAMPARRAY */
 
 static inline bool lamparray_is_supported_device(struct hid_device *hdev)
@@ -84,6 +105,14 @@ static inline void lamparray_unregister(struct lamparray *la)
 {
 }
 
+static inline void lamparray_suspend(struct lamparray *la)
+{
+}
+
+static inline void lamparray_resume(struct lamparray *la)
+{
+}
+
 #endif /* CONFIG_HID_LAMPARRAY */
 
 #endif /* _HID_LAMPARRAY_H */

-- 
2.43.0

