From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [RFC PATCH 0/3] introduce Atmel PTC driver
Date: Fri, 10 Mar 2017 16:55:26 +0100
Message-ID: <20170310155529.7550-1-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exsmtp02.microchip.com ([198.175.253.38]:8793 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754128AbdCJPzr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 10:55:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, nicolas.ferre@microchip.com, Ludovic Desroches <ludovic.desroches@microchip.com>

From: Ludovic Desroches <ludovic.desroches@microchip.com>

Hi,

I am currently writing an input driver for the Atmel Peripheral Touch Controller
which is composed of an ADC device and a pico Power Processor (PPP). This latest
requires a firmware to compute the data from the ADC device. The firmware is
named QTouch Manager (QTM) and is composed of several libraries to manage touch
objects such as buttons, sliders, wheels.
There is a shared memory area between the Cortex A5 and the PPP. It is called
the QTM mailbox. It allows to set the configuration for the firmware and to get
data. One requirement is to have a user application which allows tuning all
these parameters. This application is also used to create the configuration file
that has to be loaded at startup.

I am not familiar with the input subsystem. I had a look at other drivers but I
am not sure I am on the right track that's why I send this RFC version to
get some feedbacks. The firmware is still in development so the driver is not
finished yet. You will see some debug stuff and some crap! Patches 2/3 and 3/3
are only informative, this board is a prototype.

At the moment, my main concerns are:
- the firmware and configuration loading
- the sysfs binary file for the user application

Thanks for your help.

Regards


Ludovic Desroches (3):
  input: misc: introduce Atmel PTC driver
  ARM: dts: at91: sama5d2: add PTC device
  ARM: dts: at91: introduce at91-sama5d2_ptc_atqt1-xpro board

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/at91-sama5d2_ptc_atqt1-xpro.dts | 492 +++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi                    |  16 +
 drivers/input/misc/Kconfig                        |   7 +
 drivers/input/misc/Makefile                       |   1 +
 drivers/input/misc/atmel_ptc.c                    | 620 ++++++++++++++++++++++
 include/uapi/linux/atmel_ptc.h                    | 360 +++++++++++++
 7 files changed, 1497 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_ptc_atqt1-xpro.dts
 create mode 100644 drivers/input/misc/atmel_ptc.c
 create mode 100644 include/uapi/linux/atmel_ptc.h

-- 
2.9.0

