From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: need to get the interface cycled with autopm_get/_put() to let a
 device sleep
Date: Wed, 15 Apr 2015 16:33:48 +0200
Message-ID: <1429108428.31093.12.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

I found a problem with the close() function of usbhid.
It fails to properly suspend device that don't support
remote wake-up. The power core does not retry an autosuspend
that failed due to a lack of support for remote wake-up.

So there needs to be a _put() if the need for remote wake-up
is rescinded. The current state of affairs leads to joysticks
never going to sleep again after use.

But I am not happy with the simple solution. It needlessly
wakes up suspended devices. So, I tried using
usb_autopm_get_interface_no_resume(). To my considerable
surprise that didn't work. I cannot understand why.

So what is to be done?

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
