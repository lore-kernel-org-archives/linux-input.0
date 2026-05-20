Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF32C21C3
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240726; cv=none; b=a+Fk0ME4IHsIOKj4BmlrWQks3kLfq9VrHQ5bDkTNyAGuMHADc2LtEyW2t2tOOVe6XqPq0NtP8125fDFpmmpSgbbgazkmOHWBIClNRAfrEotA4c+hfRoXjVhEs//tmuWrgC0gu6KRKqVtXDUnMReLcM011vuNnKzeYx4cscB2G6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240726; c=relaxed/simple;
	bh=+Jx2yxq7YNs6OVz2l1IcymfPq7nFQwSnRgTsLTJSW5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTB7hE+qaC2G7PLBaqJtCDGNcGlaWALIPCADxcn+b7gbSxrgsxYoqWBv8TEG13D3c7afNyZTaIvZ3gPFGRvXMPSwOq3gTbIwcWsSMWShY/znXd/cMffrANLSUAkepkB696MaHsHdawMU27JRJGEfoaiYm0NQcpjk2Zw+A7jfjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1Xy/QPF; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Xy/QPF"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-133466cf955so15032001c88.0
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 18:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779240722; x=1779845522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrutNYw40dSQX4DbO4HY9bcnEr6Gu2bjJefb6uGPeWo=;
        b=l1Xy/QPF4IrGzK+c7NdB1Dd+K/m5n7SJAJ1FlUZsnmm0HSa0x4J3PBEIu6tVPzOcXr
         H3xPmhB8mDZ1fX+tM1augj/CC/AA6bB3h6b46SdqMJQJIxRIXYKbzMdA/ZVIo9CFE6g4
         o0V/+x414aI6Ufy2NaS5eSRAJZT+pb7h5gb22jBI4+C4nrzpq2TGIqbyE1OMYqVSsiKB
         sNmBptFEZpSXi6zqCG/OX/qjdltiBdHBHtOU7ONvzWqNLjxhgCq+51gQNJ1M0JPRDxhJ
         +eLIBfEw34M1Feg/16mKVTn1AevkN4A59wiRsjThiiaC9SAl/ymx+431/3O4uSzng+9a
         fALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779240722; x=1779845522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrutNYw40dSQX4DbO4HY9bcnEr6Gu2bjJefb6uGPeWo=;
        b=g8od2HRRCWZB+wkj2rxgCg4b/pRFkdNJXS+qzsOBX84V2F3O3dcmMq2rh7H5RTSDkA
         52oXQJjr5CCeJvicW1TROZ8Aef7ya/5KqiPfZyvJreZGh73MYAxVKRu2ToKVsWuv6P8s
         stzCgSnlm//FYCwxS41JSwvmbOKdSkJIIyaZIBDQ/1ovR9tEaYZihXV9TRy7n92hWhGM
         C9XFD+lRn5UUK8gHmipGK7oK+gzwj0+QIUdh881lb89RQjkS5WUW4FCSf4kS7Kfx/x+k
         p7itSFb28ZH0FeHDlPUPSiUuAZ5L+Dq4E/f4grpYWxcNvM9eVm+R+gnAghQ4EMfb0RDw
         8chw==
X-Forwarded-Encrypted: i=1; AFNElJ8jcpRDK2JW8BnYROK8zNJ9YJMwwiMk/lKzCoj+q7LWjOv13iy4yyq5WuZ5PIRFKVE63i/gyloJmx/FEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUl1V+d6A2F8/s5ZA8nJakPOOhu4Msy1JvczYyeBdjwsuueDGS
	pRNtA8D7v4dIbekz0wW1eqU8jZiTZ87yUgsZPKJGIK1GPGlV0jESNWxi
X-Gm-Gg: Acq92OHYrBhyz6ilMa1AsM9VjT8P9FNhNLd/qAf3foyyDVUABs38zpzmKza0/xHYWK6
	PYMcUD/gbfK1hNEHKwYaAlLuQitVY4SIuXMyVi13UgW4l74cgJuP/M4rMFS6sXYzcwIkPjoszl3
	OknzyppqgOq3bFk+5uXbcGvMXAMVg0eCaKSYus7zU7YbsEEYQqCQ6m9y3DGqbUD5BzqdfRMx3Rw
	4qfo7DT3CkOzm1B08AzhT82FuAg2gx9WMDvedX2s9tvja/m/Fb3oM7y8bH0jhp3EGPBDNALfXDj
	acSJd1mSTOfd+PUOl4xtstnu1iz64lmVFYYjoZ5j5yGn5Z2s5sKRVdXnueo/9YH2qkS7zmvi4ZN
	51OGHNFscWSpyI0FAAjwxH5P+chEVKZKZ3x5ky6FoXtXw9eo6JTBe6r98rqU8q7zD53wi0yXl99
	/3oFvG/lWSGZAeh6svQX5lt44YfczRnQhu2YsCh7xVnhkonT6F5nqZgWQ/j7TJ22x3yZKrRc8ex
	ieu
