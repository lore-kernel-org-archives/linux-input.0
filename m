Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1D25B0B2
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338379; cv=none; b=LxWa4mNRxRHSHIfTsw8F7a23DHnlP2R+ohKgo4kLWNTJS7W3vzSCGb0GFndu08p6iovcoIkZQkQvESpUs4WRt6cRs9p4I17Ea/3BIPI5/6gvm4JutyfE/i24qmko2Pvh/oC+XBF6NQiV5pGZizGD/uH/Zp/Ow4egzlR5qW3cqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338379; c=relaxed/simple;
	bh=x+DHXyBduh8nW5mH/RwXPnUoFvsJilmF8kF51mFs5s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIhRVtxeIcWgNVD0TqL0rsHhzpBhyjs1GDr6n8u+T2dd2SoMu/FYSEazKCulx8qo57TJpI8P9cY36RhCrg1aSJ6uVMCeeD+3A+dsk9wINFY/1iseum2B03g15+avAghj6Ci6VnVnw/CbzO9XLRIIZEXgxCD0lSuYofWvWtS4qt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAoFvKVr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAoFvKVr"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef616daf6so1828542f8f.3
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781338376; x=1781943176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+DHXyBduh8nW5mH/RwXPnUoFvsJilmF8kF51mFs5s0=;
        b=SAoFvKVrAPS5pH5h0ZFLSCLmSwG3YVuEo7AaEAlGjFjYkwutikYepsKrjR5SaDoWOc
         lbaQhNP+vsn1ZF779xqg0fWzWE//jtDt/h+JqEdJRQ1IqI/uQ6KLeeM7znpwDVOv3PqF
         kT+NyqubT/OF+8B8DmmCAwpZXgWpyIU8uSliUj8ccqbkw0VqlYkasucF+L/Mib/ttIPr
         e8QJ/dRWYv3jv51tp3DdHyUoh4n1E2MI+03KuSmXIXELgxMidRPbcG1T7VqhamlJYMKA
         ONygYnXihGL8EHIWhKuz304AnGotSvNQoszCmkPsyQ7HlaosbtKsd3sjfFuyBBCiasYt
         IjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781338376; x=1781943176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+DHXyBduh8nW5mH/RwXPnUoFvsJilmF8kF51mFs5s0=;
        b=mrHKs3C0gdcA6BOlraBcDrt1TULbaSxcbgcUFn/O4V4fuzMXuILPoyFK8maFCj+sTc
         W2YM0/7ZH5jwRZxraA0RoCubvFbRrWaw4Tr6Iamr9ndumlzd7d0uv95FH/cIRkEddPq4
         2Z11742+ZVeB2RvtEKhR7KLXzUNRjPUj5GrYe9eRwxbW8kixjyYqm6UZlBrTxK6YYY3Q
         nEdjc9n7CUDyFzwXQgIXyzoEGFKnCWfzF8xiZXtgVqGjvGnqY6Pos5KiuqSagqOojec6
         XK+4BONT19tBJVb4TolgHWo5tE8yj2N7nPawqciSKZvZTumWruJeGhlUz3enEKFWu1/P
         yeRg==
X-Forwarded-Encrypted: i=1; AFNElJ87OVWWDbRtJsxzWfOi6go2789iKmB6BFxcKjZI0vh0xgB+9FhsNvuLBfcsCumfZnJbDpHiiHR9kh9xVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylJGyV5kSsc8d6zlRTTwue92meV52pNntBCVMGkyQqr0gXjQLM
	lYUbEtzGulX4HIKp3mrp6PYj+d0PMtfXAkRn4SGJGPYZ60iFXjGFvLOQ
X-Gm-Gg: Acq92OGOLh0LtDLAH4I8ByaJ8/OHQQdrK4YFwT3z8b7WMUxO1brF+mjoVXgbLXBfr6h
	hEv+9Yh8eFuwHrklw0g9HO+1/KOA5GgLCbwDhtQD0jPCXbUSunN8aCujd/EUDRRB8eA3W9A8jLw
	m0QBjR7ZW/BN1lLJeaD3JUCFEaGnwlFp4d/yupV8AttYVgb4vMcPBqT9woiIepaM81czHFjd/ik
	gA3n7jWVrrgfZKrlq20rSnkjC240zyToKFfnuOjnLsLU5QYfW3llg5mFGiYhgiBRKQD59h0rQC7
	+g95NI+2s/XiriHnb78tXtM7EoCuwiKTN956/5iBITDlsnBZ0LiDAjbLr20uaKAkda84mmEl1sf
	Nb90iFGZBrv/3TH2IfFHLdV2DM+grFv4HQIJucISaBvv5ng7pIlEThe8M41ehV5z2Q3fQOUQ3fe
	ulJtEeA+eDv4eeUliYnCnjS6mLhuYXCep2T2iDK/2JPxiN
X-Received: by 2002:a05:600c:8b31:b0:490:e5c1:b8c6 with SMTP id 5b1f17b1804b1-490ec4b58ffmr75929755e9.8.1781338376446;
        Sat, 13 Jun 2026 01:12:56 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4b39e9sm88333215e9.0.2026.06.13.01.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:12:55 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Hans de Goede <hansg@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>,
 Lukas Schmid <lukas.schmid@netcube.li>,
 =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>,
 Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Luca Weiss <luca@lucaweiss.eu>, Sven Peter <sven@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject:
 Re: [PATCH v4 1/7] arm64: defconfig: Enable Allwinner LRADC input driver
Date: Sat, 13 Jun 2026 10:12:54 +0200
Message-ID: <sIT7xrHETBux3nDrv9ggVw@gmail.com>
In-Reply-To: <20260605070923.3045073-2-alexander.sverdlin@gmail.com>
References:
 <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
 <20260605070923.3045073-2-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 5. junij 2026 ob 09:09:15 Srednjeevropski poletni =C4=8Das je Al=
exander Sverdlin napisal(a):
> Enable Allwinner LRADC input driver as module to support buttons on Baijie
> HelperBoard A133.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej Skrabec


