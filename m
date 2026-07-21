Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBF2EB5A6;
	Tue, 21 Jul 2026 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635298; cv=none; b=K2CbrnPWESQG6G1+mKkTAqsofKOVhCB+Zjb3CLsTfaRSXA/jxooeiboQoFOtLyXPH8xGXkjm9UAR1Mhraz9ja3rBVU9kVgX+tCbOkUIA5Rzv4/t6XK3MZ8yKX1rT5sLCCt0K9tu6ToP0smnhtsQrKGW6fdfONEeKEtPIO9do3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635298; c=relaxed/simple;
	bh=vt4KNbYORQLKbRSdmhkkkQTOj1Tk43cxO9SyU+3mqVw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dN1sg+s+e+Ecx24inFV1CKrGREvhTgdfyNygNv1Bmd8RgvceZyRuoaIG05g/cz8j2sXb0F4FjdCKysR2zjb92fyA27iJl9uWKND4tI+ZbyIQAHktbk0vUOduiptka7SNDNpSKN8HIlHq6y+cocGv4LZJFl+WSENAjoq31VoUhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2ZGgyLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2ZGgyLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A91F000E9;
	Tue, 21 Jul 2026 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635296;
	bh=Ai8wjS8jc266OX3XQiL+6NPr38ZIhEOl/m/VNn+51N4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=K2ZGgyLhDmmHeGamiz5ULT4/CwNISwKqeCfewb9byYfFeXkktXNTcS8WnpzqUjioC
	 +oN9w1olxkzbJzj14fcHdJ6lhyJaXV2DAC0nIo+kikH1uFqxZ9h0yjWV4lWyKvZP3w
	 GQX81tjS2kqqdoWSmZP0YYZg7xYCJx/z+upzXzeNtqa+p14/dc4XZt+192CVy3bcnS
	 H3E9IOw9QrXHKsm6KsaXfFi1vTykuWe4KxzmBHgzxfSi+kLa+XwMaj2uJD/ZPJNYMM
	 k3pp2jfujfbEUM799Vhxz4VlUEEQzd/diJ2IvlVOZ9ZGYLwJqfoZi1suGYdYC91xGg
	 vvYbA07QjCQ2w==
Date: Tue, 21 Jul 2026 07:01:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Lee Jones <lee@kernel.org>, 
 devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260721095654.429346-2-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-2-clamor95@gmail.com>
Message-Id: <178463529533.2776661.17291216407355479584.robh@kernel.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: leds-cpcap: convert to DT
 schema


On Tue, 21 Jul 2026 12:56:48 +0300, Svyatoslav Ryhel wrote:
> Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
>  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/leds/leds-cpcap.txt
Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/leds/leds-cpcap.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260721095654.429346-2-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

