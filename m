Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050BC31715C
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650773; cv=none; b=h+jJseFntTyC29Wj1BA4uSrFI/Jj6zNRwIlWqwFphKiWOwHhoN6Vnzg0CJn9njybMiDp4QOxYeXXe2NhTXNlyusvMCBdDsHMpC/eI2UZeEfBF9KjUAYMtRFuwXNHVTmZLcdp61Z0q2dn4YUQq0ygUtJep/mBha2XnH6hKJCeMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650773; c=relaxed/simple;
	bh=+X03fXAA3jAuwhdLpIw7G/FSO/VmWLrsJgiCP8kvOUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b86pk4D0ZJuwPIzVMoHDJ1xaQhcRL2UbugpBicI/fulO00Mnhn0Fou/642GwIyD1NHq+f6NPJHVwxaE4+NK1KjCXm1JrfY3tK3Q+pr8Clnmc3dxWY/e/hLkowmbIqhkWpVWVT9TWWBmOz1uvr6CwSR0CIPbihR0kJeouBg7HnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpt9Q/IW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpt9Q/IW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bcd730e090so73819325ad.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650771; x=1780255571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbdaUPCQECYKj5I8bo/eYv+jpArHLYQ+KNsZa4Mw9+0=;
        b=Gpt9Q/IW4xKd/KwTD2BHG9LMxyBf9YzIPWU1S+uP+lUPQ45q9C2TSrS4EhUVZtK8In
         NRWrUpPkSs0p3cMgV1yJDKXHqEn0KyqcpT6S9PDKW5JORjHCq6rega5d4YwLCikjPthB
         HarPOm5JdtJrM04XOb1BcoG7THRTT854gIs7vpwkW+gEgW6tOHY/pYUc5RGh+0NtB5V/
         Xv3i+tyJ9vs3w0HQbWW4AplfXDHimd66ejGkX/jBmqDQc/uMxZa6lrRlKMRZo4k7/cDo
         eaLZPYnagX0mtjX/TSJ9PgcYICdNSGVyXkDXPL0EaVi+z1MrERLoF10PgIC6tkHyDO8K
         cYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650771; x=1780255571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbdaUPCQECYKj5I8bo/eYv+jpArHLYQ+KNsZa4Mw9+0=;
        b=KlB9Isp0CfKfYu1nGlVAj2Zca5NCyeSeu97wWXEoOmLKPdD/tM8YT3mr7OueNT9HZ7
         TRk5z6cPy9RiKhRyk8KU3NWrXeWARXxIEZzI6TSn7Fd0kyOATvbSYVaV5khpwcJqZxxs
         yTTy33vEyhDrO2xTuni9F1ZeCdqhqr30kJmI69m9bbSc8z7sxmiuRHWmNzYYokdXq3DI
         EHguHtFdfon3Kf1lxLzqZyORp2XGxOk/PEWOXXqkDIb6uWVjFA7a6lEs9aOHMuaIYkjw
         nen9Hm5P0/wgg/B4pXTiH1yzkQZC80rfCAs1mY2QQbuhb3Y2F8VCJPAn/6ttIUU8l1s3
         wtAQ==
X-Forwarded-Encrypted: i=1; AFNElJ850hQDHUkQ2JdGa3H+VfXojT9sJYDOH8SNXknzglLuAuo+8+1/PyoVBQdGQjJRLGYXGYUIKSaU/2E1SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YynY4lYEdGeTzeIIUD1hljtgANqs1+sgZGmpBb7jGwtz8nO/0Op
	cf/h6pvKintq4EOeoISkeqD8OUn5v5LKRP4WO7Z35k97tCoVm4JfTQl4
X-Gm-Gg: Acq92OFQQMpMMHRx6BmFlpcKZLajKKTrmGNkf8TOPAEjGrpW2L7wDkOpvnljgJZVyCA
	ACEfahGa6KsuEseH3n2ZQ4gDglFTDISspKPIl1YvSxqDN4oh5LGMNHLiLSP3wLc1zODdc9+upoB
	CjLxZ8Zoe+DA6MQ5rv3XImwnPGHhr41kR/oSO0fYGASn+BVcxWmifJjjjLblBUN/1vXX7a5EYPL
	pNhL4q7D1y/brZ41SXK6y8A3TmVAjk1EYIzRiLghdsSx3LeTV7BOlArHbW/frIQQrlJQ+I5dCwb
	tHAVi5Mp4iXkUewiRxQmT6CWhi2Wk+FWoXwmAjQTzG3SEtrY7oQ1tZTdMdo4HbnO3QsNfHuqE4P
	xsJCJI5gEIajHAbiI1X/lPT2bz8xf2gQmMlGx84uq2AsP4A6QEULzzZNUD3f+biujWYGlHvkO++
	4K0OV27Du+zPlx1xeY0YYFTWWMIRg1buPEFtEf7y53pDCYkZ8j
X-Received: by 2002:a17:902:ebc2:b0:2ba:6ffa:bde0 with SMTP id d9443c01a7336-2beb065b797mr126061235ad.19.1779650771364;
        Sun, 24 May 2026 12:26:11 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:10 -0700 (PDT)
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
Subject: [PATCH v4 12/36] iio: humidity: hid-sensor-humidity: use common device for devres
Date: Mon, 25 May 2026 00:55:49 +0530
Message-Id: <20260524192556.1195042-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
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

