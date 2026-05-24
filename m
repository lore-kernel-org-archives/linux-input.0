Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4E309EE9
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650991; cv=none; b=hyVQkbz+5ojAOz9wNsG8vF+wciZYXi64YBhXm75XIRYwWAqDWX8Pu6NPKlvbzMtGiutDSWJBWsTPNqOsZ8Hrh3/8e0evZmE9nRqN16ZoLKOFc6vUghqfc4wig6ZZkwrLn4044GSRgHDJdYeRx2kWpLrCJIEuWzlRL0YEwd0Milk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650991; c=relaxed/simple;
	bh=nkBMU3oUCIG+gkk+3uSa8iE8bBpxriUGIogtHgv6Kzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aH2x0EW2fsAlrCUdA58gW1E0HbPm8Ed7X/JKPAdXI0CVWRiIo8OAjH68wlHAG8V7GL4cu6E17Xe2Gzf21rvtbRdxaLSpsClMjya2dOuuEiwt0GIiZ7YW9KClwo4KKDDYkkz8dgz+FTRzIJAnZ+lCZQAb7Wh0dl2NKvsIgF8GZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InEM13Fw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InEM13Fw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b941cd869cso57231395ad.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650990; x=1780255790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=colMMYIBzsVvLitSa7NIWevX9bHxswKzhO4ixCpeLK8=;
        b=InEM13FwZkAkKx/CnX/IIMQorJzRoG5WFjVZfmsZQEO3iwBY0oAxPrU7cAkiX5xLLs
         D3TsZbcaV9hZqmKLy48eSxXWL7Y7cxQPreyL7YCzWxSHhfte6SoGwIOF/Y6+EKIiPHvz
         OD3VpbdecBieSOEp++rJlbPpMewlHMWjZAll76v0uKMyrOKsmBHlLpJQGtIE1k8AYbPw
         s3zGo43vWN622RgZOsD5w6YqKhRKNnyj9uXgNoqrJQrVHLZSVcDsh2cKMOOMT8YL46km
         +Hn8+OhEx5aKqQh1cuTSaWfmP6NgUlZGtwz6sGumRMuzPCSFm+OztpICJuQtjbwx9t9S
         bEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650990; x=1780255790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=colMMYIBzsVvLitSa7NIWevX9bHxswKzhO4ixCpeLK8=;
        b=RlDXldx/9rEEWFAUQJSIEPIEsMzBHAgPbjMCyPuTyQe8q5UTlA6LE9+1gk9h8bs+0e
         CLTn/d3NPLdvycHuBKOPA1cCaFgxJLMn4MyqPLyibx0/KNUkqLlW9GbLe7GovbuYMeId
         7p1COzs1v6l7Os2VsUruSudnu7Mzi/JG+lcXuQEHZYCDgklMkyfVUSUWZd9aM0ZyZ6x/
         Z3cvXO29xLG3NFdL2YCF/Lby5fLkFsd6NV2NKh7mStgZZfCUhF3aqUZdD/Ya5llBWSYW
         +QtdIddSuhTuN5UcMrkXVXOBSmQYsBdl17StK13ugJ62sPD7XeN10PO39MdWFcWfnVpO
         wocw==
X-Forwarded-Encrypted: i=1; AFNElJ/ilq8GjVR36pv2y3CLuGrlofen96tDg+Yu1ooiL63Bl9kESZ9f+g9UcyIUlDFbHToG3+hZm+hLqwMFjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzINJXCEQxQByjaRerErotOnLWHMwIesv0q+pf/RW8dQ/NeYFZr
	r0eIiQJao0Djk5I51YybKruf/48hLubMowI3S+++l8c4O8yuNqHb6gTF
X-Gm-Gg: Acq92OEnfsCGrvWJQ8G9DNS5vFWgbqIbY1OwldQ71dluGdu/rAUwiRqVjP3vql4pg5R
	zPVAYq+fZoPL37t0BCXwGpriO5Enyd1wLr16vdDDQAn9bKjX5FPyPAkoIWIE4gOfalL0sm6uJuI
	qeOp+nDr1u4o5183e5ivvV9UZs3pfVlF5IyYJEavbZXWcY6Y2AkxeOF/ZQpgBF59WpDavJ6Wyh9
	cFiXb4XdEkhSwASUqFEEn/3hHTqnBWqCXZsJQpXN44Wo+gi0DZ8P7Fn5+UNzTk+gnMoPiONyKIg
	8qtqxkg8X4y+Us8d6hGDZFR+IMdmw3kfx5hCoUGVGzdq8UlvUbA4QeHNGtVNErZaRXTcqB2kxxf
	DK4wlZD/Exn17wDe2xz9n0+xRjuWsWsXlprMwieffJ1+DVHvW3QIiFxB/5gfePGEH4KLVfuCMMN
	/dFt/J1CCMYSg+P8MoG5uHdzq4zYVd0KDqG8ZIju3oRbPLCcZOEw8/wZB3hYg=
X-Received: by 2002:a17:903:1ac5:b0:2b2:4fe3:7b89 with SMTP id d9443c01a7336-2beb070c102mr126832325ad.38.1779650990145;
        Sun, 24 May 2026 12:29:50 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:29:49 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 30/36] iio: light: hid-sensor-als: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:37 +0530
Message-Id: <20260524192943.1196773-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 0af235d30800..2e9ed860c556 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -406,8 +406,8 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	atomic_set(&als_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&als_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &als_state->common_attributes);
 	if (ret < 0) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -416,7 +416,7 @@ static int hid_als_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	als_state->callbacks.send_event = als_proc_event;
@@ -432,8 +432,6 @@ static int hid_als_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&als_state->common_attributes);
 	return ret;
 }
 
@@ -442,11 +440,9 @@ static void hid_als_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct als_state *als_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&als_state->common_attributes);
 }
 
 static const struct platform_device_id hid_als_ids[] = {
-- 
2.34.1

