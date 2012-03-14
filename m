From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 2/2] input: add driver support for MAX8997-haptic
Date: Wed, 14 Mar 2012 23:47:42 +0900
Message-ID: <4F60AF8E.7050900@samsung.com>
References: <4F5DB459.9090701@samsung.com>
 <20120314084652.GC3964@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20061 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab2CNOrk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Mar 2012 10:47:40 -0400
In-reply-to: <20120314084652.GC3964@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

Hi Dmitry,

> This is not proper locking between playing effect and suspend. Now that
> you are using workqueue you need to synchronize access with it, not with
> play_effect method.
> 
> Does the following patch work for you?
> 

Your patch is worked on TRATS board based on EXYNOS4210 but, you should
apply following patch because 'chip->enabled' is used on
max8997_haptic_configure() function to enable/disable haptic motor.

diff --git a/drivers/haptic/max8997_haptic.c
b/drivers/haptic/max8997_haptic.c
index 806bcf3..0347404 100644
--- a/drivers/haptic/max8997_haptic.c
+++ b/drivers/haptic/max8997_haptic.c
@@ -182,11 +182,11 @@ static void max8997_haptic_enable(struct
max8997_haptic *chip)
 	}

 	if (!chip->enabled) {
+		chip->enabled = true;
 		regulator_enable(chip->regulator);
 		max8997_haptic_configure(chip);
 		if (chip->mode == MAX8997_EXTERNAL_MODE)
 			pwm_enable(chip->pwm);
-		chip->enabled = true;
 	}

 out:
@@ -198,11 +198,11 @@ static void max8997_haptic_disable(struct
max8997_haptic *chip)
 	mutex_lock(&chip->mutex);

 	if (chip->enabled) {
+		chip->enabled = false;
 		max8997_haptic_configure(chip);
 		if (chip->mode == MAX8997_EXTERNAL_MODE)
 			pwm_disable(chip->pwm);
 		regulator_disable(chip->regulator);
-		chip->enabled = false;
 	}

 	mutex_unlock(&chip->mutex);
-- 
1.7.0.4

Thank you,
Chanwoo Choi
