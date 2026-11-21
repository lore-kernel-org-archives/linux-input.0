Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256840;
	b=5siCVkTIAlwzGth4wViVsv/Y7jhjWXR0gRaPlzD1DSb8qARdlFLJCugN6BLXks7V9RAI
	 3uVUUxFnWcX4qWY/p7t4uSYNo9SF87YP9Rpo1eJzp1tWYEYLES8j5T5Ap99q6ie8Cg5RL
	 KVHIGuSWQxtBfnb/XaRSOdOeRl7YQ9UeMSsi2f9CsVpnrCfzWMD1MmhjU963MPHo1hI8b
	 YnI7eazvB1eCPi+bXtumWiqB4Ri/KvEuAZfJCDfgPsDBPeVmik0ePpNjERrwDHutMW2ME
	 jDXX9Vx/XSWvFpZ2WNCpjS3PLD41kaW7bq+J9SRbv5fQ8f88fsLlWQE67Q5NoaHyKNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w4biS262h0zqd2DW2+xTp/yTJKOFKJuy+vEVoZ/SGAU=;
	b=BKXscNe8K+LA0GV6KfPahSLgWlKkN1t8i6oQhjiR2Bmx02vTyXO5LX3DRsqrLZ2I21en
	 5wEY9DbTsieZwIP4Xb2o7zyRJo3RoTmqLcfP5pObung30XvM2P6Y2q68byEbtboXzIddr
	 xMebQMoN/cS3mM6j0BjgEiiaOQFXYxkQ9FXxeHhsEAUYK4hU0+POF4SLvJzoI3PVv3Tkg
	 SVUUp9CvV4s8NZ5rK9ewnKzjTQPqx0Lr5X46nY9HU1U3Smqc+sjSKONRuc9JV0OAKHYL6
	 1G4vKSVPuZYNHjFs8JccHad440BMrcSurm02aesxqO4uqZpesH3U1326IlEm3ge/v9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THAIw131;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46176606A320;
	Sat, 21 Nov 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THAIw131
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278B41F000C0;
	Sat, 21 Nov 2026 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256840;
	bh=w4biS262h0zqd2DW2+xTp/yTJKOFKJuy+vEVoZ/SGAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=THAIw131aUJxZ4jdL0vLlrgjtLomDPAxSjHbBH7hf95SDCoa3IR6es9PsVLf7fiv6
	 +BRAFQGtHZRmSO0RSlpm+Oa3Za+oJNDi+VCVfW7726/95z5JGTjLsRw0N/TEEM2SdR
	 NoP3eA5IPT3RWNfSV/hI49tnbarOb58MEuxBn5+kPgtn+UumTaOGLjzYWb5/38yXnQ
	 DEN6LlMoHeRxJ4y0a1HD3lGIP2tPttWnndWCFZcq1X0L9a2R4Cxr55pv6wedY5spo1
	 /0BY0cSJUjwezxvrH622lqBLg6LxNbH6Jn2dhWpbAGqKkUMrZoG7amPsrrAxiJn6Py
	 1afIwyargcnvw==
Date: Sat, 21 Nov 2026 11:27:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: input: touchscreen: add Silicon
 Works SW42902
Message-ID: <20261121-wild-corgi-from-neptune-6b19d5@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-6-rofikcoga@gmail.com>
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
In-Reply-To: <20261120155450.7719-6-rofikcoga@gmail.com>

On Fri, Nov 20, 2026 at 04:54:44PM +0100, Abdur Rofik wrote:
> Document the Silicon Works SW42902 I2C touchscreen controller, including
> its interrupt, reset GPIO, power supplies, and panel touch properties.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  .../input/touchscreen/lg,sw42902.yaml         | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> new file mode 100644
> index 0000000000000..2d6d9b1500faf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Works SW42902 Touchscreen Controller
> +
> +maintainers:
> +  - Abdur Rofik <rofikcoga@gmail.com>
> +
> +description: |
> +  The SW42902 is an I2C capacitive touchscreen controller used on the
> +  LG V60 (timelm).
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: lg,sw42902

Silicon Works or LG? Confusing.

Best regards,
Krzysztof

