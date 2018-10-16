From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 4/7] Input: sx8654 - add sx8655 and sx8656 to compatibles
Date: Tue, 16 Oct 2018 11:16:50 +0200
Message-ID: <20181016091653.26896-5-richard.leitner@skidata.com>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016091653.26896-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

As the sx865[456] share the same datasheet and differ only in the
presence of a "capacitive proximity detection circuit" and a "haptics
motor driver for LRA/ERM" add them to the compatbiles. As the driver
doesn't implement these features it should be no problem.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 059127490c8d..622283b49d7c 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -222,6 +222,8 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
 
 static const struct of_device_id sx8654_of_match[] = {
 	{ .compatible = "semtech,sx8654", },
+	{ .compatible = "semtech,sx8655", },
+	{ .compatible = "semtech,sx8656", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sx8654_of_match);
@@ -326,6 +328,8 @@ static int sx8654_probe(struct i2c_client *client,
 
 static const struct i2c_device_id sx8654_id_table[] = {
 	{ "semtech_sx8654", 0 },
+	{ "semtech_sx8655", 0 },
+	{ "semtech_sx8656", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, sx8654_id_table);
-- 
2.11.0
