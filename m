From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.6-rc4
Date: Fri, 22 Apr 2016 17:23:19 -0700
Message-ID: <20160423002319.GA38622@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34211 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbcDWAXX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Apr 2016 20:23:23 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just minor driver fixes.

Changelog:
---------

Charles Keepax (1):
      Input: arizona-haptic - don't assign input_dev parent

Dmitry Torokhov (2):
      Input: twl6040-vibra - do not reparent to grandparent
      Input: twl4030-vibra - do not reparent to grandparent

H. Nikolaus Schaller (2):
      Input: twl6040-vibra - fix NULL pointer dereference by removing workqueue
      Input: twl6040-vibra - ignore return value of schedule_work

Peter Hutterer (1):
      Input: clarify we want BTN_TOOL_<name> on proximity

Silvan Jegen (1):
      Input: xpad - add Mad Catz FightStick TE 2 VID/PID

Stephen Boyd (1):
      Input: pmic8xxx-pwrkey - fix algorithm for converting trigger delay

Vladis Dronov (1):
      Input: gtco - fix crash on detecting device without endpoints


Diffstat:
--------

 Documentation/input/event-codes.txt  |  4 ++++
 drivers/input/joystick/xpad.c        |  2 ++
 drivers/input/misc/arizona-haptics.c |  1 -
 drivers/input/misc/pmic8xxx-pwrkey.c |  7 ++++---
 drivers/input/misc/twl4030-vibra.c   |  1 -
 drivers/input/misc/twl6040-vibra.c   |  8 +-------
 drivers/input/tablet/gtco.c          | 10 +++++++++-
 7 files changed, 20 insertions(+), 13 deletions(-)

-- 
Dmitry

