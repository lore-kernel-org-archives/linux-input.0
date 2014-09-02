From: Dylan Alex Simon <dylan-kernel@dylex.net>
Subject: hid-thingm: kernel panic on remove
Date: Tue, 2 Sep 2014 13:46:59 -0400
Message-ID: <20140902174659.GA1811@datura.dylex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from datura.dylex.net ([66.114.66.16]:54348 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbaIBSM5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 14:12:57 -0400
Received: from dylan by datura.dylex.net with local (Exim 4.82)
	(envelope-from <dylan-kernel@dylex.net>)
	id 1XOsAV-0000TU-HZ
	for linux-input@vger.kernel.org; Tue, 02 Sep 2014 13:46:59 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Whenever either disconnecting the USB device or simply rmmod'ing the module
(even when not in use), I get a kernel panic.  I haven't managed to capture a
backtrace, but at least the first two lines were saved after an rmmod:

18:53:17 kernel: thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
<snip, rmmod hid-thingm:>
08:38:42 kernel: BUG: unable to handle kernel paging request at fffffffb8a80aaf8
08:38:42 kernel: IP: [<ffffffff8106e30c>] osq_lock+0x3c/0x110

Let me know if you'd like me to try to capture more info, but this problem
seems very reproducible (at least with a mk2 device; I never had the problem on
older kernels with a mk1).  I do direct write()s to the hidraw device, but
don't otherwise use the driver while it's loaded.

Also at https://bugzilla.kernel.org/show_bug.cgi?id=83751
