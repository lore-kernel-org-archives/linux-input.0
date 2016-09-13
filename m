From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH] hid: Misc tablet fixes and improvements
Date: Tue, 13 Sep 2016 17:08:34 +0300
Message-ID: <20160913140843.25567-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36243 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbcIMOJJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:09:09 -0400
Received: by mail-wm0-f52.google.com with SMTP id b187so188721668wme.1
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 07:09:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

Hi Jiri, Benjamin,

Here is a bunch of patches syncing the DIGImend out-of-tree drivers package
with upstream. There are some minor fixes, some tablets being supported, and
addition of generic frame button support for UC-Logic tablets by Benjamin.

Thanks!

Nick

Benjamin Tissoires (1):
      HID: uclogic: Switch to reporting abstract button events

Nikolai Kondrashov (8):
      HID: Remove broken links to tablet descriptions
      HID: kye: Rename MousePen i608X v2 macro
      HID: kye: Fix MousePen i608X v2 report descriptor
      HID: uclogic: Remove allocation failure messages
      HID: uclogic: Add support for several more tablets
      HID: uclogic: Support UGTizer GP0610 partially
      HID: uclogic: Override constant descriptors
      HID: uclogic: Add support for UC-Logic TWHA60 v3

 drivers/hid/hid-core.c          |   2 +-
 drivers/hid/hid-ids.h           |   9 +-
 drivers/hid/hid-kye.c           | 123 +++++++++++++++++---
 drivers/hid/hid-uclogic.c       | 187 +++++++++++++++++++++++-------
 drivers/hid/hid-waltop.c        |  36 ------
 drivers/hid/usbhid/hid-quirks.c |   2 +-
 6 files changed, 264 insertions(+), 95 deletions(-)
