From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/2] Core driver enhancements
Date: Thu, 19 Feb 2015 15:31:24 -0800
Message-ID: <1424388686-18125-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64527 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbbBSXdI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 18:33:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Enhance core to support next generation of hub devices for fast response
and application collection.

v1
Added acked by tag for parallel read patch
For collection support, changed the commit message and relying on FW to explicitlty
define a collection, then only create a collection and allow callback registration

v0
Base version

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Allow parallel synchronous reads
  HID: hid-sensor-hub: Add support for application collection

 drivers/hid/hid-sensor-hub.c   | 120 +++++++++++++++++++++++------------------
 include/linux/hid-sensor-hub.h |  24 +++++++++
 include/linux/hid-sensor-ids.h |   2 +
 3 files changed, 93 insertions(+), 53 deletions(-)

-- 
1.9.1

