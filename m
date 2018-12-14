From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v5 0/3] Input: atmel_mxt_ts: Add support for optional regulators
Date: Fri, 14 Dec 2018 16:12:11 +0100
Message-ID: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch series adds optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch ensures that device is ready for communication.
Third patch updates documentation.

Changes from v4:
  - Add missing regulator_disable for vdd in case of error,
    when enabling avdd regulator

Changes from v3:
  - Checkpatch fixes
  - Drop punctuation from subject of one of patches

Changes from v2:
  - Add reviewed-by to one patch
  - Move code for enabling regulators into separate method,
    to make code more readable.
  - Add wait code, to ensure that device is ready for communication.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Paweł Chmiel (3):
  Input: atmel_mxt_ts: Add support for  optional regulators
  Input: atmel_mxt_ts: Wait for device be ready for communication
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../bindings/input/atmel,maxtouch.txt         |  8 ++
 drivers/input/touchscreen/atmel_mxt_ts.c      | 78 +++++++++++++++++--
 2 files changed, 80 insertions(+), 6 deletions(-)

-- 
2.17.1
