From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date: Thu, 21 Mar 2019 13:51:00 +0530
Message-ID: <20190321082104.2874-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

This is v7 patchset for supporting goodix GT5553 CTP. Here is the
previous version[1]

Changes for v5:
- rebase on linux-next
Changes for v5:
- document bindings for required regulators, which are need during
  power-on sequence
- enable, disable required regulators as described in power-on sequence
  using normal regulator calls
- update the proper commi messages
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

[1] https://patchwork.kernel.org/cover/10819645/

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document regulator properties
  Input: goodix - Add regulators suppot
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  3 +
 drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.18.0.321.gffc6fa0e3
