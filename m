From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] HID: get rid of HID_QUIRK_NO_INIT_REPORTS
Date: Mon, 6 Mar 2017 14:48:37 +0100
Message-ID: <20170306134836.GZ7064@mail.corp.redhat.com>
References: <20170105092144.17120-1-benjamin.tissoires@redhat.com>
 <alpine.LSU.2.20.1703061310380.31814@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1703061310380.31814-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mar 06 2017 or thereabouts, Jiri Kosina wrote:
> On Thu, 5 Jan 2017, Benjamin Tissoires wrote:
> 
> > For case 1, the hiddev documentation provides an ioctl to do the
> > init manually. A solution could be to retrieve the requested report
> > when EVIOCGUSAGE is called, in the same way hidraw does. I would be
> > tempted to not change the behavior and hope that we won't break any
> > userspace tool.
> 
> I'd like to be applying the HID_QUIRK_NO_INIT_REPORTS removal as soon as 
> possible so that it gets exposure in linux-next over the whole development 
> cycle.
> 
> I am however too conservative to ignore the potential hiddev breakage, I 
> am afraid. This has a real potential of breaking systems, and 
> administrators having hard time figuring out of happened; essentialy, this 
> is userspace-visible behavior change (regression) for which we haven't 
> done any long-term depreciation (such as printing a warning "please talk 
> to your hiddev driver vendor" in case the driver seems to assume 
> initialized reports) at least for a few years.
> 
> I think that either doing it at a connect time, or during first 
> EVIOCGUSAGE ioctl() call is a must.

Yes, that's what I was thinking to do too. Also, I think we need to keep
around the list of currently "quirked" devices for hiddev to work
properly. I am still wondering whether we should simply keep the list of
quirked devices in hid-core, but disable the effects, or move the full
list of quirked devices in hiddev.

Initially I thought it was better to remove the quirk from core and move
the list in hiddev, but on the other hand, that means that we will
remove the ability to introduce it from the kernel boot command, so
maybe keeping the list in its current state is better, and only have the
effects in hiddev. Am I clear enough?)

> 
> Otherwise, I'd be super-happy to finally get rid of this giant PITA.
> 

Me too!

Cheers,
Benjamin

> Thanks!
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
