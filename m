From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/33] Input: bcm-keypad - Drop unnecessary call to platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 09:46:23 -0800
Message-ID: <1484761614-12225-3-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
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
 drivers/input/keyboard/bcm-keypad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index 86a8b723ae15..2b4e63d81e6d 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -352,8 +352,6 @@ static int bcm_kp_probe(struct platform_device *pdev)
 
 	kp->input_dev = input_dev;
 
-	platform_set_drvdata(pdev, kp);
-
 	error = bcm_kp_matrix_key_parse_dt(kp);
 	if (error)
 		return error;
-- 
2.7.4
