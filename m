Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D485427E0
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930377; cv=pass; b=e7MAbsbhjFKsGBWRIiF24ro4jlQxIBZufnyK0+2MhZDpC5CS6L5bmJZxJilp0ROdpFjLEeQp5Bsjq5RrtFefkqQVMq1mL6I1hsMCOyRSu59+o9QfDte3qzQZtkoDDF3bdx9CV/7vyfFdno0TVN2ogJt5NF62i3udYx7fzEt2yZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930377; c=relaxed/simple;
	bh=LHKyaN6WUugoUSp5MeLqyUxtlolwPgBXkaD5KlRFm9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCtWwfPgcnl/vGY24fIOhLPR9KoBULnqMNVleS6qdcbW4cTMAPgZXxEaPvLgSPPXeCC3hL2LPV8lpFVrF3L60VIUbwqCOIYphkxnzG3udc8AmQrrIJBZIvuxFBX1gzdnP+ur5E++wpN9BE+6jrxiTPrG1L/TGb0jdztQRuIm5iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C4/6EXUW; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4/6EXUW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ac525c1f05so4764247b3.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930374; cv=none;
        d=google.com; s=arc-20260327;
        b=C/AHzREqjfG4H7PB0bx8W9cdUmQoYouz2SuucJIVJBZDVfkBaYCjcfeMF4WorB/t8y
         hVMPk37JjNgxWp7Q4YJphSGRL3HvWQ7MCL89mgmSERi9sZLkkqm5fx9vCLBLA2EdvBYZ
         OiyIT9uVyol0b07M7Hz3a3J6J68eHxybT4Eoupnj+9C+1gqwWAzwpNHH3oP2v7tLxE2C
         KjxaC+15eeq8UHDhN6i9K7kcL60GO2Fd4C+oIVYixQYQgeIaEoET0IxZurCpi8cMU9Ea
         3+b2KI6j6DpthTl3fKEoeVzrq43FxuXbt0HBs6X1Gwug1wcKUciwampo2+qb8BjJG6n0
         0BOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        fh=yFr9IAOmZsDXP77FnC470x0yeKyIOgikipAthAViUv0=;
        b=nbT1xKEhtbJnmEnXvVY8cCSyh7nEcrBv8zxsmr1dDJteodWbWMOm1WZpCk+YWxkD3c
         HcbmxCJkkSRiJruizM++bG7tx2FodUe01JlMxSQ/QVbFwVYBtH1kO/FnN3jv+atkZ9wc
         M/QWlZDNUPX0fqDPa41SINuveBw0xiLnYktTOH8lCT9KZsjeL8xd+I0Fg0hFgH3S7kb/
         /VS2FDlNpIbiXZMkBXsGCtxfZHYLZIjnL4Vzc43lwd0hYDBDzwZaH525xjvJkkHLU5dI
         pO01rLhIB8owAxix2yT/xBN639R55ZJoWCeYQDi8YXFwxMTFtlFrcakMFnQcqDwx7a0T
         FmQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791930374; x=1792535174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        b=C4/6EXUWLqwBThAGo1onKkHW2BxZrd15xJmVGIULHYLY1nPFF5hv2mrrYcUkuA7RR8
         IhUjXjBsCxcolz6CV0dg8XhSVmMve/TAn8Iev1d7tXkENPi2R8sDAr89/T1YBI130YKh
         IcS6Ly+tY/cTuvFj2Cbai7MhyVANyndbphs84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930374; x=1792535174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        b=G4IQMKZn4mufnakrCtW46RWOQGlKFe1/gy9hxo9Q3Xn5yyDToSDMc3IVa0HaGopsSt
         dlIkeEnwKkm2NQVHtRlZiY49YW3Ow23nRUXNn0qgJX4BMlXZhNYjr4GOP4guYz8T0M/3
         VRzx/fA9NI+Wz9+5ym5d1N6MJgcYKLRZZWDeAROWtmUhIu/uQbUchLBtN6yAowd9lD1/
         TPeXVQJfcf9xBeHWtbb8OJaCJLv6rsfS9gyFTOKY1p4gC9tQ2fOamKGqUdk7n3NzvDO7
         L3myqjZSnXjk7uXhTsUX/YfbaYN/rgSPrK265Uxn02biASsjPQZThpUm0YPwNOAFFsfG
         fmtQ==
