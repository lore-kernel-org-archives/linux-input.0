Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4535C698
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791759984; cv=none; b=kf91C8Yq7yoRuR2HGpQkusLt3EtNxp7wovC/DGUHBXeO+PO8AtHP8QZ1Cnibq60Nshor4nUQeiHwlwXzd7J3hfDb16yJKF3rXhqdE6k+HwfTnySnYmoNCVJPgK+ct8oCZ7i9uVbMspuCkD+/c57UYSvCdKdGszRW1Cwpe+tjcYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791759984; c=relaxed/simple;
	bh=GId+tRXTCvTzFm3HINSe/LmkKEkAakiciV2ix96r7+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au0gcn+x7r3INrS6uP6VyWeZ4j+s/ipz1Y1DFj1dJubQAPOG/N9l0DE+MJbXQGpGhZNbhr53fl2IpJkHaSWIHkk+7KBSNtQXjQM9UR2Xl4UsAXVUkqrXnx3AX8rUcpZNdTD/FHqt/NhZ5OU7NPEchNwI16YzB7f0vX3gInYNgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QXlcqlfG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QXlcqlfG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48870973bddso750102f8f.1
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791759980; x=1792364780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GId+tRXTCvTzFm3HINSe/LmkKEkAakiciV2ix96r7+k=;
        b=QXlcqlfGq8qJflB8PXiVeVhLNEArs7zM+5eyofiXwFPfWETqNKQgEYbd0pTB6Xy4ft
         l4q2tJuxoOb9j8yBoXmk14mQLz0YQVoYNmeRJ1EjVXB75Udsm1j6oLS1cteb8+Ljq/Uk
         PwjU6Td64OjPURTdDizsrvAe1iqiP4B88WH+WbcmDKa1eTyfOZle2DoD3R1LBqFSKxKn
         MOc6ghgvBjDiyYdULGqrzQIcB9UFLxjOsbFlhAluW4KpfKPv9jUI6Ke8Xt+T1Bi+taJi
         FwVF0zcAApTf+6C82ep7AvBsNxi9OOPcVP+FZelgFDLlwDfG5LqIq399SipNvoFo35+J
         Zcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791759980; x=1792364780;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GId+tRXTCvTzFm3HINSe/LmkKEkAakiciV2ix96r7+k=;
        b=azGIGagz84exnFPjJboetiiJcz6BX1f3r2BSB+ws7L4vqnlISNNGBh4GezF8ekkZ/U
         hbXU7rgp4l7Xgz2cRzdOLkcvdbD4vZNDaEV3gn/0zjq+Pmgm9n/KvsLPzSpxmI2jTV0+
         TB6oxaZhXjPigM8YjCntNXaH8RXGtzp+jW9xgTRO9BvPp6ADdWiy1oNk/SIyXaZkkWTm
         sc03JzPHEm209TimoKPthgkRIknkHEbtUFkQNVuGVhqoC+dBT+eoMF1uTjSvSywwMbg9
         D3E/HATd+5WCx7MwEiD7w8009aDvTyCXQf5adRXe+YAZUZ3y6tG8LdTo8GsV96sBZDyO
         XtBQ==
X-Gm-Message-State: AFq9FYKnBd73XEGNAhwt/14voi7Vy0Hd83xvEvNih38y7UFwDJqWqh/+
	BKn1cmOGC0Wdo0UPsiOOGbgw577wuAuRD3IrnGEr9k19xctcDfEmpXmWqo4vIXXcDuQ=
X-Gm-Gg: AYBFou2fMUHAcIMLr5Nr7o/yohbl+syWs2qnoZt3GhgK2sVGnwgd6UApcRysZ2vq8O/
	zAGyV0W0qr3WF+B4QYrAJioTNzyR9O32LT99/mgLzU/VqmeFuOJFh+FwYDyURzA8H88KKi7nEnF
	YdSfPjYJY3iS2QCh+cG6yGmONigABagmmEDjjbFqeBu4YwWWFf3t9ZnebdDyBTXcZx6Xza6+CM0
	K2/71anJPZrAhlZhKzAu4Ccxzr6U5ToVSLgxWgk9ZC0DeGXAU9tRIexGmqb12QIyFvvErKdNJf7
	RiuR0Nj//kojrQ2IMIw1FBFyHI+cDdqVNXFdwPy/LC5JX6Mx4358F+iHPDu5V+9lmBQpi/j0M+p
	iP53md2VejhZWvHZg/CuM6UQMS115kcYzz3KGQbrtK66fWFkisP83HdAlu1fQMJYqtKH8t7OsLx
	75cr3FGlQ7Xqc+VeQyezCN9TgLCpvBsm4QUxK5GBim9j71DebYiF0MS6U1jp2htPA/lI+PFPP8n
	8c=
X-Received: by 2002:a05:6000:2306:b0:488:8347:a110 with SMTP id ffacd0b85a97d-48dba9e6163mr13299157f8f.7.1791759979566;
        Sun, 11 Oct 2026 16:06:19 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48dc1abcaecsm12488698f8f.18.2026.10.11.16.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:06:17 -0700 (PDT)
Date: Mon, 12 Oct 2026 01:06:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: =?utf-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, allencl_lin@hotmail.com, 
	tylor_yang@himax.corp-partner.google.com, felix@kaechele.ca, dianders@chromium.org
Subject: Re: [PATCH v6 2/3] HID: Add Himax HX83102J SPI touchscreen driver
Message-ID: <aswV0ATke05Aa-q5@monoceros>
References: <20261011181633.1778969-1-michal@nozomi.space>
 <20261011181633.1778969-3-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2zn2xrgow5dc2xy6"
Content-Disposition: inline
In-Reply-To: <20261011181633.1778969-3-michal@nozomi.space>


--2zn2xrgow5dc2xy6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/3] HID: Add Himax HX83102J SPI touchscreen driver
MIME-Version: 1.0

Hello,

On Sun, Oct 11, 2026 at 08:16:32PM +0200, Micha=C5=82 Kope=C4=87 wrote:
> +#include <linux/mod_devicetable.h>

Please don't include <linux/mod_devicetable.h>. This file introduces a
big amount of unneeded dependencies. You can rely on <linux/spi/spi.h>
to provide of_device_id and spi_device_id (which are the ones you
actually use). Alternatively---if you want to go full iwyu---include
linux/device-id/of.h and linux/device-id/spi.h directly.

Best regards
Uwe

--2zn2xrgow5dc2xy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrMFmMACgkQj4D7WH0S
/k4MXgf9EcZ3GfDdHxsy9EN8ExCwEfNg60ObLE8QD0gdVxF+YdCbdpGNF2XrpYvk
exy5MWNHx1evhGI8uT/bu9C/jyhN3agP3CnjN8IYUDxTDMIt6AnsMR8o/K87exej
Jwx8C3Y9Yo3SQpDDR4mJF9ftPo4LgbCWne5l9cEAMH4M2i2xBYSZrMNHdPsRZ8rh
91JD5Nl0fgYKcD290dVrM6Yyzy0jTpbUgTEm039g0ev8eEvvylQcfsP30oqEDaI9
sHPHaxeZY+jPpKiOqzfBMP1IzFSQNXt86mzcWDLKLVHalJWEh7O1dnfv1SqWhPEA
s2aLRmZvKqCLimKqBYM+vLnmUtqynA==
=yG/u
-----END PGP SIGNATURE-----

--2zn2xrgow5dc2xy6--
