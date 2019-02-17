From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date: Sun, 17 Feb 2019 14:44:32 +0530
Message-ID: <20190217091436.3702-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

This is v5 patchset for supporting goodix GT5553 CTP. Here is the
previous version[1]

Changes for v4:
- document AVDD22, DVDD12, VDDIO as optional properties
- use regulator bulk calls, for get, enable and disable functionalities
Changes for v4:
- devm_add_action_or_reset for disabling regulator
Changes for v3:
- add cover-letter
- s/ADVV28/AVDD28 on commit head
- fix few typo
Changes for v2:
- Rename vcc-supply with AVDD28-supply
- disable regulator in remove
- fix to setup regulator in probe code
- add chipdata
- drop example node in dt-bindings

[1] https://patchwork.kernel.org/cover/10807779/

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document regulator properties
  Input: goodix - Add regulators support
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  8 +++
 drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++--
 2 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.18.0.321.gffc6fa0e3
