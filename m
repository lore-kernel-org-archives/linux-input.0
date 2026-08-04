Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D0495531
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870057; cv=pass; b=hocAtk3xUn937Kfcd8G16W+nLSatbI5f+pmixqhmn1GKGy/ZML7rTo/QuTZu5cqflkITxFcQaTgzBiQwB6pJPCGiSuO3Mtvyp893uE/8gMgD8Oa9nbLX8SEVPpvkp/9USdTwSse6ynC2qVcOQT1BPNr0CTppODyaspJ0MNCTl5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870057; c=relaxed/simple;
	bh=/XFOYEBNoZSJfESMossA4x0IZOYiXot0R5f6spMo1Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ie9Mixm8mRuK3h7LNfXq7dhkVD2Qd+DKGdNwGwfRvqj2GWit6cWX+Fe+fSERUNtZpwoz8IG2kwBZlJVPN3bFZRqmBDIvy76Mhwa6c2qD60I46QloLNvmCzzvL2w4shi/quyyFRuJodRBD9lCv9GK8RfYcozuJ+xLwD7vfV/W+vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NefSuPrw; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NefSuPrw"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so169736a91.0
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 12:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785870049; cv=none;
        d=google.com; s=arc-20260327;
        b=l6lQ4da+h+PFj9JsiXhXEjqHlImh96EL99hGlph1Q8FHlvkyT49B8BfMYyqqTgf6Gj
         cF02GAjg33vCM14EBjxuOkrpu+CV6UbUCrr0y4ftllBX9jQ4ABh2uAT0LcOkr3GqmuT7
         tC/oG/W89iTHfXf+Q/sq86HI+fbmnJAh2j6ICkYIk1Ky2APvqawLtcFtejV4fm2kkWIB
         6CldLLmxQli+27y5h5Y/8EwpLPPV6U4Cq30CKH85l3/wr+XwDbQMssKmCK8oM+Azwun3
         0WMgEmvWmEprHeOv2kjpoZyVDkSlyyqwzVP+CuiaPHrtS4s1nXDe1ECYNG7cYnOM4gdn
         5Gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/YyqCD8BW4XPHRakH4x68/qGqs02sJDv65IoJPvWYwQ=;
        fh=I4HJkF/gbtl0wCFQR0XiD8kayou7AHHZQz5Ij9hebSA=;
        b=KQMeCyCf1mFieEkjBDWuOlte2SleQqEV2pKaZ4RXHkCJQHiVjb1SeSTM/bUR8+zEiH
         Xvx47E0dYv+JXoDrAjQikmceZMgdqeSbvrWhjatiQPztwwCUf5NBLdYulSL/rjFWKKj5
         CMtcq5RX4zUdZrRgqDBHOMl/5PDSBVk6cMKOROxzMimnBWj4r/7QoUeRNKMNk/JEmb1n
         djdIy/lSb5526N1LNL264+cDF32DPnCqsuHGUrXru7H73SMFzjdDRGzcJWhz7d4qaos5
         0A7DDNs9EFxg/IuECJoruUpBywYFUbSo8UVwY86wcI3eGCBKGR5cDjvxGmsbevf0Adfw
         w+Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785870049; x=1786474849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/YyqCD8BW4XPHRakH4x68/qGqs02sJDv65IoJPvWYwQ=;
        b=NefSuPrwRWmDTb7it8chd9kXRExY/fFvKdKTUFFk4XNM0+J7Xlu6IPpNVv5F3FUUn5
         qmTkE+a9F8774on+c/hl3CuWrVB/yMwiKPGxZDEyX36gdhxXRbri/6S9laQCPM0iD7v8
         yvrhKWMxW2464Ham/Yn95qsKj/IhH/tD7q21PbtMzmctLeVecGkZKsYa/j6FQfPXPyBC
         2HVrbnazF6uOjkftG0JgrXwtg+MgHAhw0v5MN4xo0wM7+Gj+uiu4E4dpsmm+kOCfv7f7
         KidleKwH98refvhS+hfOhVu+tLBSnsVxzG2P+5twSkEsz3RAcImHIcUuUokh9UOc/ajI
         Eh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785870049; x=1786474849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/YyqCD8BW4XPHRakH4x68/qGqs02sJDv65IoJPvWYwQ=;
        b=tVvKaeX6i9i563kZ2n1vcpgjFaf750Z+QG7fMr7QCgli/alZjT8nrcLfXpAMaR8q85
         oSS1heYRZEGrSqLqvmxiL7dRqR6L29z2NOu59Hvh1J+Ea6HxW3f4RMvV7ZD74uQF8xF4
         YKfcWx95vBB9WBa9DZt2/2xuZnlB/5eUmCjcvnCvzRIKRYrlsJBkBr2cUB5GWvraYZR9
         Jyp+R8IO8rzCUROEJ1SJvbpVFrTn5Bl67L3btDs428+0ZEzBIRSHZCwwB2UYOBh4xFuq
         9FrWfoCLFx2cVQ28zKhySfLE9QRRdsTQqPIkGXkyfxWQi1MxJNysN14P5IcG2pI8+DZl
         wiYg==
