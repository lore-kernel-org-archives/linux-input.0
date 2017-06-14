From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH Resent 1/3] HID: core: move the dynamic quirks handling in core
Date: Wed, 14 Jun 2017 14:44:59 +0200
Message-ID: <20170614124459.29562-1-benjamin.tissoires@redhat.com>
References: <CAHp75VfGV2n8wXgL9i+45Sw7JmmKgiwpARi=+V5qeRZuzc+BtQ@mail.gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfGV2n8wXgL9i+45Sw7JmmKgiwpARi=+V5qeRZuzc+BtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

usbhid has a list of dynamic quirks in addition to a list of static quirks.
There is not much USB specific in that, so move this part of the module
in core so we can have one central place for quirks.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

Resent with -M1 -C1 in format-patch to detect the rename.

I need to be that aggressive because the list hid_blacklist in
drivers/hid/usbhid/hid-quirks.c was neither alphabetically sorted, nor sorted
by quirks as mentioned at hte beginning of the file.

 drivers/hid/Makefile                  |   2 +-
 drivers/hid/hid-core.c                |   7 +-
 drivers/hid/{usbhid => }/hid-quirks.c | 481 +++++++++++++++++-----------------
 drivers/hid/usbhid/Makefile           |   2 +-
 drivers/hid/usbhid/hid-core.c         |  10 +-
 include/linux/hid.h                   |   8 +-
 6 files changed, 255 insertions(+), 255 deletions(-)
 rename drivers/hid/{usbhid => }/hid-quirks.c (12%)

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8ceaa6c..6a5dbae 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the HID driver
 #
-hid-y			:= hid-core.o hid-input.o
+hid-y			:= hid-core.o hid-input.o hid-quirks.o
 hid-$(CONFIG_DEBUG_FS)		+= hid-debug.o
 
 obj-$(CONFIG_HID)		+= hid.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 984ef2f..953dc41 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1597,8 +1597,8 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
 
-static bool hid_match_one_id(struct hid_device *hdev,
-		const struct hid_device_id *id)
+bool hid_match_one_id(const struct hid_device *hdev,
+		      const struct hid_device_id *id)
 {
 	return (id->bus == HID_BUS_ANY || id->bus == hdev->bus) &&
 		(id->group == HID_GROUP_ANY || id->group == hdev->group) &&
@@ -2919,6 +2919,8 @@ int hid_add_device(struct hid_device *hdev)
 	if (WARN_ON(hdev->status & HID_STAT_ADDED))
 		return -EBUSY;
 
+	hdev->quirks = hid_lookup_quirk(hdev);
+
 	/* we need to kill them here, otherwise they will stay allocated to
 	 * wait for coming driver */
 	if (hid_ignore(hdev))
@@ -3117,6 +3119,7 @@ static void __exit hid_exit(void)
 	hid_debug_exit();
 	hidraw_exit();
 	bus_unregister(&hid_bus_type);
+	hid_quirks_exit(HID_BUS_ANY);
 }
 
 module_init(hid_init);
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/hid-quirks.c
similarity index 12%
rename from drivers/hid/usbhid/hid-quirks.c
rename to drivers/hid/hid-quirks.c
index a88e7c7..06f94ec 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -18,244 +18,235 @@
 #include <linux/hid.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/mutex.h>
 
-#include "../hid-ids.h"
+#include "hid-ids.h"
 
 /*
- * Alphabetically sorted blacklist by quirk type.
+ * Alphabetically sorted by vendor then product.
  */
 
