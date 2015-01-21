From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: [PATCH v2 0/4] Let leds use named gpios
Date: Wed, 21 Jan 2015 22:33:44 +0100
Message-ID: <1421876028-22799-1-git-send-email-o.schinagl@ultimaker.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Olliver Schinagl <oliver@schinagl.nl>, Robin Gong <b38343@freescale.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>, Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, Olliver Schinagl <o.schinagl@ultimaker.com>
List-Id: linux-input@vger.kernel.org

The gpio binding docs ask to use named-gpios wherever possible, however 40b73183 probably forgot that. This patch makes the new devm_get_gpiod_from_child use named gpios.

Changed since v1:
  Fix a few typo's
  Fix of_find_gpio to remove hardcoded length of string
  Check both for leds-gpios and if that fails, fall back to standard gpios for the users of devm_get_gpiod_from_child.

Olliver Schinagl (4):
  gpio: use sizeof() instead of hardcoded values
  gpio: add parameter to allow the use named gpios
  leds: Let the binding document example for leds-gpio follow the gpio
    bindings
  leds: no longer use unnamed gpios

 Documentation/devicetree/bindings/leds/leds-gpio.txt | 14 ++++++++------
 drivers/gpio/devres.c                                | 18 +++++++++++++++++-
 drivers/gpio/gpiolib.c                               |  6 ++++--
 drivers/input/keyboard/gpio_keys_polled.c            | 20 ++++++++++++--------
 drivers/leds/leds-gpio.c                             |  2 +-
 include/linux/gpio/consumer.h                        |  1 +
 6 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.1.4

