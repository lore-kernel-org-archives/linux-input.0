Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460053;
	b=zY5XNVp7MQawHEmMxpFyNM301P7ytZFeN29uU0lQ1l1pYHM036RE7D9akED5A18jfrvV
	 bcA9b6TdDdNQrWgbOvISqJ0rlPaFibk6ZuIPKvxG8XnjwqRE0Ha4razRp9VLgxFthSZUM
	 MySbIoAdy8E0IXdz+DDZrfac3r8y/7VxmfWdUxhCndnIq4QZkTM9GiDQnB8rjoH10h4vW
	 ZobMM+ETGYEsaDJSXev8H3cSMdERqD+O5kfE1aZQZ6FBkB3GW0HYiXOQvzEcFMMHogbeV
	 SDW2Vwa/h8cy8Orp/0ulz9r2djNpxt8de26RrVlntHm6PaLi5rFVznU+h6r/r5z2cPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=Un0k2zq/NBWK8TpOG7W4o6jrkmU6EU/STMy7oHRK2yo=;
	b=VK8H8GArH94AvYcjQv06yF5CeuGOhiik272In5bkAGiYKKMI8y1LvJS2XkLY5Z7oD+JZ
	 RePx9l76o8JExof8z3449aUOGPgXWg/yebNqAU04WT8piKCtDGJ8nO7URnfe+kmsazgLw
	 NhQgvVBA4zNhpSCTrnA6vA8J62HAfNJCqM2dgoGhk8uHm3/mt6LGaLgCCvM07X+7tjqwB
	 9e4eX72u4B++U4HCcuAU1uamBQh4jHw503Iap/1M9tCbBtIKihej/3KlM73PeFydEHrKZ
	 ru6Cq3aSlVVOoX8/S0aMFqpaAVSctQmpgyImFUJMosimmzOrAoqcbjUgw5mXNjSamxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIpW11g2;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A7606A337
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 18:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 831A7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIpW11g2
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38587f3de36so4393998eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795460052; x=1796064852; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Un0k2zq/NBWK8TpOG7W4o6jrkmU6EU/STMy7oHRK2yo=;
        b=OIpW11g2gVzbasg136CCV/9dpq6CgBph+I2MQdPv4F2/U18tMPOXDpzI1VvMXYhx3e
         J6e9yGfIHO44UVaB0+NpVZ/A5Xd43MoKbGyvRA2zHncMw0PDdz1iEXjrT8TLCrUAr8yb
         j2NUHT2PcgPvZ2pYu+oXu7wizkHr8cq9dOQSenVNCzvFyMHr6ksUz43v1s7w1IwRVzI9
         JNVAVyZePccb8JKjgRLnP9yIo8zeM7YocIwJ1GX/q05OybH2sq9lIflcq1gHcma4V1c9
         gHVlx/x+u2+DKpJfupkcfAa07gE1Jo4IHLqpSuqWFG47SfMC3k3+tTvh2WgstdTXADeV
         yOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460052; x=1796064852;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Un0k2zq/NBWK8TpOG7W4o6jrkmU6EU/STMy7oHRK2yo=;
        b=VI+QkniGK2CRoEVTnMyc5zyebDqEQNnuZnS+mV2YxkBwYTAb13FKwq5AxYfUvlUfhi
         BTS33rhd5ch9G16nKYNGyP2w8uEhjZOBJlZJ6pRJVtPnOIxvXx7clEneU22iZ8XLbpaP
         bBU+N6LFUJGkOHrtDYXi687AB0ZCMF0NA9aFKUqsOwz2Za9FlvF+KkbgNNMDGw/R9o9t
         spMXsPAhTOyuaqYHJiE92B8bGyf5f6vVGVC+NR/rtTlCiwz8r8Oz1S6fs3U86/JYLw6P
         CCW01nK4Ck35wSecLRrf02EGBL2YIBKmYC9kENAvkxRmWdIQ8auz9H1uO9RYwYeGgywg
         c/FQ==
X-Forwarded-Encrypted: i=1; AL+hErHKeAWc0Jud2yH/jm3QGWCx6aotX03SmyD8kExxi82BbsbIsRRorBjiXzPxfq6wj5yvWd7xNC8Q78uJKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yXQ0HVAqt+LdHmXC7/fzStLkoaXt1llvpJdvNBMisOGwH7KW8
	YK8ksN0iCnBi1oXooFWjYOMSvyUae7tOcs4iRjm6+OlnGk/Sz3ZsH/C7FvDs2xHZ
