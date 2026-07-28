Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F24756CB
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279356; cv=none; b=UItAaE3x8ENK5ytIuqwC/71hm8/483KtbJ4aKUFifaYGtuqXAPRSgwjhYCDqRCE5t0IJOVpL1Y8/Cgfnr2TfOor3S0BreGb5Sk7GbAKSza0/rs1ooHCb2TZtjbimqMl8NSRPS5jeZR9SNb+F9f+5lzTrVmSDxMK9X+SJl4HG4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279356; c=relaxed/simple;
	bh=7pMnhtkk5mrq3cXLu6ljDVdk4AtM+qQQ0aqU36IaWjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRG5TK33fJ/+tvHj5dt2ruY/BIEiDktLYvaKX9jPnAOWPsj+lKIJwSWNvSkFoDoCBMOtYW3GCBFxBIlNPBjV4n4JA0Phkpd8CRonOIQakn/qGffpb2RGFhF94xqqBdcW022JXprFfaPF97ezM4jOR+akHhhc5aMI6o/gmwTJvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMrrqRt/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMrrqRt/"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c167c58f2so2697731cf.0
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279353; x=1785884153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kpFTqKillwwF/ZPXPaJl8aiOR7iNN4pBGQsw6T0ErQQ=;
        b=mMrrqRt/T+9dZWDPk6cylbbAdTcq/31Qh5V7fOZpGdFIHqPuWrkarhG+TrMWEiWSgs
         vAX3HrKR+7RrvqpzCZ1xB7OzXDu71nIis4gE3clqZb0/Ke0DzR5C8d90OKn59DAplw1l
         kSPpua0cLF6zCYtgf8VOtPDGLRgN/1rduDkuRfGtdTHGh5gVmUdZNqHSOc7jqwQ4kmBB
         U4qWq+f71ssemr4JW84ki/EOXlQOEqL9BJKNmxE5K4dS9WJ1cbDJGaaql1DGvYo1+9kx
         /rp922YSVl+hFwdaHoPP6vtqwqHRiFP0zTNvZ+j9dMcHL2TeRv55OQzlbU7gi8dROiXB
         MEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279353; x=1785884153;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpFTqKillwwF/ZPXPaJl8aiOR7iNN4pBGQsw6T0ErQQ=;
        b=O6jveswdbMaxFPZhcS7Z99gym/XRF4EPVC3jpypGRAC70/k0gZGLrqNZy8sUzbui7/
         k4CKuFb4fiyXyNymnn3ijNJyUvawkY0/alkkBtBTI+S3+TI4ppU/HFUh+sShOEphfeCD
         bJ7jrOH/k//YhDdB2W5/se6kmWs4WDU7G4WdWnn4xH8hzRoH1K6yDfHa4i8fb1eJ1/+z
         MGNlNLUbTbmct7EFp7ckcPXxKODy8w/VteaQtUoJNhSh6OhCl4liPpM0dIoakTbxgKky
         NyjuFodVlraw9ZpBnxMFnvAR9btmhApZLMRsi7afqvMuDlEaQY16mrHxP8+Yom7WeSUM
         fdnw==
X-Forwarded-Encrypted: i=1; AHgh+RqA9Pb7qEkqY4Bx6PppP1WBpCn16J3+ydiRupotGIYWUVmI5cyVIcHRH2M+/g1FPKmdzj/ifO/x0qy3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIpyn3gU/5TwvCJFDTrfobJ9DLPyzQ398ZYXoW7R4KhYrcX+b
	q8iNOMnYSDmhf5enzOE9vZUi2xH9TMEsW2YgJC7+aYkm722TblIEpC4a
X-Gm-Gg: AR+sD13EiI6B0mqbOwtFB05CLwotbdjlJv4aVpshNE0NnqsCONrex6CFF3ZCqVXUP7V
	HC0HEywH8qXYeS7qe3FUqp74L8UbY8guOVlUmngmY062eoXW6psefOOqmLNhQ08K2cfUAniKx15
	y3dMjZD/XWqzEZyk3U8TZKnboF+XguYZg1E2KzRQ8ZA5DxKHig537QGSIbOdtGOwzNf1jnn/ebS
	IO2s2/oofSKVX7TjHzVI6EU737HjgyBn2Kf6xZaC21vBx4Z55pS7RFiwnZh4eN3Fe/3iTluSaYd
	BSiUzIHeSIpMpiEFidIUJ0/Y28c1opa0izvnjscQbHApsnnC/ns1eEo2/ajaepOZ26gJ/xtWlKj
	2/XB7BIIwsXQuVZRItSSgrFZcGr4VlXRtHoDXmByqDnCKSIRkO0wpS27/e706S6qAJ2BnmlA2Fp
	932W2wZbVh6PFBQLHz//l0uE0GNfNSHXCz4bHw4rGxTUyP6Ji1ThBaW59jFg==
X-Received: by 2002:ac8:598b:0:b0:527:7813:a439 with SMTP id d75a77b69052e-529d70fc0a3mr41950701cf.27.1785279353015;
        Tue, 28 Jul 2026 15:55:53 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b4f241sm8017991cf.7.2026.07.28.15.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:55:52 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	W_Armin@gmx.de,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: [PATCH v15 2/2] platform/x86/lenovo: Add Yoga Book 9 keyboard dock detection driver
Date: Tue, 28 Jul 2026 18:55:44 -0400
Message-ID: <20260728225545.1333610-3-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728225545.1333610-1-carvsdriver@gmail.com>
References: <20260728225545.1333610-1-carvsdriver@gmail.com>
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
v15:
- yb9_kbdock_notify_new(): restore .min_event_size = sizeof(__le32) in
  struct wmi_driver and remove the manual buffer-length check; the
  .min_event_size field was dropped in v14 by mistake (Ilpo Järvinen).

v14:
- Restore #include <linux/compiler_attributes.h> and <linux/spinlock.h>,
  which were accidentally absent from v13.
- Restore spinlock_t lock in struct yb9_kbdock_data, spin_lock_init(),
  and spin_lock/spin_unlock around input_report_switch + input_sync
  in yb9_kbdock_report().
- Restore pointer-out yb9_kbdock_query(d, u32 *bkbd) and removal of
  zero-initializer from struct wmi_buffer out.
- Restore int return from yb9_kbdock_sync() and error propagation in
  yb9_kbdock_resume() and yb9_kbdock_block_probe().

v13:
- Resend of v12: patch was corrupted in transit.  git-send-email chose
  quoted-printable encoding (triggered by non-ASCII in the changelog)
  which encoded '=' as '=3D', corrupting the RST table separators in
  the ABI doc and breaking git-am.  No content changes from v12.

v12:
- Add #include <linux/sysfs.h> (for sysfs_emit; Ilpo Järvinen)
- Add #include <linux/types.h> (for __le32 and __packed; Ilpo Järvinen)

v11:
- ABI doc: correct Date to "June 2027" and KernelVersion to "7.3";
  these fields should reflect when the ABI lands in the kernel, not
  the submission date (Armin Wolf).

 .../testing/sysfs-driver-lenovo-yb9-kbdock    |  19 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/lenovo/Kconfig           |  14 +
 drivers/platform/x86/lenovo/Makefile          |   1 +
 drivers/platform/x86/lenovo/yb9-kbdock.c      | 323 ++++++++++++++++++
 5 files changed, 364 insertions(+)
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
index 0000000..70d81f3
--- /dev/null
+++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
@@ -0,0 +1,323 @@
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
+	 * Short-buffer guard is handled by .min_event_size below.
+	 */
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
+	.min_event_size	= sizeof(__le32),
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

