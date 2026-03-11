Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23020318BB3
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188499; cv=none; b=XMbaSfsyGWZQWWrBo14+vcjcOSZInUlJ6rDjuNWgkk4hjfhg9MoK1iAC4s6QY+tjtB6Uh2YtWjq825pk3jbGlG2DM8TyIGFiHmgXHu95Q26qBS+IgISHs44b2feJ/PEEncWXi11NWa3Qb6q5Jx0Xx1iT+DmZW9tDrloDFr+lYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188499; c=relaxed/simple;
	bh=6FSfGjfEA7I/CqRKQXRkk4AHYuVTpiF3UrEghTud5sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jijH6JeX5xFltSVwSY80bbkpjAfxBM/K7wz1X7X382gLO9XmJvd7AXSj9Qfhk8isykEWUM522a7/jBFKI9MZYXFxdja/k0pgf4pJ+lSfiHSNFrSKU3JI8Kwo0Q+ZY15n9vdxmCcmnhsxdTsPewFYwoEi6ql/AxifiLI55lDe/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdalJYfv; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdalJYfv"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be1c918173so15951386eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773188495; x=1773793295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ1q6EFUHntWG4ZxMjM+nzdLiPNGdE6ZpSx+iizQ7CU=;
        b=NdalJYfv582qiyEDEi4EvAFTtEySq8+0oJ1q1s4QYBekSCOgBQp6ovSi27SJhXVP+3
         RGIemkrP2T1ZPXJGFeCcCmvIlbID97JxErebvw2RNUE9aNGdLx1yNDwSeUoRrXrbzkE4
         XgudbaA++ndxSwcBm8XwQTABFwZHCqSCCpZpvGuPLumVSCOjI1yeOPTv8+XwnEnanCj+
         REznyaSDYkDjDdkngc36wEayMDdf9t2S1130QAt4GQ2HDFyIHtGXWjjdEtDUiN1FJI3h
         aaJhQR0/zxVhhyRrMicqCkV2+X9Blq8EgvwUMfVYZMNVtthy7MlSFxS4LAuFPvX37S6r
         e2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188495; x=1773793295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ1q6EFUHntWG4ZxMjM+nzdLiPNGdE6ZpSx+iizQ7CU=;
        b=b4lKk9ZeIvjpHwTesKOwg04mriJNLfMY/gZ7Tb73NA2NeP+eLcpamPOnB1+fRfQYUk
         WlebBjuGjn4Hku3kb3pGLlAVTUKpefw3mGngwWB9MScaldS/WTDIue4I/T9MFUxZNgk+
         tbVprnp7DUnrPhWo7FzJtCuiKh1jv28B0yktSgFWbtrqvVUBvWFOxJb5QdJER7zLmxtl
         7JX7UNufGfUfWAyr6IHvfSM63JEj0punaj//2ALxKW1ncdLzCMZB6IuO1DiXVxZ22B/K
         p+8m6zTl8pcNcerz5AiyuhWj/3+oXufvgMO90ope2P49bxj/y4tsslr9qMGtdxefmEvA
         rTJw==
X-Forwarded-Encrypted: i=1; AJvYcCVukzxxzm0KEHbWxhXX+Fo873UCpe8kuOymLlzWFRnBLFSTNzapBOXAb5G7L0Z6SzTB9+RWcQ7yVeU5ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwsziqWvM8oRaur87mWdtVEzAPUnwGiQGAZLZKTJr+gsyFK/n
	M81ZV+fS9T6uPY30VLVBFLFVaDDMvfzWqyaz+7vAdKuFexBSDuh7WZ27
X-Gm-Gg: ATEYQzxajlW2kynBrAcB1PpXehaybOE7FmngVjQvJyNAhbtSDROf1nhfipy5EopHrxj
	HnuE1YL4Y0gw9tOl5Zmrfv+bWvkvNpf/di42t0zKiOJj8tiRbIFGfhm8i7WunPUo3z+U6FuBr+e
	DsbKbFlEU3z+cePDhFS2gy7OAVz7n0cUFQ88igwIgNClsiuBMvYzrQtIoZXqfKu3IIblWiXxsOM
	Vi+mrz/Woxfp2ppi6GyrZusN91AJY/bExVvkL5MAVvlQQprYI57lPeV8dmYSzTcTchCe2NmBQx/
	0Sw8im8mLkfnoMlCZyY7o9i9XA9P9NjT2YjTY23efIAnmCRBVEMseUeZD1IBXghS4Fitt0WdWlV
	0yiSBLm75ecVGBGn6IbqBI0K/3DmKCO8TSAJGAtBhiAqz1ZhKKDXkbB/u4CPZZWBxF6FboLp4HF
	LKipqPNKR5i8MP2iIDLbhNlxo4qFwCQLci4jijnkajUVA4pA0EP/sSC9zs5jEQEc/D
