From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] Make gpiolib work with static device properties
Date: Sat, 13 Jul 2019 00:52:57 -0700
Message-ID: <20190713075259.243565-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi,

These 2 patches implement GPIOs lookup for boards still using static
properties (instead of OF or ACPI), which will allow drivers to abandon
the custom platform data structures and switch to using generic bindings
with gpiod_get_*() API working transparently.

The 2nd patch was posted in September of 2018, before Heikki did the
switch from psets to software_nodes; I finally rebased it.

Enrico, it looks like you are working with a board that uses gpio_keys
that still uses platform data, it would be great if you could try this
out as I have not.

Thanks!

Dmitry Torokhov (2):
  drivers: base: swnode: link devices to software nodes
  gpiolib: add support for fetching descriptors from static properties

 drivers/base/property.c  |   1 +
 drivers/base/swnode.c    |  35 ++++++++++++-
 drivers/gpio/gpiolib.c   | 108 ++++++++++++++++++++++++++++-----------
 include/linux/property.h |   5 ++
 4 files changed, 119 insertions(+), 30 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog
