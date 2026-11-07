Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093582;
	b=2O8V5LR1NzrOGK3s9XxaRGvfGlDGlBt0J6kEt/RTPRgqIjGZQ2dMOe4cRwH74BZ9C/PX
	 HTFjIpv/MH6+0kCyQpQf6mechuHxHUG1us2GEyWnTO7mY3nS9GtvgAgAF6sw8vYUVSmx4
	 YncA4K6EZNWYyOSP+cEpw9OCfp4YfAXAmvb65IjpdJrvjIlvEPxtRm03B7OIY5eF/66bN
	 44RiE333HcPHlCwmJNQn38ULorYcgSM9cA8r7zFs93UIICbyAkuLq5oy9myg81y8/yJsG
	 +pRkA3St1yWH8KdecjrM6D/Mlm0TZ9K6IGTIHbZf7C8fBe1L+KsZR272r4Wd9Qa9EYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=PF69+SS9PhWTeKC4YFDrHLixVGiRvKbZmk5tU1R2LTg=;
	b=den1393tRB9BybN7sneUh/u2DhTl3UimC32Qsm6Kh6jHSSNWZhvM/W+Xzm+HbZDfby0X
	 IJ6qiTT7NXQ55g345e4G7rw8N6M10JDF9GJ1LPjboH3MK2vsww9lrkQv6fDUJKLAOck5O
	 Y9WJ375peP28WDBTBalW0H4vHpPu0i1Ip1m2xzs7KVZu0FMO9pe2tZHo904/zyQ2vH5dY
	 7bsun4Rsh+WzOcjxIw2OCGUjT5AhcsKMYo4E7Zb0O7A4lvrYjx5KuYHEjRk2OU3OANuZ8
	 2fPErQW3edKkzXDe3dz4IoHzbnKm5PR/Bl1FYSdJaK4r9dzpzhI+GKoArWBQ4Ay9MQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Grf1uZT1;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A55606A32E
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 23:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A55606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Grf1uZT1
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so104456c88.0
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794093582; x=1794698382; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PF69+SS9PhWTeKC4YFDrHLixVGiRvKbZmk5tU1R2LTg=;
        b=Grf1uZT1ki6mWyW6f7JfaUBUTdfJJZNUf8KE/6UoQdKUEinzHOM96u/IGcERcgjFY0
         rLSUqmsJMkefK4LraaJljvg3j70lHLDRHxLLVNz5lIT49VfWCVCqlHxOdvmS0NqjQFga
         XLj3HKGtvxFPvA6YA+dS5ZcjUx+KoqG6RnbJDOR5Nrof2Bz6y0Wjt2vk+Y5cSwkLHsNX
         uF1m7QsrQPj8o79znxlTlw05OSLIT4co/1/FL6H1zpIELPqFWoBJLuwlkmO1AIN5GNMA
         Ms6Ieji8QrTv9JzHveGngRty2/n5b6LlsyBknRy/BrHM6J+x0mO2Mepoga96eXOUs6uS
         vWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794093582; x=1794698382;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PF69+SS9PhWTeKC4YFDrHLixVGiRvKbZmk5tU1R2LTg=;
        b=xbMIAqtbQfKMTrVensgIDGJIUUvKOG/IuUnKg9cEaYWGuWqbXFiXZXhZ6eEXcpn2dg
         3JHZBntCCAf4n40uvcQewD3hFedXFZD+tEi06WshimLPTRZCTmUbXaKHSawf/b7uCxuU
         b//U/2tkyl2cQrhNEa63uXYTgnoh+8Shm+toRJOvg75798URXfFTZ4lg8rKf7rcghEaZ
         3fbk5hxbChahdoYRcVp+oAR7YVUMZ36dPCLp/yzofQEQxqr6us2QbSE0bd3oAUrJkdlz
         zsM4g4DZub4feIuNw58n49OcmSz+2EGkGbky6/MVb/e/+B/oYOG1/ChhwIacTMxSFeLL
         +bsw==
