From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 16/18] Input: elan_i2c - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:27 +0200
Message-ID: <1443793229-22363-17-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Duson Lin <dusonlin@emc.com.tw>
List-Id: linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

drivers/input/mouse/elan_i2c_smbus.c:402:1-6: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/mouse/elan_i2c_smbus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index cb6aecbc1dc2..e5b0adfac3d0 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -399,11 +399,7 @@ static int elan_smbus_prepare_fw_update(struct i2c_client *client)
 		return error;
 
 	/* Reset IC */
-	error = elan_smbus_iap_reset(client);
-	if (error)
-		return error;
-
-	return 0;
+	return elan_smbus_iap_reset(client);
 }
 
 
-- 
2.4.3
