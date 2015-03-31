From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input: elan_i2c - enable ELAN0600 acpi panels
Date: Tue, 31 Mar 2015 17:34:58 -0400
Message-ID: <1427837698-419-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>
Cc: Alessio Treglia <alessio@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

ELAN0600 seems to work just fine in mouse emulation mode through i2c-hid,
but to have full raw touch support we need to register it in elan_i2c.ko

Found on a Lenovo Yoga 3 11".

Reported-and-tested-by: Alessio Treglia <alessio@debian.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

Alessio reported this touchpad on the Lenovo Yoga 3. I must say that I am
rather surprised that we need a cross tree support to enable this panel
and I would expect that the driver would be in the HID subtree, not a direct
input device.

I understand the driver needs to access to the raw I2C commands, but still,
we could have worked around in the HID tree directly.
Not to mention that the DT binding would have required only i2c-hid, not a
custom vendor.

Anyway, Jiri, Dmitry, who wants to take this one?

Cheers,
Benjamin

 drivers/hid/hid-core.c              | 1 +
 drivers/input/mouse/elan_i2c_core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 722a925..33a22f4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2259,6 +2259,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 375d98f..ced9a9c 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1110,6 +1110,7 @@ MODULE_DEVICE_TABLE(i2c, elan_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
+	{ "ELAN0600", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
-- 
2.3.4
