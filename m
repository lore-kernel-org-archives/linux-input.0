From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 10/33] Input: twl4030_keypad - Drop unnecessary call to platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 09:46:31 -0800
Message-ID: <1484761614-12225-11-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Rui Teng <rui.teng@linux.vnet.ibm.com>
List-Id: linux-input@vger.kernel.org

There is no call to platform_get_drvdata() or dev_get_drvdata().
Drop the unnecessary call to platform_set_drvdata().

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop platform_set_drvdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/twl4030_keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 323a0fb575a4..29396ca69416 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -441,7 +441,6 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 		return -EIO;
 	}
 
-	platform_set_drvdata(pdev, kp);
 	return 0;
 }
 
-- 
2.7.4
