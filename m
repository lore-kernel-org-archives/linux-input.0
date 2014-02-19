From: AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] Input: ALPS - add support for HP Pavilion 14 TS
Date: Wed, 19 Feb 2014 15:08:09 +0800
Message-ID: <1392793689-10959-1-git-send-email-acelan.kao@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34891 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaBSHIN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 02:08:13 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so473pbc.0
        for <linux-input@vger.kernel.org>; Tue, 18 Feb 2014 23:08:13 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Without the patch, the touchpad works with no cursor.
 [  137.718584] psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 14, EC=73 02 36
 [  138.536736] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input12

After adding its data into the table, it works with cursor.
 [  182.003025] input: DualPoint Stick as /devices/platform/i8042/serio1/input/input13
 [  182.022643] input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input14

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/input/mouse/alps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index fb15c64..74859a0 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -123,6 +123,7 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x62, 0x02, 0x14 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
 	{ { 0x73, 0x00, 0x14 }, 0x00, ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT },		/* Dell XT2 */
+	{ { 0x73, 0x03, 0x14 }, 0x00, ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT },		/* HP Pavilion 14 TS Notebook PC */
 	{ { 0x73, 0x02, 0x50 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },		/* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },				/* Toshiba Tecra A11-11L */
-- 
1.9.rc1

