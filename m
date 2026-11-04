Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809993;
	b=sWClPDAiPtNVZXfVVQQn3JcDjBn5VDeEfKH6DRw+WSWXbFsuuru5T8548/jiwzFUvwC7
	 7Z9QASnOOMATr0m4+/+1ZR5ctKxjLk64gmVqwwC3ybqRZq3tdUPtNMl0zw7eV36cuwYoS
	 L09wdV3J1R62+JOZU8GlemggMFrK6d/hE5sAu0EDa7olHVKkFG+tXriGvZU5i3aUAb80U
	 SzU4V56sMCm0EqHbli+Ugdgas0CkKxBjJxAGM1e5H+QMlW4nokqNpgJ4hQYrVwav9hY2S
	 RigtVZmphm/G27Hz+B8iSKQCxln9lK+dzDRMw9q+AFy/NDA0RhrNQ4+A6ft5VwawSNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WUuEMcW2y0Pk1LSyzuy5CzYSgNsbEsC5pDpoND1JIlI=;
	b=SncD1qaM8iTFaKtIeYktXuQOs9mCXhUlUkX4N8I/QGHamMJPMGHAVi8cOGvKcIDGVM2U
	 AzjStp7gnNblFbUptRmZ5Iw73FRtEru6NLK3kaQiOXTJ/xPLOvDaatNjmKuOO+mXj7WHp
	 7c6M/qwA98QM3bN/yc85nGUtirj0m27tAY5jP+pC24cGxE4qpK/zKR/IUeiYRIwmajSQl
	 BMfX2gYBLl+fgI5ANh8Su7rYOaDsKTKKDmLen+J4FnavB5+ALno+KAWI+7Lc887sAAgYl
	 1wafCeDr37yyK3aUOUYUWXkg0x9AZKCGL9rSQNsFMS3reziu4u22r6xiC3Qtz8xvZdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsRCd8bw;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD1606A32D
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 16:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEAD1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsRCd8bw
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd693e0942bso273057a12.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 08:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793809992; x=1794414792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUuEMcW2y0Pk1LSyzuy5CzYSgNsbEsC5pDpoND1JIlI=;
        b=fsRCd8bw1VaW/FUdm/x5df/xZRxMEuPhoQfa4aceQ5hTpY2tLfKPRvrkw6NnJ3E7T2
         pg1y6766lH0bbeB2956Pil7wCQzy8WJFRTd+sW3e0yFQUxRp/4pSyMu1ZTMeud1eJkg4
         sURn4xaS0qewmdL3Gjw30AQYO45iU49ttRPe0ARjCZuirjTDeL6vzWALtqYX1agqbnVP
         A0ctlZ5JBWCS4/jLNl+cttzqyA0Ijx6x9q+aePujoKXpCwDbbR3aRvEYPfgnSsOdoCLb
         rxvW3Vs2qPcnxbd8hOFTNMHBgOpgdRvpjrZBxvv7KwpVL0KV0RFtnUWmz073kklfnRWw
         7flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809992; x=1794414792;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WUuEMcW2y0Pk1LSyzuy5CzYSgNsbEsC5pDpoND1JIlI=;
        b=LAzQhjqmXqDS/L+co+x7oIurRRHdmyoncvT48m29Rb3uSMmrfweF8PxDFka+s+Szyd
         DZA4eLGbLHSI6KE4Paz72K+pRHUv/p+IFEhF2O3hf8AWma8z+JkU86XP0xaZ4XPta/vK
         5yr0kS1yErfTYlV5A/tiuJ77JLGNy9XaJb4wJ4q+5rD6dvKozdwCX+apDX1W4Z2Tt4ea
         wGEcKOgOXud7zeHf5cEV0DsXmhnKg1iuyaXngW/JJe7FGv6QUxHyn3Y0hEkvzthayZn3
         QxYXNOOQKcXEmTFtntwUJD2pPTYThPG/sZg/As7kSssiQpySCHErH3ChPshH8ijJxG6U
         fQbw==
X-Forwarded-Encrypted: i=1; AKwUvBwII8vErzif1s5OWGxKT+7bAITbE76cd4Z61v7e9t3z0skWb7hktD0qhj9L5xjRARe2fzJqDMn51roSJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9mXRs4xxR9GWvQmVjdowSS0RJKpy1HtG9Gz0O+lC3LJnhtv7aq
	IwrjICteD8qKcdwOavelqhCwpwb8RVUUAYHqs+iRgd5VUvW3+/UBhBok
X-Gm-Gg: AYBFou27/Rt6cHxggQbrslWeegIpagGOFk6clrjY758++1jr+qaix7ZPBPFsR3sgDR/
	asYFLQ9QaZUW5J2VpVIZmYe5ilRrBiieuL2RAUqMnVkgsCzn9VVyn+eOSkE+D76FcxQZ3P4A9/4
	TtuRmv+0Lz8D0HjbyF+uxz27eQCnneXFXndqCECFZtAaUsaHsAoPiKlXdO6XAoapMknvOYMw07t
	nFm5bZlzxsew0ZJfbKYG2SOUeqsiYRmbkBlpnEeRuYaoEcaFEFju+lCvTcLbhOvvmjfxt+9o+dv
	QSDNhndJu3lrHCuc26wkxbQIf3ZiLHGRhp3iQU5z0T8+V95NiBNml+NunMLkiUdEU9ClC6b11/X
	jLYAJJqgCNUP30Q/5VdHStCjR+15/z52tOmsnB3q0edSPSfcjCmRW79pWMIc6dJj6WpggG35p1y
	rCucdEoDlCYZjlhQyafkWrWgysW6INly9/GRvR0o9fpYDil8Wsrd9lBXFrk9D2kAjgy6YopzXLK
	zqzhTecp0mHHhCFP5RSa6Kx/J5M20tIqkTNiOLa6PcdvKztyZhtWwm1EtObWRZVF6dfeIkr5JGR
	Gkv5DQJ3SWo4u2Cu0J1IyZ0lGVIuCepnr7I9k2YLeNxEjeSIoc7GcVo=
X-Received: by 2002:a05:6a00:3d43:b0:8a0:3685:239d with SMTP id d2e1a72fcca58-8a9b9a4ecfamr13116937b3a.1.1793809991595;
        Wed, 04 Nov 2026 08:33:11 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b1209b473dsm912606b3a.36.2026.11.04.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:33:11 -0800 (PST)
Date: Thu, 5 Nov 2026 00:33:05 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <ttauzj6h5b46f7o72f2irfwsr5vv6zcqtfme5qyery6wtg3eb4@u7iszy34j32k>
Mail-Followup-To: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>

On Tue, Nov 03, 2026 at 10:23:18PM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API[1], use
> strscpy() to initialize the mouse device name.
> 
> The destination is zero-initialized, and the constant string fits
> within the buffer. Since the return value is unused, this preserves
> the existing behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Reviewed-by: Shihuang Liu <shlomojune6@gmail.com>
