From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 32/33] Input: sis_i2c - Drop unnecessary call to i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 12:36:49 -0800
Message-ID: <1484771819-13761-3-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484771819-13761-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484771819-13761-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Tammy Tseng <tammy_tseng@sis.com>, Yuger Yu <yuger_yu@sis.com>
List-Id: linux-input@vger.kernel.org

There is no call to i2c_get_clientdata() or dev_get_drvdata().
Drop the unnecessary call to i2c_set_clientdata().

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop i2c_set_clientdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/sis_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchscreen/sis_i2c.c
index 8d93f8c9a403..67c2563031d6 100644
--- a/drivers/input/touchscreen/sis_i2c.c
+++ b/drivers/input/touchscreen/sis_i2c.c
@@ -316,7 +316,6 @@ static int sis_ts_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	ts->client = client;
-	i2c_set_clientdata(client, ts);
 
 	ts->attn_gpio = devm_gpiod_get_optional(&client->dev,
 						"attn", GPIOD_IN);
-- 
2.7.4
