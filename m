From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: USBHID: Fix race between disconnect and hiddev_ioctl
Date: Sat, 4 Dec 2010 12:37:50 -0800
Message-ID: <20101204203750.GA7326@core.coreip.homeip.net>
References: <20101203172746.GA31045@mvista.com>
 <20101203231611.GB22969@core.coreip.homeip.net>
 <201012042122.23852.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201012042122.23852.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Valentine Barshak <vbarshak-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Dec 04, 2010 at 09:22:23PM +0100, Oliver Neukum wrote:
> Am Samstag, 4. Dezember 2010, 00:16:12 schrieb Dmitry Torokhov:
> > > Since disconnect can happen at any time, we can't initialize
> > > struct hid_device *hid = hiddev->hid at the beginning of ioctl
> > > and then use it.
> > > 
> > > This change checks hiddev->exist flag while holding
> > > the existancelock and uses hid_device only if it exists.
> > 
> > Why didn't you take the lock and check hiddev->exist at the beginning of
> > ioctl handler instead of pushing it down into individual command
> > handlers? I guess it would slow down HIDIOCGVERSION but I think we could
> > pay this price for code that is more clear ;)
> 
> Strictly speaking you'd change the semantics. Right now you can execute
> the ioctl even if you know you are holding an fd to a disconnected device
> open.

No, I do not think I would. I do not believe that the availability for
HIDIOCGVERSION on disconnected device is spelled out in API/ABI spec. We
only know that ioctl will either succeed or appropriate error code is
returned. The fact that right now HIDIOCGVERSION is available on
disconnected devices is just an implementation detail subject to change.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
