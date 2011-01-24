From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH] input: Modify the qt602240 driver to be compatible with mXT1386
 device
Date: Mon, 24 Jan 2011 18:52:12 +0200
Message-ID: <4D3DAE3C.6060806@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:44411 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab1AXSkP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 13:40:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: jy0922.shim@samsung.com


This patches the current qt602240 driver to be usable with mXT1386. Also all the qt602240 references are changed to more generic "MXT", as in the future this driver will be kept compatible with all the maXTouch variants.


Signed-off-by: Iiro Valkonen (iiro.valkonen@atmel.com)
--- 
 drivers/input/touchscreen/qt602240_ts.c | 1006 ++++++++++++++-----------------
 include/linux/i2c/qt602240_ts.h         |   48 +-
 2 files changed, 482 insertions(+), 572 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 4dcb0e8..32de943 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -1,5 +1,5 @@
 /*
- * AT42QT602240/ATMXT224 Touchscreen driver
+ * Atmel maXTouch Touchscreen driver
  *
  * Copyright (C) 2010 Samsung Electronics Co.Ltd
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
@@ -22,300 +22,184 @@
 #include <linux/slab.h>
 
 /* Version */
-#define QT602240_VER_20			20
-#define QT602240_VER_21			21
-#define QT602240_VER_22			22
+#define MXT_VER_20		20
+#define MXT_VER_21		21
+#define MXT_VER_22		22
 
 /* Slave addresses */
-#define QT602240_APP_LOW		0x4a
-#define QT602240_APP_HIGH		0x4b
-#define QT602240_BOOT_LOW		0x24
-#define QT602240_BOOT_HIGH		0x25
+#define MXT_APP_LOW		0x4a
+#define MXT_APP_HIGH		0x4b
+#define MXT_BOOT_LOW		0x24
+#define MXT_BOOT_HIGH		0x25
 
 /* Firmware */
-#define QT602240_FW_NAME		"qt602240.fw"
+#define MXT_FW_NAME		"maxtouch.fw"
 
 /* Registers */
-#define QT602240_FAMILY_ID		0x00
-#define QT602240_VARIANT_ID		0x01
-#define QT602240_VERSION		0x02
-#define QT602240_BUILD			0x03
-#define QT602240_MATRIX_X_SIZE		0x04
-#define QT602240_MATRIX_Y_SIZE		0x05
-#define QT602240_OBJECT_NUM		0x06
-#define QT602240_OBJECT_START		0x07
+#define MXT_FAMILY_ID		0x00
+#define MXT_VARIANT_ID		0x01
+#define MXT_VERSION		0x02
+#define MXT_BUILD		0x03
+#define MXT_MATRIX_X_SIZE	0x04
+#define MXT_MATRIX_Y_SIZE	0x05
+#define MXT_OBJECT_NUM		0x06
+#define MXT_OBJECT_START	0x07
 
-#define QT602240_OBJECT_SIZE		6
+#define MXT_OBJECT_SIZE		6
 
 /* Object types */
