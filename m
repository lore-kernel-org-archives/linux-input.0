Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BD2F5A06;
	Thu, 30 Apr 2026 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536857; cv=none; b=GC+6QWF1MLdUMtuY+cxGQbWbLo4hFai2cMmsLcRrakSVFn+eR5e+auVQR8+L+F5hKcQFRnLVU2MUaQQ6vJAHlcu3CU2amlEsSkSwYKBcIYgDZ+V1FlXRSXjW1IKfNcz2/3gxlzCcvmXS9KpgsGZkFP8l8ifEyJzgfd3wUXTRqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536857; c=relaxed/simple;
	bh=tMoFJ69uaE52hLT1u3ToQcYIaqKO3QC4DBh853y5pFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1rWqLKsk5+p7s6q9ZGfJN/RqPZq6g9RsQ71bxaSsnFK5yRErsULEevjU6GwHWs+zv1WHpIGC0Clk84fpj1YbT9K5WpHBpDysmz1VzoZfCnLhZOZfJupTieHbOff3PjgaDJh/r0fqGAHx7RE8UY68z//LmVR2v2h7xrQtWYhI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=mI+gjHqH; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="mI+gjHqH"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4g5mtx0HNDz1DDS8;
	Thu, 30 Apr 2026 10:05:29 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4g5mtw15z1z1DDST;
	Thu, 30 Apr 2026 10:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1777536328;
	bh=ALBPMtNgTnH1HXHJFPbo+yMEp737dyTrIFPJpBH/4Co=;
	h=From:To:Cc:Subject:Date;
	b=mI+gjHqHlVxoFSQBM/BzFKTArJ59l7Zz02bbcU/oxIl542yx7JsyHMcVizEkKn1lW
	 ut5AWjDUKfagcEoJkUFDGS4Mwn27Nh7WfBDKenY8y4sUk9pkV5eqMO/BCdTaAJ2HuG
	 GEF58KrrfJs4coexPSjLKSCYKk7RDnUyVKObpBwerI5UNABytNsKzNkOJHwtxOU2+i
	 UusNK1Gq+qMIN4ItIfl2d7UrlvMcAq9QYkPBO8tS64d6BJWKCMvD/cHMgh8w35nvLc
	 Yk3HuzQjZBmk/rEoCRQbtAAZEpk7ryG6DpQvGiAV3yV9u4NVWItaDTlax0pgd0E/GI
	 zqfo6PW17f1Og==
From: =?UTF-8?q?Marcus=20Gren=C3=A4ngen?= <marcus@grenangen.se>
To: platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luke@ljones.dev,
	denis.benato@linux.dev,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	corentin.chary@gmail.com,
	=?UTF-8?q?Marcus=20Gren=C3=A4ngen?= <marcus@grenangen.se>
Subject: [PATCH] platform/x86: asus-wmi: fix fn-lock on platforms where WMI DEVS is a no-op
Date: Thu, 30 Apr 2026 10:05:27 +0200
Message-ID: <20260430080527.12754-1-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some ASUS laptops (e.g. ProArt P16, N-Key keyboard 0B05:19B6) advertise
the WMI fn-lock DEVID (0x00100023) as present but the DEVS call has no
effect. On these machines fn-lock must be toggled via a HID feature report
sent directly to the N-Key keyboard, which is handled by hid-asus.

Add a DMI quirk flag fnlock_use_hid for such platforms. When set,
asus_wmi_has_fnlock_key() checks for a registered hid-asus listener that
supports fnlock instead of querying DEVS, and asus_wmi_fnlock_update()
dispatches to asus_hid_set_fnlock().

Extend struct asus_hid_listener with a fnlock_set callback and wire it up
in hid-asus for QUIRK_ROG_NKEY_KEYBOARD + QUIRK_HID_FN_LOCK devices.
Initialize fn_lock_sync_work and register the listener in the probe path
for these keyboards (previously the early return for ROG N-Key devices
skipped asus_input_configured where this was done).

Also add a fnlock_status sysfs attribute (RW) under the asus-wmi platform
device so userspace (e.g. asusctl) can read and set fn-lock state without
needing to open /dev/hidraw directly.