X-Gm-Gg: AZFdTZep3G6GtFnRAEJk8RRlvi5YfVBN9B84jUYPjhCk4FM3vAuO9js5w03wHXinwyu
	CcU2RIdv/hp8vOqGprZwN2TC73EdzYi0yi4dEhKfodL+ckug1ti70b9p7LHAk+srH56GgqpiRNK
	VCHD2MTBy4PTC3K8md/6iYE8ahumtsw0Uj9BYMc+C1kIi0sToHhEhW7azxvJ5SA7FYPP4IZMTnk
	RHcJwgOJG5qXni3of/KHXD0GpTXvxA66fEiefI4USRHz1+lFWfRjMwqTT4VRdHi9r5KoeCdrzZ+
	2eSQQUSy3GJ7G52/wvKXb0z6cdpodTOvXYqoHhcrWWCRjXcX2MXNTWxtb08QCeRL+I5uRYphVbo
	A+xYi3+DIuLyznGUggy9KildDsdyX6Ff+8r4/GK/vBOc+4PG7I3+K/+Dmbt84UHFYiuZG9wHg8Z
	DbbKnaJEqjFgUEuuxzDo5FoaD/zkNygSscKv+bPno8aI6z4cWBlSexcZ+XzcjHgwLhC2dkJRMrM
	hwsplDrJnhgyks1+fh2/kM4jNuputpoG1E+X9ZXMED69CMuVEvONq1gqRt6MH2rId7OHZZbzm3t
	XTOsDbRQmbFtw/hpO2xZ8N/2bOZyoWZxsYGXYIT+L+xhuhlNqGu+tIMJTQ29bks873cejw==
X-Received: by 2002:a05:7301:d813:b0:386:8bd2:da35 with SMTP id 5a478bee46e88-3868bd2dbe9mr10377444eec.5.1795460052262;
        Mon, 23 Nov 2026 10:54:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567ea2cc5sm35609839eec.29.2026.11.23.10.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 10:54:11 -0800 (PST)
Date: Mon, 23 Nov 2026 10:54:10 -0800
Message-ID: <78d3f2f7715e3b66c06dcc7268966964@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wei Jie Law <98lawweijie@gmail.com>
Cc: andrew.smirnov@gmail.com,
	bentiss@kernel.org,
	e.velds@gmail.com,
	gideonheinz02@gmail.com,
	hadess@hadess.net,
	hansg@kernel.org,
	jikos@kernel.org,
	lains@riseup.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stuart.a.hayhurst@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 22/33] HID: logitech-hidpp: shut down G920 force feedback on input unregister
In-Reply-To: <20261119064303.274901-1-98lawweijie@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-22-30743e91d83b@gmail.com> <20261119064303.274901-1-98lawweijie@gmail.com>
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

Hi Wei Jie,

On Thu, Nov 19, 2026 at 02:43:02PM +0800, Wei Jie Law wrote:
...
> I was auditing some HID drivers and found this exact same use-after-free.
> My analysis agrees with yours, but I am replying as I think there is
> a stable-tree gap -- this patch does not have Cc: stable and your cover
> letter also only explicitly mentions the "first 14 patches". This UAF is
> worse than a crash and can lead to LPE if exploited.
...
> If you'd like, I already have a patch for stable trees that I can
> contribute. Let me know your thoughts, thanks!

I actually dropped this patch in v3 in favor of fixing the lifetime in
input core across all force-feedback drivers: see commit 2ae35f090d02
("Input: destroy force-feedback device on input unregistration") in
v7.4-rc4, which is marked for stable.

With input_ff_destroy() called from __input_unregister_device(),
hidpp_ff_destroy() runs synchronously during hidinput_disconnect() while
the driver and HID device state are still alive, so no G920-specific
stable workaround is needed.

2ae35f090d02 will apply cleanly to 7.3.y, and for 6.18.y and older LTS
trees (which do not have ef166ce08801 and ff->stop) it will just need a
trivial backport dropping the ff->stop removal hunks.

Thanks.

-- 
Dmitry
