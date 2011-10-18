From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 0/5] Add spi support for CMA3000 driver and new driver CMR3000
Date: Tue, 18 Oct 2011 10:28:01 +0200
Message-ID: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab1JRI20 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 04:28:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, jic23@cam.ac.uk, hemanthv@ti
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

The following set of patches add spi and device tree support for the cma3000 driver and also
add support for the cmr3000 gyroscope.

Ricardo Ribalda Delgado (5):
  input/cma3000_d0x: Support devices without pdata
  input/cma3000_d0x: Check silicon version
  input/cma3000_d0x: Keep configuration on poweroff
  input/cma3000_d0x: Add CMA3000 spi support
  Input: add CMR3000 gyrsocope driver

 drivers/input/misc/Kconfig           |   38 +++-
 drivers/input/misc/Makefile          |    3 +
 drivers/input/misc/cma3000_d0x.c     |   42 ++++-
 drivers/input/misc/cma3000_d0x_spi.c |  178 +++++++++++++++
 drivers/input/misc/cmr3000_d0x.c     |  400 ++++++++++++++++++++++++++++++++++
 drivers/input/misc/cmr3000_d0x.h     |   45 ++++
 drivers/input/misc/cmr3000_d0x_spi.c |  178 +++++++++++++++
 include/linux/input/cmr3000.h        |   54 +++++
 8 files changed, 932 insertions(+), 6 deletions(-)
 create mode 100644 drivers/input/misc/cma3000_d0x_spi.c
 create mode 100644 drivers/input/misc/cmr3000_d0x.c
 create mode 100644 drivers/input/misc/cmr3000_d0x.h
 create mode 100644 drivers/input/misc/cmr3000_d0x_spi.c
 create mode 100644 include/linux/input/cmr3000.h

-- 
1.7.7

