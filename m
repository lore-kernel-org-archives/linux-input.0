From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 2/2] gpio: adp5588 - add support for gpio names
Date: Mon, 10 Feb 2014 20:17:03 +0000
Message-ID: <78F369B105E123488216BDB7B6C397DA339E3D85@NWD2MBX6.ad.analog.com>
References: <1392053045-12121-1-git-send-email-jeff.dagenais@gmail.com>
 <1392053045-12121-2-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1392053045-12121-2-git-send-email-jeff.dagenais@gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "dtor@mail.ru" <dtor@mail.ru>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "gnurou@gmail.com" <gnurou@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



-----Original Message-----
From: Jean-Francois Dagenais [mailto:jeff.dagenais@gmail.com] 
Sent: Montag, 10. Februar 2014 18:24
To: Hennerich, Michael; dmitry.torokhov@gmail.com; dtor@mail.ru; linus.walleij@linaro.org; gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org; linux-input@vger.kernel.org; Jean-Francois Dagenais
Subject: [PATCH 2/2] gpio: adp5588 - add support for gpio names

which is already found in the common header for adp5588

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/gpio/gpio-adp5588.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c index 7d3c8d9..d974020 100644
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



