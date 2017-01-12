From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] Input: silead: use msleep() for long delays
Date: Thu, 12 Jan 2017 17:21:45 +0100
Message-ID: <1484238105-10785-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>, Daniel Jansen <djaniboe@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Robert Dolca <robert.dolca@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-input@vger.kernel.org

the delays here are in the 10 to 20ms range so msleep() will do - no 
need to burden the highres timer subsystem.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem found by coccinelle script

While msleep(10) has a worst case uncertainty of 10ms (on HZ=100 systems)
this seems ok here as the delays are not called frequently (init and
reset functions) and the uncertainty of 10ms fits the permitted range of
the original usleep_ranges().

Patch was compile tested with: x86_64_defconfig + 
CONFIG_TOUCHSCREEN_SILEAD=m

Patch is against 4.10-rc3 (localversion-next is next-20170112)

 drivers/input/touchscreen/silead.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 404830a..3aa885c 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -58,8 +58,7 @@
 #define SILEAD_POINT_X_MSB_OFF	0x03
 #define SILEAD_TOUCH_ID_MASK	0xF0
 
-#define SILEAD_CMD_SLEEP_MIN	10000
-#define SILEAD_CMD_SLEEP_MAX	20000
+#define SILEAD_CMD_SLEEP_MIN	10	/* 10+ ms */
 #define SILEAD_POWER_SLEEP	20
 #define SILEAD_STARTUP_SLEEP	30
 
@@ -190,25 +189,25 @@ static int silead_ts_init(struct i2c_client *client)
 					  SILEAD_CMD_RESET);
 	if (error)
 		goto i2c_write_err;
-	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
+	msleep(SILEAD_CMD_SLEEP_MIN);
 
 	error = i2c_smbus_write_byte_data(client, SILEAD_REG_TOUCH_NR,
 					data->max_fingers);
 	if (error)
 		goto i2c_write_err;
-	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
+	msleep(SILEAD_CMD_SLEEP_MIN);
 
 	error = i2c_smbus_write_byte_data(client, SILEAD_REG_CLOCK,
 					  SILEAD_CLOCK);
 	if (error)
 		goto i2c_write_err;
-	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
+	msleep(SILEAD_CMD_SLEEP_MIN);
 
 	error = i2c_smbus_write_byte_data(client, SILEAD_REG_RESET,
 					  SILEAD_CMD_START);
 	if (error)
 		goto i2c_write_err;
-	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
+	msleep(SILEAD_CMD_SLEEP_MIN);
 
 	return 0;
 
@@ -225,19 +224,19 @@ static int silead_ts_reset(struct i2c_client *client)
 					  SILEAD_CMD_RESET);
 	if (error)
 		goto i2c_write_err;
-	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
+	msleep(SILEAD_CMD_SLEEP_MIN);
 
 	error = i2c_smbus_write_byte_data(client, SILEAD_REG_CLOCK,
 					  SILEAD_CLOCK);
 	if (error)
 		goto i2c_write_err;
-	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
+	msleep(SILEAD_CMD_SLEEP_MIN);
 
 	error = i2c_smbus_write_byte_data(client, SILEAD_REG_POWER,
 					  SILEAD_CMD_START);
 	if (error)
 		goto i2c_write_err;
-	usleep_range(SILEAD_CMD_SLEEP_MIN, SILEAD_CMD_SLEEP_MAX);
+	msleep(SILEAD_CMD_SLEEP_MIN);
 
 	return 0;
 
-- 
2.1.4
