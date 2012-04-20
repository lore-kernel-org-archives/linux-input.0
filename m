From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
Subject: [PATCH 2/2] gpio: adp5588 - get value from data out when dir out
Date: Fri, 20 Apr 2012 11:32:01 -0400
Message-ID: <1334935921-13016-2-git-send-email-jeff.dagenais@gmail.com>
References: <1334935921-13016-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334935921-13016-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, dtor@mail.ru, dmitry.torokhov@gmail.com, linus.walleij@stericsson.com, linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, michael.hennerich@analog.com, =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
List-Id: linux-input@vger.kernel.org

As discussed here: http://ez.analog.com/message/35852,
the 5587 revC and 5588 revB spec sheets contain a mistake
in the GPIO_DAT_STATx register description.

According to R.Shnell at ADI, as well as my own
observations, it should read:
"GPIO data status (shows GPIO state when read for inputs)".

This commit changes the get value function accordingly.

=46ollows a similar patch for adp5588-keys.

Signed-off-by: Jean-Fran=C3=A7ois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/gpio/gpio-adp5588.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index 3122713..293ddb6 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -65,11 +65,23 @@ static int adp5588_gpio_write(struct i2c_client *cl=
ient, u8 reg, u8 val)
=20
 static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off=
)
 {
+	unsigned bank, bit;
 	struct adp5588_gpio *dev =3D
 	    container_of(chip, struct adp5588_gpio, gpio_chip);
=20
+	bank =3D ADP5588_BANK(off);
+	bit =3D ADP5588_BIT(off);
+
+	mutex_lock(&dev->lock);
+	if (dev->dir[bank] & bit) {
+		int result =3D !!(dev->dat_out[bank] & bit);
+		mutex_unlock(&dev->lock);
+		return result;
+	}
+	mutex_unlock(&dev->lock);
+
 	return !!(adp5588_gpio_read(dev->client,
-		  GPIO_DAT_STAT1 + ADP5588_BANK(off)) & ADP5588_BIT(off));
+		  GPIO_DAT_STAT1 + bank) & bit);
 }
=20
 static void adp5588_gpio_set_value(struct gpio_chip *chip,
--=20
1.7.9
