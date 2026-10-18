Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F53F328D
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792303936; cv=none; b=I9gqyacudRWeVxL8Lzs8aJwgHdl5PeL+0AECX35MqlKKmAbrO6dL1jQJJ9/YyyCplqqL/nTmGs8cWckZ6F9hsChguRivCd2mcNfTANrhMUoS7C1mSEGczVWDbqh1vXDKouEvecKJpNppcuwhKvZImzztGjvQMOjXqdTXIzwzQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792303936; c=relaxed/simple;
	bh=WbMfdK/eyZJynE1W/XkPmTttiyGMyXB1NhVqTfoICG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JnknzX+NQwv5q8N3alMNLxMQBCltVr+6tYu+h3nLEAwYrb/+JeJIGBxTIeNi5O2awsxyCy9BTjcl6SmbPzTKFS9rvg+Ao+bzDAVsDs1xTea7UyRKku8Hz6Jj04Zi6hJuTsZz/XAcEepBAg/2HZU+FV/74c8mTSieH+WKViB0kZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5SSu68H; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5SSu68H"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so2221897eec.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 23:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792303934; x=1792908734; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNEBAbWY/CxdBni1bXmXRsfCsUtcrtBZszExfd59OMk=;
        b=T5SSu68HKT+8WxmMFITdF7S59LrLtc+BU4LGG+EFKMZ0t75hcRwYMu5e4Oy481sZdN
         52S/swBruKKvWwOSOhsDBFG/j0qohph0ZGBDPymr46fWBs496PQp6TeczJcRdAnZGgha
         BXGjBXHelh7BjMiKEfYetll+MrHw8sEsE+xeoj8r8zdxZZtVBo+avirIR5rUgNKXL8rt
         VpRWmKDMhUTqx8AWxHbLiyqUHlHjWEs+eeivbFA6B6uSbrHdEY4HIqmQq/b4B+ePyFoI
         iZk60Zmjfpo/jaL7soYYgjvIhHScqXpXlhJfTGqWwJge8FwcsxIRW+CA9BVejumg+BOx
         lzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792303934; x=1792908734;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNEBAbWY/CxdBni1bXmXRsfCsUtcrtBZszExfd59OMk=;
        b=sJ7LBByIqT9NACayDFhUR0mOhsEg2EycbNi9HlBNIj9aom4lPNjqOMM6PWdp5ckfSC
         N0wfNz4XGJfLGgvppi28e0TNrjhnOgPPpgKwiWFtSYb7y+bEA0JbM/0l4ovNO1bz4aRT
         hF/jVo2XhUephVvya7hJs6u7jWqxoiO3dC6Of5mLGkkRkmf99ILlT62Wbf+KmxhTpBDL
         Tx49kEFwRarXPhEhXzLwjnSzYQU7/JLRaTNPxw5AJdgUIRPRukC2Z0UwUAQUW6FzkzYd
         wX0Gpc+N0+GefXeuLAY6AQsJ428uf5WaL21iArZ0z+hfgddDhjkEF7cp+oqqbF9fFDqM
         EYIg==
X-Forwarded-Encrypted: i=1; AKwUvBwoHcpKd2EJmayyjWnuIM0XWTch4T2rTV7tyC3+yo4DAJ59z2a2vCTEQP4oxc9FNcuNuuWFWEgpiCuVGw==@vger.kernel.org
X-Gm-Message-State: AFq9FYICDRDg/f9BoA238IqbDjWnfS8MWw+WtCrst0OQxU92OewWq50z
	BNgN5Fj0WCUVAQk0oHKdxtx8Mjq4s1STSVDQC5XbyPzr/dEXsrwVyW845qOXxA==
X-Gm-Gg: AYBFou0Hl4WST/62Y5s+R7kBbQXp2Kw3c3WwcbkRETZ/p0E4UpLQCEMz1Ld/fze5q4L
	caUxKL5vZKHDxoQRMB4p82Wk+ELUUt5g4Man1zSs6YYo6c8wKoG17Bd4vSErFeRiVzaJqwqJtGG
	5iyeCQynaf9oA44G+mqnF6iC5hlL1fd0VvysI6ICIyTS8VKvrm73zkv1EWUsms7MorQzdlxQesp
	s9nywsn09Qna1GMLX8+0zeh36rcHelmsoY/dbnmAaL2c122oYLo85D9ATKMmKSyEir3G+i5iPun
	1lHnMvsIsfzD4ms44epC9vtPhbVPGwG50yMTYgbdrly2dSGXQOuAAqoupX9yNH9KiRjXeAUJJEY
	LUkERRFyaavhAPzmTpiWP5VJQHgVVH+pP/AQU4Th1+4Q3IMsQsOayiEFT5GrriiikepJe+g/6Mk
	z6OfsNFcOmEE18SBssfvavxZOS4iU2xEprOxhLkOS/TyEtpbQipaOsz05rRNwS+FJRqbSlWxD8F
	TdCotbd8Oapb/DbC0sWY4TGgyuLXTxs2MjkgsbbdhWLQ7SIpw==
