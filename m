Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31E42EEB8
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605614; cv=none; b=DWUjvZ3OlWfzynFnnVrLdSH1pidiRP1vjTJlRd6htch+RllESYwtrQdYoQyvSuFg0b665wqKUspjfqMrjNt7KNWfR777D/1rd/XD/SGvEwFtQ9aC+MP/b1/G4XHknkTHWk+o9jtT12IlzU6JV6ws+i4qaWgSP9je0oncHJO2sQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605614; c=relaxed/simple;
	bh=Tatshw8tZp3isUeJgpguim4utDTPO4m7ZqEDtHPAsiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWGCM4XbfUcHiIUd2CNa7znmZp4LF0kyTy5GK70TDA2V1fvAwHCpV4e7l+VRxhT844ZjCYgq8c2gGAQBsn0BBPz3RLpXMD8zt/LB52keK9DCAl2tTP72aI5R4Iwc6eTR68kkmSRdc5dPVG4tyuDvnwcbzByT/Pc/yOLJ1V/c/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYHL0im5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYHL0im5"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso4351465a91.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605613; x=1782210413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fb6YzEnYflcBWwBNi3JZ3ijbs1rvmfdK7b9YH3s3sDg=;
        b=oYHL0im5Tfk6TtNPqw3WAV515y2e49L4lNSaAGB57BuyRnNBE9QciyN+Os/hIaBCxH
         KtBQ+StDd9ywd1k3iBs6k4K5c5AQEC2b2SepPdITjEgA9OTTpHcKBC8CK6t9psKOor+I
         kAfqEnXa8/sIik+oL8oCsrNoCEYQfSx5yHOA6PVellDPbCQJejYr6Os2lf6kr/ZQFPiq
         mm80lAxENhgBEtmddYJd9LiWZ4SDOMEFNTo/351bXYi5f8laGsWejy2uAyqadAGF2cgj
         WrqO+BPCt2mTV7IGFzaUvGHQ5vblMUuYoxxTsnAnPWC9iabU200PB3W7+yu21fYIy9Vc
         5BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605613; x=1782210413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fb6YzEnYflcBWwBNi3JZ3ijbs1rvmfdK7b9YH3s3sDg=;
        b=n3ELH14TpTMyTyT6NGFR14HgoSbSBl7fvYVQt1W3dzL5FMqIbYycl0OGSg7W39tJJ3
         SxHf1+SmTwfR4lNsuIDfeWIcIJ855r/rxDicAgrFGHXn4ocrExo5mG1EN4bdtrz5PmfT
         BACirGR4pu7tmk5kNF597sseJPhu/FDWYybrIpzGPf+HjazmYiU+Rb9KMbyC4Tbl8E0b
         RDlyI/PA61Yo6axCiAa7EdOPGDfOtcgFDzALdtKK7AVHHupOBJr6ShR7agT3IhU/oSZU
         VTiZvek2v4wBY0ep7hjc3o1AQ4RJwhMww3EqXhofSyuY/F+vpbYEm88Y87JedtyfNfls
         sA3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/KBMzP3TBNrVemGGQXi/LOPhiGdgUKRtL0T4atS5QtdKyIOQA9L/P4P+QHucvh8n4aEZus4jnrOJvjXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XiGeuG62erPGqCDqv2kVqoXiB8NFNNcBApx6ec8LgGPClJqp
	ePIZclfosHkrw10TjeRl0uFReb70Fop5AtIUffjCjwlpQAOZjZyFjYhl
X-Gm-Gg: Acq92OGyTTVK/l95YZ7PDjFjjQGlIfUP3s05pL2gbVVnP9prjrVpuOnsGG8cMu/oubM
	j85hdEzyWdGziNh72UF5kamIYcFiyXdAsFL0vWG1htZ8/VAeiafHYRfclS4nNXhLkupYOwByzbC
	Hrv8NA/vcmIKJ/ZZDrOv5LRJXS4eOTWLe8xXYsZiPDyD30akyiKv3XoNFb5qZYel+gxgXnzXXxH
	UHH/oXPomn9y7Q8pHUpUvsjq1Uka/IOlzfi5RatnWhokAF6uCh95XA+0QqRe0a5QPwCrczLe3ae
	+GeyrI2d2qytFpRbiwcKL7PSGhsaXWP35mR717cBTlthOjpCkVSf6f/QP9vG7hpgpXnTy4jaLrW
	N1G3hqNi5U1Z55O/MtuM+NuZHWYwGD6ig09RTklnvVO1OuKuLtFgn70VdZYOT6QnFmHK0nrF+10
	ZH3uFEzefC7dkR7q87nrfqW1UBTrjG8EfeUbxmo+SKOiInwNXe
X-Received: by 2002:a17:90a:d006:b0:36a:8ce7:b879 with SMTP id 98e67ed59e1d1-37a018486cdmr17603706a91.5.1781605612690;
        Tue, 16 Jun 2026 03:26:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:52 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:10 +0530
Subject: [PATCH 05/11] iio: humidity: hid-sensor-humidity: use common
 device for devres
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-5-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2

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
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 6fed019f4099..73120b87d641 100644
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

