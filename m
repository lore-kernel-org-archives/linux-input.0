From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 16/33] Input: mma8450 - Drop unnecessary call to i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 09:46:37 -0800
Message-ID: <1484761614-12225-17-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
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
 drivers/input/misc/mma8450.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 19c73574458e..b60cdea73826 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -205,8 +205,6 @@ static int mma8450_probe(struct i2c_client *c,
 		return err;
 	}
 
-	i2c_set_clientdata(c, m);
-
 	return 0;
 }
 
-- 
2.7.4
