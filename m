Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CE2264CF;
	Sat,  7 Feb 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770472567; cv=none; b=Pwx8pYWinGktTSiE9856MN65ahsyYZSXQIKaq36QqmlXICXQGrJcLKoJ2xCdqibeLXfEZGENcLpubKJgosPR9eISL1V8YkSw7cU5sF6twIWQk+nPmqzTd/7gvEgdXV8xNABtBxZX9W5/tbS4P9nHKvtZN5oVjwMLtddx/zauJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770472567; c=relaxed/simple;
	bh=W5PjjjoktqQ2GZfNRkvT4/j3dV7dmxs+3CHuWlmNPaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJuY3v772W+Tx6OlqGtzraPWsbx3vsWeZ/Xr2FZIbHvUZ0crpPooPET8xCIfZRKjbtEkwz4lWabArxHWGM7z6IJcb6ZV//2wTrFzkID9VHihaQn6FEd+W+73bRZ6b3Q16EuuU7aarqaRuNhRfeO1CjaAyu++dAO1EWtgLT1PDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdPDZCmK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdPDZCmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69987C116D0;
	Sat,  7 Feb 2026 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770472566;
	bh=W5PjjjoktqQ2GZfNRkvT4/j3dV7dmxs+3CHuWlmNPaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XdPDZCmKwSqrKAqq90X8GE/XXvAYFgG13/41bhyTJjRq2DIWtkid/wo5l9PLfW7Fc
	 7qAehFDgsfK17z4+7OB7JG9S7rcfngeDd3Etil8GPv+GFxDhycOogcims13P1SD40N
	 S6XHzaQm8JE4zdertU/qaFLB6cJ+5eQayMFpMxy/zaqcB1/zHjr3k4gjGUfj0ZQSni
	 SvgY9WoYPRIoNQXOn3rxPACU6T+0bPYL6ikCBYKKEmaaOHQcAs1pm7JlM71CBNwhB6
	 C/Usu/xgIyfKotQ12rIVkGowenhv5Ui1+Kv9U/jebzdYbKPqGkPw3QCWVWNw0ZcDH+
	 m0bytEcygTh2A==
Date: Sat, 7 Feb 2026 13:55:55 +0000
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
Subject: Re: [PATCH v2 05/11] iio: adc: cpcap-adc: add support for Mot ADC
Message-ID: <20260207135555.6e82e6d3@jic23-huawei>
In-Reply-To: <20260206172845.145407-6-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
	<20260206172845.145407-6-clamor95@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Feb 2026 19:28:39 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add support for ADC found in Motorola Mot board, used as a base for
> Atrix 4G and Droid X2 smartphones.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Applied to the testing branch of iio.git.

thanks,

Jonathan

> ---
>  drivers/iio/adc/cpcap-adc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index d9ee2ea116a7..f6f72efcc6ed 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -934,6 +934,17 @@ static const struct cpcap_adc_ato mapphone_adc = {
>  	.atox_ps_factor_out = 0,
>  };
>  
> +static const struct cpcap_adc_ato mot_adc = {
> +	.ato_in = 0x0300,
> +	.atox_in = 0,
> +	.adc_ps_factor_in = 0x0200,
> +	.atox_ps_factor_in = 0,
> +	.ato_out = 0x0780,
> +	.atox_out = 0,
> +	.adc_ps_factor_out = 0x0600,
> +	.atox_ps_factor_out = 0,
> +};
> +
>  static const struct of_device_id cpcap_adc_id_table[] = {
>  	{
>  		.compatible = "motorola,cpcap-adc",
> @@ -942,6 +953,10 @@ static const struct of_device_id cpcap_adc_id_table[] = {
>  		.compatible = "motorola,mapphone-cpcap-adc",
>  		.data = &mapphone_adc,
>  	},
> +	{
> +		.compatible = "motorola,mot-cpcap-adc",
> +		.data = &mot_adc,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, cpcap_adc_id_table);

