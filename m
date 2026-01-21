Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01D441056
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035213; cv=none; b=goI8zsgAOcSPEqr6VpUNzmNThbtcSMM9gcvrSEcfEUff0yHgnnpTTstU5bOcQ2ZA5g6T5XSM1IjyvjfbuPnaXOcEiidaXvQ81WWJ04+jP55uG2IMpYMpYJGmm138qaulQOidRAuscnzDHo33hw0Smb8ZF+lPwhZZuGt/Mbqlezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035213; c=relaxed/simple;
	bh=JdgXeLjUwvEesiS0RCBqXWrFZLcAAAi4LcdoGUe7jds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oejRlArtJWPQ3lYV+tStc3bHifBlG9/P5ehzwDwmQM2FzIuPSgcucqbsiLfAbg3xo1QE8TOGrhk6XonILJLSXtXU2YhjUft6g29/soRjZ2/56+nDTmC+9V3RyDcKlUasOfG0BIjByC/g8ws2FV0f4zGHcI8dzByUAGQ367lK/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0AazBor; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0AazBor"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12339e2e2c1so273523c88.1
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 14:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769035211; x=1769640011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8oqHlhFvEc8dTBSDMJ627w8lGEZ+DhUI7JdmSEBy0EU=;
        b=c0AazBortZlYBNSLLhstayLY2lYhRjJopS/CRsrU60C803MFi2EyujexFiSHwa7KDV
         o7HASyJc171k5gNjSeyXlWBk9tyu5g1+1fNz5s0NCKQ6+MP9GfvN4wuaGV/CjkKTzRT1
         q1WUzRqhbPvUVooJtjTx8sa+JaMwCowgoF8q5pWUUNsMEpfrRYv1qFOOKp/ckTZDt79I
         PhyweF5QTel9gsQyF5MEEDvpXAGQksEpjm+HQlFaNXa33whGSahkrvcVj3Kp0F2VzOKi
         zQ1FGxmmtGp3BkGu2fO1PKZWMqGzJbGwrdztZkcy/VkF0FwYcIoaimsA6IGS6Gsk6tOG
         PkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769035211; x=1769640011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oqHlhFvEc8dTBSDMJ627w8lGEZ+DhUI7JdmSEBy0EU=;
        b=BozodR0+Q/N+NMBK3O4IjgQx1bYwcwFnntVyCStPoqIs+eibtE/kd4npBdhpHqUn1p
         LXARrJcVeYZ9z2FwQ0dsFfVDcCEoMf2/cN+sT2J8KrWdCAzmLPbM2jIq65vnEMr3cBiB
         K8/KaOqSPyBaEDavplQ57KrQFQ/vpwFjLHdG7ddz5m6lILlWeiNKuQZS9A5s7fp2XLM2
         bCRSaj5TX3AV/dvVex9pLsOJuTASBJ7t3aXuyPNdLSMzRChhQ0993fzGmZfQRWcuZ4cv
         Hh6kLxJzUo6CYBQ6B/0hNWybtH67TNEzigiHEqD6sO5JV8pSNyuQpRhD7lRFQu6Ph7yi
         0ZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWQLPpjO6ipGE5lzxNWj8VktVd9/LwkRRDhcgnGjdFVywtGw+Shu14d8PQwJHpj30KD6ipJJG3xym5tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7ertTpzIqkULUOUcypzuAQgcef4QG/N2jUMA67zJ0GLsHSvG
	w8Ymd6WUEQb0vpToGxzp4GQPRTT1YtRIDMUmnYAyUWorRrzwuZ1lnAUWIVr4aQ==
X-Gm-Gg: AZuq6aIYU7YxJZhxeKnc4xpdoIqD5hVpwtbNn2KEhrD3JSAhDlrhyddFUM1NaA8Hik0
	KUc1vAUwLs02r6IOdLXdQMBrHTXszXkeByRStZ5MENYPXEE/a02triBsdBzl3eDXAnawikR/C/v
	c2SCJewWgI6bVLu8YckBR23SdF1xpicr7wgCjMvIk9pome/OVxFBk+H82huioS1/ryI8Y5WplS4
	G0/tOJzpIJsHO5Sbwjto3bmwFvlk4vJJ15GG69gsjd5C+UH9UwKOKwsFrM/YXCrS0tWghgxWYmL
	LJ1Ah/EICSHhVkHkD51v/0BI/88tFTRWyIr4ThPposIVKpAMWehuxiTVwv5U3fB4EieX8d9SdLJ
	JN09T0cNTGuqOvdi3PXeIChKzy1H5Xp2QwhptjEsnbZoWp/zlpg9/TMBhHEKr0Fmf1xGblIXAbd
	yYZZPcPqv5gDy84ySU9FgqQmTOAsezNdT820mkriPw8DcVltXWAB8Q
X-Received: by 2002:a05:7022:a91:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-12476ab27edmr594415c88.12.1769035210731;
        Wed, 21 Jan 2026 14:40:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6fb72e477sm8717342eec.29.2026.01.21.14.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:40:10 -0800 (PST)
Date: Wed, 21 Jan 2026 14:40:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dianders@chromium.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND 2/2] HID: i2c-hid: elan: Add parade-tc3408
 timing
Message-ID: <ffqvva5kgyh25mpquackob7fnlaxseu5stgevneqynwa7m77b3@totpb762p6te>
References: <20260108063524.742464-1-yelangyan@huaqin.corp-partner.google.com>
 <20260108063524.742464-3-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108063524.742464-3-yelangyan@huaqin.corp-partner.google.com>

On Thu, Jan 08, 2026 at 02:35:24PM +0800, Langyan Ye wrote:
> Parade-tc3408 requires reset to pull down time greater than 10ms,
> so the configuration post_power_delay_ms is 10, and the chipset
> initial time is required to be greater than 300ms,
> so the post_gpio_reset_on_delay_ms is set to 300.
> 
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Jiri, Benjamin, another I2C hid with bindings...

> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> index 0215f217f6d8..2a6548fd234a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> @@ -188,11 +188,19 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
>  	.main_supply_name = "vcc33",
>  };
>  
> +static const struct elan_i2c_hid_chip_data parade_tc3408_chip_data = {
> +	.post_power_delay_ms = 10,
> +	.post_gpio_reset_on_delay_ms = 300,
> +	.hid_descriptor_address = 0x0001,
> +	.main_supply_name = "vcc33",
> +};
> +
>  static const struct of_device_id elan_i2c_hid_of_match[] = {
>  	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
>  	{ .compatible = "elan,ekth6a12nay", .data = &elan_ekth6a12nay_chip_data },
>  	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
>  	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
> +	{ .compatible = "parade,tc3408", .data = &parade_tc3408_chip_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);

-- 
Dmitry
