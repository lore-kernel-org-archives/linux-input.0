From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/8] Adding PM support to hid sensor iio drivers
Date: Wed,  7 Jan 2015 10:55:52 -0800
Message-ID: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57436 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718AbbAGS5E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:57:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Linux PM and runtime PM support.

Srinivas Pandruvada (8):
  iio: hid_sensor_hub: Common PM functions
  iio: hid-sensor-accel-3d: Introduce PM
  iio: hid-sensor-gyro-3d: Introduce PM
  iio: hid-sensor-als: Introduce PM
  iio: hid-sensor-prox: Introduce PM
  iio: hid-sensor-magn-3d: Introduce PM
  iio: hid-sensor-incl-3d: Introduce PM
  iio: hid-sensor-press: Introduce PM

 drivers/iio/accel/hid-sensor-accel-3d.c            |  8 +--
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 76 +++++++++++++++++++++-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |  5 ++
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  8 +--
 drivers/iio/light/hid-sensor-als.c                 |  9 +--
 drivers/iio/light/hid-sensor-prox.c                | 10 +--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  9 +--
 drivers/iio/orientation/hid-sensor-incl-3d.c       |  9 +--
 drivers/iio/pressure/hid-sensor-press.c            |  9 +--
 9 files changed, 86 insertions(+), 57 deletions(-)

-- 
1.9.3

