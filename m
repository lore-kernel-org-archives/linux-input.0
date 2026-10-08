Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF943BFAF7
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439426; cv=none; b=MhOpNVH58UcV1XjENg2BL7i/WZFvgXKBtiScYHLUgYdoEL+uYiB8inBUauaSbgdcsXp+bPk3V0MebmXwAkTQ8Z3EAp5pvif7qE7dyyr5Huj36Q6agEEAlIZkhKb0y/VM4Q+3xAJIbr+8LMByLpGcie9l57v/eUnxBp5zJsTy/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439426; c=relaxed/simple;
	bh=LogPqtRI+3Y251ECMeXLKVerF2MqU068FSQUU1CxGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kDQQiy5KZu1AoffDblcaINkPuTxBGHl0T3y7JQQkeI9et/avdHMfjWUin+QgHcuSIOvG+aB4qFxvtI0qzriYaSHAtbyb2IdTFe4KlK0FvW5QvO+uad4JNPoqDJV2Uo6Rbci8biyyH6I08AjxDIs7vFBmIbDLSbMDAwvRdqimWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfzEIrKo; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfzEIrKo"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3115c4451c8so4043755eec.1
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 23:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791439424; x=1792044224; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vG8A5DHOHEm0r2MxX5Tv8Bi5dsLrsgnlM8XJb+VYSKY=;
        b=XfzEIrKoH+6CkUyAKSMvV7eIkCwlNgY2LM4QzjjDG6Buq/qPk72n0RyRNXxBCCT7tW
         Uf1rjcchoFHa5wj6P1kz6nOGq4aDlgh0YmOyCT/goGNZlFTmk8HGdy/cBThGck11vajU
         e/71JO4Vezcrbp2QRf23/eNUUo7UnVnWp4VoHAgial50dcSVNDg9aswufaYhfQ86ERiF
         39fWaGW0d2jLwaIxoKZE4rAVDaqXmgK/POYL7hZ9Ss7pGSSbiH6AR4RyMEpAN9WiiY4/
         8f5M8SWRqHRcoG3QVD2WxnQPamsKFqz4oM5Nl0k7WsVGVfQdppbWXp1smzYzcVLzPxY8
         /1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791439424; x=1792044224;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vG8A5DHOHEm0r2MxX5Tv8Bi5dsLrsgnlM8XJb+VYSKY=;
        b=lHYeFm0YD2l4WeA8HGeZn/v4E8E8aDEPMLd/1EqlkCUAW5EX/rGc2/HX0y4qfk4H3e
         LB++orDT7HG/FF2ZAQj/fwWuU6YNRIHolX644GaHDGg+oRdbEmjFFVL3B3R5B2ihl4T5
         0cdLRZ0zkB8rxLnwqKJfSnGAU480thYOo40Xa2fjo8DzVkFS14A86QfT+VCayZYvQZWt
         SV30HNH8RK+2lsOziM3Ioa+keFjndadKRN1FCjHCzIty/rLorQQGXxK1rz1z4AWSHFHq
         PmrsFYCTPJgoaOhcviZt6tLrZai3KjAEkPd7x6fSVvrjvHkitAOHvsyJiXoHtui3E36z
         E+ow==
X-Gm-Message-State: AFuF++ldIBlmFt3Bkhwuf767NgYUAbFfQR0kEBnFQj/qrWh3E6e2BVjp
	yj9lpPv5NzdtKxHnkcguhb6BhRufbDdPdP4n7Ml58exQq7Vhfhoo44ApG5Pk7117eqI=
X-Gm-Gg: AYBFou1nbF7BSubFe44Q6bHfuo0JZhwFmtn67uWXX3qfr33JWkI1uGeM6Cub8KgrXCX
	Zy1lzK2FYcOE4CM5uEcH/pS2gyj/81pEztL5YNLbDCYTplBBwAQr77SvfEE88jad+nEgCzmjFaD
	I+JRnvXyAn8hCWBwPszmHP1a1FwxergZxcSyt7Y9W6n3ofjxH09xU0OYf3KYLONGfs2d50MC0QR
	9uNz0ctGbwQ9Ik4S72qC/3psdLGDitGghx7Z7EIqkasScaOdu+HwvJPAnTjPoia/HtpxHYgCIUe
	rz26s+Q0UBuj2FOj2wsyikRapt+FUcVzE7YDqGPHngEUUgTEIOja61BO/CzoRj71gn7Teq9QFVv
	W0CnC/nh77qU5pkvMTrAcKq4cCaHLcWdqmSjfLd1xpN8OvRn+JjCqYUF/WcHXPPR0HLYA/Ngeex
	YI/FfTUQIpvTp+F6qtv/qJmMqfjzP6Ti3zXdzLum3MVWSTCLUKfgbGH5GUrM/B0Y2/k8GC84l1q
	k3cWawSe/XgBOX5m/USp/s6kE6Ib1by8nk9TjE2
X-Received: by 2002:a05:7300:ae97:b0:34b:6f6c:2274 with SMTP id 5a478bee46e88-35177712b36mr1862469eec.5.1791439423696;
        Wed, 07 Oct 2026 23:03:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515b02d552sm22832634eec.28.2026.10.07.23.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:03:42 -0700 (PDT)
Date: Wed, 7 Oct 2026 23:03:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: axp20x-pek - drop redundant idev->dev.parent
 assignment
Message-ID: <ascyIezYwLuoqmtw@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

devm_input_allocate_device() already initializes idev->dev.parent to
the supplied parent device, so the explicit assignment in
axp20x_pek_probe_input_device() is redundant. Remove it.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/axp20x-pek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 24f9e9d893de..c34e002258ee 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -241,7 +241,6 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
 
 	idev->name = "axp20x-pek";
 	idev->phys = "m1kbd/input2";
-	idev->dev.parent = &pdev->dev;
 
 	input_set_capability(idev, EV_KEY, KEY_POWER);
 
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Dmitry
