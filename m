Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F32E7F39
	for <linux-input@vger.kernel.org>; Wed, 18 Feb 2026 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388443; cv=none; b=Ab5HCLBDKlpERmu1STWoj5Y37/6j1+RAC5k5TKEEJLfjfHtaadG4KNqBEuQekwtLm8cRsdDLbxxWKTpjJUCy1919NhLfqF3V2iFEhMiN3bhAw0bBVBwHbdom+2/vj+255krJVEuYuQoLeSPVeV2FZ9GsT9x/aBEOVnxIXPkN9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388443; c=relaxed/simple;
	bh=gF+u7TQTGJJCideXJSPEiAo366C6GmMc+VAIJdZ7Aiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFoDT5sWVTCP9MwwFI1FjcWyiT25IA5gp6og3LwxuvKamH6tqd6AIiZHDMTnjZvdTDPOWtvpv8bPYt55BbsTp7MGQ2zolO+rh34tPhKhURtS3DhjcCqqCLNvVZvBu9OcnJsXqfkYMIRDnu+64p4z9vCSOCPPq7nPxpW4dFmM+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=AeO0xWKJ; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="AeO0xWKJ"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward201d.mail.yandex.net (Yandex) with ESMTPS id 62E1481B91
	for <linux-input@vger.kernel.org>; Wed, 18 Feb 2026 07:14:12 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4702:0:640:9195:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 5BB5AC00A5;
	Wed, 18 Feb 2026 07:14:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0ERmHYHGlmI0-eD11LZ2r;
	Wed, 18 Feb 2026 07:14:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1771388043; bh=ykbMOJLxOQnHV+R551l8Mtny/NgCfkxiPwsLjrkO+wU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=AeO0xWKJSS5FqdXS02Inxwwv+iM8jClw4wP16u7gLYxe1AK3N+OI8BC3BpAMJeHSF
	 chLA2XsF/HAkmsvR9qnIgiAIqZhr8GzYJERtFO7mZqjyPHmk0RU2TsG7OQBxRvzJ47
	 xVft1lx0E0cwDkTnPUEBHdFFc1akes5v2LU0ERUA=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Novosyolov <m.novosyolov@rosa.ru>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	m.novosyolov@rosa.ru
Subject: [PATCH] Input: atkbd: add keymap fixup for notebooks using 0x6e as Fn modifier
Date: Wed, 18 Feb 2026 07:13:52 +0300
Message-ID: <20260218041352.797625-1-m.novosyolov@rosa.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dc8c9c171ef3 ("Input: atkbd - map F23 key to support default
copilot shortcut") mapped scancode 0x6e to KEY_F23 to support the
Microsoft Copilot key on Lenovo, HP, and Dell notebooks.

However, some notebook platforms (including Positron Proxima 15 and
possibly others based on the same OEM design) use scancode 0x6e for the
Fn modifier key instead of a dedicated Copilot key. When 0x6e generates
KEY_F23 events, the Fn key breaks Fn combinations such as Fn+F5
(touchpad toggle).

On these platforms, the hardware relies on 0x6e being unmapped to
properly handle Fn combinations at the firmware level. When the kernel
maps it to KEY_F23, desktop environments intercept this as a global
hotkey and toggle the touchpad, but cannot re-enable it because the
firmware no longer recognizes Fn as a valid modifier.

Userspace solutions (systemd hwdb) cannot fix this because the keycode
mapping happens in the atkbd driver before events reach userspace.
A kernel-level quirk is required.

Add a DMI-based keymap fixup to remap scancode 0x6e to 0 for affected
systems. Currently only Positron Proxima 15 is known to be affected,
but other notebooks based on the same OEM platform may exhibit the same
behavior and can be added to the quirk table.

Scancode 0x6e has different meanings on different hardware:
- Lenovo/HP/Dell: F23 (Copilot key) - correctly mapped to KEY_F23
- Some OEM platforms: Fn modifier - must be unmapped

A generic solution is not feasible without breaking Copilot support
on other vendors.

Link: https://linux-hardware.org/?probe=7aca7ed668
Link: https://bugzilla.rosa.ru/show_bug.cgi?id=19950

Fixes: dc8c9c171ef3 ("Input: atkbd - map F23 key to support default copilot shortcut")
Co-developed-by: GLM-4.7 AI <noreply@z.ai>
Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosa.ru>
---
 drivers/input/keyboard/atkbd.c | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 6c999d89ee4b..e4ecdd9fc07b 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1068,6 +1068,40 @@ static unsigned int atkbd_volume_forced_release_keys[] = {
 	0xae, 0xb0, -1U
 };
 
+/*
+ * Positron notebooks where scancode 0x6e is used by the Fn key and should
+ * not generate KEY_F23 events.
+ *
+ * Commit dc8c9c171ef3 ("Input: atkbd - map F23 key to support default
+ * copilot shortcut") mapped scancode 0x6e to KEY_F23 for Copilot support.
+ * However, on Positron notebooks scancode 0x6e is generated by the Fn
+ * modifier key and should be unmapped to allow firmware/hardware to
+ * process Fn+F5 and other Fn combinations properly.
+ */
+static unsigned int atkbd_positron_fn_keymap_fixup_scancodes[] = {
+	0x6e, -1U
+};
+
+/*
+ * Fixup to remap scancodes to 0 (no keycode) for machines where
+ * the default keymap incorrectly assigns keys that should be unused.
+ * This is needed when BIOS/firmware uses certain scancodes for
+ * internal purposes (e.g., Fn modifier) and they should not generate
+ * keyboard events.
+ */
+static void atkbd_apply_keymap_fixup(struct atkbd *atkbd, const void *data)
+{
+	const unsigned int *scancodes = data;
+	unsigned int i;
+
+	for (i = 0; scancodes[i] != -1U; i++) {
+		unsigned int scancode = scancodes[i];
+
+		if (scancode < ATKBD_KEYMAP_SIZE)
+			atkbd->keycode[scancode] = 0;
+	}
+}
+
 /*
  * OQO 01+ multimedia keys (64--66) generate e0 6x upon release whereas
  * they should be generating e4-e6 (0x80 | code).
@@ -1775,6 +1809,14 @@ static int __init atkbd_setup_forced_release(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int __init atkbd_setup_keymap_fixup(const struct dmi_system_id *id)
+{
+	atkbd_platform_fixup = atkbd_apply_keymap_fixup;
+	atkbd_platform_fixup_data = id->driver_data;
+
+	return 1;
+}
+
 static int __init atkbd_setup_scancode_fixup(const struct dmi_system_id *id)
 {
 	atkbd_platform_scancode_fixup = id->driver_data;
@@ -1937,6 +1979,15 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Positron Proxima 15 - Fn key (0x6e) should not generate F23 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LNPO Positron LLC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1569"),
+		},
+		.callback = atkbd_setup_keymap_fixup,
+		.driver_data = atkbd_positron_fn_keymap_fixup_scancodes,
+	},
 	{ }
 };
 
-- 
2.51.0

