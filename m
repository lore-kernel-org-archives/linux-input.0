Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878097;
	b=K3TY+Ilaz5RlyjNHxtzJ3q86hcVnnT2IM1d0mmeEHe+C4zA4mWI/NPRqNdtL3/UwS/3t
	 Q7Sxc0VRkWw09oy9fMwBRmQbABuX2dLIA8HGxdsdzh1bK2cXvgJsPa0EPM+OYZdCuKOlK
	 cs+zZPg3Txr/NEk+7Kd9sQjc9U0Ukz0Q85Yn6qXumXR1CV8HIqbtx28bB5jYSQrQlE0rC
	 foIeqIJtnVAk7vFeWFshPyxKnoxB5sqeLsfImaXc8pZ4BqCkoQzEN0Rd4hihx+I54LtIt
	 iBocZomZhbleiy9RSFXuGtnOMk86HBXsvXdCPKRhTPptMPZz5gaM4oBB71vV0hgPx5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XIvvCs+k7eLYLtLSx2FRqYXI7MEHUp/Na9v+SW9QvaM=;
	b=pAb9jhJgmF2SqajHthqfl7ktXM5SaEVoa9YPSBVmsiGN7xUhXdpTI0ytuqZExgsZN/3w
	 ERaHj6WTP/WcYKLBPD+t6EQZ+/LdWNHMQoawkoALJc+K6a0fPnXRoJ5AUDB3MJkOsv3qJ
	 BV2i+Z/19UPwUonfqAKnZ0rOmjfvMjOAOorLa7D/odmnK4UtBO5xyhDhyeuCMFCDl/9Py
	 Rm82QjvGM2ZbwSyQzOZy1lZ3mM3eZFfCpZKrfwojZ9DcsNN+lbAk5Siw2jtEfMcUpkjyk
	 cVmixOBR9FkX1/s3Sg6sYTOzgBXI0TuQUJ6EXyyrzjmM0DqvgVq1KR4M49pdxyuOv8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xhGPxa/r";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EC606A32D
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 11:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254EC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhGPxa/r
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490a0e72588so739719f8f.3
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 03:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878095; x=1794482895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XIvvCs+k7eLYLtLSx2FRqYXI7MEHUp/Na9v+SW9QvaM=;
        b=xhGPxa/rgYkWlxNrvyrwQEkX6SzKw0FYWANtKQnChjWff3XwBBq3mGwV5BQErdoyek
         mPuRE+JIKIEQtG5UVyRs89ovm3SCV9fvObum9cS6jw3bmURv9nKALqe+uwI3/oHxs5gJ
         yWGOSI/cqyTNlsqGfHQqUW55btccS5uqIHBJHfRTYDBTzTTknIpTMyGTx7hvYxVQS5X9
         +Tt3oRfWlpgEfLP1vXhYzoukbzBiypRrLZbhUSH0eN4/hOLA3uXjMoq9fu1kj5oDfB/J
         qejJ8Oo5lNpID6G0YuAX+Y9Pk1Il63eLoEn7pgv/ZeEF1AlO4qLd1Xxv3DwmyWF8/qaz
         dWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878095; x=1794482895;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XIvvCs+k7eLYLtLSx2FRqYXI7MEHUp/Na9v+SW9QvaM=;
        b=PydO7+bFKRVS+sQVkC1Cnp81ZbSEIKAyiY/4pwX/3blS5AzyOzVdQzdFlOSnQon1ZX
         lyj/CI+N7qxS4vp/1ZLuKxXRkVo6dpSLPvAb7MiY6Z5TUcjrJI/KP7kanCAWOA/IJTTL
         HFl6gGCHEYMhxFzeoyMnIRNoYkP3mdwrC8Cow4UL8RJQ93A1ROiC8xTrcR1iCm2xoBD0
         LPEo7T3dVGMyPocIDXw4QgT2ClfXK6RJitYx8xjDXAj6+f7hCtJtUhEUeaseOakFOKLJ
         X0r1D1W0ab443BfhRKUMxEXtqmg9B3Z+ELFMpUzug4HN12So8a+HsJFovbqIPrSvQbwR
         jXCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJoEy6C/ppSag+lNkavYlg4BVIQybmSPvnMTXV7Zbiuspmp8oxCRoLHyIbzPAymcNJfquA7NfMbMefCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z98f/Fj8GabJAdIlP1js5H3RZ8l89bGsGRdQL86O0qvBLIT9yxD
	Ziay8n7ZHOw+E9BKGVE2/oRUDPZLV5pVYmha2jbwa0rETK6eF7VDF+MA
