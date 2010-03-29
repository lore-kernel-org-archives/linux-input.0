From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] hid: Add NOGET quirk for Quanta usb optical touchscreen
 Pixart to prevent timeout
Date: Mon, 29 Mar 2010 16:20:06 +0200
Message-ID: <20100329162006.3f6e03b1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58901 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab0C2O05 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Mar 2010 10:26:57 -0400
Received: by pwi5 with SMTP id 5so6596464pwi.19
        for <linux-input@vger.kernel.org>; Mon, 29 Mar 2010 07:26:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, Alex Neblett <alexneblett01@yahoo.com>


Add the NOGET quirk for the Quanta optical touchscreen present on MSI AE2220,
Otherwise, the hid-quanta driver timeouts at load time:

drivers/hid/usbhid/hid-core.c: usb_submit_urb(ctrl) failed
quanta-touch 0003:0408:3001.0003: timeout initializing reports
input: PixArt Imaging Inc. Optical Touch Screen as /class/input/input7
quanta-touch 0003:0408:3001.0003: input: USB HID v1.10 Device [PixArt Imaging Inc. Optical Touch Screen] on usb-0000:00:06.0-2/input0

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/hid/usbhid/hid-quirks.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 928943c..e71e005 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -60,6 +60,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUIRK_MULTI_INPUT },
-- 
1.6.5.7

