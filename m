From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date: Sat, 15 Dec 2018 20:47:58 +0530
Message-ID: <20181215151802.18592-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

This patchset support goodix GT5553 CTP.

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

 .../bindings/input/touchscreen/goodix.txt     |  2 ++
 drivers/input/touchscreen/goodix.c            | 35 ++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.18.0.321.gffc6fa0e3
