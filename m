From: Ferruh Yigit <fery@cypress.com>
Subject: [PATCH v2 0/3] Input: cyttsp4 - driver for Cypress TMA4XX touchscreen devices
Date: Fri, 14 Sep 2012 20:48:34 +0300
Message-ID: <1347644917-13269-1-git-send-email-fery@cypress.com>
References: <Ferruh Yigit <fery@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay.ihostexchange.net ([66.46.182.53]:10452 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab2INRsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 13:48:55 -0400
In-Reply-To: <Ferruh Yigit <fery@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin McNeely <kev@cypress.com>, Phil Warkentin <pwar@cypress.com>, Ferruh Yigit <fery@cypress.com>, Javier Martinez Canillas <javier@dowhile0.org>, Henrik Rydberg <rydberg@euromail.se>, Shawn Landden <shawnlandden@gmail.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This driver is for Cypress TrueTouch(tm) Standard Product controllers,
Generation4 devices.

This is second version of driver, code re-structured to match with
existing Generation3 driver code.

Driver consist of three modules:
- Core module: Main module, gets data from TTSP controller,
sent MT events to Linux
- I2C module: Underlying communication with I2C bus
- SPI module: Underlying communication with SPI bus

Ferruh Yigit (3):
  Input: cyttsp4 - core driver for Cypress TMA4XX touchscreen devices
  Input: cyttsp4 - I2C driver for Cypress TMA4XX touchscreen devices
  Input: cyttsp4 - SPI driver for Cypress TMA4XX touchscreen devices

 drivers/input/touchscreen/Kconfig        |   57 +
 drivers/input/touchscreen/Makefile       |   14 +
 drivers/input/touchscreen/cyttsp4_core.c | 2308 ++++++++++++++++++++++++++++++
 drivers/input/touchscreen/cyttsp4_core.h |  525 +++++++
 drivers/input/touchscreen/cyttsp4_i2c.c  |  191 +++
 drivers/input/touchscreen/cyttsp4_i2c.h  |   34 +
 drivers/input/touchscreen/cyttsp4_spi.c  |  318 ++++
 drivers/input/touchscreen/cyttsp4_spi.h  |   34 +
 include/linux/input/cyttsp4.h            |  126 ++
 9 files changed, 3607 insertions(+)
 create mode 100644 drivers/input/touchscreen/cyttsp4_core.c
 create mode 100644 drivers/input/touchscreen/cyttsp4_core.h
 create mode 100644 drivers/input/touchscreen/cyttsp4_i2c.c
 create mode 100644 drivers/input/touchscreen/cyttsp4_i2c.h
 create mode 100644 drivers/input/touchscreen/cyttsp4_spi.c
 create mode 100644 drivers/input/touchscreen/cyttsp4_spi.h
 create mode 100644 include/linux/input/cyttsp4.h

--
1.7.9.5


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
