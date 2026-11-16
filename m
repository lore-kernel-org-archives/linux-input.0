Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794804111;
	b=P+fWQ4RjM18IJG8w4nD619oAA4v9sOXfYc4G3SAtbucURbyMDN2NE6SdKoa3jDStMmBA
	 wmgwknAnfDLBbRv4Gb/xb7qv5a7+AoaFmxO7oXTsFde4+jw9FYwVm+bJtGzL12lmHlSlY
	 ejzx2Lj3w757IwxWzZAPeistwdrS64bxp9PvKKCqJb0frVVTG7wywcZSeKEb4zgbkqsN8
	 nqwI5AEWXzK741SSi0DyWXl4k3EFN4afeldxB3XzdDbstCsGypZopTeRhr57F1f+5F/gG
	 j7EuPaVNuJ2Oe/7cqSlAAGlvEs3I73RhEjnuoXoEWVGgijF/AWsEEc1egUV6BoBs9Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794804111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=VTg76kZYdcgWJGYz+qNwtmcTjFCSvF3hJ+5NhX0RygY=;
	b=QlRxNdW9jsHyTVroAEfcTqruHMBeoGOM9qEB3V26NK2dxjE9l8YtjGTi6nw4g/yd1yb7
	 32JV/DjlSGDlIV3BQ2jbkDpWAEVUO1DKtRPW3b36OH+5NE9bXzuHe/yA5BQqDtOqZE1m9
	 JL30UXAxJKNQ8+uIsGf4Z4CVhQ0cRKNwgZLamijJkoNx81s/nC3ASkpbFujOHffEkT8Dx
	 ZT/Xkw+r49lpOSMjYGGEsLd/YQlbwcL5yeFdCyVACw41/pO9xV5n8szLnQ5i/eY1BPfwe
	 gFsWa7+B+KY2k4gVfKGNojsF3gtq5Pwh9p3Y/LKt2fMfv1xYXpjONrNAu05RKlkCUUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crDJr2fg;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE57606A31F
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 04:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE57606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crDJr2fg
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3704d30b84fso3517932eec.1
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 20:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794804110; x=1795408910; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTg76kZYdcgWJGYz+qNwtmcTjFCSvF3hJ+5NhX0RygY=;
        b=crDJr2fgE7IYKY9ipw8yqz6NSK46OAewcvxSzfZtWwosU1qGMmuk90S/wHLwuueoZg
         zq22Ri1rdlPWHjiqX9Z7VXyagyB/84RrT9nOCcXRixDAQpVYEjnQvWmAWKjKhX/Wownd
         FK97h2C5q0YDqnktM8FFbDdmwMc/Oit0vH0/UC3io/AHz4XcVAw2K4oSzab1XmxxxvRi
         /k7vD24tI8/Bz5ZnHE9uAwm3fy7a6Pk9QZuvRLVzfSZt+qhje8l/907jvV6VtB1o/hWH
         CxSCCY6PZTEZFB0kuTQa+cb1iylIdK+wLs3kxTzdHlKFQ0dy+5z7uIJbUYeT7t7ZHcgz
         GERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794804110; x=1795408910;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VTg76kZYdcgWJGYz+qNwtmcTjFCSvF3hJ+5NhX0RygY=;
        b=aQ+kJzH8JYKTmUdkYyrJhicD/FQ5wNsFjI6ztfeF5r62V1vjIQ4qtsl5H09pgNtLJN
         ZnlzpMmyba8ql5bNO+jW08B0aiU/A/Xg+EttPee57bSvxTuULSdKxAd7q6R4bvpjFNNf
         CzJnIG5j1gYAPb1fr6oQen2PTC6jzGCi65e8y8D1FHD7JWATdgHgOs5Q1ALx7aiOn/do
         7DV1qq70cbvC4NhmoLKWQBAaA6uXYfMA+9/xm+CnWn8d5KU2BluRdwSSTwnufPe8ddN1
         8mmbRGZLU6ot5ybP+xRyk0qv9I1w/allAi5vliUFj8/DTxYKGWd4/5ZPejog6gy9aj7Z
         fkzg==
X-Gm-Message-State: APuU4Z/XEMUtidOkGdDFW1V3QlRdrJ+GC4ZcyIKX9DZvI0u1KBsW84vZ
	1+g441RNgL5NeKsotDcO+96FX3IGNkZTehd26FiTxLye8gfw/tS7Jou5
