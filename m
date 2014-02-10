From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 2/2] gpio: adp5588 - add support for gpio names
Date: Mon, 10 Feb 2014 12:24:05 -0500
Message-ID: <1392053045-12121-2-git-send-email-jeff.dagenais@gmail.com>
References: <1392053045-12121-1-git-send-email-jeff.dagenais@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1392053045-12121-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: michael.hennerich@analog.com, dmitry.torokhov@gmail.com, dtor@mail.ru, linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Jean-Francois Dagenais <jeff.dagenais@gmail.com>
List-Id: linux-input@vger.kernel.org

which is already found in the common header for adp5588

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/gpio/gpio-adp5588.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index 7d3c8d9..d974020 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -397,6 +397,7 @@ static int adp5588_gpio_probe(struct i2c_client *client,
 	gc->ngpio = ADP5588_MAXGPIO;
 	gc->label = client->name;
 	gc->owner = THIS_MODULE;
+	gc->names = pdata->names;
 
 	mutex_init(&dev->lock);
 
-- 
1.8.5.3

