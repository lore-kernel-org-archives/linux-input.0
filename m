From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c-hid: remove mostly useless parameter 'debug'
Date: Tue, 06 Aug 2013 11:02:33 +0300
Message-ID: <1375776153.403.15.camel@smile>
References: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>
	   <1375441636-12921-2-git-send-email-andriy.shevchenko@linux.intel.com>
	   <CAN+gG=Ec=jJy7HxRW08up+=Z8C0Lz4B8bhPcP+7__zuONnCAgw@mail.gmail.com>
	  <1375454987.31118.77.camel@smile> <51FBF71E.1040802@redhat.com>
	 <1375468274.31118.87.camel@smile> <51FBFDA0.4010205@redhat.com>
	 <alpine.LNX.2.00.1308051124240.17512@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab3HFICp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Aug 2013 04:02:45 -0400
In-Reply-To: <alpine.LNX.2.00.1308051124240.17512@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Mon, 2013-08-05 at 11:26 +0200, Jiri Kosina wrote: 
> On Fri, 2 Aug 2013, Benjamin Tissoires wrote:
> 
> > > With only one condition if dynamic debug is enabled in kernel.
> > > So, it would be nice to gather opinions, however, the decision is
> > > totally depends on type of user who wants to debug the module.
> > > 
> > Yep, I agree that Jiri's opinion would be helpful.
> > 
> > Meanwhile, we could also wait a little for more i2c-hid to hit the
> > market and to be widely tested, and then remove the debug flag. We
> > should also remove the debug events in get_i2c_hid_get_input() which
> > would pollute systems without dynamic debugging but with the DEBUG
> > config still enabled.
> 
> Well, it doesn't seem to make too much sense to me to have generic/bus use 
> hid_dbg() (although it's used very rarely) and a "sub-driver" use 
> something else.
> 
> Basically the options I see:
> 
> - keep i2c-hid as is
> - convert the whole drivers/hid to dev_dbg()
> - introduce another hid debugfs file in parallel to rdesc and events for 
>   these types of messages

Debugfs could be off in the kernel configuration. Whatever we choose
there will be a kernel that has a disabled option which prevents to
debug: either debugging is turned off, or driver itself.


There is another possibility as well:
instead of dev_dbg() we may add trace points and subscribe to them from
userspace via perf, for example.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
