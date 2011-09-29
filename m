From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: [PATCH v2] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 29 Sep 2011 17:52:56 +0200
Message-ID: <1317311577-29742-1-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:42955 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab1I2PxV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Sep 2011 11:53:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Simon Budig <simon.budig@kernelconcepts.de>

This is a driver for the EDT ft5x06 based capacitive touchscreens.

The driver supports up to 5 touch points, the "gain", "threshold" and "offset"
parameters can be configured via some files in the sysfs.

It also is possible to acquire some raw data from the sensor by putting the
sensor in a factory mode ("mode" file in sysfs) and then reading the "raw" 
file, which contains the raw touch data. In factory mode the reporting of
regular events will stop.

This is the 2nd iteration of the patch, based on the head of Linus' kernel
tree.

Thanks,
        Simon Budig


Simon Budig (1):
  Touchscreen driver for FT5x06 based EDT displays

 drivers/input/touchscreen/Kconfig      |   12 +
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/edt-ft5x06.c |  704 ++++++++++++++++++++++++++++++++
 include/linux/input/edt-ft5x06.h       |   16 +
 4 files changed, 733 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/edt-ft5x06.c
 create mode 100644 include/linux/input/edt-ft5x06.h

-- 
1.7.2.3

