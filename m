From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] input: gpio_keys: Convert to GPIO descriptors
Date: Fri, 19 Feb 2016 11:16:19 +0100
Message-ID: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

	Hi Dmitry,

GPIO descriptors are the preferred way over legacy GPIO numbers
nowadays.  This patch series converts the gpio_keys driver to use GPIO
descriptors, like was done before for gpio_keys_polled.

As a bonus, support for ACPI based systems was added by making use of
the device property API. While this is not required for my use case, it
was easy to do, and keeps gpio_keys and gpio_keys_polled in sync.

This has been tested on a DT-based system only (r8a7791/koelsch).

Thanks for your comments!

Geert Uytterhoeven (3):
  input: gpio_keys: Add support for GPIO descriptors
  input: gpio_keys: Switch from irq_of_parse_and_map() to
    platform_get_irq()
  input: gpio_keys: Make use of the device property API

 drivers/input/keyboard/gpio_keys.c | 133 ++++++++++++++++++-------------------
 include/linux/gpio_keys.h          |   2 +-
 2 files changed, 66 insertions(+), 69 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
