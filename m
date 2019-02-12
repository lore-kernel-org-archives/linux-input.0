From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date: Tue, 12 Feb 2019 16:54:35 +0530
Message-ID: <20190212112439.2025-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

This patchset support goodix GT5553 CTP.

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

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document AVDD28-supply
    property
  Input: goodix - Add AVDD28-supply regulator support
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  2 +
 drivers/input/touchscreen/goodix.c            | 46 +++++++++++++++++--
 2 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.18.0.321.gffc6fa0e3
