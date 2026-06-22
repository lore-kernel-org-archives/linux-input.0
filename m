Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E235B137
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106240; cv=none; b=L48MwpemkChd3TBzDtblN4HSIyyR7f5DHZcpU+LquOk0dh6FQMq2Fr48+whYhvvQH4ERp2sH63wB8Lm1dDDGah4ce7rEnX3kA/VUyNRvIL02fnsqhOKx85ci5I2TxicIpqqScH1ho8T/MY5INCHs66vQfH9Cf9qoSvRAyjUyyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106240; c=relaxed/simple;
	bh=bry/qy/huZgB5q2NICIwly/7N/mAm2guehNuSSyVzic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvBmN+Lkq0SJvjoVCmjzjCxk8MaZp/sIULsjTmoVdS5KflE1wLYIdfw/ZnXAF/JiYF6dkktCCzU05yFco5iOEcAq3nDhlNK1QshMlCk1HWWj8gAAT1oWpnBuGz1ZN2E/aD3U3fXPiw6yLUpfXtjCLzgsgtBoRKdMHvocqDYJYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJp9OGX9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJp9OGX9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so14766895ad.1
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 22:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106239; x=1782711039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3OxBcRPfrQUdQw9nRWbA+0f4GedPZWKH0C4Q4v6P3M=;
        b=NJp9OGX99Jo76g5HTuJ12UY/F78WBdqE5Z+gPIzQKZKnzF0m29WHjuROUmxoZZmi4U
         Mquu6XDHe98/H8FajZ/KdKlC+N4DXQaODvrmoI+adKI2jzAH9Clv8kZacUWXX76rudy2
         qkszMDTu+ymiaBL6St1OxXCRpw8amk3oW7/SeLQFE3PvmcmEzEFnKCLgrIfryLWLeHll
         cYULTiIAIgT0c6KA1D1bK1n3WDevsWvICl7XuWysctzGLAAJSZxAGywY0CU8H0lcFyia
         Jpv6AeYFeVMDCBls8+j+heQrc5pa07zcqJUAwhdoB8+CN/RVk5gJMleL7XpudJ/ccNnU
         22pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106239; x=1782711039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j3OxBcRPfrQUdQw9nRWbA+0f4GedPZWKH0C4Q4v6P3M=;
        b=Fp8JxeA+qR1+2Pji2DBh/tw+qO8x5956wvRrba7YrEK0yeQif8dVr6jx45YNRUFDBd
         0H9duQuMAyrbd2PcOuY5g/3NlvBVjRKYzQLig1iRV3SL8p7aPBCq6LnalLxOLtNk+17N
         JGfcHOEvVMHGRy/Sw+eOyX4qMzTok83wZ3TDMedFETBira8prun3XucZqbF9ubsJcq7D
         KO1gwXfnNB3dvU4IhIKZwd/S5sIZx0qAqNOylrrdSFtBEadoHaPmrXZRyReKsuERaprP
         1d8zma+nCPpk76Xz30Bdow36g/mpy1U2nUKU7IwNXXKGIWAfhazJ4kP4xc9BSQvjckrP
         TPbA==
X-Gm-Message-State: AOJu0YycRvD9N6YtEz1SHfVW5BsniuTB4NWIFmwK7f+UxhF7Unsoj32Q
	j2uxjHYm18d50eGhivdpVneMIN6vzGgEw/DA6Dj2dxec1m/4etccsQdMoyaKNQ==
X-Gm-Gg: AfdE7ck5XYXV0cZNw+PL5rWmyaYxg6oUuyNKcbp/Wkj89qCQ5rp2Oiy5nxAoa6cH7XN
	MPEHWcjNb1G5pO+edP3pSnu0hRxQTgz5NFfdvsrfk597o6Teq2a/NXNKaamHlb2ceDnd/1jr7+T
	Bqnj4ZiCldy1eifeQWSqPuNU0RziaIzmFPgeLZaYGTtfGDIVj+JMI5KEEIOzdBw84urBdIDtrTz
	cFGYMDHtyElbloV708xg270rbdgJIsoaKjluhuVEpHltjJZLfhRBbkObGk6OBe+wS8+TExqJI7l
	ziIkQh2SwmE1Fy4OjtfGHPwgyK5yLTehB1OO2IT50gq0jMjo60BpLGmXRZDHihsR9rlgUnV36CW
	r3qrCZLME9OriBju7SsrW9m6gSpOJImdkFL/C1eZbAsYtyg0hTs7GaCk8vYMiXBYqwKHNAFL1mr
	2ksSOrVeKm7o1nvVx5vXwh8+ceQ3gMR7n1W9UEsw==
X-Received: by 2002:a17:903:2c47:b0:2bf:128d:f7ff with SMTP id d9443c01a7336-2c7426f1797mr96126445ad.16.1782106238887;
        Sun, 21 Jun 2026 22:30:38 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:38 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:01 +0530
Subject: [PATCH v2 5/8] iio: light: hid-sensor-prox: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-5-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Archana Patni <archana.patni@linux.intel.com>, 
 Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The driver currently exposes the IIO device to userspace before
completing sensor hub callback registration, and similarly removes
callbacks while the device can still be accessed during teardown.

This creates a timing window where userspace may enable the buffer
before callbacks are available. In such cases:
- samples can be dropped,
- buffered reads may observe stale or no data.

Reorder probe and remove paths to ensure callbacks are active before
device exposure and are removed after device is no longer accessible.

This avoids a race window leading to data loss.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 9059f00f0ced..11609dc4c5dc 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -312,12 +312,6 @@ static int hid_prox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	prox_state->callbacks.send_event = prox_proc_event;
 	prox_state->callbacks.capture_sample = prox_capture_sample;
 	prox_state->callbacks.pdev = pdev;
@@ -325,13 +319,19 @@ static int hid_prox_probe(struct platform_device *pdev)
 					   &prox_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		goto error_iio_unreg;
+		goto error_remove_trigger;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device register failed\n");
+		goto error_remove_callback;
 	}
 
 	return ret;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
 	return ret;
@@ -344,8 +344,8 @@ static void hid_prox_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct prox_state *prox_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
 }
 

-- 
2.34.1

