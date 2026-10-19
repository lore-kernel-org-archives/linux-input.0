Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CD47C0FD
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393077; cv=none; b=hsRGI278HQp7sYOGCh7TGRcmC9ltzoQ8O8tlj+uv3eTGWqNuucm9kAWqNPTgoju46eoB+VEUe/YYRxHC+kXSwJ9wAvyc1jz6C2//zWQXrMquOQFtaaLqB+NjHTS44QMtTpS4f0YqUvZMtqQi+nrqPugfQ7SHZhyHIUkUfki4nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393077; c=relaxed/simple;
	bh=iUN7PS0couYMcfpfwhade+kiv7G0xPySdLn5zBMJxjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQHDJ36Q1URjKVaeuvxFLd2RgiB5P2jHD9+hmFtDAYpHWh4sQCSz6peB+2aRIYj5HGofbKQn4ceEPfF9CfVq47CwsMP7s07CT189bt4hQWeFALsd/t3HvCIn7W6M9YBcfrupDKNxIl9njs5pBHVKU/DodCuNtIVesoQpO+rrHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Gla6Mmvp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Gla6Mmvp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso18707275e9.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792393075; x=1792997875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JxfSK5IZ5O0IFCRPnkbx2AQWRlFboHtFQ8aMJNkMXv0=;
        b=Gla6MmvpNAXYtrsQEwNChSPo3bsSA508kW9imXv7qSbLZRJZPu5xYkYDl7509P5En1
         j8yxDBnAjUKFcZstRhuTfOk16M36BDED2koQZROUGZmmrfaPDgnF7z3Mf9aAGP6tIOsO
         6IT9RniByFkcDVBxj/wTT1HO9Jj42OPVk3dEg1w23ODLk6hmK2l9tEM8qB8Hj1Of0OXC
         j6dde1bfDSl6rsLmegP/extpE6NPBtJmrNy/qhKWSAe/0YNNjvu39eH6O1q45Zbc8L98
         PvDUc/YR/8/KpE/xw2Qh4j0UPlKizof5dBNGb9dwEUNqXFmz8eXsY2p8h0VmCn4+sEPz
         KEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792393075; x=1792997875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxfSK5IZ5O0IFCRPnkbx2AQWRlFboHtFQ8aMJNkMXv0=;
        b=ZcUiYcpUhs1Cpbvv6E8QrxxDqqT2rMSkfFoLyPnFm0MI2MlR1D4eSpwKuV2FJ/jdXh
         zBI76NHTWcOYCYxIwKXCA11O0QpJXL8EaChZW0LrkUs9HQ5NY1qRZSpFWOArn5LZwLJ0
         nRvbIyBXvAmV4GuN68p6uftXVn4NMi5nP7NadWUANGcQLqXSssL2rplEBP3ozcdTQjSf
         dJ7WsuN3B9wLFTPAlWUY9vF9eBxoiMNag0ChN/Xu1kvu68YWXLJN7L07JGLB/I6awTh1
         PpjsqNocrayX58QlRyGs0c7wbllT2bz7EI4A0h1O+ndRQdt7JQzgrIP8AfB69qvbOjFj
         EMvg==
X-Forwarded-Encrypted: i=1; AKwUvBwQCOQvit3C4L9sAzemWDidkeVOyWCG06ufp5m/jHDh35Ha1TksVloeWR7vqOrxE5dXFCT0au0fEabiDA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLDgg7Wc0ys+c43TupPqKP9R/ZFZUwDKQWpO6BEGNRTv7CQkTZk
	3TKzUEYYK6tLP/LdCHwxiqk+d4hU9aO0/BsQGLeoFfwwKRJv4AMESBlXHGbbFC1HJIY=
X-Gm-Gg: AYBFou1FjwS28N7NIzcLyeILaSrB8jBLOxd5n9Re/g352vQHfWMOsm/TDBjxjMYwNTg
	ARtRc2kVLivUfz08jPGubm6morZlruGkcqVIaLXfzAD4GrCs4lfxPQFttOOlMUOjuJjHHgkklfa
	q2fulCK42PU439T6q2wN0SQ1j3I/qheE5Z7M3xwZO/cnBGwrSWlW7ps6D4AJkdQsYpRznRgDu+O
	vuzkQdyZC/7L9lA5hbHmvuT8Yn2Wh4SyP95AWoGTludcgjMXLil5v9sPMXhVmW7wRK1n9wkFQJF
	j/ZOnZHYiCqJT7OwaAvcTARL0+rY1eyEeFHrB1rhnFO+L4BoBRURW4T+GZYQ9ixDYku4m/SbCDu
	vHmK0+GUd984Qe6/QBbab9xv1AzH+hc2f6Ddbnju7hjXiQdQdHj93/uit+kvpDtNDWmIY22+8fy
	71hic96Y/lkavvQdtoUOJh1dExkXjETgBB/wDZB3Vx2j3GJKCydbIZacgqQ45QXFV6JEBxis2a2
	vbOHg9Pc7zdtbIGtdTSYJ6rG91Z3rgxpBmCe2bpQO2qDlFYmC5+AlUsxzjDrg==
X-Received: by 2002:a05:600c:6992:b0:4a1:d7c3:d3d with SMTP id 5b1f17b1804b1-4a1d7c30dd2mr130711935e9.10.1792393074742;
        Sun, 18 Oct 2026 23:57:54 -0700 (PDT)
Received: from localhost (p200300f65f19a9041674bacf58593a35.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1674:bacf:5859:3a35])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a1ce3302b5sm172374155e9.4.2026.10.18.23.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:57:53 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:57:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Luka Panio <lukapanio@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722
 support
Message-ID: <atW_DkB9H0oV6U8v@monoceros>
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-7-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6wnpoaklsckkwk77"
Content-Disposition: inline
In-Reply-To: <20261017140827.290666-7-lukapanio@gmail.com>


--6wnpoaklsckkwk77
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722
 support
MIME-Version: 1.0

Hello,

On Sat, Oct 17, 2026 at 04:07:54PM +0200, Luka Panio wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/spi/spi.h>

<linux/spi/spi.h> already provides both of_device_id and spi_device_id.
So please drop <linux/mod_devicetable.h> which pulls in a lot of
unneeded dependencies.

> [...]
> +static const struct spi_device_id edt_ft5x06_spi_ids[] = {
> +	{ "ft8722-ts", (kernel_ulong_t)&edt_ft8722_data },

Please use a named initializer here.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, edt_ft5x06_spi_ids);

Best regards
Uwe

--6wnpoaklsckkwk77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrVv2wACgkQj4D7WH0S
/k7AvAf7BT3eOJwLMHu3yGXN3CuhrApIng3UUqEXnJLyTpbAVT3F/gG90raumnhq
UGl7PXQ3EXG3LCgRIkwqNQfJTBdwdqDdWo3Lv66bmIy10YRgTHNn3eSn7k/D7lXO
xyJhy7u785DrUyBAk7c9VgnpQ6haEx90dQDrvf61edI7+BOKLs+oAkHXwEtgtmkd
NV1e9kIbW6JTHGAlsYSW7YIQKDy38zhlkXyu/L/A+oBVUHzUss5JOvOuekGxzdQb
R4iPyPcrOU1VRxmAckvzHVP8imXWy7kP1HTL+oPtjkyKR7w8eAY0Vow8hdLsbYvp
TyIOSLT9Njcket/gjkcISbC+l1pDkQ==
=k8s7
-----END PGP SIGNATURE-----

--6wnpoaklsckkwk77--
