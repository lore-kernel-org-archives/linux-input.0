Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7494C955F
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121997; cv=none; b=SlV0SQBI/+pbNXhhOx7ZNXvybsdecjqvZ+5hluQKEefCGVYWYeKwjvUktKlhJvwyL+DftT+qRRhulqQMBZO2X/gDGQKQhlmE2Wwfwu7rbaw4AVPu7JMt1An4GjPX7Y0aKHw8BfPd5nHmN9ClVib5sYfp8rxxzsKS7XlUTIgbczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121997; c=relaxed/simple;
	bh=LlP3/1O8CB//0s/+CCxqGyTYuWA9OoLCrL9yKkS8zFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYRjSHfwEP24BQH/kknbhq2i5ESXCarjD0Hw1w93OnRzFqnjOeroRK9PtWaj2JS063smlnFEoTAYrxhJut02hz33zPBzPKJc5AkATxrz9ckUy/I83zg2z4rvjV3ms7zDv8nvaQJgH78RvTjbBqLvCCex6N6VyIMK1NehmHsOG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWLEngQj; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWLEngQj"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1003405eec.0
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772121989; x=1772726789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UC1Q8+vyEP17hQt6/3sZmtkvys+UUPMl4+3szj6VoQ=;
        b=ZWLEngQjy1e6iZRf2/GhQpH2Fx38vTYrFqBsozQKEzDOE99TD8e+9k/khztz2sIiyL
         pO8pQCliay1zyoD1KEuQlherhNv2LkNnsVDqunR0HEbrHEVwEkZeI7zXqVTqmNOXfAyC
         9Auyd0l02cc+33LHbPQJN+tQ8lyxMHiPmv/MbDtFC+N7NH73QzQ1y6GrK19Sn7mmev+F
         CqnAiFoaoXSAmIN+aAQiSFaA9vg1oahZ5uYJddDWgBnt3SF7uYu/2O9aQYkCSkDlIkXc
         hG4UWoBXzi6FnZ/nj1P4TvhFmNywGLYe8omXckQQtgIQYM1rj1tgLV3lOjNuJ4H3G2ec
         MJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772121989; x=1772726789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UC1Q8+vyEP17hQt6/3sZmtkvys+UUPMl4+3szj6VoQ=;
        b=X9GpSjBY2Cl/BueNlCLNCcHcw1hCY+fgSSJV7L8u36VFTkhm/fzebBsa7kPIUIw45K
         FSMMg3k89BT53iCeP3UQ7mG6ac5MxzICGE0k9CBVIWpi3+5w0gJtCZFkVXpQB0NysKqg
         u2/nGJSNBeM3Nqci2IrLfM2afnOlgH2okCsHCZbVbVfctZwCgnU0WiV5a9uSGWgVcjPX
         HwBwXYQhy62T31fLhFH5cyvfMB9Or3LIMqPQ4Bnn1I69SBfZgfAym2SbBD0fLhaWQ0y3
         DYvxQFTebsmv5LMfysN47g5PRqgHvp0VXaxUHA+PIazUVYKUjmjTXOK50KjiMcP8rc2s
         vpug==
X-Forwarded-Encrypted: i=1; AJvYcCU3jy1KNnUlpHwbZpo2C0K0uBgsWsSgYM1EdApT/XE/UkVkeROd7bX1dAbERvXqWWwMcfLOXFlA5PFFUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmcwObmqw5El3rtY4748LqwRbHiUl7OklJgQvcmwP7xrg/8NN
	FytfA+KJdQXYy0g8aM1TJqUYHFbw2dry87Xn5ABIZzaWWkH05zyqYW48
X-Gm-Gg: ATEYQzzJjya1LtBh8vg2Jbm2mdnqOl3ZTnSq+5BPme8P8NLq92Wo1wSbZj5d+pWWiAx
	LV70ke/p8cWccYYxBUv1XB5o3O06is8ci1ycofD0CvS9VB32wkGzcGnsolLGqO6EOaBNbnXOfTB
	AcBryAHoY645S8OB4hPJKtbTmeIajhDMGF9vkaxeFD6G5Q1eWD7DRkxA5NRJCrfG38SLQ5aPJab
	/upmNDFbWkwRugzuM9heLnF33YTCwVls3uaXzMLtA5kyb17VRY+spN1eDkYS0jz9O4bwB5styLp
	iCKfxvCIPhdG686WyEaGWSawWxXXjkUk+db8bxzp+jHtJDER4+sH9ll7k4dUGhZZXCq6vXksSlE
	6mgq11QXKLwC5RbCVqi732dnwi/r8rDR+fEP/SC3huCevw5tYzlQi02Bf5VVgNnVinIZ1UsQHgP
	7tplAuWhhl1hWujPg6KaGqkmdCqABUImaj50nrUN6MGhmLdGY45ER1QwciJwqSCB2a
X-Received: by 2002:a05:7301:1295:b0:2bd:cbc7:16ec with SMTP id 5a478bee46e88-2bdd3017066mr1122632eec.24.1772121988602;
        Thu, 26 Feb 2026 08:06:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a6ca:da9c:9e47:3e6b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f7e955sm2194157eec.32.2026.02.26.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:06:28 -0800 (PST)
Date: Thu, 26 Feb 2026 08:06:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jikos@kernel.org, bentiss@kernel.org, dianders@chromium.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND 0/2] Add tc3408 bindings and timing
Message-ID: <aaBvauUqgMgGYwhA@google.com>
References: <20260108063524.742464-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108063524.742464-1-yelangyan@huaqin.corp-partner.google.com>

On Thu, Jan 08, 2026 at 02:35:22PM +0800, Langyan Ye wrote:
> The tc3408 touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that they have different
> post_power_delay_ms.
> 
> According to the Parade TC3408 datasheet, the reset pin requires a
> pull-down duration longer than 10 ms, therefore post_power_delay_ms
> is set to 10. In addition, the chipset requires an initialization
> time greater than 300 ms after reset, so post_gpio_reset_on_delay_ms
> is configured as 300.
> 
> Changes in v3:
> - PATCH 2/2: Corrected post_gpio_reset_on_delay_ms: 100 -> 300
> - Link to v2: https://lore.kernel.org/all/20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com/
> 
> Changes in v2:
> - PATCH 1/2: Drop redundant "bindings for" from subject
> - PATCH 1/2: Improve description (describe hardware instead of bindings)
> - PATCH 1/2: Drop "panel: true" property
> - PATCH 1/2: Drop redundant description for reset-gpios
> - PATCH 1/2: Use unevaluatedProperties: false instead of additionalProperties
> - Link to v1: https://lore.kernel.org/all/20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com/
> 
> Langyan Ye (2):
>   dt-bindings: input: Add Parade TC3408 touchscreen controller
>   HID: i2c-hid: elan: Add parade-tc3408 timing
> 
>  .../bindings/input/parade,tc3408.yaml         | 68 +++++++++++++++++++
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c         |  8 +++
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml

Applied the lot, thank you.

-- 
Dmitry
