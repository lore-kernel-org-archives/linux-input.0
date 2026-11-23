Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465178;
	b=O/NorXC5Ac/rNyCCUUHo0JPTQRccNBmP1p+88kqVeNmvs74PVai9dyNs2F77H1GlCvua
	 P2LNDaAzKZAAlm2J0rDzXBk9zO+rZRxpnngk5glGoJYAjHAc9ckWWoyF7PyuJqMprCHhT
	 +cxo77xp079w5tZCC7ZxoDTJgtEaee81RyAoxnF2IzItkpXD4U2uTsksCqcCLC52vCF7g
	 L8xCLWnLFUATEOAEioDTgiEDx9QshcGNR+elZh6WIUSpk8G9Wb58NCIjXS+CPI4TLfgg5
	 yCc8iO2faYALTJAm7UwDfkkuwt5B4GUixcpOOmEx1Z/7UMsqM8bO/keowB2Do4doL4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=k9JvOVz5fdfo9Ol5UQWej8qJ9KZGY8CDn+BGwa9BvBA=;
	b=ZmSe5tjsB3MDXvJXYCBlYwso0qY1/fKqrf5jqWdgT4yYnMGCA0T3+go5R9PzxlBnyd/p
	 +AGlzI5OTDyre4eRk7qaIuDpswdHqt/t2aqv+gpc9C7bqiI8qWtBrUjpE37SHcMem4nd+
	 b93W9P51VCzBPjXUJ1lO1SW7sGD4v9JlaeH+Q45x/baxsUnYj7TsNtteVJYFsFfFv9WOt
	 xxbJRDKaot8h/s1nw90emhEDMqxjY7Q3HBrVyHU0C1gXxRYscurbtYuYrZlrXtjXrBqOy
	 nOoncPqg7XMUZDzVq83YYd/oZ4rcXrdrAUEm5La1Ue0SeK6eTaq9uIJqRqA3Vkze1MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lgUJfAb/";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6020606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6020606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lgUJfAb/
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-38644aedba1so5659220eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465177; x=1796069977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k9JvOVz5fdfo9Ol5UQWej8qJ9KZGY8CDn+BGwa9BvBA=;
        b=lgUJfAb/vyxZQ6/b6tuAVyFytFPBYr8TkJTXTys3zhzRbIAxfR9jFkSb7TG+uPZZef
         5CGy6n4d+zrF2erPnqe7uVws1QY64qO3DlQWVCtpZQIkmy4qTeKPeJ2VMi1M5oiDbg5M
         QM7ceSymN2Qarxo0SAbtKcG/FRVWqF+cArIml6tCkIt32oLIThKRYO5Qjavp8hzzwzv8
         klTkxXk4CG0koeX+RhBwwgLsy2QjQrMaMp6poSckzPsWvoR95dCL0vVvqmBn+eYf9e8R
         CJTys15HmCdjcNciWuVwodHuErLtMRA2+kphH4EDWVHopgQncYQu0vFpKPxEhgliqlAw
         L/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465177; x=1796069977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k9JvOVz5fdfo9Ol5UQWej8qJ9KZGY8CDn+BGwa9BvBA=;
        b=ZtvhiLwbfxO8VCjnLHU2N7RwNNh1gh3Jgwi6Hf+AZrkqe6b2qx9TyjVzG2p5pUW+qN
         RZIVxMfUbrjGLGOsZn3122V/R3+CZWD5mS4Z9oLN/Pr44VBXorhahHKf0tdKV6HdHyzb
         iAfEqowzWrkPS16GDWqvOtD8tbbXuq52kuMgvRSAyAlNE2MVrtTD4VRnG609vG5BiQ4J
         XfTSifV7q/RjrFLp4bS0Cdx2HJ3Atd20qWXT4qY0XejzLsN6DvpetPrjuRBVJCrTK0FK
         6b5u5TKavNxWBTmJCCXBpAFp/UlOTObUJgJUlBttYNOaYwVEw6ifkMiNxBIrvrDiHwfi
         r8/g==
