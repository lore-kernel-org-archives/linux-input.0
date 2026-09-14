Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F03411A16;
	Mon, 14 Sep 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376088; cv=none; b=NIm41M/lwCFOE2ZdChyc7Bm8FxKmc/VDSDaVCnh6cwWtSxGY7O4cLfIvXlRNhxtSoEwejE017Ba9Fn8v+c8OBwc7M5mrqQQdEpsugjzS3+FsfG3fV2qVZUf4T3LlBaoQbzqdc/YLAcCohNrt6+6pe10Bpca237jRaG2grHFZcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376088; c=relaxed/simple;
	bh=KFz+itPo1ys+Tsa/TL7vnt9jmxFYXYOnalIndxPD+eU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c8DgzP/8/KAAZtRUcdExfbSQq9IB+M+pz9cmtEXhnzp6DFzb6bgJongbuws1aYNMgw2xntYWifNI2EllEyMSHcZab4bN7diV0Vflxwhl8334yL0TGazXsP1588KBLBf9hOrdG5+LRDKfMXEf7UKTDY2ChzVCPBLQKisryIrSV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5D9arED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5D9arED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B2A1F000FF;
	Mon, 14 Sep 2026 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789376082;
	bh=Q7477PwCU16Z9IZb4Mk21gV/8d3FRlMM3zaJG7AjG+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=l5D9arEDmX3lxn0IIAq08RnanpvPAdGwM6Ohxa6FLbp3dGLISLUB5LDnhff7LoWPE
	 u9nKrtxtbvvu8hzQ6tWh/W56gjFRFpHy0rsrfVmMcl2b7R3hNxc6U16XKkKZu1wQG4
	 rL4GneZB/7NaEyejm/7HCe/pMTvpGVohkQc6/e+0EYdvHz7Qfu3XKGmBXjaoHnW91n
	 vH6X/opDPEuKN23CDjY6CRp4B5tAZsWCXIxXGOh/A5dWlilNnYxShoPny4w2ZJAy6Q
	 nJYvTfWdWWHo0Dd/mmcuqUM1vkQIIYJ1OAmqWYwsqw466aanskEo9BnJQODzyv2PkW
	 uBKgFW3Se1+rQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yassine Oudjana <y.oudjana@protonmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Artur Rojek
 <contact@artur-rojek.eu>, Frank Li <Frank.Li@nxp.com>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: input: Use consistent indentation in the
 example
In-Reply-To: <20260913123310.100170-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260913123310.100170-2-krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:54:38 +0200
Message-ID: <xhkdbecew1acx.fsf@mkorpers-koolstof.csb>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Krzysztof,

Thank you for the patch.

On Sun, Sep 13, 2026 at 14:33, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

For mediatek,mt6779-keypad.yaml,

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