-static const struct hid_blacklist {
-	__u16 idVendor;
-	__u16 idProduct;
-	__u32 quirks;
-} hid_blacklist[] = {
-	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER, HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_NATSU, USB_DEVICE_ID_NATSU_GAMEPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_NEXTWINDOW, USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN, HID_QUIRK_MULTI_INPUT},
-	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
-
-	{ USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016, HID_QUIRK_FULLSPEED_INTERVAL },
-
-	{ USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH_2968, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_GREENASIA, USB_DEVICE_ID_GREENASIA_DUAL_USB_JOYPAD, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
-	{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },
-
-	{ USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_AKAI_09E8, USB_DEVICE_ID_AKAI_09E8_MIDIMIX, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS682, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS692, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS1758, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FIGHTERSTICK, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_COMBATSTICK, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_ECLIPSE_YOKE, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_THROTTLE, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70R, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_M65RGB, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K95RGB, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70RGB, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K65RGB, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70RGB_RAPIDFIRE, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K65RGB_RAPIDFIRE, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_FUTABA, USB_DEVICE_ID_LED_DISPLAY, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C01A, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22, HID_QUIRK_ALWAYS_POLL },
-	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS9200_TOUCH, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS_TS, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_1, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8882, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8883, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWA60, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
-
-	{ USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
-
-	{ USB_VENDOR_ID_PI_ENGINEERING, USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL, HID_QUIRK_HIDINPUT_FORCE },
-
-	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS1, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_HD, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI, HID_QUIRK_MULTI_INPUT },
-
-	{ 0, 0 }
+struct hid_device_id hid_quirks[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016), HID_QUIRK_FULLSPEED_INTERVAL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI_09E8, USB_DEVICE_ID_AKAI_09E8_MIDIMIX), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS1758), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS682), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS692), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_COMBATSTICK), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FIGHTERSTICK), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_ECLIPSE_YOKE), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_THROTTLE), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K65RGB), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K65RGB_RAPIDFIRE), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70RGB), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70RGB_RAPIDFIRE), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70R), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K95RGB), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_M65RGB), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER), HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH_2968), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTABA, USB_DEVICE_ID_LED_DISPLAY), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, USB_DEVICE_ID_GREENASIA_DUAL_USB_JOYPAD), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C01A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NATSU, USB_DEVICE_ID_NATSU_GAMEPAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NEXTWINDOW, USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN), HID_QUIRK_MULTI_INPUT},
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK), HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PI_ENGINEERING, USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL), HID_QUIRK_HIDINPUT_FORCE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS9200_TOUCH), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS_TS), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_1), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_HD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS1), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS2), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8882), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8883), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWA60), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS), HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD), HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
+
+	{ 0 }
 };
 
 /* Dynamic HID quirks list - specified at runtime */
 struct quirks_list_struct {
-	struct hid_blacklist hid_bl_item;
+	struct hid_device_id hid_bl_item;
 	struct list_head node;
 };
 
 static LIST_HEAD(dquirks_list);
-static DECLARE_RWSEM(dquirks_rwsem);
+static DEFINE_MUTEX(dquirks_lock);
 
 /* Runtime ("dynamic") quirks manipulation functions */
 
 /**
- * usbhid_exists_dquirk: find any dynamic quirks for a USB HID device
- * @idVendor: the 16-bit USB vendor ID, in native byteorder
- * @idProduct: the 16-bit USB product ID, in native byteorder
+ * hid_exists_dquirk: find any dynamic quirks for a USB HID device
+ * @hdev: the HID device to match
  *
  * Description:
  *         Scans dquirks_list for a matching dynamic quirk and returns
- *         the pointer to the relevant struct hid_blacklist if found.
- *         Must be called with a read lock held on dquirks_rwsem.
+ *         the pointer to the relevant struct hid_device_id if found.
+ *         Must be called with a read lock held on dquirks_lock.
  *
- * Returns: NULL if no quirk found, struct hid_blacklist * if found.
+ * Returns: NULL if no quirk found, struct hid_device_id * if found.
  */
-static struct hid_blacklist *usbhid_exists_dquirk(const u16 idVendor,
-		const u16 idProduct)
+static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
 {
 	struct quirks_list_struct *q;
-	struct hid_blacklist *bl_entry = NULL;
+	struct hid_device_id *bl_entry = NULL;
 
 	list_for_each_entry(q, &dquirks_list, node) {
-		if (q->hid_bl_item.idVendor == idVendor &&
-				q->hid_bl_item.idProduct == idProduct) {
+		if (hid_match_one_id(hdev, &q->hid_bl_item)) {
 			bl_entry = &q->hid_bl_item;
 			break;
 		}
 	}
 
 	if (bl_entry != NULL)
-		dbg_hid("Found dynamic quirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
-				bl_entry->quirks, bl_entry->idVendor,
-				bl_entry->idProduct);
+		dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
+			bl_entry->driver_data, bl_entry->vendor,
+			bl_entry->product);
 
 	return bl_entry;
 }
 
 
 /**
- * usbhid_modify_dquirk: add/replace a HID quirk
- * @idVendor: the 16-bit USB vendor ID, in native byteorder
- * @idProduct: the 16-bit USB product ID, in native byteorder
- * @quirks: the u32 quirks value to add/replace
+ * hid_modify_dquirk: add/replace a HID quirk
+ * @id: the HID device to match
+ * @quirks: the unsigned long quirks value to add/replace
  *
  * Description:
- *         If an dynamic quirk exists in memory for this (idVendor,
- *         idProduct) pair, replace its quirks value with what was
- *         provided.  Otherwise, add the quirk to the dynamic quirks list.
+ *         If an dynamic quirk exists in memory for this device, replace its
+ *         quirks value with what was provided.  Otherwise, add the quirk
+ *         to the dynamic quirks list.
  *
  * Returns: 0 OK, -error on failure.
  */
