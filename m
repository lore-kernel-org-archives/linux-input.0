From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv7 0/4] twl4030-pwrbutton DT binding
Date: Fri,  8 Nov 2013 23:11:23 +0100
Message-ID: <1383948687-32279-1-git-send-email-sre@debian.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-input@vger.kernel.org

Hi,

This is the seventh iteration of DT support for the TWL4030
power button.

Changes since v6 [0]:
* Splitted DT binding documentation into its own patch
* Updated commit message of first patch
* Added Reviewed-by: Aaro Koskinen
* Added Tested-by: Florian Vaussard
* Added Acked-by: Kumar Gala

[0] https://lkml.org/lkml/2013/10/24/269

-- Sebastian

Sebastian Reichel (4):
  Input: twl4030-pwrbutton: add device tree support
  dt: binding documentation for twl4030-pwrbutton
  Input: twl4030-pwrbutton: use dev_err for errors
  Input: twl4030-pwrbutton: simplify driver using devm_*

 .../bindings/input/twl4030-pwrbutton.txt           | 21 +++++++++++
 drivers/input/misc/twl4030-pwrbutton.c             | 44 +++++++++-------------
 2 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt

-- 
1.8.4.rc3

