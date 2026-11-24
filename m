Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495774;
	b=SbqMEt1UG8qAP+IW4QpeFHYl74/+aMlyFhPQB8NDCIFxWrE6Zxiks5PFhHkrnjXiEVNm
	 RVK1eNZ8P0HSzejJYDo61RnRhZ/UylI13H1/8a3kgVDwjkm5DA9dGjiV/d7zxTYaSiY7X
	 v1AdCV6nFMv8iW/YSctCSBRPt9Pb9pNayvs00AjT0/IXdDNd6OMo0ZnwtaCbH2DAUCr6L
	 C9fLAfxTGhpSshMKcFa5r7BX7iN8TtUfYwuLu9V6HDbNevHm7i7LTYGuaEcHUtvRpkccw
	 qF0kqyQ3lQbJe5g11xLxVFl/xcvoVXHDiRJGJ390iExYIUP42n0PcTFszKq/GJgZYMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=q2AtCKrcnRowgK9UMYU4R00JyvBBzeu6djBwCY8oBcw=;
	b=b+h2E8i4+4nYUnM/SLkKEDh7AU4Ej2I2iZWss5FIr6d84FVnIeGhY5VwYLEG8Wt7szJb
	 qEbSdigMcnz9JymdgRVHoY/fSa2OOOylaGnH2o2yZGFDkxVJwJoUurY3kYoWzeMwEr271
	 L9VurW+I4v5wLcsCkESryevlmfTICv39cp7zn+8/cmzn5ekmRzZdww+Z94nFdFsF00jq+
	 iy5C3AcbXvIbJDdm0HlBZ+D0+0caorHIiRbHctV8khx6caYDtp/ciuKBvGUlmfql3ptNW
	 wqylhhNNukErm7waut0BSDsdus8UgpltCK3/fA9RO4vJWX6oCuvsEWlck9+AwRUIYww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T16l0T0G;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 838A1606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 04:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 838A1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T16l0T0G
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3866a784546so5301261eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795495774; x=1796100574; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q2AtCKrcnRowgK9UMYU4R00JyvBBzeu6djBwCY8oBcw=;
        b=T16l0T0GKicmhbZqRU168+261kQqzq5E0ht5XNJJoCO0QQhpcTXbyhHAMZk8Dv+kdS
         Zgx2o2KdXpllzpKV/tDJvD9CSZOSS2Xtuh0nJqQfHth0cjymilkWeV9ugO1W3Xu/uim5
         VJXX794Aawd6Xh9OYL6YaxqC0oNXD03VnrfMpm3mhrkFKTu0SypT3Sjp6UCj3CxbB5T7
         GTnjHpPwMH+iC/Wcop7g+dDTwv3m66TBh80+D0l+WLVQXmqwtolbLZL/9kCT5WnHkkGf
         j7AtHdSBeVSPmf8qpOvjjtYSe8HmP2NPTfBa9PjseyDIs9aKp7x+iUpxvHw7vdEUDW5f
         OYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795495774; x=1796100574;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q2AtCKrcnRowgK9UMYU4R00JyvBBzeu6djBwCY8oBcw=;
        b=fEvTziNYY0lYoZQhXQ13fmsV6/x/uVcb78TntWxKSPnZeamnJJKCKbLG7yDsx+bRtu
         /QPNyFxWsCvkI/Va252ymKgg5b68rif5H0bId67bSawt4RINCWXGHzVSzWyereiiXmSQ
         LncQSR9tS8DQfoxpJdgDK4+FICgnw70TV4saIxOurbHrdKMFdm70k2R18XkSCdkoGGy4
         4tw/3VS3mTBQbv4nk8veR+KCWVxC0r2PsuBbrxc0F8d/QgvwGRRPf1Tyl5iPk428WmVD
         XIwmvmT36U0JX+oiCjs1SXwmheMOYEw+SSHZaDtZ8ttMVj9zODL0YlHO35qTt/814HXp
         Wlww==
X-Forwarded-Encrypted: i=1; AL+hErEnjgIuDvjAfOFv6uVJBVrAEQuV4MO9oySPc2KBMD8rX8Aiks4V917A0P22OvRyzbO1YkmmdPGyE85pPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9kGH4pXmFNsp6L73d97PwKejfxb7MGcMsrF8YZEmItoP5SmB0s
	s+cdhDNGB7nCwREQNpr4YcjrgGBgfi1RqaQuXhRvWtCz6SxHdTm/s+UH
