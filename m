Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792564989;
	b=thh9E1dro5SR7l6QU6foH/CIR+XSEyOxHsfJlZpeGq36Xct76srVHKa6H0ZkzvBom1o7
	 P+H3J19oVsHRDASDm1rKyWG/njMc5ywVdDzDV4AjX0MnoRzadtK6oHHeHwcKEIuCfzp1L
	 kCluifvHyzRlnvbGwlvZtZCgNi38IHgp/a+NCKPbTOTSm4LYaKvxT5c81iYCvb9+/S2RL
	 DNmlGGLOQOZMxJibsQ5O9/9uDNVZqJLofCqEljdr8oo97yGrUNnSl0LPslMADSkdDIF8K
	 C5l1ONVNN9WfoFSgt/XKu9S7jyguP++HZAZOK/Qnhw1JujleqZqyIrowTnKVIQb4NLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
	b=YhGLNe0zecJw1SN/XamquCCqi34AruqYGi8H8HYxniM8x8g5J0RVOXDCtZKoaQELyx1F
	 0k2JPtzKrOSmvDvbqxtu9P58/gDn2r0gn94MV9BGS0bpGFP20JaKE/BDiCXfwNQhidS43
	 TfRdwDR45qAE/yztNCahSEt4HYFp4bzkxQ5PBrvVUn+KjYnNWCGDnuwfSZrXK+m+8rv9s
	 jolqeMHhPpqm+2rhHXErYwLa1e+NFUkO8L0VIgk+ODWjy2g2L2ACC4YRyQZdBJETTiGPa
	 tRYRPwKjYv1U7iJL7VTI8m04a5INz89f3fr3ouQ3jGmlj7mtGklzgdt/g1EO/R1rfNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="W/GZzHF2";
	arc=fail smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18891606A320
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 06:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18891606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W/GZzHF2
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6798eb0d190so225911d50.3
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 23:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792564988; cv=none;
        d=google.com; s=arc-20260327;
        b=XhvZgWJMHHJkZ3LWim+LalUyEBjjfv3QepWuNwYM2z1PJ6uApRh/ggn/8kx/6UMMaY
         wShfxu/9XXZK3XgrMr403R8RVGq/bSxgzVVwVlgOC6yH5XneIx6eBH+PRz8Mo6dfNy84
         xE76lQJxh9IxZmXqUC7gu+YBDvGsc93/OsqvCm435j7s3ze6dCtieKLf7dJTxcbon0KE
         p+FGJCZ+6dlMNJXOTUq37K2KB3pb9QJzSjA7OkwAUSEBQ7leveUQnbLrR6216Lj7j2Wp
         1tx+vbbMLQDc0/ST//hBaIJOmPcS1DDZTsrSlx5KPgWBCkypx0DkWv8PVnmIY+0mbHe8
         I4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
        fh=6vX/X1LZg7yZJKuEYvJwMFJYIMjzCS9ohNLxPUZNDMU=;
        b=Djmc9PRm/04NTaJvksa8ngY6NNvsCMM0c3d0mfoZq2CuuXjtkuKEjoPnmsxzjgYGZn
         jyB2z4ppr6XgIXJFuXvp692zh//N4DKtJBSAasWR9kz4AI1VGLqOQUM+kJgFjrfUiD5o
         oFRPJDAJYN9W3HaRvFrK9xsn/c75i6qiiOHaNVXuUn9NqH00kb7gpsC74DtiQR6ifaDv
         FHfxjPCUi1JCUeY/0DexIJnwcYl0TqihPxUGzhpDHegXcjU+K357PcLKzMLaLz+am9BY
         LXTz9G2p8iLFaQ/NAXvA5+jCwuP150NtrkSpHaeaGTJjsDi2ftIPEBT5/kMBQh/GdOhC
         wi+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564988; x=1793169788; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
        b=W/GZzHF2NY06v+oXZlgyivPlfoDTpJKe9CZuhEPaTuP3Qidpu3yorDYA41xB4bcPSC
         /M1QCIYeBX3/6FCyGJwl0TF8pFqTe88oUv3XwwvX1E5VlPp1911HfPcH3d5saDWQgsVU
         Nsll9UVTXZZuBMTm2Nwc2f03wOSjF5w+FPenbmn78a8sK+qlNzx+w1Y60DCOuAWUn1OR
         UDv5dhCVm0SZxFlLUR/YUHiWZCrrR8+FOmbCrNDyDDz8KnODQNNH/R7qPMfSPlYd8n0k
         Jxr2ymTOX88uWC8p/jyO/uN1fBbx888FwDve3IgT2GsonRNMcqXLmqB0eWi26eXiw5YH
         ZjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564988; x=1793169788;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
        b=ESv8dVk1Y28eLJGdR4iAVlq7+CGLmhYKFRbVGp4SzHlKKJKQy7GNnlzhsIfkVJouH0
         7tf75l8T13LGQa3OS2MbynaIfa7OE/M7AVpBDJRiHq8laAZwxsh4G8yqyVqPrNzOtWoE
         xZeY3EhWpYnayu1mlR4DOUYJRK0M7aEEDW+/XF1JsVs2ILkfIvU5x+415gbKHaWW+Ljp
         SWWmG38Zs00FrGo53ge8jUii36EQV+Ru/wZ5ziUXjy6oJZWOhPQBFiMmAUL4nQMN5pTa
         Zyu+Hgg3A0C5KmcnKtTSOgWQ+TPeCVny4VNBuZknTJUDIOYuZHEoCUAzwpiMMBVEiHB8
         bskQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2ppWPAzojpDyNMSFgeFIAczoMfshUQDnzxewFx4dDBPuc8rKWCckMX8k/vTthiGX9hv9vq4yX0ohk/w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJOs9e1uz2dsg/fXfULS5KuAzndLZ+JMZTY5pQq2sUa46O3e4J9
	7U3OewTZk5/+0/2D/4r1xJoxDOYTwqt3z1gU2im1Ii+zhfkf29BB+GSuajEFmhU2sIa/MiaWb3T
	gc8IX6jvQbF7GhR3r4Uabc+8giZjgoss=
