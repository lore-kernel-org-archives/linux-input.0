Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774043;
	b=kg3xRan/MZkCVwduMkv5yPDfqmeNMXf6cnrSGKSuPpdojGaJiuX424pUatVLrclmS85h
	 AfZYsph2OwQcuZZxXg/UkU+Qnx7AxCtoVy+fP38QlFbryka16VJcU6aqdjmgi/oM74skz
	 Vhg7LLakiKpydMW2ogn/Z4l1pHbwf+pzQmXMD/L0PMfYIaScBCM9fMq6pXyvSAd27gbQZ
	 UY4CjQHi/ow2e+m1zAyueKK3FZGc5X94/Fnq2EGc3/ZxT9KN0kBpj7BCZwmX1B5A+Dm36
	 D01/sXHFsiWXpvpkIh9RV7mUTT/AZtCMuQ20RZ/YqxqeSuuYMkyi7ho7mn2jYbAs1yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
	b=Z915OGWecsb+1xD5UGCVlVt2JRskRTIySHGIpr7yzREejQxsROpCKJ14PAoS5Yf/kxnJ
	 qrpe9tUgBt3hOvmCQr06AZjEGfs7IuJ6CdHRKDojFMngsC36cV1IU3qt6ON6rAjMbmsMA
	 bq2SjwDG5R8/CL7mxqcqJpGhiCKnLemRhDgiNYn5u9sQim8X7pn4rM1KIFnQNjDFTqwt2
	 tj/2BzPaS15KzG6NVwHqmrnqVPTKfowF6k2f+vfU1qRtO5rornb6J+0+Yoq1a88nUIJUw
	 XszIpdTdsfhHUhxvKU09SlcRlED8urASc91b18J61yXDdin0zis7h7PBMV4N4Twl4WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viISSJNK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73101606A31E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 10:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73101606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viISSJNK
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ace304021eso75472711fa.2
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 02:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774042; cv=none;
        d=google.com; s=arc-20260327;
        b=LnolVVXj3lK/F9EKk0A8WOu7f+U93CZxAeQMS+660LHtEEamaqENIZWlmOzjOR63IZ
         E5UNdKS3r/TZgZqQ8aA6YvUCIQIr+NHuEtKocYPrRyn4qNwn/MKCtr3JPiQgaRPD+45P
         dodozYcHD3BvZOVuyu+D65LaClzm183RXn0knwjkEFUTuyNfUXSWtUmfX0aOU8Zeek+S
         Jd7OD2fH3Q3Godn1ny/Hb3x5xta2V+cQFodFEqJ6lusK6Iwso6Mol/C1AW1vZH7yYscw
         BTkRQi6E4rLQWf7rFutRrJr5B4QcBHMSNb02YfjOz5kgkD6F4etsA7tpz5EbP6DDWQYH
         JsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
        fh=qGWXAx5QTjAtHe/XafP98Ef/6IXKvznamd8wLKl3pHU=;
        b=KVAHT8YOZ5pSly5xUHv9Gm0L9gnWE/x8Yuhi6kTMVPcZu3x9fT8EdjB+9IRDWCJ0Rb
         e1hakevEJACTa7UtwQHJ6fEu0GQLe+fOIL+3gTBEBgS5DVKTlSEAStN08Q4E8Gz8ir5o
         E19y4W8PnCpYUe8y37Z1HWJpUPOWIbad8POLycoGEY1spaVUapTVeH+CZEnAbTrx3YJ8
         rhF6ze11jpUtk86RfszDfa1EZ9YDkgg9EDJbNWJol8+btt5o3chMUP+4nZFGlmPvAPpO
         omz+oVTk8aps7fW5Plq9WfL4Z4TJkOtOz20oliWpm9abBEPMilKMKXnbFBJX3mAa2eR8
         5qVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774042; x=1796378842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
        b=viISSJNKKrCfVwgnqpcx21D5A8sjYsUe1xgoHbLgF/1WiqVhFBhinvCjHO3hb5SdGi
         DDjy+sCxNpLd0qJPAvrpD9ieDpS+Zx+l+bbrKVtgq7b5uQR+8+qlgOW5rUzfc7VgHQAf
         yLq5uRXkAQSsAlnVGHeJKNh709/p4DwEsY5RriTwk9+pp3Wi7aKM+kjKmllDH9Bi3++6
         gvOMnjwO+ztJzqSX/DeIQYicCdCzEJkSamEPekUsvUnBKo4eis3Ft4hIi7kmnpAf4A75
         TsKnET2Kw/eOBh2scDOAHP0Bxy5IE6g6sCGxzVXj7guCtWF4Zq3liE4xCqczhwqiR4bT
         dJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774042; x=1796378842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
        b=bg4jNNVlXH6imn3KKcetGBgzgNmB9depaIM+Ita9IgGgQMWPbFRADh9UppWmLQWIA4
         UXMX6QX8e9FoJ6tUVxnbtCSbHWQXAK+7aGjT/T78/MN2LVAHHbiXp11re1/XvDZfol2W
         FYca0SsYe8iC0fDW1cHXeEUmk/9pBnGqU75zb1Rp2vA1MylHzhz4mMCLnFTr4RjCBVkO
         +uMnswFS4eGAt15zkusrjKGlgTiilNvS9voFGJ0rNyZkm+WJn1xmp8j5haT6VAx8zRcN
         Iv+rQH96iuW3bGuTharnR8v0pQYKYhn6u32k3W0Zxy7djkye/guz+yW0lkz5da2RmUMS
         FcSA==
