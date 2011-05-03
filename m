From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB keyboard recognized as HID keyboard but doesn't work
Date: Tue, 3 May 2011 09:49:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1105030945410.2085-100000@iolanthe.rowland.org>
References: <4DBFCD88.6020900@sieker.io>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47572 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751928Ab1ECNtN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 09:49:13 -0400
In-Reply-To: <4DBFCD88.6020900@sieker.io>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Adi J. Sieker" <adi@sieker.io>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Tue, 3 May 2011, Adi J. Sieker wrote:

> Do you know of a way for me to tell the kernel/usbhid to use interface 1 
> and ignore interface 0?

Well, you can always unbind interface 0 from usbhid -- it corresponds
to the 2-1.1:1.0 file in /sys/bus/usb/drivers/usbhid/.  If you do that,
you'll probably find the few keys which _do_ currently work suddenly
stop working.

But there's nothing to be done immediately about interface 1; usbhid is
_already_ using it.  It just isn't using it correctly.

Alan Stern

