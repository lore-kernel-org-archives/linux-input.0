Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E253A5E78
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946538; cv=none; b=Zgvb2NHFUFiEDlYm/Xel1/sM6yIhg978G0zmhFGzxX5inzJTmigr0PEfuxYHDSL+dFwOSLenzaWV54qe8kfRXx9QV+FTZmBGUvi4yst2CgxivtAvM0qQrzJ8nthbdufFlnjut7e4Ju1ISEIGv6wh0Eq71f9IAsPjJq4GiXt9dt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946538; c=relaxed/simple;
	bh=7OTJD8N3JoZx+anFJ/V+T2PIw3w+U/FNaoic05d7rF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l/3qjM+ZoFgHHIClNCllcOLpqYrMgQvDeKVNB0s8WVFV9F7QH7isqBPqhYgAl256exUkMnr7BXVgHwKvMmqLNqoqG9qTUuQZyczpr0ED8mNvbxXLY/RFveqxOFvWDuyKyhgewY9kmeBdZOBPMvpz0kbVD2sSNlkAHgbi2SYOTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Lfc5/1qR; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Lfc5/1qR"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1432F24002A
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 14:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1783946534;
	bh=HRa054+qSBIwDY504Eqlctfhzd1rhASTMJb1hgLw274=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Lfc5/1qRlqdfQQCiQ2iCbdw7BvddK9lDE0h1j98MhBpLfd6Soy4fF88PRfstcqZLT
	 V3M8vfYRj9oh3khBeXa385Q/y/VyetKzI50M8k8b31YxvCZCLXTmCE8hKODTbv/El8
	 Vqet9Ly7ZqpJFT+G/UIe/ue54z0rBZszFmHl3qunkPAXSeu6v1+iFNGnghTjsA3s7C
	 IT9LpuwOBhtkL/s6czNZ8qA5QoPoe5QPBkpNUaPwjNFRpphPcJHKaQHG/oG6NSss2P
	 CB5wgygEmfe41jF8kBYPIOI8oJSzR0MFJ03r6yp1h6ayWpoQH0YFTkmGBBqx6tro1K
	 bHp7KxdwUNrQA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gzMX51vh3z6tsb;
	Mon, 13 Jul 2026 14:42:13 +0200 (CEST)
From: Benjamin Blume <benjaminblume@posteo.de>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Blume <benjaminblume@posteo.de>
Subject: [PATCH] HID: hyperx: add driver for the HyperX QuadCast 2 mute button
Date: Mon, 13 Jul 2026 12:42:13 +0000
Message-ID: <20260713124200.564126-1-benjaminblume@posteo.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The tap-to-mute button of the HyperX QuadCast 2 (03f0:07b4) is handled
entirely in the device firmware.  The firmware gates the audio internally
but never sends the Telephony "Phone Mute" usage (0x2f) that its own report
descriptor advertises, and it does not touch the UAC feature unit either.
Consequently neither an evdev key event nor an ALSA mixer change is ever
generated, and userspace has no way to learn that the microphone was muted:
desktops keep showing the microphone as live, and conferencing applications
keep displaying an unmuted microphone while transmitting silence.

The mute state is reported through a vendor-defined collection instead:

  06 c0 ff        Usage Page (Vendor-Defined 0xFFC0)
  a1 01           Collection (Application)
  06 c1 ff          Usage Page (Vendor-Defined 0xFFC1)
  85 77             Report ID (0x77)
  09 f0             Usage (0xF0)
  75 08  95 3f      Report Size (8), Report Count (63)
  81 02             Input (Data,Var,Abs)

Pressing the button emits a 64-byte report on that collection:

  77 06 00 00 ...   microphone unmuted
  77 06 01 00 ...   microphone muted

where byte 1 identifies the mute event and byte 2 carries the resulting
state.  As the payload is an opaque vendor blob carrying no HID usages,
hid-input cannot map it and a hwdb entry cannot express it either.

Add a driver that decodes the report and emits KEY_MICMUTE, which makes the
button behave like any other microphone mute key.

Note that the device reports the resulting absolute state, whereas
KEY_MICMUTE is a momentary key that userspace acts on as a toggle, so the
driver emits one keypress per state change.

Tested on a HyperX QuadCast 2 (03f0:07b4).

Signed-off-by: Benjamin Blume <benjaminblume@posteo.de>
---

Notes for reviewers:

The report descriptor also declares a Telephony collection (usage page 0x0b)
with Phone Mute (0x2f) on report ID 5, which is why the device already
advertises KEY_MICMUTE.  The firmware never sends that report; the mute state
only ever arrives on the vendor collection decoded here.  The driver therefore
reuses the input device of that telephony collection rather than creating a
second one.

Open question: the device reports an absolute mute state, so SW_MUTE_DEVICE
would model it more faithfully than KEY_MICMUTE.  I went with KEY_MICMUTE
because that is what desktop environments actually act on today, at the cost
of turning an absolute state into a toggle.  Happy to emit the switch in
addition (or instead) if you prefer.

The device also exposes a host-controllable mute LED
(/sys/class/leds/input*::mute), which is left untouched by this patch: the
firmware already drives it in lockstep with its internal mute state.
 MAINTAINERS              |   6 ++
 drivers/hid/Kconfig      |  13 +++++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-hyperx.c | 117 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h    |   1 +
 5 files changed, 138 insertions(+)
 create mode 100644 drivers/hid/hid-hyperx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d..542d606 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11530,6 +11530,12 @@ F:	include/uapi/linux/hid*
 F:	samples/hid/
 F:	tools/testing/selftests/hid/
 
