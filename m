From: Andre Haupt <andre@bitwigglers.org>
Subject: Re: mouse bug
Date: Fri, 30 Nov 2007 15:25:56 +0100
Message-ID: <20071130142556.GA14122@ahaupt-debian-vm.localdomain>
References: <475018E3.5090606@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:54535 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673AbXK3O0h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Nov 2007 09:26:37 -0500
Content-Disposition: inline
In-Reply-To: <475018E3.5090606@tiscali.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-input@vger.kernel.org

On Fri, Nov 30, 2007 at 03:06:27PM +0100, Roel Kluin wrote:
> Once in every so often boots I end up in X without a functioning mouse. A
> pointer is shown, but glued to the center of the screen. A reboot will fix it,
> but I have had this behavior for a few years now and still no clue what the
> origin of the problem is - dmesg reports as it does normally:
> 
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> mice: PS/2 mouse device common for all mice
> 
> killing and restarting X and/or gpm doesn't return control over the mouse.
> 
> I have been storing dmesgs at failures:
> 2007-08-29
> 2007-09-15
> 2007-11-23
> (I boot twice a day on average)
> 
> As you can see, I had one recently. This time I also made a copy of my /proc
> and /sys directories. (I am guessing /proc was not really needed) maybe any info
> can still be extracted?
> 
> Where can I look, what can I do to find the source of this problem? Is there
> anything that I should do to obtain more info when this occurs nexttime?

does cat /dev/input/mice work (i.e. shows weird characters)?

regards,

Andre
