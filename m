From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 0/2] Input: Add Cypress Gen5 Touchscreen driver
Date: Wed, 27 Sep 2017 13:37:45 +0200
Message-ID: <20170927113747.2770-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi everyone,

Here is a V3 serie to add the driver of the touchscreen Cypress,
TrueTouch Generation 5.
Based on last master branch of "input" kernel's tree, last commit 8d25fee28450.

This touchscreen is similar to Cypress generation 4 but the
registers are different.

This driver uses regmap as it is possible to use I2C or SPI
busses. Currently, only the I2C support are available in the driver.
This touchscreen can handle some multitouch event as buttons using
some defined zone. That is why the driver handles buttons and
multitouch events.

Changes since v2:
   - Removed pinctrl in dt-binding example which is uncessecary.
   - Added Acked-by and Reviewd-by received.
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

 .../bindings/input/touchscreen/cypress,cyttsp5.txt |   39 +
 drivers/input/touchscreen/Kconfig                  |   15 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/cyttsp5.c                | 1110 ++++++++++++++++++++
 4 files changed, 1165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
 create mode 100644 drivers/input/touchscreen/cyttsp5.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
