From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 14/21 v5] Input: atmel_mxt_ts - update driver ID info logging
Date: Tue, 26 Jun 2012 14:57:02 +0800
Message-ID: <1340693829-18665-15-git-send-email-djkurtz@chromium.org>
References: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

Print unsigned values as '%u'.
Also, parse and print the firmware version in its canonical format, as
suggested by Nick Dyer.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 07e0238..be7da72 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -855,12 +855,12 @@ static int mxt_initialize(struct mxt_data *data)
 	info->matrix_ysize = val;
 
 	dev_info(&client->dev,
-			"Family ID: %d Variant ID: %d Version: %d Build: %d\n",
-			info->family_id, info->variant_id, info->version,
-			info->build);
+			"Family ID: %u Variant ID: %u Major.Minor.Build: %u.%u.%02X\n",
+			info->family_id, info->variant_id, info->version >> 4,
+			info->version & 0xf, info->build);
 
 	dev_info(&client->dev,
-			"Matrix X Size: %d Matrix Y Size: %d Object Num: %d\n",
+			"Matrix X Size: %u Matrix Y Size: %u Object Num: %u\n",
 			info->matrix_xsize, info->matrix_ysize,
 			info->object_num);
 
-- 
1.7.7.3