X-Gm-Gg: AYBFou1zl49OgRYR6fREEpgXFFSAOTxxGUeUZY1dlrtWBhtBQdV/ML+EhUzf/p5Oltc
	L/LBD+RVjCssYc9vv/wXuHWpSGt+amTiE8pzhK1D6f90ydgL8JA1ryeZl672+QXdsXBKSoVUZza
	aXr0yGHtIz5yjVjxG+aCUZ7k6Oa3C33lah5+c54AaL4V7WbJdu5HUo3deC5+m31WN8DjBFQ1dDC
	Z7LJZ+e842aIZxCjnTTHZ8vfgNy77dTlDJKe0Tf7T8Of6jUy1uOb94ROMjV/ciQwozw0lfI15DL
	EBuUe41cej9JcXm/9d9hOxOlLzeDorjxt1+6XNoHRWxQ25x8Qp53qkufE3lLht44fh75x4wvzVT
	WXHCuH/aMO42ybKfk67IDcDcmjjHgrPyWSFFFi4uvRjssqKoL0RZgzqEe+Yocyf1uKbhYdvViAq
	lkyr6xCnsdQnuyuv65ehxO+kg8rl7Us4QTACx2cGhGrl5iYdkJzMciVFfcjf0rNG+Jcao3plkIJ
	ukvnFKwE41CgaiOAS0AF7JVz95OPWXrwqGeY+FGij4Fm0guQJv0kZK2R3yaRkF49N7RkAtPeKWD
	76rNaszR1fXF/oLZWaUfsqOKZjqRoqmN60/8zKkR4bsLzFzaWOIcIKr0SWTV5ptwwetzicGtdDJ
	9YFAXkJOncw4V5Q==
X-Received: by 2002:a05:7300:231c:b0:36f:3c7e:3c13 with SMTP id 5a478bee46e88-37967ae7f85mr14170507eec.22.1794804109971;
        Sun, 15 Nov 2026 20:41:49 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:203f:d9b9:dda8:24e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm30905922eec.11.2026.11.15.20.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:41:49 -0800 (PST)
Date: Sun, 15 Nov 2026 20:41:48 -0800
Message-ID: <7f9d0adf1f49c5a2b3919130caf0acb7@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: ahmad baghereslami <ahmad.b1995@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: synaptics - support the touchpad LED on RMI function $30
In-Reply-To: <20261114090808.2572722-1-ahmad.b1995@gmail.com>
References: <20261106095658.44166-1-ahmad.b1995@gmail.com> <20261114090808.2572722-1-ahmad.b1995@gmail.com>
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

Hi Ahmad,

On Sat, Nov 14, 2026 at 12:38:08PM +0330, ahmad baghereslami wrote:
> Some HP laptops have an LED in the top left corner of the Synaptics
> touchpad that HP's Windows driver lights while the touchpad is disabled
> (double tap on that corner). On the HP ZBook 17 G3 (SYN3040, TM2706-002)
> the LED is not driven through the PS/2 deluxe LED command: the Windows
> driver (SynTP.sys 19.0.19.68) switches the touchpad to RMI register
> access over PS/2 with mode byte 0x7f, looks up function $30 (GPIO/LED)
> in the page description table and sets the LED bit in its control
> register:
>
>   register write:  SetScale 2:1, SetRate <reg>, SetRate <value>
>   register read:   SetScale 2:1, SetRate <reg>, GetInfo (first byte)
>
> For touchpads in a new rmi_led_pnp_ids list, look up the F30 LED this
> way when the touchpad is set up and register a
> synaptics::touchpad_disabled LED class device.

Why is this touchpad running in legacy PS/2 mode instead of native RMI4
mode over SMBus (InterTouch / rmi4_smbus)?

Could you please check if booting with psmouse.synaptics_intertouch=1
switches the touchpad (and the pointing stick via F03) to RMI4 over
SMBus on the HP ZBook 17 G3?

If InterTouch works on this machine, we should add "SYN3040" to
smbus_pnp_ids[] in drivers/input/mouse/synaptics.c and implement LED
class support in drivers/input/rmi4/rmi_f30.c (which already parses
f30->has_led and the F30 control register layout), rather than adding
RMI4 PDT scanning and F30 register manipulation over the PS/2 command
backdoor in the legacy PS/2 driver.

Thanks.

-- 
Dmitry
