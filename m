From: "Jingoo Han" <jingoohan1@gmail.com>
Subject: Re: [PATCH v3 06/17] video: lcd: add LoCoMo LCD driver
Date: Wed, 20 May 2015 21:26:45 +0900
Message-ID: <000001d092f8$42fc9aa0$c8f5cfe0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Language: ko
Sender: linux-leds-owner@vger.kernel.org
To: 'Dmitry Eremin-Solenikov' <dbaryshkov@gmail.com>, 'Lee Jones' <lee.jones@linaro.org>
Cc: 'Russell King' <linux@arm.linux.org.uk>, 'Daniel Mack' <zonque@gmail.com>, 'Robert Jarzmik' <robert.jarzmik@free.fr>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Alexandre Courbot' <acourbot@nvidia.com>, 'Wolfram Sang' <wsa@the-dreams.de>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Samuel Ortiz' <sameo@linux.intel.com>, 'Mark Brown' <broonie@linaro.org>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Liam Girdwood' <liam.r.girdwood@linux.intel.com>, 'Andrea Adami' <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpiol@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

> LoCoMo has some special handling for TFT screens attached to Collie and
> Poodle. Implement that as a separate driver.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/Kconfig      |  10 ++
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/locomo_lcd.c | 285 +++++++++++++++++++++++++++++++++++
>  3 files changed, 296 insertions(+)
>  create mode 100644 drivers/video/backlight/locomo_lcd.c
