From: Zachary Lund <admin@computerquip.com>
Subject: Re: [PATCH 0/7] Input: xpad: Fix wireless controller connection and leds
Date: Thu, 6 Feb 2014 03:11:11 +0000 (UTC)
Message-ID: <loom.20140206T035948-368@post.gmane.org>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49074 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBFDPF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Feb 2014 22:15:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1WBFQe-0005lZ-Ev
	for linux-input@vger.kernel.org; Thu, 06 Feb 2014 04:15:04 +0100
Received: from li40-72.members.linode.com ([72.14.178.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 04:15:04 +0100
Received: from admin by li40-72.members.linode.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 04:15:04 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Greg Kroah-Hartman <gregkh <at> linuxfoundation.org> writes:

> 
> Here's a series of patches from Pierre-Loup and I that rework the xpad
> driver to fix the issue where when a wireless xpad controller is plugged
> in, 4 joystick devices are created, no matter how many are really
> attached to the system.  Pierre-Loup's patches fix this by dynamically
> creating the devices only when they are found by the wireless
> controller.
> 
> Bonus is that the LEDs now work correctly with this series too, when
> mixing wireless and wired, we can properly identify which device is
> which on the X-LED.  We also now name the LED device based on the
> joystick id, not on an atomic number that keeps incrementing, never
> decrementing when removed from the system.
> 
> Note, patch 4/7 is a crazy hack to get the minor number of the joystick
> id that we have registered with the system.  Pierre-Loup came up with
> this, and I really can't figure out any other way to do it, the joydev
> layer doesn't even know this information, otherwise I would have added
> it to that layer so the xpad driver could call it.  Am I missing
> something here that we could do instead?
> 
> The first patch in the series fixes a really annoying bug when plugging
> in one of these controllers to a USB 3 system.  The URB type is
> incorrect so the xhci driver complains about it, rightly so.  I think
> the original code was incorrect, but left it alone incase there is
> really a crazy device with a bulk endpoint instead of interrupt.
> 
> Also, even with this series applied, the xpad driver needs a bunch of
> work.  The LED device seems pointless as it doesn't actually work, and
> given that the number/name of the LED device was impossible to actually
> map to the proper xpad device, there's no way userspace code could ever
> actually use it.  I think it should be removed entirely.  There's also
> some other USB things that should be cleaned up, the bulk urb doesn't
> need to be always running (with lots of disconnect/connect cycles you
> can get a warning about it running when trying to submit it again), and
> the urb callbacks seem a bit strange.  I'll work on those issues next...
> 
> This series was based on a larger patch from Pierre-Loup that I broke up
> into pieces, and added some of my own where needed to resolve other
> issues.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Since it may help, I'll add a link to my driver here. I have no intention of 
trying to mainstream this driver and have used it personally for slightly 
better support than what's provided now. I've recently done even more work 
on it for the fun of it (not sure if I'm cut out for kernel hacking...).

Use at your own risk:
https://github.com/computerquip/xpad360wr

I find that the main problem with any of this is that I don't know how to 
query features e.g. whether or not a device actually has FF capabilities. 
It's currently just assumed to have FF capabilities. I suspect its in the 
announce packet for wireless devices. For wired, it's just matched up 
against a table of devices to determine what features it has. 



