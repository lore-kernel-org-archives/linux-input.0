Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986624;
	b=qK6Kfyjuiyt9QWo8z6zG9B9UpWB93kcWxNbea+lyDuD04F9K7Y+Huw4vYWa6+oycFO48
	 Z9pet4NLPPxjPY2Pj3P0SeIzkn2RJJO2nvX+ArGtkAv1Rhxo3E11UxyePDl2CChQPFR7h
	 cwdAk+aauFNm78oS6SQ80Im6q4RH1smWGp4UUavxRjx55W/xWRooad7qIs3NyU6xGzzpV
	 mV4tWUeZ3Vj2xJO3zahUbAD79J0+Eutn3qxfcuZ37mIS6CPaV25BR2ahL10i5csfajfqC
	 E7lSDisMcLxlfKT629ZvCrf5l5k8yvD89RlZrIFKM3vmKwZ8SfMrdvvKUY6cubNBRzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5bCjFCftZY+2sQA45xJDozhTjhcUphJevAvIJETfdPY=;
	b=lCho7KyqGiarpb0+mp8MIvQCzFSP5ygVgOuOFP3u1fKKK7N5IYrio+08IeKEr23x3Gc0
	 i5f7JUyrGqW03vMvBhQ4+tXZcCMbqM0PJDhL+x/Ps1ZnPQw45LhkAYdYmv5ONPj23Ynze
	 zhb+3hq9+IVmTBKosO3rrYr8hQmDR82hxLt4WlqS5/l/C2JFupAUIH4H01A1Bh4XzR4Na
	 Cc+9HG2UwzA5/wvjwcTq3l1e4wPoiZBHsAF1YRhXy0FpaIossOPCg867am09wMWqEp8oF
	 k90GpK81ER4oC7g5EsPooeZAisnaXUeEbKDUFG9KqCwD9ziAlu8TVp1qn0mkg92CjhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncubXofL;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F716606A334
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 17:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F716606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncubXofL
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so565750a91.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793986623; x=1794591423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bCjFCftZY+2sQA45xJDozhTjhcUphJevAvIJETfdPY=;
        b=ncubXofLpiA0x6STkrCaCodfzBpBsbyhIUCMKNiTmOtnlNrL0bt5hLRYEeMt4CxwQN
         LjZCs4CB7KiYhuZl4jWzyp6tpfuEqfIHL64au3kYvAsJglY2bYlaU3UA6Z7uQ8c7X5Ry
         /BF54dVhGkKw3UOQGhVFKsBNzZ5x9toSqcXi+O/jy3qrzh9QRsr1fnUp/E9Th4h95RNZ
         qil1lIy9FrHndIaOpY2ZX9AW0PndYKMmf94wm9kztxaQOwweHj+h1QNNNfxiEQM42eGk
         dlSl+Q2zxSsxEnStg6q4sLkXnTS7k8rD1+lvFeuae0HG4tIHdxLhP+pmQq/OYD9KFrDb
         vPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986623; x=1794591423;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bCjFCftZY+2sQA45xJDozhTjhcUphJevAvIJETfdPY=;
        b=gZ79ImxIsvYdp0cigm6MZqZavPumpseAjf3tE+hiRma+BbEnMCc0KrlSGH8oU4JJW2
         43vhB5xJ21XpLM5UGNALjxG1EFdizLzSBhm12ka10fda4QGd7WzNDVzukfcwxiUGT3fg
         Mb5LLfi8rIcuy+t7MeVO/MSpNFU1jOR3m3jVDrAhpwe1svI47YC2ed8ghPfFsFiagVoT
         c9HeBTQAbrv0bOy7diKO1FJfty7S7+V2s6cs4TpMXoTQvT6yZ7+Ra644d7jZ3P7xmoC7
         J893Mpwh6YpUznxqXsi3OP13T1pdoC3/CcaTCDHsVkcw8rZRh7o2Js9tSrmrg1VplTq3
         a7ng==
X-Forwarded-Encrypted: i=1; AL+hErHmhAyp1WI8c+OXtIjP0YWXF0ArfWqA89vLC+ZnEuBrLOnPc6IFeXNC82BdT0TnI+apLjOqcql7v68lDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+T3ZR7sMLbK3p7UkcfSuSBbLO+NUUnaC/O7+1UlcTse0OAb8og
	TqsC/RdJJ1dSBqgIlbhwr7eUFm2oCGhHeDtb2496NttNCzH0Pw9IDFyN
