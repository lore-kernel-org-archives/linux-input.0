Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704456;
	b=dxYGDOME6Eh0gJg0iB3za34Oa0JBkn3jtBjies3ap64w0+yGwElCWOfd5Wq5Tm2MeucR
	 lasC8tYcct7sGHGxXWnrqS7XFtBphCfFfLE4rrifNKrCHE3kI1hOM/6SPyd43SpLOzmpJ
	 FkG17GWUHcEeK7bb6m1RMGXyn6+mSf940pT3RWTFq/y23hDt/maJXgpdLRHHNxtUbqaIM
	 gLX7Hzcwvq48BgeSvZDlkxnXLJthkAsrjPeoHkbooHszmguZDb02vggOmwd9yPE94TXXy
	 8kkJZ3qNF0NKVhSKo9v37pKzJQ5PO5KnV7H8KFOZLM2wLMUfajBerA3s6B/zohlWqdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=EdcFkvlYEQTUe2xyZF84HiqIh2Jl9FgkeGFnGMB6FU8=;
	b=2P0Hieocu36dW+fM3B2abJPgbg2xLV88m8YBc1c0Efur+hI3owvzsk+rkCCPCGOR84ap
	 GC0Hul7p85JbViodMrI9i/+p9FJo0SK8CGNC8zS4NqxZAPzwZR6TEk2wVx/X5enTJwtB4
	 8hTtrJHwLfSRnjaf9rf4TPDabmrel8QVp8H+hCVJ7la4ZINNMPdNKPeWCl7RLIj+S2F0C
	 0gaaFUvVOPmQ+4djkDlVCGX8btvrEPVcAd6TWH8EO8eUyMGS/888Y9ohxrbVXBOvcI/Da
	 nFvmU2cEso8+ScfpII6x1zJF1lsPEtQ/8qqnkPUv6+VH2pC1pMJdQ8LEECJJeCYY6Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=himpRJe7;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82473606A32E
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 11:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82473606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=himpRJe7
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so2411918a91.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 03:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793704456; x=1794309256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdcFkvlYEQTUe2xyZF84HiqIh2Jl9FgkeGFnGMB6FU8=;
        b=himpRJe7+N557J3VLmX6Vm7SkksD9LfVzftUfjevHROZ+D4yKn5D9hJDG1tn1GI8AH
         IjKGH9PvxGMjdcYtoBxutna+fh4hVMh3zRk/BZTaES+hDJup2WUHD6ru+SXJq0T+EFLa
         hQI3bccTMbPc/Sh0TtexXPtslx9elk1IwvInG9ZkDKN0WUQWFAHAxAFcv9ohkza0wnBP
         f8HRHYmGh70lfVvjuf9fJqdaksswIdlw+tCIxcSGnlHU4+L4Fn8GdR5YMy2UEkd/gG4W
         40uNpJ16SaNbF4sUeGhgqg2siHLuBique+pNTqkv3eqJXwRTKpwwxW60CPLYgeUkDH/h
         mhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704456; x=1794309256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EdcFkvlYEQTUe2xyZF84HiqIh2Jl9FgkeGFnGMB6FU8=;
        b=mLJSXO7EiJUgc3yH7XkkcbgBV2yBza7klBLquLrOfBEquzcVS0dsBNmcBgnhOsJm2q
         iqFmBb0ESyJJJCW2cGi4lmp9NFeNcsad+xhn3pDBQHY7KNaCT/lEyiuZB2xcbmF8rdAv
         q95zGfzAMYR4650fRgvxkv1aY+I1d34a/fYz39LaaEwx2+Z9fLxXYV1wZZn42Ez9csWp
         Sqs7Gyjq1hcAvRMWK9e2Z630VTC//uLyZJNe5PMSJXmXnccBVry2cFf0BXMyyK4AXg4U
         2H93lFPtlSYhYK1vgn/Ag3I8Pjiy0ygFB49H4HaaI54nU7PW/PY92MPOAtdcIHGcDK9F
         1jRA==
X-Gm-Message-State: APuU4Z/5u0nQOD+tsacwj0B5KjCycbhYBk6acNdEqWN8FW0JK8bXzoRJ
	jUFdexA5ql/wMjlVxg8ulvrOkJZemZk5RnA6+jcBUfNklbKmuus8Gum8
