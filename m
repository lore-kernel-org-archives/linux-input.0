From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.0-rc4
Date: Fri, 3 Apr 2015 13:33:12 -0700
Message-ID: <20150403203312.GA28126@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem: there is a fix for ALPS
driver for issue introduced in the latest update and a tweak for yet
another Lenovo box in Synaptics.

There will be more ALPS tweaks coming...

Changelog:
---------

Charlie Mooney (1):
      Input: add MT_TOOL_PALM

Dmitry Torokhov (1):
      Input: ALPS - fix max coordinates for v5 and v7 protocols

Filip Ayazi (1):
      Input: synaptics - fix min-max quirk value for E440

Peter Hutterer (1):
      Input: define INPUT_PROP_ACCELEROMETER behavior

Ramiro Morales (1):
      Input: synaptics - add quirk for Thinkpad E440


Diffstat:
--------

 Documentation/input/event-codes.txt          |  6 ++++++
 Documentation/input/multi-touch-protocol.txt |  9 ++++++---
 drivers/input/mouse/alps.c                   | 11 ++++++-----
 drivers/input/mouse/synaptics.c              |  7 ++++++-
 include/uapi/linux/input.h                   |  3 ++-
 5 files changed, 26 insertions(+), 10 deletions(-)

-- 
Dmitry
