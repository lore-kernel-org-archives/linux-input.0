From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: atkbd: clean up indentation issue, add missing tab in an if statement
Date: Thu,  1 Nov 2018 15:12:24 +0000
Message-ID: <20181101151224.14840-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up indentation issues, add missing tab

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/keyboard/atkbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 7e75835e220f..850bb259c20e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -841,7 +841,7 @@ static int atkbd_select_set(struct atkbd *atkbd, int target_set, int allow_extra
 	if (param[0] != 3) {
 		param[0] = 2;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SSCANSET))
-		return 2;
+			return 2;
 	}
 
 	ps2_command(ps2dev, param, ATKBD_CMD_SETALL_MBR);
-- 
2.19.1
