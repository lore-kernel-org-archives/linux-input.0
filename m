From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 27/33] Input: eeti_ts - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:48 -0800
Message-ID: <1484761614-12225-28-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Error messages after memory allocation failures are unnecessary and
can be dropped.

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unnecessary braces around conditional return statements
- Drop error message after devm_kzalloc() failure
- Replace 'goto l; ... l: return e;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/eeti_ts.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 09be6ced7151..de3f4a1e8416 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -171,10 +171,8 @@ static int eeti_ts_probe(struct i2c_client *client,
 	 */
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&client->dev, "failed to allocate driver data\n");
-		goto err0;
-	}
+	if (!priv)
+		return err;
 
 	mutex_init(&priv->mutex);
 	input = input_allocate_device();
@@ -243,7 +241,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 err1:
 	input_free_device(input);
 	kfree(priv);
-err0:
 	return err;
 }
 
-- 
2.7.4
