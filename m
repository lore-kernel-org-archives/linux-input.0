Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D12F361E
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846099; cv=none; b=V1Pl2otegarUPPOkfs2PfieZXdqpyKAH4gGaoYoFH7NV1O/OW/QM/2+WydZcaiK3uvEHetFK6NQ387FLXQDHJGFBVxN1Uo2aGQJvQOcB/2Hr5fkpJMfcaIJ/U0UaQA6NJguKNkLkQEa5rBCXz8aezH+ixnxIJi2VMkatrPfPON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846099; c=relaxed/simple;
	bh=PwQS2roM7u1JRs8URNYjYhAgeauNxT5Yc1Lwb5UnGqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt6j5azb+gt2M/C9+yOshW9tcIRShhcVqP6YnUs926V0+jYdrySlVrFMOenPZRFZolNpW7UxL+wqrSIW0cb4U7YRRgkRmmk2Vs7qMp5gtLqJ5OVv8A2LUATsUtIz22VMofWg/I/WKE59f1F2W5yHxE6uKKDZZ3acaZtXIB0xIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8H3h/0b; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8H3h/0b"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so36615985eec.0
        for <linux-input@vger.kernel.org>; Tue, 26 May 2026 18:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846097; x=1780450897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uN5DfBzCdxgMtcbb6Yn1Crv8Mos2ktrmL1d0GO1AHx0=;
        b=k8H3h/0bfePOVCAqhgOz/KhJvHNlS07CBaB2t5Z7deGHy7PS7YAMEIpDiAl1mkmdZn
         CBDFE+PXTabHtacTVscpaVfmFXf0BVS9tJk9MNbJEmzGpPUhsxffcrzTxovHVctaSjAJ
         Blfz1pXVNQtsWiWat0sPgQtR8SkcamdEg2s4cnrynvDAy0wUehJAOshsbp5UnbKGutIg
         tbdKerZNSa1LII0A8TusPeLCGPAqls5n8i59hNq16Lo95mRJ4e3kwZL8SmiABgGEZY1M
         6HV8OSLvckEVZEnaAqCknSSrcE1TyuVBFYnQ/GHCTWrhjaQ2GU3BVf0AUQJCv9RPYjLT
         bvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846097; x=1780450897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN5DfBzCdxgMtcbb6Yn1Crv8Mos2ktrmL1d0GO1AHx0=;
        b=GlgFEzIhkVEY05oMyRAu8ouy4weaf8Rykdsw2K84L72UJ+ZhzOFe8jDimevoAFEAbU
         u43GIFXZCxmzzRBieMRSGQQ/DJkM3X9Y2ePICXENoH3vjU62xVA/Z9aFeOsvXUmOlZXl
         +dGvIa5u15rhfTxcJNIsFy4lidoaGCWRx2CD2irr4EGkL17bveVjTyw40KplLSkk+WlQ
         3DgNX37j+PieXagfI9e092U1RPgUA+k75yxp5wC09bWCbGeNCyspJO9ly2/ejLbD+6QY
         LkDe8b8kzMUPVIQo51khVP03/YJngj+QbAcjRXl+zX8WLWwortCrizOsi96redyzoGR0
         rXmA==
X-Gm-Message-State: AOJu0YzuUdpyLqUqhnypwsKVvT0QO3pGQi58B1xpD+W9zkaIvhEAkDMF
	jcMfIQuQoyhjyKHpGWaqGixkNFvulzWi0OK0SzYmFqLMlBsXpjjn3YUt
X-Gm-Gg: Acq92OHwG5RMVLh5fcT6hYwTI+Tv6bv6cQxSVdNKHYNs5yUfEo6rmog9X0bemXYLefj
	7DFts3UiUr0WdCcv/+Ke7vx40buMhhOuaCYXTWjnRbH0MppN+eYtGPweIZ4y5Qg/PzUKhN/pZBA
	d4kOPp3zmhWU7pF6AM4IJJXJiBU2JlH0u9C/n1f/PoFcYrpaPvqPsYz//MXLAt+ytyjG6xxJcWE
	Ycc2a0uRPFIsLEU40tlrEofiYHHvjZsuQ/ZCkQKcujNtEbDeezhtzUPiICgHZcpVE0JPo5KVc74
	htqbVjF3JAKfh3kj56SKLZru0YQ3AN4qPH5BusB6Scw/BLLmxZlrAW6sZsnRNmQszL1j9czPwWr
	VFVdRyQBrRRNsJjzuKgynMSqf0uXEzkAWudryvALidgsltiOW9kFtkJVP2ZJiVDTkgBw6Q+GY63
	AXZhW3ccWkNb2dK+BF14v4JuxIUpGWiDvzlLTqFSciFFpaVE26030d8hUZxf1WOJoWpgn/UKmNa
	cc=
X-Received: by 2002:a05:7300:4305:b0:2ef:1d11:18ae with SMTP id 5a478bee46e88-3044912c25amr9993942eec.28.1779846096801;
        Tue, 26 May 2026 18:41:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:912f:eb49:d713:7401])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304a57c04f8sm3258965eec.11.2026.05.26.18.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:36 -0700 (PDT)
Date: Tue, 26 May 2026 18:41:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] Input: mtk-pmic-keys - match loop with count
Message-ID: <ahZJ2Opc2K7WLZKF@google.com>
References: <20260527004543.22875-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527004543.22875-1-rosenp@gmail.com>

Hi Rosen,

On Tue, May 26, 2026 at 05:45:43PM -0700, Rosen Penev wrote:
> of_get_available_child_count is used along with
> for_each_child_of_node_scoped, which can cause a mismatch when keys have
> a disabled status.
> 
> If a disabled child node exists in the device tree alongside available ones,
> the loop could execute more times than the initial validation accounted for.
> This might increment the index variable past the allocated array bounds,
> leading to out-of-bounds accesses on irqnames[] and keys->keys[].
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index c78d9f6d97c4..5d4ebbafd276 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -363,7 +363,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	for_each_child_of_node_scoped(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>  		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
>  
>  		keys->keys[index].irq =

I think Sashiko correctly points out that this may result in incorrect
register data and interrupts being mapped to the keys (potentially
shifting them).

Maybe we should stop counting nodes separately, iterate over all of them
here and bail out with an error if we encounter more than 2 (does not
matter if they are marked available or not), and then skip not available
nodes? WDYT?

Thanks.

-- 
Dmitry
