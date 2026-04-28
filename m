Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004E3D47A7
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360614; cv=none; b=R7g7z+GLHkGl7K/TMawlHFwwcDuhj6+k0cZAoKciPB+Xr7CwrnQCz1i38xNQtyqw5a0kW89kG4FxYX0Ls2DzAbDF2OSQQxAAb9kin04wCkBMRqswW4cmPm7BIS2/g1TmFIc2d87izCOckuqKE5PJe+J2kM5/+j5UOTUCJQ6dYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360614; c=relaxed/simple;
	bh=jj0oKGMSJItbsfmBv49PEQMMzZmhENkSicxavbGihZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkfQVfRaqD4I+nVHa1Jc4Vy4++r3SxTGEQh4OPY44vA/IQLyT+mVoNQmZJadA5DFkyuNAW8XfYMnQTJcqta3peoPFsV9LZuBv4qbl2MayVuQnjIwTnFPYE5pVsdXjVB0NB8F3Ne9x6JAbmavsbQBqkAIFMR4ZL2P6bRPdUX5ZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzYXteKK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzYXteKK"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83177129e28so2178991b3a.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360612; x=1777965412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyeuJKAlOIXJCmj0O+A4wW9kGaPEO/cRUvtuXdGiC48=;
        b=VzYXteKK78S9/oZIV5Kurp8xxOaj7VjyyWNi9Kt6Ma0jI+zoJtCBPJimbVbKQjz/mi
         kujhdZj6BdK+CCm2lxb3TImkAC3JZSDey879DAZozIh43O5Hu0y0n+xEjM2BKAmL7lKQ
         5PquKrpj/BlnKvsEi6FYe+xUN1g08dGBWUczM8NchEDomXGX7flt99+qLsopsRd9uw32
         RwVn3u4fUZSr46gy4MRMiu4PvS/5MN7iIsCEdE6qclTOaiuOgikVbL39J9CSBMbNPK8G
         R+N5HtyEklduaf8yV9MN+BiQ0R/BJrumOQJW0xfzvJ6kvOtNHUYeJmtNmlQwgxaiIuyG
         VMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360612; x=1777965412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lyeuJKAlOIXJCmj0O+A4wW9kGaPEO/cRUvtuXdGiC48=;
        b=JSDOb6wB2/ocp2HxuI1r3xqxQkhL1Wm1MoKqSn9umTqv1E+3cryYnJ3Oa1sHka2dDn
         puwIlOj4P9OMLUxnPmKKvkGf8Ee+LYqPbV3j7yR4FxJk56dDTDkdVYNuaitZgSXkdDjL
         4Nhmp9X1pc9yQRtKJ9czRmLRTzI/TiyKDVQH6TJOAdNVO+KLFZNZyLhvmSEJaHKLir7x
         X6SHxdO2wSSueNJYTUV3S/0KrcoNroX0PNDKFNpxnowVRRWVuA1vSegm++LL8GEMEMVY
         5Szpo9wDFmHoeDZFWypEcU4/P8FMTmT8LQryD3h7rY0TSqQUj4Vv8LzCSCFTo9QaU1Uv
         6iog==
X-Forwarded-Encrypted: i=1; AFNElJ++O9pK3iRPyyg/UC3nD1zXO69E78gMqYeOgMV8opMrCaypa0X0IHBOcItNZTmYMv8mTTikMe7+N44tEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvbRG4pXThuszo9PpUf+PwKWFNYu6A7FdpyIb/Ovkb84YhbBT
	2rz8K85uVyc9DYW0QQDpC7VPIOZ9RiAyi0drG56fHlIjJVD/f+t/okWs
X-Gm-Gg: AeBDieuU0Kd8+gIJa0CLPEbuO4EjTqKT3l7ca2jT7lkUIKYw8FFGbZfGQTV86G2oprv
	q2CgkkEiSoCaJG4NIRRWDtL1F5tTVEQ8MHlUOS1jgSyWWHkVYX3eN/OuB/GmmvRVUtLEXQFocfK
	7zNdWTXzSvIH1WkjUBEKjppS8B9DF8JLBbuHf7KBM7/na9qgWTEOLit6v7VngQlDeabwszFHTvG
	EI7Vqv/lxYta2mVELmQJaPS1Q5yIw7GlCtCc6flhxZ1qBclVVGvCskJ2G9v3F8MKWi5A95mPVrD
	NQQ6Z0EdtrWnIE+MRLYFupFCv+d9SlRfbUVJyGEjFy3i2LLvOyrExMwz02XTMHdFLFlHGo634wV
	amLnndz8UYFDeIx8hGZZ+j+NbW+4KquDBT653ACkcp3rJc+rhqm0NIeVt4HD7tL/ZA44TS01gXL
	frVmJeiwnDKmdpbanSMON60RDPloBUI9NAHHHN0pyQVtTDCKVMxZ5rDhqEnLFmtEOxb9PsPQ==
X-Received: by 2002:a05:6a00:99f:b0:82c:ded1:261f with SMTP id d2e1a72fcca58-834ddbe7be7mr1926583b3a.27.1777360612421;
        Tue, 28 Apr 2026 00:16:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:52 -0700 (PDT)
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
Subject: [PATCH 08/10] iio: magnetometer: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:11 +0530
Message-Id: <20260428071613.1134053-9-sanjayembedded@gmail.com>
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index b01dd53eb100..8be3dfe4dd58 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -542,7 +542,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 	return ret;
 }
 
@@ -555,7 +555,7 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 }
 
 static const struct platform_device_id hid_magn_3d_ids[] = {
-- 
2.34.1

