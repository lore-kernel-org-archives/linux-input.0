From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 6/8] Input: mms114 - Use BIT() macro instead of explicit
 shifting
Date: Mon, 29 Jan 2018 20:33:21 +0900
Message-ID: <20180129113323.18961-7-andi.shyti@samsung.com>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p130b8bf772fc3124c0a76a0938bcacecc@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180129113323.18961-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index fdf23bc416af..d70c03adf148 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -21,7 +21,7 @@
 /* Write only registers */
 #define MMS114_MODE_CONTROL		0x01
 #define MMS114_OPERATION_MODE_MASK	0xe
-#define MMS114_ACTIVE			(1 << 1)
+#define MMS114_ACTIVE			BIT(1)
 
 #define MMS114_XY_RESOLUTION_H		0x02
 #define MMS114_X_RESOLUTION		0x03
-- 
2.15.1
