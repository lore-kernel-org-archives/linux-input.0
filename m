Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C23AFD0A
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899539; cv=none; b=W8n/5r+Dba/0ZSZ9L6x4kzLAF1m38rM8fr0ZM6F+DxpaHxDiY3h6r990+P42SR4GMddSb7xxUc4BOS4HimD6sny5UnG5GlQxWdRY/EQE77XXiriZ1Lmt1EEh12y342LxkOoHtOUJFi3daz0GfjaY0eK2DVMcHvyhb0e309ozXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899539; c=relaxed/simple;
	bh=3sZFjt+rrDifX3K1QODKkmups1sDQ+WBwnscq7Lkb5k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FraLNk2sB7fD9856HxLcEsl3pD/L8bPhZ54uliqmyRkpOYi9yq6k2jNfhHRl06mnjtbhJenskrxKFVlmOVVzxvzWo097COhIRiwaZMJE71sqcVSTeqZe7QJkS8O/a2lB+RxX2ctWurtFePexZUvejpkPmzcQnI4CUNFgbgkJ7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brsicph2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brsicph2"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4859b1fc7a8so2133810b6e.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779899536; x=1780504336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G302CK4lzpED2r6jlr/FzxUY2SQTq9rRW+M8kXn3MPs=;
        b=brsicph2QzJYv68ksuhxiWUgcTvFFmGvuz/+CweFwIlPqiLqhsKDCowWa7adKm0JQJ
         iIqMmfrnwN9PiW6N/eALbE94qAFXWgqyhRW0tRtTTKctx8EClXVIKcC83q5KmBnOSNPI
         EKOISRrbrkf4YlS2rMKU5WxIEKzfE+uUB4ZxTq/WHn1jQnCaYcEWDSNemyzZdtTlXCxR
         u96yH5INqFFU8JuGAiyO1lWq49jAyRHtBctnlcJl93DT0lf4uSwCjvRSa0IVrzc5ADTO
         FDJeDNb8iK8qilV0/c9qKcP3VGG8u7bzcBwEyR4GJ9pziZEPeWcZL5p8dtDAwfgWhxKY
         afsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899536; x=1780504336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G302CK4lzpED2r6jlr/FzxUY2SQTq9rRW+M8kXn3MPs=;
        b=oq/rAP+ujum8Ml64HrmhDTxk2+NWJWwrUFdh1a1FMzQ7XKD4Sur951tZer2rDp4WoQ
         +xLTCsIazWuW9UlUfvwmYx7RrkULYWQ+zazeCnTB0kdK9KOnKKeF4LuIW7a0W1CzjZVx
         hBpent72G5pNWfr15UBFdsTWDcKdSJe+S1EfNgxWz5RE77XuOZxrPMl+M8BxcwnPf5fq
         /UaWSrfL98s8KPRsUtIfYBlJw/YWfYPogN2FfVVwao97ma5I9m+eSCY8EgyJ8qUGbQyI
         AakpBmBd82tspJxgYoKYOHpqcLYEGDJDt5SXllPx7zvpu23NsUe7ulojprejSkXCXJkP
         /B8g==
X-Forwarded-Encrypted: i=1; AFNElJ881XV+nmKR8kr+mv/JZdbRArPj4xKHRmyrWJF4eVdeXdlO6oBrbmGq2Ll3KgsXbfhOI8Qfq7y7nmatmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1JLKpC4+F/eSG6Ku7xQxSrkKwQF4I37EU8PbtEcW0IJsM5iM
	Yh/1JXAi+k6Ph2ZxQOb7bpV9XFFj5YZHhsMoXdkOUQbMAQr+2W3n3FUP
X-Gm-Gg: Acq92OE8fl/fRjX3Hir7ofqME1WMYciUqWxAsUT1Az6A3JNcBu6rlOKrGZrQpCFYCvp
	QSHGw62OkEtKU45/fZevMIKuQx/Oj2dsXDnobRsgrvhfc9QErUMNkxs5ZNvlQ2PgO5ESMYwckFJ
	QszeGdmC/Tx+O1LkRqtKaH06mOoE4Tsp5MDFF7MpY4qfRARHF/cGB3Hjug+BYFSRsC2T0+YHGBD
	d/DdBg2BFDmFi0g3828YnClQkRRftF5vFnlsBumgEJOgl4b14nUQIxD3FRpZmypC4wyj1RF7JMp
	5XfXltAEa7m23KdDJWWNKKp+gywLSDt094OAE18lClMxkK60m5wk5b1zgZSKNZ25nJv04+9hjOs
	VqWNNMuxVFx9qgew8yLs99nHdBKp2iTRT3v+svBDe6jIHir4KLtra/8i7mmtZQem0Dm11v3tt/b
	0Y8PYImfVK4Kue/j5WOkPgPbG3Da3eUWZVzSw=
