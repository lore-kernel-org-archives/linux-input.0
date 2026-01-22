Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0034223322
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040884; cv=none; b=WjAVuiMNp5QSs8giN+iN+GkIRawOuJjA5/sdI9fxG+HsSijqytTigI3mXx7cL5DoTOVlusjFStWGK7En66j7L9V1fAOFEPJZZtI7IUmj5n8aGsI436+qxYgxgUvzdD2+3ml5Yb/nNGftZTbZSZ7oyk5sN4MSSJqUM90p94g8I8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040884; c=relaxed/simple;
	bh=GGV7wC1s+HBR22br/9JZYn2/glb2cbSkK0yUngsVjBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcmyAIBslF1ejj1x5kvtvqUfwVBlC1mAq07uXE1tbAZuLJTkLxOdD8ZmcWA6yYiuc26+Hbrcd4XvRLh1UNNYNm03ocCB2817G0l0CKzynAvF1ptHtzeQxJUyFzN47XxArE1ney+dNXr8TJcmet8CIzFy/mkK6JQheLywXxNjPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfA5QIsy; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfA5QIsy"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so622014eec.0
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 16:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040882; x=1769645682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz0AsR1Die7wQp80nUuBFjD+6JgZtowcnEqoEoJXizA=;
        b=OfA5QIsyHB+274UPGujGtTmXmDsLidGcPx8Uy1bzLjSuZ82pZVe0BprBWQ5rQz2We8
         QU8yX/0857YPL/jJmbHMkHwTQuGzF4RKBof1aZYrAU3YXjSsKTz1kBtqu70djT68Z0E1
         gRQwkTd6mw66c5nUfk828LtREDPvncm4Olypxom5jlbm8NMScUeGTafks6zN55HFssco
         yKbo6TU210P0W6ZKfrzngNn++IyORCx1sRAJ9igwmWm3JheGl5iXSIGEDJUJ4klXMfRz
         vzpTIZzbxYcxa8Lperlf0VF8iPD5OMEIkK1PF6HoppYnCWRzbhYWFKdTDunUaUlMqXBt
         eL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040882; x=1769645682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz0AsR1Die7wQp80nUuBFjD+6JgZtowcnEqoEoJXizA=;
        b=Xo3jcQT9HNnfp6xH/+0D/hiVWz2Sibw0yozvTDqKyrGl9FLlczglfy/jzAWvftIX4O
         fA/QzjDCKl0xVdJoPE/TMYhX0O76pcodCP+owI9EAdj/jWjhd0hpnymT6EAKPHxvlf9w
         J0JQLGFhfoMgkiIUYrSLjxajSQhaLLo9HqhGr84CpWLZLWokvAlr31wy5KGboXzkXM1v
         4+64cmWCRfv4S25N9jFDuOq6FKOhEf+6tClZYBQ4JhC5f1Qw8Qvw8zoTDs3pBmiw26LI
         EY9jL/XH/lTEKKXWlcKt6nUkdN/Z6RhmSjcjZftlskdhOj9nVv6oJ48eoyG9iAypXi9q
         r0Aw==
X-Gm-Message-State: AOJu0YwCsgBJAOHhLtpjkxwLXgWP6NNQx4l3SUDq7PeZRWuW6WZQUrD0
	KHV+v/qfbBz6oKtMgNzb0qwKXFxbiM3GDFgV/EZHx2L7uYzDWr5MQGrx
X-Gm-Gg: AZuq6aLpxt2ExxbVCkzeMeKKvXZV9Dy+gF4B3HMNL3FTW9C4Eisuos3h+49AHkVEXD9
	p949fcZ2DMnllBcZUdAMIhzAxJYsUlxDV9x9Lkh3P4cGJmrPFhauMqo25yHtHwb/FrtQC0adJg1
	THohPP5bKaCeVz5rPfHPr3DlFFBpWcVENsf0BtQgoc5emvy1iy80WR2Vu5ZS1+X9eR68elZBb8M
	rTx4VP8cE/0ivhcWylm00AfEEx0xwnDU4D7mueHzoZ57zf1IaY50bQ3qJDJ9+Buc1ofv7t0V5uC
	2mLOLodPJ3xk+zIp/1OsJSAguhpqg29mk3zvxWqgpQf5JtspcvIb02pRo5ZBwJYHVH0QesSmI4O
	NgE6ytxuRTPhLb58SqNf78No/G0MmBSJX9XC+a+FUc0K0tJLuCbFVXPSBbp9T0IYui7E/sKLUh6
	amb92CuRr+8NPQ47kaQLP1zV8RQTdzGS9nhyfZJBGo0+dgDCJjMYXY
