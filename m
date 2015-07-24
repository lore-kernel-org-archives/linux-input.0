From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.2-rc3
Date: Fri, 24 Jul 2015 14:43:20 -0700
Message-ID: <20150724214320.GE33241@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33610 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbGXVnY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 17:43:24 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a fix for the
warnings/oops when handling HID devices with "unnamed" LEDs and couple
of other driver fixups.

Changelog:
---------

Bastien Nocera (1):
      Input: goodix - fix touch coordinates on WinBook TW100 and TW700

Bernhard Bender (1):
      Input: usbtouchscreen - avoid unresponsive TSC-30 touch screen

Dmitry Torokhov (1):
      Input: LEDs - skip unnamed LEDs

Oleksij Rempel (1):
      Input: zforce - don't overwrite the stack

Peter Hutterer (1):
      Input: elantech - force resolution of 31 u/mm


Diffstat:
--------

 drivers/input/input-leds.c                 | 16 +++++++++++--
 drivers/input/mouse/elantech.c             | 13 ++++++-----
 drivers/input/touchscreen/goodix.c         | 36 ++++++++++++++++++++++++++++++
 drivers/input/touchscreen/usbtouchscreen.c |  3 +++
 drivers/input/touchscreen/zforce_ts.c      |  2 +-
 5 files changed, 62 insertions(+), 8 deletions(-)

-- 
Dmitry

