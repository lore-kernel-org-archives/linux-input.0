Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D53A1682
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321478; cv=none; b=Tcge97fUlB3dkTrmATla/jbepomIZiQ7GxEMirm7eGh9Nx1D9Nhmn35Bia01hk97LhsHPTfeT2FkT1bAPnCl1cA0PS3nZ71Fj0aHDx+cXrIAER262loE2+NELWnjw5OaUE33rED6mdxiHWNG2jc5SgZqhuRtMzcv7K3rmYDN9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321478; c=relaxed/simple;
	bh=LtbznnOeojfg3MF3c0kn2sEZYBxwqCbnGZr2+LdXKgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNIgZTABkUXSsAVdXY2CFmRKL7sod/Ck+vC1VxVEwzfzIjRXOYy7E2CkIh1oia2pW+ZSIuu/7Woad628sT3CUd2TWUo1ghrpdb/X/sJh6vuVv2KbWqHQIep8TGBGw3OtRCxFhGJ2PMAYF1r9zIwd5GYUfE+9Sf30N+EsVE9AeMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWJj4cPt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWJj4cPt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9ec9443c2so21055115ad.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321476; x=1778926276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NgiT1pTPWMdwN24wzoDVvqnzlpt6mLzp3Hj6Dzxk7k=;
        b=PWJj4cPtnAYtTjv8bKxjkSSBrE2A8SKHISF4Pyvl1FqeCH3FXeXsqg1BiuiuXl3+5Q
         6xAsnrnEItgziwc3HWbriBK873d3rwRWFlJLGZD5zZE0TCvSeastG6cbVCDkh30vMGMr
         HlUWK2zPccW3t/sFitu7xXCTCK71gnFcc3VVaQ6ce6w7beyOBz0fzi+tecx4aV0Cdaao
         TC3kggF0bZWArlm3y964j2Fd0znIsumFXDZixpn7ykqKQryCaMq4dpLooplPMeR+QsHm
         3S/cvDpFMqodcVR4DGaJQv7kSUQEvDxLh7j6Pph0s6LKOInSPMtA5lszjVZ6AwAZqGTn
         +Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321476; x=1778926276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9NgiT1pTPWMdwN24wzoDVvqnzlpt6mLzp3Hj6Dzxk7k=;
        b=QDVdA7TB1aJmek7xvtboTqj3yitZLZZVNMma1b//k7F5LrBOD0pSbn0KnEyIehLgpv
         V18U5RGXtFhLLol+Tz6SiZqC1WpTQ71t2PKIWGRrg/FXCtRuLf7JWxkoQKjdvhdSBAfn
         WRv8PFiVjDXNfgkfQKmMoWTakPhr7Jm424aPuaBsbSgrZIg4e5/hthsqAaYqGJdzwuVK
         MxGQ88UJUn195XPkCOECwh1XPdDctpnhh0n2juWDkji9uJfQOe8fkZjJYeuLf72FdIsi
         LF1wyZm0OmnQxMHHhYiC9jt6mBJ4Wd844nx390aQ0DpydpHxnDGIqtPsDyPFucEtZqFh
         1rPA==
X-Forwarded-Encrypted: i=1; AFNElJ/SIfWlVcExzxjSBVoRomvamEhbET2aEfAvA8WdpmrpiZdaQKN1PFq3QSYIdLcGXV+XmrQXkSHFfqwfjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3jvkgmQKXt/72CrM9EoQMKLnMHfxJ00SYwJldE1ipawc9kW6
	OeDSgB7VffIvgGuhOeFpYtfCj0JQZhKi73ENsyXGSUO7jr+HfVTsy5X5
X-Gm-Gg: Acq92OEEpsQhx8RNCxCvsXi+GuQTfcUn8UvUvP+Rebd4pcjDwYwptz6yx4nh0uBbCeN
	himjZZ8iy+CIUf4aHjQ/SKCN+pLYLxh0lMqlutced1vXnCGyGxQYiHmlpD+HQOnpg0eTBcGEgvN
	4irXL26nLe6mS3Sjlc+K8DmCXI9yXnrdVyC91Iptu/KTOWnZrl3gwtaDpFlvxaSY1JPQ4PRskkV
	UyDB1nIWRzLH7/tEafxPseppM9ipuwMREHu0b4tj7PG4u4P3I0/6f4T9MlUUuKIr0bd6VjsfTnc
	8FsBaSSoWwOqOVBp9uVqBvLrpYWS5gQ1FA8sFZpd5jwAe+8LpaeEjxMpwp6k3HGE+0ECKJgmRX7
	58qiLDozHe/fiVqTnJ7kMmVKjxa0MPgFuRxaVsAlD/bFOn9VSa7SRykDUJ6Yz2w+zBVIZQr7+n3
	uAB5jA0UllS3ADteJVFGwAtC8Djp+NoIk/72idwkpWNyz09kdr
X-Received: by 2002:a17:903:1a23:b0:2b2:6fbf:ea2d with SMTP id d9443c01a7336-2babc864863mr96873325ad.7.1778321475843;
        Sat, 09 May 2026 03:11:15 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:15 -0700 (PDT)
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
Subject: [PATCH v3 7/9] iio: humidity: hid-sensor-humidity: use common device for devres
Date: Sat,  9 May 2026 15:40:38 +0530
Message-Id: <20260509101040.791404-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 968dd8d4bb35..18d4e376376d 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -215,7 +215,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&indio_dev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;
-- 
2.34.1

