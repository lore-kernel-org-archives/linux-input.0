Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15141332913
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650781; cv=none; b=VjDHJgOepRy8SnXnXVqcDmxzD3GIeKe8XltvJ+QFI4Xec27wUl7XsWEBQ6GQN+4H5DtO7DKGwAkf7fti0kOirkMx6mnhdidmJRyJYQA5g1c8Xu/9+YC+Ojc6oVjObHVyNmLUPgwoGGm731hih/EQEgQ/afk0dgcvtzrsUij1hSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650781; c=relaxed/simple;
	bh=q4tOcUeGyv4Ycx5bkEpJspcNlwbcOl19qkE2OSQ5/50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO1mOj7NIE+ml6u9NxV/zpyJhkwzy1ubZ8mUxxpMAxR8QGFjmY3ZeN1hzpI8/Jay0b329Jwc4MlGausLOuTtrPBtEwQTfw5oTB2tGgrSSAUWUiKC26L78dr941OOGNFWN8CQKO6qZqFdnqRLdVdY/bzWcnug8XeQVL8gk/9+4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdrHJXw1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdrHJXw1"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so9817012a91.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650779; x=1780255579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh0Q7WJkWoaGQDocOyq50C2W+hagsuG+lujH441v4Ls=;
        b=pdrHJXw1g8uGrxR+9mQPp26ExwpNYWgcvDrqr62+BsgrjQGb/GNCY2/ExkPSG8UcxP
         M8eNOiD83jE1mPmJeRix0wZpQyRKX2b6NdrZTepck9s8CoOrGoeFgp0uwKckm58uyzZ1
         +LtsZ44Y799sy5FDDnU0mUKuEiqbkRPJWu6hhIW616SQBNuqeMyK4+Dlq80QxPQzPEvp
         2zPXkNa/UQurQK2DeqC/EkdMB7ww574DWGjKg+iPB2/4hSDXjqTAWBqHBu/O6ZDnfRcF
         zFuupRkS5SbgaHgLOrxsQdZKRcqCu9BzmkQR42G8FthkdG21eHMG4+59UNiihR0M2EmL
         eN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650779; x=1780255579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uh0Q7WJkWoaGQDocOyq50C2W+hagsuG+lujH441v4Ls=;
        b=XPNsXlqIHjdIuv9o50vaUqIewuyDvKyOFpWij2tcaO6p3IDD6ZENkLDUBX93/dgbLW
         YkogDsRBFEO4b9TCNBdKewX0PsmFu9cXIlvms2/7MlCqCoWqrOSDZCv81eUziz85emnt
         WWliz/yclfARu1Vuv/ZtS26Qh3V85V0gQ0ts3J6EilbV1cxlfhOYtuakEjXqXbEU4kw8
         ONulI6FX9gRgfumTkjsygoCbNWNuy8tvTbqF8Kn92/9ViLb3mrkRSygLfC0PPmFxo/43
         OSCiImD+prvr5oZb2v34Q5Ange2QK9xlkPaO5k58LGcOUoJuPIcUpTT+Rs/7u29oXiKp
         8TQw==
X-Forwarded-Encrypted: i=1; AFNElJ84gujY58WJRKTeBZF7tqdA8QB6Y8hdPhVc3Y/57paxtUPTa0O9emQxdCt3dvuWM9IK9jbYIyftkdetGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72QbhQoYTyJflq8RZOhWB1+vrldZs5jzxJW/HYnFliy3gQwSr
	AzK71lX8uLo9nwgYHABckJm5fyWBbaEuoX9YacwPAVPgcT/oT5PSoO911hxmEg==
X-Gm-Gg: Acq92OGXk2gw906IAFU/jnGsuKJjs/reQK2+Np8/eVpL0qG04TgjpZI51BSKIH982h7
	ifoEYS0AceAw1qN6qQlO7vKmzMoI11PRt4E4ofrobx9nMGu36/wdtPUTKFd8u1qKqvvU5+cYf1Z
	R8euyXORGXk2HKgwN+EWjRxMXAAx7fmyoicp1Vv/mZGbfQEUywfGocdaxHISQfcnJ2jUzSu32cd
	mSu8UgU+0BmlhpPCcfe835cBUwiPvOlWY6k78JVCwD5pdAof+zABm3+lX/RnnKQQOnD+eGVGzlf
	Kts3cjb9NZkdR2PVklHtjBr9xAM+mV6JwqUirkLepmF4yaCp7h28tY8DQk5sNrnwPNUvpSt2VPo
	9ZPhlPNnA2bKwA6sjIH8bCfyAqHqQosmJncWmx8xDMPlRcXTmFvqql+HyoRtyFp/wK/Z0HXGpCJ
	KFQ5xrVEsHmGxWmMYW3HcGxkQmoz1TGAM7/iVQY3K7+iTmWRNu2ho2Rw98PzQ=
X-Received: by 2002:a17:903:2f4e:b0:2bd:2051:13ed with SMTP id d9443c01a7336-2beb06fcbfcmr130007635ad.23.1779650779499;
        Sun, 24 May 2026 12:26:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:18 -0700 (PDT)
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
Subject: [PATCH v4 14/36] iio: temperature: hid-sensor-temperature: use common device for devres
Date: Mon, 25 May 2026 00:55:51 +0530
Message-Id: <20260524192556.1195042-5-sanjayembedded@gmail.com>
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
---
 drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..31ebfd1a1fe2 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -213,8 +213,8 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	temp_chans = devm_kmemdup(&indio_dev->dev, temperature_channels,
-				sizeof(temperature_channels), GFP_KERNEL);
+	temp_chans = devm_kmemdup(&pdev->dev, temperature_channels,
+				  sizeof(temperature_channels), GFP_KERNEL);
 	if (!temp_chans)
 		return -ENOMEM;
 
-- 
2.34.1

