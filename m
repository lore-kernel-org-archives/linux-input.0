From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v3 05/49] Input: atmel_mxt_ts - split large i2c transfers into blocks
Date: Tue, 17 Sep 2019 18:35:06 +0900
Message-ID: <20190917093550.18335-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

On some firmware variants, the size of the info block exceeds what can
be read in a single transfer.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
(cherry picked from ndyer/linux/for-upstream commit 74c4f5277cfa403d43fafc404119dc57a08677db)
[gdavis: Forward port and fix conflicts due to v4.14.51 commit
	 960fe000b1d3 ("Input: atmel_mxt_ts - fix the firmware
	 update").]
Signed-off-by: George G. Davis <george_davis@mentor.com>
[jiada: Change mxt_read_blks() to __mxt_read_reg(), original __mxt_read_reg() to
	__mxt_read_chunk()]
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 28 +++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 35cbe60094ab..45bab5253775 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -40,7 +40,7 @@
 #define MXT_OBJECT_START	0x07
 #define MXT_OBJECT_SIZE		6
 #define MXT_INFO_CHECKSUM_SIZE	3
-#define MXT_MAX_BLOCK_WRITE	256
+#define MXT_MAX_BLOCK_WRITE	255
 
 /* Object types */
 #define MXT_DEBUG_DIAGNOSTIC_T37	37
@@ -624,8 +624,8 @@ static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
 	return 0;
 }
 
-static int __mxt_read_reg(struct i2c_client *client,
-			       u16 reg, u16 len, void *val)
+static int __mxt_read_chunk(struct i2c_client *client,
+			    u16 reg, u16 len, void *val)
 {
 	struct i2c_msg xfer[2];
 	u8 buf[2];
@@ -659,6 +659,28 @@ static int __mxt_read_reg(struct i2c_client *client,
 	return ret;
 }
 
+static int __mxt_read_reg(struct i2c_client *client,
+			  u16 reg, u16 len, void *buf)
+{
+	u16 offset = 0;
+	int error;
+	u16 size;
+
+	while (offset < len) {
+		size = min(MXT_MAX_BLOCK_WRITE, len - offset);
+
+		error = __mxt_read_chunk(client,
+					 reg + offset,
+					 size, buf + offset);
+		if (error)
+			return error;
+
+		offset += size;
+	}
+
+	return 0;
+}
+
 static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
 			   const void *val)
 {
-- 
2.19.2
