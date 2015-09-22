From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 22 Sep 2015 14:05:19 +0200
Message-ID: <1442923519.6240.6.camel@suse.com>
References: <Pine.LNX.4.44L0.1509211552310.1713-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49106 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbbIVMGt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2015 08:06:49 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509211552310.1713-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Mon, 2015-09-21 at 16:02 -0400, Alan Stern wrote:
> On Mon, 21 Sep 2015, Dmitry Torokhov wrote:
> 
> > > What happens if the "inhibit" control is turned on and the driver puts 
> > > the device into runtime suspend, but then an I/O request arrives?
> > > 
> > > 	If the I/O request originated from userspace, it means the
> > > 	user is violating the terms of the "inhibit" control.  Should
> > > 	the request simply fail?
> > 
> > What user? User that inhibited it or user that tried to use the device?
> 
> Normally they would be the same.  But even if they aren't, someone has 
> violated the kernel interface: The first user told the kernel a 
> particular device wasn't going to be used, and then the second user 
> tried to use it.

If we assume that user space speaks with a uniform voice on that
issue, it can just as well close the device. It seems to me that
declaring a device idle is a privileged operation.

> Of course, this issue doesn't arise for devices that merely report 
> external events.

Indeed. We can handle output to suspended devices by waking them.
I don't see why this case is different. We are talking about input
only.

> The runtime-PM "usage" value for these devices is a little tricky to 
> calculate.  It should be nonzero if there are any open files _and_ the 
> device isn't "inhibited".  I don't know the best way to represent that 
> kind of condition in the runtime PM framework.

Does that make sense in the generic framework at all? I still
think that drivers should cease IO for input in such cases.
That should involve a common callback, but no counter.

	Regards
		Oliver



