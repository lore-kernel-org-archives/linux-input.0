From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 0/7] Input: sx8654 - reset-gpio, sx865[056] support, etc.
Date: Wed, 17 Oct 2018 14:51:08 +0200
Message-ID: <20181017125116.20077-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

Add reset-gpio, sx8654[056] and common of_touchscreen functions support
for the sx8654 driver.

Changes v2:
	- use devm_gpiod_get_optional in probe instead of in #ifdef CONFIG_OF
	- convert flags to BIT() in a separate patch
	- replace hrtimer with "regular" timer
	- use of_device_get_match_data instead of of_match_device
	- add driver data to i2c_device_id table for non-DT fallback
	- fix sequence of common touchscreen initialization
	- div. minor stlye changes

Richard Leitner (8):
  dt-bindings: input: touchscreen: sx8654: add reset-gpio property
  Input: sx8654 - add reset-gpio support
  dt-bindings: input: touchscreen: sx8654: add compatible models
  Input: sx8654 - add sx8655 and sx8656 to compatibles
  dt-bindings: input: touchscreen: sx8654: add sx8650 to comatibles
  Input: sx8654 - add sx8650 support
  Input: sx8654 - use common of_touchscreen functions
  Input: sx8654 - convert #defined flags to BIT(x)

 .../bindings/input/touchscreen/sx8654.txt          |  10 +-
 drivers/input/touchscreen/sx8654.c                 | 245 ++++++++++++++++++---
 2 files changed, 229 insertions(+), 26 deletions(-)

-- 
2.11.0
