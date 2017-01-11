From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/5] Input: mpr121 - add device tree support
Date: Thu, 12 Jan 2017 02:42:24 +0900
Message-ID: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36478 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754752AbdAKRmr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 12:42:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>

This series attempts to add device tree support to mpr121 driver which
currently only supports legacy platform data probe.

The first three patches in this series are cleanup and bug fixes that
I found while playing with this driver.  The latter two patches are the
main part of this series.  We'll make use of matrix keypad helper API in
order to reduce code duplication between legacy platform data probe and
device tree probe.

Akinobu Mita (5):
  Input: mpr121 - remove unused field in struct mpr121_touchkey
  Input: mpr121 - set missing event capability
  Input: mpr121 - handle multiple bits change of status register
  Input: mpr121 - use matrix keypad helper API
  Input: mpr121 - add device tree support

 .../devicetree/bindings/input/mpr121-touchkey.txt  |  45 ++++++
 drivers/input/keyboard/Kconfig                     |   1 +
 drivers/input/keyboard/mpr121_touchkey.c           | 177 ++++++++++++++++-----
 3 files changed, 182 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey.txt

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>
-- 
2.7.4

