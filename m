From: Mohan Pallaka <mpallaka@codeaurora.org>
Subject: [PATCH 0/2] Support for isa1200 haptic chip
Date: Wed, 18 May 2011 10:48:44 +0530
Message-ID: <1305695926-25855-1-git-send-email-mpallaka@codeaurora.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:6226 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240Ab1ERFTy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2011 01:19:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@arm.linux.org.uk, rmk+kernel@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk, Mohan Pallaka <mpallaka@codeaurora.org>

This patchset includes stubs for pwm apis in pwm.h and
a ff-memless based isa1200 driver.

ISA1200 chip can operate in two modes and if the chip has been
configured for pwm-generation mode, which doesn't use pwm standard
apis then it'd encounter compilation errors if the host doesn't
support PWM. Adding pwm stubs will avoid compilation errors in those
cases. This driver is based on Park's isa1200 driver that uses
haptic class.

Kyungmin Park (1):
  input: misc: Add support for isa1200 chip

Mohan Pallaka (1):
  pwm: Add stubs for pwm operations

 drivers/input/misc/Kconfig    |   12 +
 drivers/input/misc/Makefile   |    1 +
 drivers/input/misc/isa1200.c  |  442 +++++++++++++++++++++++++++++++++++++++++
 include/linux/input/isa1200.h |   46 +++++
 include/linux/pwm.h           |   24 +++
 5 files changed, 525 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/isa1200.c
 create mode 100644 include/linux/input/isa1200.h
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
