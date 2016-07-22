From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.7-rc7 (part 2)
Date: Fri, 22 Jul 2016 16:35:38 -0700
Message-ID: <20160722233538.GE5036@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35074 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGVXfl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2016 19:35:41 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive  a few more fixes for the input subsystem:

- restore naming for tsc2005 touchscreens as some userspace match on it
- fix out of bound access in legacy keyboard driver
- fixup in RMI4 driver

Everything is tagged for stable as well.

Changelog:
---------

Andrew Duggan (1):
      Input: synaptics-rmi4 - fix maximum size check for F12 control register 8

Dmitry Torokhov (1):
      tty/vt/keyboard: fix OOB access in do_compute_shiftstate()

Michael Welling (1):
      Input: tsc200x - report proper input_dev name


Diffstat:
--------

 drivers/input/rmi4/rmi_f12.c             |  9 +++++----
 drivers/input/touchscreen/tsc2004.c      |  7 ++++++-
 drivers/input/touchscreen/tsc2005.c      |  7 ++++++-
 drivers/input/touchscreen/tsc200x-core.c | 15 ++++++++++++---
 drivers/input/touchscreen/tsc200x-core.h |  2 +-
 drivers/tty/vt/keyboard.c                | 30 +++++++++---------------------
 6 files changed, 39 insertions(+), 31 deletions(-)

