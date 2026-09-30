Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900D4D179B
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785585; cv=none; b=af4pcoI4+HWl1C4ymV0kcWltGgalgjbs24E/IbvH73cn14HqJthcH5FcXmCWaUS4ej/1K1Wy0BldxmWxyu6TkB8D/M3Bezo16P2DiWW/QbFNDyFx2HJfyn29Jo2wDGFvMo1MW9iYwKUYrr8i5Lw24qNFZrKi3cHtUrDtoKf4OBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785585; c=relaxed/simple;
	bh=PN+fvX9EsQhTbNuuNDPU0CH3hQrYoaayFN3eSFZeTJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=araLifO0XZNKVRg2TU6/nHLxPtI+zafQrnRYHfwYam1+QCR3kxlCYuMVld4tQGZkaBNx2QAJhtBiJqIOdWpCox6vQ3u32NJdD5Ys6dUtHVYDC3uFS02H467b3QiSiPVyxpT9rwiagz48kSdylhYaER/Gd37h/tJsQufbRkdCVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDJySX+K; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDJySX+K"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b6f8b8113so816794eec.0
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790785574; x=1791390374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZZlK81/LOMpXc91kCxLooOgEsXss9MaFG6gLo7Warc=;
        b=KDJySX+KaOGeIFEXSxknuRIqGNeckBF3F8njVKeKHX2BhTSXkQFtymd64IBnUid8/m
         frqYwvY4M+xSywhfIDYgRe4IoC7q8ikYh5QlQbV07Pj36y4PsSNMiS3MBDtW41TXKmU4
         nxKGBMXEjEvyCQAvi9znbB1X56bdrecS0WULoWKMj02UjNo9eKNOrg3Y2e9c6WXRWYG7
         A3hrIFfqUjHMr8q2l3+TgNQQh+SUvDwYu/K4nNSkHp4Nht71/Q8Adcq/YeYeTCaKvKOb
         hZ3MAsvsVigxwXBTne6R67VAppbgohstYBDxVkkAxLjj9aFJlaGSoUABx0U80sGmU++8
         ahwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790785574; x=1791390374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZZlK81/LOMpXc91kCxLooOgEsXss9MaFG6gLo7Warc=;
        b=qw5AifqrsNlz0/EsOnLi2ihrWl4PlMHcXP8gd6NbQEpZfA3GH8ljWlc0KdvstHeYLe
         1EQLnlHt0y8AeUeMeKED6cqybR+XKBL/TzYwq8ib8MiORLUByLOMCpcf+qXseLevBQJ1
         tAieIKkPA/PJs/Nu7PN5m5WuvkRazPZfSDj/6mlFAjAkIcI4uJh+dD0xPPxez2r6sxsU
         cJbHS95xFLaf4fsuqO0CGAF7/yWXDkkXa2pLxmm1xT1g3yPBI/Tg5V/cQsw+N34Ltmp0
         4Wy4jlXkrCdz7k/leeWyHsUnNGtTvAVMwPHvsiGqTtpoq95MG/vtKqx/s/PVHWX1Gxen
         GWIQ==
X-Gm-Message-State: AFuF++lUUvgvRKLmlbnW63kKh3v72VMs2YUuaBt39GXnPWdB0SGF+lAu
	1oL5mYaFbwb8c8N1R0W1bXS3ezFe44eprdKI9b9JjDY3TPP0N6P1dW94
X-Gm-Gg: AYBFou2YZQlXiliSOkGrK5dgS/4B4eiqg89VskHENRL3yVq8kdzBZ/tcAjMHtEIcRBM
	3OKi3EqFIihuBhgdw7jzY6RJf9c7HlZqD48ckzOM2VRSd1WxwLiW1KOsswniOSHdJnDC0SF9wAy
	FOkr0wvN6GD1BNm6p97TgiaiVhdtwv8pAIqfsQc9yQNTEc/toM0YrqtZ4DEDVf/mXwpfNIsl7yu
	mi/SiMvdH0eWyeZVacj5Lrcw3jXaFqbUNyNBzMzGuIINDhRxz0eAXCi9V3Rx8bKn3foLHOBw1Qp
	yKBlslDp7z0DhZ7rTg6fmkhadjVgJEiYU2IHftG+J1vxR7vqfeYve/g6odV030RcJmZfo5aEOxf
	ONa8V92eNFdUOP+oO+36oHiGUGogLjPXbJ6CPH6tpft7sml6WzAKfVW1tbE4XiD0SDCSzaXP58O
	1wSMS0JPGOsVD+PYBPtCaQtB2CNGGsXJRLILhjTKCsMjviAlS1AipM1eJysPNcl8mLdz8/oMKQO
	tMef7SMVCQ/hz4JyO5JAwA8yLLLh1wPfjsbzBMH
X-Received: by 2002:a05:7301:dc3:b0:347:a3d9:dfa3 with SMTP id 5a478bee46e88-34db859bdeamr84512eec.7.1790785574210;
        Wed, 30 Sep 2026 09:26:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f011:1d53:dc9c:51d4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4c1ef93sm209318eec.28.2026.09.30.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:26:13 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:26:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: s6sy761 - fix error handling in power management
 paths
Message-ID: <ar039bFIInczb0o4@google.com>
References: <arya1u_Rqtt85lyc@google.com>
 <3c06e10d-7259-4b7b-982c-f31c3779506f@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c06e10d-7259-4b7b-982c-f31c3779506f@ixit.cz>

On Wed, Sep 30, 2026 at 06:15:29PM +0200, David Heidelberg wrote:
> On 30/09/2026 07:18, Dmitry Torokhov wrote:
> > In s6sy761_power_on(), if any of the I2C operations or status checks
> > fail after enabling the regulators, the function returns an error while
> > leaving the regulators enabled. Conversely, in s6sy761_resume(), if
> > powering on the controller fails, enable_irq() is skipped while the PM
> > core still marks the device as resumed. A subsequent system suspend or
> > driver unbind then invokes s6sy761_power_off() again, attempting to
> > disable already disabled regulators and incrementing the IRQ disable
> > depth a second time, which leaves the interrupt permanently disabled on
> > later resumes. Additionally, if restoring sensing in s6sy761_resume()
> > fails, the controller is left powered on.
> > 
> > Track whether the controller is powered up with a powered_up flag,
> > unwind regulator enablement on error in s6sy761_power_on(), move
> > disable_irq() to s6sy761_suspend() so it is only called during system
> > sleep when the controller is powered up, and power off the controller
> > if restoring sensing fails during resume.
> > 
> > Reported-by: sashiko-bot@kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >   drivers/input/touchscreen/s6sy761.c | 59 +++++++++++++++++++++--------
> >   1 file changed, 43 insertions(+), 16 deletions(-)
> > 
> 
> +<<<<<<< HEAD
>         return s6sy761_power_on(sdata);
> +=======
> +       return 0;
> +
> +err_power_off:
> +       s6sy761_power_off(sdata);
> +       return err;
> +>>>>>>> Input: s6sy761 - fix error handling in power management paths
> 
> doesn't apply cleanly on linux-next, against which branch was it build? (I
> don't see anything touch it in input)

It's on top of your change, I just pushed my queue out, should be in
next next.

Thanks.

-- 
Dmitry
