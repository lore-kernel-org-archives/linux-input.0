From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH RESEND] USB HID: Protect against disconnect/NULL-dereference
 race
Date: Fri, 13 Aug 2010 11:21:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008131121370.2702@pobox.suse.cz>
References: <m3y6ee62gp.fsf@pullcord.laptop.org> <m3lj8b8m6b.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m3lj8b8m6b.fsf-0VGQAjvlmrQzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 12 Aug 2010, Chris Ball wrote:

> One of our users reports consistently hitting a NULL dereference that
> resolves to the "hid_to_usb_dev(hid);" call in hiddev_ioctl(), when
> disconnecting a Lego WeDo USB HID device from an OLPC XO running
> Scratch software.  There's a FIXME comment and a guard against the
> dereference, but that happens farther down the function than the
> initial dereference does.
> 
> This patch moves the call to be below the guard, and the user reports
> that it fixes the problem for him.  OLPC bug report:
> http://dev.laptop.org/ticket/10174
> 
> Signed-off-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

Applied, thanks Chris.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
