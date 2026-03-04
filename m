Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FCD37F8B7
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600183; cv=none; b=VxwmKW0PNmeuLrousj8i3qrrw0p98IOB0vo2U4zbZG0NppUxr/X/2rYY13leBK8kKGTn9OCHE0GKNdja9/HOxQg9Lya0/pgmFdPfw6OpoZiHuoJybWWjM62hPteWvSj2cOZB57YyDTDb2HeYdRkqnJMhHWUskLS7aJVoPNyrs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600183; c=relaxed/simple;
	bh=pVGTU58hvCn2z+hoVnvYhtHq0U7buRUP6MUpwb7HYrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsdQl2tA9nbGheB0C1dB9D7cQ3R6bys+86AKNSMl+mr5KmALIQ1agXiW7T6oKG12jq83RK9gviCSOkMuFS8H5Z344gG3wFHCmTU8pWvlYdV50Nb+sOdlu8BQaPd4UDknSVpwrsTu2xeKVFtvAXozC+J9QZ2QB73Gylu2G8VgE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbVVH3Wd; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbVVH3Wd"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdecd00ebdso1259555eec.0
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 20:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772600180; x=1773204980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiogvf4BYSe07P/jJTWhOgw9FG4yGWFRZPfv7hu7sWY=;
        b=EbVVH3Wd11YmcUVbENvhG0+wKgcq26yjUiADOy/X1cA9e6N/F9T5fNi9yWD8tYhZIT
         8hHo31cuLiPoz4S1K1GohlESLPS5rdNzSS/6gp4P0RHHhl4Bn7f5j1o43rg+N/CixMi+
         SVlR8xLiopWA6h01MQVpKm/cBOtCKnH3zDWmDm/WSta3AjQvNMVVDARQuNGxyZONCwze
         CsF8To/sXviAJjNHRn8gZmf9nVhGaJk6sXrzQZs5hnmdW4yNH6KQjDrFbfy0BV5nUzzV
         g6Zszsx88A7uC90lIg+ZPQBQF2d0xnGRBiDQcUvulpo18wpDl1N5//uTzPxL/teCCyjY
         K2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772600180; x=1773204980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiogvf4BYSe07P/jJTWhOgw9FG4yGWFRZPfv7hu7sWY=;
        b=pHFJ53V9lPh77O921e9C3Z6k40lTmlqJWUzrC4ZWWlzCmP7UklhQWTemQ3ryHcccsw
         atK4WrJTlJPTHcAZdimdYkWlA3TWuGJxXcl/Y4RlTtHY2TZaaTHuCGpaL/sB4NF7Lkjp
         5qgijkuTyfJI32jjLs6Cwxb0GVDIspsbzUUx90nlAP3VLGxQbZyU6tbZeIadf7qZO0sB
         fDDY1DaB5C4ac4leYBdhvIMwXsfz+FNI+uFEkqzqUtbcTAoR68F8/ZX8nSOFDUoLTntM
         yUN9lz8kq4/OFUMv3SyqYheGUdC4eGbbjVy8x/vh5WC/R1IjuOI/98RvYP0j5YlGUp0A
         uZkA==
X-Forwarded-Encrypted: i=1; AJvYcCUA3Rjuz/SKsTApUkMX4I7yH/zWrPpdwtqUWjmKdE2/saSGi7wYfIHoBeu04ButZnNZ0mA4bIsNfEqMeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6TjHSYN53/e6Ta1TlzYZvPW7307UOl9qRdchZUVwgcTddR/u
	dOQV6IrZOkSCRLnQKd8rkidBWrOq/QUu2Svp/3BdqpQCefrajAO9MtIK
X-Gm-Gg: ATEYQzyeQfg8X1/4+NK2rC7hnbrDv9Un1dasFPYgqvwZx+2+vF2Xl0c2pEtiLSUWaEb
	8qjELPJTNdZddRPviaV7jZh9DfLU21gTPFaR4J44hVArc1l2NNj6Zrkc3nqG9NGpQmKrOWDoJhZ
	hNAEN2TMmQyQux3D2UGrndxU2WNawTMl/OrELsOYAhuVGQlq9ViJQ7szL1C2QU5y23pFfKEm3Ng
	StC9cnhjbgY2JuYA/IpXB77+dbrs6L0glGhzFiLQQZzeIoR4Kpv9n10h1WNNVJJtYU7Ikz2dsG7
	4wVbAV6q2QbtSC0XbhQBRfUnGzUzMG5Rd0mc/L0sbm+1q+hH7f5JXKRNOvBNTqfGm2dPRWVJXTv
	s6cQg1t/ifU+syPlJ7lxWMBFb2lYAGQnU20asvrON3u2a3G7bx3/71fRok6EwYPqGBkkAA7V7wa
	5r9FA3o7aFrmabWieFey9H7lGL8ZPfgCdUvhr/8y+QTRpUvIm59/YhEDys8f2wGpnm
X-Received: by 2002:a05:693c:2b0e:b0:2ba:6e87:525f with SMTP id 5a478bee46e88-2be311e17cbmr312357eec.34.1772600180347;
        Tue, 03 Mar 2026 20:56:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be03fc6fcesm8256880eec.1.2026.03.03.20.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:56:19 -0800 (PST)
Date: Tue, 3 Mar 2026 20:56:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Input: aw86927 - respect vibration magnitude
 levels
Message-ID: <aae7NQQXJYaTAOGp@google.com>
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
 <20260302-aw86938-driver-v4-1-92c865df9cca@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-aw86938-driver-v4-1-92c865df9cca@fairphone.com>

On Mon, Mar 02, 2026 at 11:50:25AM +0100, Griffin Kroah-Hartman wrote:
> Previously the gain value was hardcoded. Take the magnitude passed via
> the input API and configure the gain register accordingly.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  drivers/input/misc/aw86927.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
> index 8ad361239cfe3a888628b15e4dbdeed0c9ca3d1a..7f8cadda7c456d7b5448d1e23edf6e3f2918ba32 100644
> --- a/drivers/input/misc/aw86927.c
> +++ b/drivers/input/misc/aw86927.c
> @@ -180,7 +180,7 @@ struct aw86927_data {
>  	struct i2c_client *client;
>  	struct regmap *regmap;
>  	struct gpio_desc *reset_gpio;
> -	bool running;
> +	__u16 level;

Just u16 outside of headers exposed to the userspace.

Adjusted and applied, thank you.

-- 
Dmitry
