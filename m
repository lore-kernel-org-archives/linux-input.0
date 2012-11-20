From: Stefan Nilsson <stefan.nilsson@unixphere.com>
Subject: [PATCH 0/1] input: added driver support for the t5400 pressure sensor.
Date: Tue, 20 Nov 2012 22:02:33 +0100
Message-ID: <1353445355-2517-1-git-send-email-stefan.nilsson@unixphere.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:48603 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab2KTVCj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 16:02:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rob.herring@calxeda.com, arnd@arndb.de, matthias.schmidt@epcos.com, armin.schober@epcos.com, eric.andersson@unixphere.com

Hi,

This patch is based upon the mainline branch and it enables driver support
for the T5400 digital barometric pressure sensor provided by TDK/EPCOS. This
chip is a low-power, low-noise (<1m altitude resolution) pressure
sensor with support for both I2C- and SPI-interface.

The driver is implemented as a input-poll device with a fixed poll rate at 50 ms
where the raw data is transformed to pressure and temperature values
upon poll execution. Since the chip supports measurement-ready-irq two separate
background threads are implemented for the raw data handling, one threaded
interrupt utilizing the meas-ready irq and another thread utilizing the shared
worker queue.

Stefan Nilsson (1):
  input: added driver support for the t5400 pressure sensor.

 .../devicetree/bindings/input/misc/t5400.txt       |   17 +
 drivers/input/misc/Kconfig                         |   23 +
 drivers/input/misc/Makefile                        |    2 +
 drivers/input/misc/t5400-core.c                    |  607 ++++++++++++++++++++
 drivers/input/misc/t5400-i2c.c                     |  130 +++++
 drivers/input/misc/t5400-spi.c                     |  128 ++++
 include/linux/t5400.h                              |   69 +++
 7 files changed, 976 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/misc/t5400.txt
 create mode 100644 drivers/input/misc/t5400-core.c
 create mode 100644 drivers/input/misc/t5400-i2c.c
 create mode 100644 drivers/input/misc/t5400-spi.c
 create mode 100644 include/linux/t5400.h

-- 
1.7.7.2

