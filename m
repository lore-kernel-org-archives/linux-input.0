From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Thu, 8 Mar 2012 11:57:37 +0100
Message-ID: <20120308105737.GA11201@polaris.bitmath.org>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com>
 <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>
 <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:53843 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab2CHK4V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Mar 2012 05:56:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 07, 2012 at 10:36:41PM +0100, Jiri Kosina wrote:
> On Tue, 6 Mar 2012, benjamin.tissoires wrote:
> 
> > From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> > 
> > The code is inspired from the one present in the bttv module.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> > ---
> > 
> > As I mentioned in the mail 0/5, I'd really like to have your opinion on this
> > one. I copied the code from bttv, but it forces us to change hid_device which
> > is not very good for ABI changes reasons.
> 
> Haven't closely inspected the patch yet, I will comment on it later. But 
> generally, I wouldn't be worried about changing hid_device per se ... it's 
> not really an ABI, it's not exported to userspace.
> 
> It's internal kernel-ABI, yes. But we are free to change that in any way 
> we wish.
> 
> -- 

Thanks for having another go at this problem. Obviously, it is hard to
find a completely satisfactory solution to auto-loading in the current
hid framework. This latest attempt somehow comes close to the smallest
hackery that makes it possible. If we want to go beyond that, I think
we need to restructure more than the internal hid device
representation.

What if we were to change the definition of a HID device on the
modalias level?

In practise, a HID device can be either an usb device, a hid device, a
single interface on a usb bus, a special class determined by examining
the reports, etc. Yet, the hid modalias contains only bus type, vendor
and product id. This is true for the generic usb and bluetooth drivers
(and some very special drivers), but not really for the other devices.
If we were to extend the modalias description, we could cater for a
whole tree of hid devices. For instance, the usb id 1234 could be
handled by the generic usb bus driver. The multitouch sub-device
1234:MT could be handled by hid-multitouch. The mouse device
1234:Mouse could be handled by some other driver, etc. All the driver
handling could be automated in userland using the same udev mechanism
we have today, if only the hid uevents were modified to incorporate
the needed extra information.

Would this be a problematic change in userland, or would it be a
feasible, in principle?

Thanks,
Henrik
