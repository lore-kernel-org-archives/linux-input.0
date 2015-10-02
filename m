From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 10/18] Input: intel-mid-touch - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:21 +0200
Message-ID: <1443793229-22363-11-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

drivers/input/touchscreen/intel-mid-touch.c:562:1-4: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/intel-mid-touch.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/intel-mid-touch.c b/drivers/input/touchscreen/intel-mid-touch.c
index b4f0725a1c3d..4c3ef2e47e3a 100644
--- a/drivers/input/touchscreen/intel-mid-touch.c
+++ b/drivers/input/touchscreen/intel-mid-touch.c
@@ -559,11 +559,7 @@ static int mrstouch_adc_init(struct mrstouch_dev *tsdev)
 	if (err)
 		return err;
 
-	err = intel_scu_ipc_update_register(PMIC_REG_MADCINT, rm, 0x03);
-	if (err)
-		return err;
-
-	return 0;
+	return intel_scu_ipc_update_register(PMIC_REG_MADCINT, rm, 0x03);
 }
 
 
-- 
2.4.3
