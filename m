Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5A330324
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030156; cv=none; b=ZKvwtxP4uAAp4ljxOc7/4W6T7HGx17MaOxfR+C6e3cmSgY5fATgXanYBu5l32VIBvodgsRUxVcUbLSabjBgz0xCUQoEsk2bMuKCpy1ZMJmRyzgCPFNUl5wrGILeIVH2Vq3FWmxWdsQ7xysdnwb6tTcy6Ti5t4Voykfe+VXgQAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030156; c=relaxed/simple;
	bh=wxjYC7gAJmXbvVdDxfp/M8UohPrEPkWz1bx2JIWFXQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMik+O6kqC5fp2tSpTvGiCWBL0SVrFXj2eGPyPVZzFch4KExtNDo+djt/oKJ3xKq5yoYq8Cm3JdPgokakoHkRuV/ZVMS9GK/2c9AhzHmTOQMlBykv5AWlKYrFx6aP9VIA3ApA4W5C0OVglc/D/R1O2iH+qJidqtODpC0Du/CjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiIJ/pG7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiIJ/pG7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-911488599e3so193620085a.3
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779030154; x=1779634954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ5dMrJOu2VDkpK4E4GvRpu/OR2O95cehaSbIxqBQyg=;
        b=JiIJ/pG7fzdX3v3haG3Gfz/iG9WKz50TKeLk0QWxgXjjRK/3tRgMpJClxu/BCA9YVe
         iNGX8kJe+g+LvzjPbUhy5ISqe9DJ0bBBhB1ClU9fTTxry/QqBGdopI+J5rdZwLbIC9Sp
         BAG1qOCYAH9LNICRBwFjQSbvbF1m9ojVveczXKfmxpKBgH9uNotXKXYlftOeo6xE/8x2
         d7YxaE7Lh0+a56tEitDwO6i1vyrjxQyUEvw0EEOrrbXwS/yxoEabKAjyyVNm1cT8ePd+
         bbWPKe7PuxkzOJPa4A0in86d2EqySj/cY6yctDdjceneDhLFn8IAzXUztHK0HMkRDfW7
         h5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779030154; x=1779634954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZ5dMrJOu2VDkpK4E4GvRpu/OR2O95cehaSbIxqBQyg=;
        b=hMtMF0lbT+gkaZKLwMRk36q8rSEzf/eSxGE91JX5+bQzF/zRRJQTuOfyAKe6Br5y0G
         pmti/9cYlRI5VDxWfwrqUarn/boJddhA5jUblp3xgl0Ct8icWtBmeuf3Ab5fUAP91AHm
         Z2ivJGoIAvlofqy7RVnXwdqSgiCeogXs7i8ij/huI9tt7l2P9FMNdaZ27vJJw4YtNoDF
         FeaiJtXQCAW3IZjzJAvTWqoQXvla5MC2L8M2v1mPTkE7qlIWps43MWh5VhpLllQnsnGs
         LJTxEIroA+ecHfJvacUbqup7KSvIAN057GqLig47lfkRBSKh1bI6sjw6/B9tL5P+2c84
         hDAg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zj2fL7ETZiVvw1wb24bQhIjD38efvhJ1BPZ9+oPCEcQdzLjllRnC2DAQcsQvUxJT7OfkoBkBwnMaNtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOb09Zallio9M4aFsXCAWsL4nG20NvJ+csZ0m5xSpjaOHGCpP
	/UZxyPQ5PKytVvpvBysBaTN16phKRmgDP4RHaZkVYwWInsyBNnLJ5qBn
X-Gm-Gg: Acq92OHyDJRN5q5Hk32L8fzHAUgx46LwzxIdOTCRj+E6qRkeX6YPnp6OTkqiFdMkwgX
	c5W8pD4oiRk3mgeCyeF/s0ujzrWA/9U4kCpMDUsJ+EekhciRp2Ygh+j4pmmgjtLg17D3s/mFMx5
	/q8AX2YSsjqlmhc4I3Wkhsn5wSWcUI/ODkriudT8Fhv/LCJEo2OdLORCUbQOlVwiKlX1BtydD8d
	HdWENN/FDOejMi3ru7w9IRPADBzEN/Sev7OsMf0dPSB5yYdKgssQg49z+273BcSky/8p08iaA+o
	TWOrNw71CXRVqbX36L0Rg915rqJtCSeWbm07zM1+LpS9SdwQKok6GA2RjjvQ2nsS+e9Na18IYZV
	G6V+S9xhFraxnMMSxU482YAuVFj+dCKoswGM0zl62K+t40xQgmPBMX5U2/wLsK4iw9bzwhp3Rjz
	+Q3LPHh1ZYERGBXQLfyAWyQwaFgOx/4DMgl+nhgpRhcWCYRdveXWWDWB9iS/sbuwYMJlwk
