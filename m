Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256810;
	b=oKNPeUWNtdmEajrtKsg7LNkMHLltf0YfPBLsINAZemiL7NcsoCkXRgxcxkEx4e1Qjww8
	 pOwvcQOb30bQcUSZvxO0q1Gd3vY6hM5/pp/G0w3aBv/In1Jq9QtnklmuEVFKrB9ThO73T
	 2YwT3uoiVuI91J6dzSkCtniX1siAU/4A3Y9YtNEcDLVy5E3hHRI0PrCdivRS5SUErT+RW
	 HgGjYS83Ycv9RH4ophlKU6hKZOYsHmMTa8biwdmp1deGUbPZd+JwXQOWwnT85m6ruHYwh
	 HKOlCW42lDRdV/yQsCc5/kUsZ87IXB4FZgBIbbRVZ9j5RrklEP0pkCNuJu+ygzY0UbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256810;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rj24zNyI6Xn2B8xgUnQ8Hw+qn6LQJ3HqbXwAdOsjEsY=;
	b=4vBn7M+PJzmtBgyhlSP9euMFA8pd+3UYHSD6nCnBRw4MmOCplWY/T1Fj6eO6Li4RSDLu
	 hJ55VXbADqa5zdgMznuFh4PlcsRzI37qwJmHnvKQibqt3ztxgmeZOXev4BmD/GBPO6faL
	 2NwskrGOAM2YhxnkS87rNeJl0BiYm6wP/U70gM4/vo40TzgZlKHQ7nqbo0W78Q7ljR62g
	 G6wF7ki2VDHoHbidEGKQQOQl2cjyYwOIODdp8xPk5rTVC74dwPWMpQLdNsjT5MH+8T8Nm
	 h+aLfeyP8RZ++riaWuAxY6W3N/Tq2OUtsD1p2YPdP7Y5AV4Jv2X0F9U6ameJ7ajGULg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEjbVc6Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14B606A320;
	Sat, 21 Nov 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEjbVc6Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A01F000C4;
	Sat, 21 Nov 2026 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256810;
	bh=rj24zNyI6Xn2B8xgUnQ8Hw+qn6LQJ3HqbXwAdOsjEsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lEjbVc6QnC6/maHHkQCxTPTT447938tp4SQKelX8yTDrb6WtrwClKL9FV//9UaP1P
	 LfcjQd6CE6xAvIAYAR3hMIAlWGdvDNcHWOH/O9/WO65emAbTxgubILfIwGY44YeE7z
	 8o05b5R/DWblDDAtA11uZLy8y43IUDzgxprHKY5QNS6U8COnDyK8p8usRFv32fsIOM
	 jcBP+BIjMn1ojvKiMuH3ZNEf0juwmmUqoidkc0R9EURUxC82k2bZYoJZXbeSEU9shZ
	 mlWDZFVCX874vxrXbmqkB9Pp/VvHSkCjFxuXmVOGbBCcrTDBX3koYfVnCAZ5Ku/0wc
	 2tnSOgk8dIqcg==
Date: Sat, 21 Nov 2026 11:26:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: display: panel: add LG SW43103
Message-ID: <20261121-authentic-solemn-ibex-d3e2a7@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-4-rofikcoga@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-4-rofikcoga@gmail.com>

On Fri, Nov 20, 2026 at 04:54:42PM +0100, Abdur Rofik wrote:
> Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
> uses DSI command mode with DSC and DCS backlight control.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  .../bindings/display/panel/lg,sw43103.yaml    | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> new file mode 100644
> index 0000000000000..7f44ac6672bda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG / BOE SW43103 1080x2460 DSI cmd mode panel
> +
> +maintainers:
> +  - Abdur Rofik <rofikcoga@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The SW43103 is a 1080x2460 command-mode AMOLED panel used by LG V60 (timelm).
> +  It uses Display Stream Compression (DSC) over a 4-lane MIPI DSI interface.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lg,sw43103
> +      - boe,sw43103

I don't understand who is the vendor of this device.

Best regards,
Krzysztof

