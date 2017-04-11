From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 3/3] input: touchscreen: ar1021_i2c: coding style fixes
Date: Tue, 11 Apr 2017 12:27:59 +0200
Message-ID: <1491906479-17639-3-git-send-email-martin.kepplinger@ginzinger.com>
References: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, christian.gmeiner@gmail.com
Cc: linux@roeck-us.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

Use the common kernel coding style and corrently align parameters with
open parenthesis.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/input/touchscreen/ar1021_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 1767257..cac7eeb 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -38,7 +38,7 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
 	int retval;
 
 	retval = i2c_master_recv(ar1021->client,
-				ar1021->data, sizeof(ar1021->data));
+				 ar1021->data, sizeof(ar1021->data));
 	if (retval != sizeof(ar1021->data))
 		goto out;
 
@@ -78,7 +78,7 @@ static void ar1021_i2c_close(struct input_dev *dev)
 }
 
 static int ar1021_i2c_probe(struct i2c_client *client,
-				     const struct i2c_device_id *id)
+			    const struct i2c_device_id *id)
 {
 	struct ar1021_i2c *ar1021;
 	struct input_dev *input;
-- 
2.1.4
