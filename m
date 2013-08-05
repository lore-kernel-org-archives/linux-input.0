From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] i2c-hid: remove mostly useless parameter 'debug'
Date: Mon, 5 Aug 2013 11:26:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308051124240.17512@pobox.suse.cz>
References: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>   <1375441636-12921-2-git-send-email-andriy.shevchenko@linux.intel.com>   <CAN+gG=Ec=jJy7HxRW08up+=Z8C0Lz4B8bhPcP+7__zuONnCAgw@mail.gmail.com>  <1375454987.31118.77.camel@smile>
 <51FBF71E.1040802@redhat.com> <1375468274.31118.87.camel@smile> <51FBFDA0.4010205@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45372 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab3HEJ0c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Aug 2013 05:26:32 -0400
In-Reply-To: <51FBFDA0.4010205@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, 2 Aug 2013, Benjamin Tissoires wrote:

> > With only one condition if dynamic debug is enabled in kernel.
> > So, it would be nice to gather opinions, however, the decision is
> > totally depends on type of user who wants to debug the module.
> > 
> Yep, I agree that Jiri's opinion would be helpful.
> 
> Meanwhile, we could also wait a little for more i2c-hid to hit the
> market and to be widely tested, and then remove the debug flag. We
> should also remove the debug events in get_i2c_hid_get_input() which
> would pollute systems without dynamic debugging but with the DEBUG
> config still enabled.

Well, it doesn't seem to make too much sense to me to have generic/bus use 
hid_dbg() (although it's used very rarely) and a "sub-driver" use 
something else.

Basically the options I see:

- keep i2c-hid as is
- convert the whole drivers/hid to dev_dbg()
- introduce another hid debugfs file in parallel to rdesc and events for 
  these types of messages

-- 
Jiri Kosina
SUSE Labs
