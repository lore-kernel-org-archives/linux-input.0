Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3C23D2B1
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803406; cv=none; b=hLrlHlbED/hyWGjkwS2ke1oed6WfE9xQvWpIcZPYr5lJMqQB28eR4OK071gvxdYy0JmRMrfcsErdoG35q7v8JjGYbc0UOmGd7A74FutVCfziEI5GULP2mJcZBUq1KIBH69F9tfSNRbBR7yEWb9eAJx8JbX0RUPGubXQgvwUGPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803406; c=relaxed/simple;
	bh=g71acWOwhbzJ290pVkw5jld4zbq8QvuQo9b7GDaGEC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcC5sltfSpla3W4FHoUPJ6ZPg5eDNqyRDK2UAv2w8b8wIVD7kSxZMMYJPdvbW0g6cUMVM3G6DbJfoiWQIKPZeeB+QXMsGO6wTHyyYl+plKvQJ6R/eC6O1/8cVNKCKxTg3Lobi2BIcyOkFG4Z3eUSljTQfOGMWRqD3+OZcnXgOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DIa0nqN9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DIa0nqN9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so13317745e9.2
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791803403; x=1792408203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7k45PANz4WRUzNBot8+/uXuq6lmVd6FWyB01BZ/WnJA=;
        b=DIa0nqN9nf36m4RlBfpYZQPI+f77gxrbxyJZ5sFUjCiDMmdEV14tLg47Gg8uoPiSUz
         duuXgpN/x7YOic1NvA8op4VfHCz3uZ/YDnDyUk0hwG9HeL5W2wL8lBxcUri6+lXczb9r
         e1tSBWEunHButNmitmEhiwJYhuZTFaZknzw8GBt2qAWQdyUQE3v5u4Q9bDIp7D+RTEEr
         Dx0HVMQudXFU7nuRqtb1VIjSE3vnHsCC/71yOYfkBES52qUYCYqq2BgBfjzHV6xaf4uB
         iHYHILux3NIDZ0viCPAFwzbogmh8xECq/p4/OmuATwiEFpxVfRfiXtxnLu0Z//8m6KiF
         /T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791803403; x=1792408203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7k45PANz4WRUzNBot8+/uXuq6lmVd6FWyB01BZ/WnJA=;
        b=mbhWq/+tJTJ3jE7Ef+f1yGESp2hZlpq9MmS8tdYSCUAXyfYqqKQk9vC3gpb6FhvUyC
         53P8wlsopodGUbxLAizZQ5XxVekhX0muza98NRFKcx2umYDlLkZPCZN021i01gFIOC4A
         NUgV0+zQBhlochx09MjyVfa6GT46gLADg4nLaawvZJrWTux0Uc3ElBJjuO0Gnyn9N+SP
         NDw8X5HI3ZZy+d42JlM0KDezdvFKeEWlIUJW/r3T4jlkWWeJ3xVON1Q4HAwiyf2OtoBd
         AdmhypT/dGGJMJOiJYDPhWSy+Yl2C7Ny/W969N3fNnM8CXaWdtGLd0AT3JJ+SOl0i0xA
         Gxnw==
X-Forwarded-Encrypted: i=1; AKwUvBzfh4/80zEKx5xD/6ls6wLbySKdKOZInj16/rXxLMZ0i5AHI/Ihnd9tCZwfy2lKo6wPHH8q9Gcz+IlRsw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+lRLYKhzZpCaQJD5mb87saoT9UQkw+IrBG5n9spOfj3BOKXLc
	FZdPI8ZFK5zIubyNxKw64pSsMtn9kZ3msLlc7i1PR0YXq8QzGGc1X7i3krbRl/idplw=
X-Gm-Gg: AYBFou21CoPwiwq+CUVHFs8EbOazwwcPHse3lEk1J+37MD9H4ZqyrhOvy1hgDSZt3vb
	MX6sS1RJpHngsIBvPyQoQF61ZKGXnPpObc8lp0faTbNMo54ap5MG4/rsO4jqiRhqif4mBf9Jxwh
	QnJ4GsPczh74HOt27wor5fxJaMgTVU0p+yXeMimRr6gDbQdOThzBNhBo5FLyPiRQO42HBWApB8q
	FKFikCaUJLUpcmOhL/coqgy5H9IPbRMf9bMIJNpUTUN1ws5xf9HLyRj+slQNrLoxtdYlKgjGCn1
	rfU5T58iHLNSlUufNuQ7cmF4vqMJ1s0J7fnKATmpRgL0fgQWUQrDjzHRkDa3bslPXITI9Y8csp9
	YmckHn/GoiNYr/EH9/kQIkVW1K8QNep3piFbFzh9budX1ikC9vytDd2YxK+jMQ4yM2HfWfc5lYa
	VNBllLMTfOhdUXrQRcM4wAqWWyblIns7cCAp1StuuMXPEGfv8QZxliz5Lmzim0u2UIU7IRiZphU
	hWzfmgYEOSCnkINeRpkhXF1jlmosW9jN9ZNBvff9M1bKgb6N0KMMgeUeemMGXIn7whw4ik3
X-Received: by 2002:a05:600c:4ecd:b0:4a1:96cd:2f60 with SMTP id 5b1f17b1804b1-4a19ecf4c20mr49066785e9.3.1791803402684;
        Mon, 12 Oct 2026 04:10:02 -0700 (PDT)
Received: from localhost (p200300f65f19a904ade4f69ba751c34c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ade4:f69b:a751:c34c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a18be96549sm391352405e9.6.2026.10.12.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:10:01 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:10:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: armandas.kvietkus@proton.me
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: aw8697 - Add Awinic AW8697 haptics driver
Message-ID: <asy_k9PGKJF9sEXZ@monoceros>
References: <20260930-mainlining-v2-0-40bb1b3943db@proton.me>
 <20260930-mainlining-v2-2-40bb1b3943db@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmteufvncpnmcdgk"
Content-Disposition: inline
In-Reply-To: <20260930-mainlining-v2-2-40bb1b3943db@proton.me>


--pmteufvncpnmcdgk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/2] Input: aw8697 - Add Awinic AW8697 haptics driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 07:18:51PM +0200, Armandas Kvietkus via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>

You can (and should) rely on <linux/i2c.h> to provide i2c_device_id and
of_device_id. Please don't use <linux/mod_devicetable.h> which mostly
only adds unneeded build dependencies.

> +static const struct i2c_device_id aw8697_id[] = {
> +	{ "aw8697" },

Please use a named initializer, i.e.:

	{ .name = "aw8697" },

> +	{ }
> +};

Best regards
Uwe

--pmteufvncpnmcdgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrMwAYACgkQj4D7WH0S
/k4Tywf/fsRyjXKEjyrY/wgZZmTIpTg9zksElEO7EU+qTlrbPAraaPtoO7qA60bT
SPtHBKx/ahmkQ0Zu99dq4o25nV72w1qkroIbtp3o8iAR+Y7gH2vg/agfPaJURTuI
19SncK1Yn1oLj/g9OJhGP/UWN2EthaJ/UPg+GO44EbIg2FjN3izEgioRiCTCGhKi
E07DcJ7khc4dDEbZ/uGFhiUPCgRzUH3ZVOIOFwNlhyJCmd7xzdE7vq/ib1pq2UFb
LGwY26i+PCc8mqIRerCHzRFvdEVuWvKuWSIRzKq0leaaw+hK4ZXAvLiHx1dVJn8K
4wNGyZXFuPwY58DwWlOml2H9vh+NOg==
=yCu8
-----END PGP SIGNATURE-----

--pmteufvncpnmcdgk--
