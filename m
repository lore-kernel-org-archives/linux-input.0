From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] hid: sort id list for eGalax and remove dups
Date: Fri, 17 May 2013 14:34:47 +0300
Message-ID: <1368790489-21792-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35059 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab3EQLfQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 May 2013 07:35:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Third version of the patches addresses comments I got from Benjamin and Jiri.
The actual change is the commit message for patch 2/2. Patch itself is remained
as in the first version.

Andy Shevchenko (2):
  hid: sort IDs for D-WAV eGalax multitouch devices
  hid: remove duplicate ID for D-WAV eGalax 0x7224

 drivers/hid/hid-ids.h        |  7 +++----
 drivers/hid/hid-multitouch.c | 29 +++++++++++++----------------
 2 files changed, 16 insertions(+), 20 deletions(-)

-- 
1.8.2.rc0.22.gb3600c3