X-Gm-Gg: AZFdTZci+F/zTXfs/0YUddNV0ITEg20kUowOsEVNQqfwxhbK80wOv1yq15W2z6RFGbu
	mRwfKnXQ4/WkgGvybTL9mofBdig+RbGklduK7xm4QDiGDvKtiyNCU08lgHP6OYGjplBHKTWeEfS
	Nozu8360mTceUPZfR7IDc0BSG8PH5tTYIpEz7sAWx5t3X7yx9K2/2NqQxpydpRuCiUDf9m8N6nI
	f7U7mGbl1nYkSyy9F1Vr5UtnshuVw0e8cPhq5fA/laKbanfUj5alHYrLEDtno6+ODFB1/ww4Svx
	07Bisd9ifi1v3nHt/OICd8vcJ5omFttRPwlYswGKbuKUdLLMCXGPUjv94LcrJEeAIdIBfKyHJLE
	O33XoGEQIDr33OxXaZqZkpVZutrmZ023Ol60GwTOXcwuwsHxRt46ImczS9/WaEK3Vk96oOYwINi
	0vqoWcUxhYhPLMzP1jat/JH/mtk6MXsF40ZojhVaz7xXy/KYLeQgyBXm4SjcfCDzQkor3UfPTOy
	ThypSk1sMehJN8/uMfY+3nT+XF2E81Nhq190pCaRIjR0HWkw81mxX6KWOOpLzhSaArgNBUDqokh
	86ndsmYtBgJXcbWaJaYOkd3thGFXlrt0UMMVNvI9NCGfJsp7RiGfFmgoSm/Bz8xbjAw58TmBqer
	6YLh+MiVr05VLZ38=
X-Received: by 2002:a05:7301:7004:b0:386:c5b8:960b with SMTP id 5a478bee46e88-386c5b89f9emr166158eec.17.1795495773579;
        Mon, 23 Nov 2026 20:49:33 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm37247605eec.13.2026.11.23.20.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:49:32 -0800 (PST)
Date: Mon, 23 Nov 2026 20:49:31 -0800
Message-ID: <3e575d6e2eb90d4a3707319d37134c1a@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pooyan Azad <pooyan.azadparvar@gmail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Herlangga Maulani <w1zardsec@proton.me>,
	Rob Herring <robh@kernel.org>,
	Jeffrey Lin <jeffrey.lin@rad-ic.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Input: raydium_i2c_ts report handling fixes
In-Reply-To: <cover.1790612085.git.pooyan.azadparvar@gmail.com>
References: <20260927114425.442803-1-pooyan.azadparvar@gmail.com> <cover.1790612085.git.pooyan.azadparvar@gmail.com>
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

Hi Pooyan,

On Mon, Sep 28, 2026 at 06:26:15PM +0200, Pooyan Azad wrote:
...
> Patch 2 resizes an existing report buffer when a firmware update changes the
> packet size. Patch 3 moves the initial allocation to the main firmware query
> so devices can remain usable for recovery when they probe in bootloader mode.

There is a teardown ordering issue with using devm_krealloc() in patches 2
and 3.

When a device probes in bootloader mode, ts->report_data has no devres
entry before devm_request_threaded_irq() is called: in patch 2,
devm_kmalloc() with size 0 returns ZERO_SIZE_PTR without calling
devres_add(), and in patch 3, ts->report_data is NULL. When a later
firmware update transitions the controller to main mode and runs
raydium_i2c_query_ts_info(), devm_krealloc() takes its ZERO_OR_NULL_PTR()
fallback to devm_kmalloc() and appends the buffer to the devres list after
the IRQ. On driver unbind, devres releases resources in reverse order,
freeing ts->report_data before free_irq() runs while raydium_i2c_irq() can
still execute.

I do not think we need dynamic allocation for the report buffer at all.
Since pkg_size is a u8 (at most 255 bytes) and raydium_i2c_read() uses
ordinary i2c_transfer() rather than DMA-safe buffers, we can simply embed
"u8 report_data[U8_MAX];" in struct raydium_data. That eliminates the
separate devres allocation, avoids -ENOMEM during firmware updates and
ZERO_SIZE_PTR/NULL handling in bootloader mode, and guarantees the buffer
outlives the IRQ. Patches 2 and 3 then collapse into a single patch
keeping local staging of info/report parameters in
raydium_i2c_query_ts_info() and switching report_data to a fixed-size
array.

While looking at bootloader recovery, note that raydium_i2c_fw_update()
also unconditionally sets ts->boot_mode = RAYDIUM_TS_MAIN even if
raydium_i2c_initialize() returns 0 after seeing RAYDIUM_TS_BLDR, which
can leave contact_size at 0 after a bootloader-mode probe.

Thanks.

-- 
Dmitry
