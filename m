From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v3 0/7] HID: sony: game controller updates
Date: Fri,  7 Oct 2016 12:39:33 -0700
Message-ID: <1475869180-26757-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36870 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbcJGTkL (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 15:40:11 -0400
Received: by mail-it0-f45.google.com with SMTP id z65so17487952itc.0
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 12:40:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

This is a resubmit of the previous patches. Most patches are unchanged,
just for clarity the whole series is sent again.

Changes:
* 5/7: touch events patch calls input_mt_sync_frame and input_sync
       per pair of touch points.
* 7/7: removed 'v2' from update device ids patch title

Thanks,
Roderick

Roderick Colenbrander (7):
  HID: sony: Fix race condition in sony_probe
  HID: sony: Adjust HID report size name definitions
  HID: sony: Perform CRC check on bluetooth input packets
  HID: sony: Send ds4 output reports on output end-point
  HID: sony: Handle multiple touch events input record
  HID: sony: Adjust value range for motion sensors
  HID: sony: Update device ids

 drivers/hid/hid-core.c |   2 +
 drivers/hid/hid-ids.h  |   1 +
 drivers/hid/hid-sony.c | 277 +++++++++++++++++++++++++++++--------------------
 3 files changed, 166 insertions(+), 114 deletions(-)

-- 
2.7.4

