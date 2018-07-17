From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/2] Input: atmel_mxt_ts: Add support for optional regulators
Date: Tue, 17 Jul 2018 20:16:24 +0200
Message-ID: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-input@vger.kernel.org

This two patches add optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch updates documentation.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Paweł Chmiel (2):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 ++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 46 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.7.4
