From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Wed, 10 Jun 2009 00:22:18 +0100
Message-ID: <1244589738.5973.1954.camel@cookie.hadess.net>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:43032 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbZFIXWV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Jun 2009 19:22:21 -0400
In-Reply-To: <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-bluetooth@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

On Mon, 2009-06-08 at 15:33 +0200, Jiri Kosina wrote:
> On Sun, 7 Jun 2009, Bastien Nocera wrote:
> 
> > I just got an Apple Bluetooth Mighty Mouse, and was wondering whether 
> > anyone had information on how to get the battery level from the device 
> > (the keyboard apparently also allows that): 
> > http://support.apple.com/kb/TA27118?viewlocale=en_US
> > 
> > Anyone with an idea? An unparsed HID event? Does it need "poking"?
> 
> If the mouse is standard-compliant, it should be sending the battery level 
> strength in usage 0x20 of device controls page (0x06).
> 
> Could you please obtain HID debug dump (CONFIG_HID_DEBUG + modprobe hid 
> module with 'debug=2')

I found that for pretty much all the input problems, I'd need to do
something like that. Problem is:
- enabling CONFIG_HID_DEBUG requires rebuilding the kernel
- most distributions build hid into the kernel

Wouldn't there be a way to enable the debug at run-time without
impacting too much on performance or binary size?

>  and look at this usage both in the report 
> descriptor itself, and also check whether it is present in the received 
> reports?

I'll look at it when I get an occasion to rebuild a kernel (which
thankfully isn't very often these days).

Cheers

