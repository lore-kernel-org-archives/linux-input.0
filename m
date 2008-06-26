From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch]fix race between disconnect and open in usbtouch
Date: Thu, 26 Jun 2008 13:41:31 -0400
Message-ID: <20080626133956.ZZRA012@mailhub.coreip.homeip.net>
References: <200806261532.06544.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806261532.06544.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 26, 2008 at 03:32:05PM +0200, Oliver Neukum wrote:
> Hi,
> 
> if you kill the URB before you unregister, open can come in between
> and resubmit the urb. This patch reverses the order.
> 

Hm, we just talked about it - it should be simply removed, not moved
around.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
