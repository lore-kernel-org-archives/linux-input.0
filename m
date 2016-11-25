From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/3] Support multitouch touchpads in Surface TypeCover
Date: Fri, 25 Nov 2016 14:27:20 +0100
Message-ID: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753586AbcKYN1d (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 08:27:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dennis Chen <barracks510@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

this is mostly a resubmission of v1, with one patch exchanged.

The latest investigations by Dennis Chen showed that the first patch did
not changed the internal HID device quirk. So I think the first patch is
still valid for upstream.

Patch 2/3 "HID: multitouch: do not retrieve all reports for all devices" is
an attempt to pro-actively fix the other issues of the TypeCover. It looks
like the quirk HID_QUIRK_NO_INIT_REPORTS was dropped somewhere, but the quirks
set in hid-multitouch were kept. After further thoughts, I think we should
simply mimic the Windows driver and only retrieve the features we actually need.

With this patch, we don't need to add a special case for the Surface 3
cover, the default class just works.

Cheers,
Benjamin

Benjamin Tissoires (3):
  HID: input: rework HID_QUIRK_MULTI_INPUT
  HID: multitouch: do not retrieve all reports for all devices
  HID: multitouch: enable the Surface 3 Type Cover to report multitouch
    data

 drivers/hid/hid-core.c          |  2 -
 drivers/hid/hid-ids.h           |  1 -
 drivers/hid/hid-input.c         | 95 +++++++++++++++++++++++------------------
 drivers/hid/hid-microsoft.c     |  2 -
 drivers/hid/hid-multitouch.c    | 80 ++++++++++++++++++----------------
 drivers/hid/usbhid/hid-quirks.c |  1 -
 include/linux/hid.h             |  1 +
 7 files changed, 98 insertions(+), 84 deletions(-)

-- 
2.7.4

