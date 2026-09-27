Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C864137B2
	for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531906; cv=pass; b=AHM6vgD75hNseAUs8Zt7t30N7fZ+4q0TNmMXSvylSHBkqFba28cZ+CQVsn7Ipd4VLkvql+508LcjP/ETEFLToiyXM3Vjg9eFUDEscm/ZgWxVMRvVL3VWOfh8mIXq5Bg+L+LQaV3pW9JYlPm3zkZ6+HYysj0+tpbhAIn78f5+Dz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531906; c=relaxed/simple;
	bh=58tJxFbKkk1sOLpFFVR1wuJU8CunIqKhr3qdPmvFPJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEbV7kUUzUd//T1R9iAwpD4ngCP77+BL0LcAq1b6B5TauMeexG6LolcF2Z+O03mmoLPk9iMRPsZC2EtOoVUwQhAgufqSp5NCSWLZALSvqLEJfrJgvc/VJXwBBh0j03a7jui46X3QuLwC4dwuWjQZ0CiVKRCvTZduHyl9E4MImRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyACfRHq; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyACfRHq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so13589685e9.0
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 10:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790531903; cv=none;
        d=google.com; s=arc-20260327;
        b=Pbgfd1Zwb9r8ByFm9OO9V/o/roxAMR1cwEBW8kHEGmsK4miaVqMeaLBTLNSMJNyF4j
         EHS0H+au9rw/ucyjD6Fu+wFPDD9vgsWEikGPqcOoEthG3lexqGoa8dfCcmuzrm732Ago
         IioLBy+mN2hpXnt4Cnd72XuzGH4azHeHKbZWPkTRF1YZqoHYuIe+6Tx29Nym64CA+o8Z
         CNlq279jS12sscuN2IlLWTC1QdO/ZmJ6VCv/A+0PBS/KqcLHZaWjAfB9QZM43KX/tatL
         GFXTmk7kLEaXBwQz8VfeFs14IrVAtX9dEYVRArDXmCSHvyPV0YjhcqzrFQOM+TsVB+2t
         Ibbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=58tJxFbKkk1sOLpFFVR1wuJU8CunIqKhr3qdPmvFPJM=;
        fh=ezIfHKjbh0Gdi6PwCrWGQ2kwnqA/+Rnrh4zhFlzlZIQ=;
        b=SiRakxzfx9ll/TyXvL3N5MrE8qrhlbBW4NZL6SuRECV1wQQvPqewswV2XEp49DtrLg
         NF0auLcN8l0j02X/Dn/3tILu7NO/dw7NOnQqN7p8aF+7zjTxlsChCwvtKEnu84xPYApS
         f6QcOdRjBy64l+tWVXonghFQ86GwbMfrbbC6FZHS8WpbpL2A1NneBtypx6s2hk8lciJz
         +S7XuJ+ZF4pV2VPDMFOFAe4Lk9dpbx6cMmvD41dCacH8Dm4u+fJNnCcgPxvINfPBYiGV
         jniv743xITbXlScvDA2MUQVg8VxkM+1ZqyyOpXW5M3AtHcxBy50WZ65PJusF2CO455rM
         Rc0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531903; x=1791136703; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58tJxFbKkk1sOLpFFVR1wuJU8CunIqKhr3qdPmvFPJM=;
        b=dyACfRHqswA25Mqq2a05IftLMvPfwMdQB/ifFWZL4xPxiwI7dXyQX8yjygE0rRq+JM
         6lHc3Jsv4ymUSDl1cNDAnh+WThV+htWVitQQuzz6dn5ndbL699sw20iyYk6sZt19k93u
         sIo4W6T9s06bExNpZUNIupxwWTBnW6l8B2ZQNa474gYC6xiJ8uNXwMaPOHN7j/h649DI
         l3Uf2POvxdipnHDTTcLjWoVZTR2EojaXHDa4rKQgocqzQJ1Ws/Ftkm8UQBL7g5YQkb4p
         3NSwY4V3X6s+lgSQ5Wjf4J47Oq9t7An7OEy1ChE+lIKT8kOVj6FaFHoYr+s+6EozyE4d
         jzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531903; x=1791136703;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=58tJxFbKkk1sOLpFFVR1wuJU8CunIqKhr3qdPmvFPJM=;
        b=hv8m0gwbCadOv+Hn2Kyv7uLOnxQ5FTrRIGCCVwxZCtFeK0JZEyhBO8yseRkAYKiGkB
         EMbMglJK8Rf0/RhEwFriRmf5xSbtjKmNwNEgY0p/ZnHd2JYweHPEus+BKxXKyqIvsOHN
         2+b2vt08NfsQ5uvvtKJ+ixtno04hVuk6U2jTJUNZDjlVWSROzzAQPUsSlS/E75UwFjrP
         wrlNQD8PQ5qjourkokf0Qa+izoRq4LEvZQhj1qUO6bZlxL1XuUgl9NGAYn9DFMhCSb2N
         x/jzez04vo4wl20SKJSZlw4kTQUEbAm/mfc4HHAeUdQUoWHa7jTi2Ea+WZ4wV5/ZAHAg
         sQDw==
