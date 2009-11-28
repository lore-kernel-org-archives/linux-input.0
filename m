From: Guido Dorssers <bugzilla.kernel.org-Dy4KJ/v5nlEVgfBnK23ub6xOck334EZe@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard) stopped functioning in kernels >= 2.6.28
Date: Sat, 28 Nov 2009 22:51:28 +0100
Message-ID: <200911282251.28780.bugzilla.kernel.org@starbase12.cjb.net>
References: <bug-13411-10286@http.bugzilla.kernel.org/> <20090601202509.87f57ef9.akpm@linux-foundation.org> <alpine.LRH.2.00.0906021148140.29471@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LRH.2.00.0906021148140.29471-1ReQVI26iDCaZKY3DrU6dA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugzilla.kernel.org-Dy4KJ/v5nlEVgfBnK23ub6xOck334EZe@public.gmane.org, Remi Cattiau <remi-O/wO+J8fF4JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Op dinsdag 2 juni 2009 11:55:51 schreef Jiri Kosina:
> This is almost certainly because of this commit:
> 
> 	commit d1d3a5f6eaee337d793ab9ac28e696f0262c3c8a
> 	Author: Remi Cattiau <remi-O/wO+J8fF4JBDgjK7y7TUQ@public.gmane.org>
> 	Date:   Tue Sep 9 01:39:33 2008 +0200
> 
> 	    HID: ignore iBuddy devices
> 
> 	    iBuddy devices claim to be HID devices, but they are not.
> 	    Add them to the blacklist.
> 
> 	    Signed-off-by: Remi Cattiau <remi-O/wO+J8fF4JBDgjK7y7TUQ@public.gmane.org>
> 	    Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
> 
> The problem apparently [1] is, that the vendor has been super-creative and
> assigned the same combination of idVendor/idProduct to completely
> different devices. Oh well.
> 
> Remi, could you please check your device against the lsusb data provided
> in bugzilla to check whether there is any possibility to distinguish these
> devices, so that we could put some ugly check in place probably?
> 
> Thanks.
> 
> [1] http://lkml.org/lkml/2009/2/10/434
> 

Hi all,
 
A belated thanks for having pointed me into the right direction to get my 
barcodescanner operational. However, as a thought since the bug is still 
present, why not solve it with something as simple as making the blacklisting 
user-configurable instead of blacklisting valid HID devices on purpose?

As an example of what I mean:


diff -urNb drivers/hid/hid-core.c drivers/hid/hid-core.c
--- drivers/hid/hid-core.c      2009-10-17 22:22:12.589447000 +0200
+++ drivers/hid/hid-core.c      2009-10-17 23:01:38.130911398 +0200
@@ -1627,7 +1627,9 @@
        { HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, 
USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD3) },
        { HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, 
USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD4) },
        { HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, 
USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD5) },
+#if defined(CONFIG_HID_BLACKLIST_TENX_IBUDDY)
        { HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY1) },
        { HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY2) },
+#endif
        { HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LABPRO) 
},
        { HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_GOTEMP) 
},
diff -urNb drivers/hid/Kconfig drivers/hid/Kconfig
--- drivers/hid/Kconfig 2009-09-10 00:13:59.000000000 +0200
+++ drivers/hid/Kconfig 2009-10-17 23:04:23.538908607 +0200
@@ -31,6 +31,24 @@

          If unsure, say Y.

+config HID_BLACKLIST_TENX_IBUDDY
+       bool "Blacklist i-Buddy devices"
+       depends on HID
+       default n
+       ---help---
+       Barcode scanners using idVendor 1130 and idProduct 0001 were 
blacklisted
+       at the HID core level per September 9, 01:39:33, 2008. This because
+       i-Buddy devices claim to be HID devices, while not being so.
+       Unfortunately, the vendor has been super-creative and assigned the 
same
+       combination of idVendor/idProduct to completely different devices. 
Therefore,
+       blacklisting the i-Buddy as a HID device also blacklists several 
brands of
+       barcode scanners. Since blacklisting the i-Buddy by default will mean
+       blacklisting valid HID devices as well, it is now a configurable 
option.
+
+       If unsure, say N.
+       Unless of course you own an i-Buddy, say Y.
+
+
 config HID_DEBUG
        bool "HID debugging support"
        default y


Just my two cents for getting a working solution. :)

Tnx,
Regards,

Guido

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
