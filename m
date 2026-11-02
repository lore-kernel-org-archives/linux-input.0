Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589534;
	b=H/0gq4faBNR6f2+TJkHd/sq+5GnUVxxKOwPIvbWsonUhkWkIX78/wSadOJyZD9fSnmMZ
	 HxXCkH/uONZueR3Er6f38gUrZUJ271sgr4WPqZDgoWsUCi7x+DBpiM1y/vATjN5hJbQdP
	 Kp80sqlTAjABvtaAA+qlLtZcCGczobAJLTJAFEjDnH/3+l48RGF8x2HScAe74xuKsF20o
	 3JRSCtN0xzTffT1xeL6Y31oEQWrZ7GA21PCFk6rYStJoDpOrSijzgtXYFU91DWE97nKvo
	 Uc30+PrrJUKFFjAtsFMMGM1WIdDTq8rJtp59TAeOjF+Oofqbh4ZpSzqTHnvWeZhDK8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=nJCnzPlEYPTpiPpNwhFLsc1nTWFuyJzYXd5f4tSr6oQ=;
	b=LlT89tRt/zwc4NUVLZ2ID/jYitFxQx8oSORorzYzDTey5PanQTBvTuMvGATs/RV/t5pv
	 tsgQR07LWEzkDRF8hT7FZc72gCqpin0WQ1q7pMmtSieo339ra/D/BJzfdJVYU1RvKBRWk
	 Y9B82078FITK5OjEv49VXDpZ3/TvFHv+UQLTL0hrabG4K6PzCcPW7ZYRhJTO7a624O58H
	 gR7a5VQTxz9PTpCOoniWyQEuL+EwBUCLqcW+YHlMEFACMtCTEsoAdbSoJtTbigmFRcY+2
	 NAoGiXbEN5RC87OfBQLOUl8flT1EGEY/MNUrtPplfeku20rFiXJHZ28XOzbfcwURb3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzdV9ohT;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34601606A327
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 03:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34601606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzdV9ohT
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so3838639eec.0
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 19:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793589533; x=1794194333; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJCnzPlEYPTpiPpNwhFLsc1nTWFuyJzYXd5f4tSr6oQ=;
        b=HzdV9ohTmNFyqmLLsDCqmODyoy6Sx31mv0ijemiLjdQg7hHw0X40I2CBE+mz0w6uWC
         aNYtC6Yu5CBBGxnEVhvE/Y4P6wEZVejk2WgvWSIhziXfRTXvLOnmEUo9UxTr7iP4XE/3
         2eEplDFJDBFyraV/0AW3CWGNlYcrVqQIpT2k2nOGcHrMMk5JghogbQjvZYX+UKpoAakp
         Y1Cxg2O0X+lnxVEt7t0wL7ZtoESdT4GuM4+mampJwV4M+gY1pIlnVR9DJfvSBaw9QIpW
         NQcWRXEroXcZLMc6vUr7ZvMWPYeFlup5uPOXrbCj0dmNQE52XCFrdmOQbDZhTClfxJTa
         y+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793589533; x=1794194333;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJCnzPlEYPTpiPpNwhFLsc1nTWFuyJzYXd5f4tSr6oQ=;
        b=tClLd2MMtGFZnMP5RdMA4FihVsby7v4M/9gsJafIzYKkxhyZR5zZerxAlsE+BmmENd
         RJNUqAcuk8kPBsUmc7iizd1y//KTqIPCZ9bp70NGx2mMEM762KkWo4/ADa+uqB+4wRmK
         wEQoOI2pQvF4+pmS53j0jJO7ssPQibaeFxKavCc1+gG1WRhBGlJH2uRrL2j6ilElIgyy
         lLRft/FIsJItUaRcPw8BlVuvSMjEjt3dvXn2EJyAFIiPSyRZwcHj/73xUJ1jEuHq8nfA
         AFmkDeJepokbxRJnExGCXZXLj63WDjE5aPicypO03K/D6jssY2IaGLyEnJZTW4Bdh0Jw
         GN+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwRSnqvQMvth5nSf9GSizrONGtbqn4+V40OPLsouK9smNxgXSMQTQmJLYjnEmtuCdSDg0MXvjzr/MUTVA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/iNZXlXfMCMVTuu3GGf+LEeRlOuioiHoXQ/i2u96Nl+UqsbrW5
	NOmN4mhOkv6hmpyjRGsmm2QSL4wdh8JNsDnt5/BSuiRapmpI7pTkMhL9
