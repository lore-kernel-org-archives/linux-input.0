From: Colin King <colin.king@canonical.com>
Subject: [PATCH] Input: cros_ec_keyb: remove redundant variable num_cols
Date: Mon,  2 Jul 2018 17:28:41 +0100
Message-ID: <20180702162841.12553-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ravi Chandra Sadineni <ravisadineni@chromium.org>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable num_cols is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable ‘num_cols’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 820bebad519a..81be6f781f0b 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -160,9 +160,6 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 	int col, row;
 	int new_state;
 	int old_state;
-	int num_cols;
-
-	num_cols = len;
 
 	if (ckdev->ghost_filter && cros_ec_keyb_has_ghosting(ckdev, kb_state)) {
 		/*
-- 
2.17.1
