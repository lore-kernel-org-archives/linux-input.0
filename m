Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB43FFAAE
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306129; cv=none; b=WKABs/IixZMVN8HKh6cFQwNXX0B+te17owJA7shveRWjQigvHjnp9r1RaYqO38OONmg5Oc3xBIMsa64oMGPDqr9t6WebYcCsvYz84ROKhlKXIOPb5X6CXQOY7QUOCUgP4pdSeEk49N1vRlsXVvrJQ/d7MvdlsZamkwsRePK8cT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306129; c=relaxed/simple;
	bh=l59zQD9YqPAndUJbVtbTFeoUp1y5ZaOdah34Q1NYPxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU9qrWoIp8jMEGEtOlAZsJxcPMHF+/Eirjr+1ZtsyQk5Mcs8uMFVzuV6mwEWEtsrTLml6+ji7dNL8N8gfREdtA2/eCIzZNKgwlLDNnmI0NlXbV7W/HclZEvvIs3xQNHaWhtIyzl4vSR4MjDmcW0McW2oc9DKsYZro9iLsozOQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3RQEHp7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3RQEHp7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-827270d50d4so3298873b3a.3
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772306126; x=1772910926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFJRHzNwns07yr8sD7csxbfUGSI0WFETyr/H6xdIo98=;
        b=Z3RQEHp7ZfVTRl//AXHq/VYr5jTxAMelVeUxMGYx9LBUEmTtHrismg3JfqMq5znwce
         j0agAiFbUSN0pPh3/QAMMQbCW8tPq6oILilEHyAB4CtIEOmL79n9IGNB9eeJieUcfX2L
         ZZQGayD8pOlNSQ34FNsoaGhdRW4VY5ACDFAnAtdk/WD3bEjtKhi395IRRNiQy8+Lo8KT
         X5lywX6uv9zbvWve1k4dvQ1VkmLcKhhrK9ALHqkDbthKCNigpRioZ2wcSZ9l+zl+ZlB2
         wcsEg3n+cm9P/cWFcCZRcJXR8VZ8ZdNuxQh6iVFh5XHHBVrdJHNPuP8r+a5wsWf17I3z
         EcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772306126; x=1772910926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFJRHzNwns07yr8sD7csxbfUGSI0WFETyr/H6xdIo98=;
        b=tmtzk2WnqeNUKpgjDpu0POvYRb49VmFMOTW9jCVJ7xR67Pt+wXqONaSZlE8nTZQAXL
         bPYSCEJwJy3NAs5K5Ci8d/gZV/BeHe73RR2Ok+R+ROlqDPhq+a5mrUSZxogHS5/JMp9S
         AA7SW50Oh6SU49HVlkyhzlSl+EW0RIk2E1jw5BeSkfei7zMEtcRBM8RejMMvMQKkiGPN
         6XiGtOOqaiU/wWxjvEMii6MJ5icZlBe2MAvsWH93nrmaihA2zsLLZ9SA+fplhRrd7vnD
         o4KOVW45txYh0/nmcq8WbTqU8fyO8z/AOzevqz19D3FOeKSD9UCUB6a2u6ktjFLD/ntl
         87PQ==
X-Forwarded-Encrypted: i=1; AJvYcCViJJszjnxiuNjZUnHDSbU1dA1+hX+afyNKNZjT0kmabp0wb5GEXa6poevQm+d7vmBRvX4ynq5PVIjbLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgH4RCuZHXqDxFGHijgTC5DhIqoH84M67T/pCGtamom8GGXmjM
	4TP356IYv0ofNSKqL6Gxz6LA2xaDQ3afZO9KiDAXGLdMNKBKdLz5nKOI
X-Gm-Gg: ATEYQzzqEENzgd2LexA2e40ltljnSLNtMQYnjf7WbEJR96abjZQcBVxTI5H4PRcJ3PR
	Fev6rpGGjsjZmaP64TRAmCUdT+4FXW3NeHXptiDfB22RCxNr9lVfrIny9HD/rbt9G76zs5fN5UM
	Rgq/jyRqmWOu7rOJAjFWR+lWY89KF0WvQIvJF63NK4W7djUbANNsBJCYuBUhDt4hi1i9Q/5HQsw
	+3Tu/YueQHmVdCnOW+JBpn3QoxGdsOhQ2d6Q6m2k/pMZVfsG28gvVaqdPHNZUsaJw6QIvQXnJd9
	84rityO8EchJKaHuMMOUHwaPbn6frkzJFWjK3NF1evy0Hsj1SPYiV0/QX1YE2aRotY9sJsuW68p
	hIgKiCh05kE+MHMiycJoqMetnEGTLCRfJS50Nar39v0BFcfaxsU+nANEOOAnYN9/Szhc4YboS/I
	SFkmNDC39Ybcz9+EDI9FvduYrw
X-Received: by 2002:a05:6a00:32c7:b0:824:936a:46bb with SMTP id d2e1a72fcca58-8274d972d17mr6912554b3a.20.1772306126567;
        Sat, 28 Feb 2026 11:15:26 -0800 (PST)
Received: from arch ([2409:40c2:5057:a20e:20e0:a4e3:da85:ffd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm8327918b3a.8.2026.02.28.11.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:15:26 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH 1/2] iio: hid-sensor-gyro-3d: move iio_device_register() to end of probe()
Date: Sun,  1 Mar 2026 00:43:59 +0530
Message-ID: <20260228191400.19244-2-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228191400.19244-1-rougueprince47@gmail.com>
References: <20260228191400.19244-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, calling iio_device_register() before
sensor_hub_register_callback() may create a race condition where the
device is exposed to userspace before callbacks are wired.

Move iio_device_register() to the end of the probe() function to prevent
race condition.

Consequently, update the error handling path in probe() and in remove()
ensuring that iio_device_unregister() is called first to cut off
userspace access before the hardware callbacks are removed.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c43990c518f7..8e3628cd8529 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -333,12 +333,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
 	gyro_state->callbacks.pdev = pdev;
@@ -346,13 +340,19 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 					&gyro_state->callbacks);
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
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
 	return ret;
@@ -365,8 +365,8 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
 }
 
-- 
2.53.0

