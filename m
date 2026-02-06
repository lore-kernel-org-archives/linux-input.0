Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A32E1C7C;
	Fri,  6 Feb 2026 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418716; cv=none; b=btl4Whxg3lNaD5duBH5glnoqaF972Pqhgruiiy0M8TaPoKRjswpRTvTR1YLJi7wHFrrjqVoXBWdk0IC0NGTWnIidOJ2ppSvgGBPgq7UBAm6YGVdpTIPrOtz+10nAepCcT7WMPooVg36B2b7z4rjv4qngT+xyBNtvxw4nY44dL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418716; c=relaxed/simple;
	bh=BnBoe2spNt1Qo9I10slFhR8MgHQTo2hECyRQwGPmp0I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=r8HVC16VeA3CFqaD//ZjZ3CbTdl9FgcK6kQbhWX+r4GBmqneoTS1IE7o5bAcftxKddZh6R8metUrHfn2KUM47GkcGS9RETzlJnshR/Twv+GVIhzXBvMfZGjCyFkaO8DhH7iK8Ybxoy+8qs7WHNwW8QivxgjgVZrw7tXpw930in4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBrvaWzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBrvaWzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A039FC116C6;
	Fri,  6 Feb 2026 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770418715;
	bh=BnBoe2spNt1Qo9I10slFhR8MgHQTo2hECyRQwGPmp0I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=nBrvaWzJz7f0/O4UXMAUtExuE9xVo9pUp1WU7+YC4V7e6XV8bislcO1zByslD82ww
	 z7dZd0m2PGcKJjG07YzWHcsSambzm9PdRh+jg+7ouHzEuydL0CoGMC+T7T7E3VGX+I
	 zdvaFKqEL6XK5NdNmIliCAYIwVz0MFwH2KO+1AcVGhWzuobOQ6RRLjz2nVd9ZXmflY
	 49ogKlS+zkuZg++Q4JNNgfWRBFrUJnbd4zD9APvMPotHbTZzHKLrCoXlpY/Aao/aLZ
	 ZGckNdLnPo6L3rhkLpOytTCjwgSF9xm7HOmjRwtej5QAGsEbM+6VxXg4jacmV3Z1Sv
	 AM60ood8PyTQQ==
Date: Fri, 06 Feb 2026 16:58:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-input@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
 Lee Jones <lee@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@kernel.org>, 
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260206172845.145407-2-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
 <20260206172845.145407-2-clamor95@gmail.com>
Message-Id: <177041870628.250069.891260159674830369.robh@kernel.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: regulator: cpcap-regulator:
 convert to DT schema


On Fri, 06 Feb 2026 19:28:35 +0200, Svyatoslav Ryhel wrote:
> Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
> from TXT to YAML format. Main functionality preserved.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
>  .../regulator/motorola,cpcap-regulator.yaml   | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
Warning: Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml

See https://patchwork.kernel.org/project/devicetree/patch/20260206172845.145407-2-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

