Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9232874E3
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896226; cv=pass; b=Q22u1ajy8OTaWj61ObwgEBfZ+va5RRpfa/HSnsIrTUxkwtXyOcdbLsQncXpxLi9NmObbwL+QYWNo1lobkLEP8Cs38xAcJ0Xw2Zb4NwWhP9zNallGNjyO6QSv3DEH/Ck2nOfmeXNqUKeTtb63IzGlcXrgRQfHJNqND/KJdiAx/Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896226; c=relaxed/simple;
	bh=RJ3zkOU7L58sRoFvbytTBsvFQBnd1tM3hTUu3UJnWbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AydWX1HFHfQs1kFOwExeAmxSv9knbBZ+UauIIT9uAYzAMfcxh50qF66wYJoe4WZ756ngBtYYrTjdllVxY2zSqWNPLGfuuhjkS7s3g0PydZQoIA6cQIR2Mo1Jrvv6vlXRDeW9w9jp6HaYvH/ewXFuKzJIt53dcRitRpXTq+QuW7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c5cW3sJa; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c5cW3sJa"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so701629e87.0
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 21:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773896223; cv=none;
        d=google.com; s=arc-20240605;
        b=e2IDu5KX2fuDEJVpzXLP1zbKBQaeuDPG8XMoPKbeZY0p+rKbSV+LgMZQkt4LNaq70J
         DWvtSsxouXqldShFrXmm1aI7kdB2B+Q2S/kJYwZWJy09s8AL7vQsNDwTujsUH/GccQen
         y7yZrxYUa5JWiuc9VIs3SOS0PZhhthqOIbKML5vOveWiIBWwnn/5YGedT6jdV9Th8RPk
         JTfdTVcDZ88tUZBu14BMVb7FnSf6mXCFRIlFkRpGdHUQHm6kC8gzeiSWq+AFxA6Mig8m
         Hzf4QLTbJ7qpXhoAn1BHJ7rFlmQUKcE+/hp3GSXk4A3JQmmnSQbxbHsEIqZJX3yAkdZX
         XCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1zufBE/wG0H/dPy5NtwxW5QdocP2uRSfDHkfDw+3Fq4=;
        fh=PIphDu9YB83+AwIm8C/o+G2cWOBRbF+RNDENhRE3ExA=;
        b=LCFIdJ1UgT9Db+QKG+Mn7RA9RqRAblilDDpMBlXkgHz4IrH8zw1NDzesyyCB6GCv2y
         /Pa19mcYLIRzDiJ+Zl4dV7gENX8xqGO0S9TZ/Fwr9kC0LGFXmH1KRldVYXjCBVmF0zzY
         6fo7AjfNIzUck7DNAkD9jQpepTA404QgX+Q9ILs6DWofnyLrxB9XK3Oi7wo5gGZKV/U5
         7xsFBKKuCwJdX/XxVZes/C3guY2zXw3vjBnBUJTSdBeDS7U0RScZLHvHtriPgxq5YOfK
         bfIOtP2wSmzF6ig4oWAtidJnJlYXpotS6k0n93YWCZjLne9iL9bQ+GBtNZo6PRvF87SC
         VYMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773896223; x=1774501023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zufBE/wG0H/dPy5NtwxW5QdocP2uRSfDHkfDw+3Fq4=;
        b=c5cW3sJap+sGtxnrhL3MefVSVt+9F1u6gmHQ7cPndo0veI049W9uS4/57N0ivvWF+M
         OlIh1AyxOkI50DGrbjl28V7X+2kaxXSaAuwpZL+46FIwvRdLOzvs6f1yEiL98ZE84jiJ
         UN4ceoFLzm8NvOP2yD0hwEKGqQngNx6q2b5sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896223; x=1774501023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1zufBE/wG0H/dPy5NtwxW5QdocP2uRSfDHkfDw+3Fq4=;
        b=FHwRixP6qFFhMolpHVmMKcFtyx/lgvzJrSCOrjudwYBzXvZXXvqFFK7qSMYDnALjtx
         Kr+Kx8czzOWjRYx5Cx2HoCRY8foaCRzZ/PSnCwrnXpyNNMbnVAP/0iCQBOjjjjNzoC5i
         lUgYmYNoq6aVA+T2EAVRQ/2wkYUuoI7zlrcyyoQY4f+Eoin61s/LfdODXYhuL2BVdOzu
         NeKjutdSbZVw3gUDZ8SRdTZ9RSR7h7xrzESDxm4B5c3QZbG2SVCkftX8KvvFWRLYDZZJ
         arpNpUBHblQJMOl8k82gVVpF4jw3LYlImJq5WUutJjamuM342gtj42yX/lPS0E9Uu3n/
         oq1g==
