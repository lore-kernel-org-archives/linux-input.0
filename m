Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179273148B4
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650996; cv=none; b=fOQri9t59fsRVCyfKwVygyELn3H2Wi7CA8OiR5QSfltlwU000/JSQIsio50eOIAktJMTLL2qCfLfsbaQQPq3PyX6uZF+aaQaw921u1Zirfk9+h8v5J9lZcoVXp4dYfAV2yEsPmAksZk9gh2na4ea4Trx7KvR2t8/hJFyUaK0q7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650996; c=relaxed/simple;
	bh=8aonlBzK6La32zoQta17/FxpJmctPYAGec2/N5xnkqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hv86aSCaaAoZkcQIe6mgKKcJQv6EpvIEhckTVGHAEor3XCHebmoa1Rhya1c/3guZ00NtdLJUZUtSWThUjSjB3xMF8vuEq7KmzP4rwVywTgs8eC29cIHu9kXdQjsAhy0htJI0J4BJDwbW0uWPYw8Xp977TcJjehKHTUnG2jKgOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCpnWarh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCpnWarh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba6485d219so68279605ad.3
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650994; x=1780255794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FkDvC/ErgcT2CVjGwqZhVxkScGNhYlOoSdsG0KrLjc=;
        b=lCpnWarhF6oXxixfUCy52LRXLqNlU8biw12HMHjCBHfB+0MlrItYAi4htcfxSRKyS+
         Ozb7AxL8i1LAJem/4SclzZx0TQIxcduyRMp8liZ9saLxQf9I6xWl+u15iK42TC0JEieG
         AoHm85swwvbMCtVjfaqrp1IQTd7vpUGQCT3c0g5RX8GbYpTo5wpkRIKGyGdYjDPFIFyk
         fLaUZ6qeIIWLXOG+x8LAH7VMX0YICzOFNnwd87WRkUfpX5nR1IfefLSgixc3smfaD+rz
         eD+xHclnUgIooadjIhjri8xk+OmRhNPOVK8yBJlrhdwKWCil0QzU5ni4RmfzSmykivix
         lEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650994; x=1780255794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+FkDvC/ErgcT2CVjGwqZhVxkScGNhYlOoSdsG0KrLjc=;
        b=KTsjhKsuEibuxeNXkk+OMApShv6RR90T81fs/YEWywrXzuue3mewgh/lCEXbsqjLWc
         O7AnQloXS1MY4nbEcHbPj+3Mx0gV9yT1/qqKWII8Qu0VsnDHUloYoRKelo/r5I0N6FMe
         qfCt9sSA6b7ZPs4kDx18QQYDYb36BnW6LoGADtJiIELjeyeBJ55oLwryDDJ6iNr0TTDA
         7eCyV6bx6RTaZFM7uJfsjxSHX3lWDUF5eDImK8mEQXvzLsv8ENnFOA2ZVfT4TDJbQAFP
         2QKnNH2xnfOIxRl3/VgKbpEYFJSMNRmS9+WGQibl7yEGV81KA1dJmOH/F+6C7Gnv8Dq4
         oAVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+f6YcZsYsTQ4XGObBUTkFSCGkseaRm6V4LQG7iOmxaIVIaJiGYO+BnxB/PL6I/0bqxCsKGcpC9f9VIyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkKMdHa4fG2zRmGmNzhjhNeMj8mBU9Mo4763cgncHEiKuZtdP
	g4CXnG2xZCLbuPD1dHhNZh1uo+VxmZQGdAX4oW9SrejurQY+1b5E66ju
X-Gm-Gg: Acq92OFKm6NsJDn5dZZ5xY+Y2n2AM9P8/y/nWpinHcq38cNxilWCfc+4hiIj778XvzC
	1LKDJYAWDnnT6Uuli4fpQsUwkoh06ob6AhGvtAXIhPhkTYleTOlnhMIBQuFpHH41hddf5E8vdRl
	qVKdRsKpwSPQXRMxZHW38y1mUAGlg7YItvsL0xOi5v1cTzVIBnggZk9HFKCJ/uCdi4/qNsbKfoO
	qIGNCP/hNKh3+vMCM2NUDth7e17+vbrBaCZb87a+MHwDfnw9Yf+GdKkyt9i+O3XfmGX39WdmeVf
	umbhZO+cFhNlFCqj99av3+Bznxapo5eHAPLA+6lmhcprHKw7CVHeFMXfk3SZUriiAGn/KTPBYoJ
	IwxACziiqbUTMjGzuefS6reRx80fcc4aa+Bpt+wqTl+kbP4bjsb33PEoLRxh48L3tCOK0gy/iDz
	SGAgzSOIL4D+VLkRngEp+MO1RmFUEeIqBeerWL6PtG0nfBkmzL
X-Received: by 2002:a17:902:db07:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2beb0634c8amr135686415ad.30.1779650994470;
        Sun, 24 May 2026 12:29:54 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:29:53 -0700 (PDT)
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
Subject: [PATCH v4 31/36] iio: magnetometer: hid-sensor-magn-3d: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:38 +0530
Message-Id: <20260524192943.1196773-2-sanjayembedded@gmail.com>
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 22c7b24e2e3a..3019de46731a 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -516,8 +516,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &magn_state->magn_flux_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &magn_state->magn_flux_attributes);
 	if (ret < 0) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -526,7 +526,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	magn_state->callbacks.send_event = magn_3d_proc_event;
@@ -543,8 +543,6 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 	return ret;
 }
 
@@ -553,11 +551,9 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 }
 
 static const struct platform_device_id hid_magn_3d_ids[] = {
-- 
2.34.1

