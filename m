From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ps2-gpio - flush TX work when closing port
Date: Thu, 7 Feb 2019 14:27:40 -0800
Message-ID: <20190207222740.GA38612@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sven Van Asbroeck <thesven73@gmail.com>, Danilo Krummrich <danilokrummrich@dk-develop.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

To ensure that TX work is not running after serio port has been torn down,
let's flush it when closing the port.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/ps2-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index c62cceb97bb1..9e1dbde2e15b 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -76,6 +76,7 @@ static void ps2_gpio_close(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
+	flush_work(&drvdata->tx_work.work);
 	disable_irq(drvdata->irq);
 }
 
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
