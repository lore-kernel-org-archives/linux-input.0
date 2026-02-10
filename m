Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B592DA75A
	for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770704444; cv=none; b=I2IoBoHkTFFtJDtBjgA4EuBqNIAta7543kgRRllBA1hYMoCMREmi4t5I1uz7CIh9zKccVn3nH0dO6M14nVDlUsQpp9z/lqho2D8idgGuEGjAHmlWx0KU1LqpMiAIAiT9Xg6oIFM6azGdpnPNrsgH0B3fZ+pBsSlKul5IQI91/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770704444; c=relaxed/simple;
	bh=SEYG66B8ZtLuXgv2nsuhGS6fllKN1d8ENv7O1dAcJEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzL4qGUjqrbb+pXr5ZCG+Sx/L4NHVd7+W0nX6t3pwAlbMnOShsrad7ejs1FE/k1CUtLS86lEHBAOzq3Vm6fJawbDBMfghw853PIdizcHukMaoYGJZH72Azu0Xzi385ETh8X/QkqVJGDmxbtqno++mKDSzERh3n/ScHU/8KfL4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG40HT/Y; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG40HT/Y"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1270adc5121so554180c88.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 22:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770704442; x=1771309242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgWuwLpuwK0cTRarzf0Yohoxjvezc1aQian77BUVRlU=;
        b=VG40HT/Yo1xVlgykPCpuUNQAlmLtgOtlXBKB7lm53NlxtZ5B1aHn2wkMlZeg8+j+Od
         KcSNK+XfPXbv3wiCtz4cLFaCWstozCP9mesd413mVV5icmozgLBHbS29oFNQA5uTnkbw
         Mlw5I8r4cKDxfqrTGAMYM4/cWMwhA7yudYNtd8y7KZm73QaJ5M/i/pEElMTAMo7Bqwwj
         sAmJCg78yA28Y620ukaiODgphsMPaWy1bIc1VE3RT/ekw7qxjIRQ9c1igEukUZFDZm9w
         2DDTrtH3nK4SJHUUpZpzpnpckBAR5GUq16ElEffRIB/WsSaA+TqYzy5Y5wOcNyXTKlnE
         yDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770704442; x=1771309242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgWuwLpuwK0cTRarzf0Yohoxjvezc1aQian77BUVRlU=;
        b=YYsbCjIcelRwUPkRvfxQZIMqZB0u1jYsePSOI3QXZAetHVZ518DCoReywTptUAtivD
         lHfNOfN2Rp520TdyM43JczXYJMNXKmPtFISK9NemdbKK5e5rBexiHodNzOx4B+rcwp7s
         l7SZgTdgsjzbV4sYuIcEUrPXt6aXYUYnpssLMbp82HIoWwD1n/j/SsuXpLyjUc8aZjOy
         DJdLrDO84lQyO2CFYXeZMz5AbAymMx++sJFcUNmAyLJ+JBXH2Hlobn8IH6up6FLp/V2E
         pBEdVw/02XilPT/5dZjQWcXpUQzTcKpq/Sc4h8B/wgYBrgOIr+Ns3KtnF8ok4f6Mn5et
         gBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdd60pnfTiYPr13eH+gwO7K6AiGv7L46JJCs0po6joCkL2nXZ/E2meu2v31EfEDw0PUSdcDMJqMW1Fag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/7dvfMjen6G5dTJbMfAM92gNaCTekiRtOU7ArGbUEGWG5pxy
	uqOCR7rnM4+UCncux9lQi7xbCGt7LG5jlOwv8kb5oQHYr3q0jLSGNawq
X-Gm-Gg: AZuq6aJzlJXocDwbt52AAi8vBCm2Q7RTC+AodphmluKt8vkHk3/Uy9tbmH9hL9PSgkG
	N+fmQzqCTaCS8mJCDgJcmDyUVNX2K3TtNvTfXSKEMUrXRQLRy5s+3UAreRKENZSj4sYs8OnNevq
	PzT5NcPJ991dy2S08XJS4gDaephLekL2SmpViH57is+SVvNwssi0bx1S/pxKdjC7H7YzHkjcr+o
	OHSamODLq7P3oXGEdePjsyLLKD3/n60NSSBbib67PrDNXL3VuRzeMs1vxE4K3GcUKVzXzpWeO8u
	OOpH1w+1AQhfSFf4InJHufy+BSWdOO2cLW/E1E0lG3geNl8wEJI68Y2vH42sJYRCvWSezTxvyPk
	u/tJ0lyXC5mMRiBK4FwqDrRp/KLY/xQ22SGo9vghwhIL1j7zynTq1q+rwEn6lhb7VqaVJVRBBWE
	qpWIUk0tYNkqT33mVSQuy4M3sKpkqxh1zMjDoWdWkEU15u6eMAkUZe5dSr4pOfYkCt
X-Received: by 2002:a05:7022:2523:b0:119:e56b:98c1 with SMTP id a92af1059eb24-1270405d980mr5709422c88.40.1770704442142;
        Mon, 09 Feb 2026 22:20:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:616e:78a2:cc03:4be3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba89ae14c9sm887685eec.29.2026.02.09.22.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 22:20:41 -0800 (PST)
Date: Mon, 9 Feb 2026 22:20:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Courtney Cavin <courtney.cavin@sonymobile.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: input: qcom,pm8941-pwrkey: Document
 PMM8654AU
Message-ID: <aYrOMvIJdiaGHw9k@google.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-2-f944d87b9a93@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-add_pwrkey_and_resin-v2-2-f944d87b9a93@oss.qualcomm.com>

On Mon, Feb 09, 2026 at 06:53:37PM +0530, Rakesh Kota wrote:
> Add compatible strings for PMM8654AU power key and resin support.
> These blocks are compatible with PMK8350, so use that as the
> fallback.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>

Applied, thank you.

-- 
Dmitry
