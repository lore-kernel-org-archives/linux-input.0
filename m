Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303052;
	b=eHMdT+pr9oJu0LQCVgTKBOg4V7Lwud20+GtGpkLrTIQiUIOEOzu63/YikMtF7kutrsUK
	 rMyGnZjkhseKQ435aYgVf/BcvVJRZJLnnRqpIaqseyOP1LeVLrVSFuvgqx4ghM/qYHEt8
	 abbc29FbQtmabrKELkkJNAH5NxTaT+gmqYEW1K/bqIeXf+6gqubioOxroDM4nkq1LQcBx
	 wiaBDAfOQzEB3EBOVixfJtbhmseliuz5uTvc9u13BaXvA5C+2Z7SdK5MBRnvQ7oJwsO95
	 tp0L4Rf/efyGtiu1fFEGHVLTL06emDylYHsvnHrbNjjynZd1Th0Agwo+Bio+0S5YY9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303052;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+5Tizt96IR/8Tozykg3mHlCaTrQlzMtblaH2XuL71aY=;
	b=pTj/ze0/mqf5gJknbJ6BoBX3ByOyYdwI1FFRMZTedrWfLXu3EOsYvsq3IVcOv0zgo9JH
	 hwxZKPLV7BwHswphMaPv5savlwX7F824/Std1yoG2Ego3h2wUHd5PsGt3GyedDBVZFhQB
	 Ejbh7HWY0kxoHZy9R+2o1K6aagS97q4p8ElqGb1hNgeqgeSFOf+H3DbYLuXestvIEAoOJ
	 JV0A5pUmjWykTZ5Zy0NuLrnAq1HJMAUO3/6iNNSCTuqO4FNzg6T7mZzVZtPm8ipQJIOgm
	 XYy/tMu/9D3tdZZNHWvl2HNgXoo1nxTlVh6g4iIMSO5S/oYhxB1dX4tZojGx/HFdMlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi1uH7Hr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E5606A320;
	Sat, 21 Nov 2026 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi1uH7Hr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05031F000C0;
	Sat, 21 Nov 2026 23:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795303051;
	bh=+5Tizt96IR/8Tozykg3mHlCaTrQlzMtblaH2XuL71aY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wi1uH7HrP45y9lsY5U1zcFnXwQKVfNojNr8DmXjiBNSrZGz6EbMMcM+ECTy5GSvIR
	 Q4o4NGHhAAPLLKoi+rLTbGa8gBzNmTsL043Kya3D+uYeHIFVDK1gEUXrsVgYbTFnrq
	 4ZZhLIwjcZwZOrT4vKzk0ke0mJgKzkrSNmd5DEcnuat0x+tDj2Om4Z85yEg8e+FXEn
	 6tGRGsyqKTQ/Hjc6u8H1BksIy2HXuzwIb+jGaFHH32ZZKueZkZwu9Ozh0yfSgnPn6+
	 xo63QH3eqGbTtnOk7Vj0FJ757HBfwN7vnAtER2dsnfkldW0Epr42HO+3ZaIMc+5SB9
	 748sxzJKQyziA==
Date: Sat, 21 Nov 2026 23:17:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Message-ID: <20261121231726.71aa1aba@jic23-hlaptop>
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 10:40:38 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> The interrupt descriptions added during the conversion to YAML do not
> match the ICOLL source numbers used by the existing DTS files.
> 
> For i.MX23, Table 5-1 of the reference manual maps source 36 to touch
> detection and sources 37 through 44 to channels 0 through 7. The DTS
> lists these sources in that order.
> 
> For i.MX28, Table 5-1 maps source 10 to touch detection, sources 14 and
> 15 to the threshold interrupts, sources 16 through 23 to channels 0
> through 7, and sources 24 and 25 to buttons 0 and 1. The DTS also lists
> these sources in that order.
> 
> Reorder the schema descriptions to match the hardware documentation and
> the existing DT ABI.
> 
> This change was prepared with assistance from OpenAI Codex, which was
> used to compare the binding with the reference manuals, existing DTS,
> and driver ordering.

This bit belongs below the --- with the change log.
I'll fix up if you don't have to do a v6 for other reasons.


> 
> Fixes: 009528b5aa13 ("dt-bindings: mfd: convert mxs-lradc bindings to json-schema")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> Changes since v4:
> - None.
> 
>  Documentation/devicetree/bindings/mfd/mxs-lradc.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
> index 782b2f4005a0..755029880677 100644
> --- a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
> @@ -87,13 +87,13 @@ then:
>    properties:
>      interrupts:
>        items:
> +        - description: touchscreen
>          - description: channel 0
>          - description: channel 1
>          - description: channel 2
>          - description: channel 3
>          - description: channel 4
>          - description: channel 5
> -        - description: touchscreen
>          - description: channel 6
>          - description: channel 7
>      fsl,lradc-touchscreen-wires:
> @@ -102,6 +102,7 @@ else:
>    properties:
>      interrupts:
>        items:
> +        - description: touchscreen
>          - description: threshold 0
>          - description: threshold 1
>          - description: channel 0
> @@ -110,11 +111,10 @@ else:
>          - description: channel 3
>          - description: channel 4
>          - description: channel 5
> -        - description: button 0
> -        - description: button 1
> -        - description: touchscreen
>          - description: channel 6
>          - description: channel 7
> +        - description: button 0
> +        - description: button 1
>  
>  additionalProperties: false
>  

