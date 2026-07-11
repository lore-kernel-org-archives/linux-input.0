Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2863233149
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783810073; cv=none; b=K0xrYAqnfAwJfdUTQ8ICjHeeV6YUmAPJ36P5cdLTKi7N2Lm0ypmd8PM4Df+ESHL/LymEkegeI8ZJZ839b9YI0W9L1gaaoJh94yW0WVKIjm7APRVOCwTQY4mt7NxwTZ546q9Q2Rvb6i6Xo9ytwQaE8Uf9Nf2c28cq/inaHaHU2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783810073; c=relaxed/simple;
	bh=aboeeCUIcUaO3xT9USn6gRikuUTg1ZLrqdsYVPRWZTQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbrvBxI5myXmTycqx6tt1YoNAYnpNtWO4O33KssHV8HaOGlx929HvfUTIVoHVsgxcLM7Rf6eHgQ0pdH6KzkfdIOr20w+BAoNlBUy/PfF5QSNVirJpBuzESW8+zApCRYrnsooYtZ5NaXIESlvWe9HhAgVRGcIi3YU2tV56vsYv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGWTO7aU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGWTO7aU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cad8076b01so24765535ad.2
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783810072; x=1784414872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dHq/bn+Fso5t22HHctH3DoJ0EJ7q2N6ddOX0jX3sBNg=;
        b=CGWTO7aUY1KkyD3qa8jCKmTnW2vGaiqj3xQhK4kBoFUoeG0KRtoo3ALCA6qY26g8r/
         3W/hBmhd3cuOL3ZKyeFJxycOpyRN0yvnWmgX3qtgvfIE0eJOpnFPOaVwk9pf0RGM1Dhu
         KH/y9QGSVxDkX9UlfmEp9DfeawOsNH4LHbdeXC9ItLplii5AL6vbJ0fFhSvyKfrgazIX
         ffQjmfk5iqu1Om+267X3n/hcMvKZ+hG1eUSWa+qL+atIw8hQH51oC5c5nt1t/FWAvFdj
         BgqvKjJTZd4ktkiFZ+UWSMo+iXaSxHuOoJXwR927IxjA7lSkrFIVktnSiocUMLilFPer
         omZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783810072; x=1784414872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dHq/bn+Fso5t22HHctH3DoJ0EJ7q2N6ddOX0jX3sBNg=;
        b=LbaxY6cMd1Cu+WyZeEMZiNqFWN2BjriSAzlwGLmBMhIdf5C/6AktCHpseXWH4M0ZUR
         6BIdtZHr+4dMwqfBVDwgBSUCJRpb44uKmpaWEQjzFvqfuFmhkRPorzZKbziY8mo7aFDl
         QSZUSXhTRjYAinC+UqaoRBpzvD9Umm3YQqjU2rK4jJbuFeaQaM1Oc+L/JHGToy79nN7W
         2BGSLEgUQQTmrd1mddfYnfAp6YZFkf7+YPdy9vG70+Anmb5yinSHVFfJGCGjuQSQHfqL
         ffco6ItDEWmhhSbbTL1Uu3Ngm4IcM/FTTsi8xvAjwFiyUyW9tYwFemeLfgyrF3KFQJ4u
         +BwQ==
X-Gm-Message-State: AOJu0YyeP3vYzIFyoDZ8Pkn9uUeCtHj6LVBcPVujEp25mJDnzUQMd9nB
	XixdfdJjyR0eVkxvV5dwZt2VHSLxGFoNwVcWCc8eKK26EpJ0QZojlvn4Rqma4Q==
X-Gm-Gg: AfdE7cmlB+oNTKzaZKVOqtqZYykOUnST8XfuqV9hKO+7ueC1eE7u4Ppjac7u6fTqoj0
	T+MMPC/z9bbTLR+6E0uncIdlBliq4vxoRqmbv+6G4dgzN/MZjPtJZHPU946zhXA3e65OU1qAwW4
	2xgrML4GSH0jZyQEFKNuHiokwtVs3TrYdMpnFAVMhewotqywnlv37PRrGbPDZDnZElV4r6ibLEq
	KyTW4Q04iPUuZzPw5K/Tk0BL+PwfQx86xVTvVjOonRso0thu/m8GX3Z4FM/YJHzqvDAnNgEI1+l
	6mXgd+uPxulzuKqM5UjpseC8ZLVf6S9lIln89SBFp819VmDZCtsudyw9WIJiI6YSOrXqqV878XW
	4hX2rY0nIQyk6+vUZQxLifycWp6g/IibLz/Y8aVRSB1iaS5lNV4gcAaUrM66bcX29F21ZSnRsOA
	ue9RUZ+33kkR1Jr+2Cah1EsNKrf2VNocyasnoD8+Ez/aL7uhXdh6gH
X-Received: by 2002:a05:6a20:7350:b0:3b3:e05:7fc4 with SMTP id adf61e73a8af0-3c110ac62b9mr4080020637.30.1783810071914;
        Sat, 11 Jul 2026 15:47:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm50140429c88.13.2026.07.11.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:47:51 -0700 (PDT)
Date: Sat, 11 Jul 2026 15:47:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: joydev - replace ev_match boolean with goto for
 early exit
Message-ID: <alLH3-MqJwM_djak@google.com>
References: <ak8hKSa9HNYPoOZZ@thesun>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak8hKSa9HNYPoOZZ@thesun>

Hi Ashton,

On Thu, Jul 09, 2026 at 04:18:49PM +1200, Ashton Warner wrote:
> The joydev_dev_is_absolute_mouse runs unnecessary Event type checks to
> determine whether a joydev device is an absolute mouse. Change ev_match
> to a goto statement to exit early.
> 
> Signed-off-by: Ashton Warner <drflamemontgomery@gmail.com>

I think this is one of the cases where I'd avoid using goto. The extra
computation is not in hot path and will be unnoticeable. 

Thanks.

-- 
Dmitry