X-Forwarded-Encrypted: i=1; AKwUvByrbt01b4p1A5B4FgWQw3E3KyMM6xGSI5avPNGxTH62UdQaXMqb7+F1pfFJEn4MpsOj8zgYGzwuBSWY9A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLzmZjtXQv54t3V9zQRQWToQxE2Uta9a1XFH37Pg4e6zY7B0jno
	gvzt+ofo2FNvQk/inqm1I2t1/IEHilUFc4amPdiGHyA4oQCWPh8F1tGAxM2ubOlMdne7uTw9QCM
	FVoW5y3wBcsdIoOPLZnK328AgjkinHGN9LA30b9sS
X-Gm-Gg: AYBFou28eqkvqRVlylZuqYVaMUhyyAZ8etogOdgMjqCkewBwMvtW/RHFn7uuII6aznf
	tmcOz2yqlwCOZZ+J3Ee/jaCdMiOgpYUHTzaRxUqBxc9KMExfWvR5bhLVHKnGkY2TUA8dKThvkCE
	FVv1I+TBwDxxFchcykECegeZnRKcX5xh7497iYR5ey1aMdH0ZpAPK0lp1jOmuZxY6LFv8a/vqKI
	sBDNXFG1Upr2rS0L1bdSKiNeMg9O3/HZO52LNjlWViiuXUpMclq0R/1owaQw14V5lIAZC87Ikcp
	oCuWratPVY1GpVERli/rUz2DsGqIabY5IsFBRv9MiwwZBWClSAKBefn2Ri5Phaa2ig6j062NMgX
	pJE86RRyY/w==
X-Received: by 2002:a05:690c:39a:b0:8ae:8877:9ef6 with SMTP id
 00721157ae682-8b07edcf6f8mr55863427b3.10.1791930374515; Tue, 13 Oct 2026
 15:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-8-384af01da3ee@chromium.org> <aszWnnc6RR9d5SYw@monoceros>
In-Reply-To: <aszWnnc6RR9d5SYw@monoceros>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:26:03 -0700
X-Gm-Features: AclHuK_tyUehVA205WXB_Og5y1P8AMIMPFMlhjQ2Y9FOhmh_U9e-FbL8LEin36M
Message-ID: <CAEe3GZHB_mDcdz3gcoAzOu6mO7ua3muESOJcaZi6Z45Q8J77rQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] HID: spi-hid: add device tree support for HID
 over SPI
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 5:49=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Fri, Oct 09, 2026 at 10:25:33PM +0000, Jingyuan Liang wrote:
> > +#include <linux/mod_devicetable.h>
> > [...]
> > +#include <linux/spi/spi.h>
>
> Drop <linux/mod_devicetable.h>, the spi header already provides the
> needed *_device_id with less dependencies.

Thank you. I will drop it in v6.

>
> > +static const struct of_device_id spi_hid_of_match[] =3D {
> > +     { .compatible =3D "hid-over-spi", .data =3D &timing_data },
> > +     {}
>
> { } please

Will fix it in v6.

>
> > +};
> > +MODULE_DEVICE_TABLE(of, spi_hid_of_match);
> > +
> > +static const struct spi_device_id spi_hid_of_id_table[] =3D {
> > +     { "hid", 0 },
> > +     { "hid-over-spi", 0 },
> > +     { }
> > +};
>
> Please use named initializers and drop the unused zeros.

Thank you. Will fix it in v6.

>
> > +MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
> > +
> > +static struct spi_driver spi_hid_of_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "spi_hid_of",
> > +             .owner  =3D THIS_MODULE,
> > +             .of_match_table =3D spi_hid_of_match,
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +             .dev_groups =3D spi_hid_groups,
> > +     },
> > +     .probe          =3D spi_hid_of_probe,
> > +     .remove         =3D spi_hid_core_remove,
> > +     .id_table       =3D spi_hid_of_id_table,
>
> Very inconsistent alignment of =3D, if you ask me, just use a single spac=
e
> before a =3D.

Will do in v6, thanks.

>
> > +};
>
> Best regards
> Uwe
