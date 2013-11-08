From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv3 0/2] twl4030-keypad DT binding
Date: Fri,  8 Nov 2013 23:14:24 +0100
Message-ID: <1383948866-32672-1-git-send-email-sre@debian.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-input@vger.kernel.org

Hi,

Add device tree support for the twl4030 keypad, which is
for example used in the Nokia N900.

Changes since v2 [0]:
 * Removed patches, which add twl4030-keypad node to
   omap3 and nokia n900 dts files. I will send these to
   Benoit once this patchset is queued.
 * Split devicetree binding documentation into its own
   patch.
 * Fix typo in documentation

[0] https://lkml.org/lkml/2013/10/22/141

-- Sebastian

Sebastian Reichel (2):
  Input: twl4030-keypad - add device tree support
  dt: binding documentation for twl4030-keypad

 .../devicetree/bindings/input/twl4030-keypad.txt   | 31 ++++++++
 drivers/input/keyboard/twl4030_keypad.c            | 91 ++++++++++++++++++----
 2 files changed, 105 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt

-- 
1.8.4.rc3

