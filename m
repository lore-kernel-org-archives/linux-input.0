From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] HID Sensor hub driver fixes
Date: Wed,  7 Jan 2015 10:14:42 -0800
Message-ID: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14718 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbbAGSPa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:15:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Address two bug fixes in the existing code.

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Correct documentation
  HID: sensor-hub: correct dyn_callback_lock IRQ-safe change

 drivers/hid/hid-sensor-hub.c   | 8 +++++---
 include/linux/hid-sensor-hub.h | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
1.9.3

