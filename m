From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 14/23 v6] Input: atmel_mxt_ts - update driver ID info logging
Date: Thu, 28 Jun 2012 21:08:15 +0800
Message-ID: <1340888904-15620-15-git-send-email-djkurtz@chromium.org>
References: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

Print unsigned values as '%u'.
Also, parse and print the firmware version in its canonical format, as
suggested by Nick Dyer.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index fac3791..7a839d1 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -856,12 +856,12 @@ static int mxt_initialize(struct mxt_data *data)
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
