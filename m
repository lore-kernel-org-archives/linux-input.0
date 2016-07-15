From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.7-rc7
Date: Fri, 15 Jul 2016 14:57:04 -0700
Message-ID: <20160715215704.GG27847@dtor-ws>
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

to receive a few last-minute updates for the input subsystem.

Changelog:
---------

Andrew Duggan (1):
      Input: synaptics-rmi4 - use of_get_child_by_name() to fix refcount

Cameron Gutman (1):
      Input: xpad - validate USB endpoint count during probe

Dmitry Torokhov (1):
      Revert "Input: wacom_w8001 - drop use of ABS_MT_TOOL_TYPE"

Douglas Anderson (1):
      Input: add SW_PEN_INSERTED define

Peter Chen (1):
      Input: ts4800-ts - add missing of_node_put after calling of_parse_phandle


Diffstat:
--------

 drivers/input/joystick/xpad.c           |  3 +++
 drivers/input/rmi4/rmi_bus.c            |  4 ++--
 drivers/input/touchscreen/ts4800-ts.c   | 13 +++++++------
 drivers/input/touchscreen/wacom_w8001.c |  3 +++
 include/uapi/linux/input-event-codes.h  |  1 +
 5 files changed, 16 insertions(+), 8 deletions(-)
