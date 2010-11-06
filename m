From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Touchpad toggle mess
Date: Sat, 06 Nov 2010 15:58:21 +0000
Message-ID: <1289059101.5418.93.camel@novo.hadess.net>
References: <1288915209.5418.72.camel@novo.hadess.net>
	 <20101106153031.GA2215@piware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <20101106153031.GA2215@piware.de>
Sender: linux-hotplug-owner@vger.kernel.org
To: Martin Pitt <martin.pitt@ubuntu.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, xorg@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org

On Sat, 2010-11-06 at 11:30 -0400, Martin Pitt wrote:
> Hello Bastien,
> 
> Bastien Nocera [2010-11-05  0:00 +0000]:
> > The patches in https://bugs.freedesktop.org/show_bug.cgi?id=31300
> > implement this for the kernel, and for X.org.
> > 
> > Then we have the problem that udev's keymaps seem to use different
> > function keys depending on the hardware [1], when X.org (because of the
> > limitations of XKB) standardised on F22 for "XF86TouchpadToggle".
> 
> Thanks for bringing this up, indeed there's some cleanup in order
> here.
> 
> > So we'll need to standardise on the keys used. I selected F21 for
> > XF86TouchpadToggle, F22 for XF86TouchpadOn and F23 for XF86TouchpadOff.
> > See the patch in:
> > https://bugs.freedesktop.org/show_bug.cgi?id=31333
> > 
> > The remaining fixes would need to be in udev's keymaps, to set hardware
> > handled keys to F22 and F23, and software ones to F21. Patch is attached
> > for that.
> 
> Indeed the maps which don't currently use f22 should be fixed,
> regardless of what happens in X/kernel/userspace. My main concern is
> that F22 has acted as touchpad toggle key for years

No, for about a year:
http://cgit.freedesktop.org/xkeyboard-config/commit/?id=1d05eda8dfc706d6450cab5883120e0d5e1100c0

>  (many of those
> were imported from hal-info originally), so if we change everything to
> f21 now without updating userspace (things like gnome-settings-daemon)
> in lockstep, then we break existing functionality. 

You don't need to update gnome-settings-daemon. gnome-settings-daemon
doesn't see F21, F22 or F23, it'll see XF86TouchpadOn, etc.

> It would look slightly weird, but perhaps it might be better to keep
> using F22 for toggling, and F1->on, F23->off?

That sounds like a bit of a mess having those 2 keys not next to each.
F22 for toggling, F23 for on, F24 for off would do me fine, if that's
really required.

FWIW, the keys mapped in udev are the only ones that mapped F22. There's
nothing in the kernel using F22 for touchpad toggles of any kind.

Cheers

