Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425459;
	b=P00Uhc/ltjkdQWyIp7rWSNOyAAfgvcI28ryEstZT822ZuPF0kmVHAUgOLQfb3Q/17OBQ
	 ZAKN0QQEsm0nWYID2Cuh3qHQ6oGOQI6UF1rnG4HqLqAKcWdKtbGfU68bu2lN83OqvAfnu
	 JQBoZnRTdpJUc4aDFfwCzlXlC9AEn4ZSVTfh7UGuvHJ1nuj+J2lxozgDzeTvmXkD0SNba
	 o/SL56L9urF0nu6Uy+CsXh2RDf+WATcephPX3q4sH5YYST3t1JEpEHg7Z/i4bYLiVTTc8
	 iWTfKcVsScYssFQDy2o478RvMLCY+Hwse1Jhrp5Qc+XRqsboIAxyYmUHfmvcbHUNI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XivqS2GzXFfLVs4e8GPr3drYgoFDRP+i4GE/VUr/Vsw=;
	b=AuTO3qiCdgT2yRCthHQa3+liA7TwBQ0y4q1ekLP0SfIBGuTZo+c89S+j4hkgM9YeDK+i
	 8bCr0xJ8LXjCAuy4bGrXHkUdLvz9AVcTMkdqHSRDCyB0X6ZJmO/yM1yU7JYh0vj0vkj8W
	 naVSS3+0cxGmOEVgZ7Q2I52OL864p/Jry86mNab6RwPElfm0IMGrorTXjyekQ+LdS0ZVo
	 PJ4PoH0BBlFOiMpjzNulUWrFLRvNGBtkSMNREf3cuMD7xRJdL0WI88EOqO7oydbHidvTy
	 xrWCPvEcOvgcRqx77emUIfS2iYlhp56R+YCBIB1WWwGTX9AOcuo3eMOMwf/kIHfl0PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MjgPBNgH;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1560A381E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 09:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB1560A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MjgPBNgH
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so22768645e9.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795425458; x=1796030258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XivqS2GzXFfLVs4e8GPr3drYgoFDRP+i4GE/VUr/Vsw=;
        b=MjgPBNgH02xQwwlmVT88dEKqXLmkOtxBaiUolaQXrr+yWHJYso0rq5H3V5cMGxLZ4j
         4A2RItLr1Sek84a15jzHonWwk1i+lX6hrm7p24UH3BIVH8u/GLz3xMWZesQ53FDWA+dG
         x2x2jR4ERMEhavazR0qcOByOsQ2qCtCO2KRjD5X4T6FvMjY7zuG6fmRzqAPu/AUqV92V
         3zRAjur90G2sULFJ+iQ/xXtaDgx1eTPqGezZVhpjaWkCUtP1ZjTSJ27EpBZSLQkbdNSp
         w+okTMvneu+NyL6uX2WegqtYxcRuAgKYFanr9LmWTOiEkdkqf5Pi0yPw0QbSbOF/v2lF
         Cgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425458; x=1796030258;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XivqS2GzXFfLVs4e8GPr3drYgoFDRP+i4GE/VUr/Vsw=;
        b=ZfksjiHbXxzlFsAqC+42J9/kO2EBICBNbC/8ulfHVm64BN5yqJYdA+YlYFbXQXiHnz
         1fpaStLHCY2/8Uq/hT+mxRHfWhEqEe5kFgUQwNsS2/ihidcI7aoDwj0eYPmReiCZdnU2
         VJdcsqFLAPW4n508nT1RbJIQk1UtlMn/nOEtfCEx1z1SYIV/P457sm/JRtrwuqg6d9kD
         VnORxRyLD7x8tpk6nZYOGwRD1ENMF+08D+jnRO1oN+Lv/JPzp1fyaRMKQ3v+VnoUWRCB
         ykwzwp9tShw477BQi71+O36iBVsAszfU34/K52zjyo525LpuLvcDZwE7RBoD56Xx1QNB
         0XnQ==
X-Forwarded-Encrypted: i=1; AL+hErEaESKdzWxPzB5wEqLag05HziWAToiSwDAmcC1YQtSME4SsSswnJ/n0dJ9eVw0T8P3f87LRCX4HqdOKSA==@vger.kernel.org
X-Gm-Message-State: APuU4Z875clqB5yHQWhCp9NqdGL161L6QbLnqklHO3rNzm4jLP6vbArm
	7YKttB/udg0bAmDQKbCDNnisOeMeMerQIxU56Q31IvT07s4XuMIR83iPbvAKHWZ/80Q=
