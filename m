From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] don't invert mightymouse hwheel
Date: Thu, 12 Apr 2007 00:23:52 +0200
Message-ID: <1176330232.27324.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
Cc: "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Jiri Kosina <jkosina@suse.cz>, Bart Massey <bart@cs.pdx.edu>
List-Id: linux-input@vger.kernel.org

Commit a82e49b8aeb9f8dafdf6cf2e617c8b95bf056257 said:

    Further, the quirks for the Apple Mighty Mouse are not quite right: the
    horizontal scrolling needs its axis reversed, and the left and center
    buttons are transposed.

This is not true. With this X configuration:

    Section "InputDevice"
        Identifier  "EvDev"
        Driver      "evdev"
        Option      "SendCoreEvents"    "true"
        Option      "evBits"            "+1-2"
        Option      "keyBits"           "~272-287"
        Option      "relBits"           "~0-2 ~6 ~8"
        Option      "Pass"              "3"
    EndSection

I can scroll up in a window by moving my finger up, and scroll left in a
window by moving my finger right. That makes no sense, this patch therefore
removes the INVERT_HWHEEL quirk from the USB mightymouse.

I didn't change the bluetooth mightymouse, maybe it has this quirk after
all. My USB one definitely doesn't. If the bluetooth version doesn't have
that quirk either, we can completely remove the INVERT_HWHEEL quirk.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Bart Massey <bart@cs.pdx.edu>
Cc: Antonio-M. Corbi Bellot <antonio.corbi@ua.es>

---
 drivers/usb/input/hid-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- wireless-dev.orig/drivers/usb/input/hid-core.c	2007-04-12 00:09:17.754507072 +0200
+++ wireless-dev/drivers/usb/input/hid-core.c	2007-04-12 00:09:25.334507072 +0200
@@ -898,7 +898,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE, HID_QUIRK_MIGHTYMOUSE | HID_QUIRK_INVERT_HWHEEL },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE, HID_QUIRK_MIGHTYMOUSE },
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK_7 },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK_5 },
 
