From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB keyboard recognized as HID keyboard but doesn't work
Date: Mon, 2 May 2011 16:27:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1105021622510.2106-100000@iolanthe.rowland.org>
References: <4DBF077B.8080903@sieker.io>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50515 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752990Ab1EBU13 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 May 2011 16:27:29 -0400
In-Reply-To: <4DBF077B.8080903@sieker.io>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Adi J. Sieker" <adi@sieker.io>
Cc: Oliver Neukum <oliver@neukum.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2 May 2011, Adi J. Sieker wrote:

> > Something else that might help is a usbmon trace showing what happens
> > when you plug in the keyboard.  Instructions are in the kernel source
> > file Documentation/usb/usbmon.txt.  In particular, while running the
> > test try pressing some of the normal keys that don't work.
> >
> 
> The attached file usbmon-working.out is the output when I pressed the 
> backspace key. When I press any of the non working keys which is 
> everything but the backspace and menu key. I don't get any output even 
> when using 0u.

Sorry, I wasn't clear enough.  I meant for you to start the usbmon
trace _before_ plugging in the keyboard, so we can see what happens as
the keyboard is initialized and probed.

> > Also, it would help to see the output from "lsusb -v" for this device
> > -- but you'll have to unbind it from the usbhid driver first.
> >
> 
> When attaching the keyboard I get 2 devices in
> /sys/bus/usb/drivers/usbhid/2-1.1:1.0  and
> /sys/bus/usb/drivers/usbhid/2-1.1:1.1
> 
> The output is in the attached lsusb.txt.

The output looks good.  It doesn't mean much to me, but the people on 
the linux-input mailing list should be able to get something out of it.

Alan Stern

