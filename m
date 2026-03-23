Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6A3DFC96
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297951; cv=none; b=EA363WMiz9Cl6j9Kyj3Nd2PUtRTdo+4XEKOGVd893TLIASkvWsL5EA7wkkEbSGS7asRkWixVmua/dpR2leZg6NwFTzJydrketN2VvLudSS38d5jfCO3eY7Dx4boLS2ThEtmO7y/wE7eR9ROQJ0916cnvq0swqecwvuVXzlK/YIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297951; c=relaxed/simple;
	bh=vKr1o+xcvtyARFnNKS4XmL/e15jdwYB3uzKSAhU0FFc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=Qwbt8TdNES7Y96IeG50rDvUQzw5FfU6/nxkOuWUQEfvNzUiWI57qPNqRPmpC4Af4r5z/i4zopCI3Kz76SV/JEpZk69LOuSlwAW8BIz6AVQN8dqx9D4PMqGVbP0xwA528UKZQCm+w9/zv2CZCeCQu6KlBVkOCtj+0rA9L190Qttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULJb6FWz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULJb6FWz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso4863255e9.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774297948; x=1774902748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OCAEANHloCBlckd/FaGmdaFDjZ3WvYrU0EDYUJRr+Q0=;
        b=ULJb6FWzS0hEjHYUQ8nbasHg8mxQ3abcRfdQHUVANnXuLoDRJLQYkLoJHp9yzW3S+y
         5PoDMJ9UcXeplhJtnwzyuLBafA585qonKlbeY1sKDG+ODuzR/taTfNK+mXcu3Yyw23EI
         AzmECpnkgA5J+2Ip2iWPSKn8pPZp3x4e/VJdwETHkMLDRAU4UwVhNjYXuNK/RrQIxHYD
         VTjp97fgLznXW5w1qow0WSnUcLh3mXQPj9Rx1e2p5Njb6RmwVRW+n5lmKpT9OAanda2d
         Bqxh4pKztslUnkZpIAuBHlEK5B9mwjHGy322trLTpfWeO9ra4o5sP70dWAjzZ+hR1DEp
         fibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297948; x=1774902748;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCAEANHloCBlckd/FaGmdaFDjZ3WvYrU0EDYUJRr+Q0=;
        b=QGet/mJmf69YP7nir+wRhoBD3bHejEX8XxrAmZxp1lb8myjdRxis2rF81Qlj2zj+/8
         GW1bETw2EsywwB/i42VMTkHsPId2p+KHIwwo+ocm+M2SYG5B4GYoBtgjGM7+uERkt5Rf
         NWIPmRF6gVdvu2sK8/pw/FDjJhdZovrEy4XI3x3h1nUWU7SoNmHihc/mBlavjZ7aAabK
         IOWB3lkcf8IC2B5Fw1uzGGmwqp0RKEx0fBaLtIwdsTmKUbpX52RbUlmmU4+6QdUx3BZd
         McC0ue834S9yNe81Hhw93RjKVUs8+fmXexlkFnNGf2VC2MjTl6sq6UDJEpZ5kZn0KKfq
         xQGA==
X-Forwarded-Encrypted: i=1; AJvYcCXhHhlj7p1UWQZiaHC2cF886aPIyUHUQdC9yEFJtMcqjvij+8NZL5rZpgr2Ho7UG4+IoDjJjruqntm6fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Y2YDre76YlT/nxe/qvqcDIDoR4fu38h/npnpqlftSKbPzEty
	U7obNkJBPu0tQ1e2SFNtiG0lhN5ZbHtNWL9ZzgC8vy2OdtAu2jznrAP3CvcEDQ==
X-Gm-Gg: ATEYQzx1llEUizDbnqtZZikywWRrJYI4kVzLEzglYMGv4GKmWOIc/RbK+2YwxthQlud
	jYq/0+LD7wyn2BfpTPD+A1SLvPtIVj8crYEo2vSKEJGfU2yuP6JF3qolo57jns7N15sfw1evWZv
	lao8Q18J3A1qAT598nO+LdDrcs70GhLJSpXjg13ErC9PI5qbCA+4rh+KspKy57CDcWMcupKvW34
	GYZM/5U/vGYW/yUvkZI1nQ5Oihm0TVzS6b8/6Bnf8sYHyJ45MRjP+wiOIIIvMRutfxOe9PgTN1D
	E9EIbajXgY553sSS46qn9FRUjoEnDaOHCGZY9ns2fCok7mz72eVhN9Su3P04QRIMqen3xULQZe2
	wxjzKwgR8U7XNcUXE1eCcZkilLQCrsv9pCS8alYlfRNGCR9GmXHl+aTy8AJFP66WxGGDQ54JdN+
	sniBqdv0L64NS6xg==
X-Received: by 2002:a05:600c:a416:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-486ff0303admr165396455e9.24.1774297947800;
        Mon, 23 Mar 2026 13:32:27 -0700 (PDT)
Received: from localhost ([81.6.39.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e3a94sm309803705e9.7.2026.03.23.13.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:32:27 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:32:26 +0100
To: FirstName LastName <bsevens@google.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Beno=C3=AEt?= Sevens <bsevens@google.com>
Subject: Re: [PATCH] HID: roccat: fix use-after-free in roccat_report_event
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260323161107.3478633-1-bsevens@google.com>
In-Reply-To: <20260323161107.3478633-1-bsevens@google.com>
Message-Id: <2U31L1JXAA5J3.2X316ZXNYHJRU@homearch.localdomain>
User-Agent: mblaze/1.4-1-g5a69507 (2026-01-24)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

Thanks for the patch! One comment below.

FirstName LastName <bsevens@google.com> wrote:
> From: Beno=C3=AEt Sevens <bsevens@google.com>
>=20
> roccat_report_event() iterates over the device->readers list without
> holding the readers_lock. This allows a concurrent roccat_release() to
> remove and free a reader while it's still being accessed, leading to a
> use-after-free.
>=20
> Protect the readers list traversal with the readers_lock mutex.
>=20
> Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
> ---
>  drivers/hid/hid-roccat.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index fd0ea52f7cba..d6fff53d4ee7 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -257,6 +257,7 @@ int roccat_report_event(int minor, u8 const *data)
>  	if (!new_value)
>  		return -ENOMEM;
> =20
> +	mutex_lock(&device->readers_lock);

As the readers are only accessed later, we could move the locking further
down. Not sure if it's worth it in this case.

Other than that this LGTM!

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

Cheers,
Silvan


>  	mutex_lock(&device->cbuf_lock);
> =20
>  	report =3D &device->cbuf[device->cbuf_end];
> @@ -279,6 +280,7 @@ int roccat_report_event(int minor, u8 const *data)
>  	}
> =20
>  	mutex_unlock(&device->cbuf_lock);
> +	mutex_unlock(&device->readers_lock);
> =20
>  	wake_up_interruptible(&device->wait);
>  	return 0;


