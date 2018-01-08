From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] Input: cyapa - remove duplicated macro definitions
Date: Mon,  8 Jan 2018 22:54:02 +0100
Message-ID: <20180108215402.25612-1-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Apart from whitespace differences, this block of macros is repeated
twice:

$ x=./drivers/input/mouse/cyapa_gen3.c; diff -w -u <(sed -n '139,181p' $x) <(sed -n '182,224p' $x)
$

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/input/mouse/cyapa_gen3.c | 43 ----------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index 1cbfa4a6e830..076dda4a66da 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -136,49 +136,6 @@ static const u8 bl_exit[] = { 0x00, 0xff, 0xa5, 0x00, 0x01, 0x02, 0x03, 0x04,
 		0x05, 0x06, 0x07 };
 
 
- /* for byte read/write command */
-#define CMD_RESET      0
-#define CMD_POWER_MODE 1
-#define CMD_DEV_STATUS 2
-#define CMD_REPORT_MAX_BASELINE 3
-#define CMD_REPORT_MIN_BASELINE 4
-#define SMBUS_BYTE_CMD(cmd) (((cmd) & 0x3f) << 1)
-#define CYAPA_SMBUS_RESET         SMBUS_BYTE_CMD(CMD_RESET)
-#define CYAPA_SMBUS_POWER_MODE    SMBUS_BYTE_CMD(CMD_POWER_MODE)
-#define CYAPA_SMBUS_DEV_STATUS    SMBUS_BYTE_CMD(CMD_DEV_STATUS)
-#define CYAPA_SMBUS_MAX_BASELINE  SMBUS_BYTE_CMD(CMD_REPORT_MAX_BASELINE)
-#define CYAPA_SMBUS_MIN_BASELINE  SMBUS_BYTE_CMD(CMD_REPORT_MIN_BASELINE)
-
- /* for group registers read/write command */
-#define REG_GROUP_DATA 0
-#define REG_GROUP_CMD 2
-#define REG_GROUP_QUERY 3
-#define SMBUS_GROUP_CMD(grp) (0x80 | (((grp) & 0x07) << 3))
-#define CYAPA_SMBUS_GROUP_DATA	 SMBUS_GROUP_CMD(REG_GROUP_DATA)
-#define CYAPA_SMBUS_GROUP_CMD	 SMBUS_GROUP_CMD(REG_GROUP_CMD)
-#define CYAPA_SMBUS_GROUP_QUERY	 SMBUS_GROUP_CMD(REG_GROUP_QUERY)
-
- /* for register block read/write command */
-#define CMD_BL_STATUS 0
-#define CMD_BL_HEAD 1
-#define CMD_BL_CMD 2
-#define CMD_BL_DATA 3
-#define CMD_BL_ALL 4
-#define CMD_BLK_PRODUCT_ID 5
-#define CMD_BLK_HEAD 6
-#define SMBUS_BLOCK_CMD(cmd) (0xc0 | (((cmd) & 0x1f) << 1))
-
-/* register block read/write command in bootloader mode */
-#define CYAPA_SMBUS_BL_STATUS  SMBUS_BLOCK_CMD(CMD_BL_STATUS)
-#define CYAPA_SMBUS_BL_HEAD    SMBUS_BLOCK_CMD(CMD_BL_HEAD)
-#define CYAPA_SMBUS_BL_CMD     SMBUS_BLOCK_CMD(CMD_BL_CMD)
-#define CYAPA_SMBUS_BL_DATA    SMBUS_BLOCK_CMD(CMD_BL_DATA)
-#define CYAPA_SMBUS_BL_ALL     SMBUS_BLOCK_CMD(CMD_BL_ALL)
-
-/* register block read/write command in operational mode */
-#define CYAPA_SMBUS_BLK_PRODUCT_ID SMBUS_BLOCK_CMD(CMD_BLK_PRODUCT_ID)
-#define CYAPA_SMBUS_BLK_HEAD SMBUS_BLOCK_CMD(CMD_BLK_HEAD)
-
  /* for byte read/write command */
 #define CMD_RESET 0
 #define CMD_POWER_MODE 1
-- 
2.15.1
