From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Subject: [PATCH v3 1/2] USB: quirks: Fix another ELAN touchscreen
Date: Tue, 24 Nov 2015 14:49:07 +0100
Message-ID: <1448372948-8861-2-git-send-email-adrienverge@gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
 <1448372948-8861-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448372948-8861-1-git-send-email-adrienverge@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Like other buggy models that had their fixes [1], the touchscreen with
id 04f3:21b8 from ELAN Microelectronics needs the device-qualifier
quirk. Otherwise, it fails to respond, blocks the boot for a random
amount of time and pollutes dmesg with:

[ 2887.373196] usb 1-5: new full-speed USB device number 41 using xhci_=
hcd
[ 2889.502000] usb 1-5: unable to read config index 0 descriptor/start:=
 -71
[ 2889.502005] usb 1-5: can't read configurations, error -71
[ 2889.654571] usb 1-5: new full-speed USB device number 42 using xhci_=
hcd
[ 2891.783438] usb 1-5: unable to read config index 0 descriptor/start:=
 -71
[ 2891.783443] usb 1-5: can't read configurations, error -71

[1]: See commits c68929f, 876af5d, d749947, a32c99e and dc703ec.

Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
Signed-off-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f5a3819..fcd6ac0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -125,6 +125,9 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
 	{ USB_DEVICE(0x04f3, 0x016f), .driver_info =3D
 			USB_QUIRK_DEVICE_QUALIFIER },
=20
+	{ USB_DEVICE(0x04f3, 0x21b8), .driver_info =3D
+			USB_QUIRK_DEVICE_QUALIFIER },
+
 	/* Roland SC-8820 */
 	{ USB_DEVICE(0x0582, 0x0007), .driver_info =3D USB_QUIRK_RESET_RESUME=
 },
=20
--=20
2.4.3
