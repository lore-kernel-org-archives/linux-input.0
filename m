Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70396437101
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751433; cv=none; b=W8IBcjPKofRzBna0GaRP0sTBquBsQstBnCAjJRLxTnv8YFaU6VbKANlDoSK55+eFZxBlGagFpQhPHze6aPlwjTIaXaTGX1G6pgNk1G5gQSmsUl9qIEYLFWwcYxVWccdz7aCw7ztYCnr7ou0X7Iyx1hdrMgp7GmJr5z+Loz4bypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751433; c=relaxed/simple;
	bh=iVcQXW89/MLyOfO4zHsyuBcPnpFhfa3bNgFinHLTi20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhMY+P+1pMNmTZlCMUDVfIvDYX7voy3VBFq7wMWwuwieBrFIkeZx0ZAt7qu4/QKItuygxmEfY+TnxKixGdJAWYM0D+AujbzQGoTsBzW1v39JVbH6dxfnnf/p0yccCAUDgcK6ryARe+RSbR4MkrOhrbEAy1pOjxgQFNgIQpRtasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdhY/+8Y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdhY/+8Y"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-902e4af2d9dso69933656d6.0
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784751430; x=1785356230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z0FagW0z4dMepTBBZQsyT6QcM6imCH5xcq0BBKujxrQ=;
        b=EdhY/+8Y/QiMw0xBR7UuDqWv1ad+7Ce2tpxYPprUs85fRDs2rF6wDKDLMZ5SxrM5zq
         lam+5SSHQw380YWb3TJUpNn4I9dBK6T9L4NBy55VT0vZzA5krYdzWQiD6RRW/FLqs6gp
         e+1Mx/mdYTWIoWlvLq6Tfw4L+Z5kcpbaisWFw9EseP0tcCEFIY+YdcGCHrrFKa35Rh4a
         ZNo/o+dWU5wgTTkf0HvqeByydH0wKiYUw8X/qyCuqhqMk4tGIqGD2679GQ/OSMGfW0qW
         m19Y5dm86QnulpIv1Pu46iOFP2yVTXbClf8UCaOZ/ENC5GgXiBzR2Zc+tVdO5cqKQe8a
         3EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784751430; x=1785356230;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0FagW0z4dMepTBBZQsyT6QcM6imCH5xcq0BBKujxrQ=;
        b=GTt1zdtObehbN8530+04IQxRQMB2gITacYoIgOU9kHCF1rbU6hHAGb+ax7gsvMSMkj
         GJ47uwybP62gx2zON7amWmfL6cG4NkJrEZ0FwReWcads8Tww63SmzdFje4CLcJfSHIbD
         AnPG1eYjxXbStKW9JF5npTdIV1gkUFhIXvQWVFli5DbtL6HclQ3f8BrnVfF5k65d+GHB
         pC8v8Eq4NJFPTDJY788iVibZove0vmioo6F2TZ4ICsuCD2gpcfAa3bnYH3/6HZGKEXR6
         Ec8LQHg0Cqbw6+2gMzPd4lzw59mUl+7AxoVqNzH+/nfjb3tU2Tzy2trxA7ArsKlKJJKm
         V/FQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1uVaMObn7UEOmVxXPyShpU7OUI1oU3Q9HUmkrhMVS5V3uSclj/8IXFZFPeerQr7d7RZmyfBoMxen8eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVgCQKCrIU9CttnxnzUfQxJXGp1xGg/UfakGqj6SIq2Hv7RpE
	0+1vEHKM4GBlcsxg7+F6wO/aPz3Qf2jhwpDOgx7rq4unOabU+nPm3EGM
