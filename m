From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1] input: da9063: report KEY_POWER instead of KEY_SLEEP
 during power key-press
Date: Tue, 8 Dec 2015 17:55:05 +0000
Message-ID: <20151208180554.F29B93FB25@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>
Cc: David Dajun Chen <david.chen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Stop reporting KEY_SLEEP for a short key-press and report KEY_POWER instead
This change applied to both DA9063 and DA9062 ONKEY drivers.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---

This patch applies against linux-next and v4.4-rc4

Regards,
Steve


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
end-of-patch for PATCH V1
