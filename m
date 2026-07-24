Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B66449EDD
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914193; cv=none; b=bL/ifpvss2gc1aqo4s2hiVPblZxwQ1UWBlCZahoNWrUP5pm798dxZC3LgWunbL3Wo28ZXrjYSJIkQK7Bc+RvGDqyKNPrjM1vuISPxdW8lClkOIEFDa+rHeF9JeFoE/cQbUuiwI2l9Qmwq2SkD6Oljw4lyDwz1Is4SC/MTYzXVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914193; c=relaxed/simple;
	bh=JJEtIyEQyEka+FlSFBMFI4h8W4CHxV0vh08WZGFEDvg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bO4BiAhPMjD1OIFx2hkgsRz5Jp/67QPwuYbxXSXwNlKOpaed30S0HG0M7l3fnL6/jUkB5CLbsmOiHghkDPRXXqvSvQovWamne01u46u024gMH2E4dBQv6TfAaQTO0MqahWzTgJsxKG7xxvnU4XqnxTeky6kGIHhWgt/Kf6HhCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N029FmAv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N029FmAv"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-382ef647e20so759791a91.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784914190; x=1785518990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VfLgzMjoDnerpUvZDjj2ZmbAMQJPt14KAgDXLmsqJTY=;
        b=N029FmAvcFJi/SKr3MBbMU44VJdaJ/qebTwCPI5APmRvu3o+PDkX68ZiLt6fpdiTaN
         mYyvJelOfMYXaK4KwXXNCl0eTAwc4vaTcfnskGsSp+Ynvb+cC7D0ZqSAFCvfT3iDyB2s
         ex01FOov+keBo/Si6DIRMO+4Iuqo/NC84RUZ6TLA3Di3Up00WnmmzCX1tAloUvBYJ3TE
         +UyBIkWlOE2/OYLmEupvSH23hAHGnxNJ3qo/wBRK7isf4Hv3kkN/knWmiW0UT0m2GIzL
         TEzqzPiKnxqekrm9UvuHsR67huPHL7kaOgAtkHGQL1Vf8lw+A68o9stgZ7HVIQaHCWWT
         xxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914190; x=1785518990;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VfLgzMjoDnerpUvZDjj2ZmbAMQJPt14KAgDXLmsqJTY=;
        b=oLmPcWp29/Qb2+b/ITynqfasLmU1+eKlH5s2eiPCV1Kbq8B+uh69gMlruM2yfwsJov
         SIKoH5dl5INDDaT9UxNf5gFnRAU7jRQJYgvEiNKChOkMEBeSAAcMEbgWcAsuMDohSFn5
         9t4p94cKeO8hw3oUpTkAO4gwNilf0P/mAjSaXAyTIVl+Q19SldDTKqUIehPUOhTPlOx5
         M7zltrL7ID/6GMNkoNEUfv5TMODZRRzi0HNwBz4GvjpPbaCSZ1x2h4Dhxm7ueCQXzNYj
         vVPNVd10l1uuNdwo/Euw4BTMX0pYjCDh10rMGJ/HqwB674ZpxAYw07w8kINfuh4njGmT
         ernw==
X-Gm-Message-State: AOJu0YzSL3iPX1hvmLFWwbpGRifA6SicaIcAeL1A43KI+1/8K2exLEQy
	IYvlvAmSrab6dZCiyfJ+u47tVmqX548qYi3p9T/kc4gdDrbLUWigot/X
X-Gm-Gg: AR+sD10Hr0uNrxsSoTNXa3G8JdsXYKtEOYdZWDiyJhNaMOERukGk2wd8nOYs1fID92b
	MWETtsqM6tcB4GoEzJ5TjZhF+7CbeM1K8aATll9xDXlss4mkFUbUty4280vsItLtm5vAZu+KJx1
	IuR5CgS+MaBhulA+ATJS4ULbAk0BrjS03/VpovUqPPHpAvEwSy94RyqtOukYi3SsYwoV96Jywy5
	+v3zIGfbJDLBXMNCZjdxigK3GzoUHW3pO+dn3jGOTmspy09NPy4Aq0CfW8bZj68hDgC4FWxD9c1
	ZRubqAxeitcxHf3yRvQBOaPxfype5/RSOFVHbCB+KxwQlRFUKkggTgbeVwdvK3QuiXOAZSyo1R0
	U8rs2Jdbxx8OXMTkrKaRgz+GkgERQXNA2wfi6sEgtF1YKM3dHzFq34g/R2t3vYPxxP9kkw9A3uW
	Ljmlgf0Yj9uXNPK6VlbSHUOSo2
X-Received: by 2002:a17:90b:1d48:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38ec665050cmr9132399a91.41.1784914190194;
        Fri, 24 Jul 2026 10:29:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:8899:46cc:11c:efe0:55f0:d44b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm28485318c88.4.2026.07.24.10.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 10:29:49 -0700 (PDT)
Date: Fri, 24 Jul 2026 22:59:45 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: iio: gyro: hid-sensor-gyro-3d: probe cleanup
User-Agent: Thunderbird for Android
In-Reply-To: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
References: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
Message-ID: <81D24001-4CA9-4059-A649-3C92DD51E10C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kindly ignore this series, I have re-sent v2=2E

Thanks, Sanjay


On 24 July 2026 10:44:29=E2=80=AFpm IST, Sanjay Chitroda via B4 Relay <dev=
null+sanjayembeddedse=2Egmail=2Ecom@kernel=2Eorg> wrote:
>Hi all,
>
>This series cleans up probe error handling in the hid-sensor-gyro-3d
>driver by removing redundant dev_err() calls and replacing remaining
>dev_err() with dev_err_probe() to simplify error handling=2E
>
>Testing:
> - Compiled with W=3D1 for each patch in series
>
>---
>Sanjay Chitroda (2):
>      iio: gyro: hid-sensor-gyro-3d: Remove redundant dev_err()
>      iio: gyro: hid-sensor-gyro-3d: Use dev_err_probe()
>
> drivers/iio/gyro/hid-sensor-gyro-3d=2Ec | 35 ++++++++++++---------------=
--------
> 1 file changed, 12 insertions(+), 23 deletions(-)
>---
>base-commit: 36c12dbda81c284d72f3c64689461647497b643b
>change-id: 20260724-24-july-hid-gyro-dev-log-clenaup-488534e25965
>
>Best regards,
>-- =20
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>
