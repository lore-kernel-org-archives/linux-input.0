From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCHv3 0/7] Add spi support for CMA3000 driver and new driver CMR3000
Date: Tue, 18 Oct 2011 17:47:59 +0200
Message-ID: <1318952886-835-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36602 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab1JRPsN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 11:48:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, jic23@cam.ac.uk, hemanthv@ti
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>


The following set of patches add spi and device tree support for the cma3000 driver and also
add support for the cmr3000 gyroscope.

v3 of the set.

Changelog:

  v3: -Support for device tree
      -Separate read/write spi

  v2: -Changes propossed by Jonathan Cameron
      -More fixes for the cma3000 driver

Ricardo Ribalda Delgado (7):
  input/cma3000_d0x: Support devices without pdata
  input/cma3000_d0x: Check silicon version
  input/cma3000_d0x: Keep configuration on poweroff
  input/cma3000_d0x: Add CMA3000 spi support
  Input: add CMR3000 gyrsocope driver
  input/cma3000_d0x: Unwind reverse order of init
  input/cma3000_d0x: Match comment to name of struct

 drivers/input/misc/Kconfig           |   38 ++++-
 drivers/input/misc/Makefile          |    3 +
 drivers/input/misc/cma3000_d0x.c     |  100 ++++++++--
 drivers/input/misc/cma3000_d0x_spi.c |  145 +++++++++++++
 drivers/input/misc/cmr3000_d0x.c     |  382 ++++++++++++++++++++++++++++++++++
 drivers/input/misc/cmr3000_d0x.h     |   45 ++++
 drivers/input/misc/cmr3000_d0x_spi.c |  178 ++++++++++++++++
 include/linux/input/cma3000.h        |    2 +-
 include/linux/input/cmr3000.h        |   54 +++++
 9 files changed, 930 insertions(+), 17 deletions(-)
 create mode 100644 drivers/input/misc/cma3000_d0x_spi.c
 create mode 100644 drivers/input/misc/cmr3000_d0x.c
 create mode 100644 drivers/input/misc/cmr3000_d0x.h
 create mode 100644 drivers/input/misc/cmr3000_d0x_spi.c
 create mode 100644 include/linux/input/cmr3000.h

-- 
1.7.7