Fix a NULL pointer dereference in do_kbd_led_set(): brightness_set was
called unconditionally on all listeners, but listeners that only implement
fnlock_set leave brightness_set NULL.

Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
---
 drivers/hid/hid-asus.c                     |  24 ++++-
 drivers/platform/x86/asus-nb-wmi.c         |  13 +++
 drivers/platform/x86/asus-wmi.c            | 101 ++++++++++++++++++++-
 drivers/platform/x86/asus-wmi.h            |   5 +
 include/linux/platform_data/x86/asus-wmi.h |   7 +-
 5 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d34d74df3dc0..71ced03c0f7e 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -143,6 +143,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct work_struct fn_lock_sync_work;
 	bool fn_lock;
+	struct asus_hid_listener fn_lock_listener;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -584,6 +585,15 @@ static void asus_sync_fn_lock(struct work_struct *work)
 	asus_kbd_set_fn_lock(drvdata->hdev, drvdata->fn_lock);
 }
 
+static void asus_hid_fnlock_set(struct asus_hid_listener *listener, bool enabled)
+{
+	struct asus_drvdata *drvdata =
+		container_of(listener, struct asus_drvdata, fn_lock_listener);
+
+	drvdata->fn_lock = enabled;
+	schedule_work(&drvdata->fn_lock_sync_work);
+}
+
 static void asus_schedule_work(struct asus_kbd_leds *led)
 {
 	unsigned long flags;
@@ -1319,8 +1329,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 * For ROG keyboards, skip rename for consistency and ->input check as
 	 * some devices do not have inputs.
 	 */
-	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD)
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
+		if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
+			drvdata->fn_lock = true;
+			INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
+			asus_kbd_set_fn_lock(hdev, true);
+			drvdata->fn_lock_listener.fnlock_set = asus_hid_fnlock_set;
+			asus_hid_register_listener(&drvdata->fn_lock_listener);
+		}
 		return 0;
+	}
 
 	/*
 	 * Check that input registration succeeded. Checking that
@@ -1362,8 +1380,10 @@ static void asus_remove(struct hid_device *hdev)
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
 
-	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
+	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
+		asus_hid_unregister_listener(&drvdata->fn_lock_listener);
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
+	}
 
 	hid_hw_stop(hdev);
 }
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
index 80144c412b90..70758a20551d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1759,6 +1759,24 @@ int asus_hid_event(enum asus_hid_event event)
 }
 EXPORT_SYMBOL_GPL(asus_hid_event);
 
+/*
+ * Called by asus-wmi to propagate an fn-lock state change to all registered
+ * hid-asus listeners. Used on platforms where the WMI DEVS path for fn-lock
+ * (0x00100023) is a no-operation and the HID feature report path must be used
+ * instead (e.g. ASUS ProArt P16, USB keyboard product ID 0x19B6).
+ */
+void asus_hid_set_fnlock(bool enabled)
+{
+	struct asus_hid_listener *listener;
+
+	guard(spinlock_irqsave)(&asus_ref.lock);
+	list_for_each_entry(listener, &asus_ref.listeners, list) {
+		if (listener->fnlock_set)
+			listener->fnlock_set(listener, enabled);
+	}
+}
+EXPORT_SYMBOL_GPL(asus_hid_set_fnlock);
+
 /*
  * These functions actually update the LED's, and are called from a
  * workqueue. By doing this as separate work rather than when the LED
@@ -1852,7 +1870,8 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
 
 	scoped_guard(spinlock_irqsave, &asus_ref.lock) {
 		list_for_each_entry(listener, &asus_ref.listeners, list)
-			listener->brightness_set(listener, asus->kbd_led_wk);
+			if (listener->brightness_set)
+				listener->brightness_set(listener, asus->kbd_led_wk);
 	}
 }
 
@@ -4495,21 +4514,64 @@ static void asus_screenpad_exit(struct asus_wmi *asus)
 
 /* Fn-lock ********************************************************************/
 
+static bool asus_hid_has_fnlock_listener(void)
+{
+	struct asus_hid_listener *listener;
+
+	guard(spinlock_irqsave)(&asus_ref.lock);
+	list_for_each_entry(listener, &asus_ref.listeners, list) {
+		if (listener->fnlock_set)
+			return true;
+	}
+	return false;
+}
+
 static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
 {
 	u32 result;
 
+	/* Some platforms have a non-functional WMI path — use HID directly */
+	if (asus->driver->quirks->fnlock_use_hid)
+		return asus_hid_has_fnlock_listener();
+
 	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FNLOCK, &result);
 
