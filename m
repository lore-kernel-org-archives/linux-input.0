From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Question about /dev/hidraw*
Date: Mon, 4 Jan 2010 12:13:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001041208340.2277@pobox.suse.cz>
References: <6C2434209962DC46B88345CA85C334A2858711C53F@Courier.syntech.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39775 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab0ADLNd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jan 2010 06:13:33 -0500
In-Reply-To: <6C2434209962DC46B88345CA85C334A2858711C53F@Courier.syntech.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Butsch <mbutsch@syntech-fuelmaster.com>
Cc: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

On Fri, 11 Dec 2009, Mark Butsch wrote:

> I am going to be developing several USB devices and am interested in 
> utilizing the '/dev/hidraw*' interface to make it easier, i.e. don't 
> need to write drivers.
> 
> I have a few questions about the /dev/hidraw interface:
> 
> 1. Is there a list of best practices and/or example for using /dev/hidraw?

Not really a "documentation" or "example code". I really should write a 
few lines of it though, you are right.

But there are already drivers floating around the net which use this 
interface, you should be able to find them and inspect them. The interface 
is super-trivial though. If you have any questions before I write the 
example code documentation, just ask me.

> 2. Will a vendor-specific HID always have a /dev/hidraw available 
> (provided kernel is built for it)?

Yes, hidraw_connect() accepts any HID device, no matter the range of 
provided applications (as per device descriptor).

> 3. For an HID that identifies itself as a keyboard (for example), is 
> there a way to not have it function as a normal keyboard (with the input 
> subsystem) yet have access to it via the /dev/hidraw? I tried unbinding 
> it, but then the /dev/hidraw went away also.

We'd need to clear HID_CONNECT_HIDINPUT flag for this device in order to 
achieve that. Some drivers (hid-apple and hid-samsung) do this for 
particular devices.

> 4. I did some reading of the HID driver source code and looks like if 
> there was some way to clear the HID_CLAIMED_INPUT bit, that would keep 
> the input subsystem from processing the event. Is there a reason that 
> something like that could/should not be done?

HID_CLAIMED_INPUT is set by the hid-input part of the code once the 
registration with the input subsystem has been successfully performed. 
Clearing that doesn't provide the functionality you are looking for. 
Clearing HID_CONNECT_HIDINPUT is the way to go though.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
