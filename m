From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/2] HID: input: do not increment usages when a duplicate is found
Date: Fri,  8 Dec 2017 15:28:16 +0100
Message-ID: <20171208142818.15156-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753419AbdLHO2b (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Dec 2017 09:28:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Jiri,

slightly modified version (to actually make it working this time).

There is not much to add, the differences are in the commit messages
and in the notes of each patch.

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: use BIT macro instead of plain integers for flags
  HID: input: do not increment usages when a duplicate is found

 drivers/hid/hid-input.c | 33 +++++++++++++++++++++++++++++++--
 include/linux/hid.h     | 14 ++++++++------
 2 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.14.3