X-Received: by 2002:a05:7022:3d14:b0:12c:6a24:a24f with SMTP id a92af1059eb24-13504952278mr9490922c88.33.1779240722031;
        Tue, 19 May 2026 18:32:02 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm25383312c88.5.2026.05.19.18.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 18:32:01 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] HID: hid-msi: Add MSI Claw configuration driver
Date: Wed, 20 May 2026 01:31:55 +0000
Message-ID: <20260520013158.3633277-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520013158.3633277-1-derekjohn.clark@gmail.com>
References: <20260520013158.3633277-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds configuration HID driver for the MSI Claw series of handheld PC's.
In this initial patch add the initial driver outline and attributes for
changing the gamepad mode, M-key behavior, and add a WO reset function.

Sending the SWITCH_MODE and RESET commands causes a USB disconnect in
the device. The completion will therefore never get hit and would trigger
an -EIO. To avoid showing the user an error for every write to these
attrs a bypass for the completion handling is introduced when timeout ==
0.

The initial version of this patch was written by Denis Benato, which
contained the initial reverse-engineering and implementation for the
gamepad mode switching. This work was later expanded by Zhouwang Huang
to include more gamepad modes. Finally, I refactored the drivers data
in/out flow and overall format to conform to kernel driver best
practices and style guides. Claude was used as an initial reviewer of
this patch.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v7:
  - Use smp_[store_release|load_acquire] pattern for checking
    gamepad_registered to avoid possible races during teardown.
  - Reorder reinit_completion in claw_hw_output_report to avoid race
    with possible incoming ACKs.
  - Reorder cancel_delayed_work_sync to ensure setup can't be re-armed
    after cancel.
  - Reset command state machine if hw_output_report has an error.
  - Add comments to (hopefully) silence sashinko-bot warnings about the
    use of endpoint matching and the impossible scenario of switching to
    the alternate endpoint from userspace while the driver is bound.
  - Don't use spinlock_irqsave when already in irq context.
v6:
  - Add send/ack pattern to ensure synchronous acks.
  - Use spinlock_irqsave instead of mutex for read/write MODE event
    data.
  - add select NEW_LEDS to kconfig.
  - Make all timeouts 25ms to ensure at least 2 jiffies in a 100Hz
    config.
  - Gate all attribute show/store functions with gamepad_registered,
    enabling use of devm_device_add_group.
  - Re-arm cfg_setup in resume if it was canceled in an early suspend.
  - Don't set gamepad_mode on resume, MCU preserves state.
  - Ensure all count variables are checked for > 0 characters before
    setting buf - 1 to \n.
v5:
  - Swap disabled & combination mkeys_function enum values.
  - Ensure mode_mutex is properly init.
  - Ensure claw_remove is calling hid_hw_close and not hid_hw_stop for
    all paths.
v4:
  - Add msi_suspend/claw_suspend.
  - Reorder claw_remove to cancel all work before removing sysfs.
  - Add mutex lock for removing sysfs attributes.
  - Add mutex lock for MODE command data read/write.
v3:
  - Ensure claw_hw_output_report is properly guarded.
  - Reoder claw_probe to ensure all mutex, completion, and variable
    assignments are in place prior to setting drvdata.
  - Ensure gamepad_mode is set to a valid enum value in claw_probe.
v2:
  - Rename driver to hid-msi from hid-msi-claw.
  - Rename reusable/generic functions to msi_* from claw_*, retaining
    claw specific functions.
  - Add generic entrypoints for probe, remove, and raw event that route
    to claw specific functions.
