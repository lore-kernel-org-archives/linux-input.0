From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: full usbhid autosuspend
Date: Tue, 22 Apr 2008 02:07:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804220206530.19002@twin.jikos.cz>
References: <200804011603.05998.oliver@neukum.org> <200804041645.40301.oliver@neukum.org>
 <Pine.LNX.4.64.0804041708100.32130@jikos.suse.cz> <200804041708.48296.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804041708.48296.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 4 Apr 2008, Oliver Neukum wrote:

> > OK, so the quite reliable sequence seems to be
> > - let the USB keyboard go to sleep
> > - press CAPS on PS2 keyboard
> > - let the USB keyboard go to sleep again
> > - press 'a' on USB keyboard
> > - let the USB keyboard go to sleep again
> > - press CAPS on PS2 keyboard
> > - let the USB keyboard go to sleep again
> > - press 'a' on the USB keyboard
> > => deadlock.
> Good. I am recompiling with spinlock debug. This should be fixable.

Hi Oliver,

have you succeeded debugging this please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
