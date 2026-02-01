Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25792D2491
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929314; cv=pass; b=SSSGS3KXiILlEWERCnRIK1y42GTqLDFbkxyvcUIvBc4Zm6d5ulrgV25wS7hFilN/bG74qcEFXzXifhMSuxrVmjpSKG2/LRauCYqzWOYPOjlIMjPdQyQjanc0XhM7muGLASdmoFZtIMl9d6CoEBgjL2lXc+fKJOU5V4GDCl8vb/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929314; c=relaxed/simple;
	bh=bHSVbRQDobR7C2o5P+eolgEypYFQdOgjv1IYhW+8fGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5ZJQVon+Hr5KHmgqmlEqyN5SxAcDyKhIjc/SF21RQ3BEhjAJPQWvZqvD2H5S7sYTLUMR+QUHl6KdG+v2o125VYGRrRCYNiOyDkmau7h1AHxgxmSv2xHpaAjZrd76l+eRXJKokA/YsR0P/LG2kcKwqxKncDyZJVCK2PdWr7s0M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBKejBmS; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBKejBmS"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so4611170a12.1
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 23:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929311; cv=none;
        d=google.com; s=arc-20240605;
        b=LA2XMjAatEYZFWzZEeMstd6jYAUbUg8/sHJXd6CnfNns7m7xHCTGd0LGEFePkf4tbE
         ADBE7gV6GBio1HrxPKt0D9gIWkcF5BXq6HFqZr97LYi63k4gfHD/ghmC18W/vmJyD2WV
         uhIrRFaPPHsdvrR4slFmqTebFZNBnvmE9Is/Sbh+3Pd4qtbszidQ4f+VcKtHQxu58gSf
         anAVJbKPmpNO7nUgS4roW4CuUd+coHada3hEvOiz62jgL+gACzkOuhJcWmk+NG34lWQp
         m+0Ac0OxYQvS9bWP3A0KLLdxXYZ5CK5Z23F8AVkRwxPsUv5XJOQsyCCILfOXCJ5ersvV
         uR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iAWzb9BbFNy/4m/w6Zwd+njIpZ8M14O9H5IZPS16EzA=;
        fh=Cyt3+EfD860K+O7qVTSkd8LjKOAN6xPu1lWytAVPt08=;
        b=MmrVFNpumKEQAkK0oosRAE5dEXhm1KmKOzM4SHJ/p/Q9wYdI022/TbiWuMhbXIcv6r
         dwcLeqJM7zvw17QuV3xse4191Eo99tseG+nI97hS302+VMBRqgTWc4oqJwk+1pmUdIXQ
         FuB2ViqKg1YiZpYJFStxVrQh72GLxpUgK+ygJW/9sA/HNQgIjYp2LB0auZo1ABLXc0bp
         Vi9t0i1ynWQSWd8+ZF5fNRn+lU3Y7PGVi5onb4gAJX6/SA0w7dQNOYbbXLYHEMoyyZdL
         en5pYCh733UVSyTcTb+aVjJAYIfwM31Uo9+YBPUeejzgeltt1lLIcv77ftviz49L0+rg
         4lMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929311; x=1770534111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAWzb9BbFNy/4m/w6Zwd+njIpZ8M14O9H5IZPS16EzA=;
        b=JBKejBmS4EnrDrrSgo2TZcaWiwNko6dejhSRpqB3coSugLXxkgr19crETgfRrA4ZSE
         oBeD6xlYTYLcRVe2j8yQARiozYUaqztOdjRsLRnjw6x9GbRq/pcR8txFh+Rq9MsR7Bvq
         euACVxPmpd4Isp2GhT0aYyLA09r5034g7/jP4q7uEbA7mFfHOA8o7JzdvcKNESIbixqx
         Fhbqy4+MS2BPYXyhurlRpX1od+D8JrHooCPqHJphyqFoq4ML6c8cbhCeMY5Bqk99Mayv
         PgrnLN9InlhN6UYWN7gwPNxX1hX7WZ99HRl74jlgql3p0F0F9SZfHUTQo8XsqafLeuRN
         F0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929311; x=1770534111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAWzb9BbFNy/4m/w6Zwd+njIpZ8M14O9H5IZPS16EzA=;
        b=hVfMPyMrPpGA9wtw9MRd2K12ur3reubdV/IokhFijcH7zPI+yR4MtQq8b8bqu7X7si
         +vrM6+MwHrClZH9QTY6ITYesRRWFz0QOglQdAzM87Joo5dHi7vPk+VOw/kZWrMSUYfgQ
         K4o0t4by6hGcSx0Jhn5sWDXND8TTJh1hM/ouNQ6uQ0QeE7v63m4BU4r6O1X2mzuW4Tzz
         3LVfEJCMuZE189HZr90850sTergH3+hkXfmJF9QbGgdjU4qgCOvcjJw/hpo0Mglho9FZ
         EEflYdAQc27oq8YqSDdR3eYaBULUkWxLEn/eUI5W8948rt4j6AScduFzQmMOMEpj4lCU
         44CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2XaYENeqMvak/NYNiKEc2jYKbEGuMMASBmINUcPjdew6j7/xVa1k0ADzmsBsCtCQdp+xnBwyBCLHgaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+18fkcYF5aaMtigq7LZeWBqpGfMWp4Ocf6nEluKrApSA2cJUH
	1OAiliro3buwC+z1hrflrF6ggsJL6jaTN1PZ4/j6iY/6kShu92roFDa17zm7w0O5Dc/OQs/30xz
	ICGMXxBFwJTc5o7/j3B/k8i+n3DlvMe4=
