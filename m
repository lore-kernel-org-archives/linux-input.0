Received: from outbound.pv.icloud.com (pv-2006k-snip4-11.eps.apple.com [57.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D93932C9
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608251; cv=none; b=bBIofJbaEn242dt9M+zrqnO1HARgptx78OdDc+zv0YfjqtKDELtecVCefqZu2zTN7qg0pupJOcYFbt497tVggd4V3MKgmwgfYp6wsl93IYq+nQ78lG+niYrYYI0L5QjSIfL3p+gufBRSq/ZBdfJJkM7M3rAjOBCg+2MDRFpxgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608251; c=relaxed/simple;
	bh=fkndWUCFOVaduiApT5mfoJy9TPofghRReckfrTHQcn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0YHSZQrK1d4HR9w3O6jCuIE0iiA5Y/4dFIl97/Ts0QllwVY1qrWjfoLgs7m5lL38AVnWfKVlYFlfzrQHLr/CHRdgK3hnzL2MR4Ix4EZYKoRkwTH+/binzaEy/NwEXVEzN0KMzQmWxyQ4N+uHM+udizcQmomjPl6drACyiPWiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me; spf=pass smtp.mailfrom=matias.me; dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b=uRPufbku; arc=none smtp.client-ip=57.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b="uRPufbku"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPS id 46BF2180011C;
	Mon, 24 Aug 2026 21:50:47 +0000 (UTC)
X-ICL-RepId: 01a035c1-2ba9-7547-b75a-fc81d27cbc7a
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhAAkMDWBxCCE0dXgdLVxQEEFYBWwRyHVgMWgxERV8VGR5XUFoKRhlYCx0AUktAEwRPEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXgxDAlMDFxVWTVoCVk0FSgNfAVsKQg1KAlgHXwNeDkELVAVGA11RHV8BWCtfEU0RUh4ZBldOGQxKHVJWUQVKDFwAaA9dHVgRXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1787608248; x=1790200248; bh=qewjIzzZ+ngNhaSDxNo/RJpcVei58GYRs/Fn+od/qSQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=uRPufbku3XF9PxzvkHZaMlwvXOv8iEhJ/6LLCl2cRUD1bUz7/7INxrZBZ+T21apKbnGq1mFyG1OvioR2Y7SbQaFO+3AsIEhClM1d5W55JaIms0G+pzM11aKAy0lXOwXGjS0ob/CGSX54hW+N61/Q0BT5uEmJyJ0/GugBns9uXBHsnU7asfFiNk3pr+JlIQt4/NWwDQd7KA4CRIuaYtubmU0Dk2xL2ZaqugYmbUxGrtAjdP5tLRD2eoCYrCWvK8SFAS2GjwzTvcDInV42IecP2PAeleO5L44cC1+L3O683yuxFCV5ITFpYz5sS6JcdqpgcnnYSzWLI3AEo2yN7DPmeA==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPSA id C98C11800842;
	Mon, 24 Aug 2026 21:50:44 +0000 (UTC)
From: =?UTF-8?q?Mati=CC=81as=20Marti=CC=81nez?= <hello@matias.me>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Mati=CC=81as=20Marti=CC=81nez?= <hello@matias.me>
Subject: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Mon, 24 Aug 2026 17:50:41 -0400
Message-ID: <20260824215041.79892-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0B7wb7p21-5DWobArdenECeaB7AhKinm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4NSBTYWx0ZWRfX9yabQoMrcagd
 xd7CQfhp37NegHCkBgt6rBMOhwS5CznBfJesKhKyr0RvHFjuEahWGFUr1oR8b/LopC3JXMOBpfh
 oHgDZnRG55cpWd3G5DdEAevqgN32emKhfMFTe+0uZfVzbo54kWx2xkE4kVHobCby2nC8kxor+kl
 FFWgN9TiXoHD+dtEQ2DaeY4I4GnZFPihk3KPMKUV1PexYSQyowRQy5DzwEsuU/6FxeJuRKaliAe
 Pw+nCdXs9To4B7cEHti2rYdjQ04VnHXknBQQx4stqWW9ZQrtHp9TIaFU+ePOB+oYXVEz1/gnRNB
 1CUj/GMuBgHWx3mfFsIH4ColxC1gs6mbXLJmeLXH0Kw379npfiObq+7ySWFuk0=
X-Proofpoint-ORIG-GUID: 0B7wb7p21-5DWobArdenECeaB7AhKinm
X-Authority-Info-Out: v=2.4 cv=LYsxKzfi c=1 sm=1 tr=0 ts=6a8cbcb8
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=wp4DFzs0ZLdPC-dFonYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB9iC0IiNamG8EAMylDGrJXioqsdZ1lgKgbBIuqEiP6wYLgEQjTutYC764pq6wabi0stLNT/QiCgx4XyGEvm0IWnSCauFxr/zy0FFPVuW1ifF5scTU09P2ve1kmps1Xn+tf92+piwOxATamoz4IVbvbajCMllmFZKEfUsKltiHTBT9oZVcxLZIj7fKxLdMbQFb0DES788F+IBXiyEBnTwx+hwe8lAJ9PoN9KWRmJ8owBCbz7YLEJiVmvPLRtV4Z0T9yEa+K/OAEqjJM+z1Z0L5tcQ2Q+Zus6dLK/EG8Pawhfq9iDV7BmpXBxiX9rGusOwgGvJRe1UV7tS4C8wBxrTJh0MWdmsYBVhgKLV3TzlMSuHeIDcqHzeLHMlYrsFM3bmdCOoDwJ7F+x6pSW+Xl8vqg043uh/EXF8BDUMJbOAW+faCEgPZRxaSawCeTOiMTTvZr3yqyqOD1zJ2ix4vMyPhXso0SoVTNISJNJYdAX+9WHhonFt3d5LKS3wKirXsK0xJdm7SMl/Ii6Wy+SxJnqxdrLQAzFsrwTUFqj+CBmjEQxLw6zRJUX9V1RtzaMXf7ZTY+cBDFIEhUdzdIt1xf8JlG4ff85rgckXFqnnMKVarAw13XXcwEb8QSeeM64pAFsQ578xyahHZrnE+2a1oxjCPdjBgqUXH61Q+q9TwB0FBzEDDpT59+9pcgYJkGkU6XCNCCZa30+5wiT7f6ogCNwZSQNJxX9Xvct9+NgtQyIwQjxe0PEoQjp00MNs3d29PrRQFfo4sv4FYDd+i8/n+ynxMtbzQzCT7i7qUpZRxNPeTo7RBslDS6RivcUWGGyyr+u667IftVaGCw6iFPL8NAU2kwuQVLc1IceHCYkE3MJZGn9I+1WSIDMmNfN7D56yfFLzKRV9z1zP/k7SyX96iyHRXL3J+gqEBAuFomKU9Nz9JzxbOxeVN/tUCG+rKbTMCJt8sFmh+Jmd6mc0dBDzAHXEQlGs
 MU2IO8gBZBSZYX+01QEPdON6dUpt6NCEPgMu9sch1vrscs9WVYRS2Cff+Gd2V4luyJGUBNopQ2IGrFqBK9mW/KiPcPhm/eiD4EVaYjIsPg+TiUnGMmqvLr36a8uFVhobpU0W+Lstj4EThyrhZVE8doySTcSXjnYAApukbNCnUxpYoUkn+yXmOQHh2hPxR22Mi6PsrXeyD7pELybIfzOWnYg7OaEdh0Hsj1zdnJSU0IbsfxNC5Y6S9os3g12vE+8wBCPiq15CGpJWaI3WS6eEDNTZM8zD8wgu8BtW/AMckX9cDj1J8I4Uncgozla1DNH0avteX9NIljjUOtErkQsc=

The AYANEO 3 handheld has a detachable controller with swappable
modules ("Magic Modules"). The controller exposes three USB HID
interfaces behind 1c4f:0002 (a generic SigmaMicro VID/PID, hence the
DMI gate): a gamepad, a keyboard for the extra buttons, and a vendor
interface accepting 65-byte commands.

Add a driver for the vendor interface providing module identification
(module_left/module_right sysfs attributes), software eject of the
modules (eject sysfs attribute, blocking until the firmware confirms
the release handshake), and RGB control of the joystick rings as a
multicolor LED class device ("<device name>:rgb:joystick_rings";
userspace such as InputPlumber matches the function suffix).

This complements the ayaneo-ec platform driver, which exposes module
attach state and controller power. A full physical eject is performed
by writing to eject and then cutting power through ayaneo-ec's
controller_power attribute; that orchestration is deliberately left
to userspace.

The protocol was reverse engineered in the Handheld Daemon project by
Antheas Kapenekakis. Tested on an AYANEO 3: module identification,
RGB, and a full eject/reinsert/repower cycle.

Signed-off-by: Matías Martínez <hello@matias.me>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
 .../ABI/testing/sysfs-driver-hid-ayaneo       |  36 ++
 MAINTAINERS                                   |   7 +
 drivers/hid/Kconfig                           |  14 +
 drivers/hid/Makefile                          |   1 +
 drivers/hid/hid-ayaneo.c                      | 471 ++++++++++++++++++
 5 files changed, 529 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ayaneo
 create mode 100644 drivers/hid/hid-ayaneo.c

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ayaneo b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
new file mode 100644
index 000000000..807c4fc9d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
@@ -0,0 +1,36 @@
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/module_left
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/module_right
+Date:		August 2026
+KernelVersion:	7.3
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Reports the type of the module currently inserted in the
+		left/right slot of the AYANEO 3 detachable controller, as
+		the raw identifier reported by the controller firmware in
+		hexadecimal (e.g. "0x04"). Bits 0-5 encode the module
+		type, bit 6 indicates the module is inserted rotated.
+
+		Reading these attributes queries the controller and can
+		take up to a second.
+
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/eject
+Date:		August 2026
+KernelVersion:	7.3
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Write-only. Writing "left", "right" or "both" asks the
+		controller firmware to release the corresponding
+		module(s). The write blocks until the firmware confirms
+		the release handshake (typically a few seconds). The
+		module is physically released once controller power is
+		subsequently cut through the ayaneo-ec platform driver's
+		controller_power attribute; that final step is left to
+		userspace.
+
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/reset
+Date:		August 2026
+KernelVersion:	7.3
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Write-only. Writing "1" asks the controller firmware to
+		perform a quick reset of the controller configuration.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6ecfe6c9e..360f01d39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4469,6 +4469,13 @@ F:	Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
 F:	drivers/spi/spi-axiado.c
 F:	drivers/spi/spi-axiado.h
 
+AYANEO 3 CONTROLLER HID DRIVER
+M:	Matías Martínez <hello@matias.me>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-hid-ayaneo
+F:	drivers/hid/hid-ayaneo.c
+
 AYANEO PLATFORM EC DRIVER
 M:	Antheas Kapenekakis <lkml@antheas.dev>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index aa7fa11a0..9693a0233 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -205,6 +205,20 @@ config HID_AUREAL
 	help
 	Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
 
+config HID_AYANEO
+	tristate "AYANEO 3 detachable controller support"
+	depends on USB_HID
+	depends on DMI
+	depends on LEDS_CLASS_MULTICOLOR
+	help
+	  Provides support for the detachable controller ("Magic Modules")
+	  of the AYANEO 3 handheld: module identification, software eject
+	  and RGB control of the joystick rings. Complements the ayaneo-ec
+	  platform driver, which handles module attach state and controller
+	  power.
+
+	  Say Y or M here if you have an AYANEO 3.
+
 config HID_BELKIN
 	tristate "Belkin Flip KVM and Wireless keyboard"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b24..60add9348 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD)	+= hid-appletb-kbd.o
 obj-$(CONFIG_HID_CREATIVE_SB0540)	+= hid-creative-sb0540.o
 obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
 obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
+obj-$(CONFIG_HID_AYANEO)	+= hid-ayaneo.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
 obj-$(CONFIG_HID_BIGBEN_FF)	+= hid-bigbenff.o
diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
new file mode 100644
index 000000000..61c64617f
--- /dev/null
+++ b/drivers/hid/hid-ayaneo.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HID driver for the AYANEO 3 detachable controller ("Magic Modules").
+ *
+ * The AYANEO 3 controller exposes three USB HID interfaces behind
+ * VID 0x1c4f PID 0x0002 (a generic SigmaMicro ID, hence the DMI gate):
+ * a gamepad, a keyboard for the extra buttons, and a vendor interface
+ * (application usage 0xff000001) accepting 65-byte commands.
+ *
+ * This driver binds the vendor interface and provides:
+ *  - module identification (which module type is inserted on each side)
+ *  - software eject of the left/right modules
+ *  - RGB control of the joystick rings as a multicolor LED class device
+ *
+ * It complements the ayaneo-ec platform driver, which exposes module
+ * attach state and controller power. A full eject is: write to this
+ * driver's "eject" attribute, then power the controller off through
+ * ayaneo-ec's controller_power once the eject completes.
+ *
+ * The protocol was reverse engineered in the Handheld Daemon project by
+ * Antheas Kapenekakis.
+ *
+ * Command format (65 bytes, unnumbered report):
+ *   [0]   report id (0)
+ *   [1:3] little-endian sum of bytes 7..64
+ *   [3]   command
+ *   [4]   subcommand
+ *   [5:]  payload
+ * The device replies with a 64-byte report echoing the subcommand at
+ * byte 3.
+ *
+ * Copyright (C) 2026 Matías Martínez <hello@matias.me>
+ */
+
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/hid.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+#include <linux/unaligned.h>
+
+#define AYA3_REPORT_SIZE	65
+#define AYA3_RESP_SIZE		64
+#define AYA3_CMD_TIMEOUT_MS	300
+#define AYA3_CMD_ATTEMPTS	3
+
+/* Subcommands (byte 4); byte 3 is 0x00 except for the config command */
+#define AYA3_SUBCMD_CHECK	0x08
+#define AYA3_CMD_CONFIG		0x21
+#define AYA3_SUBCMD_CONFIG	0x09
+
+/* CHECK response fields */
+#define AYA3_RESP_CMD		3
+#define AYA3_RESP_EJECT_STATUS	19
+#define AYA3_RESP_MODULE_LEFT	32
+#define AYA3_RESP_MODULE_RIGHT	33
+/* Bits that stay set in the eject status byte after an eject completes */
+#define AYA3_EJECT_DONE_MASK	0x11
+
+/* Config command eject/reset field */
+#define AYA3_EJECT_LEFT		0x07
+#define AYA3_EJECT_RIGHT	0x70
+#define AYA3_RESET		0x88
+
+/* Config command RGB modes */
+#define AYA3_RGB_SOLID		0x01
+#define AYA3_RGB_OFF		0xff
+
+#define AYA3_VIBRATION_DEFAULT	0x02	/* medium */
+
+struct aya3 {
+	struct hid_device *hdev;
+	/* DMA-safe command buffer; guarded by lock */
+	u8 *xfer;
+	/* Serializes commands and cached-config access */
+	struct mutex lock;
+	struct completion resp_done;
+	u8 resp[AYA3_RESP_SIZE];
+	u8 resp_expect;
+	bool resp_pending;
+
+	u8 rgb[3];
+	u8 vibration;
+
+	struct led_classdev_mc mcled;
+	struct mc_subled subleds[3];
+};
+
+static int aya3_send(struct aya3 *aya)
+{
+	int ret;
+
+	ret = hid_hw_output_report(aya->hdev, aya->xfer, AYA3_REPORT_SIZE);
+	if (ret == -ENOSYS)
+		ret = hid_hw_raw_request(aya->hdev, aya->xfer[0], aya->xfer,
+					 AYA3_REPORT_SIZE, HID_OUTPUT_REPORT,
+					 HID_REQ_SET_REPORT);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+/**
+ * aya3_cmd() - send the command in aya->xfer and wait for the reply
+ * @aya: driver data; @aya->xfer holds the fully built 65-byte command
+ * @resp: destination for the AYA3_RESP_SIZE-byte reply, or NULL to
+ *        discard it
+ *
+ * The device echoes the subcommand byte of the command it is answering,
+ * which aya3_raw_event() uses to match replies. Unanswered commands are
+ * retried up to AYA3_CMD_ATTEMPTS times.
+ *
+ * Context: process context; the caller must hold @aya->lock, which
+ *          protects @aya->xfer and the reply state.
+ * Return: 0 on success, -ETIMEDOUT if every attempt went unanswered, or
+ *         a negative errno if sending failed.
+ */
+static int aya3_cmd(struct aya3 *aya, u8 *resp)
+{
+	int attempt, ret;
+
+	lockdep_assert_held(&aya->lock);
+
+	for (attempt = 0; attempt < AYA3_CMD_ATTEMPTS; attempt++) {
+		reinit_completion(&aya->resp_done);
+		aya->resp_expect = aya->xfer[4];
+		WRITE_ONCE(aya->resp_pending, true);
+
+		ret = aya3_send(aya);
+		if (ret) {
+			WRITE_ONCE(aya->resp_pending, false);
+			return ret;
+		}
+
+		if (wait_for_completion_timeout(&aya->resp_done,
+						msecs_to_jiffies(AYA3_CMD_TIMEOUT_MS))) {
+			if (resp)
+				memcpy(resp, aya->resp, AYA3_RESP_SIZE);
+			return 0;
+		}
+	}
+	WRITE_ONCE(aya->resp_pending, false);
+	return -ETIMEDOUT;
+}
+
+static void aya3_checksum(u8 *buf)
+{
+	u16 sum = 0;
+	int i;
+
+	for (i = 7; i < AYA3_REPORT_SIZE; i++)
+		sum += buf[i];
+	put_unaligned_le16(sum, buf + 1);
+}
+
+static int aya3_check(struct aya3 *aya, u8 *resp)
+{
+	memset(aya->xfer, 0, AYA3_REPORT_SIZE);
+	aya->xfer[4] = AYA3_SUBCMD_CHECK;
+	return aya3_cmd(aya, resp);
+}
+
+/*
+ * The config command sets everything at once: RGB for both rings,
+ * vibration strength, joystick sensitivity, and the eject/reset field.
+ */
+static int aya3_send_config(struct aya3 *aya, u8 eject)
+{
+	static const u8 template[AYA3_REPORT_SIZE] = {
+		[3] = AYA3_CMD_CONFIG,
+		[4] = AYA3_SUBCMD_CONFIG,
+		[22] = 0x33,
+		[23] = 0x22,	/* joystick sensitivity 100%/100% */
+		[32] = 0x01,
+		[37] = 0x64,
+		[38] = 0x64,
+	};
+	u8 *buf = aya->xfer;
+	u8 mode = (aya->rgb[0] || aya->rgb[1] || aya->rgb[2]) ?
+		  AYA3_RGB_SOLID : AYA3_RGB_OFF;
+
+	memcpy(buf, template, AYA3_REPORT_SIZE);
+	/* Right ring, then left ring: mode, R, G, B */
+	buf[8] = mode;
+	memcpy(buf + 9, aya->rgb, 3);
+	buf[12] = mode;
+	memcpy(buf + 13, aya->rgb, 3);
+	buf[20] = eject;
+	buf[24] = aya->vibration << 4;
+	aya3_checksum(buf);
+
+	return aya3_cmd(aya, NULL);
+}
+
+static int aya3_raw_event(struct hid_device *hdev, struct hid_report *report,
+			  u8 *data, int size)
+{
+	struct aya3 *aya = hid_get_drvdata(hdev);
+
+	if (!READ_ONCE(aya->resp_pending) || size < AYA3_RESP_SIZE)
+		return 0;
+	if (data[AYA3_RESP_CMD] != aya->resp_expect)
+		return 0;
+
+	memcpy(aya->resp, data, AYA3_RESP_SIZE);
+	WRITE_ONCE(aya->resp_pending, false);
+	complete(&aya->resp_done);
+	return 0;
+}
+
+static ssize_t aya3_module_show(struct device *dev, char *buf, int offset)
+{
+	struct aya3 *aya = dev_get_drvdata(dev);
+	u8 resp[AYA3_RESP_SIZE];
+	int ret;
+
+	ret = mutex_lock_interruptible(&aya->lock);
+	if (ret)
+		return ret;
+	ret = aya3_check(aya, resp);
+	mutex_unlock(&aya->lock);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%02x\n", resp[offset]);
+}
+
+static ssize_t module_left_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return aya3_module_show(dev, buf, AYA3_RESP_MODULE_LEFT);
+}
+static DEVICE_ATTR_RO(module_left);
+
+static ssize_t module_right_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return aya3_module_show(dev, buf, AYA3_RESP_MODULE_RIGHT);
+}
+static DEVICE_ATTR_RO(module_right);
+
+static ssize_t eject_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct aya3 *aya = dev_get_drvdata(dev);
+	u8 resp[AYA3_RESP_SIZE];
+	u8 eject;
+	int ret, i;
+
+	if (sysfs_streq(buf, "left"))
+		eject = AYA3_EJECT_LEFT;
+	else if (sysfs_streq(buf, "right"))
+		eject = AYA3_EJECT_RIGHT;
+	else if (sysfs_streq(buf, "both"))
+		eject = AYA3_EJECT_LEFT | AYA3_EJECT_RIGHT;
+	else
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&aya->lock);
+	if (ret)
+		return ret;
+
+	ret = aya3_send_config(aya, eject);
+	if (ret)
+		goto out;
+
+	/*
+	 * Wait for the firmware to report the eject as done. Userspace
+	 * must then cut power through ayaneo-ec's controller_power for
+	 * the module to be physically released.
+	 */
+	ret = -ETIMEDOUT;
+	for (i = 0; i < 20; i++) {
+		msleep(400);
+		if (aya3_check(aya, resp))
+			continue;
+		if (!(resp[AYA3_RESP_EJECT_STATUS] & ~AYA3_EJECT_DONE_MASK)) {
+			ret = 0;
+			break;
+		}
+	}
+out:
+	mutex_unlock(&aya->lock);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(eject);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct aya3 *aya = dev_get_drvdata(dev);
+	bool value;
+	int ret;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+	if (!value)
+		return count;
+
+	ret = mutex_lock_interruptible(&aya->lock);
+	if (ret)
+		return ret;
+	ret = aya3_send_config(aya, AYA3_RESET);
+	if (!ret) {
+		msleep(500);
+		ret = aya3_send_config(aya, 0);
+	}
+	mutex_unlock(&aya->lock);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *aya3_attrs[] = {
+	&dev_attr_module_left.attr,
+	&dev_attr_module_right.attr,
+	&dev_attr_eject.attr,
+	&dev_attr_reset.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(aya3);
+
+static int aya3_led_set(struct led_classdev *cdev, enum led_brightness value)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct aya3 *aya = container_of(mc, struct aya3, mcled);
+	int ret, i;
+
+	ret = mutex_lock_interruptible(&aya->lock);
+	if (ret)
+		return ret;
+
+	led_mc_calc_color_components(mc, value);
+	for (i = 0; i < 3; i++)
+		aya->rgb[i] = min_t(unsigned int, aya->subleds[i].brightness, 255);
+
+	ret = aya3_send_config(aya, 0);
+	if (ret)
+		hid_err(aya->hdev, "failed to update RGB config: %d\n", ret);
+	mutex_unlock(&aya->lock);
+	return ret;
+}
+
+static int aya3_register_led(struct aya3 *aya)
+{
+	struct led_classdev *cdev = &aya->mcled.led_cdev;
+
+	aya->subleds[0].color_index = LED_COLOR_ID_RED;
+	aya->subleds[1].color_index = LED_COLOR_ID_GREEN;
+	aya->subleds[2].color_index = LED_COLOR_ID_BLUE;
+	aya->mcled.subled_info = aya->subleds;
+	aya->mcled.num_colors = 3;
+
+	cdev->name = devm_kasprintf(&aya->hdev->dev, GFP_KERNEL,
+				    "%s:rgb:joystick_rings",
+				    dev_name(&aya->hdev->dev));
+	if (!cdev->name)
+		return -ENOMEM;
+	cdev->brightness = 0;
+	cdev->max_brightness = 255;
+	cdev->brightness_set_blocking = aya3_led_set;
+
+	return devm_led_classdev_multicolor_register(&aya->hdev->dev,
+						     &aya->mcled);
+}
+
+static const struct dmi_system_id aya3_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
+		},
+	},
+	{}
+};
+
+static int aya3_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct aya3 *aya;
+	int ret;
+
+	/* The VID/PID is a generic SigmaMicro ID; bind on AYANEO 3 only */
+	if (!dmi_check_system(aya3_dmi_table))
+		return -ENODEV;
+
+	if (!hid_is_usb(hdev))
+		return -ENODEV;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	/* Bind only the vendor interface, not the gamepad/keyboard ones */
+	if (hdev->collection->usage != (HID_UP_MSVENDOR | 0x0001))
+		return -ENODEV;
+
+	aya = devm_kzalloc(&hdev->dev, sizeof(*aya), GFP_KERNEL);
+	if (!aya)
+		return -ENOMEM;
+
+	aya->xfer = devm_kzalloc(&hdev->dev, AYA3_REPORT_SIZE, GFP_KERNEL);
+	if (!aya->xfer)
+		return -ENOMEM;
+
+	aya->hdev = hdev;
+	aya->vibration = AYA3_VIBRATION_DEFAULT;
+	init_completion(&aya->resp_done);
+	ret = devm_mutex_init(&hdev->dev, &aya->lock);
+	if (ret)
+		return ret;
+	hid_set_drvdata(hdev, aya);
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_open(hdev);
+	if (ret)
+		goto err_stop;
+
+	/* Input reports are not delivered during probe by default */
+	hid_device_io_start(hdev);
+
+	scoped_guard(mutex, &aya->lock)
+		ret = aya3_check(aya, NULL);
+	if (ret)
+		hid_warn(hdev, "controller did not answer status check: %d\n",
+			 ret);
+
+	ret = aya3_register_led(aya);
+	if (ret)
+		goto err_close;
+
+	return 0;
+
+err_close:
+	hid_hw_close(hdev);
+err_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void aya3_remove(struct hid_device *hdev)
+{
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id aya3_devices[] = {
+	{ HID_USB_DEVICE(0x1c4f, 0x0002) },
+	{}
+};
+MODULE_DEVICE_TABLE(hid, aya3_devices);
+
+static struct hid_driver aya3_driver = {
+	.name = "hid-ayaneo",
+	.id_table = aya3_devices,
+	.probe = aya3_probe,
+	.remove = aya3_remove,
+	.raw_event = aya3_raw_event,
+	.driver = {
+		.dev_groups = aya3_groups,
+	},
+};
+module_hid_driver(aya3_driver);
+
+MODULE_AUTHOR("Matías Martínez <hello@matias.me>");
+MODULE_DESCRIPTION("AYANEO 3 detachable controller driver");
+MODULE_LICENSE("GPL");

base-commit: a8fcb3dbf9024da44f1614c42ea16001f4b860b0
-- 
2.54.0 (Apple Git-157)

