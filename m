Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6683612F6;
	Wed, 20 May 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308021; cv=none; b=oM5za1ZlTA461miqvRRF/+ICIxwYEPWVpqjLnsKDFDaL7/H9oqGAhPnsedelMh1IlTD+zfS7cJPsQRJAAmUT347XUge742Pt8KFm7vhH5UxxzThvYnjqulfdj2AP8WR/7mbFSKBv8R1wFaZX2SSnbfXO1RjCt6hPnseqZOw9hcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308021; c=relaxed/simple;
	bh=euEms7TYqrmZeVjCBuiSh+bd9lVKE84VjjxrkAif1Ho=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=B2aZaNyZI75p7mojWe9CtFUe9mhbshE04X5OJhOkk8EOmacxe7h5F+HlvTeXn50DTdiBJ1gle5ucXYCnIXZ+WPE2q77OcWTPvdPVoVt4DfO0kEH6kkk66duajNPUM4wWCXsS7OJYXp5gufNSEwNeCS04mkHXIUByzCILzfSa7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8gqUlyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8gqUlyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B21A1F00A39;
	Wed, 20 May 2026 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308020;
	bh=Tsdb10MCYeVuX9T+8C6WQO30wsviGsRuozwkSNDJ4+0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=b8gqUlywO68AJVjSw6858va6PLMLoLRNok5oYtr2P3jDUX7fZdS9kLk+YHJ3NoM9C
	 ZTPnveb5ii2sQq4F4InWqZxJVSkNsDBPTuqy3shqaNLlDR6ZSRIrt+F4Oi0mWbhYBx
	 ohDSxjNHAG3K4Vioc+Z5uUj503qOK0KbRjD5a8FdIC8u/6JXZyn+V0QepoqHkYackZ
	 fdAcd8B+H7ckm6P7I3JkElwRnr71yKYsbA4MOeeqlVLgGlum6KzkAumEVz7MxxI+5a
	 XM/+SO2X5B/ipkw0CXNEjuVjZ54v2w+nO+poH/UyXA6bv5lJmxXkXbWU5G5bRaptye
	 Jxdxp/5os3PBA==
Date: Wed, 20 May 2026 15:13:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260520182124.117863-3-clamor95@gmail.com>
References: <20260520182124.117863-1-clamor95@gmail.com>
 <20260520182124.117863-3-clamor95@gmail.com>
Message-Id: <177930801875.740485.17278647053731389937.robh@kernel.org>
Subject: Re: [PATCH v6 2/6] dt-bindings: input: cpcap-pwrbutton: convert to
 DT schema


On Wed, 20 May 2026 21:21:20 +0300, Svyatoslav Ryhel wrote:
> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

See https://patchwork.kernel.org/project/devicetree/patch/20260520182124.117863-3-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

