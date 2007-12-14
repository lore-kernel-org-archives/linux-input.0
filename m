From: Nicolas Mailhot <nicolas.mailhot-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: [PATCH] usb/hid: Blacklist the Gretag-Macbeth Huey display
	colorimeter
Date: Fri, 14 Dec 2007 11:04:56 +0100
Message-ID: <1197626696.5281.5.camel@rousalka.dyndns.org>
References: <1197585460.28927.2.camel@rousalka.dyndns.org>
	 <20071214053853.GD7765@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20071214053853.GD7765-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, argyllcms-uGLqWuYN4qMgsBAKwltoeQ@public.gmane.org, Frederic Crozat <fcrozat-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Le jeudi 13 d=C3=A9cembre 2007 =C3=A0 21:38 -0800, Greg KH a =C3=A9crit=
 :=20
> On Thu, Dec 13, 2007 at 11:37:40PM +0100, Nicolas Mailhot wrote:

> > The Gretag-Macbeth Huey display colorimeter claims to be an HID dev=
ice
> > but isn't. As a result the linux HID device will claim it, preventi=
ng
> > FLOSS software like Argyll CMS (http://www.argyllcms.com/) from tal=
king
> > to it,

> > Fr=C3=A9d=C3=A9ric Crozat from Mandriva has such a device and may p=
rovide more
> > info.

> Care to make up a patch as per the Documentation/SubmittingPatches fi=
le
> and send it to this list and the HID driver maintainer?  That way you
> get the proper credit for this change.

The things I do as a public service, I don't even have the damn Huey
myself:(

There seems to be some complains about libusb BTW
(http://www.freelists.org/archives/argyllcms/12-2007/msg00068.html)


Signed-off-by: Nicolas Mailhot <nicolas.mailhot-QFKgK+z4sOrR7s880joybQ@public.gmane.org>

diff -uNr linux-2.6.24-rc5.orig/drivers/hid/usbhid/hid-quirks.c linux-2=
=2E6.24-rc5/drivers/hid/usbhid/hid-quirks.c
--- linux-2.6.24-rc5.orig/drivers/hid/usbhid/hid-quirks.c	2007-12-11 04=
:48:43.000000000 +0100
+++ linux-2.6.24-rc5/drivers/hid/usbhid/hid-quirks.c	2007-12-14 10:41:0=
1.000000000 +0100
@@ -85,6 +85,9 @@
 #define USB_VENDOR_ID_CHIC		0x05fe
 #define USB_DEVICE_ID_CHIC_GAMEPAD	0x0014
=20
+#define USB_VENDOR_ID_GRETAGMACBETH	0x0971
+#define USB_DEVICE_ID_GRETAGMACBETH_HUEY	0x2005
+
 #define USB_VENDOR_ID_CIDC		0x1677
=20
 #define USB_VENDOR_ID_CMEDIA		0x0d8c
@@ -423,6 +426,7 @@
 	{ USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_SUPER_Q2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_GOGOPEN, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_PENPOWER, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GRETAGMACBETH, USB_DEVICE_ID_GRETAGMACBETH_HUEY, HID_=
QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB, HID_QUIRK_IGNORE },

--=20
Nicolas Mailhot

-
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
