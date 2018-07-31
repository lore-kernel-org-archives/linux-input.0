From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 0/3] Input: atmel_mxt_ts: Add support for optional regulators
Date: Tue, 31 Jul 2018 17:18:08 +0200
Message-ID: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

Changes from v2:
  - Add reviewed-by to one patch
  - Move code for enabling regulators into separate method,
    to make code more readable.
  - Add wait code, to ensure that device is ready for communication.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Paweł Chmiel (3):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Wait for device be ready for communication
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 +++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 76 ++++++++++++++++++++--
 2 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.7.4