-#define QT602240_DEBUG_DIAGNOSTIC	37
-#define QT602240_GEN_MESSAGE		5
-#define QT602240_GEN_COMMAND		6
-#define QT602240_GEN_POWER		7
-#define QT602240_GEN_ACQUIRE		8
-#define QT602240_TOUCH_MULTI		9
-#define QT602240_TOUCH_KEYARRAY		15
-#define QT602240_TOUCH_PROXIMITY	23
-#define QT602240_PROCI_GRIPFACE		20
-#define QT602240_PROCG_NOISE		22
-#define QT602240_PROCI_ONETOUCH		24
-#define QT602240_PROCI_TWOTOUCH		27
-#define QT602240_SPT_COMMSCONFIG	18	/* firmware ver 21 over */
-#define QT602240_SPT_GPIOPWM		19
-#define QT602240_SPT_SELFTEST		25
-#define QT602240_SPT_CTECONFIG		28
-#define QT602240_SPT_USERDATA		38	/* firmware ver 21 over */
-
-/* QT602240_GEN_COMMAND field */
-#define QT602240_COMMAND_RESET		0
-#define QT602240_COMMAND_BACKUPNV	1
-#define QT602240_COMMAND_CALIBRATE	2
-#define QT602240_COMMAND_REPORTALL	3
-#define QT602240_COMMAND_DIAGNOSTIC	5
-
-/* QT602240_GEN_POWER field */
-#define QT602240_POWER_IDLEACQINT	0
-#define QT602240_POWER_ACTVACQINT	1
-#define QT602240_POWER_ACTV2IDLETO	2
-
-/* QT602240_GEN_ACQUIRE field */
-#define QT602240_ACQUIRE_CHRGTIME	0
-#define QT602240_ACQUIRE_TCHDRIFT	2
-#define QT602240_ACQUIRE_DRIFTST	3
-#define QT602240_ACQUIRE_TCHAUTOCAL	4
-#define QT602240_ACQUIRE_SYNC		5
-#define QT602240_ACQUIRE_ATCHCALST	6
-#define QT602240_ACQUIRE_ATCHCALSTHR	7
-
-/* QT602240_TOUCH_MULTI field */
-#define QT602240_TOUCH_CTRL		0
-#define QT602240_TOUCH_XORIGIN		1
-#define QT602240_TOUCH_YORIGIN		2
-#define QT602240_TOUCH_XSIZE		3
-#define QT602240_TOUCH_YSIZE		4
-#define QT602240_TOUCH_BLEN		6
-#define QT602240_TOUCH_TCHTHR		7
-#define QT602240_TOUCH_TCHDI		8
-#define QT602240_TOUCH_ORIENT		9
-#define QT602240_TOUCH_MOVHYSTI		11
-#define QT602240_TOUCH_MOVHYSTN		12
-#define QT602240_TOUCH_NUMTOUCH		14
-#define QT602240_TOUCH_MRGHYST		15
-#define QT602240_TOUCH_MRGTHR		16
-#define QT602240_TOUCH_AMPHYST		17
-#define QT602240_TOUCH_XRANGE_LSB	18
-#define QT602240_TOUCH_XRANGE_MSB	19
-#define QT602240_TOUCH_YRANGE_LSB	20
-#define QT602240_TOUCH_YRANGE_MSB	21
-#define QT602240_TOUCH_XLOCLIP		22
-#define QT602240_TOUCH_XHICLIP		23
-#define QT602240_TOUCH_YLOCLIP		24
-#define QT602240_TOUCH_YHICLIP		25
-#define QT602240_TOUCH_XEDGECTRL	26
-#define QT602240_TOUCH_XEDGEDIST	27
-#define QT602240_TOUCH_YEDGECTRL	28
-#define QT602240_TOUCH_YEDGEDIST	29
-#define QT602240_TOUCH_JUMPLIMIT	30	/* firmware ver 22 over */
-
-/* QT602240_PROCI_GRIPFACE field */
-#define QT602240_GRIPFACE_CTRL		0
-#define QT602240_GRIPFACE_XLOGRIP	1
-#define QT602240_GRIPFACE_XHIGRIP	2
-#define QT602240_GRIPFACE_YLOGRIP	3
-#define QT602240_GRIPFACE_YHIGRIP	4
-#define QT602240_GRIPFACE_MAXTCHS	5
-#define QT602240_GRIPFACE_SZTHR1	7
-#define QT602240_GRIPFACE_SZTHR2	8
-#define QT602240_GRIPFACE_SHPTHR1	9
-#define QT602240_GRIPFACE_SHPTHR2	10
-#define QT602240_GRIPFACE_SUPEXTTO	11
-
-/* QT602240_PROCI_NOISE field */
-#define QT602240_NOISE_CTRL		0
-#define QT602240_NOISE_OUTFLEN		1
-#define QT602240_NOISE_GCAFUL_LSB	3
-#define QT602240_NOISE_GCAFUL_MSB	4
-#define QT602240_NOISE_GCAFLL_LSB	5
-#define QT602240_NOISE_GCAFLL_MSB	6
-#define QT602240_NOISE_ACTVGCAFVALID	7
-#define QT602240_NOISE_NOISETHR		8
-#define QT602240_NOISE_FREQHOPSCALE	10
-#define QT602240_NOISE_FREQ0		11
-#define QT602240_NOISE_FREQ1		12
-#define QT602240_NOISE_FREQ2		13
-#define QT602240_NOISE_FREQ3		14
-#define QT602240_NOISE_FREQ4		15
-#define QT602240_NOISE_IDLEGCAFVALID	16
-
-/* QT602240_SPT_COMMSCONFIG */
-#define QT602240_COMMS_CTRL		0
-#define QT602240_COMMS_CMD		1
-
-/* QT602240_SPT_CTECONFIG field */
-#define QT602240_CTE_CTRL		0
-#define QT602240_CTE_CMD		1
-#define QT602240_CTE_MODE		2
-#define QT602240_CTE_IDLEGCAFDEPTH	3
-#define QT602240_CTE_ACTVGCAFDEPTH	4
-#define QT602240_CTE_VOLTAGE		5	/* firmware ver 21 over */
-
-#define QT602240_VOLTAGE_DEFAULT	2700000
-#define QT602240_VOLTAGE_STEP		10000
-
-/* Define for QT602240_GEN_COMMAND */
-#define QT602240_BOOT_VALUE		0xa5
-#define QT602240_BACKUP_VALUE		0x55
-#define QT602240_BACKUP_TIME		25	/* msec */
-#define QT602240_RESET_TIME		65	/* msec */
-
-#define QT602240_FWRESET_TIME		175	/* msec */
+#define MXT_DEBUG_DIAGNOSTIC	37
+#define MXT_GEN_MESSAGE		5
+#define MXT_GEN_COMMAND		6
+#define MXT_GEN_POWER		7
+#define MXT_GEN_ACQUIRE		8
+#define MXT_TOUCH_MULTI		9
+#define MXT_TOUCH_KEYARRAY	15
+#define MXT_TOUCH_PROXIMITY	23
+#define MXT_PROCI_GRIPFACE	20
+#define MXT_PROCG_NOISE		22
+#define MXT_PROCI_ONETOUCH	24
+#define MXT_PROCI_TWOTOUCH	27
+#define MXT_SPT_COMMSCONFIG	18	/* firmware ver 21 over */
+#define MXT_SPT_GPIOPWM		19
+#define MXT_SPT_SELFTEST	25
+#define MXT_SPT_CTECONFIG	28
+#define MXT_SPT_USERDATA	38	/* firmware ver 21 over */
+
+/* MXT_GEN_COMMAND field */
+#define MXT_COMMAND_RESET	0
+#define MXT_COMMAND_BACKUPNV	1
+#define MXT_COMMAND_CALIBRATE	2
+#define MXT_COMMAND_REPORTALL	3
+#define MXT_COMMAND_DIAGNOSTIC	5
+
+/* MXT_GEN_POWER field */
+#define MXT_POWER_IDLEACQINT	0
+#define MXT_POWER_ACTVACQINT	1
+#define MXT_POWER_ACTV2IDLETO	2
+
+/* MXT_GEN_ACQUIRE field */
+#define MXT_ACQUIRE_CHRGTIME	0
+#define MXT_ACQUIRE_TCHDRIFT	2
+#define MXT_ACQUIRE_DRIFTST	3
+#define MXT_ACQUIRE_TCHAUTOCAL	4
+#define MXT_ACQUIRE_SYNC	5
+#define MXT_ACQUIRE_ATCHCALST	6
+#define MXT_ACQUIRE_ATCHCALSTHR	7
+
+/* MXT_TOUCH_MULTI field */
+#define MXT_TOUCH_CTRL		0
+#define MXT_TOUCH_XORIGIN	1
+#define MXT_TOUCH_YORIGIN	2
+#define MXT_TOUCH_XSIZE		3
+#define MXT_TOUCH_YSIZE		4
+#define MXT_TOUCH_BLEN		6
+#define MXT_TOUCH_TCHTHR	7
+#define MXT_TOUCH_TCHDI		8
+#define MXT_TOUCH_ORIENT	9
+#define MXT_TOUCH_MOVHYSTI	11
+#define MXT_TOUCH_MOVHYSTN	12
+#define MXT_TOUCH_NUMTOUCH	14
+#define MXT_TOUCH_MRGHYST	15
+#define MXT_TOUCH_MRGTHR	16
+#define MXT_TOUCH_AMPHYST	17
+#define MXT_TOUCH_XRANGE_LSB	18
+#define MXT_TOUCH_XRANGE_MSB	19
+#define MXT_TOUCH_YRANGE_LSB	20
+#define MXT_TOUCH_YRANGE_MSB	21
+#define MXT_TOUCH_XLOCLIP	22
+#define MXT_TOUCH_XHICLIP	23
+#define MXT_TOUCH_YLOCLIP	24
+#define MXT_TOUCH_YHICLIP	25
+#define MXT_TOUCH_XEDGECTRL	26
+#define MXT_TOUCH_XEDGEDIST	27
+#define MXT_TOUCH_YEDGECTRL	28
+#define MXT_TOUCH_YEDGEDIST	29
+#define MXT_TOUCH_JUMPLIMIT	30	/* firmware ver 22 over */
+
+/* MXT_PROCI_GRIPFACE field */
+#define MXT_GRIPFACE_CTRL	0
+#define MXT_GRIPFACE_XLOGRIP	1
+#define MXT_GRIPFACE_XHIGRIP	2
+#define MXT_GRIPFACE_YLOGRIP	3
+#define MXT_GRIPFACE_YHIGRIP	4
+#define MXT_GRIPFACE_MAXTCHS	5
+#define MXT_GRIPFACE_SZTHR1	7
+#define MXT_GRIPFACE_SZTHR2	8
+#define MXT_GRIPFACE_SHPTHR1	9
+#define MXT_GRIPFACE_SHPTHR2	10
+#define MXT_GRIPFACE_SUPEXTTO	11
+
+/* MXT_PROCI_NOISE field */
+#define MXT_NOISE_CTRL		0
+#define MXT_NOISE_OUTFLEN	1
+#define MXT_NOISE_GCAFUL_LSB	3
+#define MXT_NOISE_GCAFUL_MSB	4
+#define MXT_NOISE_GCAFLL_LSB	5
+#define MXT_NOISE_GCAFLL_MSB	6
+#define MXT_NOISE_ACTVGCAFVALID	7
+#define MXT_NOISE_NOISETHR	8
+#define MXT_NOISE_FREQHOPSCALE	10
+#define MXT_NOISE_FREQ0		11
+#define MXT_NOISE_FREQ1		12
+#define MXT_NOISE_FREQ2		13
+#define MXT_NOISE_FREQ3		14
+#define MXT_NOISE_FREQ4		15
+#define MXT_NOISE_IDLEGCAFVALID	16
+
+/* MXT_SPT_COMMSCONFIG */
+#define MXT_COMMS_CTRL		0
+#define MXT_COMMS_CMD		1
+
+/* MXT_SPT_CTECONFIG field */
+#define MXT_CTE_CTRL		0
+#define MXT_CTE_CMD		1
+#define MXT_CTE_MODE		2
+#define MXT_CTE_IDLEGCAFDEPTH	3
+#define MXT_CTE_ACTVGCAFDEPTH	4
+#define MXT_CTE_VOLTAGE		5	/* firmware ver 21 over */
+
+#define MXT_VOLTAGE_DEFAULT	2700000
+#define MXT_VOLTAGE_STEP	10000
+
+/* Define for MXT_GEN_COMMAND */
+#define MXT_BOOT_VALUE		0xa5
+#define MXT_BACKUP_VALUE	0x55
+#define MXT_BACKUP_TIME		25	/* msec */
+#define MXT_RESET_TIME		65	/* msec */
+
+#define MXT_FWRESET_TIME	175	/* msec */
 
 /* Command to unlock bootloader */
-#define QT602240_UNLOCK_CMD_MSB		0xaa
-#define QT602240_UNLOCK_CMD_LSB		0xdc
+#define MXT_UNLOCK_CMD_MSB	0xaa
+#define MXT_UNLOCK_CMD_LSB	0xdc
 
 /* Bootloader mode status */
-#define QT602240_WAITING_BOOTLOAD_CMD	0xc0	/* valid 7 6 bit only */
-#define QT602240_WAITING_FRAME_DATA	0x80	/* valid 7 6 bit only */
-#define QT602240_FRAME_CRC_CHECK	0x02
-#define QT602240_FRAME_CRC_FAIL		0x03
-#define QT602240_FRAME_CRC_PASS		0x04
-#define QT602240_APP_CRC_FAIL		0x40	/* valid 7 8 bit only */
-#define QT602240_BOOT_STATUS_MASK	0x3f
+#define MXT_WAITING_BOOTLOAD_CMD	0xc0	/* valid 7 6 bit only */
+#define MXT_WAITING_FRAME_DATA	0x80	/* valid 7 6 bit only */
+#define MXT_FRAME_CRC_CHECK	0x02
+#define MXT_FRAME_CRC_FAIL	0x03
+#define MXT_FRAME_CRC_PASS	0x04
+#define MXT_APP_CRC_FAIL	0x40	/* valid 7 8 bit only */
+#define MXT_BOOT_STATUS_MASK	0x3f
 
 /* Touch status */
