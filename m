From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/4] gpio: make gpiod_count() API consistent
Date: Mon, 20 Feb 2017 18:15:45 +0200
Message-ID: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

There are three possibilities in gpiod_count(): ACPI, OF, and
platform data.

Some of them return 0, which requires to be handled separately, though
developers rather lazy and just shadow an actual error code.

Let's make this API consistent by not allowing 0 in returned value.

There are luckily only 3 users right now, one of them handles this
properly, the rest is converted in this series.

Series is supposed to go through GPIO tree.

Andy Shevchenko (4):
  gpio: acpi: Don't return 0 on acpi_gpio_count()
  gpio: of: Don't return 0 on dt_gpio_count()
  platform/x86: surface3_button: Propagate error from gpiod_count()
  Input: soc_button_array - Propagate error from gpiod_count()

 drivers/gpio/gpiolib-acpi.c            | 4 ++--
 drivers/gpio/gpiolib.c                 | 4 ++--
 drivers/input/misc/soc_button_array.c  | 5 +++--
 drivers/platform/x86/surface3_button.c | 5 +++--
 4 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.11.0
