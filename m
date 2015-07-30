From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.2-rc4
Date: Thu, 30 Jul 2015 10:38:07 -0700
Message-ID: <20150730173807.GD13165@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.com>, Henrik Rydberg <rydberg@bitmath.org>
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. The main change is support
for keyboards and touchpads found in 2015 editions of Macbooks.

Changelog:
---------

Dmitry Torokhov (1):
      Revert "Input: zforce - don't overwrite the stack"

Henrik Rydberg (2):
      Input: bcm5974 - prepare for a new trackpad generation
      HID: apple: Add support for the 2015 Macbook Pro

Jiri Kosina (1):
      Input: synaptics - dump ext10 capabilities as well

John Horan (1):
      Input: bcm5974 - add support for the 2015 Macbook Pro


Diffstat:
--------

 drivers/hid/hid-apple.c               |   6 ++
 drivers/hid/hid-core.c                |   6 ++
 drivers/hid/hid-ids.h                 |   3 +
 drivers/input/mouse/bcm5974.c         | 165 +++++++++++++++++++++++-----------
 drivers/input/mouse/synaptics.c       |   4 +-
 drivers/input/touchscreen/zforce_ts.c |   2 +-
 6 files changed, 130 insertions(+), 56 deletions(-)

-- 
Dmitry
