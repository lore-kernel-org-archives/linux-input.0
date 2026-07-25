Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47E30648C
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985807; cv=pass; b=MTFNLAJYd0CkACBBTinwEN/TgdyclgzxV/OP2jl/xMD18YkE0dqNMij4AVO/Q13Y0rt8Q7wXBx08ndNcEH43rrRYMSUVfqu7t8ct7/erSxipH/SICQq6xell+23/SYkTznMAcZtKhe/vRK1U6uVCs35iRjm5lvldhiWwvPct7Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985807; c=relaxed/simple;
	bh=iyfAphcrJGor91FmD7IGYNutyAxV9/ncvttL25PE830=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7ixAMCrfpY+SDbUaSBmEoNCjWEV4pLr0yLDblIVOFqzr/l68mZCiEWN2s9ElMxyZVMDyIM8wKdyWHTzNdPXj4V4ADwDe7ci1SmHjsbP/B0HKGHhcJfYlHVJz96Gi1XUKoVn7TZSmaQNVvh7YgHaOTRhzSBXt3rH6LMFK3i/DGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwr4tQOP; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwr4tQOP"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb973e6749so1552081a12.1
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 06:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784985805; cv=none;
        d=google.com; s=arc-20260327;
        b=s7bFaAHu47BB7BczA55c2ij4YnjZJ+9Ks1Tc9oKCthKwHEVkSTS2oHgTuaVid8P5f9
         Fnn/UGiXK4wEhdnMNuItBxh+lQ7f8QtjYbfX+Bg/e8GueIY8e5YxqG3y12l3klROIzA7
         5WPBwUxyMrChg7PRRDcm2NaDQnaFP5mpw1XHEt6Jt/z9bJx3+T3iNRShIYHI3ghNmUuo
         u59r/VykReYBPDMyt+i9+pI/b/WrsaUTARvWOpL4a9nq6mH2oPq1BcDL36nJcYLp2kDs
         f7e+I8s97qrtKDRfT4P+//Aej8bl5JwrIZoHz4mhDpOLQA1REG3YdtpxdYUONX1ZXceP
         Dviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dw44hJDz7rSvpH5qvEi2DXJBQouyq2n4xZUL150B+WY=;
        fh=ikYHnkPV5k6S/DMuts5x9sHRkC5wrCE7aGQz8tJNyWk=;
        b=bjizus6j2C0kaHQBxP6/uOy/ZkaTPpl9IvQMAR0B39qTk7/P9xR1Xj+nvcsLE0XUBU
         m5lNqoPR+5LC8Q/gQhoxJ0QaJeRHB26H6bQVaZtP+nfKywMLRjEmezGSudU+i7ixsgKt
         IuplDNaLkv7rT4h97rRe5aWV36eH0AD/0Gur6eNtdUcl4u0spx2Il/pRJ+Qs3j2SI+Gz
         3ESV5kYTdRCMk8X6prNGP6U8bgeoshyT6qnnFksnzwFPU4w3dOomfJzkhLYbPDA60D3z
         7hwXZq5NTdxqKcwY1wH12+dfTpgBby6RLdJVKZoxB6P8xIuFxVASAyMLnfo6uXFlMDM8
         0z1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784985805; x=1785590605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dw44hJDz7rSvpH5qvEi2DXJBQouyq2n4xZUL150B+WY=;
        b=rwr4tQOP/NDuSVNy6MSTjghqfhqv/9wiglejRt1ULV6Th9ZpXSsgm5REam0H9lKkzk
         o896/WR/6nNlL7/9jA0Dl7db0LpDOtVkkqJbmMGG5Q0A0dFsSwRlAiOSpOnLQa59vwZQ
         lb/qby2aAFMubawZFbk9pH6OTbCd0xQI+VV+MlfrNEwwdY1foEztzk19SFDoBOaau+qJ
         Jn0Q6WM26eRMQ3YfafZw8yfEJlCgHzxzGgR5GU9ilx4q+RTu0q23b6DyfWS62TSshZQ5
         fD+eQZrNToPFKs2IYJ8/NHhI2AwCIH1QuaYVO5NtVzyqFuWeYNmvSCIB9Wn9qcqau3Kq
         BckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784985805; x=1785590605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw44hJDz7rSvpH5qvEi2DXJBQouyq2n4xZUL150B+WY=;
        b=K1SnUruNgW2vtlt8LhgcbHdnCqS1Vb7+awT2Uo3sZDeMcH1drQiAPi3LffOghzsDNI
         wmQZ2Gx7j1Q/12+1BmIPRqUHOuzhdY5y2sO/z2dt6BDCyJPI9+n9IADk4NKFaqqrloFF
         MmH/YNppWhuhtsuYPlS7PC/bt/udUnI7GAwEJzb8uK2UHQ2EiBoceENdriKf0jLB2LhY
         pmQzmALzAEjUkACXmbvywZTcglKsbyaT/WLDiXjF09daJ9MGDdBtBXnVi1MvuGNhwnNq
         fGVwtK/ooA2kRqARLjWLZle6z1g7syUDQxr5zfMgUf52ncIVV3Xtj/7qzBAMGPeQkbd+
         afcw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0misUeJnNPDAEBiA/NlcK7eVjnz+nENzFJcpEmXC41y60F/KhCDgvYMcU7fEle1oAyf8m6zEjqCU5Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jdsyCHX/P6bqK8hTArn9MuDYilEhaYTiNz7MtdCAutfVgSlr
	tuijDu49ZMTgo25eloaatXBuFzxt1zw+oWNb2naBnpFlcU9KXf8Fr7g6nt99OFI2UYJ60kcs01P
	RvlT+q2Yl0K0aloZudGQFxnnG8Y42bio=
