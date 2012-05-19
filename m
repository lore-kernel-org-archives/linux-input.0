From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [-next regression] USB keyboard stops working occasionally
Date: Sat, 19 May 2012 15:39:03 -0700
Message-ID: <20120519223903.GA12572@kroah.com>
References: <4FB81BF9.7040705@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FB81BF9.7040705-AlSwsSmVLrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 20, 2012 at 12:17:29AM +0200, Jiri Slaby wrote:
> Hi,
> 
> sometimes, in the middle of writing, my USB HID keyboard stops sending
> interrupts (no changes in /proc/interrupts). I have to hit a key on
> another USB interface of that keyboard to resurrect the other. It
> happens once or twice a day. It happens with -next since around Friday 4th.
> 
> I tried to bisect it a bit (three or four times because of fuzz) in the
> past 3 weeks and my suspect number one is currently:
> commit 3d9545cc375d117554a9b35dfddadf9189c62775
> Author: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Date:   Mon Apr 23 13:54:36 2012 -0400
> 
>     EHCI: maintain the ehci->command value properly
> 
> ===
> 
> I'm currently running on -next 20120518 with that commit reverted for
> one whole day and the issue seems to be gone.
> 
> Could you take a look and double-check that commit? (Or do you have any
> other ideas where to take a look?)

Yes, we realized this a few days ago, and I committed a fix for this a
few hours ago to the usb-next tree, and should show up in the next -next
release.

I've included the patch below that should fix this problem, please let
me know if it doesn't for you.

thanks,

greg k-h

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=x

>From 1c01f1d9a603ecf1744ae2d1a015c4b27c2b9fa0 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Date: Sat, 19 May 2012 23:11:19 +0800
Subject: [PATCH] USB: EHCI: fix command register configuration lost problem

The 3d9545cc375d117554a9b35dfddadf9189c62775(EHCI: maintain the
ehci->command value properly) introducs one command register
configuration lost problem by the below line in ehci_reset:

	ehci->command = ehci_readl(ehci, &ehci->regs->command);

After writting RESET into command register, it is restored to
its default value per EHCI spec[1], so the previous configuration
will be lost, and may introduce some problems reported recently:
	- imx51 Babbage board detect usb hub failed[2], reported
	by Richard Zhao.
	- mouse and keyboard hangs in linux-next found by
	Dan Carpenter and Greg-KH.

So this patch just removes the line to fix these problems, and
keep configurating command register consistent as before the commit
3d9545cc(EHCI: maintain the ehci->command value properly).

[1], 4.1 Host Controller Initialization of EHCI Specification 1.0
[2], failed dmesg log:
	usb 1-1: new high-speed USB device number 2 using mxc-ehci
	hub 1-1:1.0: USB hub found
	hub 1-1:1.0: 7 ports detected
	mxc-ehci mxc-ehci.1: fatal error
	mxc-ehci mxc-ehci.1: HC died; cleaning up
	mxc-ehci mxc-ehci.1: force halt; handshake f5780344 00004000 00004000 -> -110
	mxc-ehci mxc-ehci.1: HC died; cleaning up
	usb 1-1: USB disconnect, device number 2

Reported-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Reported-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Signed-off-by: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index f644ba9..5597e60 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -352,7 +352,6 @@ static int ehci_reset (struct ehci_hcd *ehci)
 	if (ehci->debug)
 		dbgp_external_startup();
 
-	ehci->command = ehci_readl(ehci, &ehci->regs->command);
 	ehci->port_c_suspend = ehci->suspended_ports =
 			ehci->resuming_ports = 0;
 	return retval;

--DocE+STaALJfprDB--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
