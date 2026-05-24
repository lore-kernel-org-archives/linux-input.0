Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD431717D
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651001; cv=none; b=Wv+YGfXS8jN/yTG4PN5FxwRPQEsPy8ct/jzbhVrHEgYlvkUtuL2el2F6DD0Nb0XifAD8gFNxREyNgdkjKIpFzH5gvgYYyiIGj7fsFLv0Il7Q2IcBsg3xg8nTUIIwTJRqyoEJZXh37DUeoPxsHZRNR18PdFBL3xMXRyzXeBdzNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651001; c=relaxed/simple;
	bh=pQ1EFI9ESAITUd9lLEvf9rZSrin8cseneVJ1umhYv5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ws/XsxX8fLjDeplkRNbPcIY9H97gMtIMW9ZjTVl+a0wzhu8B0zGIE1rOj8Nj29TOjjHOBfcXxXhH/zB/ieSzVzM/NL/4Ypx28oWF1h8RpmlG5U9wvzjVurTEXQ3EkMov8LcZD761Mg9D9PzLAFcXdDTH0xKOOdVKor2l99mYKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk++VWne; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk++VWne"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b4650d5f5cso36714735ad.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650999; x=1780255799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN4KSgEdZHf7ZNFG2UIquoLWy1GgHCXl9gVEesFCl1s=;
        b=gk++VWnej7oDqYxm+oghLuz1QBo40AV0qYbksibsoEAsPiQ0pa7fsT6zLp79kxmzRx
         501LU6A/GDFUx5o4bA1i7ZGb+bIyCsEiFLb378SncCqENy4DXt2Txg+SetEuF6fTO6h2
         qOeXqtzO3+chCqmp+bqDkViGtvsOsgS3Zzi5IRwR/6whB4RKuu1QVsRJriJtXLTP6dF9
         g+7B1T8wpA5ejyo9LLkNLa6k2PybULhfjFe9T6ugpC0exb4R75qPoZyrMafWTOdRm0yF
         EI9oBDsqijH2Yr5jGpvUufU7Ig4qd9RRWr5V7KpDVpKu9eAwND4VadPVUwcYEi+a6k/r
         Pz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650999; x=1780255799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cN4KSgEdZHf7ZNFG2UIquoLWy1GgHCXl9gVEesFCl1s=;
        b=mD+eKk2p9TIzhje0lAqIwFBorE1oXb2uqhkiSKHcXouIKMHDzsdoT/duQR2sIcFKAX
         b1xR3bgZSxzYEVHTmCe/HrvD57G4ZG15SIqtpXi3EPnnIQcevRt9Ujtw7kKLAGTva1gi
         zTI0pFPpNTFXZX2qUWpgRfVG38U9Pqqb8yXY6vbhagXCByNt0T6GuDt1iFBlT4X/4sxB
         cbDfs4OsuDL4aZ7Iy/J+gnw7CIAf3pDyy7foa87y/NmglTg7G7g4dEymLAHadJaJM1ge
         URPC/5K9Nkyrt6oa7b0FqKWPj4rgOr34rYDJELBP9tQgCiIkq+T4aaYMo0fSccYmU884
         t66g==
X-Forwarded-Encrypted: i=1; AFNElJ9S9Q0p4+vNNm3HWKDxAtiOhagP8S/1eIX7oXLNLyaQ42912TOnICkB1C6FKNfnQ8sDrWS8b5soozJUtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIaVNSSbbOIOtOK4oQsd0ppKeUecA3zap9Qx3Kt7Ddee5+9tI
	30lFYKDLFsKVsESUOK1n3NrNgtV59FJjJ2Ch3Rh1UZmJU3PunxRPAXXw
X-Gm-Gg: Acq92OFdr9wOBuOEZPYJiQ8qXpPLRA/x4qSqcu6194H/V/HecGWv0ReZH36DKzUMJh6
	v6utW2NNplEWD3T6QHyH0vKh9Xl88TBslqVOp+eCiQriSR284qtH1VdgH7CtIo2I1UB/r+XiwND
	bMjjepcEbprarQ0R5Q2bsNnokHHonemuazQaffHq2mIQTKYR+3WM1eXzGM7NkOtxJ/70tsrSr/E
	AGIPDN4N4i5/Tgy2iaWRT9MlH+FmHyjunpuFcdwcpOhMbFOWSOtyBUg8Mb5A1rURFAqhT9BmyJ2
	cWw8BA0xw7ea9r+EE/axIMuo1EXvCFCZpNrkS6uWJkUDgLjoH69k/BpwMv8h2qkoaFYDBdAgz+g
	c0RDIvYO05SJucSImvCnMpgmVUOVYebEBooyt0Q/13cq6iMjiKCtgRJcLqWasgqbYXyg7x2GE16
	6JxTry0RZN6RqeMvotszMuIqvtmFt3IxMuB2ADXFiHY2XdR+yc
X-Received: by 2002:a17:903:1a70:b0:2bc:d1ec:9f09 with SMTP id d9443c01a7336-2beb06be3d4mr123690205ad.40.1779650998794;
        Sun, 24 May 2026 12:29:58 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:29:58 -0700 (PDT)
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
Subject: [PATCH v4 32/36] iio: orientation: hid-sensor-incl-3d: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:39 +0530
Message-Id: <20260524192943.1196773-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192943.1196773-1-sanjayembedded@gmail.com>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
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
 drivers/iio/orientation/hid-sensor-incl-3d.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 21a32f506046..55d3e8d83f6b 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -349,8 +349,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&incl_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&incl_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &incl_state->common_attributes);
 	if (ret) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -359,7 +359,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	incl_state->callbacks.send_event = incl_3d_proc_event;
@@ -377,8 +377,6 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&incl_state->common_attributes);
 	return ret;
 }
 
@@ -387,11 +385,9 @@ static void hid_incl_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct incl_3d_state *incl_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&incl_state->common_attributes);
 }
 
 static const struct platform_device_id hid_incl_3d_ids[] = {
-- 
2.34.1

