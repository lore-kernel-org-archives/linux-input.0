From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Mon, 29 Jun 2015 11:48:12 +0200
Message-ID: <1435571292.1805.4.camel@suse.com>
References: <20150626221517.GB2761@kroah.com>
	 <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>
	 <20150627012959.GA15207@kroah.com>
	 <alpine.LNX.2.00.1506270825010.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41773 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbbF2JtP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 05:49:15 -0400
In-Reply-To: <alpine.LNX.2.00.1506270825010.10183@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Tom Gundersen <teg@jklm.no>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2015-06-27 at 08:29 +0200, Jiri Kosina wrote:
> On Fri, 26 Jun 2015, Greg Kroah-Hartman wrote:

> Last time we were testing this, autosuspend for USB HID devices was quite 
> a disaster.
> 
> Do you have any idea whether udev developers tested the "autosuspend on by 
> default for USB HID devices" on reasonable set of devices?
> 
> The culrpits that I remember from top of my head (it's been long time 
> ago):
> 
> - the LEDs for suspended device go off. This is very confusing at least on 
>   keyboards, and brings really bad user experience

That is a bug. hidinput_count_leds() is supposed to prevent that.
What did you test?

> - many keyboards were losing first keystroke when waking up from suspend. 
>   We've been debugging this with Alan, and never root-caused it to a 
>   problem in our code, it seems to be the property of the HW

- mice don't wake up from movement alone.

And again I would state that we don't get enough information
from user space. Hardware seems to be designed for sleeping
while a screen saver is on. In kernel space we just get a binary
input desired or not desired from open/close.
That is insufficient.

	Regards
		Oliver



