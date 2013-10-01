From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: possible conflict between xhci_hcd and a patched usbhid?
Date: Tue, 1 Oct 2013 10:44:43 -0700
Message-ID: <20131001174443.GC7818@xanatos>
References: <CALcQQ34PZDQsWr8QDn0NvjpJ0gO9+xjHdcZgSuTtdSsDP=sROw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19552 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab3JARon (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Oct 2013 13:44:43 -0400
Content-Disposition: inline
In-Reply-To: <CALcQQ34PZDQsWr8QDn0NvjpJ0gO9+xjHdcZgSuTtdSsDP=sROw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cristobal Navarro <axischire@gmail.com>
Cc: linux-usb@vger.kernel.org, Xenia Ragiadakou <burzalodowa@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org

On Mon, Sep 30, 2013 at 11:19:56AM -0400, Cristobal Navarro wrote:
> Dear Sarah,
> 
> Maybe you can help us. We, Razer Blade laptop users are having a weird
> problem when patching the usbhid module and using the xhci_hcd module at
> the same time.
> 
> Razer Blade Laptop users running linux need to fix the polling rate
> interval of the usbhid module, to be 1000Hz in order for the laptop's
> keyboard to work properly (it is a high performance keyboard). That is to
> hardcode a line in drivers/hid/usbhid/hid-core.c to be "interval = 1;",
> around line 1134 of hid-core.c

Can you send me the output of `sudo lsusb -v`?  The USB HID driver
should be creating a quirk for this device, rather than having users
hard-code the interval value for all USB HID devices.

> The problem is that if i also include the xhci_hcd module in the kernel,
> then the fix at usbhid no longer works and the keyboard works faultly. So
> at the moment, i have to remove hxci_hcd and loose USB 3.0 support i guess.

Yep, hard coding the interval won't help when the device is under xHCI.
The xHCI driver looks at the endpoint descriptors, not the URB interval,
when it sets up the poll rate.  Changing the URB interval will have no
impact on when transfers actually get scheduled.  The EHCI driver will
respect the interval in the URB, which is why it works under EHCI.

This has been a known issue for quite some time.  What we need is new
API to allow drivers to request a different interval than the one in the
endpoint descriptors.  That's not a simple fix, and I don't think it's
going to happen any time soon.  Maybe it's something Xenia could look
into?

> Do you know what could be the cause of the problem? how could we fix it?
> Does xhci_hcd module take over the laptop's keyboard instead of usbhid??
> 
> many thanks in advance, i appreciatte all the work you have done on USB 3.0.
> Best regards,
> 
> Cristobal A. Navarro

Sarah Sharp