X-Received: by 2002:a05:7300:a59a:b0:2b7:24fc:f638 with SMTP id 5a478bee46e88-2be8a0f188fmr385401eec.0.1773188494956;
        Tue, 10 Mar 2026 17:21:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a853840sm533327eec.8.2026.03.10.17.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:21:34 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:21:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: phucduc.bui@gmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Marek Vasut <marex@denx.de>, 
	Michael Welling <mwelling@ieee.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: Touchscreen: tsc200x - delegate wakeup IRQ
 management to I2C core
Message-ID: <abC1NfUoHCHEeZpr@google.com>
References: <20260309110045.108209-1-phucduc.bui@gmail.com>
 <20260309110045.108209-3-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309110045.108209-3-phucduc.bui@gmail.com>

On Mon, Mar 09, 2026 at 06:00:44PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The tsc200x driver supports both I2C (tsc2004) and SPI (tsc2005)
>  interfaces.
> Currently, the driver attempts to manually manage the wakeup interrupt by
> calling enable_irq_wake() and disable_irq_wake() during suspend and resume.
> 
> However, for I2C devices, the I2C core already automatically handles the
> wakeup source initialization and IRQ management if the "wakeup-source"
> property is present in the device tree. Manually managing it again in the
> driver is redundant and can lead to unbalanced IRQ wake reference counts.
> 
> Clean up the wakeup IRQ handling by checking the bus type:
> - For I2C (BUS_I2C): Rely entirely on the I2C core for wakeup management.
> - For SPI (BUS_SPI): Explicitly call device_init_wakeup() in probe and
>   manually manage enable/disable_irq_wake() during suspend/resume.
> 
> The ts->wake_irq_enabled flag is also updated accordingly to ensure the
> driver accurately tracks the wakeup state across both buses.
> 
> Note: This patch is based on code analysis of the I2C subsystem and
> has not been verified on actual hardware yet.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/input/touchscreen/tsc200x-core.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
> index eba53613b005..d14d967845c8 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -465,6 +465,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
>  	ts->idev = input_dev;
>  	ts->regmap = regmap;
>  	ts->tsc200x_cmd = tsc200x_cmd;
> +	ts->bustype = tsc_id->bustype;
>  
>  	error = device_property_read_u32(dev, "ti,x-plate-ohms", &x_plate_ohm);
>  	ts->x_plate_ohm = error ? TSC200X_DEF_RESISTOR : x_plate_ohm;
> @@ -547,8 +548,9 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
>  		return error;
>  	}
>  
> -	device_init_wakeup(dev,
> -			   device_property_read_bool(dev, "wakeup-source"));
> +	if (ts->bustype == BUS_SPI)
> +		device_init_wakeup(dev,
> +				 device_property_read_bool(dev, "wakeup-source"));
>  
>  	return 0;
>  }
> @@ -565,8 +567,13 @@ static int tsc200x_suspend(struct device *dev)
>  
>  	ts->suspended = true;
>  
> -	if (device_may_wakeup(dev))
> -		ts->wake_irq_enabled = enable_irq_wake(ts->irq) == 0;
> +	if (device_may_wakeup(dev)) {
> +		if (ts->bustype == BUS_SPI)
> +			ts->wake_irq_enabled = enable_irq_wake(ts->irq) == 0;
> +		else
> +			ts->wake_irq_enabled = true;
> +	} else
> +		ts->wake_irq_enabled = false;

Sorry, but this just makes it all worse. There is no downside from
letting the driver to control wakeup if it wants to, so I'd rather leave
it as it was, at least for now.

Thanks.

-- 
Dmitry