X-Received: by 2002:a05:6808:4284:b0:485:7c44:a27 with SMTP id 5614622812f47-4857c4445camr6837696b6e.6.1779899536220;
        Wed, 27 May 2026 09:32:16 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd43dsm172290126d6.3.2026.05.27.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:32:15 -0700 (PDT)
Message-ID: <67b32b3c5d85af65bb9205d00b24d18dcab5b644.camel@gmail.com>
Subject: Re: [PATCH 1/2] Input: userio - Update maintainer name
From: thatslyude@gmail.com
To: Vicki Pfau <vi@endrift.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, 	linux-input@vger.kernel.org
Date: Wed, 27 May 2026 12:32:15 -0400
In-Reply-To: <20260522015040.3953472-1-vi@endrift.com>
References: <20260522015040.3953472-1-vi@endrift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you =E2=99=A5

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2026-05-21 at 18:50 -0700, Vicki Pfau wrote:
> She's been committing under the name Lyude Paul for a while
>=20
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
> =C2=A0Documentation/input/userio.rst | 2 +-
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/input/serio/userio.c=C2=A0=C2=A0 | 4 ++--
> =C2=A0include/uapi/linux/userio.h=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A04 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/input/userio.rst
> b/Documentation/input/userio.rst
> index f780c77931fe..415962152815 100644
> --- a/Documentation/input/userio.rst
> +++ b/Documentation/input/userio.rst
> @@ -5,7 +5,7 @@ The userio Protocol
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0
> =C2=A0
> -:Copyright: |copy| 2015 Stephen Chandler Paul <thatslyude@gmail.com>
> +:Copyright: |copy| 2015 Lyude Paul <thatslyude@gmail.com>
> =C2=A0
> =C2=A0Sponsored by Red Hat
> =C2=A0
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7cf5b55c5973..ceacb1c1d679 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28105,7 +28105,7 @@ F:	sound/drivers/pcmtest.c
> =C2=A0F:	tools/testing/selftests/alsa/test-pcmtest-driver.c
> =C2=A0
> =C2=A0VIRTUAL SERIO DEVICE DRIVER
> -M:	Stephen Chandler Paul <thatslyude@gmail.com>
> +M:	Lyude Paul <thatslyude@gmail.com>
> =C2=A0S:	Maintained
> =C2=A0F:	drivers/input/serio/userio.c
> =C2=A0F:	include/uapi/linux/userio.h
> diff --git a/drivers/input/serio/userio.c
> b/drivers/input/serio/userio.c
> index 91cb7a177b2d..abca8cb6aca5 100644
> --- a/drivers/input/serio/userio.c
> +++ b/drivers/input/serio/userio.c
> @@ -1,7 +1,7 @@
> =C2=A0/*
> =C2=A0 * userio kernel serio device emulation module
> =C2=A0 * Copyright (C) 2015 Red Hat
> - * Copyright (C) 2015 Stephen Chandler Paul <thatslyude@gmail.com>
> + * Copyright (C) 2015 Lyude Paul <thatslyude@gmail.com>
> =C2=A0 *
> =C2=A0 * This program is free software; you can redistribute it and/or
> modify it
> =C2=A0 * under the terms of the GNU Lesser General Public License as
> published by
> @@ -278,6 +278,6 @@ module_driver(userio_misc, misc_register,
> misc_deregister);
> =C2=A0MODULE_ALIAS_MISCDEV(USERIO_MINOR);
> =C2=A0MODULE_ALIAS("devname:" USERIO_NAME);
> =C2=A0
> -MODULE_AUTHOR("Stephen Chandler Paul <thatslyude@gmail.com>");
> +MODULE_AUTHOR("Lyude Paul <thatslyude@gmail.com>");
> =C2=A0MODULE_DESCRIPTION("Virtual Serio Device Support");
> =C2=A0MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/userio.h
> b/include/uapi/linux/userio.h
> index 74c9951d2cd0..98fe7e9089c4 100644
> --- a/include/uapi/linux/userio.h
> +++ b/include/uapi/linux/userio.h
> @@ -2,7 +2,7 @@
> =C2=A0/*
> =C2=A0 * userio: virtual serio device support
> =C2=A0 * Copyright (C) 2015 Red Hat
> - * Copyright (C) 2015 Lyude (Stephen Chandler Paul)
> <cpaul@redhat.com>
> + * Copyright (C) 2015 Lyude Paul <thatslyude@gmail.com>
> =C2=A0 *
> =C2=A0 * This program is free software; you can redistribute it and/or
> modify it
> =C2=A0 * under the terms of the GNU Lesser General Public License as
> published by the
