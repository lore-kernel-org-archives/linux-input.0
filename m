From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH RESENT] Input: elan_i2c - enable ELAN0600 acpi panels
Date: Fri, 17 Jul 2015 14:49:39 -0400
Message-ID: <1437158979-12381-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbbGQStm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 14:49:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Duson Lin <dusonlin@emc.com.tw>
Cc: Alessio Treglia <alessio@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

ELAN0600 seems to work just fine in mouse emulation mode through i2c-hid,
but to have full raw touch support we need to register it in elan_i2c.ko

Reported-and-tested-by: Alessio Treglia <alessio@debian.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

well, last discussion ended up that the patch was the right solution, so
I am resending it now to get Jiri's ACK so Dmitry will be able to take it.

Just for the sake of it, I double checked the Elan 0x0401 (a i2c-hid device
which might be working with elan_i2c with some tweaks), which I have some
debug logs, and I don't think we will be able to communicate and enable
the raw reporting through HID. So sadly, yes, we need to blacklist in HID 
and enable in elan_i2c.

Cheers,
Benjamin

 drivers/hid/hid-core.c              | 1 +
 drivers/input/mouse/elan_i2c_core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 157c627..279898c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2267,6 +2267,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 62641f2..c285ff3 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1167,6 +1167,7 @@ MODULE_DEVICE_TABLE(i2c, elan_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
+	{ "ELAN0600", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
-- 
2.4.3

