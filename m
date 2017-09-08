From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RH Bugzilla - Bug 1482649 - Logitech USB Unified Receiver+M570
 need 'waking' up by click after kernel update
Date: Fri, 8 Sep 2017 16:35:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709081626560.2330-100000@iolanthe.rowland.org>
References: <nycvar.YFH.7.76.1709081304520.3285@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33034 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1756914AbdIHUfG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Sep 2017 16:35:06 -0400
In-Reply-To: <nycvar.YFH.7.76.1709081304520.3285@jbgna.fhfr.qr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Mike Simms <micsim2007@outlook.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Fri, 8 Sep 2017, Jiri Kosina wrote:

> On Fri, 8 Sep 2017, Mike Simms wrote:
> 
> > Thanks for getting back to me,
> > 
> > 4.11.11-300.fc26.x86_64 and 4.12.9-300.fc26.x86_64
> >  are showing identical settings - autosuspend definitely on for
> > device /sys/bus/usb/devices/2-1.3/2-1.3:1.0/0003:046D:C52B.0001/power
> > 
> > it shows in the powertop UI as good for both kernels and
> > 
> > Folder contents are autosuspend_delay_ms (can't open), control (auto),
> > runtime_active_time (0), runtime_status (unsupported),

The "unsupported" means that runtime suspend is disabled.  (Don't ask 
me why it doesn't say "disabled" instead.)  That is suspicious in 
itself.  Drivers don't normally disable runtime suspend for more than 
very short time intervals.

Does the runtime_status file really say "unsupported" in both kernels?

> > runtime_suspended_time (0)
> 
> Alright, that means that both kernels are allowed to autosuspend the 
> device, but apparently only 4.12 actually does so. Could you please 
> confirm that with usbmon traces?

In addition to usbmon traces, it would be good to look at the settings 
under /sys/bus/usb/devices/2-1.3/2-1.3:1.0/power/.  It's unlikely that 
they have changed between 4.11 and 4.12, but it doesn't hurt to check.

Alan Stern