X-Gm-Message-State: APuU4Z9jT2BNUSyHn6WFyPMEtXY1S7ED4kG56RjSdS0a0vPnIGxjaYPV
	W7xswGOqKu2G3cXvbNVgV+QY4qJI6tYoVcz+jzKZYCDy2kP2kSFFUfks
X-Gm-Gg: AYBFou2qvGJCKqKmXLsHjsRXoPht9tyTjB2i/6/pszb16ArMCYEhYnTSXCTBEkpAO5n
	2dFJ0IPEahWH998818GjJZZVgXjYB6un5Z67qfsJ/pynOKHWT8ldWo6BSVT4XJvHzIYsIg0Piff
	TK2T6Et5ccWOHoye7DF1LtMsLKc0J+ubAqLFXnc7OaUPOjZ4SqQlh6Cfrd2HdDOf6WEQA5YMzsq
	Z1snGmMR0NvfEvBxYSxvGHeKMIjVlbD8DJIISXOkYaptg/n8ojEldGWSg+TFuIfxQAkzulTefTp
	JaF8POEXmO9wJiy04sqrj/Y8HFFYzIK5PwZIkBEw4A19oME7wMduCNlRTvL1e8QWvxG1nUi9L+Z
	O1XpGwTQRJDo/RQfxiDSVhqMT0R0koLdd88zgnRzM9oySkGSg0TlsMZ7Ben25izizM2MmgCOhnk
	61vBqLpl8MTnzTrAk/dEzxrcycxsOR44Z8qHPFnACcVa570cpQApRFGZaPdhd0J5JCGQoe2GwXW
	zuj1XGIE88tucKEje1BJ9bnKV6dLKN7gMr7WPl4pHi4pgPHnwb6BpcRr+1TCqQZw0Mp+TZhWt3j
	yhl5hfFtOQsL6YRY308AfctOZ4Z8LX4a6JUjkeuxfoj2VLBNvfeHMqdvnmDfUrTMWoJx
X-Received: by 2002:a05:7022:5f05:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1b39fe2ebbdmr64845c88.1.1794093581391;
        Sat, 07 Nov 2026 15:19:41 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:5a4:1cb9:242d:4f00])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375603ee8sm1483648c88.9.2026.11.07.15.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 15:19:39 -0800 (PST)
Date: Sat, 07 Nov 2026 15:19:38 -0800
Message-ID: <f7574ee1581d609d45e0ff35e6d908b0@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thorsten Blum <blum@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: amijoy - mark amijoy_phys as __initconst
In-Reply-To: <20261107174739.369375-2-blum@kernel.org>
References: <20261107174739.369375-2-blum@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Thorsten,

On Sat, Nov 07, 2026 at 06:47:38PM +0100, Thorsten Blum wrote:
> amijoy_phys is only read by the __init function amijoy_init().
>
> Also declare amijoy_phys as const.
...
> -static char *amijoy_phys[2] = { "amijoy/input0", "amijoy/input1" };
> +static const char * const amijoy_phys[2] __initconst = {
> +	"amijoy/input0",
> +	"amijoy/input1",
> +};

While this technically works because __initconst only places the pointer
array itself into .init.rodata and leaves the string literals in .rodata,
I find it too subtle and fragile. input_register_device() retains the
dev->phys pointer for the entire lifetime of the input device, so if
anyone later turns amijoy_phys into a 2D char array to avoid pointer
indirection, the strings themselves will move into .init.rodata and
dev->phys will become a dangling pointer after init (with no warning
from modpost since the reference is inside amijoy_init()).

Could we either just mark amijoy_phys as const without __initconst (it
is only 8 bytes on m68k), or drop amijoy_phys altogether and do:

	amijoy_dev[i]->phys = i ? "amijoy/input1" : "amijoy/input0";

in amijoy_init() (which stays in .init.text anyway)?

Thanks.

-- 
Dmitry
