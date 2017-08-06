From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/8] constify input usb_device_id.
Date: Sun,  6 Aug 2017 13:11:19 +0530
Message-ID: <1502005287-17705-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32816 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdHFHlo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 6 Aug 2017 03:41:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Fix checkpatch.pl error in patch 1,3 and 7:
ERROR: space prohibited before open square bracket '['.

Arvind Yadav (8):
  [PATCH 1/8] Input: iforce: constify usb_device_id and fix space before '[' error.
  [PATCH 2/8] Input: xpad: constify usb_device_id.
  [PATCH 3/8] Input: keyspan_remote: constify usb_device_id.
  [PATCH 4/8] Input: powermate: constify usb_device_id and fix space before '[' error.
  [PATCH 5/8] Input: appletouch: constify usb_device_id.
  [PATCH 6/8] Input: synaptics_usb: constify usb_device_id.
  [PATCH 7/8] Input: acecad: constify usb_device_id and fix space before '[' error.
  [PATCH 8/8] Input: kbtab: constify usb_device_id.

 drivers/input/joystick/iforce/iforce-usb.c | 2 +-
 drivers/input/joystick/xpad.c              | 2 +-
 drivers/input/misc/keyspan_remote.c        | 2 +-
 drivers/input/misc/powermate.c             | 2 +-
 drivers/input/mouse/appletouch.c           | 2 +-
 drivers/input/mouse/synaptics_usb.c        | 2 +-
 drivers/input/tablet/acecad.c              | 2 +-
 drivers/input/tablet/kbtab.c               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4

