Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B693A7F54
	for <linux-input@vger.kernel.org>; Thu,  5 Feb 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283450; cv=none; b=WoqpFh3DUwZleVQjfNGar5VL9ZiIbR3d6Vc4owEpFKUjw7OxlhQZMZoMqDqXXTm8HnvY/vEp3DJqu1AaNe+k6R0m1MLbzLZyIW//H7fqSQ7WpLUnPq88U8zp7nEO8ATAKE9L4WOq+Erx5zE8gTYNerSgIkfv95uDf4D5RcEAeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283450; c=relaxed/simple;
	bh=uhvtURHpuu/te5LxBUQMwf5iBL9DYrQRUsB//1jPby4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEvLNqiKNK5DfeRNovPYtrTQcoLcnlXMrHg9wgOCia2ynAexsFoj6D+WViGJaWDHF0aVsWPORFLrL6Q7o1i1Lwe4aNLSSX5AKTK75UcjitLBH4v7fSATuAFmVkbsCVKxSF/vHYcJbBHz+3tgpAaUux5vaJexihYyodqZUsuo2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtPlXx3W; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtPlXx3W"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b74f839bdfso1142655eec.1
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2026 01:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770283449; x=1770888249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyVJiV8wOgvQp43Xhj2a8xz1BJoTUmIJmHz4yLDxUWE=;
        b=LtPlXx3W2rDQ086jPBYoX6DQbVKqSgbGvWtqQQTKIaphVJAHML5ivY8NYXQiA2KRJd
         lOECYLUDglIMGJpiBZrTiYaU2dpGiSMmpnJyRO1x+n7s0d9PgViZu+VXOa6B5gTl5FzO
         IgwpWC4wNw2/pvqT929O4elcopbP7+YmUlBVN9tUtygGun+Sw6LQbmYTgqOtiQYZ/9ub
         fDufo9pkucaERS6EhkZXY72uvoSMAfEge+2v69m3duwUma67GEHwJjmLWpZeescfUAG7
         5LuvtqfRp01S+Z49rVJmuEuHXqN0h5UhJRnjV166BamcgmwyMJqPRj/IpcimVjFzcLgR
         vKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770283449; x=1770888249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyVJiV8wOgvQp43Xhj2a8xz1BJoTUmIJmHz4yLDxUWE=;
        b=BsH2AjuIOmM/YnUyrwc4X5einLZR98J1dHleauY7cDtSzGyoc1Ljap8St68DPZ52cj
         1SKriH7F55D3nv+Bj/eu/Zin8mx0aYC3Ls4DomL+8fa5/J4+DqvDwSFtNRceRo9ZYiMb
         fbfNVYXPMRllQ9aV4MC2rCivWcnPJTaKerXmlnBB53Hou+5J6uxgZnHafyd8envkaeiX
         Z7IOgXs/lHAH2aXetmdyvqNKjqnEY+nyG18jjpnj2pdKe1DVTqIdhMSSVkeqNVkO6N9U
         xbHsU3pd3xfyG9SQokKit/fx9Q7DOdy1hoX/02nsyLRtZCL1BH14Rtm+wt+Rhw4HbGWX
         GURQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdDPoeFBbs00fc8oCHSi8py1qdF/VL+FmG8ZLikhZjo45CU3UV2wd9j00Yw6RB4Y3sit7N9L/m+z5M1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5dFy0Mbg55bHPIdQ0WmF+BrlNyvK85aVm80asBDVFENq0fo8
	vR2WMhKIhEptBsDBkWrC5BO9zWqdY8wjseG8PRRqjs6eHQc4m9RB1Y0RCwH6pqw/
X-Gm-Gg: AZuq6aLi21wMKBO+FhOw/NAx3fNHoZWGnFAS3KVK8BzOQT/6AxLxSoySn3Lk5T6u3Sx
	nWVdvUHE5vYNsMyClnlfQGhNNI/fiD7L/SwWo0EH/0E5m8qCdaprKaKSYnO6UYZakwO1sEugif1
	1gdbq8QdEsB2pyzY7GTziDsXEjJDubJSebdkp46RCva2QgfavGOLITpu8W2d1cxxqOhoEjPgXYf
	/Le0ydP2eGJ+nhGovY1yLqFBL7XHNW6s5MsO5MdFP+7gUOJsIMzZBykB+hRlfU7VqkePCMo7BWc
	JrlksvG1BySXhB6NhP0TwJSav35HFrRmuRcEdjD4gMf2yDwotjTBG+qwkdIbRck9G0AfQhSb3rX
	u88KifDNYFpsDuK2ycnf1nHejsy7H1BfaiNEA0hB9gxHsOGSYoXMVQ/Zk9fNd9PHkZil2eGYyum
	vgBa/dOBALx7/hY/nYiFEBJtsVo6KqkIivqbpx3lYHer8fr3H2tZak
X-Received: by 2002:a05:7301:2901:b0:2b8:27ec:b2b9 with SMTP id 5a478bee46e88-2b8460fb170mr1056511eec.20.1770283449049;
        Thu, 05 Feb 2026 01:24:09 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:9a9a:afcc:9a68:2606])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e1296dsm3012857eec.4.2026.02.05.01.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:24:08 -0800 (PST)
Date: Thu, 5 Feb 2026 01:24:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: hvilleneuve@dimonoff.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: add GPIO charlieplex keypad
Message-ID: <aYRg2vP4Lfqm61qH@google.com>
References: <20260203155023.536103-1-hugo@hugovil.com>
 <20260203155023.536103-2-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203155023.536103-2-hugo@hugovil.com>

Hi Hugo,

On Tue, Feb 03, 2026 at 10:49:47AM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add DT bindings for GPIO charlieplex keypad.
> 

...

> +  linux,no-autorepeat:
> +    type: boolean
> +    description: Do not enable autorepeat feature.

Let's use standard "autorepeat" property to enable autorepeat when
needed.

> +
> +  gpio-activelow:
> +    type: boolean
> +    description:
> +      Force GPIO polarity to active low.
> +      In the absence of this property GPIOs are treated as active high.

No, the polarity should be encoded in individual GPIOs, not via a
separate property.

Thanks.

-- 
Dmitry
