From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Mon, 20 Sep 2010 16:55:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009201642310.1306-100000@iolanthe.rowland.org>
References: <alpine.LNX.2.00.1009201708340.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36961 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756835Ab0ITUzc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 16:55:32 -0400
In-Reply-To: <alpine.LNX.2.00.1009201708340.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mat <jackdachef@gmail.com>, Guillaume Chazarain <guichaz@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Oliver Neukum <oliver@neukum.org>, Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Andreas Bombe <aeb@debian.org>, Alex Riesen <raa.lkml@gmail.com>, Phil Turmel <philip@turmel.org>

On Mon, 20 Sep 2010, Jiri Kosina wrote:

> Thanks Matt and Phill for confirming the line that triggers the oops. As I 
> am not able to reproduce it myself, it's a bit tricky to track down what 
> went wrong.
> 
> Could you please apply the patch below? It's printing the hid <-> hiddev 
> <-> usb_interface connections at various stages of probing and open. 
> Hopefully it'll reveal a little bit what goes wrong and where.

Jiri:

There's something very fishy going on here.  Even more so than these 
bug reports suggest.

The whole business about hiddev_driver in hiddev.c looks bogus.  It
doesn't get used for anything and it never binds to an interface.  
Which means that the usb_find_interface call in hiddev_open should
never succeed.  At the very least it would need to specify hid_driver
instead of hiddev_driver.

I have no idea what's really happening.  Can you figure it out?

Alan Stern

