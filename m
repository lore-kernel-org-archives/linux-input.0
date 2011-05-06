From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: USB keyboard recognized as HID keyboard but doesn't work
Date: Fri, 6 May 2011 14:58:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105061456320.28291@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1105030945410.2085-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60809 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872Ab1EFM6R (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 May 2011 08:58:17 -0400
In-Reply-To: <Pine.LNX.4.44L0.1105030945410.2085-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Adi J. Sieker" <adi@sieker.io>
Cc: Oliver Neukum <oliver@neukum.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Tue, 3 May 2011, Alan Stern wrote:

> > Do you know of a way for me to tell the kernel/usbhid to use interface 1 
> > and ignore interface 0?
> 
> Well, you can always unbind interface 0 from usbhid -- it corresponds
> to the 2-1.1:1.0 file in /sys/bus/usb/drivers/usbhid/.  If you do that,
> you'll probably find the few keys which _do_ currently work suddenly
> stop working.
> 
> But there's nothing to be done immediately about interface 1; usbhid is
> _already_ using it.  It just isn't using it correctly.

Adi,

could you please provide output of

	cat /syse/kernel/debug/hid/<keyboard>/rdesc

anytime after the keyboard has been plugged, and

	cat /syse/kernel/debug/hid/<keyboard>/events

from the time you press any of the working and non-working keys? (both 
cases will be interesting).

Oh, and the above assumes that you have debugfs mounted under 
/sys/kernel/debug.

Thanks,

-- 
Jiri Kosina
SUSE Labs