-#define QT602240_SUPPRESS		(1 << 1)
-#define QT602240_AMP			(1 << 2)
-#define QT602240_VECTOR			(1 << 3)
-#define QT602240_MOVE			(1 << 4)
-#define QT602240_RELEASE		(1 << 5)
-#define QT602240_PRESS			(1 << 6)
-#define QT602240_DETECT			(1 << 7)
+#define MXT_SUPPRESS		(1 << 1)
+#define MXT_AMP			(1 << 2)
+#define MXT_VECTOR		(1 << 3)
+#define MXT_MOVE		(1 << 4)
+#define MXT_RELEASE		(1 << 5)
+#define MXT_PRESS		(1 << 6)
+#define MXT_DETECT		(1 << 7)
 
 /* Touchscreen absolute values */
-#define QT602240_MAX_XC			0x3ff
-#define QT602240_MAX_YC			0x3ff
-#define QT602240_MAX_AREA		0xff
-
-#define QT602240_MAX_FINGER		10
-
-/* Initial register values recommended from chip vendor */
-static const u8 init_vals_ver_20[] = {
-	/* QT602240_GEN_COMMAND(6) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_GEN_POWER(7) */
-	0x20, 0xff, 0x32,
-	/* QT602240_GEN_ACQUIRE(8) */
-	0x08, 0x05, 0x05, 0x00, 0x00, 0x00, 0x05, 0x14,
-	/* QT602240_TOUCH_MULTI(9) */
-	0x00, 0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x00, 0x02, 0x00,
-	0x00, 0x01, 0x01, 0x0e, 0x0a, 0x0a, 0x0a, 0x0a, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x88, 0x64,
-	/* QT602240_TOUCH_KEYARRAY(15) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00,
-	/* QT602240_SPT_GPIOPWM(19) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
-	/* QT602240_PROCI_GRIPFACE(20) */
-	0x00, 0x64, 0x64, 0x64, 0x64, 0x00, 0x00, 0x1e, 0x14, 0x04,
-	0x1e, 0x00,
-	/* QT602240_PROCG_NOISE(22) */
-	0x05, 0x00, 0x00, 0x19, 0x00, 0xe7, 0xff, 0x04, 0x32, 0x00,
-	0x01, 0x0a, 0x0f, 0x14, 0x00, 0x00, 0xe8,
-	/* QT602240_TOUCH_PROXIMITY(23) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00,
-	/* QT602240_PROCI_ONETOUCH(24) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_SPT_SELFTEST(25) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	/* QT602240_PROCI_TWOTOUCH(27) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_SPT_CTECONFIG(28) */
-	0x00, 0x00, 0x00, 0x04, 0x08,
-};
+#define MXT_MAX_XC		0x3ff
+#define MXT_MAX_YC		0x3ff
+#define MXT_MAX_AREA		0xff
 
-static const u8 init_vals_ver_21[] = {
-	/* QT602240_GEN_COMMAND(6) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_GEN_POWER(7) */
-	0x20, 0xff, 0x32,
-	/* QT602240_GEN_ACQUIRE(8) */
-	0x0a, 0x00, 0x05, 0x00, 0x00, 0x00, 0x09, 0x23,
-	/* QT602240_TOUCH_MULTI(9) */
-	0x00, 0x00, 0x00, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x02, 0x00,
-	0x00, 0x01, 0x01, 0x0e, 0x0a, 0x0a, 0x0a, 0x0a, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_TOUCH_KEYARRAY(15) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00,
-	/* QT602240_SPT_GPIOPWM(19) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_PROCI_GRIPFACE(20) */
-	0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x28, 0x04,
-	0x0f, 0x0a,
-	/* QT602240_PROCG_NOISE(22) */
-	0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x23, 0x00,
-	0x00, 0x05, 0x0f, 0x19, 0x23, 0x2d, 0x03,
-	/* QT602240_TOUCH_PROXIMITY(23) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00,
-	/* QT602240_PROCI_ONETOUCH(24) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_SPT_SELFTEST(25) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	/* QT602240_PROCI_TWOTOUCH(27) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_SPT_CTECONFIG(28) */
-	0x00, 0x00, 0x00, 0x08, 0x10, 0x00,
-};
+#define MXT_MAX_FINGER		10
 
