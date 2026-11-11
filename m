Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427450;
	b=JFJv/QH2RdPCrAQE2HVCXcKSIGTHqH3YaYDORRBvvm4HJ02fpERe6EtrDL0ANPQw7gx1
	 iEyHF5vTaNrF7M56AW7ZccF72BPtUEbmu/2xMfYoW7qeokCwhGKs5IHMxftJZE1qMZhsG
	 c1sZQM93xQnzVayN86HpNnZscLKm+37NWSn7lJ+SPHa4iOwox6nquZAiFTKODgr6LXVGC
	 jkhQsMB/0qlr7/XaL/U/8idh4Q/hnF8lMM2lJ5lyO9sMLfhicKlbtEEQTkg3mDQnlr/bP
	 OBKcTVrWnIMRiQLOeRiTBnNf+csT7XMzMMdOtU2iW4uF4fQwLC3hOh3GVH1tLQYVwLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rrnN6PgcupTOflQAOBran5Xv0Q8F+fK91Nv1axJyJJo=;
	b=WP3C3oxIU7eJsvXPRXBZNY/ptb3jbKppyAPyGqQTmP44rSo5VOKqCks6yZPviu6H+OEC
	 r+/1LP3b3ThUyKi36f93anTCVK4xEJPO6MFYXx+yPa/KUIj9kpYSNTmuSoQS1j0JwKUDM
	 Tu57n5ouNhdwMlxRp1gH4iAohum42uaZnLdVWAzpEw311UZS3HPdOZel1dhxgoPZ1eb8X
	 LVp26WMClmlh5Py+4izO9G8b+iOEI1e9bkWxmJ9HqVC8QQXTle1o4vqOi+Wm4cLSCHNVG
	 ulmC0cliEdncfcIPlPOy5xBXifFfAgifnqYFKnpxQs1BuBMfjeKRhMNs69qo6veAiBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYL2ei1P;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF7606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 20:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4AF7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYL2ei1P
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so5928544c88.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 12:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427449; x=1795032249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rrnN6PgcupTOflQAOBran5Xv0Q8F+fK91Nv1axJyJJo=;
        b=FYL2ei1PK0cTXZ6liuKisuJ3kjkHEby9i/yIdvVzWLPEIqdhOPrrv/+LR54pKOi+Sw
         i+v9qeMh/2762ycCdHh2FNnu8jkxb0S4GWK+/x7TaZEtrr0mUCXhWTUG/louCG/W7PLu
         c09QG64UWRb0wNZ/jFiHjjUeus0twYkriy/V85WSfYTxnn3fyPITaFNaNZsOIQujkmv2
         OCEOXahunvKNiWIyesBdo8j7BtjlL1AFk9cECKPG6mta6G89xR/fQAngykVDqlJY6sfl
         83cYapoeQQR8CkDhywd5VMlPDP0tg0gaxAM/cNnmVl2Q8eePLnJveXiydeiWWRNbp+LL
         F/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427449; x=1795032249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrnN6PgcupTOflQAOBran5Xv0Q8F+fK91Nv1axJyJJo=;
        b=IYPeaw88fJtCvNeTS6h8QFmD9Ckyq+15qTY8XWTRA8DR2x1A9dxrFAdN6tkeiXoO0Q
         o6ua/DJ3w9+70eEkxE40ADLJkw9NYJAqNHmLZ46stWtRpfij3HdsVROyW8qTMsl1A6uz
         HYlhMmfDHn1j8tMXE9KTkLEVvvrRd1jAwv3xVp62bfbEP9j4yjLiaiy9Qv4cL31Pr+JX
         WGQDugtzf0/iThBckOgelL3qJwcEE6Ij6D8+FcOZuLyBYfVBw2QmtGG9rGi1y5YurYYO
         N0y9CWdma9WLs1+aO0LvAOaq+kp5nThNvHoW9EO1nYfAW6ygMgCK4FunfSXD2Ei5kFPi
         RvXw==
X-Gm-Message-State: APuU4Z+8RD2wyRQAwzf3Ym2Bdczr8HMk9Mec9THjcrKl17FC8Zd3twe5
	ypNufrD+2fwQJkQ9RkDxbkjIa0nJE+a3h0qpmzWb8zDFdcwUUr5fCIhb
X-Gm-Gg: AYBFou0xy+yp2SDuBgAM9h8R7yvGuDBmRy32j3P0jcK4lkdW6xGM7iJeDi1nTLV5WvB
	ulLYELuM7fZsRyycHgU2egwpv6KWFmR/ykUMtKT/rJdYZLtQVsLyZ5KBb02+gg1P3yXgKpq0bvr
	riA+UZiMyNtbea8WrA1CCShjY4KsWAX1glz9sj0NBRd+uQMBUGRwXIdIfJ3vAELS6x1J70bRX4U
	CmMEX/RpaxBBR9zGyyCtc4dY0ssQM4retNz0LbQ5TYS/sC+Q+BSOCu24bsTVN74S3iMkc+dC3bX
	uTPYexcgJfbHj8ZwHXJbYs8RkwkN5uzbTotMppe11hfmH0QFrAZbY62X4/pSlaTf/g754TPVxze
	3VIvQtcMcNAMYTBlApiUllX5BbEW4BF9jbUeuQRtj236Tq/hNE0d5bX0Z8lrqpyuWGpNcgK9Olz
	y/avxNs/v+ApZy2i+/m+eM+HY5px+LoPckCcd7+87XZH0Irjv4KMVf3zGfCfc/nattrfTjzdinS
	wBwauza0zwmBqkaHZVdHlsq0WBW9dcuKjunjGT+0BBiUp8QtK995H+qTccbLFlXlL+YtjdMUd7x
	jt2q1hSLp7NyK8tzydcP8zE9wRWmNYtXZ663Y+bMOfJRf0aukEiOrb7ZFBpvjju6qmd6+lo=
X-Received: by 2002:a05:693c:8955:20b0:36f:26a7:968e with SMTP id 5a478bee46e88-37686a4510dmr3860069eec.40.1794427448447;
        Wed, 11 Nov 2026 12:04:08 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-377531d3287sm5133734eec.0.2026.11.11.12.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:04:07 -0800 (PST)
Date: Wed, 11 Nov 2026 12:04:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Juan Parrado <jparrado.1817@gmail.com>
Cc: linux-input@vger.kernel.org, Juan Parrado <jparrado1817@gmail.com>
Subject: Re: [PATCH v2] xpad.c: Add support for Hyperkin Xenon, Hori Taiko
 Controller DX, and 8BitDo M30
Message-ID: <avTKMfqo-fJr0vKu@google.com>
References: <avFwGwoJ45RGvxRH@google.com>
 <20261109102127.9417-1-jparrado1817@gmail.com>
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
In-Reply-To: <20261109102127.9417-1-jparrado1817@gmail.com>

On Mon, Nov 09, 2026 at 11:21:27AM +0100, Juan Parrado wrote:
> Add specific support to various controllers:
> - HORI Taiko Controller DX
> - 8BitDo M30 Wired Controller for Xbox
> - Hyperkin Xenon Controller
> 
> v2: Fixed format
> 
> Signed-off-by: Juan Parrado <jparrado1817@gmail.com>

Applied, thank you.

-- 
Dmitry
