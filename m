From: Andi Kleen <andi@firstfloor.org>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Tue, 11 Nov 2008 22:07:05 +0100
Message-ID: <20081111210705.GG3810@one.firstfloor.org>
References: <20081111084132.GE3810@one.firstfloor.org> <Pine.LNX.4.44L0.0811111143050.29125-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:48222 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbYKKU56 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 15:57:58 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811111143050.29125-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andi Kleen <andi@firstfloor.org>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, rjw@sisk.pl

> It does.  The problem is on the other side: Your power switch presents 
> itself as an HID device, so when it is _detected_ it binds to usbhid.

Ok, but it worked in all kernels before. Why has that changed?

Looks like a regression to me. Rafael, can you please add it to the list?

> > Why should sispm need to unbind someone else?
> 
> The usbfs API does not allow user programs to set a device's
> configuration if any drivers are bound to the device.  Therefore, if a 
> program wants to set a config then it must unbind all the existing 
> drivers first.  This is a safety precaution against programs 
> interfering with other drivers.
> 
> Now in fact, sispm probably doesn't need to set the configuration at 
> all.  This is undoubtedly a holdover from a Windows version, because 
> Windows does not set device configurations by default whereas Linus 
> does.

So you're saying that sispm should be changed to not do something?
What something exactly? And it would work then?

And why exactly does what it used to do before not work anymore now?

-Andi
-- 
ak@linux.intel.com
