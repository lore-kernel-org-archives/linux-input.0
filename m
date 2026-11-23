Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414399;
	b=iD+LPGlXNum4WU2tphLJZ03CibrWrW2ZEgFEXESTz+Tu2oVI0p4F0MhZCNGQBfFXMT9G
	 qhryeBzi3zdNTIu4+8o4hWXr4IMeox/cK6fLObzRKWdIrRFJR8KIS1ZdPAYwxg9IHO2wU
	 U3nnszM4LuBLHXdpgR+5uN3JwTzyiS9pSqEaCVjhEDnQhBpBYsqrBcbPJ283fyE+eAe7b
	 KSkzKwWmLrUsonfD9TjbSHAUUfxINHYfThrdeJTQnCISFzJDeWrou+y6nYtrqyNAFX7vA
	 xtekicRf1n2pKL0oTrcGGVeagG0vAXagvvXQs9TThHW7pyhE+1TiDDts7sK5haNIPYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0N7YienSVgGQFxcgNWuK1q2ts4qQJpa04K9gom3nhoA=;
	b=KKR4krZ34/zF/ZlXkAD2dGrD8hXjU/XPgMi8k7wBR8/vtFB74/mHlDJgKValL/CPl6qf
	 Gm0of3RwZjPeA93xjNiHq0IUrCugO0wF8VBZucux0eRDcKpOthGzg2d83siQdhXKXHfF2
	 U7NERyk3pt+SfDqvBdnU5Nowcapcp/UEHmIqgubFshfSf//MRyM26jSd1t2/7dJlSHccB
	 ohXSI9e/+6PUR04rQSWJYyeusVcqTh81MoZMDVtgEF56p9hBQSTn8pXkKbo81QfyE+Wyr
	 TId1El+aGLXuLLQaRV4Nbcp7F+xZHTUWspdk8WJEAP1TnZE6TlL7WXeetkJvJDXL0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LFRV01aJ;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1053606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1053606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LFRV01aJ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so8194381eec.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795414398; x=1796019198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0N7YienSVgGQFxcgNWuK1q2ts4qQJpa04K9gom3nhoA=;
        b=LFRV01aJZ928UOLxtn3AwpeoQyM7QlLD+7FOoyteQ1ImcG8cp0kL6t5Gz/pxFC1j1Q
         3mOu+DHuYYifyjLaIEz5gsPajo53med11ulGky4DEt0YeMqXH/JEos3L3D+c4oPRL015
         sCQh2Ba9EwLNu3CYyLkRGZngiBegROhZZPqYkRzO5o9BqxBtgOIZXl+BKyUNZpOYB+7C
         5x+BBkrBHbutaNdF2bRZapnU2964h1pbx8Ciu/W6CDBoF/1uxFa+62uc6zBxnzOGS8BJ
         s64EqiXX+ANTjOYZYuA9ExCcw+3pDgbv6c1vKdNo35TLcTysA7xAhwaWqLNGeQS56wV6
         2b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795414398; x=1796019198;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0N7YienSVgGQFxcgNWuK1q2ts4qQJpa04K9gom3nhoA=;
        b=C1T1EAheeIB4A1ZlhWxHHJvVXgJpetj4vj8ZU5XKfxEr5DkFP+/GEj69QkA3MR0Sq8
         PhUXkY9ijRL5bq1yoW4RCnVb0jssFAgE0M4tPPNn13Lr21xbCZ0lPOtMgg9MuByTOR7Z
         g1mXRqYrZWMF3jwPNfxsIdH9BDQafoV8Dewwg2M+1ImJRowfrOROcoAsxGCnXK7DPuI5
         vD5aeGpiQDzSj5RciAm54t05fcm/pRp7+r5wOwcUsHV6Kw2CSE7fC7SCs6mJPj9b+h30
         IGNNTdbpE2n9VGHTUAtty6Ul0MVxUz6nzOB9LSfTfFdm1SN/Bg/h11O2bjIYUiqjVRMz
         6BkQ==
X-Forwarded-Encrypted: i=1; AL+hErHSQzJ5Ye3YLqkpy0VH1vyuF8Q/cFgVCO+B5GZ07QUXTkeeS27zV8eUa+T9Uq2DWSqRwnJS919lAeHWlw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Mjw0LoLIeuAjvKlJr+SmOzbRAXgDZ8/+cxftIb07YRVktPKa/
	Hzm8XH7BbVVXugDQd4vbMOz8y6Qw3ttIGM3DzE5XF9boTLJtlJTl6/GL
X-Gm-Gg: AZFdTZdUqtBJgSCwwYnLH2YZtFlPuNUHjwZ9F7NyhMOUNmSYaR4oGFaxvqXIUK1nzmA
	ej9xgAjahhWilvS0kQec4ULpt8eUx0PiL98dHJ/FyXMRNaQf65bNcFnKBmJmQNU4JTla1r27D6x
	rSFIaFKN5tw4NnD+ZlmCcHqyPiKHAnak+NhKYThWaHA4a/T1uikJHa5tbQaZpiSwycNrOz9MAef
	XnO7Prkale5TyPg/e4h2Zvxllzbpp8/6FlqUlMz/9loUNm6naLxBcOLpq/kXr0PrPcYilmWZZTn
	pPM4Ne1W2SkeFNsfFDcLtYoJTFqKHMPMU7CFSlH/Sv3kHNplFNcXpAeGnvcLhBIDkqFUBo3kENa
	pDNzbERB4l4CIhJxSARadNNDyMhKL9wU1PbvZgI182w3tRsSI6JAm2JH18UlnJ1uJg1cVq3zKxG
	G2mSynf5gSr5N2HO79NE+RvsLR2ns+hnRzvUKSev29K3Wtkq2FnlNcSFUOoFpuLwlx3zUbk/HZW
	msWv8hRLiqE9rJ+iZgae9GF7x0o8zm750cRb2VrnqffIwlvkmnMDkiP150+7t+VXB2gfB2u638v
	RP++cVEMfSq7V0kB4KI5dEs9tNpKnvR7mCiICI7r6XWPPE/WIsJbFJuii+CQnK5uzPt1rD8=
X-Received: by 2002:a05:693c:6205:b0:386:a498:3ab1 with SMTP id 5a478bee46e88-386a4983cc5mr5716537eec.25.1795414397956;
        Sun, 22 Nov 2026 22:13:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm38645290eec.11.2026.11.22.22.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:13:17 -0800 (PST)
Date: Sun, 22 Nov 2026 22:13:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kim Kyuwon <q1.kim@samsung.com>, Evgeniy Dushistov <dushistov@mail.ru>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: max7359_keypad - drop platform data support
 and style fixes
Message-ID: <awPZcfJPvdseLBsE@google.com>
References: <20261112065059.1802480-1-dmitry.torokhov@gmail.com>
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
In-Reply-To: <20261112065059.1802480-1-dmitry.torokhov@gmail.com>

On Wed, Nov 11, 2026 at 10:50:56PM -0800, Dmitry Torokhov wrote:
> This short series drops unused platform data support from the
> max7359_keypad driver so it relies exclusively on device properties via
> matrix_keypad_build_keymap(), and cleans up register bit definitions and
> argument alignment.
> 
> Thanks.
> 
> Dmitry Torokhov (2):
>   Input: max7359_keypad - drop platform data support
>   Input: max7359_keypad - fix coding style issues

Applied the lot.

-- 
Dmitry
