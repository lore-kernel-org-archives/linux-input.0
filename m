Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211776;
	b=SeOGKwtcTIwBaf80LrqoXJI4+rdhxNHqgQvJ2l0UHYewFdKiAgskUSCxtlZC3/thuyXX
	 QFh4JqEbM6gd0tPl6VgQnVISFbsyNJEjMVnaXlGjGT6joHToeWPwMjt2HabfGZe9VSmdp
	 W3ex5TzCJitrquhprSillmaZ/tZyGO533V9uhSxBC3AQwsMLTYbDFlrnSlBjteFA//hDK
	 lzyRJTFA9D7ALagoPoFxfyjIlfpFMcH8YKANewV9RSwiw1NFr7npSi7hrIb88rJ2/E00v
	 o4E7VeX9GIZVIJrDEZQpLnuA9Q5VuiwZmE8gzsL/nTQYpKdqTlKPEnSnQaepiU3gXjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=JsDKGMOU9swp0GAHJV/6e1W8mjoZhe2ZCwScsI7P9n0=;
	b=mMntkZw40cyAtoNgUjn2AvSE8cVB9XUDOH85LIumozqcyCwr2HMHudWR7xMpU2CeTofH
	 FOcBK8gI/4guuOm5WMlPUmuRnAZC/jXdtZuYVFyF6EMGBH8yG5nSwEI7n1GU6D1Mi39ls
	 Cc2rtg9xoeVJPK1lhExgaVJcG6HW2SYVlI7xZ3LXyoVIMf3NB5f6FOD8GMJbDIskNdMe3
	 Dq+ldSv9yZ4o6bR+LA9fDNU6+ZlzU+mNwzkchtD+zKybZyt06qFn2V0QPZ4v4qMtrHH9v
	 BUP6vcKXH1yp5GWy9k6039BceVhjdy4zgkbhQwR3Lc9Yo/n1/sAtgc2Epb0Q2yYzsmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vsJMeHUs;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036D606A338
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 08:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6036D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vsJMeHUs
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fb88ea38cso817488eec.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 00:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211775; x=1794816575; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JsDKGMOU9swp0GAHJV/6e1W8mjoZhe2ZCwScsI7P9n0=;
        b=vsJMeHUsuLmuwRFGQWjqexyf0lMs+FFMbp3YzxktWX9Z7Hfi6YU9iNvv99NilaFmcx
         xXZHfM2uVf0gfScXZEPRmTsPR3HA2Kypv3FxakX8i6MaX7QobwzarLkVMb5mpJcsL2/O
         36mMZm/x8VV9jOsWP4EKWkW3PqNh6LwEYAcY8iwXDDLu5tuH7e4IFIzYxOiG7ATzUeSG
         Pf6bpFOpzZ+47UMY2JH8+Vmn7MWhPq2EFybf6Ymu2SNTcUfCaY4XpOv40hnz8qbKrAiX
         gvFPjcCmSohdpDRIK2GPMUPUXhHYK2j0wnWNkDq8MqTkKsNv0c1MyzdPjck7tTFoA2ER
         RhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211775; x=1794816575;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JsDKGMOU9swp0GAHJV/6e1W8mjoZhe2ZCwScsI7P9n0=;
        b=zdVGBb0AAjdjU/CAgzL1S/EZdSPVJj+fy15i9yl5q9RiFz8s3A7zFAVD+p9qh2+YnC
         Mk/a56ErTyPyIPMycImJrgvHw0GuIijzLYUxIV7PJ0fHCER7u98LVNVYDv4OSF3aEwIe
         LI7QWMk515j48sEC4+O9pvKcQ/tzsgIt3Cq/WNHHxSWVDuP8btt/tuQYJAb4RJp1Uc+m
         9GIsfwuHLmrOWdYJDtLDozI3MtNl+HALbLS/w9v6mvmpIjkySnhQl8JAhZCNbnYQmDpe
         t87HpVPp97wsBwTkP5ujQmH/wvD3ziwXoIWBNLlH2XvOWw/CkNRsMFzMxWL9Zu1eA1Gl
         Hycg==
X-Forwarded-Encrypted: i=1; AL+hErGVcZgXkmGexzCDqgdlzBYIDjBLAbcMG28wPNffOsxil4WKVBZxr0FSSPjMG9A/Xuu78U2HLRbfQsL1cA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dyZqSRUOLnjoBFvTVx97Ch4XcAAwcAl+hLMGyl7/W8/qTcte8
	Cb3PYDiKpXgG57SEHKrCnOcRABzq7+Ks2t10NZcZU/Xr6FHzdxA2pK74
