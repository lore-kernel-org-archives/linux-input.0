From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 14/27] HID: wacom: EKR: add a worker to add/remove
 resources on addition/removal (fwd)
Date: Thu, 7 Jul 2016 06:53:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1607070652110.3227@hadrien>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:45398
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750867AbcGGEx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Jul 2016 00:53:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The lack of unlock looks suspicious, although I haven't studied the
complete context.  Also, is 0 correct as a return value in an error case?

julia

---------- Forwarded message ----------
Date: Wed, 6 Jul 2016 00:27:34 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 14/27] HID: wacom: EKR: add a worker to add/remove resources
     on addition/removal

CC: kbuild-all@01.org
In-Reply-To: <1467729563-23318-15-git-send-email-benjamin.tissoires@redhat.com>
TO: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
CC: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

[auto build test WARNING on hid/for-next]
[also build test WARNING on v4.7-rc6 next-20160705]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/HID-wacom-cleanup-EKR-LED/20160705-225431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-next
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

>> drivers/hid/wacom_wac.c:851:2-8: preceding lock on line 846

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout cbd7a16fa28311673663974b9edc48bd00d83815
vim +851 drivers/hid/wacom_wac.c

72b236d6 Aaron Skomra       2015-08-20  840  		bool connected = data[j+2];
72b236d6 Aaron Skomra       2015-08-20  841
cbd7a16f Benjamin Tissoires 2016-07-05  842  		remote_data.remote[i].serial = serial;
cbd7a16f Benjamin Tissoires 2016-07-05  843  		remote_data.remote[i].connected = connected;
72b236d6 Aaron Skomra       2015-08-20  844  	}
72b236d6 Aaron Skomra       2015-08-20  845
cbd7a16f Benjamin Tissoires 2016-07-05 @846  	spin_lock_irqsave(&wacom->remote_lock, flags);
72b236d6 Aaron Skomra       2015-08-20  847
cbd7a16f Benjamin Tissoires 2016-07-05  848  	ret = kfifo_in(&wacom->remote_fifo, &remote_data, sizeof(remote_data));
cbd7a16f Benjamin Tissoires 2016-07-05  849  	if (ret != sizeof(remote_data)) {
cbd7a16f Benjamin Tissoires 2016-07-05  850  		hid_err(wacom->hdev, "Can't queue Remote status event.\n");
cbd7a16f Benjamin Tissoires 2016-07-05 @851  		return 0;
72b236d6 Aaron Skomra       2015-08-20  852  	}
72b236d6 Aaron Skomra       2015-08-20  853
cbd7a16f Benjamin Tissoires 2016-07-05  854  	spin_unlock_irqrestore(&wacom->remote_lock, flags);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
