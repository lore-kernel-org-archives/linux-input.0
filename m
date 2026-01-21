Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F803C1979;
	Wed, 21 Jan 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997063; cv=none; b=ONIltrPk13WVCehojVLFzEPF0wJ9zznqfCFL8l5dIgG9U+7e6rcm1TM1Mt2P0fMrtmyjtoH/qA9zXOH1rvJmE+JwMDlD2srufp9dr76FJurUVMkedzi8YBEaKqqCzKe3TUaEVPv5M3+zw0QbH6kWpEGJll9c2JrUU1ZhaA1fqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997063; c=relaxed/simple;
	bh=fscg7F9qmoA8q32bv/OWU/zWgcW3dnDHzT+e2EX+A2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoAfF2aXksZnwwUFnmfrl6Unj01YUeAHLZNRTAmZ6I+q/eUZUYKtw+uuEY/En6OWDlvzBntRq+6xojxBwMar3MuIh5rxW3lJYT8cM6Zlja5iwE/vRDIilwZ+FxXyVkIPDTYiynso91Oyu1x3PM8aHaCvXJ1UCMO80iF9EPxahQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKFL/i84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKFL/i84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A8C19424;
	Wed, 21 Jan 2026 12:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768997061;
	bh=fscg7F9qmoA8q32bv/OWU/zWgcW3dnDHzT+e2EX+A2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LKFL/i84tVSHT4XxbCsZ9CboHnBFg+o8ZNGU7qKqx/8w4N0tCWpz4w3Bfr8t8jXAr
	 CDUrC90DUhMcruET8cHT84nxZ1CbKmWBjR1W7eosHbkpmvRbp8/TUav8lWp/Tmttms
	 O7RQGLHZhfTa5nW78K8MkzS3A8h4ZQf3uT0o5KvKxBr5RjSbe6yWVPgwx0/7sP3yrX
	 k/o3uftONGXz5qf7ClEceeMxNLID6Q6Nxbusg3/AwePiICV4rDpG5Kvdywa9Z5q6ZF
	 r55Wdf/nBR/qtY1zlHEJY9iBmIslFxS6o1hYJ687qCNOd01B3tckIhfBJnR/BYwpTV
	 mqGA2+7ApDf7w==
Message-ID: <b4113f8c-0fbd-4a96-9cf6-9675f837ac91@kernel.org>
Date: Wed, 21 Jan 2026 13:04:17 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] input: touchscreen: novatek-nvt-ts: Add support for
 NT36672A e7t variant
To: Gianluca Boiano <morf3089@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260120193600.1089458-1-morf3089@gmail.com>
 <20260120193600.1089458-2-morf3089@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260120193600.1089458-2-morf3089@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gianluca,

On 20-Jan-26 20:36, Gianluca Boiano wrote:
> Add support for the Novatek NT36672A touchscreen variant found on the
> Xiaomi Redmi Note 6 Pro (tulip) which uses a different wake_type value
> (0x02 instead of 0x01).
> 
> The touchscreen was failing to initialize with error -5 due to the
> wake_type parameter mismatch during probe. This adds a new chip data
> structure for the e7t variant with the correct wake_type value.
> 
> Closes: https://github.com/sdm660-mainline/linux/issues/155
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>

Thank you for your patch.

I don't think that adding a new compatible + a new nvt_ts_i2c_chip_data
struct is the right approach here.

I guess the wake-type byte simply encodes some IRQ config settings,
which may indeed be different in different applications using
the some touchscreen controller.

Instead of adding a new compatible my suggestion to fix this would
be to simply drop the wake_type check as well as drop the wake_type
member from struct nvt_ts_i2c_chip_data.

This way you can fix the driver not working on the Xiaomi Redmi
Note 6 Pro by removing code instead of adding code :)

And supporting other models also becomes easier.

Regards,

Hans




> ---
>  drivers/input/touchscreen/novatek-nvt-ts.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
> index 44b58e0dc1ad..b1c379d87de0 100644
> --- a/drivers/input/touchscreen/novatek-nvt-ts.c
> +++ b/drivers/input/touchscreen/novatek-nvt-ts.c
> @@ -323,9 +323,15 @@ static const struct nvt_ts_i2c_chip_data nvt_nt36672a_ts_data = {
>  	.chip_id = 0x08,
>  };
>  
> +static const struct nvt_ts_i2c_chip_data nvt_nt36672a_e7t_ts_data = {
> +	.wake_type = 0x02,
> +	.chip_id = 0x08,
> +};
> +
>  static const struct of_device_id nvt_ts_of_match[] = {
>  	{ .compatible = "novatek,nt11205-ts", .data = &nvt_nt11205_ts_data },
>  	{ .compatible = "novatek,nt36672a-ts", .data = &nvt_nt36672a_ts_data },
> +	{ .compatible = "novatek,nt36672a-e7t-ts", .data = &nvt_nt36672a_e7t_ts_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
> @@ -333,6 +339,7 @@ MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
>  static const struct i2c_device_id nvt_ts_i2c_id[] = {
>  	{ "nt11205-ts", (unsigned long) &nvt_nt11205_ts_data },
>  	{ "nt36672a-ts", (unsigned long) &nvt_nt36672a_ts_data },
> +	{ "nt36672a-e7t-ts", (unsigned long) &nvt_nt36672a_e7t_ts_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, nvt_ts_i2c_id);

