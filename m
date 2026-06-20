Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9232F0C79;
	Sat, 20 Jun 2026 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986481; cv=none; b=hYxM1Dopu5LGu+FQUoeiMs832nwfQcqbm9mEDQKHYNLURts75uF4F39pyjC9JoSmJgR8sYNqtErH7IpCOPFt3abY+08p19MLRgGgGoppYvIvmuAvSm4OWCQz+E8MyMMJLR9V5CZBIXnb343o4hlwgYjeJ4dD983o6YJ6ibvfyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986481; c=relaxed/simple;
	bh=F+EN5Y3nKzy6JWDkS+yuDu3549N3lJQvlvk/K3YeMLs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZBF5PWgFxE73YHKPqNJlG88xOEQpvSqZkm4e73epjwudO200lhvLo86UrMDdP/eISjNY5dmHmQwvJvNS+ToRjMLVGm0svGXu9/WLxeddVtNTP2grmJilAd198W2dpW9S1sX1T+dopmVwR9hN6S5H8XqrCX6oz2YpG0bihg8+EV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joo94QOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joo94QOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FE11F000E9;
	Sat, 20 Jun 2026 20:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781986480;
	bh=ZhubLF7WcHBRFO0mFVHeOIbcfKIuhljCVHmOrYd+EJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=joo94QOs6N9f98PbWcqQCgNFKnQmsTXtwcrROw1k4YX2F1hZlIFBFVuGObbhBMptS
	 +b8UfEbucp8NFPD5wvMBqe/1djb4+XaAiH0B4gqkaVwmaIF9Xk2lim13NRduWNvPLH
	 rBF33D/BrgSrGworE21HPdOy04Te183UZZWNIeplFyFybT6sOrrs+qmm+YgSW+FnCI
	 OJ7PZmpDJhBYHh4KwZ2GTJ0rCvi7vIc3EHg37uW/qLmzM48FIp3uaq+qqutjsQDmbb
	 ZzY+0UQ39i3p4h5Jk8CoRSa7rTdX9AsCe6Kd14J0E8N/a7Tdd/ZkYdVM6XcseDzWeL
	 dimA8YVLeQYwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260620200032.334192-2-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
 <20260620200032.334192-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:14:39 +0000
Message-Id: <20260620201439.B7FE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing required header for input macros in device tree example
--

commit 17d3dfc19cdb75b35edbf6c7f6fe9a12ac08651b
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: mfd: mt6397: Add MT6392 PMIC

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b=
/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 3cbc0dc12c319..927df823d640b 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml

[ ... ]

> @@ -663,3 +672,68 @@ examples:
>              compatible =3D "mediatek,mt6397-rtc";
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pmic {
> +        compatible =3D "mediatek,mt6392", "mediatek,mt6323";
> +
> +        interrupts-extended =3D <&pio 28 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells =3D <2>;
> +
> +        keys {
> +          compatible =3D "mediatek,mt6392-keys";
> +
> +          key-power {
> +            linux,keycodes =3D <KEY_POWER>;

[Severity: Low]
Does this example miss the <dt-bindings/input/input.h> include for the
KEY_POWER and KEY_HOME macros?

Although the dt_binding_check tooling extracts and concatenates all examples
into a single file (meaning it will inadvertently compile successfully beca=
use
a previous example includes the header), omitting the header in this specif=
ic
standalone example block might cause compilation failures if copied by
developers for standalone use.

> +            wakeup-source;
> +          };
> +
> +          key-home {
> +            linux,keycodes =3D <KEY_HOME>;
> +            wakeup-source;
> +          };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620200032.3341=
92-1-l.scorcia@gmail.com?part=3D1
