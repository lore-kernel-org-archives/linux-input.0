Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA2352C54
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453532; cv=none; b=KxlAba1c1mVMcwJ8Q3Pe9im1rLTQp29eLYOCKlWazNh2vCXIamuWRb4qQDOUp6Otp7P0EKxKuppM90QTzvUfRGF0YPMYqw27Lv1bYcYbtdumT1f45ADttGYS1rSs8bc1Q6BhXywdBQmZQQNlKEy++qjQ5A/G7EcU5gdPkSxgoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453532; c=relaxed/simple;
	bh=UQDsMPCcAMgsOmMelDpxlk1dtnw15PoU7ODWqDB8cI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwbeO2FJsmbHHIaPx+n7xSvweK43Xhpth3onyYtSFN6sNpzsBs/VUci7KnqTH26LQ1D61VVBgDxm5wyMP3pvQS/oR10V085gYNHYezG0e6BrrA1t0QsAKrL8GMs4mZgN/hszjB0nfWcegCDOLlN4ZNR5ltHOH2mVMNo6Ja23cuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwDFnuQu; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwDFnuQu"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304e6c6464dso2113253eec.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780453530; x=1781058330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEFK1C6syKES+KOJB0d6AfPdbHmWanh+azd/cROxIt4=;
        b=gwDFnuQu9DSRNOq9bGT4SiTJhctFg94oungqXQL194KMg6OBZK+uAiGjJv0yyX+48M
         qUNxQ2rYgM4k0Xsa/2Q2IUjID92vz5QDXN8tEXoYWAhRDtuf311rviwcfCzlIpGMgdDi
         7DTn2XGuDFbfHYFiZ8/vUhgsqlgH2qW6tKxDGaxmRPNog2wvukr1Xh6tEgN2xBFcoD6c
         wQgSL3prDltRhofsq57V7IOQ/Bxbb8iKiUKyDQwkotiKAPVIHr9Pq+QF3aGLZy8/ORcA
         3Lt0C6tKdAloz9vBDH9A2+V7crkwxWvWkHdbOvjhNRnI5OR6uPBn1yG4s1mSh8eodNo4
         6hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780453530; x=1781058330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEFK1C6syKES+KOJB0d6AfPdbHmWanh+azd/cROxIt4=;
        b=IB2VyKi6M2SoR/TM5scQfEDl6bXOFdmW8zX0uA41eVf5VNEOai/sgVovyD+QPkrJYk
         RFQyZjNd+B+OdB3awysNjqqAdAQ7xiz7JDtcqsylTB2E77QnpKm34qCK0/uHQfgWp2aI
         kwNOxg+/9P+yVrfIz1nk4OjytmD1lr5tBg/2eQKbbkOp0F2JFbz6M1rYeS5ln2GVjxQF
         pVsWp94MSwWDIEn/iNS0LqBETZsWsjQak76d2pR4STm0QWpWvowsc53vqSi/p61SSlg0
         0iVuMwRps2nsBi1/bnXSRj22Xjd3FsSM/b57birA7UZmLeXzgzeyZobqboUcs6yRXMpd
         oCCA==
X-Forwarded-Encrypted: i=1; AFNElJ+8lQ43d8qYzqg0ZuARMl5eew/bzLeaQHHd36QwG9h27MsgZcUMpwuXoVWkn+4E0NOngSe5lBFMzakZaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUD17oa1vCkTo1ppHniON/NS/x77x2RumcvMyksTpwdz0Num4s
	102FTdBqT75m6f2h1y0S2+088OFdjXb9CV6mv7UMqPfWiiPZWbzt8hyI
X-Gm-Gg: Acq92OGTCXLQIIOYuSzTbJY76CjPBCL3mp/3fHBGCPvmao/QdTu6iCtQHnFwHlS9y/I
	nO5NvEOWS4GVi2SxYVO8qDOWLqPnLKPFugSBv/27An/8HwqxZnCGGjh/1y5KffO49EHCmNJ12ut
	T+YRm88SHax9ZafoAkKGviHTh9+O5lkHU3HktN+67sNCLTPvMOXHj23ozIdO19A67J9lqdutBJd
	Z3SmKgsrIbiJBgqyvNt4/YswHTeeY79IDRx8T05b6e88hESImil1Nr6oFbKODtmVaxpRnAVqBve
	JRh0eJYgh1H2PIOd3E0wH4FDSY/XsGrLiXxwRffNiQe4oa/zRon71IEmYoQKkcfGm0RsQsBVs7/
	wiLEqdG9ulPzn8MkEM+aKgsjqO4hkjPwkcifNcNzJvlvoUm/duVxxtk1OvEh7aRT9saUu2oWwgo
	sDQNfSGWtrmvUaqffgWmeMpgRsXZW8SdrJVTXRGYOxap7fx4aIrJhf9xjUKYJZNB6F7e/bvw14y
	HHPxOpVYqSxjQ==
X-Received: by 2002:a05:693c:25c4:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-3074fa52073mr730991eec.5.1780453530279;
        Tue, 02 Jun 2026 19:25:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c4f4:520b:1304:b259])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8708sm1184972eec.15.2026.06.02.19.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:25:29 -0700 (PDT)
Date: Tue, 2 Jun 2026 19:25:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: steven <steven@joint-cloud.com>
Cc: wens@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: axp20x-pek - add support for AXP313A variant
Message-ID: <ah-QII3kV5WK4haF@google.com>
References: <tencent_48A497E0CA81323CFB6C7CB84428019A8707@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_48A497E0CA81323CFB6C7CB84428019A8707@qq.com>

On Wed, Jun 03, 2026 at 09:38:54AM +0800, steven wrote:
> Add power button support for the AXP313A PMIC. The AXP313A does not
> have the PEK_KEY register (0x36) used to configure startup and shutdown
> timings, unlike AXP20X and AXP221. Create a dedicated axp313a_info
> configuration with NULL time tables to prevent regmap out-of-bounds
> access.
> 
> The sysfs attributes (startup/shutdown) will return -EOPNOTSUPP when
> accessed on AXP313A devices.
> 
> Signed-off-by: steven <steven@joint-cloud.com>
> ---
> Changes in v2:
> - Fixed regmap out-of-bounds access issue reported by Sashiko AI
> - Created dedicated axp313a_info with NULL time tables
> - Added NULL pointer checks to prevent crashes
> - AXP313A lacks PEK_KEY (0x36) per datasheet verification
> - Power button still functional using hardware default timings
> 
> v1: https://lore.kernel.org/all/tencent_5F1FF80489E702360F352F889570656BF608@qq.com/
> ---
>  drivers/input/misc/axp20x-pek.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index d4e2fc9a937f..de43eef0c0ea 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -85,6 +85,13 @@ static const struct axp20x_info axp221_info = {
>  	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
>  };
>  
> +static const struct axp20x_info axp313a_info = {
> +	.startup_time = NULL,
> +	.startup_mask = 0,
> +	.shutdown_time = NULL,
> +	.shutdown_mask = 0,
> +};
> +
>  static ssize_t axp20x_show_attr(struct device *dev,
>  				const struct axp20x_time *time,
>  				unsigned int mask, char *buf)
> @@ -93,6 +100,9 @@ static ssize_t axp20x_show_attr(struct device *dev,
>  	unsigned int val;
>  	int ret, i;
>  
> +	if (!time)
> +		return -EOPNOTSUPP;


Use is_visible to control whether attributes are accessible.

Thanks.

-- 
Dmitry