X-Received: by 2002:a05:620a:1a1a:b0:912:c611:80ff with SMTP id af79cd13be357-912c611880cmr1185477885a.52.1779030153734;
        Sun, 17 May 2026 08:02:33 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc936407sm1200753485a.22.2026.05.17.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 08:02:33 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: hdegoede@redhat.com,
	pithenrich2d@googlemail.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com,
	W_Armin@gmx.de,
	platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v2] platform/x86/lenovo: add Yoga Book 9 keyboard dock driver
Date: Sun, 17 May 2026 11:02:24 -0400
Message-ID: <20260517150224.50191-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9459f535-d140-a431-3f76-a5d8623f3e2d@linux.intel.com>
References: <9459f535-d140-a431-3f76-a5d8623f3e2d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Book 9 14IAH10 (83KJ) ships with a detachable Bluetooth
keyboard that magnetically attaches to the bottom screen in one of two
positions.

The Embedded Controller tracks the attachment state in a 2-bit field called
BKBD (byte 0x23 of EC RAM, bits 4-5) and signals changes via EC query _QB0,
which calls Notify(WM10, 0xEB) on the WM10 ACPI WMI device (_UID "GMZN").
The WMI event GUID 806BD2A2-177B-481D-BFB5-3BA0BB4A2285 fires on every
state change.  The current state is readable at any time via WMI data block
E7F300FA-21CD-4003-ADAC-2696135982E6 (WQAF), which returns an 8-byte buffer
whose upper four bytes hold the BKBD value.  BKBD encodes the attachment
state as: 0 = keyboard detached, 1 = docked on the top half of the bottom
screen, 2 = docked on the bottom half, 3 = reserved (treated as an error by
this driver).

Add a new driver, lenovo-yb9-kbdock, that queries the BKBD state on probe
and on each WMI event notification.  Both docked positions indicate a
physical keyboard is present and report SW_TABLET_MODE=0 (laptop mode);
keyboard detached reports SW_TABLET_MODE=1 (tablet mode).  The raw BKBD
value is additionally exposed via the read-only sysfs attribute
"keyboard_position" for userspace that needs to distinguish the two docked
positions (e.g. to choose a different UI layout).

Tested on Lenovo Yoga Book 9 14IAH10 (83KJ): all three BKBD states
(detached, top-half dock, bottom-half dock) reported correctly;
SW_TABLET_MODE transitions verified with evtest.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
---
 drivers/platform/x86/lenovo/Kconfig       | 14 ++++
 drivers/platform/x86/lenovo/Makefile      |  1 +
 drivers/platform/x86/lenovo/yb9-kbdock.c | 233 +++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo/yb9-kbdock.c

--- a/drivers/platform/x86/lenovo/Kconfig
+++ b/drivers/platform/x86/lenovo/Kconfig
@@ -43,6 +43,20 @@
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
--- a/drivers/platform/x86/lenovo/Makefile
+++ b/drivers/platform/x86/lenovo/Makefile
@@ -8,6 +8,7 @@
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o

 lenovo-target-$(CONFIG_LENOVO_WMI_HOTKEY_UTILITIES)	+= wmi-hotkey-utilities.o
+lenovo-target-$(CONFIG_LENOVO_YB9_KBDOCK)	+= yb9-kbdock.o
 lenovo-target-$(CONFIG_LENOVO_YMC)	+= ymc.o
 lenovo-target-$(CONFIG_YOGABOOK)	+= yogabook.o
 lenovo-target-$(CONFIG_YT2_1380)	+= yoga-tab2-pro-1380-fastcharger.o
