Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654123;
	b=XvbqanIybCBdY+yRfNkXyOMGWMK0PDIhvLIoAZDe6aQSwZxlT9ZRd/BsbKV6/wCwnVJr
	 tv+Cu4WZU7zjXh34BFsR8MitH7I1wFnphxdKJGHFPn4J1tKTi4RKAG1oCw6RaMHJaVkc1
	 Xb3WlFp47QDTMgWs8ID45mRjQBIzd9T8Js7Kd5owZIUsLN4Om/f/+mwULrfUYcIm7E6tq
	 OQE3zAoW4LBxVqPFjZ1MhgoNGW2ijJVmR9j/fVqf2a+gwoSQGKkuNf9LIZIECUqgl7tJ3
	 9tttvdHec4t1A7IbLYJbT64mgJkmWczd3kYMOGWUeRu6y7Gezauu+fbE2y0Sxqxh5WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=u87gTMnKrw+5wwB7Owh+xGxsBZeu7l24WbHaLHBaNMc=;
	b=nTX1BkFowx4Cag43N1T7wYFjuZEMaV54vba9OVufO/y1roIulVtdXb/XW4frfS0HeyHR
	 NXsH8tdxAvFfl3SsktSpREkIw1kfjCyfJCXkgZy39sQK+3pQJnkMQZr4dkvULUNkE1qeU
	 K8ljCOMGjCMmtMEWxHjd0IWyw9/5zc9vnn63xX43Xdxtu+5KGaMJuPUo6JoHxr9B+lGD1
	 /v+01ULzQ/ebU4N/rRr23jjLsdm5w0mx4xht1GXWLBHMzE1OUZqKPGFzuzLjuJVDkdG1M
	 BHrXN/PxJYdwduKzxbu5fcLZ5wY2YfJejD7QvWUrT/fafTYGog4vRrLcJsOaN9noZFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aT2dPJNY;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA8606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BA8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aT2dPJNY
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so8801635e9.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792654119; x=1793258919; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u87gTMnKrw+5wwB7Owh+xGxsBZeu7l24WbHaLHBaNMc=;
        b=aT2dPJNYvwXMj55NQLktkv6OrKNvDilyU4rFPqPQbTLHDfRmY8Y5gOZNRKw+9aRe+4
         xWv4BZGxBeGEHdJbqOykH3roKU1u5AWUGPA0egG6M5fc2kSisAGaHJuDafRjoXrzwmMZ
         9l605oe6K5IlFtbNUnp/YzN0FhLbdd4gP7Cx6k481U4LVJwWr2+H9AvRvDJ4x14+LwGD
         Z3pEYgB722ZdAzxGyiiWFYk24YN6JuLptwcP8n2D8CBTy40dTs2bNO1CAnDJfWWrJXJQ
         KVW/4PKfiAuTtzKNLVGGKQLhMVdm79RVCk/Ac7aSWe93f+0ympTNq9UhUkfLYTflngiI
         vT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792654119; x=1793258919;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u87gTMnKrw+5wwB7Owh+xGxsBZeu7l24WbHaLHBaNMc=;
        b=TIJiJ3cciqU1DFPDWvCRp02JAGEEhvEQiocFhIm70JVXTLU3EmCmFib7/hk4KEtUWg
         1+Qf7UcQ89vv4E//2ZU+N1ohpwa792/TeTy3LdnKpNLmtUMtS2o9KIMNMuxMoQnh+p+f
         xDJRXczfaeCneDrYchK5B0hg+MBUX03XXVsJyb0x3+5C3G5Jr382W6HpF76oQyRi2kNE
         A2or33eGX/7mzulDYSvSuPhELQddCglzbO8zC0Nbk11qRZiQkB6XY0spEytSHVq7Zt9Q
         PYxvWCpKw0jNacxQb4cPaGKISMARNnrvokC+LzM8i5gpI47vp0xYaVtqNcDi+Zj2XydA
         UQpg==
