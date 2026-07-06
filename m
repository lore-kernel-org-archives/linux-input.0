Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C03AE712
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361345; cv=none; b=IfpyYTSo1sEpNHnWnVPbv2kMnz7zVv0kfk3LYBjfDzahgeC7CHcwxqgIA+d9dAsxAnQbHS6O1T0S2W4ZtjrmS/ao4RtnKsuZWEkbpundvOaSlheDQxe4I0NH25qbIExLb8hgQevOHWmaE5vzXadWGb1f0UPctVUPq9H3+Nj6UIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361345; c=relaxed/simple;
	bh=hIJpKmWn3KefUAGdo0LDPdlAvhZwYVBzXAeeKjQ1xm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJzTJe+ucndwkCH7lVLU3gBRZHx0Ct8ximTDjodRp313Nj4KlF+rALySUaUhRh3RACus060Y+Z4x65qjtB4CD5cHIrRJzfhTu+lejTnBBjXlpLxL3HTAb30Uc6l7zuOsLFKLjCMMiOL1PpGl6QrxH2CvRLDXVOyL/B81OGfCRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfO4Oqrm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfO4Oqrm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b691cb44so24050465e9.0
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361343; x=1783966143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPaGqcrIwUHb7Vzhi3ZnBUWMwxvshiDblLgHxtklATA=;
        b=hfO4OqrmKcnPZprwHAXc/xN0sN74VO5aLcIFqwlU8naay4MmpD/fcegRfS419sDOvm
         HmPR3aa1NQ4jSyKwWRP/YhfC1Rk5quGkf3OEtBgoBREJpeKHNLzomqmhUAchSSMfAfYg
         6U6zuTTNJvttHUncin4jqJcMpWR5qhqtKDR24HZbiyqFyC2fZ24TGKSGFjZ4245u6EOM
         R1bNqitqDJlc0SNjBRd7RtJnyyl9W+FeddWKvbhK2JlJy6o0voMwQDU0z2zllk3kzDvg
         ITJlCXa4eznXSj6/Ro1B5gmfYSHRYbhUJYvPjETd+qZAOERG98CcgqE88NMJZsMSVj1O
         a/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361343; x=1783966143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPaGqcrIwUHb7Vzhi3ZnBUWMwxvshiDblLgHxtklATA=;
        b=svzJYpnrLL6N0G+fdHUoNZZbxnglhFWU+GbLWe/yAiDW8GbczX6D/xqsfn9xwyLduz
         xpZUregfvz6+ay1k+hpx6sTnYRTPgj0PnlPbgAN5Mg7H9nQFVC0cyIA5floZxzWJQyeq
         89wzNqIfZnI5SqEIanzGVFj2O96PwM9RzGkh/UDgKDZCkYlUXAKQVx+ho05K9kC7cn4y
         7h9S/ltWmQpYAhbPK1bFrZABwkox06SQ5/fUABxcrCrhLhY/CnH+Gdno93xWF1s2QCZ+
         y0Yyr2SyPtXWd0rNTHhtDu3WbHzM0CXrmkOmhSW7RGDmEPWxAfDdxMDb9W2jCt3kuGhn
         4lKw==
X-Forwarded-Encrypted: i=1; AHgh+RrrGq3M10EfTmo4Rb3UwcXVaucD5fxdqrwc0+6oLpaTay73TcO4sqadOAsoRBUw2iaAWosfjHPFiTaqFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyix4f7K1ePH0k3SVvNIModBSv7dzY9LQ1baKvYBY0oYugWT88U
	liaZ9yiQeKJYrUap/OvpLyCBEPHCg6pK/tF9Kq88hvmn3JyihsUryWY=
X-Gm-Gg: AfdE7cl7DqGmpMEBHhYUTbIhczSIOKzQPnr24ATISayVWH7LEpMqfWI5TyCUn7iUbAg
	hld3EGNjQR6MoqVFp+pvDZEAvFfZi8lHRtyU6b99xXcW6YAodnBqJlBuTv445P2mqLFt+cqJ9kQ
	09X7g6+88/luTF3glBGSyPyxhzNZvYbLBoIFWTYiBn7W0fey679HQLOskmzPx4WvufE/Yq+vqHy
	7Cd4cRz1wabM5HUlfKlpFlgbnMef2yOi6rrBe16bGrK5brGlr0K16AlYQjf9z7XOnm4YKjSrbsO
	ewuQ2tbW0sErRttxOa2wmq/u0X0yOmV0EuVBVvY85q7Z6b+WbkGIQCy1hjI6w1RczJc4FC2v9RS
	YfkV485GQf5hLI2/8bvJrdV5DAy1uQtoB2HfsKv+z01E70ojxItRvp7rNYs7S5WVlWrVMWaBmVk
	CTvhMQwD6ka/dfClZpS6OrXL/LtuHnam2Iq2ntL9dBPOSr1evt5hnA/ExJsRLQuvBNmA==
X-Received: by 2002:a05:600c:4585:b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-493df09e3cbmr20223435e9.38.1783361342554;
        Mon, 06 Jul 2026 11:09:02 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:2d45:3978:fa0d:bf54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e01c00afsm1353555e9.4.2026.07.06.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:09:02 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:08:56 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
	linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 02/26] Input: maple_keyb - fix key press detection
Message-ID: <akvvOA972XsT9Ifo@lithos>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-2-41e424964da5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-b4-maple-cleanup-v1-2-41e424964da5@gmail.com>

Hi Dmitry,

On 03 Jul 22:57, Dmitry Torokhov wrote:
> The key press detection logic was using ptr instead of !ptr (where ptr is
> the result of memchr searching for the new key in the old keys).
> 
> If ptr is not NULL, it means the key was already pressed in the previous
> report, so it is not a new press. If ptr is NULL, it means the key was
> not pressed before, so it is a new press.
> 
> Using ptr instead of !ptr caused new presses to be ignored in the first
> poll cycle (only reported in the second cycle if still held, because
> then it was in 'old'), and caused redundant press events to be sent
> on every subsequent poll while the key was held.
> 
> Fix this by using !ptr for press detection, matching the release
> detection logic.
> 
> Fixes: b11d2127c489 ("Input: add support for SEGA Dreamcast keyboard")
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/maple_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
> index 3d5538dd4f23..623d7951405b 100644
> --- a/drivers/input/keyboard/maple_keyb.c
> +++ b/drivers/input/keyboard/maple_keyb.c
> @@ -107,7 +107,7 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
>  		}
>  		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
>  		code = kbd->new[i];
> -		if (code > 3 && ptr) {
> +		if (code > 3 && !ptr) {
>  			keycode = kbd->keycode[code];
>  			if (keycode) {
>  				input_event(dev, EV_MSC, MSC_SCAN, code);
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

For patches 1-17, 21, 22, 24, 25 you can add:
Tested-by: Florian Fuchs <fuchsfl@gmail.com>

I applied the patches without the mutex-related ones, and dropped
the 18, 19 (the mutex ones) and the depending 20, 23, 26 (as didn't
apply then).

The mouse, keyboard, controller is still detected and working like
expected. All buttons, sticks, wheel and knobs work. Patch 2 seems
indeed to make the keyboard feel more reliable while typing.

Thank you,
Regards
Florian
