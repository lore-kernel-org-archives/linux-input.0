From: Mohan Pallaka <mpallaka@codeaurora.org>
Subject: [PATCH 0/2] Support for isa1200 haptic chip
Date: Fri, 13 May 2011 18:13:20 +0530
Message-ID: <1305290602-29859-1-git-send-email-mpallaka@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.intradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk, Mohan Pallaka <mpallaka@codeaurora.org>
List-Id: linux-input@vger.kernel.org

This patchset includes a __weak attributed pwm apis in pwm.h and
a ff-memless based isa1200 driver.

ISA1200 chip can operate in two modes and if the chip has been
configured for pwm-generation mode, which doesn't use pwm standard
apis then it'd encounter compilation errors if the host doesn't
support PWM. This driver is based on Park's isa1200 driver that uses
haptic class.

Kyungmin Park (1):
  input: misc: Add support for isa1200 chip

Mohan Pallaka (1):
  pwm: Add __weak attributed functions for pwm operations

 drivers/input/misc/Kconfig    |   12 +
 drivers/input/misc/Makefile   |    1 +
 drivers/input/misc/isa1200.c  |  442 +++++++++++++++++++++++++++++++++++++++++
 include/linux/input/isa1200.h |   46 +++++
 include/linux/pwm.h           |   12 +-
 5 files changed, 508 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/misc/isa1200.c
 create mode 100644 include/linux/input/isa1200.h

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
