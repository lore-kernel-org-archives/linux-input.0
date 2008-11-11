From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Tue, 11 Nov 2008 12:02:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811111143050.29125-100000@netrider.rowland.org>
References: <20081111084132.GE3810@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:1665 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751625AbYKKRCK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 12:02:10 -0500
In-Reply-To: <20081111084132.GE3810@one.firstfloor.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, 11 Nov 2008, Andi Kleen wrote:

> On Mon, Nov 10, 2008 at 07:45:28PM -0500, Alan Stern wrote:
> > On Tue, 11 Nov 2008, Andi Kleen wrote:
> > 
> > > Hi,
> > > 
> > > I have a box here which has a couple of USB devices connected.
> > > That includes several HID devices (keyboards, mouse) and a couple
> > > of others including a USB powerswitch driven through a user space
> > > program.
> > > 
> > > Now what happened is that I changed some of the HID devices
> > > around (moving from a direct port to a hub) and also moved
> > > the USB power switch from one port to another. But after that
> > > the power switch didn't work anymore, just giving a flood 
> > > of
> > > 
> > > usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
> > > 
> > > (sispm is the user space driver)
> > > 
> > > Kernel is 2.6.28-rc3
> > 
> > This sounds like a userspace problem.  The sispm program should unbind 
> > usbhid from interface 0 before trying to set the config.
> 
> Can you please explain in layman's terms why usbhid does not 
> unbind itself when it detects the removal of a device? 

It does.  The problem is on the other side: Your power switch presents 
itself as an HID device, so when it is _detected_ it binds to usbhid.

On the other hand, your log contains an error message saying "couldn't 
find an input interrupt endpoint".  That should have caused usbhid's 
probe to fail.  Perhaps the failure occurred on interface 1, leaving 
usbhid still bound to interface 0.

You can find out exactly which drivers are bound to which interfaces by 
looking at /proc/bus/usb/devices.  (Depending on your distribution, you 
may first need to mount /proc/bus/usb as type usbfs.)

> Why should sispm need to unbind someone else?

The usbfs API does not allow user programs to set a device's
configuration if any drivers are bound to the device.  Therefore, if a 
program wants to set a config then it must unbind all the existing 
drivers first.  This is a safety precaution against programs 
interfering with other drivers.

Now in fact, sispm probably doesn't need to set the configuration at 
all.  This is undoubtedly a holdover from a Windows version, because 
Windows does not set device configurations by default whereas Linus 
does.

Alan Stern

