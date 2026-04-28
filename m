Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39883D3D09
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360610; cv=none; b=L5ZaW8/3xa7z0dPauUWsAA4cAv5wkl40qIUWhEomwY/+VwEReSuzZvrRl8yZb3i9yiVVmE7m2popy1lDgYDje6l50S6fgKP4SwIVPXNwWJH86d/8sLCSN6hno4laoRxskA53jI70bhydN13kJQ2jRGsAnpjZsCoWOaK3sFDW+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360610; c=relaxed/simple;
	bh=dSkKJ7Howa8/r4sWuIZt5n9X5Q8SwwWpZB/z0c/7jDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3G465Tn6GCB7MDluZMzF/Ar1uOplPK0JW+QhTQFeDH40RHqGHgNc8XkWWhQnMT6r41c9KRUTowEsMDKN+zO8tKiC+VbWKAB4XxhU1HBpHkcN+GZjXyDzqldL7biXX9C18L+1LwITnYk6CXthlTj7ZQv//xCeMvt2x7QNJ02Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pP7BkeJ+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP7BkeJ+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-834da62e52dso335585b3a.3
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360608; x=1777965408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7mkX+e8bgIQ85sCXfa5nrQnLaf7XTdt8ByhqMB6hCw=;
        b=pP7BkeJ+ajK/LdDoi1VVXAhOtRKBqee/gf9FcJ0MSNEAl/QzrK8HxemRZNbx0IPHgU
         OzyXooy5/FZMt3fRqvEhgrR+UscQOWENZv4nmvkO+g3Ota+6PSuUf3C8kXC3knxtzNQr
         3FrNHcv9/x/wwOygkNf1OBQaSsXy6vRCxo6LJNwmmgZPCUvSG+jNAroLQ12CmBWew8UT
         PJ185C4SGmOiExHsIDTKnQVFpncH2D2zk19N2anBpHMtOfZFhY0fdxtVAb+WZWbfxZI/
         bd2Zmuj057Wv6xzSOkdMzrWDgV3kS/Po4HsVCVqlV+uN6hvhbqTEA7rQqdYwjlqT4aR/
         TvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360608; x=1777965408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7mkX+e8bgIQ85sCXfa5nrQnLaf7XTdt8ByhqMB6hCw=;
        b=p4IKoyj0gNx4NR9H3jjMcw/YT3tI+qCnAzS0KW7u9daIoM8pJ+4Ne/asyZB+3H/qI7
         Ayqp49SGeQDV7UBtS/wqnlxcslm7vPqDeEqW07JnvcygDD3pDvbpB7x7Ci4DfPEbufek
         FbstDsyOkSNpK0b3GKwyb4oUxFoNWl1qr+gpMp4EQL99FaD0ziK+0VKFy0L4NhZof+O+
         EJI3ZvKrIdIhap0sA9pg52YjqogbjUHKSeDwCU2TNMoNMOooRE/XnRvlr9AlqG1XwpPh
         NqeZjCfo4UPtrwL+uat6amNtO6X1pdbBS4Yr5rgjcjkjdmGkKBx1yaTZEa5SivmQnJTF
         xu3A==
X-Forwarded-Encrypted: i=1; AFNElJ9wY0pQh9GV95gaCSNJ/szecNCIu8+ZvDhA2cC6UIJ3fCmF94GsVYIswcxnDxJjLQJmyqsstHYWvB2qCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZelXa4V3tcyVii8zXzPQHPwLzdiQ3pH1r9RY0EuVaR40mzkRP
	5eQH8LuXOBUe39oc1lqYhHo306zK0F7skExdlAfQEnslJopZZFTf6MQ0
X-Gm-Gg: AeBDietKVcwf54vTRVeNgsm1W0t19i2MnPlLVUttUrGtQ1N/xubvMBPM+Tt7oVBHP0/
	iaTPSf85sUhMrTSH4zwvq9WycSLauerxmaqOSqpB7moeAJ0fUQTDf6W6zhpclEckBJoCQ5H5Lo0
	tGrep2acLl6jNneSj6ed2JbIqpR0D8svVrjcuLdk3dSaGsz0MnxTUOm3F4wVrnP7EYpIlDVSJYE
	QjFRpBbAXgPphLgIiE6xN0KMcshB1XL2kC+3FcUfwPn10rJnxAQQk1chMbuxpu8o5zqVR0wscR/
	PIt3rpuU4zixdVxdL+exGVSv8c8CwDuyPNnnFV2J+3SEyrp66co0MzylXr6gjVT4ktQdmZHCrPT
	EA53jCpiDK7+gTmwHGCXXXJIFB2v49QzhfVq43CIGEoZkcYUS8KFx4Zi9AFOugq6zu1XwjTzY0w
	P9gEOPRYYtzsLopJ3bYQdaRDPVJtKtj1UViKENzfRNYd/yvOfqPqmCC8qiBw8=
X-Received: by 2002:aa7:88d0:0:b0:82a:ea3:c172 with SMTP id d2e1a72fcca58-834ddc0c4bfmr1981054b3a.46.1777360608302;
        Tue, 28 Apr 2026 00:16:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:47 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] iio: light: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:10 +0530
Message-Id: <20260428071613.1134053-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c  | 4 ++--
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..9b57cdced18a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -432,7 +432,7 @@ static int hid_als_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 	return ret;
 }
 
@@ -445,7 +445,7 @@ static void hid_als_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 }
 
 static const struct platform_device_id hid_als_ids[] = {
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..473c45626487 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -340,7 +340,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
+	hid_sensor_remove_trigger(&prox_state->common_attributes);
 	return ret;
 }
 
@@ -353,7 +353,7 @@ static void hid_prox_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
+	hid_sensor_remove_trigger(&prox_state->common_attributes);
 }
 
 static const struct platform_device_id hid_prox_ids[] = {
-- 
2.34.1