X-Gm-Gg: AYBFou1MatlcC54tdPK0+4GJvMJqVH7JBdN1lwYtwFSc4i8DinlDCy5+nHq4Iv5L/Uv
	0bvDzsjCX3DcBQvUm6rpLeaPQbzqKQ3oWVMp15pER0Fw8yGUCV4W6bGQ2VLFwU9qlCp7sSl6Typ
	j/rvw1nwMNhHS9jwFIIMoE5JYlluZbCMLnHA+ZUG2dewpnkEnDEAcPYzOXTGQawFR2qpV8HvKBS
	yj9xSaW1Im93Hi4pG3qHK+Yf9sJCdl22hWqrorltFjFDKATwSVNyuuBfeqZoXUqlB/1gGH1NSGn
	fxdFffrYJ4NwMdLBMY4quQvbYxsp3u/HiOBVomB6qQ4nv94Qd9p2cnScAoeCe7E5SLiqhAOcHZT
	81/w8b+HKE8CjicSPnVKOAtfV8uAauiGUGDI=
X-Received: by 2002:a05:690e:b48:b0:677:db69:cc1a with SMTP id
 956f58d0204a3-67a0e02fb85mr644184d50.7.1792564987934; Tue, 20 Oct 2026
 23:43:07 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020173556.632798-1-l.scorcia@gmail.com> <20261020173556.632798-2-l.scorcia@gmail.com>
 <43b58ad7-5934-4895-b48d-5b5a7b92e253@kernel.org>
In-Reply-To: <43b58ad7-5934-4895-b48d-5b5a7b92e253@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 21 Oct 2026 08:42:54 +0200
X-Gm-Features: AclHuK9RBvE_tu1JJML2kndZnV_iY7Vg0PVQd2A9ECqRfA0-uzrQqgVwLULojEo
Message-ID: <CAORyz2JaJ40+F1oyrvY_0WdqH=fritbPuuQaZ98sXagVayZPLA@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> And here you write clear note about dependency, once you fixed
> bisectability.

Just to confirm, would the same text I put in the cover email be ok:

"Please note that patch 0006 and 0008 depend on patch 0005 as they need the
registers.h file, but belong to different driver areas. Patch 0009
also depends on
patch 0003 because of mt6392-regulator.h."

or did I misunderstand which dependency you are referring to?

Thank you
