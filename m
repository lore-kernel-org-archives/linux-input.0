From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb mouse not responding after resume
Date: Fri, 10 Jul 2009 16:32:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907101628550.4183-100000@iolanthe.rowland.org>
References: <12e16730907101254s12cdb3aam5fa87044938f2080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48554 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755424AbZGJUcw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2009 16:32:52 -0400
In-Reply-To: <12e16730907101254s12cdb3aam5fa87044938f2080@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: K R I S K <kdbbox@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 10 Jul 2009, K R I S K wrote:

> Thanks Allan.
> 
> We need to look into the console messages of the bootloader rather than
> dmesg's.

What bootloader?  What's the connection between booting and 
suspend/resume?

> the second USB - mouse may not be resumed or initialized
> 
> solution one:
> 
> The resistor value may have to be changed ; for example in PPC the following
> resistor values would release the reset to PPC
> 1. No install R670
> 2. Install R776

We're talking about a T60 notebook.  It doesn't use a PPC.

> Second Solution:
> 
> The USB devices can be re-initialized after suspend or when resuming
> by issuing the following sequence of commands: USB_STOP(),
> DELAY(),USB_INIT()
> in the bootloader's board specific file with in conditional High speed and
> Lowspeed flags for USB.

What bootloader?  What board-specific file?

Besides, it won't help.  The log shows that the kernel did reset the 
USB controller.

Alan Stern

