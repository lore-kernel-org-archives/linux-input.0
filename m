From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 4/8] Input: mms114 - remove unused variable
Date: Mon, 29 Jan 2018 20:33:19 +0900
Message-ID: <20180129113323.18961-5-andi.shyti@samsung.com>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p3bb7bc89558e7219ef257b36fa47dc076@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180129113323.18961-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

'__packed' is not used anywhere, remove it.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index fb4435ae506b..11dba8bb48e3 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -78,7 +78,7 @@ struct mms114_touch {
 	u8 width;
 	u8 strength;
 	u8 reserved[2];
-} __packed;
+};
 
 static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *touch)
 {
-- 
2.15.1
