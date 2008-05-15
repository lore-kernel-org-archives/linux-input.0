From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 15 May 2008 14:35:54 -0400
Message-ID: <20080515142845.ZZRA012@mailhub.coreip.homeip.net>
References: <20080514221519.GA6575@kroah.com> <20080515132108.GA9327@dose.home.local> <20080515094212.ZZRA012@mailhub.coreip.homeip.net> <20080515174939.GA10881@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080515174939.GA10881-z7fNteJZwjmqk56C3691EA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, May 15, 2008 at 07:49:39PM +0200, Tino Keitel wrote:
> On Thu, May 15, 2008 at 09:45:52 -0400, Dmitry Torokhov wrote:
> > Hi Tino,
> > 
> > On Thu, May 15, 2008 at 03:21:08PM +0200, Tino Keitel wrote:
> > > Hi,
> > >
> > > I'm pretty sure that this breaks the macmini LIRC driver again, see
> > > commit 3e1928e8793208802589aae851b6685671187242.
> > >
> > 
> > But with in-kernel driver can't LIRC feed of event device?
> 
> Sure, it can. But in its current state, it breaks existing scenarios
> and seems to have restrictions. See the comment below regarding
> learning remotes, and my other mail in this thread regarding broken
> suspend with the appleir driver.
> 

These needs to be fixed before it is in mainline, no argument here.

> > Ane people that dont use LIRC can also have access to the remote?
> 
> I know. I just wanted to point out that this is a regression for all
> people who use the macmini LIRC driver. This driver was present at
> least in the last 2 LIRC releases. The quirks stuff in the above patch
> looks like there is no way to make the macmini LIRC driver work with
> the patch applied. It relies on a USB HID device, which wouldn't be
> created anymore, and the user has no way to bring it back. Please
> correct me with a pointer to the appropriate documentation if I'm
> wrong.
>

There is a way to dynamically manipulate quirks for a VID/PID pair via
sysfs. I think if you set the quirk to 0 it will efefctively disable
the ignore quirk restoring the old behaviour.

> From the user's point of view: There are no official kernel release
> notes about what devices are added/removed to/from the various ignore
> lists and blacklists. The kernel doesn't produce any output about
> devices that are ignored or blacklisted in may cases (and also this
> one). The user has no indication why his LIRC setup stops working with
> the new kernel.
>

Not sure what we can do here... The only thing I guess is better
commit message mentioning LIRC setup concerns.

> Even if all LIRC users switch to the appleir driver, what about people
> who use a learning remote to have more than 6 keys that the Apple
> remote has? Does this work at all? After a quick look at the key
> handling it seems to me that the codes of the 6 keys are hardcoded in
> the driver. So a learning remote with more keys wouldn't work anymore.
>

We'll have to adjust the driver to allow changing keymap on a
per-device base from userspace. That's pretty easy actually.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
