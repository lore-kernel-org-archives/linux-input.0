From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Communicating tablet mode status to userspace
Date: Tue, 2 Oct 2012 16:36:41 -0700
Message-ID: <20121002233640.GB8542@core.coreip.homeip.net>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58209 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab2JBXgp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Oct 2012 19:36:45 -0400
Content-Disposition: inline
In-Reply-To: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>

On Tue, Oct 02, 2012 at 04:27:07PM -0600, Daniel Drake wrote:
> Hi,
> 
> For the upcoming OLPC touchscreen laptop we're trying to solve the
> following problem: we want the on-screen keyboard to only activate
> itself when the laptop is "folded over" into tablet mode where the
> keyboard is physically obscured.
> 
> We already have an ebook mode switch which detects this, and the
> driver is upstream. Its an input device that exposes this information
> via the SW_TABLET_MODE switch.
> 
> The on-screen keyboard runs in the user environment, which means that
> its not root - it can't access /dev/input/event nodes directly. X
> doesn't treat switches as input devices, so this info is not available
> through X.
> 
> I'm wondering if anyone has suggestions on the best way to solve this
> problem. The most attractive option I have found would be to do
> something similar to the accelerometer:
> http://git.kernel.org/?p=linux/hotplug/udev.git;a=blob;f=src/accelerometer/accelerometer.c
> 
> Modify the kernel input driver to generate a uevent (in addition to
> the evdev event) every time the switch state is changed, then write a
> udev program to expose this info in a udev property.
> 
> The change event would (presumably) trigger libudev's udev_monitor,
> which would be used by the on-screen keyboard software (maliit) to
> change its behaviour according to the property value.
> 
> Does this sound like a sensible plan, would these udev and kernel
> changes be acceptable? Or is there a better option that I'm missing?

Why can't you change event device ownership to the local user?  Then you
can read and act upon events.

Thanks.

-- 
Dmitry
