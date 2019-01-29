From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: sx8654 - do not override interrupt trigger
Date: Mon, 28 Jan 2019 16:37:37 -0800
Message-ID: <20190129003737.GA80949@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Richard Leitner <richard.leitner@skidata.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We should rely on the interrupt trigger (level vs edge) set up by the
firmware or board code instead of forcing what we consider appropriate.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sx8654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 1cc0e4116d3b..b792320d628e 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -403,7 +403,7 @@ static int sx8654_probe(struct i2c_client *client,
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, sx8654->data->irqh,
-					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  IRQF_ONESHOT,
 					  client->name, sx8654);
 	if (error) {
 		dev_err(&client->dev,
-- 
2.20.1.495.gaa96b0ce6b-goog


-- 
Dmitry