X-Forwarded-Encrypted: i=1; AL+hErHhHSaJ+49YUWEAm1iwzHxluYGl58aAckP2hneqoNo3Q1jQBnr/3LSSoeRGNzl7VAx8zZLy1BhbjlAkbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9wlXI2Fx+yPhnx+cYmIiszqRaXT2ywr4P2nUYTxbWcxSZ/OuWI
	TOlmTJ2CloL3X8zmX7zKSErzMX2tEFu32qvierszIV7fhGjOwYWy9jqX
X-Gm-Gg: AZFdTZdL4oK+nXbD+AbzLAOE5/YWw8NtfMwI3nPS0onX+vWyp2FP4j9GPCe+49VHViy
	JNYfpAFmLpeqBahxk+QH5ToR4FxQ/cJgzzqQCMxSzD9DbFwwBYI2kU76jsCAzwDQzSjvHq1KXM0
	Fi4vUxoqwXnMBqfkMfy8oYyBAN9Uof2o6BEjwXaSG+/mDRFj1wplcsdri1DlIQBEG7djiTdznDV
	xHcyutiO0WVGtc1G/2NdBskQnYZMv29/g42jNl4Z/lcFKpahq8DKyzXIzkiJjiXCbOlxZr79Cs7
	32ttHURh/dZDrWzqHWLS8g1O5U59oqgtbaNUKUnD3JuWUbLgzKth1SQkalDeJIEbnuSKNEbmRF9
	Nx7YCRrGSjOTUbMBkvI/YhQpWy7kzRg+0mkZAQrH0DmMibxZSv6p3f954FPcUxEeZpbOZ3ZqXzg
	5Ju4GFiDhLXru2Zyxho3sFXUHPGltjIkYq5q3xz+kZXkpkhnft8TtOpHDHQjsS1lNPP7KHouB4T
	mWsaoxUkPKtSDvNfoQjuGkq/G/AqZ8C3ZP0rdWB1YCvCdKYiHQKkkqvGugC+BsT22rMa0PF2D/K
	Rj7r5QyWCzOS8GN8OAkVxzl8vfNVIw3oQrpBBCvCu9Vc3WXB+/EvAMWniD4Vg6lWroukUGQ=
X-Received: by 2002:a05:7300:ce93:b0:36c:a44c:1763 with SMTP id 5a478bee46e88-386bbfa6402mr1219667eec.32.1795465176733;
        Mon, 23 Nov 2026 12:19:36 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm44019037eec.26.2026.11.23.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:19:36 -0800 (PST)
Date: Mon, 23 Nov 2026 12:19:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Vojtech Pavlik <vojtech@ucw.cz>, Greg Kroah-Hartman <gregkh@suse.de>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/10] Input: stinger - zero-initialise driver state in
 stinger_connect()
Message-ID: <awSf0LtS9H2o_hWi@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-6-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-6-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:11PM +0000, Lee Jones wrote:
> stinger_connect() allocates struct stinger with kmalloc_obj() without
> initialising the signed packet index stinger->idx.
> 
> When serial bytes arrive in stinger_interrupt(), negative values of
> stinger->idx pass the stinger->idx < STINGER_MAX_LENGTH check and cause
> stinger->data[stinger->idx++] to write before the start of stinger->data
> on the heap, corrupting stinger->dev or adjacent slab memory.  Initial
> values of 4 or greater never match the stinger->idx == 4 reset check and
> permanently wedge packet assembly.
> 
> Allocate struct stinger with kzalloc_obj() so stinger->idx and the
> packet buffer start zeroed.
> 
> Fixes: 17dd3f0f7aa7 ("[PATCH] drivers/input/joystick: convert to dynamic input_dev allocation")
> Closes: https://sashiko.dev/#/bug/linux-bad333c0-5b62-4ca5-ad93-204400bcba3a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
