From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: RH Bugzilla - Bug 1482649 - Logitech USB Unified Receiver+M570
 need 'waking' up by click after kernel update
Date: Sat, 9 Sep 2017 10:52:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709091051140.11228-100000@netrider.rowland.org>
References: <AM5PR0301MB2499095ECA92231DF068127C87950@AM5PR0301MB2499.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM5PR0301MB2499095ECA92231DF068127C87950-kM7tpf17gtYRSd3pSe3JWMiOivS/YiWQnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Simms <micsim2007-PkbjNfxxIAQqdlJmJB21zg@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org " <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Simms <micsim2007-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org " <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 8 Sep 2017, Mike Simms wrote:

> Hi Alan yes it says the same "unsupported" and all other values are
> the same too. I included them in brackets in my post. Yes it is odd.
> I don't know if the usbmon traces show anything useful. To me it's
> gobbledygook.

Where are the usbmon traces?

> On 8 Sep 2017 9:35 p.m., Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> 
> On Fri, 8 Sep 2017, Jiri Kosina wrote:
> 
> > On Fri, 8 Sep 2017, Mike Simms wrote:
> >
> > > Thanks for getting back to me,
> > >
> > > 4.11.11-300.fc26.x86_64 and 4.12.9-300.fc26.x86_64
> > >  are showing identical settings - autosuspend definitely on for
> > > device /sys/bus/usb/devices/2-1.3/2-1.3:1.0/0003:046D:C52B.0001/power
> > >
> > > it shows in the powertop UI as good for both kernels and
> > >
> > > Folder contents are autosuspend_delay_ms (can't open), control (auto),
> > > runtime_active_time (0), runtime_status (unsupported),
> 
> The "unsupported" means that runtime suspend is disabled.  (Don't ask
> me why it doesn't say "disabled" instead.)  That is suspicious in
> itself.  Drivers don't normally disable runtime suspend for more than
> very short time intervals.
> 
> Does the runtime_status file really say "unsupported" in both kernels?
> 
> > > runtime_suspended_time (0)
> >
> > Alright, that means that both kernels are allowed to autosuspend the
> > device, but apparently only 4.12 actually does so. Could you please
> > confirm that with usbmon traces?
> 
> In addition to usbmon traces, it would be good to look at the settings
> under /sys/bus/usb/devices/2-1.3/2-1.3:1.0/power/.  It's unlikely that
> they have changed between 4.11 and 4.12, but it doesn't hurt to check.

Did you do this?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
