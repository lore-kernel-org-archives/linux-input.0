From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 0/2] HID: HID Sensor: Custom and Generic sensor support
Date: Fri, 10 Apr 2015 11:22:21 -0700
Message-ID: <1428690143-28099-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54890 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000AbbDJSXx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 14:23:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v4
- Fix sysfs_attr_init arguments. Again sorry for the mistake
- Fix attribute value size for multi byte feature report

v3
- Added name attribute
Although documentation patch is acked by Jonathan for previous
version, I didn't use this as the name attribute is added.

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

 Documentation/hid/hid-sensor.txt |  84 ++++
 drivers/hid/Kconfig              |  15 +
 drivers/hid/Makefile             |   1 +
 drivers/hid/hid-sensor-custom.c  | 849 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 949 insertions(+)
 create mode 100644 drivers/hid/hid-sensor-custom.c

-- 
2.1.0

