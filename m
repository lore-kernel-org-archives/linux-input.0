Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF573B100A
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504739; cv=pass; b=G7EKO1JIESSvDqTOKwrGpVWYw6vnGjRgMtxBLfmgcqLn2HyB9iLb8bWRET6E7+AMa4xT1Zx3nntywPIeAXvYlxFmazJeTDVpK6rDEdVJor40+6LXP6m4dFW/sOQCxOyw5+CMp1vSDHeWcw9qJZFpOHErIwsUvcgpCbq4/iLlsFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504739; c=relaxed/simple;
	bh=cTBQJdmyijZHrpb9w8OjvsAHRwSnSuXQJu22SvXmwsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVVazHO8dbQ8920yXGs50LO1LukhZ2yBi9hFHIIbqPYeXPzbr4rTnrEypE5w4pCiGPj3Klx1OMvw7poynNA0VUhzBR20YvCxcv4JMGwsZ92fHdvfa5mSXiTNmx1Tu7D55EJv+rMl9IGdm2GKP+lqErqS0QgeeMRJWZj6Y7l3iio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTMHsIa5; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTMHsIa5"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30749947917so458020eec.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 23:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781504737; cv=none;
        d=google.com; s=arc-20240605;
        b=RHAPu8RgDsF97nEKTFWB5LYLT7zlb6aOMQfQE1hDP/wuxXoQQDEJXckwzScJsDtX6y
         Aj5ST72X+i2G60k76wlCZtB6M///+yyzyFinm7BduLayEQ7ClvlRd+/aNkc2I8c6koFF
         2mjW1+eHC5f8FZkncF0N26hx/Y5DCvmOcaqJN1lkI+PqK0Zf5kHg/OodgRjKOdaUQGNl
         W0Nltre8cFsbubsJHu/PMu7zRQNYsD5RZJvEym5l99oT+9sAgqUDzKbj3nbLF7QdA+3o
         yJhaw9FHUkiop+RB9qOxag7qdWuRn012lO4ie8D82SHCPRFVZvjgPMpsDH+CKxhw2ZCk
         pltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTBQJdmyijZHrpb9w8OjvsAHRwSnSuXQJu22SvXmwsU=;
        fh=cpZoIa42GEZgazxNTlXp7DAf6btJ1LtLQLt1NjEp/y4=;
        b=G2BLQ0fNxmSsinaNLcBM7ognKr2x4nYFmrfXdf0UMxU0lCEv8Q2opOhqj0DjxbjTe0
         eQ+Er0V05mTZsSPpd+oDqUeF0JAXDva5J6zfYoLUYxmtRmhEyXmF1famm9TunLKQpahN
         5c+w7FbXIwGDMd7J5UgXBnxnYYEAEn+cieSj3vP3jhs2oq+rA4XvxML4CEbAVG1dAi3v
         jF56nYWuE0CU5h9BANtQumR5UJJUZCLssNeDzzs44xyHCsRgmMdPhyBxM/mqto56NJHj
         1lLi8ZofyGX/7ZlCkWU1vtYpAk3oT77XxPzRb7xM+oY/XbCxbGDk8nVAMiL/k0Zjn7Fj
         WUmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781504737; x=1782109537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTBQJdmyijZHrpb9w8OjvsAHRwSnSuXQJu22SvXmwsU=;
        b=cTMHsIa5P/7U2nvFp1XtT4YU52P9TZl+jkyLhai9jXpPqmHGWWivrdB4lNMpD/aIDw
         oMTv+HKPnnWV11vmD2KxwZ13u6Cd4ZLlVWCK5CqDz5po2hb95mjRYg+FohYJCQoktGRF
         0SzTvDsbhwIPLb9Upp9AKKAOlE2aHewDTeFX7rVP+mMwMzEdTTsXs4PB9pCu9V+8g+0j
         1VKTho5e/u7Yb50GJy3djZoDVgWFQehJhGJpedTZ9BqMA8/aBbGQ8dfVByHyUOSNLM0m
         5jA560dDpYP+g8y0BE99TvMmltMRBljwT0b/hg4I/za0XBU85tqtyaUFrNyKiumeyegJ
         QZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504737; x=1782109537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTBQJdmyijZHrpb9w8OjvsAHRwSnSuXQJu22SvXmwsU=;
        b=UqPQ/F/gpzd8kUHtCZZWfvnp9u0G9EuaqGyv1f0SmvbO5jbbZPSCQTIqIKImKqwZrU
         e9NxVBtBEnA4cmtzIHpz1zYih/EBh35vsKeHcSTQ02CdTbpiRQnKdPtw7UpJKCpNKqa8
         7zkV7jX2EEOrl87ZEp/W3ewNTRQBSXCB33rc1/qMGDzFKBLq9uzwb2iqpndvLVKT9dZ0
         RFv5dhF1LDOCSGd1Gthj+kjLydAOvQ2Gzvs0JUDcArBFXGKQns970biB/cDybYCAQsoH
         E+f8trPRiSIWKa0vZmdjLyg6nn4cz/BsuTY2r0+vojX+H5CmNRgFmuoKs+i3Imr/kskM
         lttQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lTTf5wkEZYWKeke+oF7Q8tqHNfy0383Lh6YZCNliYFfYQE7OvWj86m12XVFSw0obvX5mv179Tis8m1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTrYW4rwAkEznylaj0swz6AtOBhQStExfKII4QZjXuB5bjGyA
	89+yWnwMYlE3SAKP8aSai3T8zNyzN+Yj9K3UcUE/Tdc1SbS4pr3cCoxLz82tZnKLLeXsQTzNLHS
	oLr1EsL02AxG8WPoDG899eslWz2FHMv0=
