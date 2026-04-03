Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F5248F62
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187313; cv=pass; b=VB+iu8Or8xLAAXK6l03je2JPkPp91UTCF9dXbLL6zFvfhP1cY82U+3MXli4k6YBdhyKDSJrdL2bQkvfQn5mErie0DbbAVfO/sUT3Uyduru0SptypM9swKVyP3EdY4iuDofElT3Sbu073brsh7q3NCCi5vZjeQx6wmdkaBQhyKn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187313; c=relaxed/simple;
	bh=+0MwXn0LJEuitKVf35y/AcyJhu9pLZu7swqJVU6DXVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXzBNRgLTYum8H+T/nm7Zsbo78q96nyqBi7DIRBTVY37cg4UCk8xI/cbtSou1ZvnP9HDKBSMsnhna729MPC58ARrDlVgbx48ViDW2TRb9AJiu1mu2XMUOBZPP6Fes0tNuZ7YLDdC+Bua/WPHKeU26t0udbqFznTpPN0eFirulTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icYl7E5D; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icYl7E5D"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9516a653so7491305ad.0
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2026 20:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775187312; cv=none;
        d=google.com; s=arc-20240605;
        b=OkmIbLzFldN10QubOLQNsfmyYNrrtSRXIC5CJow8D6y2oELAh7shmHzOxH8CVK54td
         TvecOUyXfT1wyKN199qXueDp6vcHPbtQwq6RlcIflS953ck5AUQJQahLqRXE29/fwaJr
         pIrz3DbiJRgUaJltwM/SUO606f3YMcexEwJXl2AoS7qdgPs2rDBERY8Ym+pV+Vc66no5
         QQKQpvA96OwLzotm9gs34a4UBAaM+b0HxSBWSQ2NgkbsKCRS4QhTYNWQodkW6i3dTaNE
         PkW3G2nLI8HpeivJyuTlToYF3LYl/g1Qy5AUJv1r94L81n09loX4dT0WS8EkQm7qofcQ
         G5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahAWEcg4rYVlFXBXuYLShZwIh35ovqR23fOGx9fT9qw=;
        fh=tKh02iL3k/goNy3pj/gizP7SvhKacZRVzdkoZ5yGRqg=;
        b=LexeL9YRV3faSqVvsmHL/ZElriPBbKjWJTJqA6ALMmL0zQ/GiFr4SSLeCOJkGtOGRz
         FtfYeWIEzRlz42WgHt4ly1mHPR6cUQMbGeqzyzyd3uFWpa6tJzu0Qrj5FuvjaBX6jTU0
         b9usAwsueW47Bzbqgk7ittOz5tXTH6v4P8uoOFTnD0/qymufv5VUMfCNljsIHTSiPYpG
         d3GR8RcEAEhGnREjIvAyevpPGiMkNExCEQUUOADR17blNmuNvXEFovzPGmnnfJYTDKZk
         iEqKcY4+TV7Vx0twBm6qb2TfJJNpLVCQ/zBr/imkOBb7++UffMaJw5t4VN3LOZTH6U/J
         EVvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775187312; x=1775792112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahAWEcg4rYVlFXBXuYLShZwIh35ovqR23fOGx9fT9qw=;
        b=icYl7E5DKorRnLxtiToowarc4hXGctXcoq3zaQpMdWidKaFZwNtXR4HmrLSlItWxr0
         lGr6RcjrtB2MHUB70KjrmkysQJbskdkxny2VWzx+Yzn/5W+KGfIZOTpgpa4Vgt8l+RW4
         O81aT+5TAkukTif5Bk5yoUXPIDtkJJtJ1VlrAtu41W34+a4LeUhCRumjXQaqJITYx8mB
         RJ8LpcRTIo/PhW4pwpkCVrlbjaa66bnwhyD3wVncQQefp9M3SzPbyj6ZoQWO85cc14IO
         Mq+3Oa3DaQWJxpLHrsHaF9QkQ6lsE+cjsYE5uzKxLx5qYIvPeb7NFfHeGgDP5YaCzmmt
         u2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775187312; x=1775792112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahAWEcg4rYVlFXBXuYLShZwIh35ovqR23fOGx9fT9qw=;
        b=lDZvKDPj3t+CHaOSxI6Rv4b03eRo2/DUBEcBgHWu6ZD4kkHWvJ11mXBDWrnrP/gSAY
         VPYrU2isk1kFV7PaAjcMK7z90Oc3FDqnWzMPdpmSv+WH+GU0/DBevXaXL4UCtwve0WzW
         EiQ2mdTCFzeb0y0+y459fYRDwKFHOx1aI3F+lGP5b1ymPZUcF5dZ6F6VIgHdPXuCtxOP
         jM2F/XBPm3AZM4DSRGlJEwRkecCizoiUkw/KHD5dhCbI0xDAXalOvvWgOgI0aYwl1G06
         mmOw5iysOB0b0H/DRvW/pipPd1Y2NfCvZy1Oau7NFsp0lVaScqX7jeCiDdu77DLQEDLy
         eURA==
