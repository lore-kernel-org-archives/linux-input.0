From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 12/18] Input: pxa27x_keypad - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:23 +0200
Message-ID: <1443793229-22363-13-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh@kernel.org>, Pramod Gurav <pramod.gurav@smartplayin.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

drivers/input/keyboard/pxa27x_keypad.c:141:1-6: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/keyboard/pxa27x_keypad.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index fcef5d1365e2..436e8c2efbe5 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -138,14 +138,10 @@ static int pxa27x_keypad_matrix_key_parse_dt(struct pxa27x_keypad *keypad,
 	pdata->matrix_key_rows = rows;
 	pdata->matrix_key_cols = cols;
 
-	error = matrix_keypad_build_keymap(NULL, NULL,
-					   pdata->matrix_key_rows,
-					   pdata->matrix_key_cols,
-					   keypad->keycodes, input_dev);
-	if (error)
-		return error;
-
-	return 0;
+	return matrix_keypad_build_keymap(NULL, NULL,
+					  pdata->matrix_key_rows,
+					  pdata->matrix_key_cols,
+					  keypad->keycodes, input_dev);
 }
 
 static int pxa27x_keypad_direct_key_parse_dt(struct pxa27x_keypad *keypad,
-- 
2.4.3
