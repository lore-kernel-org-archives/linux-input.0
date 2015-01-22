From: Jochen Hein <jochen@jochen.org>
Subject: [PATCH] input: i8042 - add noloop quirk for Medion Akoya E7225
 (MD98857)
Date: Thu, 22 Jan 2015 18:45:45 +0100
Message-ID: <87vbjyk8ty.fsf@echidna.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cc-smtpout1.netcologne.de ([89.1.8.211]:48853 "EHLO
	cc-smtpout1.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbAVRzk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 12:55:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>


input: i8042 - add noloop quirk for Medion Akoya E7225 (MD98857)

Without this the aux port does not get detected, and consequently the touchpad
will not work.

With this patch the touchpad is detected:

$ dmesg | grep -E "(SYN|i8042|serio)"
pnp 00:03: Plug and Play ACPI device, IDs SYN1d22 PNP0f13 (active)
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd00123/0x840300/0x126800, board id: 2863, fw id: 1473085
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6

dmidecode excerpt for this laptop is:

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Medion
        Product Name: Akoya E7225
        Version: 1.0

Cc: stable@vger.kernel.org
Signed-off-by: Jochen Hein <jochen@jochen.org>

---
I own one of these laptops and have tested the patch against 3.18.3.
I've added "CC: stable" to get the quirk backported to distro kernels.
Feel free to remove the CC: if you feel it is not needed.

 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
  1 file changed, 8 insertions(+)

--- linux-3.18.3/drivers/input/serio/i8042-x86ia64io.h.orig	2015-01-16 16:04:08.000000000 +0100
+++ linux-3.18.3/drivers/input/serio/i8042-x86ia64io.h	2015-01-22 16:21:40.668367968 +0100
@@ -152,6 +152,14 @@
 		},
 	},
 	{
+		/* Medion Akoya E7225 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Akoya E7225"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
+		},
+	},
+	{
 		/* Blue FB5601 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "blue"),

-- 
The only problem with troubleshooting is that the trouble shoots back.
