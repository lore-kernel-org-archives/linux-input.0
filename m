From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [v3.11][Regression] HID: hyperv: convert alloc+memcpy to memdup
Date: Mon, 16 Sep 2013 13:42:35 -0400
Message-ID: <5237430B.5040009@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: thomas@m3y3r.de, Jiri Kosina <jkosina@suse.cz>
Cc: list@osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, open@osuosl.org, HID CORE LAYER <linux-input@vger.kernel.org>, devel@linuxdriverproject.org
List-Id: linux-input@vger.kernel.org

Hi Thomas,

A bug was opened against the Ubuntu kernel[0].  After a kernel bisect,
it was found that reverting the following commit resolved
this bug:

commit a4a23f6d68ad2c86ee8df6a6f89c9d315c0a761c
Author: Thomas Meyer <thomas@m3y3r.de>
Date:   Sat Jun 1 11:40:31 2013 +0200

    HID: hyperv: convert alloc+memcpy to memdup


The regression was introduced as of v3.11-rc1.  The bug causes a system
to lockup when connecting a bluetooth trackpad and has been reported on
multiple machines. 

I wanted to ping you since you are the author of this patch.  I was
thinking of requesting a revert for v3.12 and v3.11, but I wanted to get
your feedback first.

Reverting the patch changes the driver back to useing kzalloc() and
memcpy() instead of  kmemdup.  Doing so has uncovered another bug, which
causes an oops on memcpy()[1].  We are in the process of bisecting that
one now and will provide the results.


Thanks,

Joe

[0] pad.lv/1218004
[1]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1218004/+attachment/3818671/+files/kern.log
