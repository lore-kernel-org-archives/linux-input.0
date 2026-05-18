Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73260218845
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086264; cv=none; b=Cak20cb5Jvxoy9vhNYF2R0BLjKtX1VxRJGs/7dRD0JiQVwfCQEwCr+obVQfjfoLUkwLzehl6Eh7ihHaejAaqaXZ4u+bQCaoqqthl8R2/kSw5TfC8O2vNtI3HAsiVVhpM/R8JsjhlUwktAe9U12iyFlSMWNAwRO0lrnS/DyxonAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086264; c=relaxed/simple;
	bh=4opVSGVK1pUcuw9hzNkK2EOLoJi7osP12yDz7HhOVnM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q2uG2cjqFySnEGCc1QRfhYSxAlNE/HBFO/KzubGpTOnDGFJKe/VvhfHE2GveA+nVnsO4RzPmHIL1LXDncjoqGG3PWWrIxw423H2QDRnfKofN/Q4Rujh+00xKQztXJLo0H/aQ6bZu3OSmE1RMX20hCulL3ghxbakzmP9a+/pfTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRZ2DdO3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRZ2DdO3"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d880e6fbbso33584071cf.0
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779086256; x=1779691056; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cE+xwVdh3twnCV3V0E994pEurq17/WwBVoFWrClUTg=;
        b=FRZ2DdO3lFXmK9f3D5L/iMj6iEjVpWLcWvS29T0E0AhD3N7cqoBGra8UJ3pe4A2Hb0
         XzjH76SGsgRmfTCjnNrssBlNpSeu8+AzooZTm9VVHqC4kKYTamVOoCMa8fg03q1lb+tf
         Egy1spcQ4X6VtqRC/UgmJu8bA8KYClYVe+PZbKgfBNmApxeJwe5dAJ5TayfQooiIxJpt
         Ernp7STdnf+WQ0n65F8aLrRcN/xfXH5Zm589GI6/uvndd+PhyJyhC3ogL9MAGZfsAQkw
         Ct8Zm6aNfmNuxvJT3DV71MhVeCO9gY7aqwTJB8cNe5aBodYg5HZCCXcj6hGoFyUvlYlN
         RV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779086256; x=1779691056;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cE+xwVdh3twnCV3V0E994pEurq17/WwBVoFWrClUTg=;
        b=Y85FgxZpLo3r1v5vNg22njcZxtb4EYpm3J5qYIwt1i/Ii2kNW/kDjrtgxpQBWpCrsW
         yhePV2NzD3DLKd2GcioAd9rVYBDEVAHZQSMA22cNfrjsIb0HpowIatJQB9dwl/9KzKvl
         b1rh4kfcLtJi6n1l1NDkwTRWA8+qJM43QCIUPNrREzs1Rbtbm4sfGV3e2LijKG4ZYWSC
         NgXFQBhNJEkjgh6swpPV+VCkyqCizhXTUmEOW/XPv7TEFtM0SQiOpLODaBUtKTMuemxO
         TgLGN3jvtrn5bdbrjmF/Du9E8K7VaPdDpLHE4KYBwOPmguoc6nn63x1svv6j2LawpqTS
         sTPw==
X-Forwarded-Encrypted: i=1; AFNElJ960tKa6R8a1XKx+Z+oi82hv68Rv86qbT57BEktyGKD0tyBXwWZ9iNRe0TU3MKt587bR+0+KeeqShOptQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sGBzGkfhVUnRF65CR9HLkGhRzJkKOoMVdXrzuvFRhYwB8i3t
	KcKe39EIMG3cjeoVp/d9iC0XF1snH/739LhtlP7zseIFbdNW2tgWr7B8
