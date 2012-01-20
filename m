From: Greg KH <greg@kroah.com>
Subject: Re: PROBLEM: Kernel version 3.2.1 usb touchscreen device not
 recognised [UDEV? USBINPUT? HOOK]
Date: Fri, 20 Jan 2012 15:44:44 -0500
Message-ID: <20120120204444.GA20799@kroah.com>
References: <4F192242.1070909@exemail.com.au>
 <20120120160210.GA21565@kroah.com>
 <4F19CB06.6040801@exemail.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50311 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754325Ab2ATUpk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jan 2012 15:45:40 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C0E612117F
	for <linux-input@vger.kernel.org>; Fri, 20 Jan 2012 15:45:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4F19CB06.6040801@exemail.com.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Padfoot <padfoot@exemail.com.au>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Jan 21, 2012 at 07:13:58AM +1100, Padfoot wrote:
> On 21/01/12 03:02, Greg KH wrote:
> >On Fri, Jan 20, 2012 at 07:13:54PM +1100, Padfoot wrote:
> >>Upgrade from kernel 3.1.9 to 3.2.1 eGalax usb touchscreen device is
> >>no longer recognised.
> >>
> >>Device is an Acer Iconia Tab w501 with inbuilt touchscreen. Screen
> >>is a pci device but is connected on boot as a usb input device.
> >>Issue appears to be with either UDEV or USBINPUT boot hook failing
> >>to recognise the device as can be seen in the dmesg.3.2.1
> >>attachment.
> >>
> >>Downgrading to kernel 3.1.9 corrects the issue.
> >Can you run 'git bisect' between 3.1.0 and 3.2.0 to find the problem
> >commit here?
> >
> >Also, you might want to cc: the linux-input developers, they can help
> >you out much better than the general list can.
> >
> >greg k-h
> >
> Hi Greg,
> 
> I am not a kernel dev, nor have I ever compiled a kernel, so I don't
> think I am able to help with a git bisect to locate the offending
> commit. I am just a regular user running pre-compiled packages on my
> Arch Linux distro. But, of course I am happy to assist wherever I
> can.

If you want to build your own kernel, there are lots of instructions on
how do this online (google for 'linux kernel in a nutshell' for a free
book about this.)

Otherwise, can you file a bug with the arch linux developers?  They
might be able to help you out here better as you are using a distro
kernel.

good luck,

greg k-h
