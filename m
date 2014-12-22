From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] Input: regulator-haptic: Make regulator_haptic_set_voltage
 call regulator_haptic_toggle
Date: Mon, 22 Dec 2014 12:47:40 +0800
Message-ID: <1419223660.22487.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:50712 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbaLVErp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Dec 2014 23:47:45 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so5148518pab.18
        for <linux-input@vger.kernel.org>; Sun, 21 Dec 2014 20:47:44 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pankaj Dubey <pankaj.dubey@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hyunhee Kim <hyunhee.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-input@vger.kernel.org

All the use cases in this driver has a regulator_haptic_toggle() call after
regulator_haptic_set_voltage(). So make regulator_haptic_set_voltage() call
regulator_haptic_toggle() to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/input/misc/regulator-haptic.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index 9426221..5b18de3 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -76,6 +76,8 @@ static int regulator_haptic_set_voltage(struct regulator_haptic *haptic,
 		return error;
 	}
 
+	regulator_haptic_toggle(haptic, !!magnitude);
+
 	return 0;
 }
 
@@ -84,7 +86,6 @@ static void regulator_haptic_work(struct work_struct *work)
 	struct regulator_haptic *haptic = container_of(work,
 					struct regulator_haptic, work);
 	unsigned int magnitude;
-	int error;
 
 	mutex_lock(&haptic->mutex);
 
@@ -93,12 +94,7 @@ static void regulator_haptic_work(struct work_struct *work)
 
 	magnitude = ACCESS_ONCE(haptic->magnitude);
 
-	error = regulator_haptic_set_voltage(haptic, magnitude);
-	if (error)
-		goto out;
-
-	regulator_haptic_toggle(haptic, magnitude != 0);
-
+	regulator_haptic_set_voltage(haptic, magnitude);
 out:
 	mutex_unlock(&haptic->mutex);
 }
@@ -123,7 +119,6 @@ static void regulator_haptic_close(struct input_dev *input)
 
 	cancel_work_sync(&haptic->work);
 	regulator_haptic_set_voltage(haptic, 0);
-	regulator_haptic_toggle(haptic, false);
 }
 
 static int __maybe_unused
@@ -225,7 +220,6 @@ static int __maybe_unused regulator_haptic_suspend(struct device *dev)
 		return error;
 
 	regulator_haptic_set_voltage(haptic, 0);
-	regulator_haptic_toggle(haptic, false);
 
 	haptic->suspended = true;
 
@@ -245,10 +239,8 @@ static int __maybe_unused regulator_haptic_resume(struct device *dev)
 	haptic->suspended = false;
 
 	magnitude = ACCESS_ONCE(haptic->magnitude);
-	if (magnitude) {
+	if (magnitude)
 		regulator_haptic_set_voltage(haptic, magnitude);
-		regulator_haptic_toggle(haptic, true);
-	}
 
 	mutex_unlock(&haptic->mutex);
 
-- 
1.9.1



