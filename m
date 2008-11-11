From: Andi Kleen <andi@firstfloor.org>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Tue, 11 Nov 2008 09:41:32 +0100
Message-ID: <20081111084132.GE3810@one.firstfloor.org>
References: <20081111003117.GA10904@basil.nowhere.org> <Pine.LNX.4.44L0.0811101939100.15552-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:39874 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbYKKIcZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 03:32:25 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811101939100.15552-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andi Kleen <andi@firstfloor.org>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, Nov 10, 2008 at 07:45:28PM -0500, Alan Stern wrote:
> On Tue, 11 Nov 2008, Andi Kleen wrote:
> 
> > Hi,
> > 
> > I have a box here which has a couple of USB devices connected.
> > That includes several HID devices (keyboards, mouse) and a couple
> > of others including a USB powerswitch driven through a user space
> > program.
> > 
> > Now what happened is that I changed some of the HID devices
> > around (moving from a direct port to a hub) and also moved
> > the USB power switch from one port to another. But after that
> > the power switch didn't work anymore, just giving a flood 
> > of
> > 
> > usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
> > 
> > (sispm is the user space driver)
> > 
> > Kernel is 2.6.28-rc3
> 
> This sounds like a userspace problem.  The sispm program should unbind 
> usbhid from interface 0 before trying to set the config.

Can you please explain in layman's terms why usbhid does not 
unbind itself when it detects the removal of a device? 

Why should sispm need to unbind someone else?

-Andi

-- 
ak@linux.intel.com
