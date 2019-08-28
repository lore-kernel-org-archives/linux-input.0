From: "Johnny.Chuang" <johnny.chuang@emc.com.tw>
Subject: [PATCH] Input: elants_i2c - return real value of elants_i2c_initialize()
Date: Wed, 28 Aug 2019 10:33:46 +0800
Message-ID: <000601d55d49$05878160$10968420$@emc.com.tw>
References: <1566958886-25756-1-git-send-email-johnny.chuang@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566958886-25756-1-git-send-email-johnny.chuang@emc.com.tw>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, =?big5?B?U1RSRDItsviozsBN?= <johnny.chuang@emc.com.tw>, =?big5?B?U1RSRDItvbK0Zrxg?= <jennifer.tsai@emc.com.tw>
Cc: =?big5?B?U1RSRDIts6+xUqn6uGeyeg==?= <james.chen@emc.com.tw>, =?big5?B?J7Hns9W1vic=?= <paul.liang@emc.com.tw>, 'jeff' <jeff.chuang@emc.com.tw>
List-Id: linux-input@vger.kernel.org

The return value of elants_i2c_initialize() was always 0.
It maybe register input device when initialize fail.

Signed-off-by: Johnny Chuang <johnny.chuang@emc.com.tw>
---
 drivers/input/touchscreen/elants_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c
b/drivers/input/touchscreen/elants_i2c.c
index d4ad24e..9c9816f 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -571,7 +571,7 @@ static int elants_i2c_initialize(struct elants_data *ts)
 	if (error)
 		ts->iap_mode = ELAN_IAP_RECOVERY;
 
-	return 0;
+	return error;
 }
 
 /*
-- 
2.7.4