X-Gm-Gg: AR+sD101pRiMRu72cBw1FTNHK9NiXZrfwFxvIw/RxtKx2otUtgDuEQ3WEYiRb2t73xh
	V5+srppY9XnvhSVLa0Kf1YDrMRxDt1/f6wcTYuEv5v9PNaGrL/yHXeHOwi9PssA3xq0j6iU5tol
	0eUUdMMpP35HVH+tmwyNskEE1DXlmmnsjByJwkXbLG1JG9N0G/G2sFs6fvuzfZeYzpaAtTicZkT
	REPOjRex2Oea52QGj9ZcbpVzI5tk9gkLbne/oy5wcXyD6TWzjUJFPONPsY+IrSa/ZtjqEP2nVFm
	37SJPlXIVIcYM1lgZoe7NeVEyLCXPkJXpkBYXUZa1Dc886OmV/D/sGuJhs0DGo7zBNAwGiOuwEy
	JtOINkzgYNB3a7WTR7jrve38L28d3l0KWh2Xxj0L5vMDzgP4ZO9YqSv5pSTom3fkNuNlaOKyJa2
	xLpBy/Yodf0Q==
X-Received: by 2002:a05:6214:3b81:b0:8fd:6e22:6634 with SMTP id 6a1803df08f44-907b9be36a1mr69878676d6.32.1784751430089;
        Wed, 22 Jul 2026 13:17:10 -0700 (PDT)
Received: from fedora ([2600:383:440:3e74:66f4:dee9:6d5b:1526])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b7494sm28767506d6.8.2026.07.22.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:17:09 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	W_Armin@gmx.de,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: [PATCH v14 2/2] platform/x86/lenovo: Add Yoga Book 9 keyboard dock detection driver
Date: Wed, 22 Jul 2026 16:16:59 -0400
Message-ID: <20260722201659.874469-3-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722201659.874469-1-carvsdriver@gmail.com>
References: <20260722201659.874469-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Book 9 14IAH10 ships with a detachable Bluetooth keyboard
that magnetically attaches to the bottom (secondary) screen in one of two
positions.  The Embedded Controller tracks the attachment state in a 2-bit
field called BKBD and signals changes via WMI event GUID
806BD2A2-177B-481D-BFB5-3BA0BB4A2285 (notify ID 0xEB on the WM10 ACPI
device, _UID "GMZN").

The device contains embedded BMOF data (WQDD, 20705 bytes) documenting
both WMI interfaces used by this driver:

  LENOVO_BTKBD_EVENT (event GUID): WmiDataId(1) uint32 Status.
  The ACPI _WED(0xEB) method returns EC.BKBD directly as an integer,
  so the notify callback receives BKBD without a separate query.

  LENOVO_FEATURE_STATUS_DATA (block GUID, WQAF method): returns an
  8-byte buffer {uint32 IDs=0x00060000, uint32 Status=BKBD}.
  Used for the initial state read on probe and after resume.

BKBD encoding:
  0 = keyboard detached
  1 = keyboard docked on top half of bottom screen
  2 = keyboard docked on bottom half of bottom screen
  3 = reserved (not observed in practice)

This driver registers two WMI drivers sharing a module-level
BLOCKING_NOTIFIER_HEAD:

  - The event driver (LENOVO_BTKBD_EVENT) uses .notify_new() to receive
    a pre-parsed wmi_buffer and fires the notifier chain with the BKBD
    value extracted from the buffer.

  - The block driver (LENOVO_FEATURE_STATUS_DATA) owns the input_dev in
    its per-device private struct.  At probe time it registers a
    notifier_block on the chain and reads the initial BKBD state via
    wmidev_query_block().  The WMI buffer is parsed as
    struct lenovo_feature_status { __le32 id; __le32 status; }, and the
    ID field is verified before the status is used.

  - SW_TABLET_MODE=1 is reported when the keyboard is detached;
    SW_TABLET_MODE=0 when docked in either position (keyboard present).

  - The raw BKBD value is exposed via read-only sysfs attribute
    "keyboard_position".

  - BKBD state is re-read via wmidev_query_block() on resume from
    suspend or hibernation.

Tested on: Lenovo Yoga Book 9 14IAH10 (model 83KJ), kernel 7.0.

Acked-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Dave Carey <carvsdriver@gmail.com>
---
v14:
- Restore #include <linux/compiler_attributes.h> and <linux/spinlock.h>
  accidentally dropped in v13 (Ilpo Järvinen)
- Restore spinlock_t lock in struct yb9_kbdock_data
- Restore spin_lock_init(), spin_lock/spin_unlock around input_report_switch
  + input_sync in yb9_kbdock_report()
- Restore pointer-out yb9_kbdock_query(d, u32 *bkbd) and remove
  zero-initializer from struct wmi_buffer out