X-Forwarded-Encrypted: i=1; AKwUvBxWxIDZvbTdrbnNFi8Xk/NaykEokfA/G2sXA9Hj4Ws35TeKJmnUwmNRIISbrGDtd7cEYyucSqlzBGbeQQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m++oEZKAiajmKQcPDv625xyZ+Gy7gPHW+5gYK2mc7WkPP3PEKt
	u+7REvfjMpfw1pv7rImFq5lETWKZStVyDjcJIqp/u+Or4EAmSHaE9KZvoz0rCfKBj/mmpTu5kmg
	Iiy8lNcZ2QBOPlUF5xfoK1gkBrDX+Phw=
X-Gm-Gg: AYBFou1eZXor7tpp5KHGLL5G7yJaDSvpJkfPbcz8ZxH4mTPHhz7vdIvJi8cflDytVkb
	ylw9gdf0eARkvm5SzJECVEQtsEo5AoNcfnwG/Vg1i+4ThiJw0i6JTrPlJBI0G1Dw9XTpKV34Xvr
	xc7TaTmLSoT03bUTJVyVQqbM031VRCaM7+KKEDfxqYovtv2H17nOn/k8k9CVrz6GmPaCoQ/GnDx
	/DVznq/Kzb5KGt7NUu3Tb0eVE65G2c6iP8Iz/LRES+iwAjxF0fGt4HUKIdD7UyaBXFgShTaGRxx
	gQURbf9H2Cra1dpmYgfLAEGTpF1jcZ4sYeqCFQ/YnQ61tDYMybnf4pY17yfPhivODJhfiAzXDvW
	M4VcU87tevyk=
X-Received: by 2002:a05:600c:a4c:b0:49c:fa20:cc08 with SMTP id
 5b1f17b1804b1-49fe67060cemr197513905e9.31.1790531902934; Sun, 27 Sep 2026
 10:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927114425.442803-1-pooyan.azadparvar@gmail.com> <CADqcGB=Jfg-=UoTnFJRv=+=RoKX4LhCz7sr4TVPS7F4_xG=WhA@mail.gmail.com>
In-Reply-To: <CADqcGB=Jfg-=UoTnFJRv=+=RoKX4LhCz7sr4TVPS7F4_xG=WhA@mail.gmail.com>
From: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Date: Sun, 27 Sep 2026 19:58:11 +0200
X-Gm-Features: AclHuK87o0NFVmvvliTRvyOdHaWVG3mXQo78bllcHq76p8p2EN535aWHnrz1FBI
Message-ID: <CANC3H+J9oRGP142sBL6BXzaiMsw_phQJZqDDAEgU6u3s4Dt21w@mail.gmail.com>
Subject: Re: [PATCH] Input: raydium_i2c_ts - validate report parameters
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Herlangga Maulani <w1zardsec@proton.me>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Muhammad,

Thanks for the review.

There is no per-packet touch count in the IRQ path; it uses
report_size / contact_size. Those values are validated by the query,
including the RM_MAX_TOUCH_NUM limit.

The resize is safe too: query happens before requesting the IRQ at
probe, or with the IRQ disabled during firmware update/resume.
disable_irq() waits for a running threaded handler to finish.

Thanks,
Pooyan
