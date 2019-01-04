From: Alex Gonzalez <alex.gonzalez@digi.com>
Subject: [PATCH] Input: goodix - decouple irq and reset lines
Date: Fri, 4 Jan 2019 17:00:48 +0100
Message-ID: <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hadess@hadess.net
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, alex.gonzalez@digi.com
List-Id: linux-input@vger.kernel.org

The Goodix touch controller allows the use of two optional GPIOs (RESET
and INT) to reset the touch controller, select the I2C address of the
device and exit the device from sleep mode.

The current implementation requires both GPIOs to be provided, however,
it is possible to provide only the INT line and not to have the RESET line
available but pulled-up.

Designs that only provide the INT line are able to operate the touch on
the default I2C address but will not be able to reset the touch via
software or place the device in sleep mode.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 drivers/input/touchscreen/goodix.c | 59 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..8d96b0b771b6 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -484,34 +484,39 @@ static int goodix_reset(struct goodix_ts_data *ts)
 {
 	int error;
 
-	/* begin select I2C slave addr */
-	error = gpiod_direction_output(ts->gpiod_rst, 0);
-	if (error)
-		return error;
+	if (ts->gpiod_rst) {
+		/* begin select I2C slave addr */
+		error = gpiod_direction_output(ts->gpiod_rst, 0);
+		if (error)
+			return error;
 
-	msleep(20);				/* T2: > 10ms */
+		msleep(20);				/* T2: > 10ms */
 
-	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
-	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
-	if (error)
-		return error;
+		/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
+		error = gpiod_direction_output(ts->gpiod_int,
+				ts->client->addr == 0x14);
+		if (error)
+			return error;
 
-	usleep_range(100, 2000);		/* T3: > 100us */
+		usleep_range(100, 2000);		/* T3: > 100us */
 
-	error = gpiod_direction_output(ts->gpiod_rst, 1);
-	if (error)
-		return error;
+		error = gpiod_direction_output(ts->gpiod_rst, 1);
+		if (error)
+			return error;
 
-	usleep_range(6000, 10000);		/* T4: > 5ms */
+		usleep_range(6000, 10000);		/* T4: > 5ms */
 
-	/* end select I2C slave addr */
-	error = gpiod_direction_input(ts->gpiod_rst);
-	if (error)
-		return error;
+		/* end select I2C slave addr */
+		error = gpiod_direction_input(ts->gpiod_rst);
+		if (error)
+			return error;
+	}
 
-	error = goodix_int_sync(ts);
-	if (error)
-		return error;
+	if (ts->gpiod_int) {
+		error = goodix_int_sync(ts);
+		if (error)
+			return error;
+	}
 
 	return 0;
 }
@@ -786,13 +791,11 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	if (ts->gpiod_int && ts->gpiod_rst) {
-		/* reset the controller */
-		error = goodix_reset(ts);
-		if (error) {
-			dev_err(&client->dev, "Controller reset failed.\n");
-			return error;
-		}
+	/* reset the controller */
+	error = goodix_reset(ts);
+	if (error) {
+		dev_err(&client->dev, "Controller reset failed.\n");
+		return error;
 	}
 
 	error = goodix_i2c_test(client);