-	return (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
-		!(result & ASUS_WMI_FNLOCK_BIOS_DISABLED);
+	if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+	    !(result & ASUS_WMI_FNLOCK_BIOS_DISABLED))
+		return true;
+
+	/*
+	 * Some platforms (e.g. ASUS ProArt P16) have a non-functional WMI
+	 * DEVS path for fn-lock (DEVS returns One unconditionally with no
+	 * side effects). On these platforms fn-lock is controlled via a HID
+	 * feature report sent directly to the N-Key keyboard. Return true if
+	 * a hid-asus listener with fnlock support has registered, so that
+	 * asus-wmi can manage the fn-lock state and expose the sysfs knob.
+	 */
+	return asus_hid_has_fnlock_listener();
 }
 
 static void asus_wmi_fnlock_update(struct asus_wmi *asus)
 {
 	int mode = asus->fnlock_locked;
+	u32 result;
 
-	asus_wmi_set_devstate(ASUS_WMI_DEVID_FNLOCK, mode, NULL);
+	/* Platform has non-functional WMI DEVS for fn-lock — use HID directly */
+	if (asus->driver->quirks->fnlock_use_hid) {
+		asus_hid_set_fnlock(mode);
+		return;
+	}
+
+	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FNLOCK, &result);
+
+	if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+	    !(result & ASUS_WMI_FNLOCK_BIOS_DISABLED)) {
+		asus_wmi_set_devstate(ASUS_WMI_DEVID_FNLOCK, mode, NULL);
+		return;
+	}
+
+	/* WMI path absent or non-functional — delegate to hid-asus */
+	asus_hid_set_fnlock(mode);
 }
 
 /* WMI events *****************************************************************/
@@ -4690,6 +4752,34 @@ static ssize_t cpufv_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_WO(cpufv);
 
+static ssize_t fnlock_status_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->fnlock_locked);
+}
+
+static ssize_t fnlock_status_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	bool enable;
+	int err;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	asus->fnlock_locked = enable;
+	asus_wmi_fnlock_update(asus);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(fnlock_status);
+
 static struct attribute *platform_attributes[] = {
 	&dev_attr_cpufv.attr,
 	&dev_attr_camera.attr,
@@ -4698,6 +4788,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
+	&dev_attr_fnlock_status.attr,
 #if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 		&dev_attr_charge_mode.attr,
 		&dev_attr_egpu_enable.attr,
@@ -4741,6 +4832,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
+	else if (attr == &dev_attr_fnlock_status.attr)
+		ok = asus_wmi_has_fnlock_key(asus);
 
 #if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 	if (attr == &dev_attr_charge_mode.attr)
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
index 554f41b827e1..569289417a51 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -173,10 +173,11 @@ enum asus_ally_mcu_hack {
 	ASUS_WMI_ALLY_MCU_HACK_DISABLED,
 };
 
-/* Used to notify hid-asus when asus-wmi changes keyboard backlight */
+/* Used to notify hid-asus when asus-wmi changes keyboard backlight or fn-lock */
 struct asus_hid_listener {
 	struct list_head list;
 	void (*brightness_set)(struct asus_hid_listener *listener, int brightness);
+	void (*fnlock_set)(struct asus_hid_listener *listener, bool enabled);
 };
 
 enum asus_hid_event {
@@ -196,6 +197,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 int asus_hid_register_listener(struct asus_hid_listener *cdev);
 void asus_hid_unregister_listener(struct asus_hid_listener *cdev);
 int asus_hid_event(enum asus_hid_event event);
+void asus_hid_set_fnlock(bool enabled);
 #else
 static inline void set_ally_mcu_hack(enum asus_ally_mcu_hack status)
 {
@@ -227,6 +229,9 @@ static inline int asus_hid_event(enum asus_hid_event event)
 {
 	return -ENODEV;
 }
+static inline void asus_hid_set_fnlock(bool enabled)
+{
+}
 #endif
 
 #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */
-- 
2.54.0

