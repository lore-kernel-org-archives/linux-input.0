From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: don't grab devices with no input
Date: Thu, 13 Nov 2008 16:37:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811131632150.3036-100000@iolanthe.rowland.org>
References: <1226610600-22899-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39433 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750852AbYKMVhy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 16:37:54 -0500
In-Reply-To: <1226610600-22899-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Nov 2008, Jiri Slaby wrote:

> Alan Stern wrote:
> > This suggests that a lot of the work in usbhid_start should be 
> > performed earlier, before calling hid_add_device.  After all, why 
> > bother registering a USB device on the input bus if usbhid isn't going 
> > to be able to drive it?
> 
> None of the code can be moved to the usbhid probe function, because all
> of it depends on the driver's (potential) report_fixup.
> 
> However I suggest moving this test to the probe which ensures performing
> the test early enough.

That makes sense.  It's the only failure mode in usbhid_start which
isn't a simple out-of-memory error.

> Andi, could you test the attached patch?
> 
> --
> 
> Some devices have no input interrupt endpoint. These won't be handled
> by usbhid, but currently they are not refused and reside on hid bus.
> 
> Perform this checking earlier so that we refuse to control such
> a device early enough (and not pass it to the hid bus at all).
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

> +	for (n = 0; n < interface->desc.bNumEndpoints; n++)
> +		if (usb_endpoint_dir_in(&interface->endpoint[n].desc))
> +			has_in++;
> +	if (!has_in) {
> +		dev_err(&intf->dev, "couldn't find an input interrupt "
> +				"endpoint");
> +		return -ENODEV;
> +	}
> +

Do you want to use usb_endpoint_is_int_in() instead?  It matches the 
error message more closely.

Alan Stern