-static int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct,
-				const u32 quirks)
+static int hid_modify_dquirk(const struct hid_device_id *id,
+			     const unsigned long quirks)
 {
+	struct hid_device *hdev;
 	struct quirks_list_struct *q_new, *q;
 	int list_edited = 0;
+	int ret = 0;
 
-	if (!idVendor) {
-		dbg_hid("Cannot add a quirk with idVendor = 0\n");
-		return -EINVAL;
-	}
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
 
 	q_new = kmalloc(sizeof(struct quirks_list_struct), GFP_KERNEL);
-	if (!q_new)
-		return -ENOMEM;
+	if (!q_new) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	q_new->hid_bl_item.idVendor = idVendor;
-	q_new->hid_bl_item.idProduct = idProduct;
-	q_new->hid_bl_item.quirks = quirks;
+	hdev->bus = q_new->hid_bl_item.bus = id->bus;
+	hdev->group = q_new->hid_bl_item.group = id->group;
+	hdev->vendor = q_new->hid_bl_item.vendor = id->vendor;
+	hdev->product = q_new->hid_bl_item.product = id->product;
+	q_new->hid_bl_item.driver_data = quirks;
 
-	down_write(&dquirks_rwsem);
+	mutex_lock(&dquirks_lock);
 
 	list_for_each_entry(q, &dquirks_list, node) {
 
-		if (q->hid_bl_item.idVendor == idVendor &&
-				q->hid_bl_item.idProduct == idProduct) {
+		if (hid_match_one_id(hdev, &q->hid_bl_item)) {
 
 			list_replace(&q->node, &q_new->node);
 			kfree(q);
@@ -269,48 +260,59 @@ static int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct,
 	if (!list_edited)
 		list_add_tail(&q_new->node, &dquirks_list);
 
-	up_write(&dquirks_rwsem);
+	mutex_unlock(&dquirks_lock);
 
-	return 0;
+ out:
+	kfree(hdev);
+	return ret;
 }
 
 /**
- * usbhid_remove_all_dquirks: remove all runtime HID quirks from memory
+ * hid_remove_all_dquirks: remove all runtime HID quirks from memory
+ * @bus: bus to match against. Use HID_BUS_ANY if all need to be removed.
  *
  * Description:
  *         Free all memory associated with dynamic quirks - called before
  *         module unload.
  *
  */
-static void usbhid_remove_all_dquirks(void)
+static void hid_remove_all_dquirks(__u16 bus)
 {
 	struct quirks_list_struct *q, *temp;
 
-	down_write(&dquirks_rwsem);
+	mutex_lock(&dquirks_lock);
 	list_for_each_entry_safe(q, temp, &dquirks_list, node) {
-		list_del(&q->node);
-		kfree(q);
+		if (bus == HID_BUS_ANY || bus == q->hid_bl_item.bus) {
+			list_del(&q->node);
+			kfree(q);
+		}
 	}
-	up_write(&dquirks_rwsem);
+	mutex_unlock(&dquirks_lock);
 
 }
 
 /**
- * usbhid_quirks_init: apply USB HID quirks specified at module load time
+ * hid_quirks_init: apply USB HID quirks specified at module load time
  */
-int usbhid_quirks_init(char **quirks_param)
+int hid_quirks_init(char **quirks_param, __u16 bus)
 {
-	u16 idVendor, idProduct;
-	u32 quirks;
+	struct hid_device_id id = { 0 };
 	int n = 0, m;
+	unsigned short int vendor, product;
+	u32 quirks;
+
+	id.bus = bus;
 
 	for (; n < MAX_USBHID_BOOT_QUIRKS && quirks_param[n]; n++) {
 
 		m = sscanf(quirks_param[n], "0x%hx:0x%hx:0x%x",
-				&idVendor, &idProduct, &quirks);
+				&vendor, &product, &quirks);
+
+		id.vendor = (__u16)vendor;
+		id.product = (__u16)product;
 
 		if (m != 3 ||
-		    usbhid_modify_dquirk(idVendor, idProduct, quirks) != 0) {
+		    hid_modify_dquirk(&id, quirks) != 0) {
 			pr_warn("Could not parse HID quirk module param %s\n",
 				quirks_param[n]);
 		}
@@ -320,80 +322,75 @@ int usbhid_quirks_init(char **quirks_param)
 }
 
 /**
- * usbhid_quirks_exit: release memory associated with dynamic_quirks
+ * hid_quirks_exit: release memory associated with dynamic_quirks
+ * @bus: a bus to match against
  *
  * Description:
- *     Release all memory associated with dynamic quirks.  Called upon
- *     module unload.
+ *     Release all memory associated with dynamic quirks for a given bus.
+ *     Called upon module unload.
+ *     Use HID_BUS_ANY to remove all dynamic quirks.
  *
  * Returns: nothing
  */
-void usbhid_quirks_exit(void)
+void hid_quirks_exit(__u16 bus)
 {
-	usbhid_remove_all_dquirks();
+	hid_remove_all_dquirks(bus);
 }
 
 /**
- * usbhid_exists_squirk: return any static quirks for a USB HID device
- * @idVendor: the 16-bit USB vendor ID, in native byteorder
- * @idProduct: the 16-bit USB product ID, in native byteorder
+ * hid_exists_squirk: return any static quirks for a USB HID device
+ * @hdev: the HID device to match
  *
  * Description:
- *     Given a USB vendor ID and product ID, return a pointer to
- *     the hid_blacklist entry associated with that device.
+ *     Given a HID device, return a pointer to the quirked hid_device_id entry
+ *     associated with that device.
  *
  * Returns: pointer if quirk found, or NULL if no quirks found.
  */
-static const struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor,
-		const u16 idProduct)
+static const struct hid_device_id *hid_exists_squirk(const struct hid_device *hdev)
 {
-	const struct hid_blacklist *bl_entry = NULL;
+	const struct hid_device_id *bl_entry = NULL;
 	int n = 0;
 
-	for (; hid_blacklist[n].idVendor; n++)
-		if (hid_blacklist[n].idVendor == idVendor &&
-			(hid_blacklist[n].idProduct == (__u16) HID_ANY_ID ||
-				hid_blacklist[n].idProduct == idProduct))
-			bl_entry = &hid_blacklist[n];
+	for (; hid_quirks[n].bus; n++)
+		if (hid_match_one_id(hdev, &hid_quirks[n]))
+			bl_entry = &hid_quirks[n];
 
 	if (bl_entry != NULL)
-		dbg_hid("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
-				bl_entry->quirks, bl_entry->idVendor,
-				bl_entry->idProduct);
+		dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
+				bl_entry->driver_data, bl_entry->vendor,
+				bl_entry->product);
 	return bl_entry;
 }
 
 /**
- * usbhid_lookup_quirk: return any quirks associated with a USB HID device
- * @idVendor: the 16-bit USB vendor ID, in native byteorder
- * @idProduct: the 16-bit USB product ID, in native byteorder
+ * hid_lookup_quirk: return any quirks associated with a HID device
+ * @hdev: the HID device to look for
  *
  * Description:
- *     Given a USB vendor ID and product ID, return any quirks associated
- *     with that device.
+ *     Given a HID device, return any quirks associated with that device.
  *
- * Returns: a u32 quirks value.
+ * Returns: an unsigned long quirks value.
  */
-u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct)
+unsigned long hid_lookup_quirk(const struct hid_device *hdev)
 {
-	u32 quirks = 0;
-	const struct hid_blacklist *bl_entry = NULL;
+	unsigned long quirks = 0;
+	const struct hid_device_id *quirk_entry = NULL;
 
 	/* NCR devices must not be queried for reports */
-	if (idVendor == USB_VENDOR_ID_NCR &&
-			idProduct >= USB_DEVICE_ID_NCR_FIRST &&
-			idProduct <= USB_DEVICE_ID_NCR_LAST)
-			return HID_QUIRK_NO_INIT_REPORTS;
-
-	down_read(&dquirks_rwsem);
-	bl_entry = usbhid_exists_dquirk(idVendor, idProduct);
-	if (!bl_entry)
-		bl_entry = usbhid_exists_squirk(idVendor, idProduct);
-	if (bl_entry)
-		quirks = bl_entry->quirks;
-	up_read(&dquirks_rwsem);
+	if (hdev->vendor == USB_VENDOR_ID_NCR &&
+	    hdev->product >= USB_DEVICE_ID_NCR_FIRST &&
+	    hdev->product <= USB_DEVICE_ID_NCR_LAST)
+		return HID_QUIRK_NO_INIT_REPORTS;
+
+	mutex_lock(&dquirks_lock);
+	quirk_entry = hid_exists_dquirk(hdev);
+	if (!quirk_entry)
+		quirk_entry = hid_exists_squirk(hdev);
+	if (quirk_entry)
+		quirks = quirk_entry->driver_data;
+	mutex_unlock(&dquirks_lock);
 
 	return quirks;
 }
