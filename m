From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 12/33] Input: axp20x-pek - Use devm_add_action_or_reset and other changes
Date: Wed, 18 Jan 2017 09:46:33 -0800
Message-ID: <1484761614-12225-13-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-input@vger.kernel.org

Replace devm_add_action() followed by failure action with
devm_add_action_or_reset()

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace devm_add_action() followed by failure action with
  devm_add_action_or_reset()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/axp20x-pek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 1ac898db303a..419ca97b051b 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -260,10 +260,10 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = devm_add_action(&pdev->dev,
-				axp20x_remove_sysfs_group, &pdev->dev);
+	error = devm_add_action_or_reset(&pdev->dev,
+					 axp20x_remove_sysfs_group,
+					 &pdev->dev);
 	if (error) {
-		axp20x_remove_sysfs_group(&pdev->dev);
 		dev_err(&pdev->dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
-- 
2.7.4
