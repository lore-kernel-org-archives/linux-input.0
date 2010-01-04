From: Mark Butsch <mbutsch@syntech-fuelmaster.com>
Subject: RE: Question about /dev/hidraw*
Date: Mon, 4 Jan 2010 16:24:37 -0500
Message-ID: <6C2434209962DC46B88345CA85C334A285943E4B3A@Courier.syntech.org>
References: <6C2434209962DC46B88345CA85C334A2858711C53F@Courier.syntech.org>
 <alpine.LNX.2.00.1001041208340.2277@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exchsrvr.syntech-fuelmaster.com ([199.44.250.2]:58134 "EHLO
	courier.syntech-fuelmaster.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753589Ab0ADVY7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jan 2010 16:24:59 -0500
In-Reply-To: <alpine.LNX.2.00.1001041208340.2277@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Jiri Kosina' <jkosina@suse.cz>
Cc: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

On Mon, 4 Jan 2010, Jiri Kosina wrote:
 
On Fri, 11 Dec 2009, Mark Butsch wrote:

> > I am going to be developing several USB devices and am interested in 
> > utilizing the '/dev/hidraw*' interface to make it easier, i.e. don't 
> > need to write drivers.
> > 
> > I have a few questions about the /dev/hidraw interface:
> > 
> > 1. Is there a list of best practices and/or example for using /dev/hidraw?

> Not really a "documentation" or "example code". I really should write a 
> few lines of it though, you are right.

> But there are already drivers floating around the net which use this 
> interface, you should be able to find them and inspect them. The interface 
> is super-trivial though. If you have any questions before I write the 
> example code documentation, just ask me.

> > 2. Will a vendor-specific HID always have a /dev/hidraw available 
> > (provided kernel is built for it)?

> Yes, hidraw_connect() accepts any HID device, no matter the range of 
> provided applications (as per device descriptor).

> > 3. For an HID that identifies itself as a keyboard (for example), is 
> > there a way to not have it function as a normal keyboard (with the input 
> > subsystem) yet have access to it via the /dev/hidraw? I tried unbinding 
> > it, but then the /dev/hidraw went away also.

> We'd need to clear HID_CONNECT_HIDINPUT flag for this device in order to 
> achieve that. Some drivers (hid-apple and hid-samsung) do this for 
> particular devices.

> > 4. I did some reading of the HID driver source code and looks like if 
> > there was some way to clear the HID_CLAIMED_INPUT bit, that would keep 
> > the input subsystem from processing the event. Is there a reason that 
> > something like that could/should not be done?

> HID_CLAIMED_INPUT is set by the hid-input part of the code once the 
> registration with the input subsystem has been successfully performed. 
> Clearing that doesn't provide the functionality you are looking for. 
> Clearing HID_CONNECT_HIDINPUT is the way to go though.

It looks to me that HID_CONNECT_HIDINPUT would be used if you are writing a kernel driver. I am accessing /dev/hidraw* from userspace. Kind of like using ioctl(EVIOCGRAB), but then you get HID reports instead of events. More general purpose.

I tried adding a couple of ioctl calls to hidraw.c to allow clearing and setting of HID_CLAIMED_INPUT and it appears to provide the functionality. I even added code in hidraw_release() to make sure  HID_CLAIMED_INPUT is set for the next time the device is opened.

Are there some details I have missed?

Thanks,

Mark

