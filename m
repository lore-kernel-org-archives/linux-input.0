From: vereecke.jan@skynet.be
Subject: [PATCH] Patch enabling Fn function keys for Laptop Asus G730 (keyboard
 0x1869)
Date: Thu, 14 Jun 2018 22:44:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org
List-Id: linux-input@vger.kernel.org

Attached is a patch enabling (most of) the Fn function keys for the Asus 
ROG Strix GL730 Laptop. The keyboard identifies as a USB device 0x1869.

This patch enables:
     volume/mute keys, ROG key, rew/play/ff,
     monitor and keyboard brightness keys,
     Touchpad toggle key,
     Calculator key

'Touchpad on/off' Key returns keycode 33, which is mapped to the 'p' key.
'Display on/off' returns keycode 253, which is mapped in X11 to NoSymbol
'Airplane Key' returns keycode 255, which is mapped in X11 to NoSymbol

The following keys are not activated yet:
        Microphone Mute key, Fan key, Display Switch key

This patch is against the 4.17-rc7 kernel, for the x86 architecture

diffstat for this patch is:
  hid-asus.c   |    2 ++
  hid-ids.h    |    1 +
  hid-quirks.c |    1 +
  3 files changed, 4 insertions(+)

To apply the patch, in the root of the kernel tree use:
patch -p1 < AsusGL703-Keyboard-Fn-keys.patch

----------------------------------------------------------------------------------------------
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 88a5672..8f4f3c1 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -781,6 +781,8 @@ static const struct hid_device_id asus_devices[] = {
                 USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
                 USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+               USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD4), QUIRK_USE_KBD_BACKLIGHT },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
                 USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
           QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 46f5ecd..93b958f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -187,6 +187,7 @@
  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
+#define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD4 0x1869

  #define USB_VENDOR_ID_ATEN             0x0557
  #define USB_DEVICE_ID_ATEN_UC100KM     0x2004
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 587e268..ebb1353 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -286,6 +286,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3) },
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD4) },
         { HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
         { HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD) },
