Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B52F5313
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358376; cv=none; b=XHr9/3Uk8xO76hza7KLFDxn6whdYUlHU9sn9zB++95I//KGIdbtBsAphLRC1ABRf2srSKXlmCvvkVZH3RWk4j+ZxrX02iELaZuyfisyNGX3zUV1jH1wQ1aU9SrWNnagLuRRHGfb9jaiXrtVFDXoGMHFxvxVRTQ00E8U6DrOtC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358376; c=relaxed/simple;
	bh=dHBwqhTYfbY9fJIHTmYEjxPraka/sj1Dbn/aCnQQgls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA9JqAMvjpdxmhLlKFwQG1e0nbmw5mO3ag99TYN/wUhhomHtsUAfsQlbRZnRX6dlgH7d3Nwdsjn5DoP32icbneuRvnzbZCSmVxxo/NVE9bbdrIw8jsdY8H1p68Qm8+YHNs5M5MbF68+4WAO0wmaltHZOSfl3d3jLQ+N5brSlRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kEDcriMY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kEDcriMY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso1813266f8f.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783358373; x=1783963173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHBwqhTYfbY9fJIHTmYEjxPraka/sj1Dbn/aCnQQgls=;
        b=kEDcriMYD2qbvjO5qDz42WB9jgpc/wXissBLYzuLKVsDh37RLvM+1Wpwqe/L/wEgEn
         Bzsimd3HEfJTDr2JQ1aoEARPmt86aUvKAJPMr4216YOUf6zz2G7VNmJhatFVULtcqrHk
         m1fpgsSVtiP7kP2daY4SrEZ50S+wwgF7Go/D1c8lt9Rgokyf3tgg/AdebvEAWI1p0Jwf
         b4yEcNcmJKzOc36PhLqkk0B93aBUJd6DPSi6gz1PY6cz7S3uq4SN/6ub1csvN5hKdiYg
         9rAAk3no0/OW/5KI/vtXPUBKPgFHofH2GAt6YDj2Zdia4rhvZqdSc+f278HR19pm74WW
         FVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358373; x=1783963173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHBwqhTYfbY9fJIHTmYEjxPraka/sj1Dbn/aCnQQgls=;
        b=Rywd4tSdPv6rRNbKUX0rKQvVfP3emZCNPPF4LG6tm/3g8n7vUapextCRq6HNy3pTew
         j6yb/dVVrsoiWC3QK1xeh8EjzKFWtMtJUmNivnj+QtrAZBsZKiH3qGR3FXQU+++makK2
         w0fX6y5WCcSiFNIsDfx21jD2M+bBAJRA4NS+oat+TAZX12N6I/9I21nj0ttqS56o8NHg
         jci26aysVOsfWt+XOqUIVFgglAKj/R2PpLe2b0PR4mVlVZhAMIXQRp/2VkTMmzU5Yr/P
         s+gJ1XZZLFBtR0yBFEqWB8gCPVH32lBHW4sJPqyyZZddXNG4UhtsiVh4wceeAj4IBKeu
         tqWw==
X-Forwarded-Encrypted: i=1; AHgh+Rrjhs683hqlmypgeMA/6gmgxepkJ3sKWKTYjrj/vhHpmGe/V0Eyw2OmEXSAuGohi1SPx1i60tTL0PLdoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11lCR+yN92zgWfDsj85vkM3Rbr9XgG1j3Gcm51tmlezQlAuC0
	TuDvooTdrF91XHd3YrdSiwwRrpp5ovq/DRZn/q00+D1G7QmN7mG48hfeBY0jWpyyagc=
X-Gm-Gg: AfdE7cm1g9/QF86MQJN4KOwNC5qzG7HYY/GBvI4Gn8qqqMjjpozA/T208f1d2XldK/h
	mzlLPsWmL3A67AGdVoOfF3nPunQ6hlIK6Z1Xa9LbJh6gXWOYcrZlpdJwuvpNe60eOTf5/6IL1bt
	4Tu96vgScZD+IWGleii0GM1ceRdm7sApg6aS8fxZOvtDiUS47RLruuv5JvVunmiguI+rbzqd2VW
	ZKBVLs0DDYa3+8gIe19TpUH3Ab1Z+2xpmSBVh6R+x+zsCb0+TaN8adxPfsujXVZslrBQZhN1mRu
	yoxD4WRw5gaz3L7DaUWtDSxWaZQRUhyOhymZomAzcPFedHb+dG2jaZ8yjyYRhVgaymu+q6PyNCp
	4cuUmrFYtbJYKfTE5pf9gRYRvJo4zWgbKQJQkjiTFH5Y6EyePEb3VYPyzY1j7sfmrEvm9dSSj20
	ENzX2XIo87kD3bQBdrx9OUdbEfQxdr4ghq9qg6vl1vlEsSH5/ueIRWF0ld7RHRobiDDAeUlT2s0
	7UDwTZgD4FOlQ==
X-Received: by 2002:adf:fc86:0:b0:46e:c978:7ddc with SMTP id ffacd0b85a97d-47de668ad94mr1104856f8f.24.1783358373402;
        Mon, 06 Jul 2026 10:19:33 -0700 (PDT)
Received: from localhost (p200300f65f47db0404eb41111570ffdc.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4eb:4111:1570:ffdc])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa0f21328sm26811879f8f.32.2026.07.06.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:32 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:19:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: andrew.thomas@touchnetix.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Marco Felsch <kernel@pengutronix.de>, 
	Henrik Rydberg <rydberg@bitmath.org>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: Re: [PATCH v7 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <akvjh3luyvQC6p2w@monoceros>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xu5avqsjxngvurz6"
Content-Disposition: inline
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>


--xu5avqsjxngvurz6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
MIME-Version: 1.0

Hallo Marco,

On Fri, Jul 03, 2026 at 12:32:25AM +0200, Marco Felsch wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need.

Thanks
Uwe

--xu5avqsjxngvurz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpL46AACgkQj4D7WH0S
/k7IzQgAuSytq6eodi1gpj8Lnqny84O1wKdC5ws5BbWBuQOxm3s3uS09akU0uyy7
uRPzfliKfsoSiM5ZhS8QmBeB68z2OfPvzSmYA0wATJWYxOMFLub2dpTEfHtJqf0i
C9/oSgSY3vmO9x9yP1C/Sa94x5UIGdxq9O4C5KkClNaSlED478Y5o70Sk6ZHr05q
5jyaYk6Xtyhrf4uYqliu5ewXlywlG34FQC231sEMwslfWgx7k/ifmngUUjrSUAmq
uXweNMRNsDS7DLG0MJHHSm0pOUgcaj6hEVkatXHvidT6c0d9zUtIDOL+Bvf0EIcI
EJRrPkRmRlM7GUO8KqNaOEmvl3BTIw==
=SMi+
-----END PGP SIGNATURE-----

--xu5avqsjxngvurz6--
