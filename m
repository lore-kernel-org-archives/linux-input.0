Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4A6FC3;
	Sun, 25 Jan 2026 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769359398; cv=none; b=oxJQkJSYMlsXtPPjV/hjOeUgONzleI1DZPF24a2XqLZZdICMblC6YnWPXzL6pFDWdVV13AQ9VpnlfiE6HfisGkQrsAW9jsYMxy/5qe8hFjtoJFe/whDhI25FTud+CTG79Yz1m17RGFMpVjDrzILQTPS9usDDQIiV7nkQaIkVzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769359398; c=relaxed/simple;
	bh=NTKFoTTriFZRbaDXwNX0c2+5oPstU4W32j80Bg1dKyA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iLF08G/2vvEldvUoWjy4SpvwWBSiin1Wh6MAy+IkBBi0SiRbVTcTJQ+xvEu6kw/1Uo583xUHSLElLYQMJ5ArsyZPrVZczH4B19xsNQJjiRhFs59PIyHNlyBvxKdx89oVWmwWfWBxXT1CqFG7PXGZzL580u/QQlHayzrxUj80PGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMe0KuaD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMe0KuaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADEDC4CEF1;
	Sun, 25 Jan 2026 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769359398;
	bh=NTKFoTTriFZRbaDXwNX0c2+5oPstU4W32j80Bg1dKyA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=MMe0KuaDW6arnECymP8c/vduV6GLMjbaqisl6yJEwDLljCjr0VRpeXLoyTlNE9xGi
	 PAffWuHUKAxaNqmtgFqPqacUTDck/AfPi5wf3LnE47PdY6xHcKU86UMp7ZIe0JZhfP
	 /WSTUkU8aKPNAoEFZQJfnRaH3xz979e036Cy+xyRE2QfFkEDK77CZU37/weIMDIxHQ
	 +UQdZus2vscAtfmpEEQAr7AtNa/RVKUaQqh45oGB98d5sjdW8jGja/Trra9p7x6j4/
	 gaySui+OPG2pMUwDvIrosW9Yo40nMjEp6nD40OpZ5f4bw6hqQCr/FCEHp3ORgFchgo
	 6mcHMAhC3ldyw==
Date: Sun, 25 Jan 2026 10:43:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Dixit Parmar <dixitparmar19@gmail.com>, linux-rtc@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Tony Lindgren <tony@atomide.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260125134302.45958-8-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-8-clamor95@gmail.com>
Message-Id: <176935939720.3420868.16882574881889259889.robh@kernel.org>
Subject: Re: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert
 to schema


On Sun, 25 Jan 2026 15:42:59 +0200, Svyatoslav Ryhel wrote:
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
Warning: Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/leds/leds-cpcap.txt
Warning: Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/leds/leds-cpcap.txt
Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml

See https://patchwork.kernel.org/project/devicetree/patch/20260125134302.45958-8-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

