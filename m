From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/4] ISH Fixes for module loading
Date: Fri, 21 Oct 2016 15:48:37 -0700
Message-ID: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62344 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbcJUWs4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2016 18:48:56 -0400
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


v2
 -pci_set_power_state() used instead of changing directly CSR

Even Xu (3):
  hid: intel-ish-hid: ipc: consolidate ish wake up operation
  hid: intel-ish-hid: ipc: Move DMA disable code to new function
  hid: intel-ish-hid: ipc: Fix driver reinit failure

Srinivas Pandruvada (1):
  hid: intel-ish-hid: request_irq failure

 drivers/hid/intel-ish-hid/ipc/ipc.c     | 102 +++++++++++++++++++++++---------
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |   2 +-
 2 files changed, 74 insertions(+), 30 deletions(-)

-- 
2.7.4

