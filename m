Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1920C00A
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777950095; cv=none; b=ewTQ8jVR7te+UWF/WfmFdI/mbEuFSz9kbgbsNeIJVWLJrPIPQWkMMORjRGKSKbpGXA7XdA4eoqVqkA1Wu4KoeODfybPTURcD/wFL/DGoui2dLFq5aL8wJFzheyA37aDEQfhpq4oywLxpFg8j+3w61XdpvjYhQ0DYeSsV/pMsQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777950095; c=relaxed/simple;
	bh=1ZZq3AZcXhdVVTCNk7Y6efOxIfjWHrNXrTwSSibK9+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWHqO4uzPbhc3DoIRVPJ7DylhVeNJqrAL0usPaCQTy5xBr/2WGP0s2AwtqNvqaY8Ur6jLmWcMAiMPY5G3yUKQQPvjJ1UEioY5h1tREq7rpTq5V+AU8+cVA9ZV2TsdiEH/4DH60ybjqqH1XIoDq8sLEL2jYcZlhYc23lg0t5Yu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPUUYsu9; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPUUYsu9"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-130b2295ed0so702477c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 20:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777950094; x=1778554894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=El9tXtPSumoZ+MStmDgSuEySorMFvbhYEvY/QycU3Vk=;
        b=RPUUYsu9Jc17qV39uZNMtCuh2kXqJ3Xr2PodS9bZLuEUZO8SMXVnBrVbDS8k8uBmqM
         54beor3a4LtE3lJ/uWIyNE/eFBKta4aWibf5WIjMlv2ZbXwcpvEiAzgB1tL4B7x9/cfV
         qg9jYsDa/27uV1iCoFmXVmaR8WoT8/KuAWrTjE+8g90h5nVNs5C/c+ONtVFQ5/Ua+TKi
         8/g6kVu3fwvupNpPzMy49Ol0QdeQH/9UhCk96ELuQzPlLkr2AzZBB8Ay/yDqDXY/pGoW
         Tq1PrAsF4uxMpq5KJSC+il+XBU6yBWUCM261Fw20xMT2fspVL/FuIvGVlIPALgFIIMMg
         e2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777950094; x=1778554894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El9tXtPSumoZ+MStmDgSuEySorMFvbhYEvY/QycU3Vk=;
        b=fdilE9i/PaT7Iax/Kdsce+a0TCKzDTUcnVkTlWb4CE1TXUXj2ky8r+ELydWVstNMih
         cHNF19h5yZTK0a+Lnh1K45V7kqRMXLz4c5EB+kxFiRauW72cE/RD5xQWauAkD2OTpW43
         Hi7KgHrMjLPfjeuo3v504bm4UonnrqNyBhYqp5Y/s8mCWlQdXltQ96isCvmYwqDtESpY
         Uz9POkU9VJvkGzuaiEGCmgT9ZseYvnHf8rvRfWWt6KkFLJuRQokfHXkNbkTESuwyhfwt
         hbM78hP8k09nuD6pqUAqGLF/3VC4LzSov3li+JZ3ZsOVhoFw6/Sc4druSu/0q3B03FGD
         Cr6A==
X-Forwarded-Encrypted: i=1; AFNElJ9zT81KwHQG5bYK0mFWTOnBD8V/WLj0AX55lEXnsiJyjZ4axlFZTKvQkY/D9PkTLN0P1EQq+7IowUwcKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OqhklzL9edJQgfy5+B+EbufVScEsy2UmO87Eam8IJ1/ZpFkF
	6/7JM+SKm5VLq81zFiEMR/J445vr4bZ5OpjWx+ymzbdaoSaYFYn0Yt8E
X-Gm-Gg: AeBDietM3L5K2W+y82DgqTNe0gNEs27U2VIEZffpiu/jheaYPbeIohMWcDj6qv7YKxH
	rjinBaKRP4fk1uEjs5Ui9H/RGiMbZr5GPAVgiNmhomaEbzUCVX5xrvGBaenlHx/fwmkk1XMuKH/
	641/Yo+r3mV8kF6Mr8ceis/nvCp+T5evKW6WZHiyAdykjwHn3tWn5yb+WjPF9w64VERURbXv9mT
	ej+vTutGmarEiUJOdZbI9Dhq7mp2LDOfG+pXlqv20/NIY40oBljwlbEWRgf4VYjvYR3Jn6+5Wx2
	iMIzM63EPRx0tnoMoThxzcTEVEnot6cjkQHbJO/vtPXjaKH0B9y6xwWz/kbTsfmly6SvkdfTCqv
	ZY74vkf4Y0rga45EawsWeVsnRP3ENR+HzgugLpJxfPKQH9wE8Bxm6aDkgzpRyExnjfEHed7OB2X
	4/ZfXXPWJMzbIQaY132rjaz9BJNo6JTafpbxTo6/QKJnu1035ydTIkQLStz93lsmTrzQhj+5Lt9
	pQ=
X-Received: by 2002:a05:7300:bc9a:b0:2d3:f43c:d684 with SMTP id 5a478bee46e88-2f40745dcc3mr566666eec.2.1777950093512;
        Mon, 04 May 2026 20:01:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b781555sm19279870eec.21.2026.05.04.20.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:01:32 -0700 (PDT)
Date: Mon, 4 May 2026 20:01:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <aflcL6y_ugHV5p8s@google.com>
References: <20260430173739.3843425-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430173739.3843425-1-kris@embeddedTS.com>

Hi Kris,

On Thu, Apr 30, 2026 at 05:37:38PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits and use the scratch variable for the rx_buf for
> both the 1 byte command to and 2 byte response from the controller.
> 
> This change was tested on real TSC2046 and ADS7843 controllers,
> but not the XPT2046 the workaround was originally created for.
> Confirming that the original modification to clear the command
> register does not impact either real controller.
> 
> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> Cc: stable@vger.kernel.org
> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
> 
> V1 -> V2: Don't use rx_buf when clearing command reg
> V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
>           output on xfer with len and NULL buffers
> 
>  drivers/input/touchscreen/ads7846.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 4b39f7212d35c..488bcc8393293 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>  
>  	/* clear the command register */
> -	req->scratch = 0;
> -	req->xfer[6].tx_buf = &req->scratch;
> +	req->xfer[6].rx_buf = &req->scratch;

Sashiko (I believe correctly) pointed out that by doing this "scratch"
is now write only and this may cause DMA from the device stomp on
message status and other unrelated data that shares the same cacheline
with scracth. While it was already a problem before now it is even more
likely.

Since scratch is now write-only I believe moving it below "sample"
forces it into separate cacheline and fixes this problem. Could you
please try making this change?

Thanks.

-- 
Dmitry