- Restore int return from yb9_kbdock_sync() with error propagation
- Restore error propagation in yb9_kbdock_resume() and yb9_kbdock_block_probe()

v13:
- Resend of v12: patch was corrupted in transit.  git-send-email chose
  quoted-printable encoding (triggered by non-ASCII in the changelog)
  which encoded '=' as '=3D', corrupting the RST table separators in
  the ABI doc and breaking git-am.  No content changes from v12.

v12:
- Add #include <linux/sysfs.h> (for sysfs_emit; Ilpo Järvinen)
- Add #include <linux/types.h> (for __le32 and __packed; Ilpo Järvinen)

v11 (addressing Armin Wolf's v10 review):
- ABI doc: correct Date to "June 2027" and KernelVersion to "7.3"

v10 (addressing Armin Wolf's v9 review):
- Update ABI doc: Date: June 2026, KernelVersion: 6.16
- Add #include <linux/compiler_attributes.h> and <linux/types.h>
- yb9_kbdock_query(): change return to pointer-out u32 *bkbd
- struct yb9_kbdock_data: add spinlock_t lock
- yb9_kbdock_report(): hold lock across input_report_switch + input_sync
- yb9_kbdock_sync(): return int, propagate query error to callers
- yb9_kbdock_resume(), yb9_kbdock_block_probe(): propagate sync error
- struct wmi_buffer out: remove zero-initializer
- yb9_kbdock_notify_new(): drop manual length check; use
  .min_event_size = sizeof(__le32) in struct wmi_driver instead

 .../testing/sysfs-driver-lenovo-yb9-kbdock    |  19 +
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/lenovo/Kconfig           |  14 +
 drivers/platform/x86/lenovo/Makefile          |   1 +
 drivers/platform/x86/lenovo/yb9-kbdock.c      | 324 ++++++++++++++++++
 5 files changed, 365 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
 create mode 100644 drivers/platform/x86/lenovo/yb9-kbdock.c

diff --git a/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock b/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
new file mode 100644
index 0000000..ebe713a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
@@ -0,0 +1,19 @@
+What:		/sys/bus/wmi/drivers/lenovo-yb9-kbdock/<guid>/keyboard_position
+Date:		June 2027
+KernelVersion:	7.3
+Contact:	Dave Carey <carvsdriver@gmail.com>
+Description:
+		Read-only attribute reporting the current keyboard dock position
+		as reported by the Embedded Controller on the Lenovo Yoga Book 9
+		14IAH10.
+
+		Possible values:
+
+		==  =============================================================
+		0   keyboard is not docked to any screen (detached)
+		1   keyboard docked on the top half of the bottom screen
+		2   keyboard docked on the bottom half of the bottom screen
+		==  =============================================================
+
+		SW_TABLET_MODE input events are also emitted: 0 when the keyboard
+		is docked (either position), 1 when detached.
diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e1..00e8275 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14479,6 +14479,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/lenovo/wmi-hotkey-utilities.c
 
+LENOVO YOGA BOOK 9 KEYBOARD DOCK DRIVER
+M:	Dave Carey <carvsdriver@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
+F:	drivers/platform/x86/lenovo/yb9-kbdock.c
+
 LETSKETCH HID TABLET DRIVER
 M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
index 9c48487..938b361 100644
--- a/drivers/platform/x86/lenovo/Kconfig
+++ b/drivers/platform/x86/lenovo/Kconfig
@@ -43,6 +43,20 @@ config LENOVO_WMI_CAMERA
 	  To compile this driver as a module, choose M here: the module
 	  will be called lenovo-wmi-camera.
 
+config LENOVO_YB9_KBDOCK
+	tristate "Lenovo Yoga Book 9 keyboard dock detection"
+	depends on ACPI_WMI
+	depends on DMI
+	depends on INPUT
+	help
+	  Say Y here to enable keyboard dock detection on the Lenovo Yoga Book 9
+	  14IAH10.  The detachable Bluetooth keyboard magnetically attaches to
+	  either screen; this driver reports SW_TABLET_MODE input events based
+	  on the attachment state and exposes the raw position in sysfs.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called lenovo-yb9-kbdock.
+
 config LENOVO_YMC
 	tristate "Lenovo Yoga Tablet Mode Control"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/lenovo/Makefile b/drivers/platform/x86/lenovo/Makefile
index 7b2128e..2842d7d 100644
--- a/drivers/platform/x86/lenovo/Makefile
+++ b/drivers/platform/x86/lenovo/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 
 lenovo-target-$(CONFIG_LENOVO_WMI_HOTKEY_UTILITIES)	+= wmi-hotkey-utilities.o
+lenovo-target-$(CONFIG_LENOVO_YB9_KBDOCK)	+= yb9-kbdock.o
 lenovo-target-$(CONFIG_LENOVO_YMC)	+= ymc.o
 lenovo-target-$(CONFIG_YOGABOOK)	+= yogabook.o
 lenovo-target-$(CONFIG_YT2_1380)	+= yoga-tab2-pro-1380-fastcharger.o
diff --git a/drivers/platform/x86/lenovo/yb9-kbdock.c b/drivers/platform/x86/lenovo/yb9-kbdock.c
new file mode 100644
index 0000000..40a2566
--- /dev/null
+++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Lenovo Yoga Book 9 keyboard-dock detection
+ *
+ * The Yoga Book 9 ships with a detachable Bluetooth keyboard that magnetically
+ * attaches to the bottom screen in one of two positions.  The EC tracks
+ * attachment state in a 2-bit field called BKBD and signals changes via WMI
+ * event 0xEB on the WM10 ACPI device (_UID "GMZN").
+ *
+ * BKBD values:
+ *   0 = keyboard detached
+ *   1 = keyboard docked on the top half of the bottom screen
+ *   2 = keyboard docked on the bottom half of the bottom screen
+ *   3 = reserved / not observed
+ *
+ * Two WMI interfaces are used (documented in embedded BMOF, WQDD, 20705 bytes):
+ *
+ *   LENOVO_BTKBD_EVENT (event GUID, 806BD2A2-...)
+ *     WmiDataId(1) uint32 Status — _WED(0xEB) returns EC.BKBD directly.
+ *     The notify callback receives BKBD as an integer; no separate query needed.
+ *
+ *   LENOVO_FEATURE_STATUS_DATA (block GUID, E7F300FA-...)
+ *     WmiDataId(1) uint32 IDs   = 0x00060000 (feature selector)
+ *     WmiDataId(2) uint32 Status = BKBD value
+ *     Used on probe and resume to read initial state.
+ *
+ * The event driver (LENOVO_BTKBD_EVENT) fires a notifier chain on each WMI
+ * event.  The block driver (LENOVO_FEATURE_STATUS_DATA) owns the input_dev
+ * and registers a notifier_block to receive those events, eliminating the
+ * need for shared global state or a mutex.
+ *
+ * SW_TABLET_MODE=1 is reported when the keyboard is detached;
+ * SW_TABLET_MODE=0 when docked in either position (keyboard present).
+ * The raw BKBD value is exposed via the sysfs attribute "keyboard_position".
+ *
+ * Copyright (C) 2026 Dave Carey <carvsdriver@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/cleanup.h>
+#include <linux/compiler_attributes.h>
+#include <linux/dev_printk.h>
+#include <linux/dmi.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/wmi.h>
+
+#define YB9_KBDOCK_EVENT_GUID	"806BD2A2-177B-481D-BFB5-3BA0BB4A2285"
+#define YB9_KBDOCK_QUERY_GUID	"E7F300FA-21CD-4003-ADAC-2696135982E6"
+
+/* BKBD encoding */
+#define BKBD_DETACHED		0
+
+/* LENOVO_FEATURE_STATUS_DATA feature selector */
+#define YB9_FEATURE_STATUS_ID	0x00060000u
+
+/*
+ * LENOVO_FEATURE_STATUS_DATA: 8-byte buffer {uint32 IDs, uint32 Status}.
+ * IDs is always 0x00060000; Status holds the BKBD value (0–3).
+ */
+struct lenovo_feature_status {
+	__le32 id;
+	__le32 status;
+} __packed;
+
+/* ------------------------------------------------------------------
+ * Notifier chain — event driver fires it, block driver listens
+ * ------------------------------------------------------------------ */
+
+static BLOCKING_NOTIFIER_HEAD(yb9_kbdock_chain_head);
+
+static void devm_yb9_kbdock_unregister_notifier(void *data)
+{
+	struct notifier_block *nb = data;
+
+	blocking_notifier_chain_unregister(&yb9_kbdock_chain_head, nb);
+}
+
+static int devm_yb9_kbdock_register_notifier(struct device *dev,
+					      struct notifier_block *nb)
+{
+	int ret;
+
+	ret = blocking_notifier_chain_register(&yb9_kbdock_chain_head, nb);
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_yb9_kbdock_unregister_notifier, nb);
+}
+
+/* ------------------------------------------------------------------
+ * Block WMI driver — LENOVO_FEATURE_STATUS_DATA
+ * (owns input_dev, sysfs, PM resume)
+ * ------------------------------------------------------------------ */
+
+struct yb9_kbdock_data {
+	struct wmi_device	*wdev;
+	struct input_dev	*input_dev;
+	struct notifier_block	 nb;
+	spinlock_t		 lock;	/* protects input_report_switch + input_sync */
+};
+
+static int yb9_kbdock_query(struct yb9_kbdock_data *d, u32 *bkbd)
+{
+	struct wmi_buffer out;
+	int ret;
+
+	ret = wmidev_query_block(d->wdev, 0, &out,
+				 sizeof(struct lenovo_feature_status));
+	if (ret)
+		return ret;
+
+	struct lenovo_feature_status *fs __free(kfree) = out.data;
+
+	if (le32_to_cpu(fs->id) != YB9_FEATURE_STATUS_ID)
+		return -EIO;
+
+	*bkbd = le32_to_cpu(fs->status);
+	return 0;
+}
+
+static void yb9_kbdock_report(struct yb9_kbdock_data *d, u32 bkbd)
+{
+	int tablet = (bkbd == BKBD_DETACHED) ? 1 : 0;
+
+	spin_lock(&d->lock);
+	input_report_switch(d->input_dev, SW_TABLET_MODE, tablet);
+	input_sync(d->input_dev);
+	spin_unlock(&d->lock);
+	dev_dbg(&d->wdev->dev, "BKBD=%u SW_TABLET_MODE=%d\n", bkbd, tablet);
+}
+
+static int yb9_kbdock_sync(struct yb9_kbdock_data *d)
+{
+	u32 bkbd;
+	int ret;
+
+	ret = yb9_kbdock_query(d, &bkbd);
+	if (ret)
+		return ret;
+
+	yb9_kbdock_report(d, bkbd);
+	return 0;
+}
+
+static int yb9_kbdock_nb_call(struct notifier_block *nb,
+			       unsigned long bkbd, void *unused)
+{
+	struct yb9_kbdock_data *d =
+		container_of(nb, struct yb9_kbdock_data, nb);
+
+	yb9_kbdock_report(d, bkbd);
+	return NOTIFY_DONE;
+}
+
+static ssize_t keyboard_position_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct yb9_kbdock_data *d = dev_get_drvdata(dev);
+	u32 bkbd;
+	int ret;
+
+	ret = yb9_kbdock_query(d, &bkbd);
+	if (ret)
+		return ret;
+	return sysfs_emit(buf, "%u\n", bkbd);
+}
+static DEVICE_ATTR_RO(keyboard_position);
+
+static const struct attribute * const yb9_kbdock_attrs[] = {
+	&dev_attr_keyboard_position.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(yb9_kbdock);
+
+static int yb9_kbdock_resume(struct device *dev)
+{
+	struct yb9_kbdock_data *d = dev_get_drvdata(dev);
+
+	return yb9_kbdock_sync(d);
+}
+static DEFINE_SIMPLE_DEV_PM_OPS(yb9_kbdock_pm_ops, NULL, yb9_kbdock_resume);
+
+static int yb9_kbdock_block_probe(struct wmi_device *wdev, const void *ctx)
+{
+	struct yb9_kbdock_data *d;
+	struct input_dev *input_dev;
+	int ret;
+
+	d = devm_kzalloc(&wdev->dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	d->wdev = wdev;
+	spin_lock_init(&d->lock);
+
+	input_dev = devm_input_allocate_device(&wdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->name		= "Lenovo Yoga Book 9 keyboard dock switch";
+	input_dev->phys		= YB9_KBDOCK_QUERY_GUID "/input0";
+	input_dev->id.bustype	= BUS_HOST;
+	input_set_capability(input_dev, EV_SW, SW_TABLET_MODE);
+
+	ret = input_register_device(input_dev);
+	if (ret)
+		return ret;
+
+	d->input_dev		= input_dev;
+	d->nb.notifier_call	= yb9_kbdock_nb_call;
+
+	ret = devm_yb9_kbdock_register_notifier(&wdev->dev, &d->nb);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&wdev->dev, d);
+	return yb9_kbdock_sync(d);
+}
+
+static const struct wmi_device_id yb9_kbdock_block_id_table[] = {
+	{ .guid_string = YB9_KBDOCK_QUERY_GUID },
+	{ }
+};
+
+static struct wmi_driver yb9_kbdock_block_driver = {
+	.driver = {
+		.name		= "lenovo-yb9-kbdock",
+		.dev_groups	= yb9_kbdock_groups,
+		.pm		= pm_sleep_ptr(&yb9_kbdock_pm_ops),
+	},
+	.id_table	= yb9_kbdock_block_id_table,
+	.no_singleton	= true,
+	.probe		= yb9_kbdock_block_probe,
+};
+
+/* ------------------------------------------------------------------
+ * Event WMI driver — LENOVO_BTKBD_EVENT
+ * (fires the notifier chain on each WMI event)
+ * ------------------------------------------------------------------ */
+
+static void yb9_kbdock_notify_new(struct wmi_device *wdev,
+				  const struct wmi_buffer *data)
+{
+	/*
+	 * _WED(0xEB) returns EC.BKBD directly as a 32-bit integer
+	 * (LENOVO_BTKBD_EVENT WmiDataId(1) uint32 Status).
+	 */
+	if (!data || data->length < sizeof(__le32))
+		return;
+
+	u32 bkbd = le32_to_cpu(*(const __le32 *)data->data);
+
+	blocking_notifier_call_chain(&yb9_kbdock_chain_head, bkbd, NULL);
+}
+
+static const struct wmi_device_id yb9_kbdock_event_id_table[] = {
+	{ .guid_string = YB9_KBDOCK_EVENT_GUID },
+	{ }
+};
+MODULE_DEVICE_TABLE(wmi, yb9_kbdock_event_id_table);
+
+static struct wmi_driver yb9_kbdock_event_driver = {
+	.driver = {
+		.name = "lenovo-yb9-kbdock-event",
+	},
+	.id_table	= yb9_kbdock_event_id_table,
+	.no_singleton	= true,
+	.notify_new	= yb9_kbdock_notify_new,
+};
+
+/* ------------------------------------------------------------------
+ * Module init / exit
+ * ------------------------------------------------------------------ */
+
+static const struct dmi_system_id yb9_kbdock_dmi_table[] __initconst = {
+	{
+		/* Lenovo Yoga Book 9 14IAH10 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,   "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83KJ"),
+		},
+	},
+	{ }
+};
+
+static int __init yb9_kbdock_init(void)
+{
+	int ret;
+
+	if (!dmi_check_system(yb9_kbdock_dmi_table))
+		return -ENODEV;
+
+	ret = wmi_driver_register(&yb9_kbdock_event_driver);
+	if (ret)
+		return ret;
+
+	ret = wmi_driver_register(&yb9_kbdock_block_driver);
+	if (ret) {
+		wmi_driver_unregister(&yb9_kbdock_event_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(yb9_kbdock_init);
+
+static void __exit yb9_kbdock_exit(void)
+{
+	wmi_driver_unregister(&yb9_kbdock_block_driver);
+	wmi_driver_unregister(&yb9_kbdock_event_driver);
+}
+module_exit(yb9_kbdock_exit);
+
+MODULE_AUTHOR("Dave Carey <carvsdriver@gmail.com>");
+MODULE_DESCRIPTION("Lenovo Yoga Book 9 keyboard dock detection");
+MODULE_LICENSE("GPL");
-- 
2.55.0

