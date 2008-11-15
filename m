From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Sun, 16 Nov 2008 00:58:14 +0100
Message-ID: <200811160058.14747.rjw@sisk.pl>
References: <20081111084132.GE3810@one.firstfloor.org> <Pine.LNX.4.44L0.0811111143050.29125-100000@netrider.rowland.org> <20081111210705.GG3810@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41321 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbYKOXxs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Nov 2008 18:53:48 -0500
In-Reply-To: <20081111210705.GG3810@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Tuesday, 11 of November 2008, Andi Kleen wrote:
> > It does.  The problem is on the other side: Your power switch presents 
> > itself as an HID device, so when it is _detected_ it binds to usbhid.
> 
> Ok, but it worked in all kernels before. Why has that changed?
> 
> Looks like a regression to me. Rafael, can you please add it to the list?

Done.

Thanks,
Rafael

 
> > > Why should sispm need to unbind someone else?
> > 
> > The usbfs API does not allow user programs to set a device's
> > configuration if any drivers are bound to the device.  Therefore, if a 
> > program wants to set a config then it must unbind all the existing 
> > drivers first.  This is a safety precaution against programs 
> > interfering with other drivers.
> > 
> > Now in fact, sispm probably doesn't need to set the configuration at 
> > all.  This is undoubtedly a holdover from a Windows version, because 
> > Windows does not set device configurations by default whereas Linus 
> > does.
> 
> So you're saying that sispm should be changed to not do something?
> What something exactly? And it would work then?
> 
> And why exactly does what it used to do before not work anymore now?
