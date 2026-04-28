Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B83CAE81
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360590; cv=none; b=MbpeZxm1+RhHSNiZUY9kzFLqHh52zW/ZGHmnlLiNJQGpAiRLsph/hEekFnjITZnMRusdr5M2YVyz/qywhFeBHBforBN1efE/djHwSX/5BB7AoCBUs183Yopxhg2l90KMjC42I1GsiARP7GBjPoW9Vd4hhUloAn2VpL/f/QLZrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360590; c=relaxed/simple;
	bh=GcfKUhA9sUCH/m9Qy49VZDRVp9ZkTdbtacQbAQFjBGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fabx0Z0eVb8xOUkIFGGyXRPVbKjzXMBgakkUcnNPDBwBmOwfoz75iAfqHT4lSqv9MkFKMBjKslooT4aaMqcmYCK9qFmiR29jhVNrKXAxMIuRAcNjaSYKWM69l1RJJDUmG00PmGrQCqqnWJvxNhO5Ofnn2keDzsPSTvotu9FdnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeCtA688; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeCtA688"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f69a286dbso8340373b3a.2
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360588; x=1777965388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SSYhf4HLOqy0avoXIi70zEszKa6ZWlWDxXxbtQNr6o=;
        b=oeCtA688sitlJZXH3fhzWn0GoNL1vAaISDM3T1QfaNu5Lbm31CgpHjYDdxwVAL+f5b
         ktekRqpQM/26MwFPGIlIfRiCqEEzj6fETkVm4o2o7AGoiRIxjGO0WD1kJ6ZoaiIDRKb2
         OhQwA2ppzp81/07H0EC1aQu4vHABthRm63YKG1uPk+1a/ZinK5l2K08dYOxHfkz44h/e
         0NQJjz6ohuIYOLshjpg8TZeUZta7RfxHlCSExKcYtJDWbj8Z0wwaxxfai2OwGx90snMT
         3GGaQF2qvsEr8hvLHMlCCfsKwaD6mcWQAT2d5lOigy3IubI1EHBO9wcOcE+n78jlONLB
         PMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360588; x=1777965388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4SSYhf4HLOqy0avoXIi70zEszKa6ZWlWDxXxbtQNr6o=;
        b=ayF8VK2JxLGqBB2Z0wERMpZH0Gdrn6evVeLE5qWxAsm4EaukZckywb5Y1z1Z1KOBPG
         pSQjNFVIw0m2EPFcatYWZayQLt/MVTj8Cwopc6Dc/IINSivNeGmhjkTSq/QZ+sA04fBD
         fueHrDXXl/9A9Krr3SpmxoOKidJsV1NUzlI+4+Ulo06cALdDYZLioJAFzcB7y/73F4Pw
         eTzTwVixyF9nh+wpbA2Vhq8BQN0fJkMkuDqKbSajeR6kH7eZijq9LvR2i6PjYfviketd
         GtfSaT6M0I4HFGAjzdiYlxMSPSVaVV3IVXO+VhBHjssknFqtjo+50MZD+8MgKQ6/encI
         H01w==
X-Forwarded-Encrypted: i=1; AFNElJ9LDVH2XrJXacBe3umMWNtdCAUXSTuYuCjEq8GLPtISfdGhiPkhj0KQfEsiuSPkIbZZr7DLqaka6PQvNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CvZ2L96+orrLS3Og794UtXa1uy0/7YOmGbZh1jDI0oCxzGJ9
	DAom9TrXI8LJEUFL7MRTsZypI1dQYODe2Ghi28s43/VG+9zaCpZ7CGeZ
X-Gm-Gg: AeBDiet/S/fsaBDBJx/ddo8W1MPtUpffn6yDHCW6/pbiw3F5u/Wvb+mYSCviFe7i8Qd
	/J88sLAmjZ1AK7HRV5kRtS+6/6HEphhf4n3VrBDNKmjhGuNOUgZbMp5TuHYoLKRecBl68bj4Tx0
	GBjjrqP8Or8Pg9ZwIfbScgEhWhCncL9Q8R7gb/eaJI+3N91QvdfMqzoFQ7BeGvcj6mG83Rir6eA
	7ocUemztvt7OYpHTirTEJ7gTra1ZYlqwV6O1ojuPUeVO8/jt4BT1lJpw0GNTzeXtf15q/x/09aB
	S40QggXjb/HnuNnUEALdZNFAnxLCcDAIvwLQTGdD5kzseyTs9c72bLWSy31SRmoNCnQxMn404T+
	nMtyaeT4iI9ygZ7/psHz2BOJxtBD+uVd0ifMcPwLY6ZRXFoCD5cfROIDAnFdPs5jRpbAtRu4kN4
	qI3VmjSkJwy7sz3KjuOjzPMu2Wd/IBAnUT/pz54Dmt2C/N9Z6qPVfAJbeV3YI=
X-Received: by 2002:a05:6a00:4094:b0:82c:e0d7:268b with SMTP id d2e1a72fcca58-834ddc2d692mr2132239b3a.23.1777360587812;
        Tue, 28 Apr 2026 00:16:27 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:27 -0700 (PDT)
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
Subject: [PATCH 02/10] iio: orientation: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:05 +0530
Message-Id: <20260428071613.1134053-3-sanjayembedded@gmail.com>
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
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 4 ++--
 drivers/iio/orientation/hid-sensor-rotation.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 4e23a598a3fb..56fd9c53dfc2 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -378,7 +378,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
+	hid_sensor_remove_trigger(&incl_state->common_attributes);
 	return ret;
 }
 
@@ -391,7 +391,7 @@ static void hid_incl_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
+	hid_sensor_remove_trigger(&incl_state->common_attributes);
 }
 
 static const struct platform_device_id hid_incl_3d_ids[] = {
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e4555099..56fdb3412fe3 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -353,7 +353,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
+	hid_sensor_remove_trigger(&rot_state->common_attributes);
 	return ret;
 }
 
@@ -366,7 +366,7 @@ static void hid_dev_rot_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
+	hid_sensor_remove_trigger(&rot_state->common_attributes);
 }
 
 static const struct platform_device_id hid_dev_rot_ids[] = {
-- 
2.34.1