X-Forwarded-Encrypted: i=1; AJvYcCXl4TgqFzDiII57RgR5XoUjVdTDRHLHF+aOYcHwLjrmEuyjopu/n/aZAKQr4EBAfsuA3DqAZ8GwX4uCWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKH3AHOvwJJZS4bUtUbW2FR40G56sx4ruDyaB4BgdUHjXn3X7U
	nXff0CACvisDiP5YgUYcsX7kg+svl7WQEjl0ZjgqGw9r6gcFe0t6fdFVRyOJLLuCFKMHUyTI+2L
	qoLpicEXN4Qrh5HdUrSYHCp2DuxekIJE=
X-Gm-Gg: AeBDietOytAHlL1Ixkl4VTyWaoZwMmJrbfqLmCZ2Wn5vQ2ih9OtFbGIkmKZ8goXLBqm
	PUmbmX8wzlxiwxAOiSXyaaNaqrESIypjP/FFNwOzBPFpi0Ewca/CUFqWvPi2Z4lryI9dR47tgYA
	l9DG+WV1jVeYEzyVWfzJFl16+b6rJ4vQDxn/bq28dHX34OOJ8Hsaz2rGyHYYF94M88v5dpYyERi
	n7B9kP/6rmRHXpXntUmJAHJJvOwxny3FzTUupTxxPsyBmJ5++hW0qflp8KSvGZ7d+vP7Jscv873
	t3wB3gSj7a8efGyIjpBQaBla3498abOH//Oh4Q==
X-Received: by 2002:a17:902:e751:b0:2ae:b807:da61 with SMTP id
 d9443c01a7336-2b2817b422fmr17307015ad.35.1775187311715; Thu, 02 Apr 2026
 20:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318083124.21793-1-phucduc.bui@gmail.com> <20260326141551.GA2304345-robh@kernel.org>
In-Reply-To: <20260326141551.GA2304345-robh@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 3 Apr 2026 10:35:00 +0700
X-Gm-Features: AQROBzBK98OPGZHdV69IVsBAyLP_4-EkBm5a428QbKTLn_9UWmvRwVCS8EXNElE
Message-ID: <CAABR9nH3hr+Y5ksD0cn3Gd9XUvmb07X7zJw0b4k_yVbnAuz9=w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: input: touchscreen: ti,tsc2005: Add wakeup-source
To: Rob Herring <robh@kernel.org>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, conor@kernel.org, 
	devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, krzk@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de, 
	mingo@kernel.org, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob, Krzysztof, Conor,

Thanks for the discussion.

The core schema already defines "wakeup-source" as a common property
(using oneOf for boolean or phandle-array), so defining the type here is
redundant.

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/wake=
up-source.yaml

I'll update it to "wakeup-source: true" in v4.

Best regards,
Phuc

On Thu, Mar 26, 2026 at 9:15=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Mar 18, 2026 at 03:31:24PM +0700, phucduc.bui@gmail.com wrote:
> > From: bui duc phuc <phucduc.bui@gmail.com>
> >
> > Document the "wakeup-source" property for the ti,tsc2005 touchscreen
> > controllers to allow the device to wake the system from suspend.
> >
> > Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> > ---
> >
> > changes:
> > v3: Remove blank lines
> > v2: Revise the commit content and remove patch1 related to I2C and SPI
> > wakeup handling
> >
> >  .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml    | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc=
2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.=
yaml
> > index 7187c390b2f5..a9842509c1fe 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.ya=
ml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.ya=
ml
> > @@ -55,6 +55,9 @@ properties:
> >    touchscreen-size-x: true
> >    touchscreen-size-y: true
> >
> > +  wakeup-source:
> > +    type: boolean
>
> wakeup-source already has a defined type.
>
> wakeup-source: true
>
> > +
> >  allOf:
> >    - $ref: touchscreen.yaml#
> >    - if:
> > @@ -97,6 +100,7 @@ examples:
> >
> >              ti,x-plate-ohms =3D <280>;
> >              ti,esd-recovery-timeout-ms =3D <8000>;
> > +            wakeup-source;
> >          };
> >      };
> >    - |
> > @@ -124,5 +128,6 @@ examples:
> >
> >              ti,x-plate-ohms =3D <280>;
> >              ti,esd-recovery-timeout-ms =3D <8000>;
> > +            wakeup-source;
> >          };
> >      };
> > --
> > 2.43.0
> >
