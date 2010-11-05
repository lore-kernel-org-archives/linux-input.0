From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Touchpad toggle mess
Date: Thu, 4 Nov 2010 19:20:05 -0700
Message-ID: <20101105022004.GA26173@core.coreip.homeip.net>
References: <1288915209.5418.72.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45376 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0KECUQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Nov 2010 22:20:16 -0400
Content-Disposition: inline
In-Reply-To: <1288915209.5418.72.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, xorg@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Martin Pitt <martin.pitt@ubuntu.com>

Hi Bastien,

On Fri, Nov 05, 2010 at 12:00:09AM +0000, Bastien Nocera wrote:
> Heya,
> 
> In GNOME 2.32, we added support for touchpad toggle buttons, by
> capturing the XF86TouchpadToggle button in gnome-settings-daemon,
> showing a nice popup, and disabling the touchpad in software.
> 
> That works great for a number of laptops, but completely breaks a number
> of others where the hardware handles the request, but still sends a key
> event (usually separate ones for on and off). In those cases, we'd need
> 2 more key types, in the kernel, and in X.org.

Rfkill story all over I guess ;(

> 
> The patches in https://bugs.freedesktop.org/show_bug.cgi?id=31300
> implement this for the kernel, and for X.org.
> 
> Then we have the problem that udev's keymaps seem to use different
> function keys depending on the hardware [1], when X.org (because of the
> limitations of XKB) standardised on F22 for "XF86TouchpadToggle".
> 
> So we'll need to standardise on the keys used. I selected F21 for
> XF86TouchpadToggle, F22 for XF86TouchpadOn and F23 for XF86TouchpadOff.
> See the patch in:
> https://bugs.freedesktop.org/show_bug.cgi?id=31333
> 
> The remaining fixes would need to be in udev's keymaps, to set hardware
> handled keys to F22 and F23, and software ones to F21. Patch is attached
> for that.
> 
> Questions, comments?

I still believe we need dedicated keycodes in kernel for that and make
sure that in-kernel maps use proper keycodes so that programs that do
not have the same limitations that X has could differentiate between
touchpad events and real F2* events. X can still continue to use f21, 22
and 23 (at least while it can't handle higher keycodes), and common
setups may rely on udev's facilities to remap the keys.

Thanks.

-- 
Dmitry
