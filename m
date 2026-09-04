Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BC4A3F25
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529608; cv=none; b=AqoVhLkrnFLoCqswe5idPvll149YlGMtbRkMSzwyk76KPt6avoQpMPOAk7j7VZmMcM13ImqdQtzGJH40dQ+oLOSBxZ9YObXt0lkQMo9U00BlWJT8IDgg644icn7z/XmLs+BBjPArTOsDFfvpYaibhdTpHtjgc8UbpPx74FpmaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529608; c=relaxed/simple;
	bh=VcKuCeSMQ4I5yw0ljiiq4L1snVizmWQm18XxRE0uO/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOLixvlirD9R68ZLNoMGKe5EkJ7and3Cun/7qtk3Gn79pgvq1sITv21ttzp3rWuceQA8vJmWH4/6bMdSI3u14C2wX7BsgYe/fjsNgtj9eMF7FfGLcFWEGqZk6BHGtuLACf1kxxuSQmZ1joKeQAL1q4R1TZwEPO75Hfa3ZqAoLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2IKQTFc; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2IKQTFc"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f6617c7536so590583a34.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788529605; x=1789134405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZTXMZGnnVv6fSvtGBrE1wHaAf9xygy4G9N0vOtIQdo=;
        b=e2IKQTFc3YbZN3ypwX5yUCc+DsU03AvtA4towAyv1iY7augKUcyGpi7zcej+n0gH/W
         YlKp0xM7ph4DcCy4t6ngtLpCXzKtxdoTMHVfgF6voqG43XDO6wRJM3LsWYyZpsTiGqT4
         RAN5Ydx02OQJ4YqPRZgYahO2LuNoSaSFRysLwn8STC8lEap+t64mKmgiyeC0uqL5kokT
         4JUvv05WFRn5DptkYllwqBn5utqH3zuhuhp40osprNWxNympUw1AjEsHCvIDO4o/dbQg
         8phcTYJLtsheIpLOizcR44HtHc4w/X6s2Uu/yh9lHSmrkRBYyYaeT6hAVNfUnrqf+T92
         cYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529605; x=1789134405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZTXMZGnnVv6fSvtGBrE1wHaAf9xygy4G9N0vOtIQdo=;
        b=q84s8GMKsd6BhTEDPO2v01tajRJB0LOCdWUmzaJAUZMrBL5vn7X7Pho6GXiCm9cXTr
         179ObTJAVJILghhtlS02fY4O8pmgdC/ZEgqm8jlDWCINdDCG67KRwZCfznnyAOeVmNuQ
         DkSs3mqF227T4u/uWFmXVf5+tRjyMJ0TgXarlI0mLieX5uUcaJC9JkuZNu3xJYBr20Xj
         +Qcp+cX32mc+3z8T2m6rqbhaMEqla2ggsApcfHHUy1KoUisaEfDQs1I5ELlomOieGDTB
         0wyHGD/0X7LPXrqTVp4hiIk0xtH2c3+WE51q011bh4fSoUnri7JDeMnJiHHM8dim3OSf
         xNXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxs0cawPo+xSyBTdDcan4pA95hiLRC6KDEcaiR2ezXP5mgfy28h3izg6ubJv+tv0MzDIKR5H9nTJE4ifQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kT4m+gTHlJtEVazBErfrD2c2khZMoyfZIvTM08JafZB5BzuwSo
	71lKPJdqtAWj/3KIkwSZXiUtEEPNPensz0wYMErT+v66/hpewJFxna8Z
X-Gm-Gg: AYBFou0t+W8huBsumjq01Gxa/wsRskXLMig/x23r9/Gk32O31Ni0Kd4RXx8FzyLhfTp
	ijOs6Agmk1ellvf8U8W5qX7CBYNm2xQ+FgCZoPVm2ONf4NvwOIgrYtg8r3iVwt833OYrUby/J6U
	GRze55jkfjeasv1pt0VFxpWChOR4HUJVgD7FjyicAulU9N05w4cNIf00NhnVxtj8K14UCkLFB91
	swpudCdne1DHzGkOQ+KQA8/ACbT5YCVNEicPzpkegd0Kd3iFKXnl4d1Cq1GWeyywlZd70NgCdoE
	yq3Szt3PH9EvBJ6do14bHLJJfgNlImTvJVzlIcgAmTV/3MHLhpngHW43wWinbOA9AUgE/I1Kmow
	5eIvqWCt48Tqhznq3o3vJwtxoYM/piRI8dWWRjp80XZqfpr3Xlj+9U4RvObF4zH/Vm/rCT5CdkT
	3c3IX6qrl/sTqC7p+z41Ckamykl6/JaMqcx9Wcwwgcj1TF8reASIeQ8iaiV5xKDXNqWwyI5dLAe
	IIReeMr1nEfjgzD3j67nswHk+YL
X-Received: by 2002:a05:6820:c86:b0:6b7:46e9:96f7 with SMTP id 006d021491bc7-6b746e9a200mr2294144eaf.39.1788529605201;
        Fri, 04 Sep 2026 06:46:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3ed6:cbf9:9a8:24d0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm7174899eec.5.2026.09.04.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:46:44 -0700 (PDT)
Date: Fri, 4 Sep 2026 06:46:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Russell King <linux@armlinux.org.uk>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v3 07/10] mfd: wm831x: support software nodes for DCDC
 regulators
Message-ID: <aprLYn4VzSTnZWuw@google.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260711-samsung-kp-v3-7-b2fcaba77aff@gmail.com>
 <0306eaba-b59c-4f8b-9151-9f39685398ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0306eaba-b59c-4f8b-9151-9f39685398ba@kernel.org>

On Fri, Sep 04, 2026 at 03:41:21PM +0200, Krzysztof Kozlowski wrote:
> On 12/07/2026 04:12, Dmitry Torokhov wrote:
> > Allow passing software nodes to wm831x DCDC regulators via PMIC platform
> > data. This is useful for non-DT/non-ACPI platforms that want to
> > associate device properties (like DVS GPIOs) with the regulator devices
> > using software nodes.
> > 
> > We add 'dcdc_swnodes' to the PMIC platform data 'struct wm831x_pdata' and
> > have the MFD core assign these software nodes to the buckv cells.
> > 
> > Assisted-by: Antigravity:gemini-3.5-flash
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/mfd/wm831x-core.c        | 47 ++++++++++++++++++++++++++++++----------
> >  include/linux/mfd/wm831x/pdata.h |  2 ++
> >  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> I still need Ack for this from Lee... and the problem is that you did
> not Cc him.

Hmm, indeed. not sure wheat happened...

> 
> Please resend everything or spin v4 with MFD maintainers included for
> acking.

Maybe you could take patches 1-6 now and then I'll continue with the
rest of cleanups?

Thanks.

-- 
Dmitry