X-Forwarded-Encrypted: i=1; AJvYcCWdTdE+yA5T8kWQaNA9nOiyzIgsqcvjtp5awXs3ZE3mEti2ixlXNO3fapo7PYqYcWj+QtiuxPXZUGV3lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaOboBkT+fSoqTa3HUhkqoLuUjpoUe6V0K8YSb/ZTbb10rgXbQ
	CW2PgJYf1r7CEtb8QYWvSomSjSO+qQthwGl9tFIN+4zWwjA6+AuSFbgFLDq5kgJITluI+ZbByy8
	4eKX26rajK90trl/5x4saJt9ssoL+A3565p2uBcXf
X-Gm-Gg: ATEYQzy3dxI0y3Jy8LuYVIQzDe+jNCZWYvuZ+L3kYNFH73q5lhOJl4BDkHepkN91qAp
	sCoubemKSUJ9sI2u3O9eFPN1A2C6sFJXxEicf8f2lc/x5yxj7awe3Q9vVy5EY1SKA8vI9+FYrxB
	/dWixr0Cr3sbuxy6YpLz5/B9sXhF4DMiMeDmKV7dUQwrI+dFlgG874faVs1ViT6NmmmJuxkw1rS
	Wwa8+wratFtQ7SgJFppOr4WIF0IH7CFFk9RWkPz92MaUo6vUbfeZ8QKe27lUK4pRTsmeOEwoMXg
	fQZqZ4qW3heUorrZ6/eXn1fzHmDq3g/4CfC6ng==
X-Received: by 2002:a05:6512:1598:b0:5a1:3561:de7d with SMTP id
 2adb3069b0e04-5a2796bae61mr2319165e87.41.1773896223417; Wed, 18 Mar 2026
 21:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-4-l.scorcia@gmail.com>
In-Reply-To: <20260317184507.523060-4-l.scorcia@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 19 Mar 2026 12:56:52 +0800
X-Gm-Features: AaiRm53ZcC1_5GBB68m3xy0r3oGl-8GEHHuCoUTvKM9klv1nQiqkqQTd8EeYleI
Message-ID: <CAGXv+5Hz6JHBTX1ftxRuD0pJuhxGJnAkGUO7=kUh3fErOLtXTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: regulator: Document MediaTek MT6392
 PMIC Regulators
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Julien Massot <julien.massot@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:46=E2=80=AFAM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> Add bindings for the regulators found in the MediaTek MT6392 PMIC,
> usually found in board designs using the MediaTek MT8516/MT8167 SoCs.
>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../regulator/mediatek,mt6392-regulator.yaml  | 318 ++++++++++++++++++
>  .../regulator/mediatek,mt6392-regulator.h     |  24 ++
>  2 files changed, 342 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,=
mt6392-regulator.yaml
>  create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulat=
or.h
>
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-=
regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt639=
2-regulator.yaml
> new file mode 100644
> index 000000000000..fa4aad2dcbe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulat=
or.yaml
> @@ -0,0 +1,318 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6392-regulator.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6392 Regulator
> +
> +description:
> +  Regulator node of the PMIC. This node should under the PMIC's device n=
ode.
> +  All voltage regulators provided by the PMIC are described as sub-nodes=
 of
> +  this node.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt6392-regulator

Please add the various supply rails. This allows you to properly describe
regulator dependencies and have a complete power supply tree.

They can be found in the datasheet.


ChenYu
