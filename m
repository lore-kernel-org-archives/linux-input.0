Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0232E757
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650777; cv=none; b=rVpGCq6NEn+TWmLafDrnQef/Gv0SthBxDg0v1FPzX+VG92huWKKRCLjRz+S1uOiaS1owDTvoa7bjsQzW0iQ3oqZ2t/WR5Egz3Mn4LunKHiqE9Bw4gxmsLMdVzvbsCrow2SmymoZ2EkKDrytTDEeTe0MxegWxGH8CupwTji+uIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650777; c=relaxed/simple;
	bh=egtMgX2FDjd0er6w9V0x4CTz+7hgSNxMa18qrYXFVh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzU1cIKplCY6ZcHLU68uu5ZXkBIRp3BZqVcQXdoDOi9v8OFQmLdXcdZ0IJiAYlTpo4udlIOI/jhORORZNQLFJf4YEzKbVp3LrUMQCc5fBW9M5dvABE3Lydk8am8Q4Bqv8Rd0nI85FC+k1W0cv8T18y5bkZL9MLJUh40DR+q3IIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLt/mpuJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLt/mpuJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b4650d5f5cso36710335ad.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650775; x=1780255575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti18O9hnscGTIssv3n5pi3SPGLV25Y8SlAQgXesMLNE=;
        b=OLt/mpuJJ0ADv/tSB6zy+9gr3CnEFmG2mb9ms3eebAuNwzmkWOz1mRu987bs/ac3ah
         JDka0pThKgOACuqDXTK/19LcfoC31RZY9YzXZOnr6+3rM2ACmBN51y72B1rscie9vZce
         5lIeuFU6sl22/mnvuY0LkGTZ3VaHGXoSS0kOdNHDu446KiopCR+8xzzj3S/WT8po8yxr
         64EbCbCwFey3BnW/BK/aWeX5FHYZQYfxkLaSZkZrqO9NaAT7PR6iuIpEJPq6e9HuAHse
         JGxGcgAvbXHsa1kuj64jJNqoWgvaQQsJuWeo2WkeKTCs2C7XTkmjWecwmQIBVbA1C5Hx
         d1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650775; x=1780255575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ti18O9hnscGTIssv3n5pi3SPGLV25Y8SlAQgXesMLNE=;
        b=OTABDWJUkI5+w4Vphvj1OlKGUzecMaQseWWDWQ45+wFmAludQ4n6KBWL/OSiqBQ+d5
         gxLLSUUcpZZRUlwDicsXCMTE89JaEN4HJCbmTrtB2batj/W3zr/Sg9JgCXndUagi9hkQ
         Mv5jf95dnxLAC0p5FgGI2oGRrg1QmaG8tM/Kla5jxYh4J8HYrB/EWNH4HSKQN7Bt0OZT
         0a0vt8Cm9iDnytNMe6yf6zqr9w1KNAQRvkotKnXReCodFzDI970obQh8xu36kIRsEkFS
         d95EH4uImet557AmzEvXXes8oRxJD295EutBaYWGFydVyrqay3Shx7Q1CbaqBsZlhsAq
         Xjhw==
X-Forwarded-Encrypted: i=1; AFNElJ+yk4AdhC4bIB1IOlFITvJXKk96MbfUj9Tu2M7OS6ZIeE/ZxegRAG+3Yo6Bu4Bnxg5yQ/1Ls8XDNSc+3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dzgTkr+w12swsejCB4KE45r/Z7qX5qbFbn7Fi/1uJntXUMLc
	ccp7DVmy8q/ypeuO23ny0occlM9usb2165jd/qgIltxxOlUjn7LUqgy8
X-Gm-Gg: Acq92OEqY0g9l0XMtZoaRZNJ8iy+Dki1U9BeWDsoW0iNid71ePe0TULjDf02fwlpNjw
	8QiwBbyhY8MsuTsg4ELzneyk9K6F7v1rvCSnUvzoCXs8QOR/5Oa21GTVh9fGURSu/btrm6jkwB7
	YCXTLTR3HtYyeAS8+VMq+JtXaWE+UpjrKo+78+7Ibb1VJP2MrnfQ46ykDAIVO94DDCcQd/mpOrx
	SxF6ngZGKkad25I0LCLd1Rw73Wp4x4cqFm4SwVtWWnqbFLM+UsobF21qSCmI0AKuN4M7+QzQz4L
	ZvmNOOPsrCwAHEowRcnkvd7zNzbLr2TaNd/wccJ231zfqkvdl1qGMRkG/pkHkIgibJXWxVMDglB
	HRzYX5TznOsNN7m4Sd0Nlt9NdmE76ufnK181IVP1pbvR6QWY9SYoT28RWSXJZ0u4Edh6x3gUpGx
	yh8HTgZDrZWLjkCOJpFhzCoBKkXihF25vBek3/F+O5JSAxVBco3vNe4APv0+awcHQPFTzy9Q==
X-Received: by 2002:a17:902:db07:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2beb0634c8amr135623885ad.30.1779650775312;
        Sun, 24 May 2026 12:26:15 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:14 -0700 (PDT)
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
Subject: [PATCH v4 13/36] iio: position: hid-sensor-custom-intel-hinge: use common device for devres
Date: Mon, 25 May 2026 00:55:50 +0530
Message-Id: <20260524192556.1195042-4-sanjayembedded@gmail.com>
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
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index a26d391661fd..0ba9d2d43913 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -292,7 +292,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
-	indio_dev->channels = devm_kmemdup(&indio_dev->dev, hinge_channels,
+	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
 					   sizeof(hinge_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;
-- 
2.34.1

