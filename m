From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 4/4] Input: goodix - Add GT5663 CTP support
Date: Sat, 15 Dec 2018 20:48:02 +0530
Message-ID: <20181215151802.18592-5-jagan@amarulasolutions.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181215151802.18592-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures.

Add support for it by adding compatible and supported chip data.

The chip data on GT5663 is similar to GT1151, like
- config data register has 0x8050 address
- config data register max len is 240
- config data checksum has 16-bit

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 7371f6946098..735ab8e246b6 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -218,6 +218,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5663:
 		return &gt1x_chip_data;
 
 	case 911:
@@ -965,6 +966,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3
