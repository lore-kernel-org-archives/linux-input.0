From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [rft]powermate runtime pm
Date: Thu, 3 Jul 2008 13:43:28 -0400
Message-ID: <20080703134107.ZZRA012@mailhub.coreip.homeip.net>
References: <200807031753.16960.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200807031753.16960.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will-ffEBwZeNOFERmelmmXo44Q@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Oliver,

On Thu, Jul 03, 2008 at 05:53:16PM +0200, Oliver Neukum wrote:
> Hi,
> 
> this should add runtime power management to the powermate driver.
> In order to do so the driver had to be changed to provide open & close
> methods. Please test.
> 

I was workinf on adding suspend and resume hooks to input devices to
reset them into sane state automatically. I am wondering if I should
call driver's suspend and resume only for open input devices and
provide mutual exclusion with open and close. DO you think it will
help with reagrd to adding autopm support to USB devices?

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