X-Forwarded-Encrypted: i=1; AKwUvBwZAtni4/a74OneHnpNMd9kgS+RSgkh3ytevGbu5Up0jRYZSdJY9p8q/t/cuHUGUmKIJzEq/sMPmehLmw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0HEJ6Uv0JfcMXa62Nk7rAThFMTvqY6B+fLdxv+440DbyoaPPO
	WBKZMjJfpT/gO+ZowloYECvTeNG3mP9jmV2GbbwRROns5ctcbIUkp46CbKIl1X0G6JM=
X-Gm-Gg: AYBFou2AOwaacOZ6hLZMA1JAKTZVEJDUMQ3u5fHtIDFN18fMTqq7sBxtSHqy6XMqjUE
	+6sDG4jBa9yCWjYBvQmSuGEy71jhgULd/0rh/7W5N+3TG6GHnf10CM/ccf3PCYkHg4d4NJLLuBT
	jlDfI/iexLF/EcepYZz8mlemXDo7yQQTpBK4szAy0XaqjbZLZ+6ySX8s2i4U2WQTxtpAWUZfnCa
	YRRZh6ynSpALNXQ0BqI424qj0Xzp33wU5o8YhrhVIZhNu6zT9EZ9ktO+uLe4eqCoKib1/iC8+NA
	+MTFwahsAfKG69BgvSTS7IjAVhuPCjlr5dPuJXSGmUf5uk+4Sdis08WnDcjGGkRUvgs1+dCL9rd
	tO6ddqdqTuP2Z3kmYhJgFN4e93FB6gZIivjg6B592K1XHrfU2vpyjMt303pEAqWO8EmfHrI1fYK
	sdsP2tMKgDxX00hD4eOs9EVnPB4368jogPa46o8mVCRahQtiNz/LwY0X0HZAER7MPdxA5Tq52mu
	klH3VT5R0oXAD9TMH2TuIzyUHAvch/WbrYDkGTVjsYytHZhmgk=
X-Received: by 2002:a05:600c:3e8e:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a1fdd2c16amr86892955e9.25.1792654119089;
        Thu, 22 Oct 2026 00:28:39 -0700 (PDT)
Received: from localhost ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b37df4sm49911655e9.6.2026.10.22.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:28:37 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1df50d76efba72e33c25952a6ad8edefb7920dae8cc1c3f139c1ceb795f9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 22 Oct 2026 09:28:30 +0200
Message-Id: <DMB6UH6R51LW.1TRHK4HV4GGE9@baylibre.com>
Cc: <msp@baylibre.com>, <s-kochidanadu@ti.com>, <a-kaur@ti.com>,
 <s-tripathi1@ti.com>, <vishalm@ti.com>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] Input: gpio-keys - support wakeup pinctrl state
 on suspend
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>
 <20261005-upstream-gpio-wakeup-v4-2-96f092de4690@ti.com>
In-Reply-To: <20261005-upstream-gpio-wakeup-v4-2-96f092de4690@ti.com>

--1df50d76efba72e33c25952a6ad8edefb7920dae8cc1c3f139c1ceb795f9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Oct 5, 2026 at 10:47 PM CEST, Kendall Willis wrote:
> GPIO can be used as a wakeup source for TI K3 AM62 devices during
> suspend to RAM states. The GPIO controller is powered off in these
> states, so a wakeup enable flag must be set on the GPIO pin in the
> pinctrl in order to allow wakeup.
>
> If the device is wakeup enabled, select the wakeup pinctrl state on
> suspend and restore the default pinctrl state on resume.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Reviewed-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Best
Markus

--1df50d76efba72e33c25952a6ad8edefb7920dae8cc1c3f139c1ceb795f9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCatm7HhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOW
6gD9HrdUBVOx10eNENGmC87DdSVjcxmdzYuAxOfxX58o+lYBAM1LWM+m+3hSU4Ah
LmcKRriuYGDt5w/aDK/CIdWJS4AJ
=PCfQ
-----END PGP SIGNATURE-----

--1df50d76efba72e33c25952a6ad8edefb7920dae8cc1c3f139c1ceb795f9--