-
-EXPORT_SYMBOL_GPL(usbhid_lookup_quirk);
+EXPORT_SYMBOL_GPL(hid_lookup_quirk);
diff --git a/drivers/hid/usbhid/Makefile b/drivers/hid/usbhid/Makefile
index 890f291..e61b6e5 100644
--- a/drivers/hid/usbhid/Makefile
+++ b/drivers/hid/usbhid/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the USB input drivers
 #
 
-usbhid-y	:= hid-core.o hid-quirks.o
+usbhid-y	:= hid-core.o
 usbhid-$(CONFIG_USB_HIDDEV)	+= hiddev.o
 usbhid-$(CONFIG_HID_PID)	+= hid-pidff.o
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 76013eb..2a8acf3 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -972,8 +972,7 @@ static int usbhid_parse(struct hid_device *hid)
 	char *rdesc;
 	int ret, n;
 
-	quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
-			le16_to_cpu(dev->descriptor.idProduct));
+	quirks = hid_lookup_quirk(hid);
 
 	if (quirks & HID_QUIRK_IGNORE)
 		return -ENODEV;
@@ -1314,7 +1313,6 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 	hid->vendor = le16_to_cpu(dev->descriptor.idVendor);
 	hid->product = le16_to_cpu(dev->descriptor.idProduct);
 	hid->name[0] = 0;
