From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 0/3] mfd: mc13xxx: Fixes and enhancements for NXP's mc34708
Date: Mon,  9 Sep 2019 23:44:37 +0200
Message-ID: <20190909214440.30674-1-lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukasz Majewski <lukma@denx.de>
List-Id: linux-input@vger.kernel.org

This patch set provides several enhancements to mc13xxx MFD family
of devices by introducing mc34708 as a separate device.

This IC has dedicated pen detection feature, which allows better
touchscreen experience.

This is the fifth version of this code (v5).
Discussion regarding previous versions can be found here:
https://lkml.org/lkml/2018/4/12/351
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1661934.html
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1664296.html
https://lkml.org/lkml/2019/7/17/705

Sascha Hauer (3):
  mfd: mc13xxx: Add mc34708 adc support
  input: touchscreen mc13xxx: Make platform data optional
  input: touchscreen mc13xxx: Add mc34708 support

 drivers/input/touchscreen/mc13783_ts.c | 63 ++++++++++++++---
 drivers/mfd/mc13xxx-core.c             | 98 +++++++++++++++++++++++++-
 include/linux/mfd/mc34708.h            | 37 ++++++++++
 3 files changed, 185 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/mfd/mc34708.h

-- 
2.20.1
