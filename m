From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH V2 3/5] arm: mmp: use matrix_keymap for teton_bga
Date: Sun, 5 May 2013 23:04:06 -0400
Message-ID: <1367809448-9437-4-git-send-email-chao.xie@marvell.com>
References: <1367809448-9437-1-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367809448-9437-1-git-send-email-chao.xie@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, haojian.zhuang@gmail.com, xiechao.mail@gmail.com
Cc: Chao Xie <chao.xie@marvell.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/teton_bga.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 8609967..d8967fa 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -56,11 +56,15 @@ static unsigned int teton_bga_matrix_key_map[] = {
 	KEY(1, 7, KEY_RIGHT),
 };
 
+static struct matrix_keymap_data teton_bga_matrix_keymap_data = {
+	.keymap			= teton_bga_matrix_key_map,
+	.keymap_size		= ARRAY_SIZE(teton_bga_matrix_key_map),
+};
+
 static struct pxa27x_keypad_platform_data teton_bga_keypad_info __initdata = {
 	.matrix_key_rows        = 2,
 	.matrix_key_cols        = 8,
-	.matrix_key_map         = teton_bga_matrix_key_map,
-	.matrix_key_map_size    = ARRAY_SIZE(teton_bga_matrix_key_map),
+	.matrix_keymap_data	= &teton_bga_matrix_keymap_data,
 	.debounce_interval      = 30,
 };
 
-- 
1.7.4.1
