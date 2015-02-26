From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/6] HID: huion/uclogic merge and few additions
Date: Thu, 26 Feb 2015 13:57:23 -0500
Message-ID: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55657 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbbBZS5o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 13:57:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

Hi,

this is the v2 of the merge of Huion and UcLogic.
I removed the previous 3/4 as mentioned during the review and added
3 more.
Note that 6/6 could have been squashed in 2/6, but I kept it separate
to keep the first 2 reviewed.

Cheers,
Benjamin

Benjamin Tissoires (6):
  HID: uclogic: Set quirks from inside the driver
  HID: uclogic: merge hid-huion driver in hid-uclogic
  HID: uclogic: name the input nodes based on their tool
  HID: uclogic: apply quirk NO_EMPTY_INPUT
  HID: uclogic: discard the extra Pen input node on Huion tablets
  HID: uclogic: actually invert the in-range bit for huion tablets only

 drivers/hid/Kconfig             |   8 +-
 drivers/hid/Makefile            |   1 -
 drivers/hid/hid-huion.c         | 290 -----------------------------------
 drivers/hid/hid-uclogic.c       | 324 +++++++++++++++++++++++++++++++++++++++-
 drivers/hid/usbhid/hid-quirks.c |   4 -
 5 files changed, 324 insertions(+), 303 deletions(-)
 delete mode 100644 drivers/hid/hid-huion.c

-- 
2.1.0

