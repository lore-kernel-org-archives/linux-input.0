From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3 0/4] Add max77693 haptic driver
Date: Fri, 05 Sep 2014 20:48:18 +0900
Message-ID: <1409917702-17009-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

This series adds max77693 haptic driver.
The max77693 is a Multifunction device with PMIC, CHARGER, LED,
MUIC, HAPTIC and this series is haptic device driver in MAX77693.
The haptic driver use regmap method for i2c communication and
support force feedback framework in input device.

Changes in v3:
 - driver : remove mutex in workqueue
 - driver : mv max77693_haptic_set_duty_cyle() to workqueue.
 - driver : remove max77693_haptic_remove[]
 - driver : add suspend() function to turn-off entering suspend.

Changes in v2:
 - split to documentation and mfd patchs.
 - Documentation : change explanation of haptic 
 - Documentation : remove pwm-names propertie in example

Jaewon Kim (4):
  mfd: max77693: Initialize haptic register map
  Input: misc: Add haptic driver on max77693
  mfd: max77693: add haptic of_compatible in mfd_cell
  mfd: max77693: Update DT binding to support haptic

 Documentation/devicetree/bindings/mfd/max77693.txt |   18 ++
 drivers/input/misc/Kconfig                         |   12 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/max77693-haptic.c               |  321 ++++++++++++++++++++
 drivers/mfd/max77693.c                             |   26 +-
 include/linux/mfd/max77693-private.h               |    9 +
 6 files changed, 383 insertions(+), 4 deletions(-)
 create mode 100644 drivers/input/misc/max77693-haptic.c

-- 
1.7.9.5
