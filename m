From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.3-rc7
Date: Fri, 6 Sep 2019 15:48:27 -0700
Message-ID: <20190906224827.GA211076@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem - a tiny update from Benjamin
removing mistakenly added Elan PNP ID so that device is again handled by
hid-multitouch.

Changelog:
---------

Benjamin Tissoires (1):
      Input: elan_i2c - remove Lenovo Legion Y7000 PnpID

Diffstat:
--------

 include/linux/input/elan-i2c-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.


-- 
Dmitry
