From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] i2c: Split I2C_M_NOSTART support out of I2C_FUNC_PROTOCOL_MANGLING
Date: Thu, 26 Apr 2012 13:37:19 +0100
Message-ID: <1335443839-22872-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Since there are uses for I2C_M_NOSTART which are much more sensible and
standard than most of the protocol mangling functionality (the main one
being gather writes to devices where something like a register address
needs to be inserted before a block of data) create a new I2C_FUNC_NOSTART
for this feature and update all the users to use it.

In the case of regmap-i2c we remove the requirement for mangling as
I2C_M_NOSTART is the only mangling feature which is being used.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/i2c/functionality       |    1 +
 drivers/base/regmap/regmap-i2c.c      |    2 +-
 drivers/i2c/algos/i2c-algo-bit.c      |    2 +-
 drivers/i2c/algos/i2c-algo-pcf.c      |    2 +-
 drivers/i2c/busses/i2c-nuc900.c       |    3 ++-
 drivers/i2c/busses/i2c-s3c2410.c      |    3 ++-
 drivers/input/joystick/as5011.c       |    1 +
 drivers/video/matrox/matroxfb_maven.c |    1 +
 include/linux/i2c.h                   |    3 ++-
 9 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
index 42c17c1..fb2e77e 100644
--- a/Documentation/i2c/functionality
+++ b/Documentation/i2c/functionality
@@ -33,6 +33,7 @@ For the most up-to-date list of functionality constants, please check
   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA Handles the SMBus write_block_data command
   I2C_FUNC_SMBUS_READ_I2C_BLOCK   Handles the SMBus read_i2c_block_data command
   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK  Handles the SMBus write_i2c_block_data command
+  I2C_FUNC_NOSTART                Transfers can be sent without a start
 
 A few combinations of the above flags are also defined for your convenience:
 
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 5f6b247..fa6bf52 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -42,7 +42,7 @@ static int regmap_i2c_gather_write(void *context,
 	/* If the I2C controller can't do a gather tell the core, it
 	 * will substitute in a linear write for us.
 	 */
-	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_PROTOCOL_MANGLING))
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_NOSTART))
 		return -ENOTSUPP;
 
 	xfer[0].addr = i2c->addr;
diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 7f0b832..fad22b0 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -608,7 +608,7 @@ bailout:
 
 static u32 bit_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
 	       I2C_FUNC_SMBUS_READ_BLOCK_DATA |
 	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
 	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 5c23795..8b38986 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -401,7 +401,7 @@ out:
 
 static u32 pcf_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
 	       I2C_FUNC_PROTOCOL_MANGLING;
 }
 
diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index 03b6157..a26dfb8 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -502,7 +502,8 @@ static int nuc900_i2c_xfer(struct i2c_adapter *adap,
 /* declare our i2c functionality */
 static u32 nuc900_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_NOSTART |
+		I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 /* i2c bus registration info */
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 8764d6a..faa1f23 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -591,7 +591,8 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 /* declare our i2c functionality */
 static u32 s3c24xx_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_NOSTART |
+		I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 /* i2c bus registration info */
diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 3063464..57d19d4 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -231,6 +231,7 @@ static int __devinit as5011_probe(struct i2c_client *client,
 	}
 
 	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_NOSTART |
 				     I2C_FUNC_PROTOCOL_MANGLING)) {
 		dev_err(&client->dev,
 			"need i2c bus that supports protocol mangling\n");
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index 31b8f67..217678e 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1243,6 +1243,7 @@ static int maven_probe(struct i2c_client *client,
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_WORD_DATA |
 					      I2C_FUNC_SMBUS_BYTE_DATA |
+					      I2C_FUNC_NOSTART |
 					      I2C_FUNC_PROTOCOL_MANGLING))
 		goto ERROR0;
 	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 195d8b3..c18b5b1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -540,7 +540,7 @@ struct i2c_msg {
 	__u16 flags;
 #define I2C_M_TEN		0x0010	/* this is a ten bit chip address */
 #define I2C_M_RD		0x0001	/* read data, from slave to master */
-#define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_PROTOCOL_MANGLING */
+#define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_NOSTART */
 #define I2C_M_REV_DIR_ADDR	0x2000	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_IGNORE_NAK	0x1000	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
@@ -568,6 +568,7 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
+#define I2C_FUNC_NOSTART		0x10000000 /* I2C_M_NOSTART */
 
 #define I2C_FUNC_SMBUS_BYTE		(I2C_FUNC_SMBUS_READ_BYTE | \
 					 I2C_FUNC_SMBUS_WRITE_BYTE)
-- 
1.7.10
