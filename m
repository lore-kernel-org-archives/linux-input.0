From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/1] hid: Logitech G13 driver 0.0.2
Date: Tue, 22 Dec 2009 16:03:07 -0800
Message-ID: <20091222160307.0018bda9.akpm@linux-foundation.org>
References: <200912220022.nBM0MMS8005004@imap1.linux-foundation.org>
	<alpine.LNX.2.00.0912230056120.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45053 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755567AbZLWAD7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 19:03:59 -0500
In-Reply-To: <alpine.LNX.2.00.0912230056120.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, rvinyard@cs.nmsu.edu, dtor@mail.ru, oliver@neukum.org

On Wed, 23 Dec 2009 00:57:43 +0100 (CET)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Mon, 21 Dec 2009, akpm@linux-foundation.org wrote:
> 
> > From: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
> > 
> > This is a driver for the Logitech G13 gamepad, and contains three key
> > parts.  In the USB reports the device identifies itself as a HID, and as a
> > result this driver is under the HID framework.
> > 
> > There are two primary sub-components to this driver; an input device and a
> > framebuffer device.
> > 
> > Although identified as a HID, the device does not support standard HID
> > input messages.  As a result, a sub-input device is allocated and
> > registered separately in g13_probe().  The raw events are monitored and
> > key presses/joystick activity is reported through the input device after
> > referencing an indexed keymap.
> > 
> > Additionally, this device contains a 160x43 monochrome LCD display.  A
> > registered framebuffer device manages this display.  The design of this
> > portion of the driver was based on the design of the hecubafb driver with
> > deferred framebuffer I/O since there is no real memory to map.
> > 
> > Signed-off-by: Rick L. Vinyard, Jr <rvinyard@cs.nmsu.edu>
> > Cc: Oliver Neukum <oliver@neukum.org>
> > Cc: Dmitry Torokhov <dtor@mail.ru>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> The driver doesn't build for me. Seems like missing some 
> framebuffer-related include at a first glance.
> 
> Rick, care to fix that up please?
> 
> drivers/hid/hid-g13.c:121: error: field ___fb_defio___ has incomplete type
> drivers/hid/hid-g13.c:1207: error: variable ___g13_fb_defio___ has initializerbut incomplete type
> drivers/hid/hid-g13.c:1208: error: unknown field ___delay___ specified ininitializer
> drivers/hid/hid-g13.c:1208: warning: excess elements in struct initializer
> drivers/hid/hid-g13.c:1208: warning: (near initialization for ___g13_fb_defio___)
> drivers/hid/hid-g13.c:1209: error: unknown field ___deferred_io___ specified in initializer
> drivers/hid/hid-g13.c:1209: warning: excess elements in struct initializer
> drivers/hid/hid-g13.c:1209: warning: (near initialization for ___g13_fb_defio___)
> drivers/hid/hid-g13.c: In function ___g13_probe___:drivers/hid/hid-g13.c:1351: error: ___struct fb_info___ has no member named ___fbdefio___
> 

Missing CONFIG_FB_DEFERRED_IO, I assume?

--- a/drivers/hid/Kconfig~hid-logitech-g13-driver-002-fix
+++ a/drivers/hid/Kconfig
@@ -187,6 +187,7 @@ config LOGITECH_G13
 	tristate "Logitech G13 gameboard support"
 	depends on HID_LOGITECH
 	depends on FB
+	depends on FB_DEFERRED_IO
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
_