X-Gm-Gg: AYBFou0JEiBQhKgP230W1UCDOPqNk2eoQ9T1VcJ9EW6OkvSDXfKj45F9FuwCNAsfnw2
	a6t/pMc4TgXURbN6t/xW6eUfLrEa00H+xntR8JtwPwuKqWPTm4WaUm3D+AdehvCg+eoI/YKDIZ5
	G9g9akEYeX/BmweAJE82N+K1gbC8EqH91qBsNeR/tkJio+dlq5PZHe3BP/bw6IYK4hf6kCFvMx2
	zoiakfsEwVMp2DlOEwkRHHjhgd86IzByF348Sk56wEn6T9rBldIFm9mxzjfIdhsToEOYjwFgQza
	a3Q3L5c0bOTvy7QSEACK2ehEAqoyY/wfNn1pA9z779Xu11dLkJJa45PTKWLLw/qcES0nArohRkS
	40Fw/83GVam4NbNqB2oLX4ohg6V9qaQWVxfxzELR7Ev4vyPt3dZHT6S1T9tL7S1otJLWvsU0ZDE
	739eXWUstK80xOvqJP6SGrZESi+ZMIzSmaPxW9loLQ0IBKOSj5kiih81iw8vBqvG6EsX6j0vQYm
	QKSwzx8IYJK4I3F+v+7W39B+ghUqauI7tJ0In9XaYErmIcSn48FMoskTUK9SL/IqzJODwQZ4iFQ
	88lSLpLBYygZdBBRiuxfxZlJaF2uMpZQgZa24f5Fh36nLgJNAIIGMeElFUdl/2ReryRm
X-Received: by 2002:a05:7022:408b:b0:1a3:cbd7:1269 with SMTP id a92af1059eb24-1b39fedb95cmr5006800c88.23.1794211775040;
        Mon, 09 Nov 2026 00:09:35 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375728f8bsm10241765c88.15.2026.11.09.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:09:34 -0800 (PST)
Date: Mon, 09 Nov 2026 00:09:33 -0800
Message-ID: <e9cf3745ebc09bf04ce0bf75b67a31f0@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-input@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Input: apm-power - Rename to apm-power-input
In-Reply-To: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>
References: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>
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

Hi Nathan,

On Mon, Nov 09, 2026 at 01:25:26AM -0500, Nathan Chancellor wrote:
> When scripts/modules-check.sh is fixed to normalize the module's name
> like name-fix-token does in scripts/Makefile.lib before checking that it
> is unique [1], there is an error due to drivers/input/apm-power.ko and
> drivers/power/supply/apm_power.ko having the same module name.
...
> Rename drivers/input/apm-power.c to apm-power-input.c to make the module
> name unique and clear up the error.
...
> We would like to take [1] for 7.5 in kbuild-next, so we would appreciate
> an ack to take this directly or a stable branch that we can pull in.

drivers/input/apm-power.c only reacts to EV_PWR/KEY_SUSPEND input events
to queue APM_USER_SUSPEND via APM emulation. The only in-tree users that
generate those events are the legacy Sharp Zaurus ARM machines
(spitz/borzoi/akita on PXA alongside SHARPSL_PM, and collie on SA1100
via locomokbd). None of them were converted to Device Tree, both
mach-pxa board files and mach-sa1100 were marked deprecated in 7.3, and
Arnd (added to Cc) already has their removal queued up for 7.5 after
holding it back from 7.4 LTS:

https://lore.kernel.org/r/e4da2f9d-d3b9-4267-9b64-b0f2cb43402a@app.fastmail.com

None of the remaining ARM platforms or other APM_EMULATION targets emit
EV_PWR input events or enable CONFIG_INPUT_APMPOWER (and pxa_defconfig
already dropped CONFIG_PXA_SHARPSL in commit cc7852314abd, leaving
CONFIG_INPUT_APMPOWER inert there).

Since you are targeting 7.5 for the modules-check change anyway, let's
just drop drivers/input/apm-power.c altogether instead of renaming a
module whose last users are going away in the same cycle. I will send
out a removal patch shortly, and either you can take it directly through
kbuild-next or I can put it on an immutable branch for you to pull.

Thanks.

-- 
Dmitry
