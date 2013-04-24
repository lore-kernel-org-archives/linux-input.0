From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH 3/6] arm: mmp: use matrix_keymap for aspenite
Date: Tue, 23 Apr 2013 23:20:30 -0400
Message-ID: <1366773633-7727-4-git-send-email-chao.xie@marvell.com>
References: <1366773633-7727-1-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55336 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757400Ab3DXDZz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Apr 2013 23:25:55 -0400
In-Reply-To: <1366773633-7727-1-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, haojian.zhuang@gmail.com, xiechao.mail@gmail.com
Cc: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 9f64d56..1e23346 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -205,7 +205,7 @@ struct pxa168fb_mach_info aspenite_lcd_info = {
 	.invert_pixclock	= 0,
 };
 
-static unsigned int aspenite_matrix_key_map[] = {
+static const unsigned int aspenite_matrix_key_map[] = {
 	KEY(0, 6, KEY_UP),	/* SW 4 */
 	KEY(0, 7, KEY_DOWN),	/* SW 5 */
 	KEY(1, 6, KEY_LEFT),	/* SW 6 */
@@ -214,11 +214,15 @@ static unsigned int aspenite_matrix_key_map[] = {
 	KEY(4, 7, KEY_ESC),	/* SW 9 */
 };
 
+static struct matrix_keymap_data aspenite_matrix_keymap_data = {
+	.keymap			= aspenite_matrix_key_map,
+	.keymap_size		= ARRAY_SIZE(aspenite_matrix_key_map),
+};
+
 static struct pxa27x_keypad_platform_data aspenite_keypad_info __initdata = {
 	.matrix_key_rows	= 5,
 	.matrix_key_cols	= 8,
-	.matrix_key_map		= aspenite_matrix_key_map,
-	.matrix_key_map_size	= ARRAY_SIZE(aspenite_matrix_key_map),
+	.matrix_keymap_data	= &aspenite_matrix_keymap_data,
 	.debounce_interval	= 30,
 };
 
-- 
1.7.4.1

