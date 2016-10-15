From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/4] intel-ish-hid: Fixes for loading failures
Date: Sat, 15 Oct 2016 09:22:40 -0700
Message-ID: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13009 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751226AbcJOQWs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Oct 2016 12:22:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Two issues are reported related to loading of intel-ishtp-hid:

1. Loading failure after rmmod and then modprobe
(Patch 1/4 to Patch 3/4) address this. Here first two patches are just
clean up patches which gets used in Patch 3/4 to fix the issue.

2. Loading failure due to request_irq failure on some platforms
(Patch 4/4)

Even Xu (3):
  hid: intel-ish-hid: ipc: consolidate ish wake up operation
  hid: intel-ish-hid: ipc: Move DMA disable code to new function
  hid: intel-ish-hid: ipc: Fix driver reinit failure

Srinivas Pandruvada (1):
  hid: intel-ish-hid: request_irq failure

 drivers/hid/intel-ish-hid/ipc/ipc.c     | 107 +++++++++++++++++++++++---------
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |   2 +-
 2 files changed, 79 insertions(+), 30 deletions(-)

-- 
2.7.4

