Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265289;
	b=knJs/QDcfwhQNWPgxD8GbIy8lem7YXG5a0leqJObDWfRupaiQR9VApZ8WRh3o6icYRcR
	 ZZlHSrmgpUk7E77HJYSzOcYqDH+fqnXCpuxmFYRcw7cNe50WiAnaZsVeBntrzdVootIKm
	 qSOBdte73v8Qfw6ZS9Ah4vv7IcICuHSgUDt3XkruUdTpeX00HtaSZQfGsd/eFSY0reYZr
	 P1/4MVq4e/KGQ9/J2Vse1TKs0A4VxplD2yeDZ6j49oQIFTOt8h8FLtjY3AZkgCimOK2ON
	 JWOl7kufJEoBzXSVGY8+NU+q05tLecMbnd2+bnheXwHt20FmSsmmxi/tRcT1S3q4l3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8PkbYCzHyaa3WD3xq26j0zYQizlYfQmZT/+LBj0BT38=;
	b=nEJ2+VyW0a6+gee8JHWACyOjD80+OhAaU7J4Wxy1REhPlIrilQmcftMso/9e0lP+KOme
	 XL2bHP0hE6Skn7M8dU3SAn2mb5AD4brT8c+RLSp6NxzR9roryOGMuiNWX4sJVVEDmd4Pz
	 xdBs0ZvpjIdweVFva0v6i3HuAOGEy0EUr+UV4Cn9BlWPLKIZDtA60mU/W91jS9cKFm7Oc
	 YGOFf1wGqyOPJv0C3UTbVxTwJwyw7w6iU3Fxw6U1R62SR/du9XONQDsTh28fWBg/r8cRY
	 u157KXcjhiQ5kn/J32cOslG+4ujSG7/i0g4SeQ5Vgmqimj53ZvWp7hAz5VEP6t5EeZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCvMCgoo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01477606A32C;
	Sat, 21 Nov 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCvMCgoo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FE01F000C6;
	Sat, 21 Nov 2026 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795265288;
	bh=8PkbYCzHyaa3WD3xq26j0zYQizlYfQmZT/+LBj0BT38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCvMCgooFOmIb5nOzFShpLCCW17Y6Zpk08LL47h+0NzrM1fCiebKh+oBgZp2A8YDr
	 ct8fjdyvQAidygNtUwQB47dyIbF1rOkJ3Z3Vhcv+70SuFyuAm7eYVi23parTZczzeN
	 qGub96ZdQWrKTC1/A2H6oWyoE19zCdXJI17Auz/9J65keEwtHOnXpEE50j42FnImB6
	 KI+TO1zkSBSOYrEQu1vL3IYSY1f/s2F7PLLYC9YY+1plW1rs6gMFpnyFMhqS8Mu1A1
	 a/Gr2CEzOIyJHp9XSt/eGD2ecdCKeM7ABo0wQLWJc2NqtYLDum91zQLowCHzdW74wv
	 leL49a3xpvGMg==
Message-ID: <sashiko-outbox-227025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/13] dt-bindings: input: touchscreen: add SiRF
 AT550 touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuugo Yoneda" <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261121-at550-rfc-v1-v2-7-b0309d0789b2@gmail.com>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-7-b0309d0789b2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 12:48:07 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: input: interrupts listed before clocks in
  sirf,at550-ts.yaml
--

commit 694e35a7d31a133773d2560d04e23081ecacf69f
Author: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

dt-bindings: input: touchscreen: add SiRF AT550 touchscreen

This commit adds a Devicetree binding schema for the SiRF AT550 resistive
touchscreen controller and updates MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sirf,at5=
50-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550=
-ts.yaml
> new file mode 100644
> index 0000000000000..ce081e1158ccd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.y=
aml
> @@ -0,0 +1,40 @@
[ ... ]
> +properties:
> +  compatible:
> +    const: sirf,at550-ts
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +  clocks:
> +    maxItems: 1

[Severity: Low]
This isn't a bug, but should clocks be listed before interrupts in
properties to match the canonical Devicetree schema property order
(compatible, reg, clocks, interrupts)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-at550-rfc-=
v1-v2-0-b0309d0789b2@gmail.com?part=3D7