---
 MAINTAINERS           |   6 +
 drivers/hid/Kconfig   |  13 +
 drivers/hid/Makefile  |   1 +
 drivers/hid/hid-ids.h |   5 +
 drivers/hid/hid-msi.c | 692 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 717 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f6517bf4f970..8e2de98b768f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17965,6 +17965,12 @@ S:	Odd Fixes
 F:	Documentation/devicetree/bindings/net/ieee802154/mrf24j40.txt
 F:	drivers/net/ieee802154/mrf24j40.c
 
+MSI HID DRIVER
+M:	Derek J. Clark <derekjohn.clark@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-msi.c
+
 MSI EC DRIVER
 M:	Nikita Kravets <teackot@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 10c12d8e65579..7766676051a52 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -492,6 +492,19 @@ config HID_GT683R
 	Currently the following devices are know to be supported:
 	  - MSI GT683R
 
+config HID_MSI
+	tristate "MSI Claw Gamepad Support"
+	depends on USB_HID
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_CLASS_MULTICOLOR
+	help
+	Support for the MSI Claw RGB and controller configuration
+
+	Say Y here to include configuration interface support for the MSI Claw Line
+	of Handheld Console Controllers. Say M here to compile this driver as a
+	module. The module will be called hid-msi.
+
 config HID_KEYTOUCH
 	tristate "Keytouch HID devices"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 07dfdb6a49c59..80925a17b059c 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_HID_MAYFLASH)	+= hid-mf.o
 obj-$(CONFIG_HID_MEGAWORLD_FF)	+= hid-megaworld.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
+obj-$(CONFIG_HID_MSI)		+= hid-msi.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
 obj-$(CONFIG_HID_NINTENDO)	+= hid-nintendo.o
 obj-$(CONFIG_HID_NTI)			+= hid-nti.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 933b7943bdb50..94a9b89dc240a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1047,7 +1047,12 @@
 #define USB_DEVICE_ID_MOZA_R16_R21_2	0x0010
 
 #define USB_VENDOR_ID_MSI		0x1770
+#define USB_VENDOR_ID_MSI_2		0x0db0
 #define USB_DEVICE_ID_MSI_GT683R_LED_PANEL 0xff00
+#define USB_DEVICE_ID_MSI_CLAW_XINPUT	0x1901
+#define USB_DEVICE_ID_MSI_CLAW_DINPUT	0x1902
+#define USB_DEVICE_ID_MSI_CLAW_DESKTOP	0x1903
+#define USB_DEVICE_ID_MSI_CLAW_BIOS	0x1904
 
 #define USB_VENDOR_ID_NATIONAL_SEMICONDUCTOR 0x0400
 #define USB_DEVICE_ID_N_S_HARMONY	0xc359
diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
new file mode 100644
index 0000000000000..d95483907a5e5
--- /dev/null
+++ b/drivers/hid/hid-msi.c
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for MSI Claw Handheld PC gamepads.
+ *
+ *  Provides configuration support for the MSI Claw series of handheld PC
+ *  gamepads. Multiple iterations of the device firmware has led to some
+ *  quirks for how certain attributes are handled. The original firmware
+ *  did not support remapping of the M1 (right) and M2 (left) rear paddles.
+ *  Additionally, the MCU RAM address for writing configuration data has
+ *  changed twice. Checks are done during probe to enumerate these variances.
+ *
+ *  Copyright (c) 2026 Zhouwang Huang <honjow311@gmail.com>
+ *  Copyright (c) 2026 Denis Benato <denis.benato@linux.dev>
+ *  Copyright (c) 2026 Valve Corporation
+ */
+
+#include <linux/array_size.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/kobject.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include "hid-ids.h"
+
+#define CLAW_OUTPUT_REPORT_ID	0x0f
+#define CLAW_INPUT_REPORT_ID	0x10
+
+#define CLAW_PACKET_SIZE	64
+
+#define CLAW_DINPUT_CFG_INTF_IN	0x82
+#define CLAW_XINPUT_CFG_INTF_IN	0x83
+
+enum claw_command_index {
+	CLAW_COMMAND_TYPE_NONE =			0x00,
+	CLAW_COMMAND_TYPE_READ_PROFILE =		0x04,
+	CLAW_COMMAND_TYPE_READ_PROFILE_ACK =		0x05,
+	CLAW_COMMAND_TYPE_ACK =				0x06,
+	CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA =		0x21,
+	CLAW_COMMAND_TYPE_SYNC_TO_ROM =			0x22,
+	CLAW_COMMAND_TYPE_SWITCH_MODE =			0x24,
+	CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE =		0x26,
+	CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK =		0x27,
+	CLAW_COMMAND_TYPE_RESET_DEVICE =		0x28,
+};
+
+enum claw_gamepad_mode_index {
+	CLAW_GAMEPAD_MODE_XINPUT =	0x01,
+	CLAW_GAMEPAD_MODE_DINPUT =	0x02,
+	CLAW_GAMEPAD_MODE_DESKTOP =	0x04,
+};
+
+static const char * const claw_gamepad_mode_text[] = {
+	[CLAW_GAMEPAD_MODE_XINPUT] =	"xinput",
+	[CLAW_GAMEPAD_MODE_DINPUT] =	"dinput",
+	[CLAW_GAMEPAD_MODE_DESKTOP] =	"desktop",
+};
+
+enum claw_mkeys_function_index {
+	CLAW_MKEY_FUNCTION_MACRO,
+	CLAW_MKEY_FUNCTION_DISABLED,
+	CLAW_MKEY_FUNCTION_COMBO,
+};
+
+static const char * const claw_mkeys_function_text[] = {
+	[CLAW_MKEY_FUNCTION_MACRO] =	"macro",
+	[CLAW_MKEY_FUNCTION_DISABLED] =	"disabled",
+	[CLAW_MKEY_FUNCTION_COMBO] =	"combination",
+};
+
+struct claw_command_report {
+	u8 report_id;
+	u8 padding[2];
+	u8 header_tail;
+	u8 cmd;
+	u8 data[59];
+} __packed;
+
+struct claw_drvdata {
+	/* MCU General Variables */
+	struct completion send_cmd_complete;
+	struct delayed_work cfg_resume;
+	struct delayed_work cfg_setup;
+	struct hid_device *hdev;
+	struct mutex cfg_mutex; /* mutex for synchronous data */
+	bool waiting_for_ack;
+	spinlock_t cmd_lock; /* Lock for cmd data read/write */
+	u8 waiting_cmd;
+	int cmd_status;
+	u8 ep;
+
+	/* Gamepad Variables */
+	enum claw_mkeys_function_index mkeys_function;
+	enum claw_gamepad_mode_index gamepad_mode;
+	bool gamepad_registered;
+	spinlock_t mode_lock; /* Lock for mode data read/write */
+};
+
+static int get_endpoint_address(struct hid_device *hdev)
+{
+	struct usb_host_endpoint *ep;
+	struct usb_interface *intf;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	ep = intf->cur_altsetting->endpoint;
+	if (ep)
+		return ep->desc.bEndpointAddress;
+
+	return -ENODEV;
+}
+
+static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
+				   struct claw_command_report *cmd_rep)
+{
+	if (cmd_rep->data[0] >= ARRAY_SIZE(claw_gamepad_mode_text) ||
+	    !claw_gamepad_mode_text[cmd_rep->data[0]] ||
+	    cmd_rep->data[1] >= ARRAY_SIZE(claw_mkeys_function_text))
+		return -EINVAL;
+
+	scoped_guard(spinlock, &drvdata->mode_lock) {
+		drvdata->gamepad_mode = cmd_rep->data[0];
+		drvdata->mkeys_function = cmd_rep->data[1];
+	}
+
+	return 0;
+}
+
+static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *report,
+			  u8 *data, int size)
+{
+	struct claw_command_report *cmd_rep;
+	int ret = 0;
+
+	if (size != CLAW_PACKET_SIZE)
+		return 0;
+
+	cmd_rep = (struct claw_command_report *)data;
+
+	if (cmd_rep->report_id != CLAW_INPUT_REPORT_ID || cmd_rep->header_tail != 0x3c)
+		return 0;
+
+	dev_dbg(&drvdata->hdev->dev, "Rx data as raw input report: [%*ph]\n",
+		CLAW_PACKET_SIZE, data);
+
+	switch (cmd_rep->cmd) {
+	case CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK:
+		ret = claw_gamepad_mode_event(drvdata, cmd_rep);
+
+		scoped_guard(spinlock, &drvdata->cmd_lock) {
+			if (drvdata->waiting_for_ack &&
+			    drvdata->waiting_cmd == CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE) {
+				drvdata->cmd_status = ret;
+				drvdata->waiting_for_ack = false;
+				complete(&drvdata->send_cmd_complete);
+			}
+		}
+
+		break;
+	case CLAW_COMMAND_TYPE_ACK:
+		scoped_guard(spinlock, &drvdata->cmd_lock) {
+			if (drvdata->waiting_for_ack) {
+				drvdata->cmd_status = 0;
+				drvdata->waiting_for_ack = false;
+				complete(&drvdata->send_cmd_complete);
+			}
+			dev_dbg(&drvdata->hdev->dev, "Waiting CMD: %x\n", drvdata->waiting_cmd);
+		}
+
+		break;
+	default:
+		dev_dbg(&drvdata->hdev->dev, "Unknown command: %x\n", cmd_rep->cmd);
+		return 0;
+	}
+
+	return ret;
+}
+
+static int msi_raw_event(struct hid_device *hdev, struct hid_report *report,
+			 u8 *data, int size)
+{
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata || (drvdata->ep != CLAW_XINPUT_CFG_INTF_IN &&
+			 drvdata->ep != CLAW_DINPUT_CFG_INTF_IN))
+		return 0;
+
+	return claw_raw_event(drvdata, report, data, size);
+}
+
+static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *data,
+				 size_t len, unsigned int timeout)
+{
+	unsigned char *dmabuf __free(kfree) = NULL;
+	u8 header[] = { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	size_t header_size = ARRAY_SIZE(header);
+	int ret;
+
+	if (header_size + len > CLAW_PACKET_SIZE)
+		return -EINVAL;
+
+	/* We can't use a devm_alloc reusable buffer without side effects during suspend */
+	dmabuf = kzalloc(CLAW_PACKET_SIZE, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	memcpy(dmabuf, header, header_size);
+	if (data && len)
+		memcpy(dmabuf + header_size, data, len);
+
+	guard(mutex)(&drvdata->cfg_mutex);
+	if (timeout) {
+		reinit_completion(&drvdata->send_cmd_complete);
+		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
+			drvdata->waiting_cmd = index;
+			drvdata->waiting_for_ack = true;
+			drvdata->cmd_status = -ETIMEDOUT;
+		}
+	}
+
+	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
+		CLAW_PACKET_SIZE, dmabuf);
+
+	ret = hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = ret == CLAW_PACKET_SIZE ? 0 : -EIO;
+	if (ret) {
+		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
+			drvdata->waiting_cmd = CLAW_COMMAND_TYPE_NONE;
+			drvdata->waiting_for_ack = false;
+		}
+		return ret;
+	}
+
+	if (timeout) {
+		ret = wait_for_completion_interruptible_timeout(&drvdata->send_cmd_complete,
+								msecs_to_jiffies(timeout));
+
+		dev_dbg(&hdev->dev, "Remaining timeout: %u\n", ret);
+		ret = ret > 0 ? drvdata->cmd_status : ret ?: -EBUSY;
+		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock)
+			drvdata->waiting_for_ack = false;
+	}
+
+	return ret;
+}
+
+static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int i, ret = -EINVAL;
+	u8 data[2];
+
+	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	if (!smp_load_acquire(&drvdata->gamepad_registered))
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(claw_gamepad_mode_text); i++) {
+		if (claw_gamepad_mode_text[i] && sysfs_streq(buf, claw_gamepad_mode_text[i])) {
+			ret = i;
+			break;
+		}
+	}
+	if (ret < 0)
+		return ret;
+
+	data[0] = ret;
+	scoped_guard(spinlock_irqsave, &drvdata->mode_lock)
+		data[1] = drvdata->mkeys_function;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data, ARRAY_SIZE(data), 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t gamepad_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret, i;
+
+	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	if (!smp_load_acquire(&drvdata->gamepad_registered))
+		return -ENODEV;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 25);
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock_irqsave, &drvdata->mode_lock)
+		i = drvdata->gamepad_mode;
+
+	if (!claw_gamepad_mode_text[i] || claw_gamepad_mode_text[i][0] == '\0')
+		return sysfs_emit(buf, "unsupported\n");
+
+	return sysfs_emit(buf, "%s\n", claw_gamepad_mode_text[i]);
+}
+static DEVICE_ATTR_RW(gamepad_mode);
+
+static ssize_t gamepad_mode_index_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(claw_gamepad_mode_text); i++) {
+		if (!claw_gamepad_mode_text[i] || claw_gamepad_mode_text[i][0] == '\0')
+			continue;
+		count += sysfs_emit_at(buf, count, "%s ", claw_gamepad_mode_text[i]);
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(gamepad_mode_index);
+
+static ssize_t mkeys_function_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int i, ret = -EINVAL;
+	u8 data[2];
+
+	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	if (!smp_load_acquire(&drvdata->gamepad_registered))
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(claw_mkeys_function_text); i++) {
+		if (claw_mkeys_function_text[i] && sysfs_streq(buf, claw_mkeys_function_text[i])) {
+			ret = i;
+			break;
+		}
+	}
+	if (ret < 0)
+		return ret;
+
+	scoped_guard(spinlock_irqsave, &drvdata->mode_lock)
+		data[0] = drvdata->gamepad_mode;
+	data[1] = ret;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data, ARRAY_SIZE(data), 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t mkeys_function_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret, i;
+
+	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	if (!smp_load_acquire(&drvdata->gamepad_registered))
+		return -ENODEV;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 25);
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock_irqsave, &drvdata->mode_lock)
+		i = drvdata->mkeys_function;
+
+	if (i >= ARRAY_SIZE(claw_mkeys_function_text))
+		return sysfs_emit(buf, "unsupported\n");
+
+	return sysfs_emit(buf, "%s\n", claw_mkeys_function_text[i]);
+}
+static DEVICE_ATTR_RW(mkeys_function);
+
+static ssize_t mkeys_function_index_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	int i, count = 0;
+
+	for (i = 0; i < ARRAY_SIZE(claw_mkeys_function_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", claw_mkeys_function_text[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(mkeys_function_index);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	bool val;
+	int ret;
+
+	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	if (!smp_load_acquire(&drvdata->gamepad_registered))
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_RESET_DEVICE, NULL, 0, 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribute *attr,
+					    int n)
+{
+	struct hid_device *hdev = to_hid_device(kobj_to_dev(kobj));
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata) {
+		dev_warn(&hdev->dev,
+			 "Failed to get drvdata from kobj. Gamepad attributes are not available.\n");
+		return 0;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute *claw_gamepad_attrs[] = {
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
+	&dev_attr_mkeys_function.attr,
+	&dev_attr_mkeys_function_index.attr,
+	&dev_attr_reset.attr,
+	NULL,
+};
+
+static const struct attribute_group claw_gamepad_attr_group = {
+	.attrs = claw_gamepad_attrs,
+	.is_visible = claw_gamepad_attr_is_visible,
+};
+
+static void cfg_setup_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work, work);
+	struct claw_drvdata *drvdata = container_of(dwork, struct claw_drvdata, cfg_setup);
+	int ret;
+
+	ret = claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE,
+				    NULL, 0, 25);
+	if (ret) {
+		dev_err(&drvdata->hdev->dev,
+			"Failed to setup device, can't read gamepad mode: %d\n", ret);
+		return;
+	}
+
+	/* Add sysfs attributes after we get the device state */
+	ret = devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_group);
+	if (ret) {
+		dev_err(&drvdata->hdev->dev,
+			"Failed to setup device, can't create gamepad attrs: %d\n", ret);
+		return;
+	}
+	/* Pairs with smp_load_acquire in attribute show/store functions */
+	smp_store_release(&drvdata->gamepad_registered, true);
+
+	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
+}
+
+static void cfg_resume_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work, work);
+	struct claw_drvdata *drvdata = container_of(dwork, struct claw_drvdata, cfg_resume);
+
+	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	if (!smp_load_acquire(&drvdata->gamepad_registered))
+		schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500));
+}
+
+static int claw_probe(struct hid_device *hdev, u8 ep)
+{
+	struct claw_drvdata *drvdata;
+	int ret;
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->gamepad_mode = CLAW_GAMEPAD_MODE_XINPUT;
+	drvdata->hdev = hdev;
+	drvdata->ep = ep;
+
+	mutex_init(&drvdata->cfg_mutex);
+	spin_lock_init(&drvdata->cmd_lock);
+	spin_lock_init(&drvdata->mode_lock);
+	init_completion(&drvdata->send_cmd_complete);
+	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
+	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
+
+	/* For control interface: open the HID transport for sending commands. */
+	ret = hid_hw_open(hdev);
+	if (ret)
+		return ret;
+
+	hid_set_drvdata(hdev, drvdata);
+	schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500));
+
+	return 0;
+}
+
+static int msi_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	u8 ep;
+
+	if (!hid_is_usb(hdev)) {
+		ret = -ENODEV;
+		goto err_probe;
+	}
+
+	ret = hid_parse(hdev);
+	if (ret)
+		goto err_probe;
+
+	/* Set quirk to create separate input devices per HID application */
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP | HID_QUIRK_MULTI_INPUT;
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		goto err_probe;
+
+	/* For non-control interfaces (keyboard/mouse), allow userspace to grab the devices. */
+	ret = get_endpoint_address(hdev);
+	if (ret < 0)
+		goto err_stop_hw;
+
+	ep = ret;
+	if (ep == CLAW_XINPUT_CFG_INTF_IN || ep == CLAW_DINPUT_CFG_INTF_IN) {
+		ret = claw_probe(hdev, ep);
+		if (ret)
+			goto err_stop_hw;
+	}
+
+	return 0;
+
+err_stop_hw:
+	hid_hw_stop(hdev);
+err_probe:
+	return dev_err_probe(&hdev->dev, ret, "Failed to init device\n");
+}
+
+static void claw_remove(struct hid_device *hdev)
+{
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata) {
+		hid_hw_close(hdev);
+		return;
+	}
+
+	cancel_delayed_work_sync(&drvdata->cfg_resume);
+	cancel_delayed_work_sync(&drvdata->cfg_setup);
+
+	/* Pairs with smp_load_acquire in attribute show/store functions */
+	smp_store_release(&drvdata->gamepad_registered, false);
+
+	hid_hw_close(hdev);
+}
+
+static void msi_remove(struct hid_device *hdev)
+{
+	int ret;
+	u8 ep;
+
+	/* Safe assumption. SET_INTERFACE ioctl can't be used while driver is bound */
+	ret = get_endpoint_address(hdev);
+	if (ret <= 0)
+		goto hw_stop;
+
+	ep = ret;
+	if (ep == CLAW_XINPUT_CFG_INTF_IN || ep == CLAW_DINPUT_CFG_INTF_IN)
+		claw_remove(hdev);
+
+hw_stop:
+	hid_hw_stop(hdev);
+}
+
+static int claw_resume(struct hid_device *hdev)
+{
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata)
+		return -ENODEV;
+
+	/* MCU can take up to 500ms to be ready after resume */
+	schedule_delayed_work(&drvdata->cfg_resume, msecs_to_jiffies(500));
+	return 0;
+}
+
+static int msi_resume(struct hid_device *hdev)
+{
+	int ret;
+	u8 ep;
+
+	/* Safe assumption. SET_INTERFACE ioctl can't be used while driver is bound */
+	ret = get_endpoint_address(hdev);
+	if (ret <= 0)
+		return 0;
+
+	ep = ret;
+	if (ep == CLAW_XINPUT_CFG_INTF_IN || ep == CLAW_DINPUT_CFG_INTF_IN)
+		return claw_resume(hdev);
+
+	return 0;
+}
+
+static int claw_suspend(struct hid_device *hdev)
+{
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata)
+		return -ENODEV;
+
+	cancel_delayed_work_sync(&drvdata->cfg_resume);
+	cancel_delayed_work_sync(&drvdata->cfg_setup);
+
+	return 0;
+}
+
+static int msi_suspend(struct hid_device *hdev, pm_message_t msg)
+{
+	int ret;
+	u8 ep;
+
+	/* Safe assumption. SET_INTERFACE ioctl can't be used while driver is bound */
+	ret = get_endpoint_address(hdev);
+	if (ret <= 0)
+		return 0;
+
+	ep = ret;
+	if (ep == CLAW_XINPUT_CFG_INTF_IN || ep == CLAW_DINPUT_CFG_INTF_IN)
+		return claw_suspend(hdev);
+
+	return 0;
+}
+
+static const struct hid_device_id msi_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_XINPUT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_DINPUT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_DESKTOP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_BIOS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, msi_devices);
+
+static struct hid_driver msi_driver = {
+	.name		= "hid-msi",
+	.id_table	= msi_devices,
+	.raw_event	= msi_raw_event,
+	.probe		= msi_probe,
+	.remove		= msi_remove,
+	.resume		= msi_resume,
+	.suspend	= pm_ptr(msi_suspend),
+};
+module_hid_driver(msi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Denis Benato <denis.benato@linux.dev>");
+MODULE_AUTHOR("Zhouwang Huang <honjow311@gmail.com>");
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("HID driver for MSI Claw Handheld PC gamepads");
-- 
2.53.0

