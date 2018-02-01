From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 2/2] Input: mms114 - fix license module information
Date: Thu, 01 Feb 2018 17:23:20 +0900
Message-ID: <20180201082320.24031-3-andi.shyti@samsung.com>
References: <20180201082320.24031-1-andi.shyti@samsung.com>
        <CGME20180201082338epcas1p1b51e19d17ab9259cf18e031fb8e9f318@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180201082320.24031-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

The driver has been released with GNU Public License v2 as stated
in the header, but the module license information has been tagged
as "GPL" (GNU Public License v2 or later).

Fix the module license information so that it matches the one in
the header as "GPL v2".

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Reported-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index be7926555432..a5ab774da4cc 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -621,4 +621,4 @@ module_i2c_driver(mms114_driver);
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
 MODULE_DESCRIPTION("MELFAS mms114 Touchscreen driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1
