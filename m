From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.19-rc4
Date: Sun, 18 Jan 2015 00:24:13 -0800
Message-ID: <20150118082413.GB15720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Dmitry Torokhov (2):
      MAINTAINERS: remove Dmitry Torokhov's alternate address
      Input: I8042 - add Acer Aspire 7738 to the nomux list

Gabriel Laskar (1):
      Input: uinput - fix ioctl nr overflow for UI_GET_SYSNAME/VERSION

Sam hung (1):
      Input: elantech - support new ICs types for version 4

Srihari Vijayaraghavan (1):
      Input: i8042 - reset keyboard to fix Elantech touchpad detection


Diffstat:
--------

 Documentation/kernel-parameters.txt   |  1 +
 MAINTAINERS                           |  1 -
 drivers/input/mouse/elantech.c        |  2 ++
 drivers/input/serio/i8042-x86ia64io.h | 39 +++++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042.c           | 14 +++++++++++++
 include/uapi/linux/uinput.h           |  4 ++--
 6 files changed, 58 insertions(+), 3 deletions(-)

-- 
Dmitry
