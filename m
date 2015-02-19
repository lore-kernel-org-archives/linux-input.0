From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] Asynchronous attribute reads
Date: Thu, 19 Feb 2015 15:33:55 -0800
Message-ID: <1424388836-18193-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21973 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbbBSXfE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 18:35:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v2
As suggested by Jonathan reversed the logic for sync/async and
moved sensor_hub_report to begining of the function

v1
Squashed into a single patch for bisectability.

v0
Separate patches for each driver/module


Srinivas Pandruvada (1):
  HID: hid-sensor-hub: Extend API for async reads

 drivers/hid/hid-sensor-hub.c                  | 65 ++++++++++++++-------------
 drivers/iio/accel/hid-sensor-accel-3d.c       |  3 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 +-
 drivers/iio/light/hid-sensor-als.c            |  3 +-
 drivers/iio/light/hid-sensor-prox.c           |  3 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  3 +-
 drivers/iio/pressure/hid-sensor-press.c       |  3 +-
 drivers/rtc/rtc-hid-sensor-time.c             |  2 +-
 include/linux/hid-sensor-hub.h                | 19 +++++---
 10 files changed, 63 insertions(+), 44 deletions(-)

-- 
1.9.1

