From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.9-rc3
Date: Wed, 30 Nov 2016 17:51:46 -0800
Message-ID: <20161201015146.GF31934@dtor-ws>
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

to receive updates for the input subsystem. We are disabling automatic
probing of BYD touchpads as it results in too many false positives, and
the hardware is not terribly popular and having the protocol support
does not result in significantly improved user experience.

We also change keycode for KEY_DATA to avoid clashing with
KEY_FASTREVERSE. Luckily this newish code is used by CEC framework that
is still in staging, so it is extremely unlikely that someone has
already started using this keycode.

Changelog:
---------

Dmitry Torokhov (1):
      Input: psmouse - disable automatic probing of BYD touchpads

Ping Cheng (1):
      Input: change KEY_DATA from 0x275 to 0x277


Diffstat:
--------

 drivers/input/mouse/psmouse-base.c     | 4 ----
 include/uapi/linux/input-event-codes.h | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
Dmitry
