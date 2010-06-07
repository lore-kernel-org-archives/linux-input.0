From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: [0000/0003]full power management for usb touchscreens
Date: Mon, 7 Jun 2010 15:13:29 +0200
Message-ID: <201006071513.29478.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

this patch series implements:

- full support for suspend/resume/reset_resume
- runtime power management

It does so by adding normal methods for suspend/resume,
splitting device intialization into a part that needs to be repeated
after reset_resume() and a part that does not.
Runtime power management is possible while the device is
active if the device supports remote wakeup, otherwise a fallback
to a method based on open/close is implemented.

I lack the hardware. Therefore I need testers.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