X-Received: by 2002:a05:7300:8623:b0:2b0:5735:25a1 with SMTP id 5a478bee46e88-2b6fd5d816fmr4876896eec.7.1769040881645;
        Wed, 21 Jan 2026 16:14:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a94sm22920419eec.20.2026.01.21.16.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:14:41 -0800 (PST)
Date: Wed, 21 Jan 2026 16:14:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gianluca Boiano <morf3089@gmail.com>
Cc: linux-input@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v3] Input: novatek-nvt-ts - drop wake_type check
Message-ID: <e52df336krqtmq5yu44muzyfjqnplgtqtd7m7nl2wrrzjxfib6@4nvv3d2zrtit>
References: <20260121-fervent-wren-1730d5@quoll>
 <20260122001040.76869-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122001040.76869-1-morf3089@gmail.com>

On Thu, Jan 22, 2026 at 01:10:40AM +0100, Gianluca Boiano wrote:
> The wake_type parameter from touchscreen registers is not used for
> anything functional - the driver only validates that it matches a
> hardcoded expected value per chip variant. This causes probe to fail
> on touchscreens that report a different wake_type despite being
> otherwise compatible.
> 
> Drop the wake_type check and the associated chip data member to allow
> the existing compatibles to work with more touchscreen variants.
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>

I think this deserves "Suggested-by:" tag. I'll add it unless there are
objections...

> ---
> Changes in v3:
> - Completely reworked per Hans de Goede's suggestion: instead of adding
>   a new compatible for the e7t variant, simply drop the wake_type check
>   entirely since it serves no functional purpose
> - Dropped dt-bindings patch (no longer needed)
> 
> Changes in v2:
> - Removed Closes: tag referencing downstream repository
> 
>  drivers/input/touchscreen/novatek-nvt-ts.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
> index 44b58e0dc1ad..3e6e2ee0ba8f 100644
> --- a/drivers/input/touchscreen/novatek-nvt-ts.c
> +++ b/drivers/input/touchscreen/novatek-nvt-ts.c
> @@ -27,7 +27,6 @@
>  #define NVT_TS_PARAMS_MAX_TOUCH		0x09
>  #define NVT_TS_PARAMS_MAX_BUTTONS	0x0a
>  #define NVT_TS_PARAMS_IRQ_TYPE		0x0b
> -#define NVT_TS_PARAMS_WAKE_TYPE		0x0c
>  #define NVT_TS_PARAMS_CHIP_ID		0x0e
>  #define NVT_TS_PARAMS_SIZE		0x0f
>  
> @@ -49,7 +48,6 @@ static const int nvt_ts_irq_type[4] = {
>  };
>  
>  struct nvt_ts_i2c_chip_data {
> -	u8 wake_type;
>  	u8 chip_id;
>  };
>  
> @@ -261,7 +259,6 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	if (width > NVT_TS_MAX_SIZE || height >= NVT_TS_MAX_SIZE ||
>  	    data->max_touches > NVT_TS_MAX_TOUCHES ||
>  	    irq_type >= ARRAY_SIZE(nvt_ts_irq_type) ||
> -	    data->buf[NVT_TS_PARAMS_WAKE_TYPE] != chip->wake_type ||
>  	    data->buf[NVT_TS_PARAMS_CHIP_ID] != chip->chip_id) {
>  		dev_err(dev, "Unsupported touchscreen parameters: %*ph\n",
>  			NVT_TS_PARAMS_SIZE, data->buf);
> @@ -314,12 +311,10 @@ static int nvt_ts_probe(struct i2c_client *client)
>  }
>  
>  static const struct nvt_ts_i2c_chip_data nvt_nt11205_ts_data = {
> -	.wake_type = 0x05,
>  	.chip_id = 0x05,
>  };
>  
>  static const struct nvt_ts_i2c_chip_data nvt_nt36672a_ts_data = {
> -	.wake_type = 0x01,
>  	.chip_id = 0x08,
>  };
>  

Thanks.

-- 
Dmitry
