Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941C283CB5;
	Wed, 20 May 2026 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308020; cv=none; b=uQAb5fj3NIFPALtpHfCohqZY6eovuOdaBc9H+BmZdaF+B/mZns7jIj8aS2YYCDOUsbvw8mcHUcgWk9mGdf8RF5+DVhmBQvC2J4wHYLvjHm8QenbupOlZdCKfmbjPLGSVcLaIapZZrw7aTtaXkBVtipgxswsKv3120ILzdgFiVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308020; c=relaxed/simple;
	bh=YWOykokvSunWlJGCv6gQh8IA9UYPjKXXXSSKo+kEn/s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lH+Vzf4w4diyuigAFRd3hmKINwbZormJdoIsuoEzkeqEWP0h/e0w4gpKWnixQEvRU97UH8Rc6tq5v2B0EYNZj82PzkWRNR38fnwGjxuFXoBvg+79QFzXVmHdP5VkxqqTPq1Bvnfo7AoL65E3DO7PKog0jiJeaUKJGe3JLbUf7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWLxi8Tg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWLxi8Tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681021F000E9;
	Wed, 20 May 2026 20:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308019;
	bh=ip8UhnLhZVRUTvuSbuKZx7fgIiSx5T5PZckISIMWYfE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=TWLxi8TgKxQ3k8C7+9KG/U8oP1M8SJFzfPB+hcGLPzBzW+6rGWCUhiqvnYnsjJMew
	 2avm8TLFjmEYxYUEHSV1JGMOfxUkM8Ed8LggOG6if9NVyrj+ydujJkBklJ24rJeQZ6
	 tujD0sOXDSxM2ETNC8BxV55BAHeII01Ccf5XKUafSxV3ztQ7ZT26/cDv5D0kYaAW34
	 TIEoEKzI5+hh25BEyRZ8Ip1HuD777XwkiP5pkDryAejBKoV/y2+Wb7U1JqESSHDMa7
	 Ft+OqTIoqY+YPhDHgaI+gRoAfKxOkyd4xhMle6wvOoPC9pFnK6P4lwOYCTs5ThUW8Z
	 uu+G1yudgqzzQ==
Date: Wed, 20 May 2026 15:13:38 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260520182124.117863-2-clamor95@gmail.com>
References: <20260520182124.117863-1-clamor95@gmail.com>
 <20260520182124.117863-2-clamor95@gmail.com>
Message-Id: <177930801788.740456.10278434130014876879.robh@kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: leds: leds-cpcap: convert to DT
 schema


On Wed, 20 May 2026 21:21:19 +0300, Svyatoslav Ryhel wrote:
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

See https://patchwork.kernel.org/project/devicetree/patch/20260520182124.117863-2-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