--- a/drivers/platform/x86/lenovo/yb9-kbdock.c
+++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Lenovo Yoga Book 9 keyboard-dock detection
+ *
+ * Reports SW_TABLET_MODE based on keyboard attachment state and exposes the
+ * raw dock position via sysfs.
+ *
+ * Copyright (C) 2026 Dave Carey <carvsdriver@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/dmi.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/wmi.h>
+
+/*
+ * WM10 ACPI device (_UID "GMZN") exposes two relevant WMI GUIDs:
+ *   YB9_KBDOCK_EVENT_GUID — notify ID 0xEB fires on attachment state change.
+ *   YB9_KBDOCK_QUERY_GUID — object "AF" (WQAF), returns an 8-byte buffer
+ *                           whose upper four bytes hold the BKBD value.
+ *
+ * BKBD encoding:
+ *   0 (BKBD_DETACHED)    — keyboard detached       → SW_TABLET_MODE = 1
+ *   1 (BKBD_TOP_HALF)    — docked, top half        → SW_TABLET_MODE = 0
+ *   2 (BKBD_BOTTOM_HALF) — docked, bottom half     → SW_TABLET_MODE = 0
+ *   3                    — reserved; treated as an error
+ */
+#define YB9_KBDOCK_EVENT_GUID		"806BD2A2-177B-481D-BFB5-3BA0BB4A2285"
+#define YB9_KBDOCK_QUERY_GUID		"E7F300FA-21CD-4003-ADAC-2696135982E6"
+#define YB9_KBDOCK_QUERY_INSTANCE	0
+
+#define BKBD_DETACHED		0
+#define BKBD_TOP_HALF		1
+#define BKBD_BOTTOM_HALF	2
+#define BKBD_MASK		GENMASK(1, 0)
+
+/* Distinguish the two GUIDs via the id_table context field. */
+enum yb9_guid_type { YB9_GUID_EVENT, YB9_GUID_QUERY };
+
+/*
+ * Both GUIDs are children of the same ACPI device (WM10).  Store the query
+ * WMI device globally so the event-device probe and notify path can reach it
+ * via wmidev_block_query().  Protected by yb9_query_lock during probe/remove.
+ */
+static struct wmi_device *yb9_query_wdev;
+static DEFINE_MUTEX(yb9_query_lock);
+
+struct yb9_kbdock_priv {
+	struct wmi_device *query_wdev;
+	struct input_dev *input_dev;
+	unsigned int bkbd;
+};
+
+/* Returns 0–2 on success, -errno on error. */
+static int yb9_kbdock_query(struct wmi_device *event_wdev,
+			     struct wmi_device *query_wdev)
+{
+	u32 bkbd;
+
+	union acpi_object *obj __free(kfree) =
+		wmidev_block_query(query_wdev, YB9_KBDOCK_QUERY_INSTANCE);
+	if (!obj) {
+		dev_warn(&event_wdev->dev, "WQAF query returned NULL\n");
+		return -EIO;
+	}
+
+	/*
+	 * WQAF returns an 8-byte buffer: bytes [0..3] = LFID (0x00060000),
+	 * bytes [4..7] = BKBD value.  Guard against short buffers.
+	 */
+	if (obj->type == ACPI_TYPE_BUFFER && obj->buffer.length >= 8)
+		memcpy(&bkbd, obj->buffer.pointer + 4, sizeof(bkbd));
+	else if (obj->type == ACPI_TYPE_INTEGER)
+		bkbd = obj->integer.value;
+	else {
+		dev_warn(&event_wdev->dev,
+			 "WQAF: unexpected result type %d len %u\n",
+			 obj->type, obj->type == ACPI_TYPE_BUFFER ? obj->buffer.length : 0);
+		return -EIO;
+	}
+
+	bkbd = FIELD_GET(BKBD_MASK, bkbd);
+	if (bkbd == 3) {
+		dev_warn(&event_wdev->dev, "BKBD value 3 is reserved\n");
+		return -EINVAL;
+	}
+
+	return bkbd;
+}
+
+static void yb9_kbdock_update(struct wmi_device *wdev)
+{
+	struct yb9_kbdock_priv *priv = dev_get_drvdata(&wdev->dev);
+	int tablet_mode;
+	int bkbd;
+
+	bkbd = yb9_kbdock_query(wdev, priv->query_wdev);
+	if (bkbd < 0)
+		return;
+
+	priv->bkbd = bkbd;
+	tablet_mode = (bkbd == BKBD_DETACHED) ? 1 : 0;
+
+	input_report_switch(priv->input_dev, SW_TABLET_MODE, tablet_mode);
+	input_sync(priv->input_dev);
+
+	dev_dbg(&wdev->dev, "BKBD=%u tablet_mode=%d\n", bkbd, tablet_mode);
+}
+
+static void yb9_kbdock_notify(struct wmi_device *wdev, union acpi_object *data)
+{
+	yb9_kbdock_update(wdev);
+}
+
+static ssize_t keyboard_position_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	static const char * const names[] = {
+		"detached", "top-half", "bottom-half",
+	};
+	struct yb9_kbdock_priv *priv = dev_get_drvdata(dev);
+	unsigned int bkbd = priv->bkbd;
+
+	if (WARN_ON_ONCE(bkbd >= ARRAY_SIZE(names)))
+		return -EINVAL;
+	return sysfs_emit(buf, "%u (%s)\n", bkbd, names[bkbd]);
+}
+static DEVICE_ATTR_RO(keyboard_position);
+
+static struct attribute *yb9_kbdock_attrs[] = {
+	&dev_attr_keyboard_position.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(yb9_kbdock);
+
+static const struct dmi_system_id yb9_kbdock_dmi_table[] = {
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
+static int yb9_kbdock_probe(struct wmi_device *wdev, const void *ctx)
+{
+	enum yb9_guid_type type = (enum yb9_guid_type)(uintptr_t)ctx;
+	struct yb9_kbdock_priv *priv;
+	struct input_dev *input_dev;
+	struct wmi_device *qwdev;
+	int err;
+
+	if (type == YB9_GUID_QUERY) {
+		mutex_lock(&yb9_query_lock);
+		yb9_query_wdev = wdev;
+		mutex_unlock(&yb9_query_lock);
+		return 0;
+	}
+
+	if (!dmi_check_system(yb9_kbdock_dmi_table))
+		return -ENODEV;
+
+	mutex_lock(&yb9_query_lock);
+	qwdev = yb9_query_wdev;
+	mutex_unlock(&yb9_query_lock);
+	if (!qwdev)
+		return -EPROBE_DEFER;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	input_dev = devm_input_allocate_device(&wdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->name = "Lenovo Yoga Book 9 keyboard dock switch";
+	input_dev->phys = YB9_KBDOCK_EVENT_GUID "/input0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &wdev->dev;
+	input_set_capability(input_dev, EV_SW, SW_TABLET_MODE);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(&wdev->dev, "failed to register input device: %d\n", err);
+		return err;
+	}
+
+	priv->query_wdev = qwdev;
+	priv->input_dev = input_dev;
+	dev_set_drvdata(&wdev->dev, priv);
+
+	yb9_kbdock_update(wdev);
+	return 0;
+}
+
+static void yb9_kbdock_remove(struct wmi_device *wdev)
+{
+	mutex_lock(&yb9_query_lock);
+	if (wdev == yb9_query_wdev)
+		yb9_query_wdev = NULL;
+	mutex_unlock(&yb9_query_lock);
+}
+
+static const struct wmi_device_id yb9_kbdock_wmi_id_table[] = {
+	{ .guid_string = YB9_KBDOCK_EVENT_GUID, .context = (void *)YB9_GUID_EVENT },
+	{ .guid_string = YB9_KBDOCK_QUERY_GUID, .context = (void *)YB9_GUID_QUERY },
+	{ }
+};
+MODULE_DEVICE_TABLE(wmi, yb9_kbdock_wmi_id_table);
+
+static struct wmi_driver yb9_kbdock_driver = {
+	.driver = {
+		.name = "lenovo-yb9-kbdock",
+		.dev_groups = yb9_kbdock_groups,
+	},
+	.id_table = yb9_kbdock_wmi_id_table,
+	.probe    = yb9_kbdock_probe,
+	.remove   = yb9_kbdock_remove,
+	.notify   = yb9_kbdock_notify,
+};
+module_wmi_driver(yb9_kbdock_driver);
+
+MODULE_AUTHOR("Dave Carey <carvsdriver@gmail.com>");
+MODULE_DESCRIPTION("Lenovo Yoga Book 9 keyboard dock detection");
+MODULE_LICENSE("GPL");

2.47.0