X-Gm-Gg: AZFdTZcStIsQh2OpchdE7jbv9xX0jypT4e1TkLX9IIXNf54qPjh5e5PoCdAOjF/woOm
	mtxaLHKj/QvXZbcitzWLmkwNSRjwdHKnF7oz4sjah+jMpkZ0EbM83SW21VCIjPcxQU08u1AHwVo
	9c32VQD8+UUCMZoG1fPlrUH4P73xa9tzqJloV/UP+Dy0+QqY6L/6zGHjTtwmQi2fAW5dbV4w8fK
	8g9ysHHeL1xforlWBeBvEmGSHNiAXAalojDO5W5O/wtS6j5ZO9OYiFfDwKtLIWXT3wvQ3739VGK
	o7DS2fLyrCyC42KSRsNHPTW7S/qiDE/eDhl5JpA7jWgsDB71sVwjnGJTQAaw6IfcIrwvYHFPz/5
	8VdiQSvPjbDd4/g0BG9xMwV4yn7AuFFgvC8mSeenPkJ7E5gdM4f+8SmLy+b3tDHGmGjqr7BbGBP
	GVbl9UEj09iNVWjeuZUVDJXlfaa3992y5RJLmBfCZ5Qvcj/H29cF87h/j/M9Lb1A/QQr6XphOgf
	/rHhj48UXSmuC2PGYMWz72WzciUeGnWNh4Wllpk/jqqHWBvH9To2tkkeRlZ+zQrH2qH7JDixhTj
	mLkE+6QsAGQ3LAcLZG8sVXIb1T/OO4SBwMbkIPeEY6W5nvnOUtDKpknGbJLJZJKZ/3v3T8janYc
	2H/HBh1In+W9wJ+EAraDR+RGIXA1wW07mBD/o3w==
X-Received: by 2002:a05:600c:468b:b0:4ab:cc03:7f60 with SMTP id 5b1f17b1804b1-4bb8881b511mr224342725e9.18.1795425457707;
        Mon, 23 Nov 2026 01:17:37 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb906e4ce6sm162891895e9.4.2026.11.23.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:17:36 -0800 (PST)
Date: Mon, 23 Nov 2026 10:17:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: yogo.0917.sabu@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, 
	soc@lists.linux.dev
Subject: Re: [PATCH RFC v2 10/13] mmc: sdhci-at550: add SiRF AT550
 programmed-I/O host driver
Message-ID: <awQEjpz2572Y9wsB@monoceros>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-10-b0309d0789b2@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53xo6eipu5xw5r7j"
Content-Disposition: inline
In-Reply-To: <20261121-at550-rfc-v1-v2-10-b0309d0789b2@gmail.com>


--53xo6eipu5xw5r7j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC v2 10/13] mmc: sdhci-at550: add SiRF AT550
 programmed-I/O host driver
MIME-Version: 1.0

Hello,

On Sat, Nov 21, 2026 at 09:43:20PM +0900, Yuugo Yoneda via B4 Relay wrote:
> diff --git a/drivers/mmc/host/sdhci-at550.c b/drivers/mmc/host/sdhci-at550.c
> new file mode 100644
> index 000000000..11c9de0c9
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-at550.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivalence. */
> +#include <linux/mmc/host.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

<linux/platform_device.h> already provides of_device_id without the
implied dependencies you get by including <linux/mod_devicetable.h>. So
please drop the latter.

Best regards
Uwe

--53xo6eipu5xw5r7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEBK0ACgkQj4D7WH0S
/k7hOgf/csj9IbehNzv7kJ/jSWUzgb6r4/RUEEbwtHDzllOp2mTN98xOQkRXzRr+
kmuM5eb3Prkbs0qQBPQiihfmm0Jo8lnvB2N8uBswWQM42XQ1o5YmtZx2RIs5cp4a
M0FFz9Bz2fH6rmOr5ETS3FRjnZ8CNqQnaFBWD9lGusUfgppfoyqvFwbXBZyQd45Z
KCR1pIqN6sWoDMkalLwcL8/M72VapgfDtPpmNp4qxYjf3m8WbJJZGT7uK2Mk78DG
WWybLbbeuHCv72ICgMdJArlShc5E7A8r/LZSSpXjnNPBCxOU5AeW1Fa/7Ma+TYWI
G0UtaE9KZSsmGdqMVovJUC5O5/MnDA==
=R4EF
-----END PGP SIGNATURE-----

--53xo6eipu5xw5r7j--
