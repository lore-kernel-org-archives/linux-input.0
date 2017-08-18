From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 0/2] Input: Add Cypress Gen5 Touchscreen driver
Date: Fri, 18 Aug 2017 08:20:43 +0200
Message-ID: <20170818062045.31280-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55762 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdHRGXj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Aug 2017 02:23:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

Hi everyone,

Here is a V2 serie to add the driver of the touchscreen Cypress,
TrueTouch Generation 5.
Based on last linux-next tag (next-20170817), last commit bb70832dd42b.

This touchscreen is similar to Cypress generation 4 but the
registers are different.

This driver uses regmap as it is possible to use I2C or SPI
busses. Currently, only the I2C support are available in the driver.
This touchscreen can handle some multitouch event as buttons using
some defined zone. That is why the driver handles buttons and
multitouch events.

Changes since v1:
   - Updated the driver according to reviews. Most important modifications:
   removed unnecessary mutex, updated dev_err output, handled return cases
   in a better way, created a HID_ENUM, removed magic value, used an
   existing CRC table and used "linux-keycodes" instead of sub-nodes.
   - Updated the dt-bindings to use linux-keycodes and removed properties'
   description that comes from touchscreen's binding.

Patch 01: Add the basis of the driver for Cypress Gen5 Touchscreen.
Patch 02: Add the binding documentation for this driver.

If you have any remarks, let me know.

Thank you in advance,
Mylène


Mylène Josserand (2):
  Input: Add driver for Cypress Generation 5 touchscreen
  dt-bindings: input: Add documentation for cyttsp5

 .../bindings/input/touchscreen/cypress,cyttsp5.txt |   41 +
 drivers/input/touchscreen/Kconfig                  |   15 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/cyttsp5.c                | 1110 ++++++++++++++++++++
 4 files changed, 1167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
 create mode 100644 drivers/input/touchscreen/cyttsp5.c

-- 
2.11.0

