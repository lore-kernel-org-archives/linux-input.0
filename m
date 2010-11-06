From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Touchpad toggle mess
Date: Sat, 06 Nov 2010 15:56:09 +0000
Message-ID: <1289058969.5418.91.camel@novo.hadess.net>
References: <1288915209.5418.72.camel@novo.hadess.net>
	 <20101105022004.GA26173@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <20101105022004.GA26173@core.coreip.homeip.net>
Sender: linux-hotplug-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, xorg@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Martin Pitt <martin.pitt@ubuntu.com>
List-Id: linux-input@vger.kernel.org

On Thu, 2010-11-04 at 19:20 -0700, Dmitry Torokhov wrote:
> Hi Bastien,
> 
> On Fri, Nov 05, 2010 at 12:00:09AM +0000, Bastien Nocera wrote:
> > Heya,
> > 
> > In GNOME 2.32, we added support for touchpad toggle buttons, by
> > capturing the XF86TouchpadToggle button in gnome-settings-daemon,
> > showing a nice popup, and disabling the touchpad in software.
> > 
> > That works great for a number of laptops, but completely breaks a number
> > of others where the hardware handles the request, but still sends a key
> > event (usually separate ones for on and off). In those cases, we'd need
> > 2 more key types, in the kernel, and in X.org.
> 
> Rfkill story all over I guess ;(

Yes, though a fair bit simpler :)

> > The patches in https://bugs.freedesktop.org/show_bug.cgi?id=31300
> > implement this for the kernel, and for X.org.
> > 
> > Then we have the problem that udev's keymaps seem to use different
> > function keys depending on the hardware [1], when X.org (because of the
> > limitations of XKB) standardised on F22 for "XF86TouchpadToggle".
> > 
> > So we'll need to standardise on the keys used. I selected F21 for
> > XF86TouchpadToggle, F22 for XF86TouchpadOn and F23 for XF86TouchpadOff.
> > See the patch in:
> > https://bugs.freedesktop.org/show_bug.cgi?id=31333
> > 
> > The remaining fixes would need to be in udev's keymaps, to set hardware
> > handled keys to F22 and F23, and software ones to F21. Patch is attached
> > for that.
> > 
> > Questions, comments?
> 
> I still believe we need dedicated keycodes in kernel for that and make
> sure that in-kernel maps use proper keycodes so that programs that do
> not have the same limitations that X has could differentiate between
> touchpad events and real F2* events. X can still continue to use f21, 22
> and 23 (at least while it can't handle higher keycodes), and common
> setups may rely on udev's facilities to remap the keys.

I actually looked through the kernel, and couldn't find any drivers that
used F2X for touchpad toggling. All those keys are mapped in udev.

But I agree that we need to add those keys in the kernel, which is why I
cooked up:
https://bugs.freedesktop.org/attachment.cgi?id=39965

Do you want me to send the patch separately?

Cheers

