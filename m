From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.2-rc5
Date: Sun, 9 Aug 2015 00:32:15 -0700
Message-ID: <20150809073215.GA32984@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33381 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482AbbHIHcT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Aug 2015 03:32:19 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just small ALPS and Elan
touchpads, and other driver fixups.

Changelog:
---------

Chen-Yu Tsai (1):
      Input: axp20x-pek - add module alias

Dmitry Torokhov (1):
      Input: turbografx - fix potential out of bound access

Duson Lin (1):
      Input: elantech - add special check for fw_version 0x470f01 touchpad

Hans de Goede (1):
      Input: alps - only Dell laptops have separate button bits for v2 dualpoint sticks

Marek Belisko (1):
      Input: twl4030-vibra - fix ERROR: Bad of_node_put() warning


Diffstat:
--------

 Documentation/input/alps.txt        |  6 ++++--
 drivers/input/joystick/turbografx.c |  2 +-
 drivers/input/misc/axp20x-pek.c     |  1 +
 drivers/input/misc/twl4030-vibra.c  |  3 ++-
 drivers/input/mouse/alps.c          |  8 ++++++--
 drivers/input/mouse/elantech.c      | 22 ++++++++++++++++++++--
 drivers/input/mouse/elantech.h      |  1 +
 7 files changed, 35 insertions(+), 8 deletions(-)

-- 
Dmitry