X-Gm-Gg: AYBFou3Xp5h38kNSm0FCyiLSPVPcO2CKetrM7ttqrf1EvzYB3juBJ7TUt3zTJ4s7sOk
	DhC9Mu6PvI7kgJOogHW82SmT1vq+IcuHASp3/EHbKlWjyaZotshzS9wTIONNkWHGzRmr/lu6zrB
	onbBTVT4LRyiVcvzfMxMTrydmdNoWPZlpPZ+IFSvfsLg/FQSmeJjVdapD3qn5ZrypvIwFK4La72
	/il5pfdFoQYl/PLdqFjjnDf4nZrir5891yj97s4HLllIWpZ4mvm8Dgtw3GGWtTBshe3iJodlG99
	NXWsW1JMUsUqYU4O7E5aeYjbhCl5zZ5rB2/cILsbVXYWb55iFTjk3WFDkTLYYenNdvtfnz0cP35
	Lj2H/0R2YEh1odldXxrp+eZydEbpws+u8XzNoPvccuBRyV/5EXG8rMpYDkY7L9WT2y6XV7iSLi1
	iQt9u6btK00imucmA5y7rmnn9nucu8Svgor5wbNy/PZIMvfpkykP+8kdYJlo1zoufCOY52P/hn/
	u1Ov+iHmM08rYaMNeiFZd/N77WCGZaCr0BPjVJFA5xHCDShXGGDTKbBKiqlXLwcBSroI5fXLx1n
	V6GOZ70Lvrputh89gKTSC2FxrJpz2rgG3vVPTNSvedhN324U+V4/2aupNKWzRSDn0sQu
X-Received: by 2002:a17:90b:5410:b0:3ab:5832:727d with SMTP id 98e67ed59e1d1-3b0db6e7fa8mr3207259a91.35.1793986623300;
        Fri, 06 Nov 2026 09:37:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64e:8358:c9cb:c17b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0f76ff45fsm983355a91.17.2026.11.06.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:37:00 -0800 (PST)
Date: Fri, 6 Nov 2026 09:36:57 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Juergen Borleis <jbe@pengutronix.de>, Denis Carikli <denis@eukrea.com>, Lee Jones <lee@kernel.org>, 
	fangxy@xiaopeng.com, linux-input@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: mx25-tcq - clamp the FIFO sample count to the
 buffer size
Message-ID: <au4Pt9K9145wF2r_@google.com>
References: <20261106075127.3105907-1-liuc63@xiaopeng.com>
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
In-Reply-To: <20261106075127.3105907-1-liuc63@xiaopeng.com>

Hi Liu,

On Fri, Nov 06, 2026 at 03:51:27PM +0800, Liu Chao wrote:
> MX25_ADCQ_SR_FDN() reports up to 31 pending samples.  The IRQ thread
> aligns the count down to a multiple of the sample count but never
> bounds it by the size of sample_buf, so a FIFO backlog larger than
> TSC_MAX_SAMPLES overruns the stack buffer.
> 
> Clamp the count before the alignment so that the result stays a
> multiple of sample_count.
> 
> Fixes: 4f7ed234f2a5 ("Input: touchscreen: Add imx25 TCQ driver")
> Cc: stable@vger.kernel.org

This is a platform device, not something that can be randomly connected.
SO barring silicon issues the condition should never happen. I do not
think this makes sense to backport this.

> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  drivers/input/touchscreen/fsl-imx25-tcq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
> index ff270b3b8572..fa8d8b736723 100644
> --- a/drivers/input/touchscreen/fsl-imx25-tcq.c
> +++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
> @@ -319,6 +319,7 @@ static irqreturn_t mx25_tcq_irq_thread(int irq, void *dev_id)
>  	 */
>  	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
>  	samples = MX25_ADCQ_SR_FDN(stats);
> +	samples = min_t(unsigned int, samples, TSC_MAX_SAMPLES);

Why is it valid to clamp instead of refusing invalid data?

>  	samples -= samples % priv->sample_count;
>  
>  	if (!samples)

Thanks.

-- 
Dmitry
