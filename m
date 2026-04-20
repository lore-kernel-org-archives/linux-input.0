Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723D175A84
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644309; cv=none; b=knj1a+u0cUWh560NWJrXL3CGibohcHCLVGAuXPswrymo1kMzZJdK1MPNo+EAwBYOMPs79y+B1yzsRNcSJAowOObvABH3e3rqrJ7edKig9sooqAtsUIPsScCCJ4KSYbuLjgZAzEZdHsBymnayfhEgcogIsNTCDUvlC980evX01Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644309; c=relaxed/simple;
	bh=CHbcvGC0D4cWu56DoiePKJcYS1Yl8WUV95TVYlZX5o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR5qdGGEm+9RtADt+6D8bT/lrtn1CVOPjnLRoo2LpGgzTYoE3jzhEp+vOhgM4EwZ5dmqREtciQSfI9GOKhEKfd+31z++6NVUlup4KQgo7VGfu0lzcV+Zhe4Xx/louO/6zMgm+K/aDTXQOehARgV5ul+oLLRTaCcJrSbL9NPmxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paZJOgtY; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paZJOgtY"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c1a170a50so2863901c88.0
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776644307; x=1777249107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qijg/5GFGpZX39afBtXL4K2j66rc4n4AfMN/Cq1xB/Q=;
        b=paZJOgtY9K5Q6/df/jpD+u2M5s+brrE24iYUsj9HnRBTnSKfn05l8XXnLtcrTEL86e
         8pHBmyPTQq00E9V9k7+yfBfGbLIZOaXYdRozd0uv03DZPWYMcDQVTF7X4BU/s7VS/fTr
         Kwg08bCNxa1TwJt/3QHKiUbTO//QrGz7RUcqtaWjriqFU8Czrzk1MKrJysGG8js6Ak0i
         wfqBIPmTXR7vtJjo5bHWReTvqY5knWslYRZt0jKvVqEiAMeHWiyzJotBHvUvspSrJKqk
         rrmRwNedsqN1eJcGzPdYdUOsBPGJVSvVSZ4xGtrV3nb+tGNKCUnqI5Jp2z0RYC/WuNA4
         SUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776644307; x=1777249107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qijg/5GFGpZX39afBtXL4K2j66rc4n4AfMN/Cq1xB/Q=;
        b=ecE1zr+GAT+E066By/UZg+9+2TvoGvhuv28sGTCU5RepOyXh3gMCETTRR9JTC9ZPE1
         YFkaE4AIheJE7DpZBaWnKRX2dU8k/ztN+UTB+7hhwz5lQEG9ZoJ0jCqTU+YeouhFA1s7
         gk+d24sN+0PG6XFJhzRfVcKwz32900MfchS8BNailAuzGmY3wvgJ5o/hRbVW3K+xamgr
         HLDckTUZqCwrPceiU5dCyRMrT1xpfp7aEHcnPi8YwnIe7SegVRQJWDXFOmXOltb12/ed
         GY9eaq4VOAfz5pI7l0JY/YXczfy09j3FFT0h/CWW+87aUtlL5cG8QHhsBFLdzdCttmR5
         xklA==
X-Forwarded-Encrypted: i=1; AFNElJ9HT49eGqMUZKdjEHgopGUVVB+li2L5BJ10caEHsw5PuzQOuvU8sXTXbzPVf4YTY5NdYZ20tQAXY6JYLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyav+Xr2mVZphrc8yeRG3NLPTlWQqG/Bkc+pv4OLeli3yVq1KEM
	EQZNLYkioFtYPEh6Tz4QGwmecxK5lm6hLhaBmC+yrC4XiutpDUwnbal0rO071Q==
X-Gm-Gg: AeBDietSd3VslHhAuLlH4MJDw5BTnudSYaOmj+i0LwpN0gGBD9EUSljdXQgfJChbF40
	KjOhtAbd2VBfELdqC0YvZvCYIgTzLbPzbmSbvsDbYNjIiPbJxQJMgbS7bYZmpjXMhk0EortdjWN
	0bWbx3WOS84YqJDIflDMKNZLKDLckKjytY3UGSyKpW7KlR2m0siNMo81rsf6w3TmjjnR98ddS+y
	z8Wx4WasgGFlAj99NV7ZMpjnhEcA7dLySWapFO3SRZDGpwoto2kkwbNmdXvCKRco7j7dcwIEON+
	9ptYRs+NsDiihP1AlYTWuUmMUht9cELAttE5ZH0dpRY6O0S4AeafKILy3BkkWYO2m4IzujIKEcB
	ZMZDSwpfhPJjs7vDhPa8mAzUjzh3Mx1KLWiqKgnD8iXMhNRy1RwIfm7I3vtEcs12vbrBOKyFDmO
	EqcQLX8sfG2Y+8/I5+aRRwKwOVXY3xB26rfWDUuxOYmSn6F0VnmBc9iZstPAGCyrfsdNJ1rbuby
	mQ=
X-Received: by 2002:a05:7022:f9e:b0:128:ccb7:7fa3 with SMTP id a92af1059eb24-12c73fa8fa3mr5040606c88.34.1776644306762;
        Sun, 19 Apr 2026 17:18:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1a4e:4965:5dff:cdee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a80c7sm14535406eec.10.2026.04.19.17.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 17:18:26 -0700 (PDT)
Date: Sun, 19 Apr 2026 17:18:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yuki Horii <yuuki198708@gmail.com>
Cc: clamor95@gmail.com, johannes.kirchmair@skidata.com, 
	linux-input@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] Input: touchscreen: tsc2007: Reduce I2C transactions for
 Z2 read
Message-ID: <aeVwUKCQmTmn3OnY@google.com>
References: <20260410074100.1660-1-horiiyuk@ishida.co.jp>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074100.1660-1-horiiyuk@ishida.co.jp>

Hi Yuki,

On Fri, Apr 10, 2026 at 04:41:00PM +0900, Yuki Horii wrote:
> From: Yuki Horii <yuuki198708@gmail.com>
> 
> The current implementation sends a separate power-down command
> after reading the Z2 value, resulting in an extra I2C
> transaction per measurement cycle.
> 
> The TSC2007 command byte contains a 2-bit power-down mode
> selection field. By selecting the power-down state in the Z2
> measurement command, the device powers down after the Z2 A/D
> conversion completes, eliminating the subsequent power-down
> transaction.
> 
> This reduces the number of I2C transactions by one per touch
> measurement cycle, decreasing I2C bus overhead and improving
> touch sampling performance.
> 
> Signed-off-by: Yuki Horii <yuuki198708@gmail.com>
> ---
>  drivers/input/touchscreen/tsc2007_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> index 948935de894b..ff60245baa96 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -61,10 +61,8 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
>  
>  	/* turn y+ off, x- on; we'll use formula #1 */
>  	tc->z1 = tsc2007_xfer(tsc, READ_Z1);
> -	tc->z2 = tsc2007_xfer(tsc, READ_Z2);
> -
> -	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
> -	tsc2007_xfer(tsc, PWRDOWN);
> +	/* Read Z2 and power down ADC after A/D conversion, enable PENIRQ */
> +	tc->z2 = tsc2007_xfer(tsc, (TSC2007_POWER_OFF_IRQ_EN | TSC2007_MEASURE_Z2));
>  }
>  
>  u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)

Thank you for the patch.

I'd like people using this part to chime in (CCed).

Thanks.

-- 
Dmitry
