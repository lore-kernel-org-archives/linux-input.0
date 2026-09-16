Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83A377EC3;
	Wed, 16 Sep 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570147; cv=none; b=fqNKMxc4KsqL9X59KQug3R73UB6TqthFiJpkhi16DSrHCKNI/Hfo/PSpS+9s21AiHEZMlJ5i8JrVx15/rE6rv4NLRtBi0QE5FtEUkRq5/JwZ6HQfYeXX9YEBwKqHH2L+y4ijewa7vYYUWYC76PR4E5/9BKkQG9A/Ljjd6IsH3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570147; c=relaxed/simple;
	bh=Ow6NRNRTel+qnWJj5t/AKayGC+GkvCwurscAuIN4Z/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FP/lXorGkkNXBaEErRahzf2odGqcm7nMEE+e3k5BtRdioAUcIzaVnrfETLHP5gAnwZ0+0svSkC8jvAOw1husw7YUZ3RKmFib+b6p5SXNsd5MET1fURME9wSmu+GQmCl2Yj+FJoFSdFvk7gQGEdj7hGyFbQFvGkVH9sgNGR7tx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=apKd09Gd; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="apKd09Gd"
Received: from aerhardt-tuxedo.fritz.box (p57b95085.dip0.t-ipconnect.de [87.185.80.133])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id F371B2FC0089;
	Wed, 16 Sep 2026 16:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1789570136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ08eeysXG1lRjiC42kpWCK4V04RLtYU9wvMwjhAJaI=;
	b=apKd09GdLFvfK26BStD0KRKLmtTH5nw+tE2pduuEIGKiqTiye01tDhWTp1sqGoHEEYDwwD
	x/pUX257Im9RfjrwEcYUPUwrczqbZbG/W10N8yljv4Vi0OB2zaDeeJG/BlRaV7KrqjB3n3
	3brAngH0nnq0i+wZitFr2NEyUnOynb8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Aaron Erhardt <aer@tuxedocomputers.com>,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] HID: lamparray: blank lamps across suspend and restore on resume
Date: Wed, 16 Sep 2026 16:48:33 +0200
Message-ID: <20260916144838.456239-4-aer@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916144838.456239-1-aer@tuxedocomputers.com>
References: <20260916144838.456239-1-aer@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cristian Mazzotta <cmmazzo@icloud.com>

The helper installs no PM callbacks, so lamps keep their last state
across suspend. Firmware is not required to turn them off in low power
states, and on devices where it does not, they stay lit for the whole
suspend.

On an Acer Predator PT14-52T, system power draw during s2idle is 12.35W
with the lamps lit and 2.84W with them blanked, measured at the charger.

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
 drivers/hid/hid-generic.c     | 29 ++++++++++++++++++-
 drivers/hid/hid-lamparray.c   | 54 +++++++++++++++++++++++++++++++++++
 include/linux/hid-lamparray.h | 29 +++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index fde772c5014b..f78c62f796fb 100644
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
index acc00950495b..c7d4d3d1b02d 100644
--- a/drivers/hid/hid-lamparray.c
+++ b/drivers/hid/hid-lamparray.c
@@ -847,6 +847,60 @@ void lamparray_unregister(struct lamparray *la)
 }
 EXPORT_SYMBOL_GPL(lamparray_unregister);
 
+/*
+ * Blank all lamps on suspend rather than handing control back to the firmware,
+ * which may not turn them off in low power states. On an Acer Predator PT14-52T,
+ * system power draw during s2idle was ~12.35W with lamps lit, and ~2.84W with
+ * them blanked; the lighting accounted for ~77% of the power draw during suspend.
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
index a77869728d12..f7d0e22305e5 100644
--- a/include/linux/hid-lamparray.h
+++ b/include/linux/hid-lamparray.h
@@ -65,6 +65,27 @@ struct lamparray *lamparray_register(struct hid_device *hdev,
  */
 void lamparray_unregister(struct lamparray *la);
 
+/**
+ * lamparray_suspend() - blank all lamps ahead of sleep transition
+ * @la: LampArray handle returned by lamparray_register()
+ *
+ * Writes zeroes to the rgb values only, keeping the brightness, unless the
+ * use_leds_uapi sysfs attribute is 0, in which case, it will return early
+ * before writing anything. The cached state is left untouched so
+ * lamparray_resume() can restore it.
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
@@ -83,6 +104,14 @@ static inline void lamparray_unregister(struct lamparray *la)
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

