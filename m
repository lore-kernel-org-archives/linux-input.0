From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] HID: HID Sensor: Custom and Generic sensor support
Date: Mon, 16 Mar 2015 16:09:01 -0700
Message-ID: <1426547343-27747-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20383 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbCPXKV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 19:10:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Srinivas Pandruvada <spandruvada@spandruv-bdw-test.jf.intel.com>

From: Srinivas Pandruvada <spandruvada@spandruv-bdw-test.jf.intel.com>

v2
- Addressed review comments from Jonathan
- Added poll capability on misc device
- Added time stamp to the report id

v1
- Two trailing white spaces in the document
- Error in getting attribute value found by
saurabh rawat <saurabh.rawat@st.com>

v0
Base version

Srinivas Pandruvada (2):
  HID: HID Sensor: Custom and Generic sensor support
  HID: HID Sensor: Update document for custom sensor

 Documentation/hid/hid-sensor.txt |  79 ++++
 drivers/hid/Kconfig              |  15 +
 drivers/hid/Makefile             |   1 +
 drivers/hid/hid-sensor-custom.c  | 759 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 854 insertions(+)
 create mode 100644 drivers/hid/hid-sensor-custom.c

-- 
2.1.0

