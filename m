Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8583C427A03
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973994; cv=none; b=RG/9pN0zlNOepE+T15fenr9Qj5IE++t2mXtBM8WeNBRebt/58HtuXeu2DAi4u0HiU3EmoJxc/FaUA8cXTxaY9PRzrYfK9jxiwtNSWwRQGyz0a7SclF7LBNYOGaAU2ff/o71Z8F1D38h3MHyQs/EeVIVByTl9nU2q0f20LI+nF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973994; c=relaxed/simple;
	bh=0tBodSYCgkMr7ybzGmQDo7w4mEHIQJuBjmw5ze2hCsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhh/ONQktjSXg9QN8bh+SkDhsI6GVpdu1e4ra3uzAIyNgRgxNTQqLAM6QPrz31XWQRXbwaNGHYe0pF6arlbMMwHdOJ+L5mgtQItaYknIvskClQ+1S0pzVKiWinmifclcenDAkj2/EypL8yGx35g6yGsWEjSAo33hwFFgkfNq/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKBts/vd; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKBts/vd"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1220154725fso583551c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 21:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768973985; x=1769578785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+7T8GNwM4dfichYyvJ3rVwGsSTHVKdbp0kCAGG1sRA=;
        b=PKBts/vdkhLJq/uWzImPSyswrcUBqxYrdiVz8guVg+4IS56/LxtcG+GW0x9tkG4Na5
         sBBDtSNGNH2fKM3Li0kybVDnsRYG+w52awXti2Qdf3uu5MEKul2COwpNaHS4AbmxWZ9D
         0H1ZPzW78INhgJ+FtQ1YtBWXysZm2VySTJBf4DsEmVuVdTgCvZf6AMn0xqCT02iVFksc
         +brZ6y8vlNP1cZXbRca42heEMyVqRKAGgDIq2FQ6vFxOVuenSg4DHX9sgqoqzRXjwDCA
         oqo80rUlMp9D5pz+TC61AtJg+tAjJUYK8qB0s7/zdkqKFdFiRhNmPsb1dB5SKvfwqBbX
         FIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973985; x=1769578785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+7T8GNwM4dfichYyvJ3rVwGsSTHVKdbp0kCAGG1sRA=;
        b=Vaf/rn2zEndEPaVw4xMEkGOXsFkBwmiSTF/CidYKejf//se71N3qdgmRvXTgCS8QZq
         jJ/mDMHGZnAq8VgyeDoPRnM+N92hJIYExTsaf4+dZpkIWaFyukUGhN6OJ0WL8PnklOmw
         2+r1nQ5UQsu2lWcwxqnrnfN2yhu+Y84YlHh7s2OO5V/xr/6BBXsWKRvwXIIxy3BpeqqV
         2oPWrEfZ+CiiVXxKpfebIZD9Z889T3e+a7KJQO8dDPXjUU2fYLWm5OCIjQOI0uOE5mOQ
         s60c/O3Jw5hL54b0NiRhtjVIKDUcBlqbuG5ujX8lGUiCi4BamWSTwEvFBedxZds/TIta
         LBqA==
X-Gm-Message-State: AOJu0YzS/vPKH20tzJ1MLqMdVRC9w+2rzdnBjKzMi6VotCKVJaA/KhX2
	R2chpABj/WXB9TsWpOJc+lfFDxXsG3l2EXhwlUSRa0sdK1QNbylbRa+K
X-Gm-Gg: AZuq6aJAsFW4m3WzJKVkJiuYUefgu/RddxwtytWmLJyoR0mqEArsD/QQRxClrvD/vEj
	Rk5GaWiV/Qj8EOk48fzIlEjQSTHxVUybgylAOGpuY/YKQuTf0DZnhWUcDPRFxk/x4N/ksO6dAJ/
	Cts918o8u6LbhGWET74L2Xng1fbyeAOZetn+AJ3i8s7zIRxMH5/4+k4Socdeyd+SMOM5sRpAdOH
	2jaJ9ZshnOJVdO+D/8tyWl48yhhl0XbryQ5jO8sx8qoPBd9zLq2ETQ/Wu3mYankQQlZkE6rHAU4
	3gNR8/xxBNElonVGjO2Ntz1hFziMJXSxk+SaAd0CAz2ZorlG66btP9h/6rQmVxWr/joIa+toKvX
	g/YVewtNfTqdaQDSQSsAFblQkNkAOsqJxOWoJaWtpxUZkBGZSq4lQa5NnlabUaICFHHQ5DVWAdc
	Cvx23H9vkyvussUCvl9KwEDZdSxhekjQB+5hYQNPuYq93M4PBl/7JVcjbB5EeSbzg=
X-Received: by 2002:a05:7022:e21:b0:119:e569:f875 with SMTP id a92af1059eb24-1244ae9c26cmr13266445c88.18.1768973984664;
        Tue, 20 Jan 2026 21:39:44 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm23791135c88.7.2026.01.20.21.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:39:44 -0800 (PST)
Date: Tue, 20 Jan 2026 21:39:41 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: daniel_peng@pegatron.corp-partner.google.com, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH v6 2/2] HID: i2c-hid: Add FocalTech FT8112
Message-ID: <eb47h436johngo3bz5b5cn6tyvwqoplg55uhk2siftxk6n547n@4rgwokhtrcec>
References: <20251117094041.300083-1-Daniel_Peng@pegatron.corp-partner.google.com>
 <20251117094041.300083-2-Daniel_Peng@pegatron.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117094041.300083-2-Daniel_Peng@pegatron.corp-partner.google.com>

On Mon, Nov 17, 2025 at 05:40:41PM +0800, daniel_peng@pegatron.corp-partner.google.com wrote:
> From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
> 
> Information for touchscreen model HKO/RB116AS01-2 as below:
> - HID :FTSC1000
> - slave address:0X38
> - Interface:HID over I2C
> - Touch control lC:FT8112
> - I2C ID: PNP0C50
> 
> Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

Jiri, Benjamin, do you want to take it (and the binding) through the HID
tree or should I take it through input?

> ---
> 
> Changes in v6:
> - No changed with the v5 due to relation chain.
> 
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> index 0215f217f6d8..b81fcc6ff49e 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> @@ -168,6 +168,13 @@ static const struct elan_i2c_hid_chip_data elan_ekth6a12nay_chip_data = {
>  	.power_after_backlight = true,
>  };
>  
> +static const struct elan_i2c_hid_chip_data focaltech_ft8112_chip_data = {
> +	.post_power_delay_ms = 10,
> +	.post_gpio_reset_on_delay_ms = 150,
> +	.hid_descriptor_address = 0x0001,
> +	.main_supply_name = "vcc33",
> +};
> +
>  static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
>  	.post_power_delay_ms = 1,
>  	.post_gpio_reset_on_delay_ms = 200,
> @@ -191,6 +198,7 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
>  static const struct of_device_id elan_i2c_hid_of_match[] = {
>  	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
>  	{ .compatible = "elan,ekth6a12nay", .data = &elan_ekth6a12nay_chip_data },
> +	{ .compatible = "focaltech,ft8112", .data = &focaltech_ft8112_chip_data },
>  	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
>  	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
>  	{ }

Thanks.

-- 
Dmitry
