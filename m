Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52383563F3;
	Mon, 23 Feb 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840463; cv=none; b=GilBj/FISM3ENbjA5RzMejucU5X69UvkE/yN0pYkuWb3RpEG0iTvw+/uZKHmyoxt3rmb+Qh8IUjceo1PlUvW21XxjVDIyZInVvDOgEfgoNyXne9vM0mcN66YOLuLDRan2PyZxLS7m0bowZUiknu1Hcj8vrm3ciFMCBASR6ANLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840463; c=relaxed/simple;
	bh=JWfMwhsykouUvZpccY1Dd6wRJOOSr3zLEkZxB9e9+/U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ttkoLKCIhimjSsAU/qPiKS6S6g0Tu2HzlJQsTnYgRs2kDU+md/NfUoRxo8Z0EaPFp142crxn9cStGaDv6KytmSk2Q+C0V6gppkfe7Ytqs1FNCV4q6EOI/FLWc8P+vTGQIBDbTTPZzSokYH4FRu2nUD36eo3mkGtQJzI/azrBGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U714091e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U714091e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7654FC116C6;
	Mon, 23 Feb 2026 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771840463;
	bh=JWfMwhsykouUvZpccY1Dd6wRJOOSr3zLEkZxB9e9+/U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=U714091ebCpuO30iX6C3R0ih0NzaIWP9jugCwtPLB+2cdgrXM/fia/RCUnBoD1qUf
	 wrpzYxKM32DHGrdEmkuI0LXxFz+f+hu1RowEo4pCAhppnQrVFTFGfMYxwLBDbL6E7d
	 TJYrohM/7jo0ukkHWx22wi43r4OeVxdZ59sVo5xQ+EkcsM/ssixfXJ7VwAtG6TYBaP
	 H4WtJLLNMRvxt4mjroj2ql3obkIOOE7YLpxRUJTt4ogeh1JUxgKkfqcxFfCt6IV/Sb
	 7+0OHnyT4ikC9Wyp8vido21C6Zx0avodDJDQYtQxUGdXKffoUtLJRiaFilao3x3cSe
	 ZvT5cgQ4MZuTA==
Date: Mon, 23 Feb 2026 03:54:22 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260223063858.12208-6-clamor95@gmail.com>
References: <20260223063858.12208-1-clamor95@gmail.com>
 <20260223063858.12208-6-clamor95@gmail.com>
Message-Id: <177184046063.2675311.12742690593841960784.robh@kernel.org>
Subject: Re: [PATCH v3 5/9] dt-bindings: input: cpcap-pwrbutton: convert to
 DT schema


On Mon, 23 Feb 2026 08:38:54 +0200, Svyatoslav Ryhel wrote:
> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
>  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260223063858.12208-6-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