X-Gm-Gg: AZuq6aKW1fDw6KXnLhLgNg4iTqjd5WQKg7yal4dWO91RxRfIJSoqVvLhKFwE7tudkE8
	js2swAvmKc5CepODGmrqpqLo+lZQD7SqW3M3WTByqhToWitrjbBaqBXUf65MF9sL0CiyOpgIVbP
	qWGd4XT4/dHX/mHZDPmG2XfL7MVuJJX9NaABArmAeqE3vMy4aojm3jkZ1LFvDUEUnllb1ykRGXJ
	D4NhvIwOzk9gK+jKpQWOP3aUATvl84XUSIf/XLrPz3o/QIPrsGpO4nblZoZ+GqU6dn/3vkm
X-Received: by 2002:a17:907:94d0:b0:b87:1839:2601 with SMTP id
 a640c23a62f3a-b8dff6969b7mr517593266b.40.1769929310797; Sat, 31 Jan 2026
 23:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-2-clamor95@gmail.com>
 <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com> <8cedbb9c-9f72-43ae-a23e-705b3feb85fb@baylibre.com>
In-Reply-To: <8cedbb9c-9f72-43ae-a23e-705b3feb85fb@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:01:38 +0200
X-Gm-Features: AZwV_QizrzJwmFJ9K3HDRK05t0a_0kaNB1Vjer8WbyjV6HsHfDqBvgFrLolg9pY
Message-ID: <CAPVz0n1uv=2Hhue2zjnXdG=_PyofBBqEhdU+S84+ysYq2PV+qg@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert
 to schema
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 21:55 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/31/26 1:46 PM, David Lechner wrote:
> > On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> >> Convert devicetree bindings for the Motorola CPCAP MFD regulator subno=
de
> >> from TXT to YAML format. Main functionality preserved and added compat=
ible
> >> for CPCAP regulator set found in the Mot board.
> >>
>
> ...
>
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - motorola,cpcap-regulator
> >> +      - motorola,mapphone-cpcap-regulator
> >> +      - motorola,mot-cpcap-regulator
>
> This is what caused me to get confused on the order of the later patches.
>
> motorola,mot-cpcap-regulator is a new compatible, so would be better as
> a separate patch.
>

Rob already cleared this up