X-Forwarded-Encrypted: i=1; AL+hErECCEeaRlar0LmHZ8XRwWnyTGf5vJ0XLDroeyjfHKjVNcbGSZ3gk8TauhppPHPRRtmAHJWIl3esjw0Lfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z94U1ETmbgJc2qxRnfL9IaVYoMdNmMFcPYsaC5rbGEZixubfzEW
	cptSwi4EGbvx1B6PSSOwc03JJGG93L+4Siko1SDrh1J67hfY430bKh6pn4Bsp5gU2da3vCb+5WS
	UKbdxAQAGz0i+Cy4SF0MnN5/2gwSyV4s=
X-Gm-Gg: AZFdTZcWp+ao7kIcWtBokkIF9B2EMY+antVJMmlsk85Sd7d5nJXt9ZGcx/W0gEXyOSH
	57/+PAy42p1iLpHk6s/LfIthtn4/V9r3tkxlOJIbXP7G/aL7feXrZJI346UTigIiF4lZjQbOSVI
	x3HEDstGBnc3JlPN4Y6YuOofq9LOWrfQCMhQ+aLCxfObrUcHY/Vdo6g/R2PeNS0nmeXAtoMsJDK
	rBu3JhBD1hS6zuJQ5JALSoYWYOi+h1DNu4zwj/0MVqQ4cojJPULQo4edkuRH62eUnh1Y6njVbaI
	vlZowDWylG17QCZhnxtWBnnitLG/T743J4+CbUOlKfnwwd9b0FxRpCW3bXcAtY5ei8p/ANdlsMU
	vUYce1q7nhfKqXfSlfCy7y7AKslU7/Y4Bd69vQWce90Q2t+q6SWepOW6SwwsBtnt6mYt3EeEZSe
	jIxTqVl/z/VpvpcvHXllU7859/+ow2PcI=
X-Received: by 2002:a05:651c:a344:b0:3ac:436e:4084 with SMTP id
 38308e7fff4ca-3ae7f9b2126mr75337521fa.4.1795774041405; Fri, 27 Nov 2026
 02:07:21 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-10-b0309d0789b2@gmail.com> <awQEjpz2572Y9wsB@monoceros>
In-Reply-To: <awQEjpz2572Y9wsB@monoceros>
From: =?UTF-8?B?57Gz55Sw5oKg56KB?= <yogo.0917.sabu@gmail.com>
Date: Fri, 27 Nov 2026 19:07:09 +0900
X-Gm-Features: Aa3M54qQEDKdWrHJxIfU9kb7QVNH017aRUBBckb6jwRibhb7ERXk9zIWhsR6uho
Message-ID: <CAJGK9zbBc94aMeXLuUZXrPOT+TbcD6HAejS1PgaCU-wO=ysY0Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/13] mmc: sdhci-at550: add SiRF AT550
 programmed-I/O host driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-doc@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:17:35AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Sat, Nov 21, 2026 at 09:43:20PM +0900, Yuugo Yoneda via B4 Relay wrote=
:
> > diff --git a/drivers/mmc/host/sdhci-at550.c b/drivers/mmc/host/sdhci-at=
550.c
> > new file mode 100644
> > index 000000000..11c9de0c9
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-at550.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivale=
nce. */
> > +#include <linux/mmc/host.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
>
> <linux/platform_device.h> already provides of_device_id without the
> implied dependencies you get by including <linux/mod_devicetable.h>. So
> please drop the latter.

Hi Uwe,

Thanks, I'll drop <linux/mod_devicetable.h> here as well in v3.

Best regards,
Yuugo
