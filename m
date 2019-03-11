From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/27] Input: ps2-gpio - flush TX work when closing port
Date: Mon, 11 Mar 2019 15:58:11 -0400
Message-ID: <20190311195824.139043-14-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 33a841ce5cef4ca6c18ad333248b6d273f54c839 ]

To ensure that TX work is not running after serio port has been torn down,
let's flush it when closing the port.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Acked-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/ps2-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index b50e3817f3c4..4a64ab30589c 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -76,6 +76,7 @@ static void ps2_gpio_close(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
+	flush_delayed_work(&drvdata->tx_work);
 	disable_irq(drvdata->irq);
 }
 
-- 
2.19.1
