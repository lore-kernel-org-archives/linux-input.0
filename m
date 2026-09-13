Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030312D9EE4
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330938; cv=none; b=THXvgeGSTt10xkHwH4+eJ664FdjblUxy5tvl9C649zhoYdHUWmQeVB96+7Eb/R9NGdsSz4NTtO5G7BnB5B/v/fhAJjU//MqMm9lFQVGy8ECWdYtaYBdnnLLjK+5zZeEFSwi7KaQ0HfHnr+CyNL8+LNT8UgkP9JJO7d5xr0QQaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330938; c=relaxed/simple;
	bh=5Jnyq2m/fxnLdLAi7cgMxTDXw8BXgJ1dEaTgBH8SqDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI2bJ6q8lyuWEu15QXSIw1nc3w6K11pfR4VsgUGjSELMo+7bUK/TIzFipIHT7+74iQdXky56PFc2OPo4g7jhyMrffbp5ZRii8sai4lKYqyHy4xog6YZNjNaEvl3qVd7ABSaKUsYSfczs9BdA8h1+AmbOI0U11dUu/GZq7Q6D5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th8RMXgs; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th8RMXgs"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so1114830a91.3
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789330936; x=1789935736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YW22hpn6NA/1ctJFf8XwFZnt6mlHWHAmp1i+9J3jcig=;
        b=Th8RMXgsIq0rtMw0GKGfHEZAbOgxmYK0km1S3MddxEuAeKVk65O9JLuJS/7l7K7Nhi
         1hFvC9jVKli++lB9NZAEN1G4Ca26UTfguEsSyJkRziNKlfbZcionE37ZziGhKVNuFy5v
         ffygg0uAY65AFUeho1AWBhs/J95RwDf7elnY1ello2+MYy6d/+ls5utggeyVTmzHtIb/
         LZ4dxZsCgEXYhDZKUcUMNraipQbchIj12Y9T5SphPtqW+Sa/JYutn/VyciRqZxf2OhdF
         kIlX1Yz1imfYHnlASfmEYKoeAQV6hKcJVAC66eCjhClkJeKZr6bt/zucrs8EaWgnWZkL
         OFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789330936; x=1789935736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YW22hpn6NA/1ctJFf8XwFZnt6mlHWHAmp1i+9J3jcig=;
        b=Qan7FpjB49W/HZxPdi0narWKTLStkxRfiDaJi+jPWB3pqVvoB1yxW9nWYNd35xZjKL
         G1ZvU4scH3vHhRQ4Pw0cQFBMpy7U1mkGXynp2CO9l8yNTQmotHftRkTaCFED09C2unWc
         1kshajYM1VoYYaw/vVvhQbhFlgEopefUpraJVTUooN6PB6ReTOZf9zVZP/WKsxivZ68J
         RSQ1mP8w4yX8H41+Zhin1YI12+O8SzW5Wne1HW54J5kGSd7tYNGyiCqj8x5Y1TjU2j1T
         rivdSOMhibd9N53wN4Wp6Zgra/OeJCNTVGbhChfWHfv3r0HxcbkSBQDApluFfPRhperg
         Qo7A==
X-Gm-Message-State: AFuF++mR+mkke4M2CPlLu8z948UCpsM5hWRotkgpDd3/acoAi7oTVslZ
	7oovITNc0UaIwVUM285NG/+MtzPUaqDi5utMCNypaTaUDcf9Gp8DrW+Eq7QJ8g==
