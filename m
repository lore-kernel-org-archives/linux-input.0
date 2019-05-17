From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH v2 0/4] Input: mpr121-polled: Add polled driver for MPR121
Date: Fri, 17 May 2019 15:12:49 +0200
Message-ID: <1558098773-47416-1-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
List-Id: linux-input@vger.kernel.org

Hi,

I have to deal with a situation where we have a custom i.MX6 based
platform in production that uses the MPR121 touchkey controller.
Unfortunately the chip is connected using only the I2C interface.
The interrupt line is not used. Back in 2015 (Linux v3.14), my
colleague modded the existing mpr121_touchkey.c driver to use polling
instead of interrupt.

For quite some time yet I am in a process of updating the product from
the ancient Freescale v3.14 kernel to the latest mainline and pushing
any needed changes upstream. The DT files for our imx6dl-yapp4 platform
already made it into v5.1-rc.

I rebased and updated our mpr121 patch to the latest mainline.
It is created as a separate driver, similarly to gpio_keys_polled.

The I2C device is quite susceptible to ESD. An ESD test quite often
causes reset of the chip or some register randomly changes its value.
The [PATCH 3/4] adds a write-through register cache. With the cache
this state can be detected and the device can be re-initialied.

The main question is: Is there any chance that such a polled driver
could be accepted? Is it correct to implement it as a separate driver
or should it be done as an option in the existing driver? I can not
really imagine how I would do that though..

There are also certain worries that the MPR121 chip may no longer be
available in nonspecifically distant future. In case of EOL I will need
to add a polled driver for an other touchkey chip. May it be already
in mainline or a completely new one.

I will appreciate any comments. Thank you in advance,
Michal


Michal Vokáč (4):
  dt-bindings: input: Add support for the MPR121 without interrupt line
  Input: mpr121-polled: Add polling variant of the MPR121 touchkey
    driver
  Input: mpr121-polled: Add write-through cache to detect corrupted
    registers
  ARM: dts: imx6dl-yapp4: Enable MPR121 touch keypad on Hydra

 .../bindings/input/mpr121-touchkey-polled.txt      |  26 ++
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi         |  12 +
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts           |   4 +
 drivers/input/keyboard/Kconfig                     |  13 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/mpr121_touchkey_polled.c    | 493 +++++++++++++++++++++
 6 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt
 create mode 100644 drivers/input/keyboard/mpr121_touchkey_polled.c

-- 
2.1.4
