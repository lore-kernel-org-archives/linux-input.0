Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0E72621
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771469015; cv=none; b=aeht4BGh3+jUAn/ImjHu5N1/ICpN5yIj0NpHA1au9xhEZDmhtTnF5JOrt+CHmi36PavPhJMsBJlFxkufsKo+lAjdU2FnPeFxXegKf5lg9N2+UTEaeSwAoLfdguZMs2LKYb84ZtHBW0cDUnJ/oP9hqclF2uB7XBsSwH0IBYGQLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771469015; c=relaxed/simple;
	bh=KqGg5WSPpAb6AJ2Q67bzsJbSdSO5yc4vMcgZLK0hulg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgYCQcMPKRQ+nubefPWZX9FiqQ+WfMK5MoypSATxKI/Bo3e5xtd1UL06XRvVp+ruqIyvSQx6s2gpY0Yflc1Ei/KjJ3OsJ+uaLTCJJkuXmDlQDITKSytOAPmFW39Rzsn5cAfhqrXOnZ0G5PaGSsTmMIl2CFRP+PiBLvFAWRxK8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRt7OXsk; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRt7OXsk"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba94dbf739so495036eec.1
        for <linux-input@vger.kernel.org>; Wed, 18 Feb 2026 18:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771469013; x=1772073813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTKrUTqUdwYFHuwWVgZXgaQ8n3QIp5eyNYtOEVUSSHU=;
        b=hRt7OXskXZbGmTnNI+o3gVtG9MEG7NTSUzObi+apxAyVPIc2plNQ5Zh0yOXzgc2R6F
         FSIV+nT/jmNBbQl+kuqmSLVD0Da8CB3c/mmIiJM4NEr1I2YGh745zgaD9Xt5osDRU1CM
         FN6dq12jnqw1aFvGI+Xu3opJYZMVcE0B5A1vqgSN4FRoAcS86hWgqFc36RRf9apltGd9
         E4tx+Gq7LsEEdXO1LrJqSasElsglk2X14BYj/SHNbBE7Umkl8RTHMWmAGVFOEmxjxtO4
         Hyq16L3vMME5L4KYlHhpg9OmHTJ7G9Y5RgR/2YXsivmC3OVzI7tlKUvOUgzbDouxHwKq
         JGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771469013; x=1772073813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTKrUTqUdwYFHuwWVgZXgaQ8n3QIp5eyNYtOEVUSSHU=;
        b=d+mQR/pDiJVR/JFd9OArB5HeGOu3GyWsWpn/91W5CUqSZCTPyu9E9gR279KgROWTW7
         oRRBE16U6I9+n5weCYndAg+ozb8KKodUBcn5qcQH5jdi2HD9buB8dSvwqmTzWgN7bneP
         oCnCjmx9cKFFqGKKgkiqGs9rmQ4hz69XLW7nNiuZdoubZl/6JEc/VlFm/wB1xJJAjczi
         2d/frnal5waf2oySjpjZKflvk689qQusexwFMuM4NLgm0Ow83Phfr3mEwOhVmaP38aEQ
         HBY5v904QtCQVxxKMVK+zS64PzAEOXUiwDGEScYZkwELMVDg47ejKBbEBULwHfC+Tc/W
         q6Rw==
X-Gm-Message-State: AOJu0YzYWA0XDWqus8jc4E5fKqg724tv39xESq6LJ9G16i/s2gaI62T5
	QteOS7seARE/IRolP2/qDvweh38vPA5VJF0+BiuEJx1NsCvJHrA7YZ4r
X-Gm-Gg: AZuq6aLW9JLmZTqB2mliUQ/IztfOqmzLGR/RWYT9xZxxssofyBZED5DhbzGmf4pLKes
	Rej0727sSORDSgcqdCgeagprAwJOv2oXpa95fiQGC7FLswLJNpJkavmvnztfdRS0PZYxtQXsftp
	rNa0nzjh+eTa4dim4IcsW2d/C6shxz8ENL3Zzufg82wIx9FOovWZx/yo0ayO+s93eaPUl5GTGqu
	tNf59d43hhWS4hAJ05CiypZcilag7VfThS67Gpnb8L/epc8dhbF+mNqTEwHFJn2pesPCS7SS0d8
	8Csoo41IALYqv8Q3H1an/iagCmGsnHSieOI/wqg4aGQqCiTWRodcMH21xVY6kDHP1GZLQMvZ9Xw
	SaW+iYDQ3OoFtinlTdHLmeu41fCYH71TaIBr47kRoxjnJzSsi+JxKPfgjiqdJjWn4rVW4SlmBjc
	F4YW3GWc4AocPP/LzLwfpilw+NH+JksMY3EhhpJ5xVfUrgdUXv6H48X9bOttkRoP08
X-Received: by 2002:a05:7301:6091:b0:2b6:fa0c:6c44 with SMTP id 5a478bee46e88-2bd50009ef8mr1690376eec.12.1771469013002;
        Wed, 18 Feb 2026 18:43:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543e8dsm20020155eec.5.2026.02.18.18.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 18:43:32 -0800 (PST)
Date: Wed, 18 Feb 2026 18:43:30 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 4/5] input: drv260x: Fix unbalanced
 regulator_disable() call
Message-ID: <aZZ4jqZQZ4vA1SFO@google.com>
References: <20260215141435.727872-1-jekhor@gmail.com>
 <20260215141435.727872-5-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215141435.727872-5-jekhor@gmail.com>

Hi Yauhen,

On Sun, Feb 15, 2026 at 04:14:34PM +0200, Yauhen Kharuzhy wrote:
> +static void drv260x_remove(struct i2c_client *client)
> +{
> +	struct drv260x_data *haptics = i2c_get_clientdata(client);
> +
> +	regulator_disable(haptics->regulator);
>  }

This will result in power being shut off the first thing during
unbinding, which is too early.

I switched this to devm_add_action_or_reset() and applied.

Thanks.

-- 
Dmitry
