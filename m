From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: ALPS touchpad recognized as Generic Wheel Mouse
Date: Mon, 21 Nov 2011 08:47:59 -0600
Message-ID: <20111121144759.GB6736@thinkpad-t410>
References: <4EC95D0B.4070407@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57152 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab1KUOsC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 09:48:02 -0500
Content-Disposition: inline
In-Reply-To: <4EC95D0B.4070407@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felix Zweig <f.zweig@yahoo.de>
Cc: linux-input@vger.kernel.org

On Sun, Nov 20, 2011 at 09:03:23PM +0100, Felix Zweig wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The following refers to the same Touchpad as in bug #15893 (ALPS in an
> Acer Aspire 532h).
> 
> The device is recognized as "ImPS/2 Generic Wheel Mouse as
> /devices/platform/i8042/serio1/input/input5" instead of a touchpad; at
> least since Linux 3.0 (and up to 3.2-rc2).
> 
> As one result, middle mouse button emulation doesn't work. IIRC, evdev
> disabled it for non-touchpad inputs a while ago.
> 
> Is there a way to have the device recognized correctly as a touchpad (as
> it used to be a few versions earlier, unfortunately I can't remember
> which versions worked).

I sent some patches that should be in 3.3 that will get your touchpad
working, with the exception of multitouch (the 532h is one of the
machines I used to develop the patches). You can find the patches in the
following locations if you'd like to give them a try.

  https://lkml.org/lkml/2011/11/7/433
  http://git.kernel.org/?p=linux/kernel/git/dtor/input.git
