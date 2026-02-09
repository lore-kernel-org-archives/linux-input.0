Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEC2DEA90
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661257; cv=none; b=al2AWY36yP9iNKNawr56/LdiNIA28l+0eZjXJZlQ5CLVZTZzFXBCIEzQcB4E4FeMlrUyei6ITyGP461NDQOWMf8fCdqXY7psc2k9pXD9qaUTUlDaJy7ZIFkTWKW5INtYqjU4Q1bwBP1kUXFB8rUGHE4db8OPBZZ/zclDs2XAlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661257; c=relaxed/simple;
	bh=7dN/acDxRQuhaH/mCUZ0BOpdERh0fJXK8ZDUnBKwDD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyi+6XigYCQrpenkuvm8W6ktU2dk528lqh8X9A6A98mCt6PlYH9AYXJiuoU/wZ2877P+VuGCp11rs5N7lBRTlpJLKneTQnj0Vh6JjCzB0XIrmMtPc9ufr1vdsMIbhqRFwiTeBGvEuetc9uVYWefbozWgP3b07Y/b8OoqZI7GsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igYgjF/V; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igYgjF/V"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba73c4fa5eso20581eec.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 10:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770661256; x=1771266056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSV3vsUg8E13DVBRTy1EKOAg5TL6exZt8xqnFEN40xk=;
        b=igYgjF/VgJy9yAqsvDSX5ywe6w2XT2oJ9hrZMGhkkfDa6FnqXlQoIkX8uDqgv7k8Xj
         O147tEC4utu6eHENKXDi8jYI//EINQ+13iA9vUPXZ28ZgUX3Tf/BEaVE0VsZ15aXwL5/
         yfnOAtc7jUVp6gxqRRjfsQFfMXB4o5tYE340Zl9XUKrJk4O0qvSK98bwCrEqqt4QkSkr
         Jo2cVHygQEsdy37CK6j50A6i5FJ4yABmQ1Q7+sRFrUWbo/JKOxNZqOcJLPBCaqD1n1wF
         Yrf5C55tJS6PyHPypA/8lySBNS2xbvGDWimqZ6HI7TfkOLhGkEhdc9FTnqTsIFYYd5az
         mKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661256; x=1771266056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSV3vsUg8E13DVBRTy1EKOAg5TL6exZt8xqnFEN40xk=;
        b=VE49szfojS0ixAn+4Sue/G6VKhU43ZO5nxyzhaBp0MFFZd9MNP3fxEF35njurKVxco
         aeOooMxC+lDZHB8+mum1ESPLWasPTrqPV7q5W5vLcOgj/32lhXp0LmfbSEXMpfpD90Dt
         qanyzKC5/W3OMbfvEcn7H4JawRet6BwHdwmLWB02eSvS/vsadLaaf294LGjQ0aeXZXJH
         3hMOYwzl8XKwDD+YEJ7r3ieTJnbTjKR2wO+cInSz80JlDmjbjcDET2eWaipsrTF3tRvb
         9CoQw8IWjCwpssps/HgDiOD2da30yF/m2rgyCUF/Mfe3XXOB/A95ugTPR+Xs7gj9Vlwj
         r8tA==
X-Forwarded-Encrypted: i=1; AJvYcCVpS6okXuP8ye1Kf7nEGf64Z880lAX6UVC7rvPuSv1BA98qAgKL6V7ybvmZ/M/70xJ+AEc0rt6jDwxZ8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPBjqxEPhLIBC4gq5v3JYqdYzWToy0rseUXrwWra4AvCjeF8J
	gfDaHxY6KAjZbm54kPzeKkBD5uBpYoRPiIA79WlkEZEIkNYT4DmA5rIa
X-Gm-Gg: AZuq6aLrrIHVLupy+UBCueRoBNQEkQ/NQBuGsXln2TYYkZA47Zq4/RhT9CrxZ6FCdnM
	uOo2FPAH3u63EstadtRbkyuY8D6j2J2mNBX9yav2mePygTSKPgVY+k/B+V3shjoZhhV6o+zYSqS
	2ftUm30O7V6dhVIyQeqiIu1uKP7T2ZAcgnOzAtK3x1TAbE9wl9ccGLNEsJ5OkifF2csrao1gJoT
	hcuEuE2jCwERLK5ce52EmckPtYlRTlh9aebM2d67XgzNykprMzZfd7TMPLwvHN610klCH+TMAec
	8w76nEMD1M0m0YZQFUucNVthW2kTLSMbgkCZsaXzmpdlBJsAuqrwkoun9HHU9f73fSS2aFJeKbE
	tOstnOEfItIXV6AjVwlwJ/MJ0iw0GEc/IV74HdqdBNanbvlSNgQTTLljIlLUz/rA4KeCFVF7lTX
	J/4qc4DBiH0Hnw6ufgT2AtcfBvuBOyHU0IjMGjo6Xgj7Fbbz9wZQs3
X-Received: by 2002:a05:7300:e207:b0:2ba:7ed9:1566 with SMTP id 5a478bee46e88-2ba7ed91857mr794184eec.25.1770661256115;
        Mon, 09 Feb 2026 10:20:56 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:616e:78a2:cc03:4be3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b95505b8d2sm4714919eec.6.2026.02.09.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:20:55 -0800 (PST)
Date: Mon, 9 Feb 2026 10:20:52 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Simon Glass <sjg@chromium.org>, linux-input@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] Input: cros_ec_keyb - add function key support
Message-ID: <aYoZEztHrIx5CzwQ@google.com>
References: <20260112093309.240905-1-fabiobaltieri@chromium.org>
 <20260112093309.240905-2-fabiobaltieri@chromium.org>
 <aYYTgxi0mcPVgpTr@google.com>
 <aYoBTEgrirtcW96F@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoBTEgrirtcW96F@google.com>

On Mon, Feb 09, 2026 at 03:46:20PM +0000, Fabio Baltieri wrote:
> On Fri, Feb 06, 2026 at 08:25:14AM -0800, Dmitry Torokhov wrote:
> > 
> > I do not believe this flag is needed. Always do FN processing. If there
> > is no FN in the keymap it should work just fine.
> 
> The problem is that if there is an Fn key and a keymap, hence we process
> the Fn keys in the kernel, then we don't send the Fn events, but we
> currently have devices deployed with an Fn key where the key is handled
> by the userspace and they expect KEY_FN events to be emitted, so if I
> let the "fn keymap" logic kick in it unconditionally it would cause a
> regression for existing devices.

Hmm, I see. Then I think we really need to have it as a device property,
because keymap can be manipulated at runtime, so depending on it to
switch processing seems weird.

It is like autorepeat, either device configuration asks for it, or it
does not...

Thanks.

-- 
Dmitry
