Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78846255F28
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940432; cv=none; b=h7R97886UArZQmhOsaQs6VZP8EWtERTMlJenqoBSRNjq2GQy/4TC0LfABLuRGBv5N7Gyb+GhX3wYYn5y5q/YfHOSXB3e75x1F2iqXYnhClZSUujU6INBqCqw/Yu9Je0Y6lNCty36hRi3FMhRxkPbZ0bYLuuutAZItS8U3hd5zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940432; c=relaxed/simple;
	bh=UJVA9+EOL1W+AO6b9PWinnVn9nww4fVVLjqsLiybgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK8vPpdUorhWGkMsWZp3EVvT7PncfDklTnzTVwlGX8CNrevMSGVCuNkr/dYuVZtrKfwn18PJ7lS7L9JjCACqFZNC0TnTpAJiILrFrn4rzsWWcpOiy2Cy5C48ZdTunwscN6Uowj472zNu843K20WMWW3B+jLQ2MRhosmLInLiAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X20XkpRt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X20XkpRt"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1048599a91.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784940431; x=1785545231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLa0EMw9PWWGmtr3YMFJ2UkiiCRgohdNwEzulmVed7c=;
        b=X20XkpRtrqo80eIO8rjbrIPG9UlcXMVrdg/RJXAyDSPCkYyFg6WjYBjx4iJ/ENJ4gp
         NQA43R9bKPhKBpPoYUY014esc/9m8aMvwl5U60APrFM4mqfbrDZblylYAMpUnOSMOE1z
         4zxeEclL4DcoNmF6MVG5ZEiz6WBkOl9RR+YoflSuQdS1/+TIhH4sKcsWK/BLY8pl4jZb
         Cr2DfDDwxs2kuquV3IzAe1e9PJVDrpqyqGAw8wKQ8k2c02YTBYf5z62TuA52qA8I0Bes
         tp+t7rtDnyD5Z4oSwtOlHMfiejUYvEKwYtu5lJ9ENe3WxwIbhKFzhtFJkY978Xxkp+8E
         UXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784940431; x=1785545231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nLa0EMw9PWWGmtr3YMFJ2UkiiCRgohdNwEzulmVed7c=;
        b=JMTlQrciYh8tD134LKnh+jJHhwh2TCX7HpYx0MzrpIiAdHv5mszu1lAO8lolFa6ecc
         2XK/DRe9/MJgN/4AzzlOmjkCGSnGS327AePlarrusmrSDNN8u/lIGFjqNQLRX8Anye0h
         6hFse6UBQUrf1vfJ9rBz5gSg/9mCoyrW8Cl40vil294vDzQbZ8Wee57upif1w3aNjP6u
         xovZM3mHaMqRQs5ad6pz83n9yChMsEAushT8T9gk17O60O7j2CXRVurBmXOD/uIHrXGF
         v1C7PS2Ttq5qhNPurx4r5FgZjH6XhDvy837pJFwdOW2VHazgIF7vYXFpHU2QwOikA5i9
         MCRg==
X-Gm-Message-State: AOJu0YyEQvsdEPJwvYP55Nb4aHkpE6z0pE0MRwgp61Rg5amM1oS8Fz3t
	/WEu3dkZtG6nDjUhRh38IrfeeBhv4hYcTmjmTg39jz8RRK/ty7kCOO2d
X-Gm-Gg: AR+sD10e/x4Gg0x7rkH0lfOGy1HC0jU65RV+0QEZho+rXeeaB2fIMxFiNkQTSNLKlkz
	p7ob8ps3txdvWp82h9+B9EY7TlaNfD3LWHp0pcocRje9QID180iirlAcN6+XypdlWt898F633hn
	pQBND6XaBVSw+H5eFeDMMJSU+Cepb8wmPsY6WTyVFkEWuCP4zVuWc664aIQqqYImpAGqvqq2O9W
	zb/jxAHKWOofu2tXEo35MyTXcmcQK24YycFxjBqHKcPpnG/3kuJAr8qPZxev222zS5OTZ1csIrr
	X6F4W96qzCygAgZZ4YhObwnRhQRCA/jOrgBF6X4GD2QjAd8DQiLZJEDl9guQb3Ga3VzrHtJXOBO
	zTMdiGLsGKYSRSkLx9/65oBRKTBf7WiPHL/ohM6uKFHJdBV0ulge9SzUVbjS7YGBXM3pAJG7+8+
	HXQ0wv4cMABVJdOF0JNydfM6yfBlLYPn9cGoio87rpIBk=
X-Received: by 2002:a17:90b:3b83:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38f298857damr611643a91.41.1784940430666;
        Fri, 24 Jul 2026 17:47:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm48048249c88.15.2026.07.24.17.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:47:09 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:47:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liang Zhan <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tca8418_keypad - fix potential infinite loop and
 OOB, access on I2C error
Message-ID: <amP9vj5SZ6Jlipm0@google.com>
References: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>

Hi Liang,

On Thu, Jul 23, 2026 at 11:41:43AM +0800, Liang Zhan wrote:
> From 187224ee38e19fd3f74bfc08d1908c97398fef82 Mon Sep 17 00:00:00 2001
> From: Zhian Liang <liangzhan5dev@gmail.com>
> Date: Thu, 23 Jul 2026 00:08:15 +0800
> Subject: [PATCH] Input: tca8418_keypad - fix potential infinite loop and OOB
>  access on I2C error
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> If the I2C bus returns 0xFF (e.g., due to a stuck bus or device fault),
> the original code would treat it as a valid key event, leading to two
> critical issues:
> 1. The loop in tca8418_read_keypad() would never terminate because the
>    condition "reg <= 0" is false for 0xFF (255). This stalls the threaded
>    IRQ handler indefinitely.

Not everything that Sashiko generates needs to be taken literally. If
transfer glitches I expect I2C core signal this properly.

> 2. The extracted hardware keycode (127) is used to compute row/col
>    indices that exceed the valid range (rows*cols ≤ 80), causing an
>    out-of-bounds read on "keymap[code]" when reporting the key.
> Fix both by:
> - Recognizing 0xFF as an empty FIFO condition (along with 0x00).
> - Validating the keycode before calculating row/col, skipping invalid
>   codes and preventing array overrun.
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
> ---
>  drivers/input/keyboard/tca8418_keypad.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> diff --git a/drivers/input/keyboard/tca8418_keypad.c
> b/drivers/input/keyboard/tca8418_keypad.c
> index b124e576feca..cec6a589192d 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -171,13 +171,20 @@ static void tca8418_read_keypad(struct tca8418_keypad
> *keypad_data)
>             break;
>         }
> -       /* Assume that key code 0 signifies empty FIFO */
> -       if (reg <= 0)
> +       /* 0x00 =  empty FIFO, 0xFF = likely bus fault */
> +       if (reg == 0 || reg == 0xFF)
>             break;
>         state = reg & KEY_EVENT_VALUE;
>         code  = reg & KEY_EVENT_CODE;

Jet's move the check for empty FIFO here:

	if (!code)
		return;

> +       /* validate keycode: must be non-zero and within hardware limits */
> +       if (code == 0 || code > TCA8418_MAX_ROWS * TCA8418_MAX_COLS){

This check is not sufficient if keypad is configured to use just part of
potential matrix. We need to make sure that row and col is within the
rows and cold limits we set up for the keypad.

Thanks.

-- 
Dmitry
