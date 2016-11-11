From: Even Xu <even.xu@intel.com>
Subject: [PATCH 0/3] Clean up ipc wait times
Date: Fri, 11 Nov 2016 09:38:39 +0800
Message-ID: <1478828319-31590-2-git-send-email-even.xu@intel.com>
References: <1478828319-31590-1-git-send-email-even.xu@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19367 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935107AbcKKBjU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 20:39:20 -0500
In-Reply-To: <1478828319-31590-1-git-send-email-even.xu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@intel.com, Even Xu <even.xu@intel.com>

This series addresses issue with schedule_timeout() calls and cleans
up code around this.

Even Xu (3):
  hid: intel-ish-hid: ipc: remove unused macro
  hid: intel-ish-hid: ipc: change timed_wait_for_timeout() to be a
    function
  hid: intel-ish-hid: ipc: use msleep_interrupt() for wait

 drivers/hid/intel-ish-hid/ipc/ipc.c   | 66 +++++++++++++++++++++++++++++++----
 drivers/hid/intel-ish-hid/ipc/utils.h | 64 ---------------------------------
 2 files changed, 60 insertions(+), 70 deletions(-)
 delete mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h

-- 
2.7.4

