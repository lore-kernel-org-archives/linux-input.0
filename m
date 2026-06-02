Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14ED3E9C37
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413218; cv=none; b=BMT3+hRo2CQCB7qXz1I9mtmsxo3k3IBBbpMEzWo0hj2SdsTt9halZxFtbwL7nkZEa6+qTbn+xW/prfrdQzbBnAFt1tSuNVAs9YpbX/F8WhJhe4oCbZ3vAgm/kfb9z16X/dyzKaip89MP4dYxb8xDh4ZqsKpvLhI1KcdYJyd+eKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413218; c=relaxed/simple;
	bh=uIoxNG/ylBOK4Md2Y1TKewK40SltRXwOuLYlZ4lHLRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eamFDEP/B2NtplLaZx0FjB5d+lW6sehRPLTYtrfcRQxB3bFjgQ7/a8E84MgbaTH3kgbHgtdbJ2sdLewuSF09Z4QUtAOsYSfqOdUI2FkZy05UCeF7PR22yeD+584foCjulqd8sHLKaml8IWDlEqqGFNFAAe6n72XOneIwGkAqZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emUYCpzT; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emUYCpzT"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso7554975e9.3
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413215; x=1781018015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7SDYY2MPZQ+JtNCaxiWzC7XvRzNl6Gx9eXMUcPLE5Q=;
        b=emUYCpzTHW6lIvzXU+p3AzszTMR43mp6Bz5nHPI6jCbRbbgKrkv2lMabMHFgCWfja1
         trqZNuQGkTnqZ74Qtn5bLVLWgTEuGA0au+6iFIgD37AM9RzC/GRiNm4ON7zj6I9sFrdU
         vpl9hGcUcyMmNjURrJUBJ4wsmue9X2cATjVSPRUGbQ1kGVj8sCixbfdJMryUGHTRpZn1
         +Nf1ZNPBzEokNob/LiHJvZXgxR8GweriWHf9HjRnCgjjiq9wfWw8nyroYB73Q+GMVcEJ
         PCNqA4qyh/TLSnSlF5ptKv4uVqPqS2NsjCCdNf/jaLCsnUnKIEE3+vtoDS9MwuQ7r76C
         kf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413215; x=1781018015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7SDYY2MPZQ+JtNCaxiWzC7XvRzNl6Gx9eXMUcPLE5Q=;
        b=o5joy2NFI6/26K7m5W+2EtLAY/JWeQqkq+LXxd2KmhEfL482qiRL6mC4y4jo1JMA6r
         jlnu8Oj4Y9D1znKqfML13f68iEjFNhDiyD7nMmLk2W6R4gIqZyGc7cBUsVvM7BHulNxk
         Vm8cXdbXYkOKHUKGbolmwkwCgQZo1cNPiZLQNlaHZn+yPblruDf4uJtCjCd0TQFfqf/P
         LmUq3lrrgcQhKyo0H1WXlWiX/3aSQ3QjWJa0hhEWFrewC8tT4InTC4dGUcF6L6fOmrDA
         JkrqWfCUvmhsdYzbVC+QcPqN2AQhZd+Rcqm2WQi/p8QsDw/i3GtMVuKK2uGqJjyavwNF
         Ig6g==
X-Forwarded-Encrypted: i=1; AFNElJ/l4cG/z2s2Uhbf5nprNS5Fzol4e4IinHuSLKq35WL6tkpeItAxHL4KAuPUatyn15KpYj+WYKBlFwsCoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRrz9nLhUltShcqLEQYlxTefAySCaGZ8tKPhouNhuFxxO8xXX
	haJGd9D3HpNKfT3tI+Pmib51TibHYO5SgFIcdxc1fPrtMReHpeXG6Em+
X-Gm-Gg: Acq92OGQbIkDUbXJBOtRwWZcjAS4zfQjvu4sc+zjIDcF0R50eZblT+hW6rCGF8wqiu5
	wB67D6huSE3vkSjF/OTcDrqn1/XFGvznjKtLtP+U3ZmbLqgvT4oByRo4sL60KIB3Ezw0XHrV00A
	0rzr8nqsx3eU3LgVlG5H/7MpLFaXrAK+4AsoYaka4r1pEQk4fmmcoOYNQHsoLrZgMjb1IjQHjwk
	6fyAmGme4CLGgJG1aSFb3VG3H92jWwqWkUyadSO5j04VwGo7Kr04HAwIpiciZ+9V9VBBjGQ37XK
	7nxjn5hIC83LMTXjqsWBVEKAAv2r0W6LFOQZGAYTSMrRTbmzHYZIbXUfM2piapp0hAXugkIKCGe
	ybCyvnslaAezDaSTb3nqMN+407JJFP/wviYcI04bxk5UToOfR1HDi0ha9NK1mm/d/HxNMKnHt3v
	3H+GFR7EQGYFIgHHeC/ym75CTV3534S29d6nEiyCLVfnOEh0HgcI/9sLFwF08IlW7Qmw==
X-Received: by 2002:a05:600c:3552:b0:490:958c:46dc with SMTP id 5b1f17b1804b1-490b50928e4mr2308925e9.17.1780413214999;
        Tue, 02 Jun 2026 08:13:34 -0700 (PDT)
Received: from machine (host-176-37-220-32.b025.la.net.ua. [176.37.220.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm43539336f8f.32.2026.06.02.08.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:13:34 -0700 (PDT)
From: d3z <d3z.the.dev@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: "Danny D ." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	abhishektamboli9@gmail.com,
	sakari.ailus@linux.intel.com
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume
Date: Tue,  2 Jun 2026 18:13:15 +0300
Message-ID: <20260602151317.27768-1-d3z.the.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <IA1PR11MB60985A7B3D9EA4583C2DDBF7F4122@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com> <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com> <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com> <20260601213047.115271-1-d3z.the.dev@gmail.com> <IA1PR11MB60985A7B3D9EA4583C2DDBF7F4122@IA1PR11MB6098.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danny D. <d3z.the.dev@gmail.com>

Hi Even,

Good way to split it - "touch IC off" vs "THC power-gated" - so I ran the
reset_tic()-only test you asked for.

I added just reset_tic() to a pristine quickspi_resume(), with none of the
THC reconfig (no thc_spi_*_config, no thc_ltr_*). On the Surface Pro 10,
after an s2idle suspend/resume, the touchscreen does NOT come back - so
reset_tic() alone isn't enough here.

The interesting bit is why. The one new line on resume is:

    intel_quickspi 0000:00:10.0: THC interrupt already unquiesce

That's reset_tic() -> thc_interrupt_quiesce(dev, false) finding
DEVINT_QUIESCE_EN already clear - even though quickspi_suspend() set it in
suspend. thc_regmap is REGCACHE_NONE, so that's the real register, not a
cached value. So the THC port-control state we wrote in suspend is gone
after resume.

That's your second case: the THC itself loses its register context across
s2idle, without ever hitting PM_SUSPEND_MEM. reset_tic()'s SPI exchange
then runs against a THC whose I/O address and read/write config are wiped,
so the reset never completes. Reprogramming those first (like
quickspi_restore(), and like v2 on the no-wake path) is what brings touch
and pen back.

So on the SP10 both are needed - reset the touch IC AND reconfigure the
THC - the full reconfigure looks necessary here.

One note on the log: there's no fresh "Wait RESET_RESPONSE timeout" line
this cycle, but that path is dev_err_once() and the box had ~12h uptime, so
an earlier cycle likely already consumed it.

Thanks,
Danny
