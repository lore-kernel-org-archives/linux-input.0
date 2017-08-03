From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/4] constify hid attribute_group structures.
Date: Thu,  3 Aug 2017 16:56:42 +0530
Message-ID: <1501759603-18121-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33281 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdHCL1D (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Aug 2017 07:27:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work with
const attribute_group. So mark the non-const structs as const.

Arvind Yadav (5):
  [PATCH 1/4] HID: multitouch: constify attribute_group structures.
  [PATCH 2/4] HID: sensor: constify attribute_group structures.
  [PATCH 3/4] HID: logitech-hidpp: constify attribute_group structures.
  [PATCH 4/4] HID: ntrig: constify attribute_group structures.

 drivers/hid/hid-logitech-hidpp.c |  2 +-
 drivers/hid/hid-multitouch.c     |  2 +-
 drivers/hid/hid-ntrig.c          |  2 +-
 drivers/hid/hid-sensor-custom.c  |  2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1

