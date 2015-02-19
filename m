From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/2] hid: sensor-hub: Enhance feature report APIs
Date: Thu, 19 Feb 2015 15:35:24 -0800
Message-ID: <1424388926-18258-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34189 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbbBSXgd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 18:36:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Current get and set feature report is enhanced to have multiple
values in get and set.

v3
Removed cast for __s32 *buf32, as suggested by Jonathan
Added Acked-by/reviewed-by tags as per the reply from Jonathan

v2
As suggested by Antonio Borneo, using DIV_ROUND_UP

v1
Squashed into two patches one for get and one for set feature report
for bisectability.

v0
Separate patches for each driver/modules

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Enhance get feature report API
  HID: hid-sensor-hub: Enhance feature report set API

 drivers/hid/hid-sensor-hub.c                       | 37 +++++++++++++++++++---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 24 +++++++-------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 13 ++++----
 include/linux/hid-sensor-hub.h                     | 13 +++++---
 4 files changed, 60 insertions(+), 27 deletions(-)

-- 
1.9.1

