Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E42352FB0
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283301; cv=none; b=QJVyPny1UMGyqrz7ewEvaI+VB2l9G0dKHhlpjzGXUi1JAPVO3ZzgtdkCq1Eo2USx66AYO1BJm7ov0rvp5rdN5BNjMbvE3iluPCbn8zS5E4l2RQvHfk9CE2Byd9fVA3fNqRqgbOSLzFWhnMIz71ZcuWFG8ro2o9Nj+CeNNpi6ukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283301; c=relaxed/simple;
	bh=zGfqUCx6jXAzT6zCCJ7NiL3kT8DKVER0oBryCp4Dxcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax6Ba29xO3rmvyam7MZ230t6kvgdn2tK6q5RxaUlc2ChPbytdu4Dnv2VDWy40iP4seupLh0DfUSFjm319a3N87Br+OlOH5lqSqSuID5wvECrV5FXIhUdAUF3twwDXOPKyIyDSBPsbdVg6MmBsvir4DqFkkqTDTG6+/UeB2iGP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiGJzJG5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiGJzJG5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c02782159so347541f8f.0
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2026 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791283297; x=1791888097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9EgTKWvY83NOreoEpihq3C4uu+WwUDt2rznQTC8D2g=;
        b=RiGJzJG5n0Z9tkkWW7q5OVVdQFwdMvdu+B6c2pZTXH1iwDGUgdO3b8B7KhDcaUbklp
         SKsBPoiSn58rLdkGnYH/02aMimAfPT67yOsv99OZ52ZMpIbcfVAIAQtF77EN+vj2Tasi
         BiFj7fneJnlFUfnyNB9scjz1o/ACOrXOZTsCW/ONz47k6KL79ocllOEDynh2hFF7KYD0
         YLmhJYYDwVbtaNesv6EhF9Ofxbho94LWWIhpYt8jidhWhxZiHQyX+RAlllHPA9i2HlKC
         A6n6WkvufLuhIZsHCNFP9MrrKfDY215t2WPG/smIebLumLZuQlT4xxBAf5h2FK7/Mf+D
         Lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283297; x=1791888097;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9EgTKWvY83NOreoEpihq3C4uu+WwUDt2rznQTC8D2g=;
        b=QTvv17hCbMleFKUJBeMXL9l7NSHiGYo1HTT6IzMhJw6cwRVuathlFiMQAZj1zNQ08e
         g5bKYe+58yezEXKfR6axusdwg4mpBLQiY+MT5zhIq3qjhfHDo/Oa9BvPlrpzBhcKCAHj
         gMKsuPsk1iw5w1GdZK7xQwc1eA8X61O6Pwrt8vryBKccwfDtFtWinVHfYHrfBQcS+jpU
         /ihqeRjomQu0kuBVqkpo8wx/a3PCr1BoUQDNhIaPMuLRFSPczcwM6v9nKOlQGwaPQ9xK
         yclm1S/PFK8qdJozukkU1Whi7bVQsV9TUNFnjpqK9IPCNd+yUR7Ngg3i1WK6NJpJoJUR
         J/qw==
X-Forwarded-Encrypted: i=1; AKwUvBx/mIDoheEAU4Pw8y8wwhJbAvsNAmDCSvfJzAdzupig8cd6NGW9vr0HLW60o1dppl9G5c+9WyXjBpsaSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYILiFwAvT1AXduVL7ag0eICQz33FjQQQVIZFWVzmZPqCVI62jPQ
	ul/HHhRyX3+zKtI3kI8K8xn079SSSltjr2AljKVzUCeJcE/ebdk4bp8=
X-Gm-Gg: AYBFou3MfpqCyzLM7fthIkxyjmtuuldUHbI89izJTwpUwgRoLxuVEw1ank7UG7Y8tKC
	bwXZfwUTt4ssTMs/X/9FwenlEF/8+8DZwIL61sboFcF+9vbFnnGVM721XySVSOQoo4K05KhbGqi
	W1FtmwduLLNX7zEa9Q/WXvZeW0tNWt4JK8vfUqP4v21gQV85LBdy+0lXicIQXltlC0CZiC+SSJF
	8D1vqtbZ4X4b4hi/Ch1B03onl1rb4IUq6dHjwv3+4NAk4YsT2NMgjtlSbMmF1/ctwjTdphHNMfB
	4vLPQ0oKjsunC2zPK1HAqN3bjiiJIo4vddueryj8GhewYB801W8rmOerQhctOTvLhMuu9ZKFslq
	t03otGhV3m9lKJcuc5tnWxmZ1Wj1Qf2K+pebdd8iqMyy7ybyu+IL5g7+LMtD63/WE31o+Ja20Zt
	3jrFWScqtveduRBBUOR5ZkDH3GYSzbTTfGvARPQzrtQ4o96eEuBwIujzpCfxUEMqiYGIAaZe0Kz
	2SmkFFRKwsTf8GyKaKuKCEAB+kbkRGGHCRRt9irCMyjQQCsNQ==
X-Received: by 2002:a05:6000:2dc7:b0:48c:41c2:46d6 with SMTP id ffacd0b85a97d-48c6d1c1c1amr2258645f8f.35.1791283296969;
        Tue, 06 Oct 2026 03:41:36 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:d1f6:bf6:35f2:f07c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622704a5sm22046834f8f.15.2026.10.06.03.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:41:36 -0700 (PDT)
Date: Tue, 6 Oct 2026 12:41:31 +0200
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
Message-ID: <asTQW0F2nqp2Kj86@lithos>
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

Hi Dmitry,
do you want to pick this patch as well? It improves key press detection,
so would be nice.

Tested-By: Florian Fuchs <fuchsfl@gmail.com>


Regards
Florian