X-Gm-Gg: AYBFou2+8BOkQRdvBLnXUpWtQuzpsV1dgowIew/6e4RPl4Bj0OVB07T8yo1oaP2nmbc
	M6FYl8U7MvGEYq+i3ox3xrJP28w4H+s4cu59QaoMtYuda1yjN95LMX/SyIvnZkRB3HnihDPhfGK
	ilXmfJtkM2Jd9sCAFArIbNMLaE7Rkb3IMNVvIty20WSs5YNlWS+/LCpjYvo90oJeyF4y8VJ+ZtU
	VoDVA6Dm8rW8KkDUVrvup+ORkjTXZrj4Gmpr3H8YzuZmomx4FOweU4njTIbFFrAogtfBjYUFsBI
	e4EHHgRsnFmYDaMTr7jKzNY1oU0P3KHaLz5b9spT9IpI7K7RV4iYjyEaz2XFTIOTJSyFTKQFqiE
	gcyhRWvBFPyWUlry7C9cX57UOmn2wIqOBjFH4Lu5SOoZ/5rsOvWy3U1D09G15dgmmWSAQgGmD8/
	DaL5X32FLmr975EDd8VbXZSOS5+TsRpHpxwhda0E3doiuWfJr584tACjCImDc85F8zZwuzb+Myx
	2vFo52ScUWiG+4vp4/tf+pZ2YURUuylK12fvGlj1TK+NzRPdc8VoWoR2IFknhQEwR56bSn5jFOA
	hgjr1ZDlPjUTsv6Q9ZWZZy/ooWneftl2Ft/Jk5AFeaw+JKs65JIh/KXZhvd5hfOJifm+6eI=
X-Received: by 2002:a05:693c:20d0:20b0:36a:112d:fae3 with SMTP id 5a478bee46e88-36a42435927mr13964731eec.40.1793589533040;
        Sun, 01 Nov 2026 19:18:53 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:d75c:a9d8:6c00:c5c6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm33411882eec.24.2026.11.01.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 19:18:52 -0800 (PST)
Date: Sun, 01 Nov 2026 19:18:51 -0800
Message-ID: <4590302cb7f26ea6173018f5d7083977@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Petr Hodina <petr.hodina@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	phone-devel@vger.kernel.org,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v8 0/5] Input: support for STM FTS5
In-Reply-To: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
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

Hi David,

On Fri, Sep 25, 2026 at 11:22:18PM +0200, David Heidelberg wrote:
> Used on various phones. Minimal viable driver.
>
> Includes device-tree enabling touchscreen on Pixel 3.
> Also, tested on Xiaomi Mi 8 (device-tree is not yet inside the mainline).

I applied patches 1 through 4 (leaving patch 5/5 for the Qualcomm SoC
tree) with a few small adjustments folded in:

 - In patch 1/5, added a missing trailing newline to the reset timeout
   error message and fixed a typo in the comment in stmfts_power_on().
 - In patch 3/5, wrapped "const: st,stmfts5" under "contains:" in the
   allOf condition so the check keeps working if a fallback compatible
   is added later.
 - In patch 4/5:
   - moved ABS_MT_TOOL_TYPE setup from stmfts_setup_input() to
     stmfts5_setup_input() since FTS4 does not report tool types;
   - dropped the undocumented "stylus-enabled" property check so stylus
     contacts unconditionally report MT_TOOL_PEN;
   - checked X and Y resolutions independently before applying the
     10 units/mm fallback;
   - added a check for !sdata->ops in stmfts_probe();
   - fixed the GPIO name in the "mode-switch" error message and a couple
     of minor comment/log formatting nits.

I will also send out a few separate follow-up patches shortly: one
teaching touchscreen_parse_properties() to parse touchscreen-x-mm and
touchscreen-y-mm directly so drivers do not have to open-code resolution
handling, plus a few fixes in stmfts (not aborting FIFO parsing early on
non-touch events, validating the 4-bit slot ID against
STMFTS_MAX_FINGERS, and switching coordinate reporting to
touchscreen_report_pos() so axis inversion and swapping properties are
honored).

Thanks.

-- 
Dmitry
