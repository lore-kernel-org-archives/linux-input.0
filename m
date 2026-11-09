Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207919;
	b=OwCZlRJLSoRvyYRmjIngJ518jAvLR0828jN98zqMegXvZN9X0qVhltZ2K+CZUz/nERYY
	 6Bb2lBK6vmXaoudTW6kIJ4pfjUHwJqQsPwnTemvAU5dyveRDJFHLW6oxQW2vkGPikw6l0
	 gwPY12DauWDuiiBp414Ysz8E+xMbVQqKggCsJ4JRy2kBE3N1HCdEoYd/b/yudsAp+wtj6
	 CncI7/IjrtqwTLFdLzCXamHfF5sABSbs3ESjIj4IczK7zMOHKHOW0017/9hCN2obg1AIB
	 Cd+NY+vJzndsdxUvYuLWDPSz433FLtaLVwNhjA954GSqdOtTlzoO/lisZlAP07SZaUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=78AHM0eWQcECUUXYNy5GCd5KtV2VlLS3AoOx+2YvwDg=;
	b=OxfRjijxMJF7O89B2rgC2+NmNcgHytSWoLTkuqrAfRF/hN6VycpSB7WdCPHTLYeQXw07
	 lwXsirlXQ5UpUQdPH39CcJvV2iWTwx9YXtJ+WbFuFv/9M8PEFm1H8RrUAQEXyCj66gsmI
	 0623rtLF7NuQEOtJfefiPxx4tZiWLcVbZy4WBmY2aOp6WkH322UYr7AR/7BSzFYsEhLyK
	 2V+RxQ3G0lmR9YY2Cm8PYeCcRFJN0UrIeTdLXuOTZ81wT75tMk2VTZoQsdG2MqRS4m3ro
	 uuGoBiW5nUcxC5LEWd79uCB/v2d/UlVBFQg/1M9XNBi04tOHnMfMm3A/NtqgsmWS9mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqoL0y6+;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701ED606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 701ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqoL0y6+
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so611242c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207918; x=1794812718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78AHM0eWQcECUUXYNy5GCd5KtV2VlLS3AoOx+2YvwDg=;
        b=UqoL0y6+R+/1sn9BOeneQyCLbjf1I/wFn967LHemkR5iyeU825+Ze0n2BNEg0/4x5F
         pyHu83063E37xvcMo75oCV/XWe7qCk8q9L1Jz+B0kXwvbsL3ovdpG6PbisOATW0Zl8j+
         gVHfqoJOundl9yBLbJVNMDNZop1S4J8AH1oMu9gBnxU1gaYCyCqeYTzgNYmSmeQptT3D
         fiKl/HBQNX2SIIzkjfQbXig5HcZcOak4l3on7All4M0Jll5jwRWVCPgyAXaSXDtlkHhq
         iPO8hV/Ju/BCwoAd0XBP5YntNG//imHz+yPR/eaAXtDWQUiB3iVtoqt5nsPrekXfPjmX
         ykTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207918; x=1794812718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78AHM0eWQcECUUXYNy5GCd5KtV2VlLS3AoOx+2YvwDg=;
        b=i1kLu42ozhj5BnFXPKINXX70VBpFHX0TnJ1waj2RAY861eWYozd5StL2NYSPBzijCr
         f5+4wKf2D8JoANT3/JJAGf7Idw7GwgiTStam0KVF0p6wrd323ij5765YQiIIbtzBDsIW
         iG49RGtnE/l0Mba7jzGirSwSLlytjCbwcPIRDVlnXazX09l5BQuP7kuqZzUnKcG5eshm
         pUU4DRArpAGvm7nSK9Dike4p9ANbsH73MxEjT7SmJ+4nw5EElJfki7aSQEDf7N4sMPtp
         ZWiexHQpYlOCuWH4Aj4XT/RBgCsAaR1l5t40F+h3p4UmSePPfcabzhJLE0Q5/K1t2iQF
         iVbQ==
X-Forwarded-Encrypted: i=1; AL+hErFq4HfbA5fGnXQlAa9wYY4U8nk6puGuRfO+VvKx01V2OBKrHkVJECV7BTL0vUXPA/wxqsuf8t1Hke0sJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+r6wlSPvs52kvSnChouAvlEV3jreVxGV0opYfhAqAMbqSlRHjz
	+IW/FQcW37udblg3YCyYocw2ZUDtddEIcu00AeBHYJHsfHtmJ427MahV
X-Gm-Gg: AYBFou0s89bvugihNJyBXpr3TmRhJGi4To+rIj4TbgHm4rmuCpmBLqdbzkAtaz76UgU
	qFcmNCAObjGiYloIwvB4WaEgSpzlUKwspIppg/77kA+nr/3/oyxcS9m/Xpxkn9Q477ZixlmQrrD
	AlB7Teua3EJeRt6HMiGCdraOEd7P81bRSRaqLrkVhwb8QcmApfTfdPRmdVmi+MHXbVHqp1xCxMT
	jphBIGybaj3WWyrJ36lDvFgBRsXCKsxxGTB6IPQpKefuWBUZtYnWRVgIWbzaqLkS0x0UOj1PcEI
	O7QgUC50c173PHhZOjmo8TInz2THokSTmb18LYA4TPr1q6QHPg91F1Zn3eQbGiUkCb1pRDcKNvi
	B8io3QQHdpUIEWA9faHHcYcMxQWrcrLOHsIVjPn+IIDD2WGlLd/nQ1hgH+O8ELJwmSPBZHI2bZd
	G0xN5NBJmE6iASOm5mIiR7ptAvQU94IYeY4/iprcQemwYFhXfPtT9bzKNDudRWRYSM3bcRtXiex
	Va1kH9M1B4cpuxqnpeKadGxkgchyk1fwP4C3CQYnw5aJ+JmdtHPggQsG4D1G4aNBdgC5698hkv0
	vVN7nrOp4JajbeTeaQXPDRJu661XvC39NsU+m6+DX3wZI2ImjbU+4GAjp7ITpSPe7pHn
X-Received: by 2002:a05:701b:4211:20b0:1a4:9eaa:d01d with SMTP id a92af1059eb24-1b39ff16f25mr5285894c88.45.1794207918345;
        Sun, 08 Nov 2026 23:05:18 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771fa200sm10317466c88.22.2026.11.08.23.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:05:17 -0800 (PST)
Date: Sun, 8 Nov 2026 23:05:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: bartosz.golaszewski@oss.qualcomm.com, arnd@arndb.de, 
	marco.crivellari@suse.com, tony@atomide.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org
Subject: Re: [PATCH v2] Input: gpio-keys - do not BUG() on requested wakeirqs
Message-ID: <avFwp6UA9QN43geY@google.com>
References: <20261107104807.54410-1-andreas@kemnade.info>
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
In-Reply-To: <20261107104807.54410-1-andreas@kemnade.info>

On Sat, Nov 07, 2026 at 11:48:07AM +0100, Andreas Kemnade wrote:
> Having the IRQ handler called when enabled IRQs arrive should be considered
> as a feature not as a bug. So do not BUG() there when this happens.
> Also BUG() is too harsh here.
> 
> Fixes: 3717194f24922 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thank you.

-- 
Dmitry
