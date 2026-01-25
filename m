Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C818320A37;
	Sun, 25 Jan 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769358491; cv=none; b=Xz9x4klgwc8+E1B/eJ/ovoAoO0vgrF22UU8wYhwjQLUGntbKKx3WXN7vcHMgo97sfB1CditYuoswfMUsgpViXCMWp51BwVFNSmEHBc715sjg2zegJSG43eC7yT1kmAFVTgkyI1Lb40tp9pNMcrn5IDTRYxvp8GVXFckujBrxCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769358491; c=relaxed/simple;
	bh=/kBVfEeJ/g4AP/VjKN8A4Uzwnf7UltFNduXdvjV67xs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YoAV/iKHsGgQaCq3b9ulzyLkwen8YDJmRNQARTQ72f/ZEANY0+PbuSBZ5wIII+8BRegJLTEMjo3qXIM87jg+0urVSg/I7JoTEH/TKoM6ORJDJUKt73dtotqi911esX1cMrU5/jRISUirtjP5cepTVFRQvj1TjV6FXdz3hxszCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekgsh12L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekgsh12L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153BCC4CEF1;
	Sun, 25 Jan 2026 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769358491;
	bh=/kBVfEeJ/g4AP/VjKN8A4Uzwnf7UltFNduXdvjV67xs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ekgsh12LUQ3AXmJllmcATFerorX1tckcRHS6TTtIyzOEPAd+aLEf6ngWb3Lg77xLL
	 QIS8dBXGNCjLK7ggRb+JMW7BmRR10b4mKIPkeI6IoimTs22W9D73TjTHptWvqw93L9
	 yct82EmEBrkkD4R4U9LXyTzM1xWcaGyYk0npwXpiT4At5Z6le/mAztE70P6tUzNTr7
	 J4TRdmMOKQH+2QEqfq4OfU9TdznqBeKjLEMg8KOZ2XOnfRHom/6IxO7AE86h9PSIYJ
	 gDlN+m80IFHrQcDe0BXnhd4FXF40KvQkh/oVTjB/pOyDbL7kDsgX4T7pa/wh4vhRJH
	 HrcTt0RCDvViQ==
Date: Sun, 25 Jan 2026 10:28:10 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-leds@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>, linux-rtc@vger.kernel.org, 
 Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260125134302.45958-7-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-7-clamor95@gmail.com>
Message-Id: <176935849015.3303521.6335397364292112478.robh@kernel.org>
Subject: Re: [PATCH v1 06/10] dt-bindings: rtc: cpcap-rtc: convert to
 schema


On Sun, 25 Jan 2026 15:42:58 +0200, Svyatoslav Ryhel wrote:
> Convert RTC devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/rtc/cpcap-rtc.txt     | 18 -----------
>  .../bindings/rtc/motorola,cpcap-rtc.yaml      | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/leds/leds-cpcap.txt
Warning: Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/leds/leds-cpcap.txt
Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml

See https://patchwork.kernel.org/project/devicetree/patch/20260125134302.45958-7-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