X-Gm-Gg: Acq92OGwQHRpatYlqI/B22xI+o5lJrUYUgRJ1YTqhupASaVT89OnNhfdKUgy2Vl9S0T
	TDPXkEECVyvID4Y94sG/QS1yuOB/DMLhHG2WYY4zXRWerThVqkd3/1O9EIrq9+YvyZblOUJoI0l
	ygbtu6FNIyDXJwibasYQYfwH01bWtnB34DQdZpARX2srpxmkgI/OPu2WLSbXnPx9S5NFTVPcrVn
	80mo9QcX6Yk3O4vdd+2NOJNNvCgmE3v/zfPBhlghep9uBI0rdWPjHxZu5pBnhzGHFJVhNiShYdB
	pc6a7xnwbDzUPzDnSiu+1fMbqwTdB5tkKTeok2p0OxLXCl/Xl0plGLdiBvQtBu3MlFF4t0fOc0i
	ECMZf6aTw2wbAPYMRuN4m6UUTpxhI/k9GcLiFVonrJvn+DndE96f2qqIYwB4zYoOiH6/ll63c7w
	79Clc8aQRIIOiQLQ/wDhDCQ52c5ASlCfIQkALIChcTxogVH4EU+VXR7R4Res0mxX7wDaUkJG6jh
	t8IqdiLleqkGbjiCE4QS9sr/I3W5LcEia/ZnSL3QoSDPbw6oog=
X-Received: by 2002:a05:622a:a950:b0:50e:18f9:b5e2 with SMTP id d75a77b69052e-5164155c029mr175840921cf.6.1779086256196;
        Sun, 17 May 2026 23:37:36 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360952f9sm46958916d6.15.2026.05.17.23.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 23:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 May 2026 23:37:33 -0700
Message-Id: <DILLFY3D4HQN.2KOV4CVPYXTV0@gmail.com>
Cc: <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>
Subject: Re: [PATCH] Input: mtk-pmic-keys - use of_device_get_match_data()
From: "Rosen Penev" <rosenp@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Rosen Penev" <rosenp@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260518042046.981861-1-rosenp@gmail.com>
 <20260518043409.EC97EC2BCB7@smtp.kernel.org>
In-Reply-To: <20260518043409.EC97EC2BCB7@smtp.kernel.org>

On Sun May 17, 2026 at 9:34 PM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Missing NULL check for of_device_get_match_data() result leads t=
o NULL pointer dereference.
> - [High] Mismatch between child counting and iteration logic can cause ou=
t-of-bounds array accesses.
> --
>
> commit 0ee3fee49ccf02b7e629f90533e67fc9b40d2b9e
> Author: Rosen Penev <rosenp@gmail.com>
>
> Input: mtk-pmic-keys - use of_device_get_match_data()
>
> This commit simplifies the driver to fetch PMIC key register data directl=
y
> using of_device_get_match_data(). It also removes the unneeded of_device.=
h
> include.
>
>> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyb=
oard/mtk-pmic-keys.c
>> index c78d9f6d97c4f..fd684ac169386 100644
>> --- a/drivers/input/keyboard/mtk-pmic-keys.c
>> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> [ ... ]
>> @@ -342,7 +339,7 @@ static int mtk_pmic_keys_probe(struct platform_devic=
e *pdev)
>>
>>  	keys->dev =3D &pdev->dev;
>>  	keys->regmap =3D pmic_chip->regmap;
>> -	mtk_pmic_regs =3D of_id->data;
>> +	mtk_pmic_regs =3D of_device_get_match_data(&pdev->dev);
>
> While this isn't a new issue introduced by this patch, can mtk_pmic_regs =
be
> NULL here if the device is bound manually via sysfs without a matching
> device tree node?
>
> If mtk_pmic_regs is NULL, it appears it is unconditionally dereferenced
> later when calling mtk_pmic_keys_lp_reset_setup().
>
> Would it make sense to add a check for !mtk_pmic_regs right after fetchin=
g
> the match data?
No because every compatible has a non NULL data component.
>
>
> Also, while reviewing this probe function, I noticed another pre-existing
> issue further down:
>
> 	keycount =3D of_get_available_child_count(node);
> 	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> 	    keycount > ARRAY_SIZE(irqnames)) {
> 		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
> 		return -EINVAL;
> 	}
>
> 	for_each_child_of_node_scoped(node, child) {
> 		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];
>
> Is there a mismatch between the child counting and iteration logic?
>
> The validation check uses of_get_available_child_count(), which ignores
> disabled nodes. But the loop uses for_each_child_of_node_scoped(), which
> iterates over all children, including disabled ones.
>
> If a disabled child node exists in the device tree alongside available on=
es,
> could the loop execute more times than the initial validation accounted f=
or?
> This might increment the index variable past the allocated array bounds,
> leading to out-of-bounds accesses on irqnames[] and keys->keys[].
>
> Would updating the loop to use for_each_available_child_of_node_scoped()
> prevent this?
Yes. Interesting that pre-existing issues are flagged...

