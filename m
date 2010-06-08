From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] usbtouchscreen: Implement runtime power management
Date: Tue, 8 Jun 2010 16:12:03 +0200
Message-ID: <201006081612.03253.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1006071622260.1332-100000@iolanthe.rowland.org> <201006072247.33068.oliver@neukum.org> <20100608083751.GA27348@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100608083751.GA27348-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Dienstag, 8. Juni 2010 10:37:51 schrieb Dmitry Torokhov:
> On Mon, Jun 07, 2010 at 10:47:33PM +0200, Oliver Neukum wrote:
>
> > Then I'd say the other drivers are wrong. We cannot leak USB specific
> > codes. Maybe we should pass -ENOMEM and -ENODEV, but the others
> > really don't mean anything as generic codes.
> > 
> 
> No, I'd say that usb_autopm_get_interface() is wrong - since it is
> supposed to be used by drivers who are not concerned about USB-specific
> codes these functions should not leak them to the callers but rather
> provide ones suitable for reporting upstream.

How about a wrapper like this?

	Regards
		Oliver

>From f4c742fa1ec8a368bbaeb129fb502aecb9cf9208 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Tue, 8 Jun 2010 16:02:51 +0200
Subject: [PATCH] usb: add helper for error code conversion

USB uses error codes in a particular manner. Such codes must
not be passed to user space as that violates POSIX. This helper
maps the error codes to error codes that may be passed to
user space

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 drivers/usb/core/usb.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index cd88220..b070549 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -124,6 +124,18 @@ static inline int is_usb_device_driver(struct device_driver *drv)
 			for_devices;
 }
 
+/* translate USB error codes to codes user space understands */
+static inline int usb_translate_errors(int error_code)
+{
+	switch (error_code) {
+	case 0:
+	case -ENOMEM:
+	case -ENODEV:
+		return error_code;
+	default:
+		return -EIO;
+	}
+}
 
 /* for labeling diagnostics */
 extern const char *usbcore_name;
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
