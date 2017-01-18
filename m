From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 15/33] Input: kxtj9 - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:36 -0800
Message-ID: <1484761614-12225-16-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Error messages after memory allocation failures are unnecessary and
can be dropped.
Other relevant changes:
  Simplify error return

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unnecessary braces around conditional return statements
- Drop error message after devm_kzalloc() failure
- Replace 'if (e) return e; return 0;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/kxtj9.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index efaffcc57e36..1c96e30834fc 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -196,11 +196,8 @@ static int kxtj9_update_odr(struct kxtj9_data *tj9, unsigned int poll_interval)
 	if (err < 0)
 		return err;
 
-	err = i2c_smbus_write_byte_data(tj9->client, CTRL_REG1, tj9->ctrl_reg1);
-	if (err < 0)
-		return err;
-
-	return 0;
+	return i2c_smbus_write_byte_data(tj9->client, CTRL_REG1,
+					 tj9->ctrl_reg1);
 }
 
 static int kxtj9_device_power_on(struct kxtj9_data *tj9)
@@ -526,11 +523,8 @@ static int kxtj9_probe(struct i2c_client *client,
 	}
 
 	tj9 = kzalloc(sizeof(*tj9), GFP_KERNEL);
-	if (!tj9) {
-		dev_err(&client->dev,
-			"failed to allocate memory for module data\n");
+	if (!tj9)
 		return -ENOMEM;
-	}
 
 	tj9->client = client;
 	tj9->pdata = *pdata;
-- 
2.7.4
