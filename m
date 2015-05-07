From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] HID: hid-sensor-hub: Fix debug lock warning
Date: Thu,  7 May 2015 14:26:33 -0700
Message-ID: <1431033994-7836-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41606 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbbEGV22 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 17:28:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v1
Allocate mutex memory dynamically

v0
base version

Srinivas Pandruvada (1):
  HID: hid-sensor-hub: Fix debug lock warning

 drivers/hid/hid-sensor-hub.c   | 13 ++++++++++---
 include/linux/hid-sensor-hub.h |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.1.0

