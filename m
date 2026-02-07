Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE91243964;
	Sat,  7 Feb 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770472547; cv=none; b=HHrNmZkSLEgtJg+B2dk1FSyU/X4hujSE7UGy8brKGULdA6hFaJ8o7ogtUapKWaH+FjND8q/75hdeClNk1J2nvpeNk8K46/oHlJQcmvpuHLR6MvAuwDCFhCU4oVCqTXGVUgybO9wzeIxO4/tgL5vDD02hhI5vPgDiVGPJhyUG34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770472547; c=relaxed/simple;
	bh=52HdvhLl+Rj+D0U25RyCmlrmaka83KzgV6WDZKvInCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4uaNHxgXrsiQkWjEjwMTXtWe6QIxxEj6s//+o+3V77JSHSYC0dgXMabMy845ve4FSuAqFiYapBE1zaIkT0sNy9MEk4LlZYDSQoGSMMuLtE3f5xwcQOg2c83e9aMeC4wBA3SRwJG4eQfwgW5bhwMxJBKSDELZsI2MajKmLx1tXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0tjHTyD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0tjHTyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150A4C19422;
	Sat,  7 Feb 2026 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770472546;
	bh=52HdvhLl+Rj+D0U25RyCmlrmaka83KzgV6WDZKvInCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d0tjHTyD1T6o2BOyOj7ViDjHcJOtDAY6Gb3/UGwKhQupAzwbpPDgQwYM77lkVPuP0
	 QGLj7H33NMjV2aes42SwROXx0UU91vOVLlVL0oskrAfWzGdlGxTPkVtZnvWfOCWfml
	 CcglOzzXzrCWf6em1eCk7JlMDy6rlTHden2FzhzBdiQoOeemnOPf7tt11Rp5DAbyeY
	 1YyTMn7bEUrXB24pTqct72WabARXvGqVZPKz2CMXOHIojpZ8VTtpde2r4UE23Wp3nY
	 RjjKFNFDhMhEf8JELUnzIdUXtVX7KlYXAjWajesxvufDaa/Km9696GYtZtg5n6SS7I
	 9kd0jkGjj2vgw==
Date: Sat, 7 Feb 2026 13:55:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee
 Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dixit Parmar
 <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: iio: adc: cpcap-adc: document Mot
 ADC
Message-ID: <20260207135534.074af78d@jic23-huawei>
In-Reply-To: <20260206172845.145407-5-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
	<20260206172845.145407-5-clamor95@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Feb 2026 19:28:38 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add compatible for ADC used in Mot board. Separate compatible is required
> since ADC in the Mot board uses a unique set of configurations.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> index 9ceb6f18c854..1f77da7f8e06 100644
> --- a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> @@ -19,6 +19,7 @@ properties:
>      enum:
>        - motorola,cpcap-adc
>        - motorola,mapphone-cpcap-adc
> +      - motorola,mot-cpcap-adc
>  
>    interrupts:
>      maxItems: 1

