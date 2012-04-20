From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] input: adp5588-keys - get value from data out when dir out
Date: Fri, 20 Apr 2012 11:32:00 -0400
Message-ID: <1334935921-13016-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
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

A similar patch for gpio-adp5588 follows.

Signed-off-by: Jean-Fran=C3=A7ois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/keyboard/adp5588-keys.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyb=
oard/adp5588-keys.c
index 6412ced..b7a0f1a 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -78,6 +78,13 @@ static int adp5588_gpio_get_value(struct gpio_chip *=
chip, unsigned off)
 	unsigned int bank =3D ADP5588_BANK(kpad->gpiomap[off]);
 	unsigned int bit =3D ADP5588_BIT(kpad->gpiomap[off]);
=20
+	mutex_lock(&kpad->gpio_lock);
+	if (kpad->dir[bank] & bit) {
+		int result =3D !!(kpad->dat_out[bank] & bit);
+		mutex_unlock(&kpad->gpio_lock);
+		return result;
+	}
+	mutex_unlock(&kpad->gpio_lock);
 	return !!(adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank) & bit);
 }
=20
--=20
1.7.9
