From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] Make gpio_keys accept board descriptors
Date: Fri, 24 Nov 2017 10:30:40 +0100
Message-ID: <20171124093045.5961-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33825 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdKXJat (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 04:30:49 -0500
Received: by mail-lf0-f65.google.com with SMTP id i14so24744759lfc.1
        for <linux-input@vger.kernel.org>; Fri, 24 Nov 2017 01:30:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

The goal I'm working toward is to rid the kernel of the global
GPIO numberspace.

This means GPIO lines should be references by the local offset
on the GPIO chip.

This patch set starts to move gpio_keys toward using GPIO
look-up tables instead of global GPIO numbers to find their
GPIOs.

As an example I did (I think) the necessary patches to
convert DaVinci and i.MX to use this. There are several users
also x86 platform devices.

Strategy:

- Merge the patch to input/keyboard/gpio_keys* to support
  using descriptors from board files.

- Refactor the whole universe to get proper names on GPIO
  chips, and reference the GPIO lines with local offsets using
  tables, as in the example patches in this series. These
  can trickle in after the first patch is merged in Input.
  The work to be done can be seen if you type:
  git grep gpio_keys_platform_data

- When all are refactored, remove the "gpio" and "active low"
  members from the platform data and delete the associated
  legacy GPIO handling in the input driver for gpio_keys.

Posting this with the examples to get buy-in from Dmitry
before I go and spend time refactoring the world.

I.e. I'm happy if patch 1 gets merged, the rest I will push
through ARM SoC etc, or if nothing else works (like
nonresponsive maintainers) I can push it through the GPIO
tree without bothering Dmitry.

Linus Walleij (5):
  Input: gpio-keys: Support getting descriptors from board
  gpio: pca953x: Name the gpiochip after the I2C address
  ARM: davinci: Switch DA850EVM to use GPIO descriptors
  ARM: imx: Give all GPIO chips a unique name
  ARM: imx: Use GPIO descriptors for gpio_keys

 arch/arm/mach-davinci/board-da850-evm.c     | 57 ++++++++++++++---
 arch/arm/mach-imx/mach-armadillo5x0.c       | 19 ++++--
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c | 26 ++++++--
 arch/arm/mach-imx/mach-pcm037_eet.c         | 52 +++++++++++----
 arch/arm/mach-imx/mach-vpr200.c             | 99 ++++++++++++++++++++++++-----
 arch/arm/mach-imx/mm-imx21.c                | 12 ++--
 arch/arm/mach-imx/mm-imx27.c                | 12 ++--
 arch/arm/mach-imx/mm-imx3.c                 | 12 ++--
 drivers/gpio/gpio-pca953x.c                 | 17 ++++-
 drivers/input/keyboard/gpio_keys.c          | 14 +++-
 drivers/input/keyboard/gpio_keys_polled.c   | 10 +++
 11 files changed, 259 insertions(+), 71 deletions(-)

-- 
2.14.3