X-Received: by 2002:a05:7301:470e:b0:358:8bd2:fda1 with SMTP id 5a478bee46e88-361a2649752mr6073652eec.30.1792303934037;
        Sat, 17 Oct 2026 23:12:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:297c:6f48:9e5:4e5b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b684dsm20989445eec.10.2026.10.17.23.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:12:13 -0700 (PDT)
Date: Sat, 17 Oct 2026 23:12:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: da9055_onkey - switch to using managed resources
Message-ID: <atRjCWI0PXs840rl@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Switch the driver to use devm_input_allocate_device(),
devm_delayed_work_autocancel(), and devm_request_threaded_irq() to
simplify error handling in probe and drop the remove() callback (which
also had a leftover broken regmap_irq_get_virq() call on an already
mapped virtual IRQ). Also use input_set_capability() to advertise
KEY_POWER support and drop unneeded error messages.

Reported-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/da9055_onkey.c | 59 ++++++++-----------------------
 1 file changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index 3e4fc2f01011..25845106b920 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -7,6 +7,7 @@
  * Author: David Dajun Chen <dchen@diasemi.com>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -45,7 +46,6 @@ static void da9055_onkey_query(struct da9055_onkey *onkey)
 	 */
 	if (key_stat)
 		schedule_delayed_work(&onkey->work, msecs_to_jiffies(10));
-
 }
 
 static void da9055_onkey_work(struct work_struct *work)
@@ -80,72 +80,43 @@ static int da9055_onkey_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
-	if (!onkey) {
-		dev_err(&pdev->dev, "Failed to allocate memory\n");
+	if (!onkey)
 		return -ENOMEM;
-	}
 
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		dev_err(&pdev->dev, "Failed to allocate memory\n");
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev)
 		return -ENOMEM;
-	}
 
 	onkey->input = input_dev;
 	onkey->da9055 = da9055;
 	input_dev->name = "da9055-onkey";
 	input_dev->phys = "da9055-onkey/input0";
-	input_dev->dev.parent = &pdev->dev;
 
-	input_dev->evbit[0] = BIT_MASK(EV_KEY);
-	__set_bit(KEY_POWER, input_dev->keybit);
+	input_set_capability(input_dev, EV_KEY, KEY_POWER);
 
-	INIT_DELAYED_WORK(&onkey->work, da9055_onkey_work);
+	err = devm_delayed_work_autocancel(&pdev->dev, &onkey->work,
+					   da9055_onkey_work);
+	if (err)
+		return err;
 
-	err = request_threaded_irq(irq, NULL, da9055_onkey_irq,
-				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-				   "ONKEY", onkey);
-	if (err < 0) {
-		dev_err(&pdev->dev,
-			"Failed to register ONKEY IRQ %d, error = %d\n",
-			irq, err);
-		goto err_free_input;
-	}
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, da9055_onkey_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"ONKEY", onkey);
+	if (err)
+		return err;
 
 	err = input_register_device(input_dev);
 	if (err) {
 		dev_err(&pdev->dev, "Unable to register input device, %d\n",
 			err);
-		goto err_free_irq;
+		return err;
 	}
 
-	platform_set_drvdata(pdev, onkey);
-
 	return 0;
-
-err_free_irq:
-	free_irq(irq, onkey);
-	cancel_delayed_work_sync(&onkey->work);
-err_free_input:
-	input_free_device(input_dev);
-
-	return err;
-}
-
-static void da9055_onkey_remove(struct platform_device *pdev)
-{
-	struct da9055_onkey *onkey = platform_get_drvdata(pdev);
-	int irq = platform_get_irq_byname(pdev, "ONKEY");
-
-	irq = regmap_irq_get_virq(onkey->da9055->irq_data, irq);
-	free_irq(irq, onkey);
-	cancel_delayed_work_sync(&onkey->work);
-	input_unregister_device(onkey->input);
 }
 
 static struct platform_driver da9055_onkey_driver = {
 	.probe	= da9055_onkey_probe,
-	.remove	= da9055_onkey_remove,
 	.driver	= {
 		.name	= "da9055-onkey",
 	},
-- 
2.56.0.176.g3575e65682-goog


-- 
Dmitry