X-Gm-Gg: AYBFou2jfrq+O2Fy7Q2rNZ+DPXiGkwikZgkfuNssZaB0kmhg+tcGGMCT7YGyB9xadd6
	0y5TCOjXcEblv++ee297orCDryjrISXHJxUJRAyB8scMsl0A/hy1O8f60CXhRXhkCnFGyuqIrlq
	/GZL2tJ91s8htHF1Vd7VHadFVOM+JA8QGXWkXgslGB3EzRQkS0PGvjmEL0gc2rQRCEUJGNcsv/d
	IRdpGUpnqF7gSsrhhURm1uzNR58qtOi4Xb87BVDrSpDMHquIIvk0ddiyTO3LxR4ksDu94dIW0Xs
	pWVA6mHqASaL+Lw+YcuiqTzV7IsxKbJudDlkOFu9trG2lREFsObjkT99q2XsIqH7OEKz8wCr9QC
	MU+gIeeC+0K7AvtmCWZC8aTCD4jb2pzLrV/rSGrS6nBdFY+oHmgzJlba1RAAWnwy4ZHOrF1U9KN
	bI/KIAGC4TKYkQpIa+6HpBodWD3Mb7laWmD26Lq3pxEg05Vrv29xTNlQVkBwfZnxGsr5X6hzJa+
	bpfAc4YWeCRH32IrIB3EJFYXZWerqVfMFuCbiIZ6nFyWaONiceHzw5OjdAgdwWZIvgEfeN8YynP
	6lyP4VVRlzocxa1J4MiEvDRzrjZz5zAVoqMxyqZEBVNOQeBeGNHWVlpvHqc4v82/
X-Received: by 2002:a05:6000:4310:b0:492:149f:67ae with SMTP id ffacd0b85a97d-492149f6981mr789005f8f.32.1793878095471;
        Thu, 05 Nov 2026 03:28:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac2772sm9135636f8f.18.2026.11.05.03.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:28:15 -0800 (PST)
Date: Thu, 5 Nov 2026 11:28:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <20261105112813.13210334@pumpkin>
In-Reply-To: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 22:23:18 -0800
Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:

> In preparation for removing the deprecated strlcat() API[1], use
> strscpy() to initialize the mouse device name.
> 
> The destination is zero-initialized, and the constant string fits
> within the buffer. Since the return value is unused, this preserves
> the existing behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
>  drivers/input/mouse/vsxxxaa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
> index 042a17fe81db..b3a0d7ff5738 100644
> --- a/drivers/input/mouse/vsxxxaa.c
> +++ b/drivers/input/mouse/vsxxxaa.c
> @@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, struct serio_driver *drv)
>  
>  	mouse->dev = input_dev;
>  	mouse->serio = serio;
> -	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> -		 sizeof(mouse->name));
> +	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> +		sizeof(mouse->name));

You might as well use the 2 argument form.
Moreover, if you use strcpy() you'll get a compile-time error if the
string doesn't fit.
strscpy() will truncate and return an errors.

The other question is whether mouse->name even has to be char[].

Personally I think that while there are issues with strlcat()
(mostly to do with its return value), and that there are often
much better (and faster - so sprintf is out) ways of getting
the same result, the deprecation really needs to propose a
sensible alternative (not inlined strlen() + strscpy()).

This case is, of course one of the 'better ways' cases.

David

>  	snprintf(mouse->phys, sizeof(mouse->phys), "%s/input0", serio->phys);
>  
>  	input_dev->name = mouse->name;

