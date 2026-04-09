Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FF26B2AD
	for <linux-input@vger.kernel.org>; Thu,  9 Apr 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762269; cv=pass; b=tSFNUOsF0wp9/ygM3lcHzuK98xynVOLXV1fhMBJEiqV36q1l39p0vt8+4mF5IAMPwsnSXrcvRQ4EOumTgDKgsGiL4JNm7gkJN1mOmpYfv/bNHD0WX5uceJZU01OrW9131u69mzUll5zr/y0yr2mUB2EMLUlwzVM3aXkPKCOGKIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762269; c=relaxed/simple;
	bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RffLi8svbj42sgqetJjv1qL0m3q5qldFF3zPYQuczBi8+RZ8JJRZxk1kyODY1jzCFwQIeo7NkYE0tRG500PD4VwbGTzPnIV6f4ecUR68mVegrl+gV/ddzvfyTfpBhpXuTOPQDZ4hDFvriM7iKv3uB5fnyhdG6UIXLFJ36AyhyP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRxOTARa; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRxOTARa"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso164655966b.3
        for <linux-input@vger.kernel.org>; Thu, 09 Apr 2026 12:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775762267; cv=none;
        d=google.com; s=arc-20240605;
        b=eTtDAgBoeOOWb0kRtJGObDK6TUQ9PBybF6LpyJyLmmaM5jOhgmz5FvwyEh1LyJ3dgU
         WS6HLK5X6Ii8LxKG2TETW+VH0IPxul4gXIqwJX6iHNmHbLoGykFINBgKNWNEz1TGxfL0
         VXCYrsz2kyDrC4m63vtOl1vnJgWIVwruNi/xyZwRyoO4s9dWValwW+e2h/hwSxzHvfnm
         1yomG9SnNnjKsIBSAmEpg8GwFQ3VBzoODpvKQP2IcsfCamOWovrkxGhP0aRgKGDA9+6w
         6NeextwyPlsfOzrtXQujKQHGqbCSo6gRxJIQ607FVik5NyeHZwqsg9Wg+TxAXNjec4Cc
         xz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        fh=04nkHyL6iFwHDgtpqH4XEVZDBHCqiMxgZYS5jaOhYao=;
        b=kpl4R1xAlgW8KiNv80hvqCpYgAzmgoAvvzbv/iBC/sMrvvpeFyWKNbmnqQn62NKHfg
         T08Tr+Pds/5mj4AG7HwpEkDsxjfe9ngUd+P/yDSTt7JKmNJctYJ74AcTUZs7qxc7ct0v
         /7cFFa3knHm2cPWLYX9IobFISY2i5jdCVLLrqtSTs6gsq3EK38cN3tTq5fZ3+Z3k7i9c
         bgVPXPpjJZhRZPZsozxSNF7TwlMZYlmmHLkBhDc51igN+aD4HUJYPv6zZdk5L1IWoBl8
         2uD2P8rJvU99hDTVS3xPXdnX9Rv1VnEmQmTnUggBQWKNrMg7CkCSX3ohT6BQepimnGE5
         JFKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762267; x=1776367067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        b=mRxOTARa7KEK/i89Nt5wG/esGfHtqRc+wZKzGDt8l+Mf4F47U59XvNjN4jbdK/lFHs
         lYSqDbgpTyAUrkAZHaUxGbQdrh/T0yN9u4CKjdu9DO1Dw5kteYdPnsZyZuLjsqzLj2Kg
         eyYANlMC3dKz0kCiAmf1O03gdy+XLwwslVsH7yXxfYAyizb5H1rFTNW3AXP2D+7lGJor
         7bZ92RNiycke3zY/JjVCA2323jSIetsrvz/M7e8cquGcTetTTtvJQzoNLyXnOMAr7cTH
         2eZvN4UMtNcAbLACq2RgzcvU9uEqq1vjUsfx3/69fDbKzretMvMRgnzK5Em1dmA1FoHP
         rfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762267; x=1776367067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        b=rZPHB/7PJXuF7NHMTAksl9F5bbJwYf1iEugj0rNoOFJeeBf03lNzkusu1JDyB0sgwp
         gk4mrS8joK9SDd9VRyg3RK2wL52InTyA+zwnX2GRuXcNjqUr3wT688mXhyL+TETYDQF0
         GT0j/CCB4PDX89XX8VgL1p6X8T1dYwtxafYsW6goHqWYAp1Wn3/l+N7HO2/54iIB4K8v
         0IhfQFKltWRFg+EsJ9FjO2AQyL9iddyT3KJX9l4b/pM+/pjq3sVAZX/CxuwyFORotNYG
         Ak85NEEgflDjAZs+ibuESF5+/DutHBvIWiMi5J0yWrjzNZOANB1XE/RVeuhQcEUD7Vvc
         dEhA==
