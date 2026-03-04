Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C502DECB2
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600480; cv=none; b=aOVmu/zszFszi0H/j+8FYgOib3KcUmJ9voW/8K91rezO5WhYb6TI+38HRR28qXcfmseYGs7IUdy53Od6SJpdJUAk0GJc3Tw+oPO4bIqEyYO4MtPb0FZ3o7dJGS8p2YqQa35dBSJ9PvH+j/jw9Dzys8i6PDJ42i4fybf/Ov7ycX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600480; c=relaxed/simple;
	bh=q900SxARa7WkotcVHjlQh+90jJwX7uIhDq9gH9l/QfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+7vyjhp5mf8x61WW5ykE4B5Awf7/ItFNJG2rMH3zbk4PfDol4A5bqOSjBlraycXVR5YWw8cNtVitOUvEZUGXibILwoHu+Rx5vGAM744rDeUhzJqUoGx7Erv8Ck06obyjXDhUHXEgZDXTiul23w51WAwQJLBb8iC5AUM90CIYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noVzN0gY; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noVzN0gY"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12732e6a123so3943240c88.1
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 21:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772600478; x=1773205278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/nYbvJ2Ie/7AoV2hxQbNjt9CPBgI0NZpDJT+MhOo98=;
        b=noVzN0gY6eDOmqdIDzhqW7qhaHHSELHcvJObBWE3FYMEO/OLSyyhqgXb+Pu2XWdyAq
         LI7wT165K39bYeBeQxZE9Udgs5sijUrIh+t+s6aF2TyoYRsLi6pV3tbNoyerqGwIFUSo
         Qr4cym0LaZmn0aKkCdXz99pW7FlPrWk4pv4yLTG1S8MgOVtAW7GQeQ61nlIgc+HjDGCV
         pMmoZBG9RO5WHCegH5cDgy5EipYHDY43UJUwMTOSYbZYOqHCaNtPz5Gv3Dz13GmNCPeT
         rZCHThWX18UcDrkdEHrsnI94B48y60CtvMDdKHvIgEKvDn/gDGuALJmgOqFGk47pHqvw
         b0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772600478; x=1773205278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/nYbvJ2Ie/7AoV2hxQbNjt9CPBgI0NZpDJT+MhOo98=;
        b=q4gHhephZ0rLjQ59kNy9jInv/4NJDt0Whtrm0xdVUTssBbujctxOmcpn2048S4zKCG
         FSwc6B8N4xFw7ERTVMYubTUBCuoVs7bYkJ4t7cy3G+rUAzFBVhsSYnv7nC1p4OfxLcfH
         qx9JQOzknUqhxTCAUReWFSPwS7A62WoCCy0oMmLAJePknSIQm/1C+M6sZOVCAEZBYAtE
         EjDacebDE3dVFGicrS6QFOK2F1Fax7+8FX0Uq+ZNpHd1I7Bd6M1ZQYuBlTMzk9FOJeyy
         tiougpsTajqpAvTu+9usmwPVhktVb3q1rbZrrRRgcHMBi7RAJSnpLEPre4ulqsR3dz7i
         /NLA==
X-Forwarded-Encrypted: i=1; AJvYcCXXtKXx96QTrjvTDefCaiEqEt0YP3jH8g9A9T3ocPrZSEDwopXmgLMgMBSolvTxscm5H9lBNaDwzMgtKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63fBbu/abtRo65VsIR/h3WUgRhUADHiW8S4IOi7TKMjVNs/B5
	hlrxjqvi5AZN0A+qZeh4Kp6PbkdsaYPT02JcyGAZQpDt4GqRnNeofmhX
X-Gm-Gg: ATEYQzzwcgoQKoK/3XnMd1K9PfXOc2kku+3hX83RNYDJVSN9ITlzioOUIIRIEOQ6xY7
	935D7RTlhiam9LPN8hcgeqpuN5vcQJ6yZEl56MHrPbc6FZWgWSoUhPviXBBNcQKMJk51Sp7fWMY
	gm9wX6O5KLJYPKzRkg6E4uEHyrC2sHBxbOVowATMVTHtwC81U+eQifnTnBFXJl3xHAzvfBc7G3W
	R5ucRR+2Q+QRTqxNCF7TkitWM6eOTctrbOHEtmhrLaKq6bsbf7kiFT/yRqXBYjH+QHnNCjR5hm6
	5ofM00ODPpe301TH4YA3TsvJojpl2vZSDPC6neeb1w51Pyu8NzWe686wPl+HFxrghP+vY7hsWGA
	OKlMd6GQwry7JDRLEg88+s/CEk/2KGsuyN+OhZVVhC7HbUwGICFBODPXepDOCDDMfm//kNy0DkI
	rB889A3/OZjbPQoaKzbZBTtkUEyIjpQH/M6k5ntQUPnyAdfhdak6ViuVro5lVsN03P
X-Received: by 2002:a05:7022:24aa:b0:119:e569:fbb2 with SMTP id a92af1059eb24-128b70df522mr302307c88.33.1772600477988;
        Tue, 03 Mar 2026 21:01:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899dfc47sm21528620c88.6.2026.03.03.21.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:01:17 -0800 (PST)
Date: Tue, 3 Mar 2026 21:01:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Petr Hodina <petr.hodina@protonmail.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH 04/10] Input: stmfts - disable regulators when power on
 fails
Message-ID: <aae8OqFl5Aejv6YN@google.com>
References: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
 <20260301-stmfts5-v1-4-22c458b9ac68@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-stmfts5-v1-4-22c458b9ac68@ixit.cz>

On Sun, Mar 01, 2026 at 06:51:18PM +0100, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> We must power off regulators after failing at power on phase.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/input/touchscreen/stmfts.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
> index db2dd0bb59fcc..f4e5f1b3ce796 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
> @@ -558,7 +558,7 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>  
>  	err = stmfts_read_system_info(sdata);
>  	if (err)
> -		return err;
> +		goto power_off;
>  
>  	enable_irq(sdata->client->irq);
>  
> @@ -566,11 +566,11 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>  
>  	err = stmfts_command(sdata, STMFTS_SYSTEM_RESET);
>  	if (err)
> -		return err;
> +		goto power_off;
>  
>  	err = stmfts_command(sdata, STMFTS_SLEEP_OUT);
>  	if (err)
> -		return err;
> +		goto power_off;
>  
>  	/* optional tuning */
>  	err = stmfts_command(sdata, STMFTS_MS_CX_TUNING);
> @@ -586,7 +586,7 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>  
>  	err = stmfts_command(sdata, STMFTS_FULL_FORCE_CALIBRATION);
>  	if (err)
> -		return err;
> +		goto power_off;
>  
>  	/*
>  	 * At this point no one is using the touchscreen
> @@ -595,6 +595,11 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>  	(void) i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
>  
>  	return 0;
> +
> +power_off:
> +	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies),
> +			       sdata->supplies);
> +	return err;

Maybe wrap everything below enabling the supplies into
stmfts_configute() or something to avoid bunch of gotos to power off on
error?

Thanks.

-- 
Dmitry
