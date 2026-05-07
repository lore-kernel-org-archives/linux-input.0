Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7E3C1414;
	Thu,  7 May 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146159; cv=none; b=hoB5K93Xt8rstBmGuTfEe5mSaaIZz4imELQkvWEAe+frN5UvqlUb+KmTgVbiRM8lt4adJH5Ixe7seeQqkTsRuLWev43o6zrpoPleB7I7Y8j+YMoU2LH+jXcOVYJh7KCGCwyJYfT44StOzf1/Vwag4Z5AbOqGJ/sW1CrULxe1VBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146159; c=relaxed/simple;
	bh=H/tScrmyvamiUhGLeRMOmsQhhFV2sCrdw6L2HUZ1k8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJrue1TuNd6hjz9wMaYPV2Q3P1vN2mOlJtl1lC/scEp3xxidby5UWmt09C/aEKvERUAsRCSKu6nZZZPrSgtPhuTMGOcyNT8fMKFRse9AFOMgkxHKA5WXURwOEOwYvqDQPBf+Xr/+dCCtlNfzl19dCUGBZohcxuVqawk9/JdAo5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=VksDSn6g; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="VksDSn6g"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4gB6QK1pw1z1FQVX;
	Thu,  7 May 2026 11:29:13 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4gB6QJ5VFqz1FQVM;
	Thu,  7 May 2026 11:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1778146152;
	bh=FpCphwls28tEQgBfDnPaU5ckJ/fIPJvTY6hjNF0Fqdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VksDSn6gWODo9iEN5KQkJgMXp10iuvUe4rflAiRu5B9IvZKDs4RsSCJpwk6UPHvOH
	 BDux5qEhhujmjyKd6FLbB9hpmS+anLiq/OvhZ6q8p+3a/J9SpmeFmE4ANIImSNBtgy
	 zL1EzFf0TwvnOLKq/XHZa4EhLtoCKKzUh7ouHroh+Jf4iK4h7vYNPivrl3EJw+wlX+
	 qFMDz2o+kdl1x65csoCll9HvrEl/2JUDcsrxFZfbiKZXSwVagsH5XhggwQsHQ5pbUA
	 IEeFJwE8ADX6FdGNeEGNctbL9DftJ//5Sli2a0U/kkdm0a7Pj3dAalMzJ3/nHVszQ3
	 vqsRrSBNjFEQw==
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
Subject: [PATCH v3 2/3] platform/x86: asus-nb-wmi: add fnlock_use_hid quirk and asus_wmi_fnlock_use_hid()
Date: Thu,  7 May 2026 11:29:10 +0200
Message-ID: <20260507092911.8855-3-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507092911.8855-1-marcus@grenangen.se>
References: <9b568ce0-93f7-4a7f-98e4-625e910f8a1d@linux.dev>
 <20260507092911.8855-1-marcus@grenangen.se>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ASUS ProArt P16 (N-Key keyboard 0B05:19B6) advertises the WMI fn-lock
DEVID (0x00100023) as present via DSTS, but the DEVS call has no effect.
Fn-lock must instead be toggled via a HID feature report sent to the N-Key
keyboard (handled by hid-asus).

Add a fnlock_use_hid flag to struct quirk_entry and set it for the ProArt
P16 via a DMI match on DMI_PRODUCT_FAMILY.

Export asus_wmi_fnlock_use_hid() so that asus-armoury can query whether
the HID path is required without reading the quirk struct directly. This
keeps the DMI and quirk knowledge inside asus-wmi.

Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
---
 drivers/platform/x86/asus-nb-wmi.c         | 13 +++++++++++++
 drivers/platform/x86/asus-wmi.c            | 22 ++++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |  5 +++++
 include/linux/platform_data/x86/asus-wmi.h |  6 +++---
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b4677c5bba5b..44e4cf68ff70 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -155,6 +155,10 @@ static struct quirk_entry quirk_asus_z13 = {
 	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
+static struct quirk_entry quirk_asus_proart_p16 = {
+	.fnlock_use_hid = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -553,6 +557,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_z13,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ProArt P16",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
+		},
+		.driver_data = &quirk_asus_proart_p16,
+	},
 	{},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 80144c412b90..d4d742b9983d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1759,6 +1759,28 @@ int asus_hid_event(enum asus_hid_event event)
 }
 EXPORT_SYMBOL_GPL(asus_hid_event);
 
+/**
+ * asus_wmi_fnlock_use_hid() - Return true if fn-lock must use the HID path.
+ *
+ * On some platforms (e.g. ASUS ProArt P16) the WMI DEVS call for fn-lock is
+ * silently a no-op. The fnlock_use_hid quirk flag marks these platforms so
+ * that callers can select the HID feature-report path instead.
+ *
+ * Returns: true if the HID path should be used, false otherwise.
+ */
+bool asus_wmi_fnlock_use_hid(void)
+{
+	struct asus_wmi *asus;
+
+	guard(spinlock_irqsave)(&asus_ref.lock);
+	asus = asus_ref.asus;
+	if (!asus)
+		return false;
+
+	return asus->driver->quirks->fnlock_use_hid;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_fnlock_use_hid, "ASUS_WMI");
+
 /*
  * These functions actually update the LED's, and are called from a
  * workqueue. By doing this as separate work rather than when the LED
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 5cd4392b964e..6c50b11860e8 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -52,6 +52,11 @@ struct quirk_entry {
 	 */
 	int no_display_toggle;
 	u32 xusb2pr;
+	/*
+	 * Some platforms report WMI DEVID_FNLOCK as present but the DEVS call
+	 * is a no-op. Force the HID feature report path via hid-asus instead.
+	 */
+	bool fnlock_use_hid;
 };
 
 struct asus_wmi_driver {
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a88bf03f9c4d..199179266363 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -205,7 +205,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 int asus_hid_register_listener(struct asus_hid_listener *cdev);
 void asus_hid_unregister_listener(struct asus_hid_listener *cdev);
 int asus_hid_event(enum asus_hid_event event);
-int asus_hid_fnlock_set(bool enabled);
+bool asus_wmi_fnlock_use_hid(void);
 #else
 static inline void set_ally_mcu_hack(enum asus_ally_mcu_hack status)
 {
@@ -238,9 +238,9 @@ static inline int asus_hid_event(enum asus_hid_event event)
 	return -ENODEV;
 }
 
-static inline int asus_hid_fnlock_set(bool enabled)
+static inline bool asus_wmi_fnlock_use_hid(void)
 {
-	return -ENODEV;
+	return false;
 }
 #endif
 
-- 
2.54.0

