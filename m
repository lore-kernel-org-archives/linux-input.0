From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.24:  false double-clicks from USB mouse
Date: Sun, 02 Dec 2007 13:52:46 -0500
Message-ID: <4752FEFE.3000600@rtr.ca>
References: <4752DB8C.50608@rtr.ca> <4752E432.10504@rtr.ca> <Pine.LNX.4.64.0712021903460.12208@twin.jikos.cz> <4752F6C7.4040904@rtr.ca> <Pine.LNX.4.64.0712021918500.13260@jikos.suse.cz> <4752FE11.2050200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3367 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbXLBSws (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2007 13:52:48 -0500
In-Reply-To: <4752FE11.2050200@rtr.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rubini@vision.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Mark Lord wrote:
> 
> Here's a *single* button click (press/release quickly):
> 
> Event: time 1196621063.612542, type 1 (Key), code 272 (LeftBtn), value 1
> Event: time 1196621063.612553, type 0 (Reset), code 0 (Reset), value 0
> Event: time 1196621063.620504, type 1 (Key), code 272 (LeftBtn), value 0
> Event: time 1196621063.620512, type 0 (Reset), code 0 (Reset), value 0
> Event: time 1196621063.628497, type 1 (Key), code 272 (LeftBtn), value 1
> Event: time 1196621063.628502, type 0 (Reset), code 0 (Reset), value 0
> Event: time 1196621063.684524, type 1 (Key), code 272 (LeftBtn), value 0
> Event: time 1196621063.684531, type 0 (Reset), code 0 (Reset), value 0
> Event: time 1196621063.700532, type 1 (Key), code 272 (LeftBtn), value 1
> Event: time 1196621063.700538, type 0 (Reset), code 0 (Reset), value 0
> Event: time 1196621063.764540, type 1 (Key), code 272 (LeftBtn), value 0
> Event: time 1196621063.764550, type 0 (Reset), code 0 (Reset), value 0
..


Note that, much of the time, a single mouse click looks like this:

Event: time 1196621357.073485, type 1 (Key), code 272 (LeftBtn), value 1
Event: time 1196621357.073494, type 0 (Reset), code 0 (Reset), value 0
Event: time 1196621357.201482, type 1 (Key), code 272 (LeftBtn), value 0
Event: time 1196621357.201492, type 0 (Reset), code 0 (Reset), value 0

So the first one I posted was probably the same kind of sequence
that leads to the unwanted double-clicks I'm reporting here.

This information may also be relevant:

The mouse is plugged into a USB2 hub, and appears as IRQ19:

 19:      34776          0   IO-APIC-fasteoi   uhci_hcd:usb1, ehci_hcd:usb5

Cheers

