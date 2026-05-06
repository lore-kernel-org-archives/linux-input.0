Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BD332913;
	Wed,  6 May 2026 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096021; cv=none; b=m7uGocVDCqbbyDRTy+IwWXVH4cXWYqxl86wCBdBqaVCPylMd85d3jQ+8jO1Yjh3hchDjOOilE6DnTDwAMmVKZ2cFl4ndRuKhgn8nm6SRZeqgWpe9PELCOeUfFBCYTHq+d13zpw7ilhzFgGhBsbSzk6J38akqNvxWUVoIY28LJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096021; c=relaxed/simple;
	bh=0E0riaforsFpDADYdFU7wxSXkiaEjNYCmu26Yajw9S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W926cFADP6pxkJ2TTWPZyi3oOPkJIalNQkx1tOY3wqNtZ6taOFVUbCoQeptGbvSjcPAXVPyBnHqQ9GMBE42jU4nbqZoUmOHjIcvL7blnjl7Xe3mQyP4SVLyD8BveTCkMVC+wgmeT/WHaHdRVsD/Ng+KtB84SLRhGOh2JhcsfN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=hJkzk35k; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="hJkzk35k"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4g9lsz6z7lz1DHbY;
	Wed,  6 May 2026 21:33:27 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4g9lsz5bLmz1DHpS;
	Wed,  6 May 2026 21:33:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1778096007;
	bh=5ziB+yeGoLE8bnmvg6gHy/PHSlDnMakEWu2jrT3ybss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJkzk35k6VxzY8T0TJFhlsSOXIlalXMQW3vSAMHI+IPKqM/AmYYmFDfEnJ3b7TYNM
	 ffXWGrB2xixYAl8aOgXMpuRv3OeXxFXKSMgo8p80XVRwYhwTB1h+6ExDXLOCw6cEE1
	 EcIAysHDGWmsYbAahY3wskxiQHpOdglSdSL5y2v+3Q7TOon9BxMefh4K7OoUR+h734
	 nnw8stcqAtPcnI82iMGvgTyvdcKnpmZBd+Cispe1rJBAZui2Y3acZ91H2T2ChEwGR0
	 NNiFnvEtx0CDRxaM4mRPbspCzHvrRfkDxKWk+yPhXzRopXUYDFUv8dZqLdgCbR3+3p
	 d1hD2vi1PMErQ==
From: =?UTF-8?q?Marcus=20Gren=C3=A4ngen?= <marcus@grenangen.se>
To: platform-driver-x86@vger.kernel.org,
	denis.benato@linux.dev
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luke@ljones.dev,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	corentin.chary@gmail.com,
	marcus@grenangen.se
Subject: [PATCH v2 1/3] HID: asus: export asus_hid_fnlock_notify() for direct fn-lock control
Date: Wed,  6 May 2026 21:33:24 +0200
Message-ID: <20260506193326.5862-2-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506193326.5862-1-marcus@grenangen.se>
References: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
 <20260506193326.5862-1-marcus@grenangen.se>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some ASUS platforms cannot control fn-lock via WMI DEVS and must send a
HID feature report directly to the N-Key keyboard device instead.

Add a module-level fnlock_hdev pointer (protected by a mutex) that is set
at probe time for devices with QUIRK_HID_FN_LOCK and cleared at remove.
Export asus_hid_fnlock_notify(bool) so that asus-armoury can call into
hid-asus without a circular dependency.

Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
---
 drivers/hid/hid-asus.c                     | 43 +++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |  5 +++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d34d74df3dc0..8a51dacf35eb 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -584,6 +584,38 @@ static void asus_sync_fn_lock(struct work_struct *work)
 	asus_kbd_set_fn_lock(drvdata->hdev, drvdata->fn_lock);
 }
 
+/*
+ * Module-level reference to the HID device that handles fn-lock via feature
+ * report. Set at probe and cleared at remove for QUIRK_HID_FN_LOCK devices.
+ * Protected by fnlock_hdev_lock.
+ */
+static DEFINE_MUTEX(fnlock_hdev_lock);
+static struct hid_device *fnlock_hdev;
+
+/**
+ * asus_hid_fnlock_notify() - Set fn-lock state directly via HID feature report.
+ * @enabled: true to lock fn (F1-F12 primary), false to unlock.
+ *
+ * Called by asus-armoury on platforms where the WMI DEVS path for fn-lock is
+ * non-functional (e.g. ASUS ProArt P16, N-Key keyboard product ID 0x19B6).
+ *
+ * Returns 0 on success, -ENODEV if no fn-lock capable HID device is present.
+ */
+int asus_hid_fnlock_notify(bool enabled)
+{
+	int ret = -ENODEV;
+
+	guard(mutex)(&fnlock_hdev_lock);
+	if (fnlock_hdev) {
+		ret = asus_kbd_set_fn_lock(fnlock_hdev, enabled);
+		/* hid_hw_raw_request returns byte count on success; normalise to 0 */
+		if (ret > 0)
+			ret = 0;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(asus_hid_fnlock_notify);
+
 static void asus_schedule_work(struct asus_kbd_leds *led)
 {
 	unsigned long flags;
@@ -969,6 +1001,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		drvdata->fn_lock = true;
 		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
 		asus_kbd_set_fn_lock(hdev, true);
+		guard(mutex)(&fnlock_hdev_lock);
+		fnlock_hdev = hdev;
 	}
 
 	if (drvdata->tp) {
@@ -1008,6 +1042,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		drvdata->fn_lock = true;
 		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
 		asus_kbd_set_fn_lock(hdev, true);
+		guard(mutex)(&fnlock_hdev_lock);
+		fnlock_hdev = hdev;
 	}
 
 	return 0;
@@ -1362,8 +1398,13 @@ static void asus_remove(struct hid_device *hdev)
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
 
-	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
+	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
+		scoped_guard(mutex, &fnlock_hdev_lock) {
+			if (fnlock_hdev == hdev)
+				fnlock_hdev = NULL;
+		}
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
+	}
 
 	hid_hw_stop(hdev);
 }
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 554f41b827e1..20facd5da74e 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -196,6 +196,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 int asus_hid_register_listener(struct asus_hid_listener *cdev);
 void asus_hid_unregister_listener(struct asus_hid_listener *cdev);
 int asus_hid_event(enum asus_hid_event event);
+int asus_hid_fnlock_notify(bool enabled);
 #else
 static inline void set_ally_mcu_hack(enum asus_ally_mcu_hack status)
 {
@@ -227,6 +228,10 @@ static inline int asus_hid_event(enum asus_hid_event event)
 {
 	return -ENODEV;
 }
+static inline int asus_hid_fnlock_notify(bool enabled)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */
-- 
2.54.0

