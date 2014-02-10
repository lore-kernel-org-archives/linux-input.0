From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/2] gpio: adp5588 - use "unsigned" for the setup and
 teardown callbacks
Date: Mon, 10 Feb 2014 20:16:55 +0000
Message-ID: <78F369B105E123488216BDB7B6C397DA339E3D7E@NWD2MBX6.ad.analog.com>
References: <1392053045-12121-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1392053045-12121-1-git-send-email-jeff.dagenais@gmail.com>
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
Subject: [PATCH 1/2] gpio: adp5588 - use "unsigned" for the setup and teardown callbacks

to comply with the rest of the GPIO drivers.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 include/linux/i2c/adp5588.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h index d8341cb..c215304 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -161,10 +161,10 @@ struct adp5588_gpio_platform_data {
 	unsigned irq_base;	/* interrupt base # */
 	unsigned pullup_dis_mask; /* Pull-Up Disable Mask */
 	int	(*setup)(struct i2c_client *client,
-				int gpio, unsigned ngpio,
+				unsigned gpio, unsigned ngpio,
 				void *context);
 	int	(*teardown)(struct i2c_client *client,
-				int gpio, unsigned ngpio,
+				unsigned gpio, unsigned ngpio,
 				void *context);
 	void	*context;
 };
--
1.8.5.3