X-Gm-Gg: Acq92OGDNuzQX/0LCypDCi+1Jek8xmlquDq5WMq/3gmeb/xrj0zg4JYLrHuMOIDKFD9
	kyO4DSj0+WlXAkKxOrmV8ONxrJHOqPdjnVsx/UXHf+Jh4Uk951ktAjLV3sPXyiVwVbXfiagrY2Y
	BEx2VEaSCn+N9HwMnUSiHWblE7rtEytXeAGpPPf69l/P9zjINDOs0bjQR9xg0myF5cuzjhIY/HL
	9uOD/gKN/U8Hp38hRIkrWP41LJ1mbw99HTwRlWyG+j2cZDCpxyEYU/RibCiENRV1V3O8HYi4hX0
	12PSeejB
X-Received: by 2002:a05:7300:2d09:b0:304:3c33:7ad4 with SMTP id
 5a478bee46e88-3093a514e9cmr4694274eec.13.1781504737180; Sun, 14 Jun 2026
 23:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520182124.117863-1-clamor95@gmail.com> <20260527151432.GE671544@google.com>
In-Reply-To: <20260527151432.GE671544@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 15 Jun 2026 09:25:26 +0300
X-Gm-Features: AVVi8Cfj4CFtRay_yHgb9x-k9rdyWbOqU0lnoe6TjkW8GjWPr84WyPCoGmkU928
Message-ID: <CAPVz0n33PRWgLHqaD_wVr+Dji+22Bm2gCdA1cSMLuKHYJ4T5iw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] mfd: cpcap: convert documentation to schema and
 add Mot board support
To: Lee Jones <lee@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 27 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 18:1=
4 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 20 May 2026, Svyatoslav Ryhel wrote:
>
> > The initial goal was only to add support for the CPCAP used in the Mot
> > Tegra20 board; however, since the documentation was already partially
> > converted, I decided to complete the conversion to schema too.
> >
> > The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
> > from TXT to YAML while preserving the original structure. Mot board
> > compatibility was added to the regulator and core schema. Since these
> > were one-line patches, they were not separated into dedicated commits;
> > however, the commit message notes this for both cases.
> >
> > Finally, the CPCAP MFD was slightly refactored to improve support for
> > multiple subcell compositions.
>
> Once you've fixed the DT issues that Rob pointed out, I'll merge the set.

Hello Lee! This patchset already contains fixes Rob pointed to. May
you please merge it?

> --
> Lee Jones
