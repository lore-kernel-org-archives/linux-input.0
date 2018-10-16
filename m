From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 0/7] Input: sx8654 - reset-gpio, sx865[056] support, etc.
Date: Tue, 16 Oct 2018 11:16:46 +0200
Message-ID: <20181016091653.26896-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

Add reset-gpio, sx8654[056] and common of_touchscreen functions support
for the sx8654 driver.

Richard Leitner (7):
  dt-bindings: input: touchscreen: sx8654: add reset-gpio property
  Input: sx8654 - add reset-gpio support
  dt-bindings: input: touchscreen: sx8654: add compatible models
  Input: sx8654 - add sx8655 and sx8656 to compatibles
  dt-bindings: input: touchscreen: sx8654: add sx8650 to comatibles
  Input: sx8654 - add sx8650 support
  Input: sx8654 - use common of_touchscreen functions

 .../bindings/input/touchscreen/sx8654.txt          |  10 +-
 drivers/input/touchscreen/sx8654.c                 | 267 ++++++++++++++++++---
 2 files changed, 245 insertions(+), 32 deletions(-)

-- 
2.11.0
