From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 10/13] Input: misc - drop unnecessary calls to device_init_wakeup
Date: Sat, 21 Jan 2017 10:46:02 -0800
Message-ID: <1485024365-3368-11-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org, usrp-users@lists.ettus.com
List-Id: linux-input@vger.kernel.org

Calling device_init_wakeup in the remove function is unnecessary since the
device is going away, and thus won't be able to cause any wakeups under any
circumstances. Besides, the driver cleanup code already handles the
necessary cleanup.

Similar, disabling wakeup in the probe error path is unnecessary, as is
disabling wakeup in the probe function in the first place.

Changes were done automatically using the following coccinelle script.

@probe@
identifier p, probefn;
declarer name module_platform_driver_probe;
position pos;
@@
(
  module_platform_driver_probe(p, probefn@pos);
|
  struct platform_driver p = {
    .probe = probefn@pos,
  };
|
  struct i2c_driver p = {
    .probe = probefn@pos,
  };
|
  struct spi_driver p = {
    .probe = probefn@pos,
  };
)

@remove@
identifier p, removefn;
@@

  struct
(
  platform_driver
|
  i2c_driver
|
  spi_driver
|
  hv_driver
)
  p = {
    .remove = \(__exit_p(removefn)\|removefn\),
  };

@depends on remove@
identifier remove.removefn;
@@

removefn(...) {
<+...
- device_init_wakeup(...);
...+>
}

@depends on probe@
identifier probe.probefn;
expression dev;
@@

probefn(...) {
<+...
- device_init_wakeup(..., \(false\|0\));
  ...+>
}

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/88pm80x_onkey.c   | 1 -
 drivers/input/misc/e3x0-button.c     | 1 -
 drivers/input/misc/gp2ap002a00f.c    | 2 --
 drivers/input/misc/hisi_powerkey.c   | 2 --
 drivers/input/misc/pm8941-pwrkey.c   | 1 -
 drivers/input/misc/pmic8xxx-pwrkey.c | 2 --
 drivers/input/misc/sirfsoc-onkey.c   | 2 --
 7 files changed, 11 deletions(-)

diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index cf9908f1e5d5..45a09497f680 100644
--- a/drivers/input/misc/88pm80x_onkey.c
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -143,7 +143,6 @@ static int pm80x_onkey_remove(struct platform_device *pdev)
 {
 	struct pm80x_onkey_info *info = platform_get_drvdata(pdev);
 
-	device_init_wakeup(&pdev->dev, 0);
 	pm80x_free_irq(info->pm80x, info->irq, info);
 	input_unregister_device(info->idev);
 	kfree(info);
diff --git a/drivers/input/misc/e3x0-button.c b/drivers/input/misc/e3x0-button.c
index b0b374112db3..1e50314db1ab 100644
--- a/drivers/input/misc/e3x0-button.c
+++ b/drivers/input/misc/e3x0-button.c
@@ -126,7 +126,6 @@ static int e3x0_button_probe(struct platform_device *pdev)
 
 static int e3x0_button_remove(struct platform_device *pdev)
 {
-	device_init_wakeup(&pdev->dev, 0);
 	return 0;
 }
 
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 3bfdfcc20485..c6a29e57b5e4 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -210,8 +210,6 @@ static int gp2a_remove(struct i2c_client *client)
 	struct gp2a_data *dt = i2c_get_clientdata(client);
 	const struct gp2a_platform_data *pdata = dt->pdata;
 
-	device_init_wakeup(&client->dev, false);
-
 	free_irq(client->irq, dt);
 
 	input_unregister_device(dt->input);
diff --git a/drivers/input/misc/hisi_powerkey.c b/drivers/input/misc/hisi_powerkey.c
index c4c42124a059..baa81dccfc1f 100644
--- a/drivers/input/misc/hisi_powerkey.c
+++ b/drivers/input/misc/hisi_powerkey.c
@@ -122,8 +122,6 @@ static int hi65xx_powerkey_probe(struct platform_device *pdev)
 
 static int hi65xx_powerkey_remove(struct platform_device *pdev)
 {
-	device_init_wakeup(&pdev->dev, 0);
-
 	return 0;
 }
 
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index e317b75357a0..18ad956454f1 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -266,7 +266,6 @@ static int pm8941_pwrkey_remove(struct platform_device *pdev)
 {
 	struct pm8941_pwrkey *pwrkey = platform_get_drvdata(pdev);
 
-	device_init_wakeup(&pdev->dev, 0);
 	unregister_reboot_notifier(&pwrkey->reboot_notifier);
 
 	return 0;
diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index 67aab86048ad..c75be2dd00e7 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -440,8 +440,6 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 
 static int pmic8xxx_pwrkey_remove(struct platform_device *pdev)
 {
-	device_init_wakeup(&pdev->dev, 0);
-
 	return 0;
 }
 
diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index ed7237f19539..a2ed0e4fcd0b 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -174,8 +174,6 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 static int sirfsoc_pwrc_remove(struct platform_device *pdev)
 {
-	device_init_wakeup(&pdev->dev, 0);
-
 	return 0;
 }
 
-- 
2.7.4