-static const u8 init_vals_ver_22[] = {
-	/* QT602240_GEN_COMMAND(6) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_GEN_POWER(7) */
-	0x20, 0xff, 0x32,
-	/* QT602240_GEN_ACQUIRE(8) */
-	0x0a, 0x00, 0x05, 0x00, 0x00, 0x00, 0x09, 0x23,
-	/* QT602240_TOUCH_MULTI(9) */
-	0x00, 0x00, 0x00, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x02, 0x00,
-	0x00, 0x01, 0x01, 0x0e, 0x0a, 0x0a, 0x0a, 0x0a, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00,
-	/* QT602240_TOUCH_KEYARRAY(15) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00,
-	/* QT602240_SPT_GPIOPWM(19) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_PROCI_GRIPFACE(20) */
-	0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x28, 0x04,
-	0x0f, 0x0a,
-	/* QT602240_PROCG_NOISE(22) */
-	0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x23, 0x00,
-	0x00, 0x05, 0x0f, 0x19, 0x23, 0x2d, 0x03,
-	/* QT602240_TOUCH_PROXIMITY(23) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_PROCI_ONETOUCH(24) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_SPT_SELFTEST(25) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	/* QT602240_PROCI_TWOTOUCH(27) */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* QT602240_SPT_CTECONFIG(28) */
-	0x00, 0x00, 0x00, 0x08, 0x10, 0x00,
-};
-
-struct qt602240_info {
+struct mxt_info {
 	u8 family_id;
 	u8 variant_id;
 	u8 version;
@@ -325,7 +209,7 @@ struct qt602240_info {
 	u8 object_num;
 };
 
-struct qt602240_object {
+struct mxt_object {
 	u8 type;
 	u16 start_address;
 	u8 size;
@@ -336,13 +220,13 @@ struct qt602240_object {
 	u8 max_reportid;
 };
 
-struct qt602240_message {
+struct mxt_message {
 	u8 reportid;
 	u8 message[7];
 	u8 checksum;
 };
 
-struct qt602240_finger {
+struct mxt_finger {
 	int status;
 	int x;
 	int y;
@@ -350,65 +234,65 @@ struct qt602240_finger {
 };
 
 /* Each client has this additional data */
-struct qt602240_data {
+struct mxt_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
-	const struct qt602240_platform_data *pdata;
-	struct qt602240_object *object_table;
-	struct qt602240_info info;
-	struct qt602240_finger finger[QT602240_MAX_FINGER];
+	const struct mxt_platform_data *pdata;
+	struct mxt_object *object_table;
+	struct mxt_info info;
+	struct mxt_finger finger[MXT_MAX_FINGER];
 	unsigned int irq;
 };
 
-static bool qt602240_object_readable(unsigned int type)
+static bool mxt_object_readable(unsigned int type)
 {
 	switch (type) {
-	case QT602240_GEN_MESSAGE:
-	case QT602240_GEN_COMMAND:
-	case QT602240_GEN_POWER:
-	case QT602240_GEN_ACQUIRE:
-	case QT602240_TOUCH_MULTI:
-	case QT602240_TOUCH_KEYARRAY:
-	case QT602240_TOUCH_PROXIMITY:
-	case QT602240_PROCI_GRIPFACE:
-	case QT602240_PROCG_NOISE:
-	case QT602240_PROCI_ONETOUCH:
-	case QT602240_PROCI_TWOTOUCH:
-	case QT602240_SPT_COMMSCONFIG:
-	case QT602240_SPT_GPIOPWM:
-	case QT602240_SPT_SELFTEST:
-	case QT602240_SPT_CTECONFIG:
-	case QT602240_SPT_USERDATA:
+	case MXT_GEN_MESSAGE:
+	case MXT_GEN_COMMAND:
+	case MXT_GEN_POWER:
+	case MXT_GEN_ACQUIRE:
+	case MXT_TOUCH_MULTI:
+	case MXT_TOUCH_KEYARRAY:
+	case MXT_TOUCH_PROXIMITY:
+	case MXT_PROCI_GRIPFACE:
+	case MXT_PROCG_NOISE:
+	case MXT_PROCI_ONETOUCH:
+	case MXT_PROCI_TWOTOUCH:
+	case MXT_SPT_COMMSCONFIG:
+	case MXT_SPT_GPIOPWM:
+	case MXT_SPT_SELFTEST:
+	case MXT_SPT_CTECONFIG:
+	case MXT_SPT_USERDATA:
 		return true;
 	default:
 		return false;
 	}
 }
 
-static bool qt602240_object_writable(unsigned int type)
+static bool mxt_object_writable(unsigned int type)
 {
 	switch (type) {
-	case QT602240_GEN_COMMAND:
-	case QT602240_GEN_POWER:
-	case QT602240_GEN_ACQUIRE:
-	case QT602240_TOUCH_MULTI:
-	case QT602240_TOUCH_KEYARRAY:
-	case QT602240_TOUCH_PROXIMITY:
-	case QT602240_PROCI_GRIPFACE:
-	case QT602240_PROCG_NOISE:
-	case QT602240_PROCI_ONETOUCH:
-	case QT602240_PROCI_TWOTOUCH:
-	case QT602240_SPT_GPIOPWM:
-	case QT602240_SPT_SELFTEST:
-	case QT602240_SPT_CTECONFIG:
+	case MXT_GEN_COMMAND:
+	case MXT_GEN_POWER:
+	case MXT_GEN_ACQUIRE:
+	case MXT_TOUCH_MULTI:
+	case MXT_TOUCH_KEYARRAY:
+	case MXT_TOUCH_PROXIMITY:
+	case MXT_PROCI_GRIPFACE:
+	case MXT_PROCG_NOISE:
+	case MXT_PROCI_ONETOUCH:
+	case MXT_PROCI_TWOTOUCH:
+	case MXT_SPT_GPIOPWM:
+	case MXT_SPT_SELFTEST:
+	case MXT_SPT_CTECONFIG:
 		return true;
 	default:
 		return false;
 	}
 }
 
-static void qt602240_dump_message(struct device *dev,
-				  struct qt602240_message *message)
+static void mxt_dump_message(struct device *dev,
+				  struct mxt_message *message)
 {
 	dev_dbg(dev, "reportid:\t0x%x\n", message->reportid);
 	dev_dbg(dev, "message1:\t0x%x\n", message->message[0]);
@@ -421,7 +305,7 @@ static void qt602240_dump_message(struct device *dev,
 	dev_dbg(dev, "checksum:\t0x%x\n", message->checksum);
 }
 
-static int qt602240_check_bootloader(struct i2c_client *client,
+static int mxt_check_bootloader(struct i2c_client *client,
 				     unsigned int state)
 {
 	u8 val;
@@ -433,12 +317,12 @@ recheck:
 	}
 
 	switch (state) {
-	case QT602240_WAITING_BOOTLOAD_CMD:
-	case QT602240_WAITING_FRAME_DATA:
-		val &= ~QT602240_BOOT_STATUS_MASK;
+	case MXT_WAITING_BOOTLOAD_CMD:
+	case MXT_WAITING_FRAME_DATA:
+		val &= ~MXT_BOOT_STATUS_MASK;
 		break;
-	case QT602240_FRAME_CRC_PASS:
-		if (val == QT602240_FRAME_CRC_CHECK)
+	case MXT_FRAME_CRC_PASS:
+		if (val == MXT_FRAME_CRC_CHECK)
 			goto recheck;
 		break;
 	default:
@@ -453,12 +337,12 @@ recheck:
 	return 0;
 }
 
-static int qt602240_unlock_bootloader(struct i2c_client *client)
+static int mxt_unlock_bootloader(struct i2c_client *client)
 {
 	u8 buf[2];
 
-	buf[0] = QT602240_UNLOCK_CMD_LSB;
-	buf[1] = QT602240_UNLOCK_CMD_MSB;
+	buf[0] = MXT_UNLOCK_CMD_LSB;
+	buf[1] = MXT_UNLOCK_CMD_MSB;
 
 	if (i2c_master_send(client, buf, 2) != 2) {
 		dev_err(&client->dev, "%s: i2c send failed\n", __func__);
@@ -468,7 +352,7 @@ static int qt602240_unlock_bootloader(struct i2c_client *client)
 	return 0;
 }
 
-static int qt602240_fw_write(struct i2c_client *client,
+static int mxt_fw_write(struct i2c_client *client,
 			     const u8 *data, unsigned int frame_size)
 {
 	if (i2c_master_send(client, data, frame_size) != frame_size) {
@@ -479,7 +363,7 @@ static int qt602240_fw_write(struct i2c_client *client,
 	return 0;
 }
 
-static int __qt602240_read_reg(struct i2c_client *client,
+static int __mxt_read_reg(struct i2c_client *client,
 			       u16 reg, u16 len, void *val)
 {
 	struct i2c_msg xfer[2];
@@ -508,12 +392,12 @@ static int __qt602240_read_reg(struct i2c_client *client,
 	return 0;
 }
 
-static int qt602240_read_reg(struct i2c_client *client, u16 reg, u8 *val)
+static int mxt_read_reg(struct i2c_client *client, u16 reg, u8 *val)
 {
-	return __qt602240_read_reg(client, reg, 1, val);
+	return __mxt_read_reg(client, reg, 1, val);
 }
 
-static int qt602240_write_reg(struct i2c_client *client, u16 reg, u8 val)
+static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 val)
 {
 	u8 buf[3];
 
@@ -529,17 +413,17 @@ static int qt602240_write_reg(struct i2c_client *client, u16 reg, u8 val)
 	return 0;
 }
 
-static int qt602240_read_object_table(struct i2c_client *client,
+static int mxt_read_object_table(struct i2c_client *client,
 				      u16 reg, u8 *object_buf)
 {
-	return __qt602240_read_reg(client, reg, QT602240_OBJECT_SIZE,
+	return __mxt_read_reg(client, reg, MXT_OBJECT_SIZE,
 				   object_buf);
 }
 
-static struct qt602240_object *
-qt602240_get_object(struct qt602240_data *data, u8 type)
+static struct mxt_object *
+mxt_get_object(struct mxt_data *data, u8 type)
 {
-	struct qt602240_object *object;
+	struct mxt_object *object;
 	int i;
 
 	for (i = 0; i < data->info.object_num; i++) {
@@ -552,63 +436,63 @@ qt602240_get_object(struct qt602240_data *data, u8 type)
 	return NULL;
 }
 
-static int qt602240_read_message(struct qt602240_data *data,
-				 struct qt602240_message *message)
+static int mxt_read_message(struct mxt_data *data,
+				 struct mxt_message *message)
 {
-	struct qt602240_object *object;
+	struct mxt_object *object;
 	u16 reg;
 
-	object = qt602240_get_object(data, QT602240_GEN_MESSAGE);
+	object = mxt_get_object(data, MXT_GEN_MESSAGE);
 	if (!object)
 		return -EINVAL;
 
 	reg = object->start_address;
-	return __qt602240_read_reg(data->client, reg,
-			sizeof(struct qt602240_message), message);
+	return __mxt_read_reg(data->client, reg,
+			sizeof(struct mxt_message), message);
 }
 
-static int qt602240_read_object(struct qt602240_data *data,
+static int mxt_read_object(struct mxt_data *data,
 				u8 type, u8 offset, u8 *val)
 {
-	struct qt602240_object *object;
+	struct mxt_object *object;
 	u16 reg;
 
-	object = qt602240_get_object(data, type);
+	object = mxt_get_object(data, type);
 	if (!object)
 		return -EINVAL;
 
 	reg = object->start_address;
-	return __qt602240_read_reg(data->client, reg + offset, 1, val);
+	return __mxt_read_reg(data->client, reg + offset, 1, val);
 }
 
-static int qt602240_write_object(struct qt602240_data *data,
+static int mxt_write_object(struct mxt_data *data,
 				 u8 type, u8 offset, u8 val)
 {
-	struct qt602240_object *object;
+	struct mxt_object *object;
 	u16 reg;
 
-	object = qt602240_get_object(data, type);
+	object = mxt_get_object(data, type);
 	if (!object)
 		return -EINVAL;
 
 	reg = object->start_address;
-	return qt602240_write_reg(data->client, reg + offset, val);
+	return mxt_write_reg(data->client, reg + offset, val);
 }
 
-static void qt602240_input_report(struct qt602240_data *data, int single_id)
+static void mxt_input_report(struct mxt_data *data, int single_id)
 {
-	struct qt602240_finger *finger = data->finger;
+	struct mxt_finger *finger = data->finger;
 	struct input_dev *input_dev = data->input_dev;
 	int status = finger[single_id].status;
 	int finger_num = 0;
 	int id;
 
-	for (id = 0; id < QT602240_MAX_FINGER; id++) {
+	for (id = 0; id < MXT_MAX_FINGER; id++) {
 		if (!finger[id].status)
 			continue;
 
 		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
-				finger[id].status != QT602240_RELEASE ?
+				finger[id].status != MXT_RELEASE ?
 				finger[id].area : 0);
 		input_report_abs(input_dev, ABS_MT_POSITION_X,
 				finger[id].x);
@@ -616,7 +500,7 @@ static void qt602240_input_report(struct qt602240_data *data, int single_id)
 				finger[id].y);
 		input_mt_sync(input_dev);
 
-		if (finger[id].status == QT602240_RELEASE)
+		if (finger[id].status == MXT_RELEASE)
 			finger[id].status = 0;
 		else
 			finger_num++;
@@ -624,7 +508,7 @@ static void qt602240_input_report(struct qt602240_data *data, int single_id)
 
 	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
 
-	if (status != QT602240_RELEASE) {
+	if (status != MXT_RELEASE) {
 		input_report_abs(input_dev, ABS_X, finger[single_id].x);
 		input_report_abs(input_dev, ABS_Y, finger[single_id].y);
 	}
@@ -632,10 +516,10 @@ static void qt602240_input_report(struct qt602240_data *data, int single_id)
 	input_sync(input_dev);
 }
 
-static void qt602240_input_touchevent(struct qt602240_data *data,
-				      struct qt602240_message *message, int id)
+static void mxt_input_touchevent(struct mxt_data *data,
+				      struct mxt_message *message, int id)
 {
-	struct qt602240_finger *finger = data->finger;
+	struct mxt_finger *finger = data->finger;
 	struct device *dev = &data->client->dev;
 	u8 status = message->message[0];
 	int x;
@@ -643,18 +527,18 @@ static void qt602240_input_touchevent(struct qt602240_data *data,
 	int area;
 
 	/* Check the touch is present on the screen */
-	if (!(status & QT602240_DETECT)) {
-		if (status & QT602240_RELEASE) {
+	if (!(status & MXT_DETECT)) {
+		if (status & MXT_RELEASE) {
 			dev_dbg(dev, "[%d] released\n", id);
 
-			finger[id].status = QT602240_RELEASE;
-			qt602240_input_report(data, id);
+			finger[id].status = MXT_RELEASE;
+			mxt_input_report(data, id);
 		}
 		return;
 	}
 
 	/* Check only AMP detection */
-	if (!(status & (QT602240_PRESS | QT602240_MOVE)))
+	if (!(status & (MXT_PRESS | MXT_MOVE)))
 		return;
 
 	x = (message->message[1] << 2) | ((message->message[3] & ~0x3f) >> 6);
@@ -662,23 +546,23 @@ static void qt602240_input_touchevent(struct qt602240_data *data,
 	area = message->message[4];
 
 	dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
-		status & QT602240_MOVE ? "moved" : "pressed",
+		status & MXT_MOVE ? "moved" : "pressed",
 		x, y, area);
 
-	finger[id].status = status & QT602240_MOVE ?
-				QT602240_MOVE : QT602240_PRESS;
+	finger[id].status = status & MXT_MOVE ?
+				MXT_MOVE : MXT_PRESS;
 	finger[id].x = x;
 	finger[id].y = y;
 	finger[id].area = area;
 
-	qt602240_input_report(data, id);
+	mxt_input_report(data, id);
 }
 
-static irqreturn_t qt602240_interrupt(int irq, void *dev_id)
+static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 {
-	struct qt602240_data *data = dev_id;
-	struct qt602240_message message;
-	struct qt602240_object *object;
+	struct mxt_data *data = dev_id;
+	struct mxt_message message;
+	struct mxt_object *object;
 	struct device *dev = &data->client->dev;
 	int id;
 	u8 reportid;
@@ -686,15 +570,15 @@ static irqreturn_t qt602240_interrupt(int irq, void *dev_id)
 	u8 min_reportid;
 
 	do {
-		if (qt602240_read_message(data, &message)) {
+		if (mxt_read_message(data, &message)) {
 			dev_err(dev, "Failed to read message\n");
 			goto end;
 		}
 
 		reportid = message.reportid;
 
-		/* whether reportid is thing of QT602240_TOUCH_MULTI */
-		object = qt602240_get_object(data, QT602240_TOUCH_MULTI);
+		/* whether reportid is thing of MXT_TOUCH_MULTI */
+		object = mxt_get_object(data, MXT_TOUCH_MULTI);
 		if (!object)
 			goto end;
 
@@ -703,47 +587,39 @@ static irqreturn_t qt602240_interrupt(int irq, void *dev_id)
 		id = reportid - min_reportid;
 
 		if (reportid >= min_reportid && reportid <= max_reportid)
-			qt602240_input_touchevent(data, &message, id);
+			mxt_input_touchevent(data, &message, id);
 		else
-			qt602240_dump_message(dev, &message);
+			mxt_dump_message(dev, &message);
 	} while (reportid != 0xff);
 
 end:
 	return IRQ_HANDLED;
 }
 
-static int qt602240_check_reg_init(struct qt602240_data *data)
+static int mxt_check_reg_init(struct mxt_data *data)
 {
-	struct qt602240_object *object;
+	const struct mxt_platform_data *pdata = data->pdata;
+	struct mxt_object *object;
 	struct device *dev = &data->client->dev;
 	int index = 0;
 	int i, j;
-	u8 version = data->info.version;
 	u8 *init_vals;
 
-	switch (version) {
-	case QT602240_VER_20:
-		init_vals = (u8 *)init_vals_ver_20;
-		break;
-	case QT602240_VER_21:
-		init_vals = (u8 *)init_vals_ver_21;
-		break;
-	case QT602240_VER_22:
-		init_vals = (u8 *)init_vals_ver_22;
-		break;
-	default:
-		dev_err(dev, "Firmware version %d doesn't support\n", version);
-		return -EINVAL;
+	if (pdata->config) {
+		init_vals = pdata->config;
+	} else {
+		dev_err(dev, "No cfg data defined, skipping reg init\n");
+		return 0;
 	}
 
 	for (i = 0; i < data->info.object_num; i++) {
 		object = data->object_table + i;
 
-		if (!qt602240_object_writable(object->type))
+		if (!mxt_object_writable(object->type))
 			continue;
 
 		for (j = 0; j < object->size + 1; j++)
-			qt602240_write_object(data, object->type, j,
+			mxt_write_object(data, object->type, j,
 					init_vals[index + j]);
 
 		index += object->size + 1;
@@ -752,9 +628,9 @@ static int qt602240_check_reg_init(struct qt602240_data *data)
 	return 0;
 }
 
-static int qt602240_check_matrix_size(struct qt602240_data *data)
+static int mxt_check_matrix_size(struct mxt_data *data)
 {
-	const struct qt602240_platform_data *pdata = data->pdata;
+	const struct mxt_platform_data *pdata = data->pdata;
 	struct device *dev = &data->client->dev;
 	int mode = -1;
 	int error;
@@ -801,8 +677,8 @@ static int qt602240_check_matrix_size(struct qt602240_data *data)
 		return -EINVAL;
 	}
 
-	error = qt602240_read_object(data, QT602240_SPT_CTECONFIG,
-				QT602240_CTE_MODE, &val);
+	error = mxt_read_object(data, MXT_SPT_CTECONFIG,
+				MXT_CTE_MODE, &val);
 	if (error)
 		return error;
 
@@ -810,29 +686,29 @@ static int qt602240_check_matrix_size(struct qt602240_data *data)
 		return 0;
 
 	/* Change the CTE configuration */
-	qt602240_write_object(data, QT602240_SPT_CTECONFIG,
-			QT602240_CTE_CTRL, 1);
-	qt602240_write_object(data, QT602240_SPT_CTECONFIG,
-			QT602240_CTE_MODE, mode);
-	qt602240_write_object(data, QT602240_SPT_CTECONFIG,
-			QT602240_CTE_CTRL, 0);
+	mxt_write_object(data, MXT_SPT_CTECONFIG,
+			MXT_CTE_CTRL, 1);
+	mxt_write_object(data, MXT_SPT_CTECONFIG,
+			MXT_CTE_MODE, mode);
+	mxt_write_object(data, MXT_SPT_CTECONFIG,
+			MXT_CTE_CTRL, 0);
 
 	return 0;
 }
 
-static int qt602240_make_highchg(struct qt602240_data *data)
+static int mxt_make_highchg(struct mxt_data *data)
 {
 	struct device *dev = &data->client->dev;
+	struct mxt_message message;
 	int count = 10;
 	int error;
-	u8 val;
 
 	/* Read dummy message to make high CHG pin */
 	do {
-		error = qt602240_read_object(data, QT602240_GEN_MESSAGE, 0, &val);
+		error = mxt_read_message(data, &message);
 		if (error)
 			return error;
-	} while ((val != 0xff) && --count);
+	} while ((message.reportid != 0xff) && --count);
 
 	if (!count) {
 		dev_err(dev, "CHG pin isn't cleared\n");
@@ -842,82 +718,82 @@ static int qt602240_make_highchg(struct qt602240_data *data)
 	return 0;
 }
 
-static void qt602240_handle_pdata(struct qt602240_data *data)
+static void mxt_handle_pdata(struct mxt_data *data)
 {
-	const struct qt602240_platform_data *pdata = data->pdata;
+	const struct mxt_platform_data *pdata = data->pdata;
 	u8 voltage;
 
 	/* Set touchscreen lines */
-	qt602240_write_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_XSIZE,
+	mxt_write_object(data, MXT_TOUCH_MULTI, MXT_TOUCH_XSIZE,
 			pdata->x_line);
-	qt602240_write_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_YSIZE,
+	mxt_write_object(data, MXT_TOUCH_MULTI, MXT_TOUCH_YSIZE,
 			pdata->y_line);
 
 	/* Set touchscreen orient */
-	qt602240_write_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_ORIENT,
+	mxt_write_object(data, MXT_TOUCH_MULTI, MXT_TOUCH_ORIENT,
 			pdata->orient);
 
 	/* Set touchscreen burst length */
-	qt602240_write_object(data, QT602240_TOUCH_MULTI,
-			QT602240_TOUCH_BLEN, pdata->blen);
+	mxt_write_object(data, MXT_TOUCH_MULTI,
+			MXT_TOUCH_BLEN, pdata->blen);
 
 	/* Set touchscreen threshold */
-	qt602240_write_object(data, QT602240_TOUCH_MULTI,
-			QT602240_TOUCH_TCHTHR, pdata->threshold);
+	mxt_write_object(data, MXT_TOUCH_MULTI,
+			MXT_TOUCH_TCHTHR, pdata->threshold);
 
 	/* Set touchscreen resolution */
-	qt602240_write_object(data, QT602240_TOUCH_MULTI,
-			QT602240_TOUCH_XRANGE_LSB, (pdata->x_size - 1) & 0xff);
-	qt602240_write_object(data, QT602240_TOUCH_MULTI,
-			QT602240_TOUCH_XRANGE_MSB, (pdata->x_size - 1) >> 8);
-	qt602240_write_object(data, QT602240_TOUCH_MULTI,
-			QT602240_TOUCH_YRANGE_LSB, (pdata->y_size - 1) & 0xff);
-	qt602240_write_object(data, QT602240_TOUCH_MULTI,
-			QT602240_TOUCH_YRANGE_MSB, (pdata->y_size - 1) >> 8);
+	mxt_write_object(data, MXT_TOUCH_MULTI,
+			MXT_TOUCH_XRANGE_LSB, (pdata->x_size - 1) & 0xff);
+	mxt_write_object(data, MXT_TOUCH_MULTI,
+			MXT_TOUCH_XRANGE_MSB, (pdata->x_size - 1) >> 8);
+	mxt_write_object(data, MXT_TOUCH_MULTI,
+			MXT_TOUCH_YRANGE_LSB, (pdata->y_size - 1) & 0xff);
+	mxt_write_object(data, MXT_TOUCH_MULTI,
+			MXT_TOUCH_YRANGE_MSB, (pdata->y_size - 1) >> 8);
 
 	/* Set touchscreen voltage */
-	if (data->info.version >= QT602240_VER_21 && pdata->voltage) {
-		if (pdata->voltage < QT602240_VOLTAGE_DEFAULT) {
-			voltage = (QT602240_VOLTAGE_DEFAULT - pdata->voltage) /
-				QT602240_VOLTAGE_STEP;
+	if (data->info.version >= MXT_VER_21 && pdata->voltage) {
+		if (pdata->voltage < MXT_VOLTAGE_DEFAULT) {
+			voltage = (MXT_VOLTAGE_DEFAULT - pdata->voltage) /
+				MXT_VOLTAGE_STEP;
 			voltage = 0xff - voltage + 1;
 		} else
-			voltage = (pdata->voltage - QT602240_VOLTAGE_DEFAULT) /
-				QT602240_VOLTAGE_STEP;
+			voltage = (pdata->voltage - MXT_VOLTAGE_DEFAULT) /
+				MXT_VOLTAGE_STEP;
 
-		qt602240_write_object(data, QT602240_SPT_CTECONFIG,
-				QT602240_CTE_VOLTAGE, voltage);
+		mxt_write_object(data, MXT_SPT_CTECONFIG,
+				MXT_CTE_VOLTAGE, voltage);
 	}
 }
 
-static int qt602240_get_info(struct qt602240_data *data)
+static int mxt_get_info(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
-	struct qt602240_info *info = &data->info;
+	struct mxt_info *info = &data->info;
 	int error;
 	u8 val;
 
-	error = qt602240_read_reg(client, QT602240_FAMILY_ID, &val);
+	error = mxt_read_reg(client, MXT_FAMILY_ID, &val);
 	if (error)
 		return error;
 	info->family_id = val;
 
-	error = qt602240_read_reg(client, QT602240_VARIANT_ID, &val);
+	error = mxt_read_reg(client, MXT_VARIANT_ID, &val);
 	if (error)
 		return error;
 	info->variant_id = val;
 
-	error = qt602240_read_reg(client, QT602240_VERSION, &val);
+	error = mxt_read_reg(client, MXT_VERSION, &val);
 	if (error)
 		return error;
 	info->version = val;
 
-	error = qt602240_read_reg(client, QT602240_BUILD, &val);
+	error = mxt_read_reg(client, MXT_BUILD, &val);
 	if (error)
 		return error;
 	info->build = val;
 
-	error = qt602240_read_reg(client, QT602240_OBJECT_NUM, &val);
+	error = mxt_read_reg(client, MXT_OBJECT_NUM, &val);
 	if (error)
 		return error;
 	info->object_num = val;
@@ -925,19 +801,19 @@ static int qt602240_get_info(struct qt602240_data *data)
 	return 0;
 }
 
-static int qt602240_get_object_table(struct qt602240_data *data)
+static int mxt_get_object_table(struct mxt_data *data)
 {
 	int error;
 	int i;
 	u16 reg;
 	u8 reportid = 0;
-	u8 buf[QT602240_OBJECT_SIZE];
+	u8 buf[MXT_OBJECT_SIZE];
 
 	for (i = 0; i < data->info.object_num; i++) {
-		struct qt602240_object *object = data->object_table + i;
+		struct mxt_object *object = data->object_table + i;
 
-		reg = QT602240_OBJECT_START + QT602240_OBJECT_SIZE * i;
-		error = qt602240_read_object_table(data->client, reg, buf);
+		reg = MXT_OBJECT_START + MXT_OBJECT_SIZE * i;
+		error = mxt_read_object_table(data->client, reg, buf);
 		if (error)
 			return error;
 
@@ -957,19 +833,19 @@ static int qt602240_get_object_table(struct qt602240_data *data)
 	return 0;
 }
 
-static int qt602240_initialize(struct qt602240_data *data)
+static int mxt_initialize(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
-	struct qt602240_info *info = &data->info;
+	struct mxt_info *info = &data->info;
 	int error;
 	u8 val;
 
-	error = qt602240_get_info(data);
+	error = mxt_get_info(data);
 	if (error)
 		return error;
 
 	data->object_table = kcalloc(info->object_num,
-				     sizeof(struct qt602240_object),
+				     sizeof(struct mxt_object),
 				     GFP_KERNEL);
 	if (!data->object_table) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
@@ -977,44 +853,52 @@ static int qt602240_initialize(struct qt602240_data *data)
 	}
 
 	/* Get object table information */
-	error = qt602240_get_object_table(data);
+	error = mxt_get_object_table(data);
 	if (error)
 		return error;
 
 	/* Check register init values */
-	error = qt602240_check_reg_init(data);
+	error = mxt_check_reg_init(data);
 	if (error)
 		return error;
 
 	/* Check X/Y matrix size */
-	error = qt602240_check_matrix_size(data);
+
+	/*
+	 * Skip this and trust what's on the chip, as the current check
+	 * is not compatible with mXT1386. Revisit and fix.
+	 */
+
+	/*
+	error = mxt_check_matrix_size(data);
 	if (error)
 		return error;
+	*/
 
-	error = qt602240_make_highchg(data);
+	error = mxt_make_highchg(data);
 	if (error)
 		return error;
 
-	qt602240_handle_pdata(data);
+	mxt_handle_pdata(data);
 
 	/* Backup to memory */
-	qt602240_write_object(data, QT602240_GEN_COMMAND,
-			QT602240_COMMAND_BACKUPNV,
-			QT602240_BACKUP_VALUE);
-	msleep(QT602240_BACKUP_TIME);
+	mxt_write_object(data, MXT_GEN_COMMAND,
+			MXT_COMMAND_BACKUPNV,
+			MXT_BACKUP_VALUE);
+	msleep(MXT_BACKUP_TIME);
 
 	/* Soft reset */
-	qt602240_write_object(data, QT602240_GEN_COMMAND,
-			QT602240_COMMAND_RESET, 1);
-	msleep(QT602240_RESET_TIME);
+	mxt_write_object(data, MXT_GEN_COMMAND,
+			MXT_COMMAND_RESET, 1);
+	msleep(MXT_RESET_TIME);
 
 	/* Update matrix size at info struct */
-	error = qt602240_read_reg(client, QT602240_MATRIX_X_SIZE, &val);
+	error = mxt_read_reg(client, MXT_MATRIX_X_SIZE, &val);
 	if (error)
 		return error;
 	info->matrix_xsize = val;
 
-	error = qt602240_read_reg(client, QT602240_MATRIX_Y_SIZE, &val);
+	error = mxt_read_reg(client, MXT_MATRIX_Y_SIZE, &val);
 	if (error)
 		return error;
 	info->matrix_ysize = val;
@@ -1032,11 +916,11 @@ static int qt602240_initialize(struct qt602240_data *data)
 	return 0;
 }
 
-static ssize_t qt602240_object_show(struct device *dev,
+static ssize_t mxt_object_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct qt602240_data *data = dev_get_drvdata(dev);
-	struct qt602240_object *object;
+	struct mxt_data *data = dev_get_drvdata(dev);
+	struct mxt_object *object;
 	int count = 0;
 	int i, j;
 	int error;
@@ -1049,13 +933,13 @@ static ssize_t qt602240_object_show(struct device *dev,
 				"Object Table Element %d(Type %d)\n",
 				i + 1, object->type);
 
-		if (!qt602240_object_readable(object->type)) {
+		if (!mxt_object_readable(object->type)) {
 			count += sprintf(buf + count, "\n");
 			continue;
 		}
 
 		for (j = 0; j < object->size + 1; j++) {
-			error = qt602240_read_object(data,
+			error = mxt_read_object(data,
 						object->type, j, &val);
 			if (error)
 				return error;
@@ -1070,9 +954,9 @@ static ssize_t qt602240_object_show(struct device *dev,
 	return count;
 }
 
-static int qt602240_load_fw(struct device *dev, const char *fn)
+static int mxt_load_fw(struct device *dev, const char *fn)
 {
-	struct qt602240_data *data = dev_get_drvdata(dev);
+	struct mxt_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	const struct firmware *fw = NULL;
 	unsigned int frame_size;
@@ -1086,26 +970,26 @@ static int qt602240_load_fw(struct device *dev, const char *fn)
 	}
 
 	/* Change to the bootloader mode */
-	qt602240_write_object(data, QT602240_GEN_COMMAND,
-			QT602240_COMMAND_RESET, QT602240_BOOT_VALUE);
-	msleep(QT602240_RESET_TIME);
+	mxt_write_object(data, MXT_GEN_COMMAND,
+			MXT_COMMAND_RESET, MXT_BOOT_VALUE);
+	msleep(MXT_RESET_TIME);
 
 	/* Change to slave address of bootloader */
-	if (client->addr == QT602240_APP_LOW)
-		client->addr = QT602240_BOOT_LOW;
+	if (client->addr == MXT_APP_LOW)
+		client->addr = MXT_BOOT_LOW;
 	else
-		client->addr = QT602240_BOOT_HIGH;
+		client->addr = MXT_BOOT_HIGH;
 
-	ret = qt602240_check_bootloader(client, QT602240_WAITING_BOOTLOAD_CMD);
+	ret = mxt_check_bootloader(client, MXT_WAITING_BOOTLOAD_CMD);
 	if (ret)
 		goto out;
 
 	/* Unlock bootloader */
-	qt602240_unlock_bootloader(client);
+	mxt_unlock_bootloader(client);
 
 	while (pos < fw->size) {
-		ret = qt602240_check_bootloader(client,
-						QT602240_WAITING_FRAME_DATA);
+		ret = mxt_check_bootloader(client,
+						MXT_WAITING_FRAME_DATA);
 		if (ret)
 			goto out;
 
@@ -1117,10 +1001,10 @@ static int qt602240_load_fw(struct device *dev, const char *fn)
 		frame_size += 2;
 
 		/* Write one frame to device */
-		qt602240_fw_write(client, fw->data + pos, frame_size);
+		mxt_fw_write(client, fw->data + pos, frame_size);
 
-		ret = qt602240_check_bootloader(client,
-						QT602240_FRAME_CRC_PASS);
+		ret = mxt_check_bootloader(client,
+						MXT_FRAME_CRC_PASS);
 		if (ret)
 			goto out;
 
@@ -1133,19 +1017,19 @@ out:
 	release_firmware(fw);
 
 	/* Change to slave address of application */
-	if (client->addr == QT602240_BOOT_LOW)
-		client->addr = QT602240_APP_LOW;
+	if (client->addr == MXT_BOOT_LOW)
+		client->addr = MXT_APP_LOW;
 	else
-		client->addr = QT602240_APP_HIGH;
+		client->addr = MXT_APP_HIGH;
 
 	return ret;
 }
 
-static ssize_t qt602240_update_fw_store(struct device *dev,
+static ssize_t mxt_update_fw_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	struct qt602240_data *data = dev_get_drvdata(dev);
+	struct mxt_data *data = dev_get_drvdata(dev);
 	unsigned int version;
 	int error;
 
@@ -1154,14 +1038,14 @@ static ssize_t qt602240_update_fw_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (data->info.version < QT602240_VER_21 || version < QT602240_VER_21) {
+	if (data->info.version < MXT_VER_21 || version < MXT_VER_21) {
 		dev_err(dev, "FW update supported starting with version 21\n");
 		return -EINVAL;
 	}
 
 	disable_irq(data->irq);
 
-	error = qt602240_load_fw(dev, QT602240_FW_NAME);
+	error = mxt_load_fw(dev, MXT_FW_NAME);
 	if (error) {
 		dev_err(dev, "The firmware update failed(%d)\n", error);
 		count = error;
@@ -1169,12 +1053,12 @@ static ssize_t qt602240_update_fw_store(struct device *dev,
 		dev_dbg(dev, "The firmware update succeeded\n");
 
 		/* Wait for reset */
-		msleep(QT602240_FWRESET_TIME);
+		msleep(MXT_FWRESET_TIME);
 
 		kfree(data->object_table);
 		data->object_table = NULL;
 
-		qt602240_initialize(data);
+		mxt_initialize(data);
 	}
 
 	enable_irq(data->irq);
@@ -1182,60 +1066,60 @@ static ssize_t qt602240_update_fw_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(object, 0444, qt602240_object_show, NULL);
-static DEVICE_ATTR(update_fw, 0664, NULL, qt602240_update_fw_store);
+static DEVICE_ATTR(object, 0444, mxt_object_show, NULL);
+static DEVICE_ATTR(update_fw, 0664, NULL, mxt_update_fw_store);
 
-static struct attribute *qt602240_attrs[] = {
+static struct attribute *mxt_attrs[] = {
 	&dev_attr_object.attr,
 	&dev_attr_update_fw.attr,
 	NULL
 };
 
-static const struct attribute_group qt602240_attr_group = {
-	.attrs = qt602240_attrs,
+static const struct attribute_group mxt_attr_group = {
+	.attrs = mxt_attrs,
 };
 
-static void qt602240_start(struct qt602240_data *data)
+static void mxt_start(struct mxt_data *data)
 {
 	/* Touch enable */
-	qt602240_write_object(data,
-			QT602240_TOUCH_MULTI, QT602240_TOUCH_CTRL, 0x83);
+	mxt_write_object(data,
+			MXT_TOUCH_MULTI, MXT_TOUCH_CTRL, 0x83);
 }
 
-static void qt602240_stop(struct qt602240_data *data)
+static void mxt_stop(struct mxt_data *data)
 {
 	/* Touch disable */
-	qt602240_write_object(data,
-			QT602240_TOUCH_MULTI, QT602240_TOUCH_CTRL, 0);
+	mxt_write_object(data,
+			MXT_TOUCH_MULTI, MXT_TOUCH_CTRL, 0);
 }
 
-static int qt602240_input_open(struct input_dev *dev)
+static int mxt_input_open(struct input_dev *dev)
 {
-	struct qt602240_data *data = input_get_drvdata(dev);
+	struct mxt_data *data = input_get_drvdata(dev);
 
-	qt602240_start(data);
+	mxt_start(data);
 
 	return 0;
 }
 
-static void qt602240_input_close(struct input_dev *dev)
+static void mxt_input_close(struct input_dev *dev)
 {
-	struct qt602240_data *data = input_get_drvdata(dev);
+	struct mxt_data *data = input_get_drvdata(dev);
 
-	qt602240_stop(data);
+	mxt_stop(data);
 }
 
-static int __devinit qt602240_probe(struct i2c_client *client,
+static int __devinit mxt_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	struct qt602240_data *data;
+	struct mxt_data *data;
 	struct input_dev *input_dev;
 	int error;
 
 	if (!client->dev.platform_data)
 		return -EINVAL;
 
-	data = kzalloc(sizeof(struct qt602240_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
@@ -1243,11 +1127,11 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	input_dev->name = "AT42QT602240/ATMXT224 Touchscreen";
+	input_dev->name = "Atmel maXTouch Touchscreen";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
-	input_dev->open = qt602240_input_open;
-	input_dev->close = qt602240_input_close;
+	input_dev->open = mxt_input_open;
+	input_dev->close = mxt_input_close;
 
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
@@ -1255,17 +1139,17 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 
 	/* For single touch */
 	input_set_abs_params(input_dev, ABS_X,
-			     0, QT602240_MAX_XC, 0, 0);
+			     0, MXT_MAX_XC, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
-			     0, QT602240_MAX_YC, 0, 0);
+			     0, MXT_MAX_YC, 0, 0);
 
 	/* For multi touch */
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-			     0, QT602240_MAX_AREA, 0, 0);
+			     0, MXT_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-			     0, QT602240_MAX_XC, 0, 0);
+			     0, MXT_MAX_XC, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
-			     0, QT602240_MAX_YC, 0, 0);
+			     0, MXT_MAX_YC, 0, 0);
 
 	input_set_drvdata(input_dev, data);
 
@@ -1276,12 +1160,22 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
-	error = qt602240_initialize(data);
+	error = mxt_initialize(data);
 	if (error)
 		goto err_free_object;
 
-	error = request_threaded_irq(client->irq, NULL, qt602240_interrupt,
+	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
 			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
+
+	if (error < 0) {
+		/* If registering an interrupt with falling edge didn't work,
+		   try any edge. */
+		/* Todo: in this case, check the validity of the interrupt by
+		   reading the CHG line state */
+		error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
+			0, client->dev.driver->name, data);
+	}
+
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		goto err_free_object;
@@ -1291,7 +1185,7 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 	if (error)
 		goto err_free_irq;
 
-	error = sysfs_create_group(&client->dev.kobj, &qt602240_attr_group);
+	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
 	if (error)
 		goto err_unregister_device;
 
@@ -1310,11 +1204,11 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit qt602240_remove(struct i2c_client *client)
+static int __devexit mxt_remove(struct i2c_client *client)
 {
-	struct qt602240_data *data = i2c_get_clientdata(client);
+	struct mxt_data *data = i2c_get_clientdata(client);
 
-	sysfs_remove_group(&client->dev.kobj, &qt602240_attr_group);
+	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	free_irq(data->irq, data);
 	input_unregister_device(data->input_dev);
 	kfree(data->object_table);
@@ -1324,83 +1218,81 @@ static int __devexit qt602240_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int qt602240_suspend(struct device *dev)
+static int mxt_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct qt602240_data *data = i2c_get_clientdata(client);
+	struct mxt_data *data = i2c_get_clientdata(client);
 	struct input_dev *input_dev = data->input_dev;
 
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		qt602240_stop(data);
+		mxt_stop(data);
 
 	mutex_unlock(&input_dev->mutex);
 
 	return 0;
 }
 
-static int qt602240_resume(struct device *dev)
+static int mxt_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct qt602240_data *data = i2c_get_clientdata(client);
+	struct mxt_data *data = i2c_get_clientdata(client);
 	struct input_dev *input_dev = data->input_dev;
 
 	/* Soft reset */
-	qt602240_write_object(data, QT602240_GEN_COMMAND,
-			QT602240_COMMAND_RESET, 1);
+	mxt_write_object(data, MXT_GEN_COMMAND,
+			MXT_COMMAND_RESET, 1);
 
-	msleep(QT602240_RESET_TIME);
+	msleep(MXT_RESET_TIME);
 
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		qt602240_start(data);
+		mxt_start(data);
 
 	mutex_unlock(&input_dev->mutex);
 
 	return 0;
 }
 
-static const struct dev_pm_ops qt602240_pm_ops = {
-	.suspend	= qt602240_suspend,
-	.resume		= qt602240_resume,
+static const struct dev_pm_ops mxt_pm_ops = {
+	.suspend        = mxt_suspend,
+	.resume         = mxt_resume,
 };
+
 #endif
 
-static const struct i2c_device_id qt602240_id[] = {
-	{ "qt602240_ts", 0 },
+static const struct i2c_device_id mxt_id[] = {
+	{ "atmel_mxt_ts", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, qt602240_id);
+MODULE_DEVICE_TABLE(i2c, mxt_id);
 
-static struct i2c_driver qt602240_driver = {
+static struct i2c_driver mxt_driver = {
 	.driver = {
-		.name	= "qt602240_ts",
+		.name	= "atmel_mxt_ts",
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
-		.pm	= &qt602240_pm_ops,
-#endif
 	},
-	.probe		= qt602240_probe,
-	.remove		= __devexit_p(qt602240_remove),
-	.id_table	= qt602240_id,
+	.probe		= mxt_probe,
+	.remove		= __devexit_p(mxt_remove),
+	.id_table	= mxt_id,
 };
 
-static int __init qt602240_init(void)
+static int __init mxt_init(void)
 {
-	return i2c_add_driver(&qt602240_driver);
+	return i2c_add_driver(&mxt_driver);
 }
 
-static void __exit qt602240_exit(void)
+static void __exit mxt_exit(void)
 {
-	i2c_del_driver(&qt602240_driver);
+	i2c_del_driver(&mxt_driver);
 }
 
-module_init(qt602240_init);
-module_exit(qt602240_exit);
+module_init(mxt_init);
+module_exit(mxt_exit);
 
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
-MODULE_DESCRIPTION("AT42QT602240/ATMXT224 Touchscreen driver");
+MODULE_DESCRIPTION("Atmel maXTouch Touchscreen driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt602240_ts.h
index c5033e1..733c680 100644
--- a/include/linux/i2c/qt602240_ts.h
+++ b/include/linux/i2c/qt602240_ts.h
@@ -1,5 +1,5 @@
 /*
- * AT42QT602240/ATMXT224 Touchscreen driver
+ * Atmel maXTouch Touchscreen driver
  *
  * Copyright (C) 2010 Samsung Electronics Co.Ltd
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
@@ -10,21 +10,38 @@
  * option) any later version.
  */
 
-#ifndef __LINUX_QT602240_TS_H
-#define __LINUX_QT602240_TS_H
+#ifndef __LINUX_MAXTOUCH_TS_H
+#define __LINUX_MAXTOUCH_TS_H
+
+/* Chip I2C Addresses */
+#define	MXT224_I2C_ADDR1				0x4A
+#define	MXT224_I2C_ADDR2				0x4B
+#define	MXT1386_I2C_ADDR1				0x4C
+#define	MXT1386_I2C_ADDR2				0x4D
+#define	MXT1386_I2C_ADDR3				0x5A
+#define	MXT1386_I2C_ADDR4				0x5B
+
+/*
+ * Select this address from above depending on what maXTouch
+ * chip you have and how it's address pins are configured;
+ * see datasheet.
+ */
+
+#define MXT_I2C_ADDRESS                                 MXT1386_I2C_ADDR1
+
 
 /* Orient */
-#define QT602240_NORMAL			0x0
-#define QT602240_DIAGONAL		0x1
-#define QT602240_HORIZONTAL_FLIP	0x2
-#define QT602240_ROTATED_90_COUNTER	0x3
-#define QT602240_VERTICAL_FLIP		0x4
-#define QT602240_ROTATED_90		0x5
-#define QT602240_ROTATED_180		0x6
-#define QT602240_DIAGONAL_COUNTER	0x7
-
-/* The platform data for the AT42QT602240/ATMXT224 touchscreen driver */
-struct qt602240_platform_data {
+#define MXT_NORMAL		0x0
+#define MXT_DIAGONAL		0x1
+#define MXT_HORIZONTAL_FLIP	0x2
+#define MXT_ROTATED_90_COUNTER	0x3
+#define MXT_VERTICAL_FLIP	0x4
+#define MXT_ROTATED_90		0x5
+#define MXT_ROTATED_180		0x6
+#define MXT_DIAGONAL_COUNTER	0x7
+
+/* The platform data for the Atmel maXTouch touchscreen driver */
+struct mxt_platform_data {
 	unsigned int x_line;
 	unsigned int y_line;
 	unsigned int x_size;
@@ -33,6 +50,7 @@ struct qt602240_platform_data {
 	unsigned int threshold;
 	unsigned int voltage;
 	unsigned char orient;
+	unsigned char *config;
 };
 
-#endif /* __LINUX_QT602240_TS_H */
+#endif /* __LINUX_MAXTOUCH_TS_H */
-- 
1.7.0.4