+HID HYPERX DRIVER
+M:	Benjamin Blume <benjaminblume@posteo.de>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-hyperx.c
+
 HID LOGITECH DRIVERS
 R:	Filipe Laíns <lains@riseup.net>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f9bcaeb..e00bac8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -433,6 +433,19 @@ config HOLTEK_FF
 	  Say Y here if you have a Holtek On Line Grip based game controller
 	  and want to have force feedback support for it.
 
+config HID_HYPERX
+	tristate "HyperX microphones"
+	depends on USB_HID
+	help
+	  Support for the mute button of HyperX microphones.
+
+	  The button is handled in the device firmware and only reports the
+	  resulting mute state through a vendor-defined collection, so without
+	  this driver userspace never learns that the microphone was muted.
+
+	  Supported devices:
+	  - HyperX QuadCast 2
+
 config HID_VIVALDI_COMMON
 	tristate
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 23e6e3d..4138be7 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
+obj-$(CONFIG_HID_HYPERX)	+= hid-hyperx.o
 obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
 obj-$(CONFIG_HID_ITE)		+= hid-ite.o
 obj-$(CONFIG_HID_JABRA)		+= hid-jabra.o
diff --git a/drivers/hid/hid-hyperx.c b/drivers/hid/hid-hyperx.c
new file mode 100644
index 0000000..18d2dc2
--- /dev/null
+++ b/drivers/hid/hid-hyperx.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for the HyperX QuadCast 2 microphone
+ *
+ *  The tap-to-mute button is handled entirely in the device firmware: it gates
+ *  the audio internally and does not send the Telephony "Phone Mute" usage its
+ *  own report descriptor advertises.  The resulting mute state is only reported
+ *  through a vendor-defined collection, which hid-input cannot map, so the
+ *  button is invisible to userspace.
+ *
+ *  Copyright (c) 2026 Benjamin Blume <benjaminblume@posteo.de>
+ */
+
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define HYPERX_QC2_REPORT_ID	0x77
+#define HYPERX_QC2_EVENT_MUTE	0x06
+#define HYPERX_QC2_MUTE_LEN	3
+
+struct hyperx_drvdata {
+	struct input_dev *input;
+	bool muted;
+	bool have_state;
+};
+
+static int hyperx_input_configured(struct hid_device *hdev,
+				   struct hid_input *hi)
+{
+	struct hyperx_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	/*
+	 * The device exposes several application collections.  Prefer the
+	 * telephony one, which already advertises KEY_MICMUTE, and fall back
+	 * to the first collection otherwise.
+	 */
+	if (!drvdata->input || test_bit(KEY_MICMUTE, hi->input->keybit)) {
+		drvdata->input = hi->input;
+		input_set_capability(drvdata->input, EV_KEY, KEY_MICMUTE);
+	}
+
+	return 0;
+}
+
+static int hyperx_raw_event(struct hid_device *hdev, struct hid_report *report,
+			    u8 *data, int size)
+{
+	struct hyperx_drvdata *drvdata = hid_get_drvdata(hdev);
+	bool muted;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !drvdata->input)
+		return 0;
+
+	if (size < HYPERX_QC2_MUTE_LEN || data[0] != HYPERX_QC2_REPORT_ID ||
+	    data[1] != HYPERX_QC2_EVENT_MUTE)
+		return 0;
+
+	muted = data[2];
+	if (drvdata->have_state && muted == drvdata->muted)
+		return 0;
+
+	drvdata->muted = muted;
+	drvdata->have_state = true;
+
+	/*
+	 * The device reports the resulting absolute state, while KEY_MICMUTE is
+	 * a momentary key that userspace acts on as a toggle.  Emit one
+	 * keypress per state change.
+	 */
+	input_report_key(drvdata->input, KEY_MICMUTE, 1);
+	input_sync(drvdata->input);
+	input_report_key(drvdata->input, KEY_MICMUTE, 0);
+	input_sync(drvdata->input);
+
+	return 0;
+}
+
+static int hyperx_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct hyperx_drvdata *drvdata;
+	int ret;
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, drvdata);
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+}
+
+static const struct hid_device_id hyperx_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP,
+			 USB_PRODUCT_ID_HP_HYPERX_QUADCAST_2) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, hyperx_devices);
+
+static struct hid_driver hyperx_driver = {
+	.name			= "hyperx",
+	.id_table		= hyperx_devices,
+	.probe			= hyperx_probe,
+	.input_configured	= hyperx_input_configured,
+	.raw_event		= hyperx_raw_event,
+};
+module_hid_driver(hyperx_driver);
+
+MODULE_DESCRIPTION("HID driver for the HyperX QuadCast 2 microphone");
+MODULE_AUTHOR("Benjamin Blume <benjaminblume@posteo.de>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922..76674b3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -688,6 +688,7 @@
 #define USB_DEVICE_ID_HORI_WIRELESS_SWITCH_PAD	0x00f6
 
 #define USB_VENDOR_ID_HP		0x03f0
+#define USB_PRODUCT_ID_HP_HYPERX_QUADCAST_2			0x07b4
 #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
-- 
2.55.0

