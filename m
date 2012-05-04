From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] i2c: Split I2C_M_NOSTART support out of I2C_FUNC_PROTOCOL_MANGLING
Date: Fri,  4 May 2012 11:26:48 +0100
Message-ID: <1336127208-17951-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46493 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753640Ab2EDK06 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 06:26:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Since there are uses for I2C_M_NOSTART which are much more sensible and
standard than most of the protocol mangling functionality (the main one
being gather writes to devices where something like a register address
needs to be inserted before a block of data) create a new I2C_FUNC_NOSTART
for this feature and update all the users to use it.

Also strengthen the disrecommendation of the protocol mangling while we're
at it.

In the case of regmap-i2c we remove the requirement for mangling as
I2C_M_NOSTART is the only mangling feature which is being used.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/i2c/functionality       |    8 +++++---
 Documentation/i2c/i2c-protocol        |    9 ++++++++-
 drivers/base/regmap/regmap-i2c.c      |    2 +-
 drivers/i2c/algos/i2c-algo-bit.c      |    2 +-
 drivers/i2c/busses/i2c-nuc900.c       |    3 ++-
 drivers/i2c/busses/i2c-s3c2410.c      |    3 ++-
 drivers/input/joystick/as5011.c       |    1 +
 drivers/video/matrox/matroxfb_maven.c |    1 +
 include/linux/i2c.h                   |    5 +++--
 9 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
index 42c17c1..7cbd5da 100644
--- a/Documentation/i2c/functionality
+++ b/Documentation/i2c/functionality
@@ -18,9 +18,8 @@ For the most up-to-date list of functionality constants, please check
                                   adapters typically can not do these)
   I2C_FUNC_10BIT_ADDR             Handles the 10-bit address extensions
   I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_IGNORE_NAK,
-                                  I2C_M_REV_DIR_ADDR, I2C_M_NOSTART and
-                                  I2C_M_NO_RD_ACK flags (which modify the
-                                  I2C protocol!)
+                                  I2C_M_REV_DIR_ADDR and I2C_M_NO_RD_ACK
+				  flags (which modify the I2C protocol!).
   I2C_FUNC_SMBUS_QUICK            Handles the SMBus write_quick command
   I2C_FUNC_SMBUS_READ_BYTE        Handles the SMBus read_byte command
   I2C_FUNC_SMBUS_WRITE_BYTE       Handles the SMBus write_byte command
@@ -33,6 +32,7 @@ For the most up-to-date list of functionality constants, please check
   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA Handles the SMBus write_block_data command
   I2C_FUNC_SMBUS_READ_I2C_BLOCK   Handles the SMBus read_i2c_block_data command
   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK  Handles the SMBus write_i2c_block_data command
+  I2C_FUNC_NOSTART                Can skip repeated start sequence
 
 A few combinations of the above flags are also defined for your convenience:
 
@@ -50,6 +50,8 @@ A few combinations of the above flags are also defined for your convenience:
                                   emulated by a real I2C adapter (using
                                   the transparent emulation layer)
 
+In kernel versions prior to 3.5 I2C_FUNC_NOSTART was implemented as
+part of I2C_FUNC_PROTOCOL_MANGLING.
 
 ADAPTER IMPLEMENTATION
 ----------------------
diff --git a/Documentation/i2c/i2c-protocol b/Documentation/i2c/i2c-protocol
index 10518dd..0b3e62d 100644
--- a/Documentation/i2c/i2c-protocol
+++ b/Documentation/i2c/i2c-protocol
@@ -49,7 +49,9 @@ a byte read, followed by a byte write:
 Modified transactions
 =====================
 
-We have found some I2C devices that needs the following modifications:
+The following modifications to the I2C protocol can also be generated,
+with the exception of I2C_M_NOSTART these are usually only needed to
+work around device issues:
 
   Flag I2C_M_NOSTART: 
     In a combined transaction, no 'S Addr Wr/Rd [A]' is generated at some
@@ -60,6 +62,11 @@ We have found some I2C devices that needs the following modifications:
     we do not generate Addr, but we do generate the startbit S. This will
     probably confuse all other clients on your bus, so don't try this.
 
+    This is often used to gather transmits from multiple data buffers in
+    system memory into something that appears as a single transfer to the
+    I2C device but may also be used between direction changes by some
+    rare devices.
+
   Flags I2C_M_REV_DIR_ADDR
     This toggles the Rd/Wr flag. That is, if you want to do a write, but
     need to emit an Rd instead of a Wr, or vice versa, you set this
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 9a3a8c5..157bbd5 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -40,7 +40,7 @@ static int regmap_i2c_gather_write(struct device *dev,
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
index 737f721..37b1f90 100644
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
index 195d8b3..85d4ef1 100644
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
@@ -553,8 +553,9 @@ struct i2c_msg {
 
 #define I2C_FUNC_I2C			0x00000001
 #define I2C_FUNC_10BIT_ADDR		0x00000002
-#define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_NOSTART etc. */
+#define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_IGNORE_NAK etc. */
 #define I2C_FUNC_SMBUS_PEC		0x00000008
+#define I2C_FUNC_NOSTART		0x00000010 /* I2C_M_NOSTART */
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
-- 
1.7.10

