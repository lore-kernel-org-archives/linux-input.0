Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DB3859FB
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504609; cv=pass; b=a7tD46rzbevCJENd/R9id+lTUs1VXMa6OQ3uDYTs5evxk80GIdcM8X2+ygJGm/T1QYCg8h6XAcrszEfwA9Z9zzNbBqc6hxje+V5Nvi054jwiSkHDChPPb0CejmwcVsA74yTkfeU4syTnykdZS3a87uENIvwOJizXyycKIhOrcc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504609; c=relaxed/simple;
	bh=6RrxEbtdY1URcRhqUHuv6rRPkusZoYqTLT3CjAAQOGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS37sgcFHZBlIbMI4g73t4pPQfjSId9zAkFlVXgEwcA0Dhv/fYhGAV39iGUuOtgYuza1yY4F2YB08qAqaYRyyIkQ5Ud4CdQ+qGp9tvwRiwFtjfWdzhGkMFYqcJaBLERDhgMoSVfrwJPQxltj1CiYQgwvio2FdaOhXmTueGczA8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6/470yY; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6/470yY"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30749947917so453401eec.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 23:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781504608; cv=none;
        d=google.com; s=arc-20240605;
        b=Rokokb2MGlHLrzGemnO64KQqoHIPElNHYCFX+jK5n78L9yR8b4JG8S5bAjb+ztXirN
         5fhggXVkwu54f8BB+qr3dErrITbmCoqFQxnewKxa30G/4wGnsEH3EOuHbGblyL6/oQ6s
         n9uiHTAVygtSqfIfNerEc3PiMrKJu3I/X6Ka05K1is0nQ4bEEXF5HzOvDTLLsIL/xfG2
         ZIKy9A6EFVtWEocUgGg0lCMi2MVYTgStW0TCNamJcJr0uMWFw/2eS5ig4P+gWmMp8IS9
         c1APxLiZvoFWg0Cn5kI/evvSE7JuFTrhsv1Z8lap34mNBe2piYK8VZZFPUO+gvlghjMp
         CpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76EcjshEI0S52XWKwaYtOS0vh7v35QH2XSqyWXuOjik=;
        fh=rNUX8YVJRSLb7ZZf6vpD8Q8zPyXiJQi/Qe5MOEvagb0=;
        b=Zm/mH9gZYyoAJ6zHI8VdsyKht1WBJD9JYJ4l5ARwD0Dh3LU1pJ0ojBH/EOSwQyukY9
         tjVpW3D+3DO0YF7aeEIICmx+E5Wfs39QF28WQgLILIPvC5NYa2cTTLZPMWj3nULXKtWc
         2EoiPXRbUGDnP41PAYMctKD/LeDr/MI66j6DGtPcDhXTlpz0diCmyFNabgpRYnbhhQ2+
         0d8YcMX0f2d3xth2cUznytM1Rdr8/Ff8NvNXQyc277UDOEqmlGcukYKsw8M5zx5Jw/1B
         X5PJ0riqR+po3di0FH9FwNQpl5hXvtf8WuQ3T4uH+A69lSQekdSOQHSbQAXCI4ToAXfl
         KIrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781504608; x=1782109408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76EcjshEI0S52XWKwaYtOS0vh7v35QH2XSqyWXuOjik=;
        b=l6/470yYabGu6XgvM5OFyCNHNsAhvW6UJ4Siw90FNHfR3fvG+Wlux3PZPKM/ki02sS
         WZ+rhn4nFhT9cxcq8Ymo2usB1z/IJxQGtqsxPVDNAfCnhN2NqPoyAOkxywhZRYTc2Yl6
         aGhHgsUblQwTZzBuykJBzxWok4HF3USQ4LSvHr1cwLnrdYsp9gm1SZqV9JuLA9OhJAFS
         THwcGloLyjqtvfUmiF5A1qqRfV2r3oPfvk2VIGyUeNUKJj38+KQK1/aiHMu1J0ekpwrs
         7JguB3zU53LVT83ZAfLghEE8TTaB6QChcwY9tDxiqKOPG/JEeIBWRm0c/DkobKb/7Uh3
         t85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504608; x=1782109408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76EcjshEI0S52XWKwaYtOS0vh7v35QH2XSqyWXuOjik=;
        b=jED2eZnPph3uv11J5ylav9sdVR6UieFZi4NYS9CH9nJwO/22wjka5WCJ+fQDpO+gP2
         9C0Q6qaKnI4sjFQtqF8JsLBNK/fLR0u8+KRuisS3A36eLyeUKBSiyJLdjKkkThHTCKBu
         4CuD18NtdPWYe/VD1fF46KROrmkGhDm7NQFSYYsmufsithnmF4q4RqAy9728EWR4nMlJ
         iCJz4ol73yGkDuDfOd+gFLPdvlqWSQAvmN90/QJVSYmPYtpk3HNfXfZdhSnKll6QLGIe
         HfDiBr8PMhvelxw4OJjeNkQKbBpUQk3pO5e3fDqcyoI+wYfcZX5gNHKBCXucIof9VNse
         /08w==
X-Forwarded-Encrypted: i=1; AFNElJ/0/PkQ6EiJivn515qI0MPVXE5jaJb9N+KtRQcRKoOLJ5Xrq+/s9e6mjJghKg1amo6i1U2zkVpL4Osw+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRy0z3jPrXA2L+p0nHjN+ENIw3DgAdILgM+2XzQ5yE5FgoCugs
	G5h7YvhGeEIkvRkWiG5OqXEKxEsIvjr37hZ1ea/Ln7rCEUtulzfWnCTNGVhFuRwS4DV6klZRRcq
	qP5Js6XBL5LPBjQv4Jr1yYCIw1pJ3a6w=
X-Gm-Gg: Acq92OFlOjKewKzlD6cc2URoHQOmV9cuYpS8gI9sk0f4ivHGaCEJyZe3COWE9hEMD5a
	WISt8tJKdOl3BbEh+LF2Chr0vVQWubXhG37Uz/pvzg3sA8YpJbq5QikGXeTZ5uFGYo2qQGL+Hlk
	uT/3lFzQ5EMUvOJLiBOaU1T+YpdY3PWeKui9/PFf6aZuGwhLNCs4Cm6juNtxANoS9hjq91CW9vr
	cJtunmth4KcZt90hqrrSSs+vb+W1sk8hDWR3HhUr3yb5buVHbvwzoVfcj4nO+gj/j5yOS7Zstn2
	SLoA52Ca
X-Received: by 2002:a05:7300:3723:b0:2ed:e15:c922 with SMTP id
 5a478bee46e88-3094197a175mr4911122eec.30.1781504607592; Sun, 14 Jun 2026
 23:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-5-clamor95@gmail.com>
In-Reply-To: <20260528053203.9339-5-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 15 Jun 2026 09:23:16 +0300
X-Gm-Features: AVVi8CfYtPBR17uEYmSCkdqsGtwveF8FuLfNiOAFFFOH2flEclU8yKRNkxPiLtw
Message-ID: <CAPVz0n0cgb=ht+uW9+g8q9524BBQdPLNczK_9nSdrk=8kZSV7Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 08:3=
2 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Since this only modifies codes sent by asus-ec-keys it doesn't affect
> normal keyboards at all.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig                |  10 +
>  drivers/input/keyboard/Makefile               |   1 +
>  .../input/keyboard/asus-transformer-ec-keys.c | 286 ++++++++++++++++++
>  3 files changed, 297 insertions(+)
>  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
>

Hello Dmitry! May you please take a look and Ack it if you are fine
this this driver or tell what I should adjust? That would be very
helpful. Thank you.