X-Gm-Gg: AYBFou2lMwVDEbCSXqf1kXeQp8G+W9aY6TQonRGB52BaMSzygI/043Tm/UoDGfdStkg
	ZEzcSpotlNx/N+c7LXjhgcKAw2SHIffy0Xhohsl6ZMK+ufHOPIQKpcd9ixFEUo3Zx3Dx1RxzZI8
	iM1MFyU9k8w6l58U9+H7YdZqs3gXyDMZy4RaHZEhawzaBKUj/1nPNSjnvjAkVR1AVKvEvhRJJTH
	nPdHaqzFQsuBIhMgkY6e1Rfj2G3aL+3MmwBazUmLJ2tO/tjUDmxp8YwHUDuRHk92H+ZJTWrez9Q
	wo1S17HhqtTLbBp86WKmIHcsCd48M/g3oAvR/v1g8oOZjl9hyWbM1QCFUF2Pse/E4jW4XyNhPgl
	u1WVXAVQTaNl5QzKwTpLNLaSOLAddoyYuHkdlCmjA4DGqK5bJspSyU6oHtfiLdbYnXAibhhgl2W
	RaPtUDra32cmCSIdAkbHtx35xnsXWz1VFWR2oQa8vjMJrHRVsQ4q7OxDBeMrONsN2Ob/6UaB4nh
	WU3YSQ4HFvgDDvnhukJcWzjwj7qkfP0sxpJY11e9pncrUMQxsM3
X-Received: by 2002:a17:90b:5807:b0:39b:2b5a:8dc5 with SMTP id 98e67ed59e1d1-39dbc0c2cf6mr14903060a91.6.1789330936018;
        Sun, 13 Sep 2026 13:22:16 -0700 (PDT)
Received: from localhost ([2409:40c4:315e:9ae4:a35a:4d93:b2da:5738])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dada5c76asm14847432a91.12.2026.09.13.13.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:22:15 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:52:10 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Cameron Spencer <cameron@oscillator.com.au>
Cc: linux-input@vger.kernel.org
Subject: Re: [6.12.107] MSI G63 9SEK - Synaptics touchpad falls back to PS/2,
 multitouch lost at boot, fixed by delayed protocol write
Message-ID: <aqcCuI183ErUorYO@eggarch>
References: <4bd8e20e-e4cc-4528-9862-740a437c2687@oscillator.com.au>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd8e20e-e4cc-4528-9862-740a437c2687@oscillator.com.au>

On Sun, Sep 13, 2026 at 05:23:43AM +0000, Cameron Spencer wrote:
> I experienced an issue where my Synaptics touchpad is registered as a 
> basic PS/2 device at boot, losing all multitouch functionality 
> (two-finger scroll, gestures). Writing "synaptics" to the sysfs protocol 
> file a few seconds after boot restores the SynPS/2 extended protocol and 
> full functionality.
> 
> System:
> 
> - Kernel: 6.12.107+deb13-amd64
Hi,

Thanks for the report, could you see if the issue is reproducible in mainline
first?

>      $ dmesg | grep -iE 'psmouse|synaptics|serio|i8042'
>      [    1.006462] i8042: PNP: PS/2 Controller 
> [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>      [    1.010384] serio: i8042 KBD port at 0x60,0x64 irq 1
>      [    1.010392] serio: i8042 AUX port at 0x60,0x64 irq 12
>      [    1.018706] input: AT Translated Set 2 keyboard as 
> /devices/platform/i8042/serio0/input/input0
>      # psmouse probes at boot, fails the Synaptics handshake, registers 
> as plain "PS/2 Synaptics TouchPad" (no multitouch)
>      [    2.384949] input: PS/2 Synaptics TouchPad as 
> /devices/platform/i8042/serio1/input/input6
>      # psmouse-reload service runs after systemd-udev-settle and writes 
> synaptics to /sys/bus/serio/devices/serio1/protocol, then re-probes with 
> the Synaptics extended protocol, queries coordinates, and registers as 
> "SynPS/2 Synaptics TouchPad" (multitouch restored)
>      [    8.654815] psmouse serio1: synaptics: queried max coordinates: 
> x [..5656], y [..4728]
>      [    8.683422] psmouse serio1: synaptics: queried min coordinates: 
> x [1284..], y [1128..]
>      [    8.739382] psmouse serio1: synaptics: Touchpad model: 1, fw: 
> 8.2, id: 0x1e2b1, caps: 0xf00323/0x840300/0x26800/0x0, board id: 3163, 
> fw id: 2286728
>      [    8.775128] input: SynPS/2 Synaptics TouchPad as 
> /devices/platform/i8042/serio1/input/input21
Seems like firmware is unable to answer extended queries for some time
after initialization and just falls back to PS/2,

perhaps we could just add a retry loop around
synaptics_query_hardware() to give firmware a little extra time.

Thanks,
Lovekesh
