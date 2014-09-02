From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid-thingm: kernel panic on remove
Date: Tue, 2 Sep 2014 23:32:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz>
References: <20140902174659.GA1811@datura.dylex.net> <54062150.2010800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50824 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbaIBVcb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 17:32:31 -0400
In-Reply-To: <54062150.2010800@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dylan Alex Simon <dylan-kernel@dylex.net>, linux-input@vger.kernel.org

On Tue, 2 Sep 2014, Benjamin Tissoires wrote:

> > Whenever either disconnecting the USB device or simply rmmod'ing the module
> > (even when not in use), I get a kernel panic.  I haven't managed to capture a
> > backtrace, but at least the first two lines were saved after an rmmod:
> > 
> > 18:53:17 kernel: thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
> > <snip, rmmod hid-thingm:>
> > 08:38:42 kernel: BUG: unable to handle kernel paging request at fffffffb8a80aaf8
> > 08:38:42 kernel: IP: [<ffffffff8106e30c>] osq_lock+0x3c/0x110

Hmm, so the only lock that is taken in thingm driver itself is 
rgb->tdev->lock, which is thingm_device->lock, properly initialized in 
_probe().

So my first thought was that the work is not cancelled properly, causing 
use-after-free on the lock with the workqueue firing at the time the 
drvier has cleaned up everything, but that doesn't seem to be the case, as 
thingm_remove() -> thingm_remove_rgb() seems to be doing the right thing.

Dylan, is there any chance for you to capture more complete backtrace from 
the oops? serial console, netconsole, anything?

Thanks,

-- 
Jiri Kosina
SUSE Labs
