Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB823A3E78
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033331; cv=none; b=blDOxiM5kHFqgSEECUI7g0PK6jfJ1ba5oZ+csw5Kska7AcoBdZG4bCfC74tKu0LMiYnJ6j835wuw+6P1R1jHjNlbBv0crBPOyu80vLftB5OhzjO6iDtULEg9lwivZBomQXvCb14iRP9Hjmcji9/0yusMbvwDAeVW04zL8wL7qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033331; c=relaxed/simple;
	bh=PtTATevxmIUh63d4xOSqSI6Fh1p2atV5TSFEbDIi/jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGxPEUiM8ZGWYW33If4cx1SFnR3VNTyLub0/z4dcUODH5oV343xU3HoGlJBjQUBk5o0ZJEqXcDlFffhyK0eXZTzLDJsrCrKOnpB8+ZQ/XK1/aONwM4mAsC9Z+i27PepoLJFY5AX/f2byM5V31dNptUrAKDLFtzBI6YkRkwWP0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJES2FUl; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJES2FUl"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d555293aso55844eec.0
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780033329; x=1780638129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz6zBQ1WuCUd89SpgtC5HEUuwrLsBEV1lrV5fai6fA0=;
        b=lJES2FUlgSuO1wV3I+HTbcPRPeCBPzNJL28n+l9wKGOtwb6q1GJwcnVuux/MybeSaR
         jqUCi4CszkzX1JN4Z9VA0pUhXJBOyjkcAW+S2BQjdb3BzQFn1ch6ipzsD+yFQZZDbrki
         S+guHDF8VrJ9H8icVm4dqDy0EcQYjaKlti2LM8vwnNCRz6it29fH7S2HxJ9nzKJxmhSR
         ZR46ohRfKQl6K5deqb4FI9boCSlSPcO/PhpmKetf/SiuNHWgHqOImIChvpt0PMkEdKOX
         EQLqz+3UkYC3w174GU1HMXmIIW7HQV4ee4WvCFY+mNa4nPzqyOy9Ejf8qcQmFeLbHXMO
         z2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033329; x=1780638129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz6zBQ1WuCUd89SpgtC5HEUuwrLsBEV1lrV5fai6fA0=;
        b=qYWeHLWLGyC8CirXpBm7WPZ6OSmrpaNOs1eS+p+/xJLSp4RA11DN8y+SGBZ65RYvsJ
         m4fy4/PziAyUxAZ/dkBn9rN2dZrk03NSO7Coy6+wEXe+bJ/mTeljc7gU831v4hs6+F6M
         quTP6q5Mw0SsSf21BJvpYX85i+2TWUEtgfh4ncKn+MYsLExbFkIDuKGUITe+/zOSp4yj
         7MR4zeNxNglTFyoERws2dkCPFQGSB5KLlBPE4NH4BEFbm1hNUzjcrBQPrTCFfAXdpYYi
         tAInBP0dL+c3Yr1Ne+SbjedkLGBIeL0Sh/im5Kavt7xhpB8bYOrCU6YgV6wj0NIzYIUT
         tiZA==
X-Forwarded-Encrypted: i=1; AFNElJ9CUIXHZwN0DzpzxYw7nUyVxv7giY5Bbcbf5dL0jQ8UMyboxCSSRt7Uvn18qxdIcj6dAfa07Bq+Y1QFBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5vr6pmzHnohS3FQqk0Mz+giSahw77OcwTg8sf6NpwpAbtVug
	YmpEAj8x3vS56uWwZYlcsbhcG/v5XAihKklnRyBnyTdR2Iy80nBS7B3WhNhBRw==
X-Gm-Gg: Acq92OFmg99BgPKCbPKCoQtRWrSuzucCBlUO0uuE8TVemuYOJ1Bx4Hg1T2Mo9CKuEJZ
	YLLn13fj5Dem5OFDLzyQhKV9x6STVqnr94a53WnhOqDILpXHPEMe5os3pefwoOpZLJfFagln8Qt
	pWmTXOH/1AvjTahZU+5C1aKffPSV34okFxy5IRpAxFTONkZrO6obUsW5lji5PZFN/jpbfnc/0KX
	qk8dfRAwI3TRH8FzjFmwGmaH5xfKoMqbssVAfyzYkuR9A5T3D7DQn9JUR6nd1erxcs7F1Qm/zlN
	J6u4oUB+4xvTPhH/sg03mHl5JOeacW1NfQDtGZCLvN9yoHui7EDEGOomHZuzvZRlx2A/FpO6Fbj
	d+Gu0gUBmQlgtXIqmoSi/Q62iZzC/mpkhYjGlkaCLvisdnNwhuqoRQX1+enEvlqQU14G73x0x1M
	LrnQ3XQRj5RmurMLPQTwtx9O0NE3TVdJPz5MVKSTonWuaFwSfWIp30v5mwyrcnu9cR6WKBlsy1F
	pU=
X-Received: by 2002:a05:7300:cb11:b0:2ed:6f94:9d9f with SMTP id 5a478bee46e88-304eb115c56mr669142eec.11.1780033328984;
        Thu, 28 May 2026 22:42:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e169:a62b:d3ca:e8c5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed578c48sm596863eec.20.2026.05.28.22.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:42:07 -0700 (PDT)
Date: Thu, 28 May 2026 22:42:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hendrik Noack <hendrik-noack@gmx.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ferass El Hafidi <funderscore@postmarketos.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] Input: Add support for Wacom W9000-series
 penabled touchscreens
Message-ID: <ahkmPEEyF-AKKy6X@google.com>
References: <20260528074818.12151-1-hendrik-noack@gmx.de>
 <20260528074818.12151-3-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528074818.12151-3-hendrik-noack@gmx.de>

Hi Hendrik,

On Thu, May 28, 2026 at 09:48:18AM +0200, Hendrik Noack wrote:
> +
> +struct wacom_w9000_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	const struct wacom_w9000_variant *variant;
> +	u16 fw_version;
> +
> +	struct touchscreen_properties prop;
> +	u16 max_pressure;
> +
> +	struct regulator *regulator;
> +	bool powered;

We do not really need this flag as ling as you use
input_device_enabled() in wacom_w9000_suspend().

...

> +
> +	dev_dbg(dev, "max_x:%d, max_y:%d, max_pressure:%d, fw:%#x", wacom_data->prop.max_x,
> +		wacom_data->prop.max_y, wacom_data->max_pressure,
> +		wacom_data->fw_version);

Here and in couple of other places we miss '\n' in the diagnostic
messages.

> +
> +	input_dev->name = wacom_data->variant->name;
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = dev;

This is not needed: devm_input_allocate_device() sets the patent for us.

No need to resubmit, I made edits on my end.

Thanks.

-- 
Dmitry
