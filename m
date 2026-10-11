Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3772E7380
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760573; cv=none; b=oDfBiXTY8gq9xPvlrhTtEFGUvw84lly5s531k8UnC7jcm7VQpL3vG63McqIp/MIF0MsNqqzLU3wGdAdXrpQtU+e7Ol4l4TuYARUAheydwBTRAyhgP2b33TEzVMcYr6h2ffl6I3jYpIqp1qwLzb+SDjfAZW+OBlAEVKVi6M/b3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760573; c=relaxed/simple;
	bh=LmVQj7uu7MJqrKqgNSP5uYYVsgcU/25VPpMhJmIGlMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfiprf/eh6bVkDIjUib2oFXnaHeoAvFooJgOdSKLJ6nR6DqjOGHs9Qz6QgZ+2J8xY9/gawXqXJD9h0F8G3KPAbMw6GoRkUVarlw0jR/JVZZ877bsNPa3izmGepykDHFPtvAD43hFi/SVw14Q6D20en6BLfjOW3HAEwOrHY/wUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Sztr5wgH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Sztr5wgH"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so11959705e9.1
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791760571; x=1792365371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LmVQj7uu7MJqrKqgNSP5uYYVsgcU/25VPpMhJmIGlMw=;
        b=Sztr5wgHMnUNvoPb0SWAp/YNM6eyxBGF/XwVKdTFZ6ZSDyZmpkrRZ7B3hxKuza9qwM
         sYIEBqQ9SUbmW3ycIykNwl+EuLJ7WQMJOLEn+mHlOIbZ/VU7HbysS+HT1qK03qODor0i
         xZBYGTbAjH2fp3xoZYI+DGTijLEsczwgnXVV1JwdHkfIWczY8aAdqZlc2BVFSBujAUv8
         hmWrUeqOAVTxWNNTTk7erKumnE0ip2PPsexJNPJrPkUJP2TcH8OCEtKfvqYCQP6gsFo0
         f8BpfnIIedJg5azpYToOigcDlSucdnOQSTdoQDHg8kmoufzh8v3hJXTRWW9WJrQNlbuV
         bQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791760571; x=1792365371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LmVQj7uu7MJqrKqgNSP5uYYVsgcU/25VPpMhJmIGlMw=;
        b=fuk+/KdccG0FUyWkRH7VBBExI0iP5tBiCx+zWVpF6IhoTFaQUvE+BdpyNKhpgC41qP
         U/pZwLUk4KcSAvvjyyd/o7DJIb3OXupdOvWyy4DfabWHIKFRELhfRFvkkN6EURcJrI0a
         3//jYKBn9C4S8UMiLdJglJLmn5mLe3d5DDyfmjtwx/FxhVeNYsaPpTILXzQf9sfEuVnr
         S8bQdjrjCjrKg2kEeXye8ipXpQDTeDnojmfUwkh+Xm0pE4bfTZjwaEltKOAEf5kVgKG6
         6wRkFcNXTEKwxQ6P5LG1MQkq42yoQirnzJGlzPZkf6M23TWPZlBkHRVTjzsUHmpkL8st
         fVTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrGVgsWFzJcnTROkehM0GEIdtM1oy/2vXORDZVeGHL24g/V2kvOO+7ofATzHhOJRbAk6WyOIUCLs2lXQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLW32LvKD2Fu2DT4YHAnpCeTgwkgYOiLMJDoa0TqJeNK8LqKNUd
	tkgAX65XG1zY7TD3WPJH11vxkGL7h4XZ6/golvG86nMuIa0/vQKoCff+udtCbw2fqD4=
X-Gm-Gg: AYBFou2Wao9gP0crp9uj27b9f3aqkzuQEigGcTs7HnOFW65RQyCZBRq0XoXyL8/ULCW
	qE5we7rDQG4WhG1iJGSigxvQCf9iOsmL60VQQBjvKL/jQ/Lcmz1PZQuCiz+sHCRbq1laNKAkbjm
	MlIL6qHXlIgrXGnjtmr9vjm7UCy+rXPJV+MtZI21akeP9EMJKKjpFINeHO9X5MqMjwrSuZhBtdj
	sHOu+jnM/WEK4ZkibZRxbTbIwu43FG5fLN3jiTGv1lf6vhsEHqrlkAP0ZGNUhjzEMoyfCZARoq9
	RnoGUpnTNmxoAepH8xSNPRVnmyYZgsGodfZ2+u8q1WewEDvAqKFnnooWLvVjBdLmE+sO/faRGNI
	ikMAjsNuxO/5xq923hP/tLWCH4r19Zs/1LqRrsMdeYtefJ/9LSpbtPeMqJoW9UiyLUyrgw/rZW1
	Iqe/FaT3s+JPFAjNdaP5a7Smj1Egvhq5qmJMdrkjTbr9M800e1UsL5Fpg7iLLEymL6Mjtv2gzMD
	yQ=
X-Received: by 2002:a05:600c:8105:b0:4a1:775b:5eb2 with SMTP id 5b1f17b1804b1-4a18e48362emr139928885e9.13.1791760570708;
        Sun, 11 Oct 2026 16:16:10 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a18be964dfsm240506775e9.7.2026.10.11.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:16:08 -0700 (PDT)
Date: Mon, 12 Oct 2026 01:16:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: armandas.kvietkus@proton.me
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: aw8697 - Add Awinic AW8697 haptics driver
Message-ID: <aswYYk71JspzTQaO@monoceros>
References: <20260930-mainlining-v1-0-c303cbdb00c8@proton.me>
 <20260930-mainlining-v1-2-c303cbdb00c8@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ridkd3llbbsodmf"
Content-Disposition: inline
In-Reply-To: <20260930-mainlining-v1-2-c303cbdb00c8@proton.me>


--5ridkd3llbbsodmf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] Input: aw8697 - Add Awinic AW8697 haptics driver
MIME-Version: 1.0

Hello,

On Wed, Sep 30, 2026 at 06:08:04PM +0200, Armandas Kvietkus via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>

Please drop this include, <linux/i2c.h> already provides of_device_id
and i2c_device_id, so you only gain unnecessary dependencies here.

Best regards
Uwe

--5ridkd3llbbsodmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrMGLUACgkQj4D7WH0S
/k6kxQf+IukpznR2fVDe2FYjwtjDRNGy/yLsBjaEG3d4asAugaTEUfUdBPK0dCFW
zgab2jxZXtXpWm145NHWKc2TXTY5fdbyzDo1lLTObUvw0XqXoEWjEV2Z1uFhMx2z
b5SpQGJhkddN3tFDIayYA5uFwo9c7vYr2w2UjXnJL4YAaGR9UETvZgP3FeuBs0YI
kqqR/z0K4q9zTl8LqcRdV8bkRBzetw8xopnurhb8rkB5eNwc0kUsfHG5ogpHyXGT
CDtMfYaqC9NxfohfFB2/0T/ITMS2HmQ1koWTWmyY/iBpCfWjfbqFlBrAR18rD4V8
GpJ5ZqYJeVW8FJIpYCiOsjce2bry9w==
=8biG
-----END PGP SIGNATURE-----

--5ridkd3llbbsodmf--
