From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] Fix kernel warning and failure
Date: Thu,  5 Dec 2013 16:34:24 -0800
Message-ID: <1386290065-31813-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46271 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413Ab3LFAfr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Dec 2013 19:35:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v1:
Use platform driver capability to assign unique id.
In this way it is just one line change.

v0:
Use idr to allocate unique cell id

Srinivas Pandruvada (1):
  HID: hid-sensor-hub: Fix kernel warning and failure

 drivers/hid/hid-sensor-hub.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
1.8.1.2

