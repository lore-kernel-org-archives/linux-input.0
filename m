From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/2] HID: HID Sensor: Custom and Generic sensor support
Date: Thu,  5 Mar 2015 08:05:42 -0800
Message-ID: <1425571544-21324-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17350 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757535AbbCEQHM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Mar 2015 11:07:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v1
- Two trailing white spaces in the document
- Error in getting attribute value found by
saurabh rawat <saurabh.rawat@st.com>

v0
Base version

Srinivas Pandruvada (2):
  HID: HID Sensor: Custom and Generic sensor support
  HID: HID Sensor: Update document for custom sensor

 Documentation/hid/hid-sensor.txt |  79 ++++++
 drivers/hid/Kconfig              |  12 +
 drivers/hid/Makefile             |   1 +
 drivers/hid/hid-sensor-custom.c  | 551 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 643 insertions(+)
 create mode 100644 drivers/hid/hid-sensor-custom.c

-- 
1.9.1

