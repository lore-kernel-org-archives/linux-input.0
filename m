From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/3] Cleanup to get rid of a static checker warning
Date: Fri, 20 Mar 2015 14:56:40 -0700
Message-ID: <1426888600-8603-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36574 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbCTV4o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2015 17:56:44 -0400
Received: by pdbcz9 with SMTP id cz9so120150190pdb.3
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2015 14:56:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Patch e2c7d8877e5c leads to the following Smatch complaint:

drivers/hid/wacom_wac.c:602 wacom_intuos_inout()
         error: we previously assumed 'wacom->shared' could be null (see line 584)

The first patch in this series fixes that warning. The next two cleans up the code
and fixes a logic order.

The patchset is based on Jiri's for-4.0/upstream-fixes branch.

Ping Cheng (3):
  HID: wacom: remove hardcoded WACOM_QUIRK_MULTI_INPUT
  HID: wacom: use wacom_wac_finger_count_touches to set touch_down
  HID: wacom: set stylus_in_proximity before checking touch_down

 drivers/hid/wacom_sys.c |  24 ++++-----
 drivers/hid/wacom_wac.c | 137 +++++++++++++++++++-----------------------------
 drivers/hid/wacom_wac.h |   9 ++--
 3 files changed, 68 insertions(+), 102 deletions(-)

-- 
1.9.1