-	hid->quirks = usbhid_lookup_quirk(hid->vendor, hid->product);
 	if (intf->cur_altsetting->desc.bInterfaceProtocol ==
 			USB_INTERFACE_PROTOCOL_MOUSE)
 		hid->type = HID_TYPE_USBMOUSE;
@@ -1626,7 +1624,7 @@ static int __init hid_init(void)
 {
 	int retval = -ENOMEM;
 
-	retval = usbhid_quirks_init(quirks_param);
+	retval = hid_quirks_init(quirks_param, BUS_USB);
 	if (retval)
 		goto usbhid_quirks_init_fail;
 	retval = usb_register(&hid_driver);
@@ -1636,7 +1634,7 @@ static int __init hid_init(void)
 
 	return 0;
 usb_register_fail:
-	usbhid_quirks_exit();
+	hid_quirks_exit(BUS_USB);
 usbhid_quirks_init_fail:
 	return retval;
 }
@@ -1644,7 +1642,7 @@ static int __init hid_init(void)
 static void __exit hid_exit(void)
 {
 	usb_deregister(&hid_driver);
-	usbhid_quirks_exit();
+	hid_quirks_exit(BUS_USB);
 }
 
 module_init(hid_init);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5006f9b..9296237 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -838,6 +838,8 @@ int hid_open_report(struct hid_device *device);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
 void hid_disconnect(struct hid_device *hid);
+bool hid_match_one_id(const struct hid_device *hdev,
+		      const struct hid_device_id *id);
 const struct hid_device_id *hid_match_id(struct hid_device *hdev,
 					 const struct hid_device_id *id);
 s32 hid_snto32(__u32 value, unsigned n);
@@ -1076,9 +1078,9 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 		int interrupt);
 
 /* HID quirks API */
-u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);
-int usbhid_quirks_init(char **quirks_param);
-void usbhid_quirks_exit(void);
+unsigned long hid_lookup_quirk(const struct hid_device *hdev);
+int hid_quirks_init(char **quirks_param, __u16 bus);
+void hid_quirks_exit(__u16 bus);
 
 #ifdef CONFIG_HID_PID
 int hid_pidff_init(struct hid_device *hid);
-- 
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
