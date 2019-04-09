From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH v2 0/4] Use MFD framework for SGI IOC3 drivers
Date: Tue,  9 Apr 2019 17:46:04 +0200
Message-ID: <20190409154610.6735-1-tbogendoerfer@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

SGI IOC3 ASIC includes support for ethernet, PS2 keyboard/mouse,
NIC (number in a can), GPIO and a byte  bus. By attaching a
SuperIO chip to it, it also supports serial lines and a parallel
port. The chip is used on a variety of SGI systems with different
configurations. This patchset moves code out of the network driver,
which doesn't belong there, into its new place a MFD driver and
specific platform drivers for the different subfunctions.

Change in v2:
 - fixed issue in ioc3kbd.c reported by Dmitry Torokhov
 - merged IP27 RTC removal and 8250 serial driver addition into
   main MFD patch to keep patches bisectable

Thomas Bogendoerfer (4):
  MIPS: SGI-IP27: remove ioc3 ethernet init
  mfd: ioc3: Add driver for SGI IOC3 chip
  MIPS: SGI-IP27: fix readb/writeb addressing
  Input: add IOC3 serio driver

 arch/mips/include/asm/mach-ip27/mangle-port.h |    2 +-
 arch/mips/include/asm/sn/ioc3.h               |  349 ++---
 arch/mips/sgi-ip27/ip27-console.c             |    5 +-
 arch/mips/sgi-ip27/ip27-init.c                |   13 -
 arch/mips/sgi-ip27/ip27-timer.c               |   20 -
 drivers/input/serio/Kconfig                   |   10 +
 drivers/input/serio/Makefile                  |    1 +
 drivers/input/serio/ioc3kbd.c                 |  158 +++
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/ioc3.c                            |  802 +++++++++++
 drivers/net/ethernet/sgi/Kconfig              |    4 +-
 drivers/net/ethernet/sgi/ioc3-eth.c           | 1867 +++++++++----------------
 drivers/rtc/rtc-m48t35.c                      |   11 +
 drivers/tty/serial/8250/8250_ioc3.c           |   98 ++
 drivers/tty/serial/8250/Kconfig               |   11 +
 drivers/tty/serial/8250/Makefile              |    1 +
 include/linux/platform_data/ioc3eth.h         |   15 +
 18 files changed, 1946 insertions(+), 1435 deletions(-)
 create mode 100644 drivers/input/serio/ioc3kbd.c
 create mode 100644 drivers/mfd/ioc3.c
 create mode 100644 drivers/tty/serial/8250/8250_ioc3.c
 create mode 100644 include/linux/platform_data/ioc3eth.h

-- 
2.13.7
