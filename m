From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V2] input: da9063: report KEY_POWER instead of KEY_SLEEP
 during power key-press
Date: Thu, 10 Dec 2015 09:37:13 +0000
Message-ID: <20151210093632.5DF333FBD7@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>
Cc: David Dajun Chen <david.chen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Stop reporting KEY_SLEEP for a short key-press and report KEY_POWER instead
This change applies to both DA9063 and DA9062 ONKEY drivers.

A previous application used for testing by the developer required a KEY_SLEEP
and KEY_POWER input_report_key event to distinguish between a short and
long key-press of the power key.
This is not the general convention and the typical solution is for KEY_POWER
to be used in both cases: suspend and S/W power off.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.4-rc4

Dmitry,

Now I realise what you meant in a previous review of this driver.

- https://lkml.org/lkml/2015/4/17/618
> Why do we handle KEY_POWER and KEY_SLEEP completely differently?

Because my testing assumed KEY_SLEEP was linked to suspend and KEY_POWER was
linked to S/W power off

- https://lkml.org/lkml/2015/4/29/406
> (1) short press & release -- SLEEP
> (2) long press & release -- POWER

This change removes the reporting of KEY_SLEEP that was specific to my test
framework and replaces it with the intended KEY_POWER.

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/input/misc/da9063_onkey.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 8eb697d..bb863e0 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -179,13 +179,13 @@ static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
 		input_report_key(onkey->input, KEY_POWER, 1);
 		input_sync(onkey->input);
 		schedule_delayed_work(&onkey->work, 0);
-		dev_dbg(onkey->dev, "KEY_POWER pressed.\n");
+		dev_dbg(onkey->dev, "KEY_POWER long press.\n");
 	} else {
-		input_report_key(onkey->input, KEY_SLEEP, 1);
+		input_report_key(onkey->input, KEY_POWER, 1);
 		input_sync(onkey->input);
-		input_report_key(onkey->input, KEY_SLEEP, 0);
+		input_report_key(onkey->input, KEY_POWER, 0);
 		input_sync(onkey->input);
-		dev_dbg(onkey->dev, "KEY_SLEEP pressed.\n");
+		dev_dbg(onkey->dev, "KEY_POWER short press.\n");
 	}
 
 	return IRQ_HANDLED;
-- 
end-of-patch for PATCH V2