X-Gm-Gg: AYBFou0cEDKKv/+rbcqBfrwGJO8Zj20dySnNggI6FFTjF7Yt/BbAcB+VACRvhfah6jB
	2Eeojdr992V0c6hlunhwp8TnHHfEPPIVPd6tC4huTc3OHqwuXhwOJaAjNj/5al3201zy0+o/F7o
	DODDehp/JCa7KtO6JVsI1Ubjk1dSSWYXsemvjpd323WTLLyD2NJpCAFLHy2n75HnIx6iddM/lgC
	KHbS2IB52ctV8IvB3zwHhDGuQZxAso0BY3CApRGBBs53BA0T/offos2TvFgMw0XzZ4GpKX8qi2a
	E8A+5p6/IXZrRQN3ypWyLZtRV3/mgd+jxvYapQyusfXgHs25xUSkipyg3yaP6wzmOnR3bcILJDv
	gDww9Wg3ARFMr7Mp3pfefCcb0quWki+9y/+eWoTPRQ/uDWOP2UIjhHS6/3BU5LaBSFImxf3LMFt
	LUNe+BM6Y6RrAeTQ10xVxUY6yKcQ1EAIqPZ0Nr05wLKQGnAbQxXdJqsViaISuAyesYlR+cCCwTx
	713/pfEm3fzsd0fzOURiCAfM7QbottLwce9cG9hhXN1XexRwe5M+6h8NscXp+JCo7gZj7e1R92u
	eqIfk2TjjONtlyGDWfPn5vb01VzMuCoZ8z6q7AslSt3UFXFI8wEJjc9aoIyw7iAe
X-Received: by 2002:a17:90b:1b0f:b0:3ac:a5ff:2cc3 with SMTP id 98e67ed59e1d1-3ae8957d4f8mr10933586a91.8.1793704455819;
        Tue, 03 Nov 2026 03:14:15 -0800 (PST)
Received: from eggarch ([2409:40c4:f9:fb9d:212d:53ce:9917:b4aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f662basm9070787a91.1.2026.11.03.03.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:14:15 -0800 (PST)
Date: Tue, 3 Nov 2026 16:44:08 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Eduardo Henrique Teixeira <ehstbr@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [BUG] ThinkPad T490 Synaptics TM3471-020 input lag and missed
 taps with SMBus/RMI4
Message-ID: <aum7W7Q7GLVOwgec@eggarch>
References: <CAASp5sxDHbnSyaRZE4D2BrkZU2XTuLU9R+3mZ0=K00NK+gWMug@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASp5sxDHbnSyaRZE4D2BrkZU2XTuLU9R+3mZ0=K00NK+gWMug@mail.gmail.com>

On Tue, Nov 03, 2026 at 04:07:48AM +0000, Eduardo Henrique Teixeira wrote:
> Regarding your questions, I can confirm that the problem persists after
> both warm boots (restarting the laptop) and cold boots (completely shutting
> it down and powering it back on). I haven’t noticed any significant
> difference between these scenarios.
> 
> 
> At first, I suspected some kind of electromagnetic interference or a
> hardware-related issue with the power supply. I even tested a brand-new,
> genuine Lenovo charger that I had kept as a spare, but the behavior
> remained unchanged.
> 
> I believe my initial impression was influenced by how I normally use the
> laptop. I rarely use its built-in touchpad while charging because, at home,
> I usually connect the laptop to a docking station with an external keyboard
> and mouse.
> 
> However, after performing additional tests, I confirmed that the issue
> occurs consistently both while charging and while running on battery power.

Okay, thanks for testing.

> I understand that the original reporter confirmed InterTouch was working
> correctly on their device, so perhaps there is some hardware or firmware
> variation between T490 units that would explain the different results.
> 
> I haven’t yet tested disabling runtime power management specifically, but I
> can perform that test if it would help further investigate the issue.
>

I can't think of any other reason why this only breaks on your machine.
Things look same between the original report and yours.
Maybe Dmitry would have any idea what could cause an issue like this.

Could you also test with runtime PM disabled while rmi4 debug enabled?
(boot via rmi_core.debug_flags=1)
Wonder if the device is getting suspended between touches which might
explain the lag.

Regards,
Lovekesh
