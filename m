From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 0/5] nput: mpr121 - switch to use device tree probe
Date: Sun, 15 Jan 2017 22:15:39 +0900
Message-ID: <1484486144-27947-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34134 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdAONQC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 15 Jan 2017 08:16:02 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>

This driver currently only supports legacy platform data probe.  This
change adds device tree support and gets rid of platform data probe code
since no one is actually using mpr121 platform data in the mainline.

This series also contains miscellaneous cleanup and bug fixes that
mostly I found while playing with this driver.

* Changes since v1 (All changes are suggested by Dmitry Torokhov)
- Add patch 'annotate PM methods as __maybe_unused'
- Use for_each_set_bit() to search changed bit
- Use linux,keycodes property instead of using matrix keymap API
- Get rid of platform data

Akinobu Mita (5):
  Input: mpr121 - annotate PM methods as __maybe_unused
  Input: mpr121 - remove unused field in struct mpr121_touchkey
  Input: mpr121 - set missing event capability
  Input: mpr121 - handle multiple bits change of status register
  Input: mpr121 - switch to device tree probe

 .../devicetree/bindings/input/mpr121-touchkey.txt  |  30 +++++
 drivers/input/keyboard/mpr121_touchkey.c           | 141 ++++++++++++++-------
 include/linux/i2c/mpr121_touchkey.h                |  20 ---
 3 files changed, 127 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey.txt
 delete mode 100644 include/linux/i2c/mpr121_touchkey.h

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>
-- 
2.7.4

