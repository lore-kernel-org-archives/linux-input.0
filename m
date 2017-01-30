From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 0/2] gpio: Add the devm_fwnode_get_index_gpiod_from_child() helper
Date: Mon, 30 Jan 2017 16:41:47 +0100
Message-ID: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-input@vger.kernel.org

Hello Linus,

I send these 2 patches separately from the Atmel NAND driver rework
since these are self-contained and do not have any external
dependencies.

Feel free to apply them in your tree if you are happy with this
version and once other subsystem maintainers have acked patch 1.

Thanks,

Boris

---
Changes since v1:
- Rename the devm_get_gpiod_from_child() helper into
  devm_fwnode_get_gpiod_from_child()
- Define as a static inline wrapper around
  devm_fwnode_get_gpiod_from_child()

Boris Brezillon (2):
  gpio: Rename devm_get_gpiod_from_child()
  gpio: Add the devm_fwnode_get_index_gpiod_from_child() helper

 drivers/gpio/devres.c                     | 14 ++++++++------
 drivers/gpio/gpiolib.c                    |  9 +++++----
 drivers/input/keyboard/gpio_keys.c        |  3 ++-
 drivers/input/keyboard/gpio_keys_polled.c |  5 +++--
 drivers/leds/leds-gpio.c                  |  2 +-
 drivers/video/fbdev/amba-clcd-nomadik.c   |  8 ++++----
 include/linux/gpio/consumer.h             | 23 ++++++++++++++++-------
 7 files changed, 39 insertions(+), 25 deletions(-)

-- 
2.7.4
