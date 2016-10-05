From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 0/5] HID: sony: game controller updates
Date: Tue,  4 Oct 2016 19:58:53 -0700
Message-ID: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:35445 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbcJEDAY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2016 23:00:24 -0400
Received: by mail-it0-f50.google.com with SMTP id r192so164664588ita.0
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2016 20:00:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi all,

This patch series contains a couple patches to improve ds4 support.
The first two patches were sent earlier, but I was asked to rebase
against a different branch.

At time of the first submission, the second patch was not yet needed,
because there was no report id collision yet. This collission starts
happening as of patch 3, which adds CRC checking for input reports.
The other patches add crc checking for output report, which allows
getting rid of an ugly quirk. The last patch improves touchpad support.

Thanks,
Roderick

Roderick Colenbrander (5):
  HID: sony: Fix race condition in sony_probe
  HID: sony: Adjust HID report size name definitions
  HID: sony: Perform CRC check on bluetooth input packets
  HID: sony: Send ds4 output reports on output end-point
  HID: sony: Handle multiple touch events input record

 drivers/hid/hid-sony.c | 259 ++++++++++++++++++++++++++++---------------------
 1 file changed, 151 insertions(+), 108 deletions(-)

-- 
2.7.4

