From: Eric Andersson <eric.andersson@unixphere.com>
Subject: [PATCH v6 0/1] input: add driver for Bosch Sensortec's BMA150 accelerometer
Date: Wed, 27 Jul 2011 22:53:46 +0200
Message-ID: <1311800027-25982-1-git-send-email-eric.andersson@unixphere.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:41379 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839Ab1G0Uts (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2011 16:49:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, alan@lxorguk.ukuu.org.uk, jic23@cam.ac.uk, Eric Andersson <eric.andersson@unixphere.com>

This is version 6 of the driver for Bosch Sensortec's accelerometers BMA150
and SMB380.

Here is the changelog:
* community review: request ONESHOT irq.
* community review: replaced ABS_MISC event registration with EV_ABS only.
* community review: updated runtime_pm in open/close.
* community review: added units in range and bandwidth parameter description.
* community review: fixed weird spacing.
* community review: moved register address macros from h- to c-file.
* community review: changed handling of platform_data cfg settings.
* community review: replaced driver pm-struct with UNIVERSAL_DEV_PM_OPS.
* community review: empty line between variable declaration and code.
* community review: replace existing driver mutex in favor of the input mutex.
* community review: added missing __devinits and __devexit.
* Updated the default_cfg settings according to the EEPROM values.
* Removed const and added __initdata to the default_cfg struct.

--
Best regards,
 Eric

 http://www.unixphere.com

Eric Andersson (1):
  input: add driver for Bosch Sensortec's BMA150 accelerometer

 drivers/input/misc/Kconfig  |   11 +
 drivers/input/misc/Makefile |    1 +
 drivers/input/misc/bma150.c |  654 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/bma150.h      |   47 +++
 4 files changed, 713 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/bma150.c
 create mode 100644 include/linux/bma150.h

-- 
1.7.3.4

