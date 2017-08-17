From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 00/30] constify input serio_device_id
Date: Thu, 17 Aug 2017 17:08:01 +0530
Message-ID: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34914 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdHQLjU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 07:39:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

serio_device_id are not supposed to change at runtime. All functions
working with serio_device_id provided by <linux/serio.h> work with
const serio_device_id. So mark the non-const structs as const.

Arvind Yadav (30):
  [PATCH 01/30] Input: iforce: constify serio_device_id
  [PATCH 02/30] Input: magellan: constify serio_device_id
  [PATCH 03/30] Input: spaceball: constify serio_device_id
  [PATCH 04/30] Input: spaceorb: constify serio_device_id
  [PATCH 05/30] Input: stinger: constify serio_device_id
  [PATCH 06/30] Input: twidjoy: constify serio_device_id
  [PATCH 07/30] Input: warrior: constify serio_device_id
  [PATCH 08/30] Input: zhenhua: constify serio_device_id
  [PATCH 09/30] Input: iatkbd: constify serio_device_id
  [PATCH 10/30] Input: hil_kbd: constify serio_device_id
  [PATCH 11/30] Input: lkkbd: constify serio_device_id
  [PATCH 12/30] Input: newtonkbd: constify serio_device_id
  [PATCH 13/30] Input: stowaway: constify serio_device_id
  [PATCH 14/30] Input: sunkbd: constify serio_device_id
  [PATCH 15/30] Input: xtkbd: constify serio_device_id
  [PATCH 16/30] Input: serio: constify serio_device_id
  [PATCH 17/30] Input: wacom_serial4: constify serio_device_id
  [PATCH 18/30] Input: dynapro: constify serio_device_id
  [PATCH 19/30] Input: elo: constify serio_device_id
  [PATCH 20/30] Input: fujitsu_ts: constify serio_device_id
  [PATCH 21/30] Input: gunze: constify serio_device_id
  [PATCH 22/30] Input: hampshire: constify serio_device_id
  [PATCH 23/30] Input: inexio: constify serio_device_id
  [PATCH 24/30] Input: mtouch: constify serio_device_id
  [PATCH 25/30] Input: penmount: constify serio_device_id
  [PATCH 26/30] Input: touchit213: constify serio_device_id
  [PATCH 27/30] Input: touchright: constify serio_device_id
  [PATCH 28/30] Input: touchwin: constify serio_device_id
  [PATCH 29/30] Input: tsc40: constify serio_device_id
  [PATCH 30/30] Input: wacom_w8001: constify serio_device_id

 drivers/input/joystick/iforce/iforce-serio.c | 2 +-
 drivers/input/joystick/magellan.c            | 2 +-
 drivers/input/joystick/spaceball.c           | 2 +-
 drivers/input/joystick/spaceorb.c            | 2 +-
 drivers/input/joystick/stinger.c             | 2 +-
 drivers/input/joystick/twidjoy.c             | 2 +-
 drivers/input/joystick/warrior.c             | 2 +-
 drivers/input/joystick/zhenhua.c             | 2 +-
 drivers/input/keyboard/atkbd.c               | 2 +-
 drivers/input/keyboard/hil_kbd.c             | 2 +-
 drivers/input/keyboard/lkkbd.c               | 2 +-
 drivers/input/keyboard/newtonkbd.c           | 2 +-
 drivers/input/keyboard/stowaway.c            | 2 +-
 drivers/input/keyboard/sunkbd.c              | 2 +-
 drivers/input/keyboard/xtkbd.c               | 2 +-
 drivers/input/serio/serio_raw.c              | 2 +-
 drivers/input/tablet/wacom_serial4.c         | 2 +-
 drivers/input/touchscreen/dynapro.c          | 2 +-
 drivers/input/touchscreen/elo.c              | 2 +-
 drivers/input/touchscreen/fujitsu_ts.c       | 2 +-
 drivers/input/touchscreen/gunze.c            | 2 +-
 drivers/input/touchscreen/hampshire.c        | 2 +-
 drivers/input/touchscreen/inexio.c           | 2 +-
 drivers/input/touchscreen/mtouch.c           | 2 +-
 drivers/input/touchscreen/penmount.c         | 2 +-
 drivers/input/touchscreen/touchit213.c       | 2 +-
 drivers/input/touchscreen/touchright.c       | 2 +-
 drivers/input/touchscreen/touchwin.c         | 2 +-
 drivers/input/touchscreen/tsc40.c            | 2 +-
 drivers/input/touchscreen/wacom_w8001.c      | 2 +-
 30 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.7.4

