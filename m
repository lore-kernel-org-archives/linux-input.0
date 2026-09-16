Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06F4457C7;
	Wed, 16 Sep 2026 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543993; cv=none; b=Pbt7r7lbTZGcaswYSEbCxJmhL1Phw+EvZ7lr4yfFNzwtLgvaSfSZrvQwobV6Wdq6qzCTRKK7OLHcSsX2je/Qsjg9dyjm0dti6FbB3hBytw1A6Mpp8N6o80w0S7UHVVK7MxNbYn+BsrIS2HZxGj59sNKhaGkDwGskF8HL8itRUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543993; c=relaxed/simple;
	bh=uhEEMSeYIVCrkIn5hi86Xkv5BxenIOVfaRKKVYHvD84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bWmo6mi9Lgu7eVs3EtRncVpv0d+R+4FDoTyYx8v6Ki2bv8sqv2lG/rorVyiEx0jK0nWwROVI3xOfLlnPY6PBa0KiCCHFTmZsfyMUiGsfbKZiYth6eWXFDNd01/4GdW0V3r7GcXFS2quhw0DyPg/pgvVxjfGD2vpqkCkAN/Ftvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERhM4IuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERhM4IuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F205D1F000FF;
	Wed, 16 Sep 2026 07:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543976;
	bh=uhEEMSeYIVCrkIn5hi86Xkv5BxenIOVfaRKKVYHvD84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ERhM4IuWUsUDUCi0mxk+QQ4mrLR+K0U0X3WIVec1LX+IL7ZohUfsPxaA8/Kff+DSB
	 1qcsKbCRrZoF9P5pNQzA8kZ6WfUNzY8YgjV1Ua5/aqQqcZPKEpFWwn9eUQ0gb8Kxl0
	 PmPO05XA6tf0yCSo/qmTHuqOllx9qAwbzhcAl0648Z1/1u4PoeQALx3BjXwYpLIiPM
	 9rcgVPSAXAawae5xybgelL7ZlwwZL078ZeAabYw5ajT95XxqV7ropCyY0SIuEHND5E
	 fZubQALdBDGLGG22xtIj3p5oUJlMXVRFVkYD/ST0VNbK+NwWtNa4C+w4vzl2luIccZ
	 YMKu3eeuLqfdw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ryan Brue <ryanbrue.dev@gmail.com>
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add the
 MT8173 keypad
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
References: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
Date: Wed, 16 Sep 2026 09:32:53 +0200
Message-ID: <xhkdbbj9x1wii.fsf@mkorpers-koolstof.csb>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ryan,

Thank you for the patch.

On Tue, Sep 15, 2026 at 22:47, Ryan Brue <ryanbrue.dev@gmail.com> wrote:

> MT8173's keypad controller is the same block this driver already handles.
> Its register map agrees offset for offset with the MT6779 one -- STA 0x00,
> MEM1..MEM5 0x04..0x14, DEBOUNCE 0x18, SEL 0x20, EN 0x24 -- and
> mt6779-keypad drives it with no code change, so the node only needs the
> fallback compatible in second position. Add the mt8173 string to the
> existing enum, which is what mt6873, mt8183, mt8365 and mt8516 already do.
>
> Verified on an MT8173 board (Amazon Fire HD 10 2017): the volume rocker
> reports through mt6779-keypad with no driver modification.
>
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

