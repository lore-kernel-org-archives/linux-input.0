From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/2] gpio: adp5588: get value from data out when dir is
 out
Date: Mon, 10 Feb 2014 20:16:42 +0000
Message-ID: <78F369B105E123488216BDB7B6C397DA339E3D76@NWD2MBX6.ad.analog.com>
References: <1392051929-32290-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1392051929-32290-1-git-send-email-jeff.dagenais@gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "dtor@mail.ru" <dtor@mail.ru>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "gnurou@gmail.com" <gnurou@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



-----Original Message-----
From: Jean-Francois Dagenais [mailto:jeff.dagenais@gmail.com] 
Sent: Montag, 10. Februar 2014 18:05
To: Hennerich, Michael; dmitry.torokhov@gmail.com; dtor@mail.ru; linus.walleij@linaro.org; gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org; linux-input@vger.kernel.org; Jean-Francois Dagenais
Subject: [PATCH 1/2] gpio: adp5588: get value from data out when dir is out

As discussed here: http://ez.analog.com/message/35852,
the 5587 revC and 5588 revB spec sheets contain a mistake in the GPIO_DAT_STATx register description.

According to R.Shnell at ADI, as well as my own observations, it should read:
"GPIO data status (shows GPIO state when read for inputs)".

This commit changes the get value function accordingly.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/gpio/gpio-adp5588.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c index 3f190e6..7d3c8d9 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -67,9 +67,20 @@ static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)  {
 	struct adp5588_gpio *dev =
 	    container_of(chip, struct adp5588_gpio, gpio_chip);
+	unsigned bank = ADP5588_BANK(off);
+	unsigned bit = ADP5588_BIT(off);
+	int val;
 
-	return !!(adp5588_gpio_read(dev->client,
-		  GPIO_DAT_STAT1 + ADP5588_BANK(off)) & ADP5588_BIT(off));
+	mutex_lock(&dev->lock);
+
+	if (dev->dir[bank] & bit)
+		val = dev->dat_out[bank];
+	else
+		val = adp5588_gpio_read(dev->client, GPIO_DAT_STAT1 + bank);
+
+	mutex_unlock(&dev->lock);
+
+	return !!(val & bit);
 }
 
 static void adp5588_gpio_set_value(struct gpio_chip *chip,
--
1.8.5.3