X-Gm-Gg: AR+sD122dypF27vQqCI/msAAMiPCLSwdHTODduoqgqSiJ+GGgxhrUSppEJdUz7gkgzz
	dwBIRr9b0AMnJFoiwypn+CuDJ/Cpi8XdPy5Ex01mWEvzk4TIyOldrX0pnr8R4MfGiTryTxaHQcs
	JAiNlVnrwQ1TjRK0K8limdWcVsxWBvt9OAksYkCn954EoQyN7VWx2lWrkLvtVC1B1YXuNz/t/J1
	Dm3S1gRLI+sdwUyp2HS9UKMJTo2M87M6vGkCYY23fJnx0WTj0ug6RNf5fD19mDYaKJKpH1kwjjC
	qln/l30nFYNEunLLJdA=
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1b:d0b3 with SMTP id
 adf61e73a8af0-3c67e026f9dmr2180177637.62.1784985805156; Sat, 25 Jul 2026
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-3-clamor95@gmail.com>
 <amGx2fJCUB4_XW1M@monoceros>
In-Reply-To: <amGx2fJCUB4_XW1M@monoceros>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 25 Jul 2026 16:23:13 +0300
X-Gm-Features: AUfX_mx8PDd_aHDdNKfdxjyqn_bGAG_YlQFuZHOTbUPdXQnkuKB3mJ4_MrnWIhc
Message-ID: <CAPVz0n2yWtTOgruRc+MAYTZ9=rd6qf6sEnX9v8THvJkN_opvbA@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded controller
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 23 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 09:25 Uwe =
Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello,
>
> On Tue, Jul 21, 2026 at 12:52:28PM +0300, Svyatoslav Ryhel wrote:
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> > and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> > detection and common operations for EC's functions.
> >
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Documentation/process/submitting-patches.rst has:
>
>         [...] the ordering of Signed-off-by: tags should reflect the
>         chronological history of the patch insofar as possible [...]
>
> So your S-o-b should be last when you submit a patch.
>
> > +#include <linux/i2c.h>
> > [...]
> > +#include <linux/mod_devicetable.h>
>
> <linux/mod_devicetable.h> will go away soon. Please rely on
> <linux/i2c.h> to provide a definition of struct of_device_id and drop
> the #include of mod_devicetable.h.
>
> > +static const struct of_device_id asus_ec_match[] =3D {
> > +     {
> > +             .compatible =3D "asus,sl101-ec-dock",
> > +             .data =3D &asus_ec_sl101_dock_data
> > +     }, {
> > +             .compatible =3D "asus,tf101-ec-dock",
> > +             .data =3D &asus_ec_tf101_dock_data
> > +     }, {
> > +             .compatible =3D "asus,tf201-ec-pad",
> > +             .data =3D &asus_ec_tf201_pad_data
> > +     }, {
> > +             .compatible =3D "asus,tf600t-ec-pad",
> > +             .data =3D &asus_ec_tf600t_pad_data
> > +     },
> > +     { /* sentinel */ }
> > +};
>
> Trailing comma after the assignments to .data please.
>

Sure, but out of curiosity, why in this case you ask for trailing
comma and if entries are in one line, you don't.

> Best regards
> Uwe