X-Forwarded-Encrypted: i=1; AHgh+Ros4yZdUOFL7ybPqPI3sohETH0CKs9g/VL3I3PcReFqSweE92cKAHWY4XVJCmd5WbMQcw5FrN/Tbu9N2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxS0dnSrjBVHKj+9cX+AgAet2oA7F/8qkiwTtFNXTMbWEYFWUu
	z03M34XUsp6aexHhUwLuj9f6OH3E+7e4Ct1CpotlWdkSLqrI64VBhboZWYYtG4VuLcMHsLKZJsL
	Fb3Q/4Uc0MzArSBc3IqQoLcOZinRTRh4=
X-Gm-Gg: AR+sD12FzEXsAFxPs+jLwrUkD2xR2lEIUMoTQUqwDbQbr827UURRb1jv+zfpP/4ZMcs
	/u7MSIfsUlPCCfdzZfBEXaenFLFBkarLCC3lFTCeH0uyM8+Tz955WMjtmpdiLJ1Y04PryMEP9Oe
	878XeXSZoB9L5aRyTtV+sIebs6YOSxuxF8Nczm4cIEuHHNJNzvykmwJUMm8s0N40ha0SLR9yPni
	brcOaWQy8OJdR+o4dMkUlc+IqeSDoTXEB50A8Ou5U9Lg0PqAQrQt5dO+Ova3adL3znTZzDuIVHz
	1LUonOCYZIR7wJWxAncr7ml4BDgK58NaffySS5DdSKPlB6A/ON6q0RYOg+/ly82PlTw6zax4rLG
	VF7RgfZ+PSGe1e6v+PX3b9YhyZ9s=
X-Received: by 2002:a17:90b:5112:b0:38e:542:6485 with SMTP id
 98e67ed59e1d1-3903c5919c4mr924860a91.12.1785870049156; Tue, 04 Aug 2026
 12:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com> <anIhyHL4Kl-DX2G_@eggarch>
In-Reply-To: <anIhyHL4Kl-DX2G_@eggarch>
From: Jamie Stephens <jamie.stephens@gmail.com>
Date: Tue, 4 Aug 2026 15:00:37 -0400
X-Gm-Features: AUfX_mzKEFWesy9_PyKm-5nbf0o3VldJqhUPwpqyxb0HY0FLUd51o98kcLYGN30
Message-ID: <CABWMpWT8fGTVABdi6KF42UTmarneeBQgYQfCVj=09jyEtHS=rQ@mail.gmail.com>
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, regressions@lists.linux.dev, 
	gregkh@linuxfoundation.org, stern@rowland.harvard.edu, 
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, will set aside some time in the next day or so  to run the
patches and git bisection

On Tue, Aug 4, 2026 at 2:56=E2=80=AFPM Lovekesh Solanki
<lovekeshsolanki00@gmail.com> wrote:
>
> Thanks for the report,
>
> On Thu, Jul 30, 2026 at 03:28:02PM -0400, Jamie Stephens wrote:
> > sudo lsusb -v -d 0764:0501
> >
> > reports:
> >
> > wDescriptorLength     504
> >
> > Warning: can't get report descriptor, LIBUSB_ERROR_PIPE
> >
> > cannot read device status, Resource temporarily unavailable (11)
> >
> > As a result, usbhid-ups is unable to reliably communicate with the
> > device and NUT cannot reliably monitor UPS status.
> The lsusb failure and NUT seem to be seperate, lsusb failure could
> simply be device property.
>
> Few possibilities I can think of worth testing:
> 1) It may be related to LPM, the device may be advertising this but may
> not be handling it properly.
> 2) Commit 8020c41b39f5 (usb: core: allow ACPI-managed hard-wired ports to=
 power off)
> lets acpi managed ports be powered off even if hub does not advertise
> power switching. The UPS may be sitting on such port and its power could
> be cycled out and leave it in a stale state.
>
> I'm attaching two patches to see if they have any effect, please apply
> and test them seperatly and let us know the results.
> And, as per Thorsten's advice above, run git bisection regardless.
>
> Regards,
> Lovekesh
