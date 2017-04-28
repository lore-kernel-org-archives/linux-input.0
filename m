From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.11-rc7
Date: Fri, 28 Apr 2017 10:58:47 -0700
Message-ID: <20170428175847.GF4949@dtor-ws>
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

to receive updates for the input subsystem. Yet another quirk to i8042
to get touchpad recognized on some laptops.

Changelog:
---------

Dmitry Torokhov (1):
      Input: i8042 - add Clevo P650RS to the i8042 reset list


Diffstat:
--------

 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
Dmitry