X-Forwarded-Encrypted: i=1; AJvYcCUX91yf0DbLdbNCeOCyPQBs/hCG2BCmcasDy9UzxHJDRPRHfnQ7SbxDfnRQ2iR9m8tPwvX78pw3tkISsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXA2vnDH5FDBoPGK4UNu2lDEPw7ariAYMDlSrVQlI4jjaK/t4V
	6EyKWQ4pwOEAL6Ux+iN37+NuT810CfqTn/2kxR5EL+rIPdY7SwWSvdy+qWUVxk6I01EFiLTydXE
	ect4koa7PenY56iRynVcqCrr/w27e1h8=
X-Gm-Gg: AeBDietBZhgzeQldg7+QD4nVrxFuhjUd0jXH8SvCyUeNff5F8kgfqcFLjJZJDZzOi2h
	BtENgJE5jZPsSo/wVeqLt5+ZfR1W+yLYWonb7WLgeCCoHlDU5bVhdW2+OnX/EuyMda8EEg6LLQQ
	O0cOhJSbwpWWRrX3C/zQ60B4gPEfiHdKzxKffnzsSUsxT9bEmNWTEELRC1gEtnn9KkEs9yfYUZ2
	iTYdRkyZ3ofvpMnIhvvwY2cMIQXQKJV3cNRRW0gOsHbu6UF5KuChC8Bz6Nda7mGJNtEkMA4fPwF
	Vo7SkgweT1by4GxzmA==
X-Received: by 2002:a17:907:3ea5:b0:b9c:80d5:f01d with SMTP id
 a640c23a62f3a-b9d7248489amr28294266b.15.1775762266312; Thu, 09 Apr 2026
 12:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
 <20260324201858.46591-1-sebasjosue84@gmail.com> <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
 <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com> <7qr72215-4q40-qon4-808o-7o639qq90q3s@xreary.bet>
In-Reply-To: <7qr72215-4q40-qon4-808o-7o639qq90q3s@xreary.bet>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Thu, 9 Apr 2026 22:17:33 +0300
X-Gm-Features: AQROBzDUKfzKx0I6op-NC1K0D3CmW-7Z4_EpR32Zz1oP0pvTVWsGpsyO6bE_-Mk
Message-ID: <CAPnwWgOMNxU+vPx2a3aX4DDOMiW76sE2enVfCKk7gP+pSsoXgg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
To: Jiri Kosina <jikos@kernel.org>
Cc: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 9:29=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>
> On Thu, 9 Apr 2026, Michael Zaidman wrote:
>
> > The FT260 uses different report IDs (0xD0 through 0xDE) for different p=
ayload
> > lengths, with each report ID defining a different report size in the HI=
D
> > descriptor. So yes, the device can legitimately send reports shorter th=
an
> > FT260_REPORT_MAX_LENGTH, and a blanket size < 64 check would break vali=
d
> > short transfers.
>
> Perfect, thanks a lot for the detailed writeup! I was rather suspicious
> about the bold statement in the changelog.
>
> Similarly to other Sebasti=C3=A1n's fixes to various other drivers. This =
will
> need more thorough check.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

Indeed. The original patch would have been easily caught by testing on actu=
al
FT260 hardware - short transfers using report IDs 0xD0 through 0xD3 carry w=
ell
under 64 bytes and are part of normal I2C operation. A blanket size < 64 ch=
eck
would break them immediately.

I'll submit a proper fix with per-report-ID capacity validation based on th=
e
HID descriptor.
