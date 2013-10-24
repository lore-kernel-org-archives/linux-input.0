From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv6 0/3] DT Support for TWL4030 power button
Date: Thu, 24 Oct 2013 16:48:43 +0200
Message-ID: <1382626126-12565-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Sebastian Reichel <sre@debian.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sachin Kamat <sachin.kamat@linaro.org>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

This is the sixth iteration of DT support for the TWL4030
power button.

Changes since v5 [0]:
* Updated documentation

[0] https://lkml.org/lkml/2013/10/23/416

-- Sebastian

Sebastian Reichel (3):
  Input: twl4030-pwrbutton - add device tree support
  Input: twl4030-pwrbutton: use dev_err for errors
  Input: twl4030-pwrbutton: simplify driver using devm_*

 .../bindings/input/twl4030-pwrbutton.txt           | 21 +++++++++++
 drivers/input/misc/twl4030-pwrbutton.c             | 44 +++++++++-------------
 2 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt

-- 
1.8.4.rc3
