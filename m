Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A1344D88
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637447; cv=none; b=OKkfJ0q7BERtNskerFt4bD0oEcK4UJghyhU8GpWKMcpwUALVflimGS8rpg+b3kKo0UD1Ic50t15B3eOqCH+ohsIZTURwP2ZH5M57SCnZ52LtCc5nR4o4TrxnzqrDUurylAaikgLVn2/tUk/2aOkXOVWyB7useXvynLpd/XWxRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637447; c=relaxed/simple;
	bh=JJYTTjkksJKuvApYhzKEoSa9mLsNiQ0WHtwYRFZOoww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj4A600+WEg/fn5PjMtDwze+SS9c9xFZYFi8/oSJYA/03GPiyzzUniX2WmuGLCFsdEr4uKelLPBoswgFUircFOY0tMR2X2QILnDLy1kdg6/zjOcoEYdYait39OcJzQK9lmzdH3yeDMVdjLEh7yr1xxiMwzEYlbbd1l6zOISWX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJdNW9T6; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJdNW9T6"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-307631dbfedso10493785eec.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637445; x=1782242245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hI8CQ7iIs183Bza7pfsOzCiD8tUmxO8qZugpjjwhilU=;
        b=EJdNW9T6tixA32vKpg3MWx4K+BAr7XcscHaCSn7uI1qQFwEVJZP4ezl8Pu9FEVUkqB
         EZKPV5nJGLY+C7TzdeQ2VNeTrKm6ja8OxXdsxaXHVMPYMLj7FSXlJdL6rPiybm4H1T5j
         ke2I8RfKsmy0OGcLS+scLOn969oxIRRmqQ6WU6TgyswGIodnaBYnPmN0Wotyn4CBzQkm
         WLn4iOfw6C3qjQbiZwy2MaXcJIya2Yy8hmlLImhTOZnnh863i1XI9i2TfHqvA4Da5OZx
         n8ofsoBXZGRK0yZHYRZwRY3s0E8olOFdO65Fw88W3jMzeHUGin6QrWv4aZEZ4B4oMbmN
         gSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637445; x=1782242245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI8CQ7iIs183Bza7pfsOzCiD8tUmxO8qZugpjjwhilU=;
        b=qg4Ahqal3EXdvS5c/PEdb2DdB0T0HrYtrBCmcpWpIKooU++rd9jJINaqBGOXlOvSHC
         KPMN6XtG4S/SAptClSHUT5KqHISu/p6VzCteX4nR3H7CnwoyOcbIV7v8ViN9e5+l4Izl
         KELNFfs375Vu77Ejdh/e1vN4XuXv5DixswtQE7KphUg6cXI0tPUHfkVyn/7tvKVfOTDA
         lmadDXELdJndAzvplNCL5MDzQFa1/WJgyyiKfaysVsq+QB64FV3cPC2EoObm9F2TX0HO
         VUaPsDT3Bk1iqFnsBn+w4Axd6z4ahT+JPQeL5OGLrWZPKE/UMKXLalsOYBV3lLOISsLM
         9TAA==
X-Forwarded-Encrypted: i=1; AFNElJ94DDdsq1cmhsexZUB3CWgoUgxKqbkYCjGKw6dIjU/qJJzE9tQiodd1wpRG8sdHtqGvGjYlSJtwxHML+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqC6xuydFV305PylDsfoghNWXNMdw310U0/owcg7rtqjoOx5cp
	jpzwZyAf8LTMQBKxEdUWrvlqinhSYjMGuOg4hcRRsmIiYeTrkkybBGSN
X-Gm-Gg: Acq92OGeH+FgPliqxDwimDrGdEsMX5oC7bcRx+3AVu26cXOobhTsixprHKOU+SnM2v9
	vOvkjfFW0JRgy7ETjXazZ8Ri2+xceSopCcPXZGYuDSpXdzGN92s7UXifaJhf0Py1OMpYxIT4lo3
	nR8f0nH9mTd3VhkSJb376d2xPj4PCiNMWQFVd1z8XpEs2jsd3sZ79fQrZbm9+zt8rNYrhTkpXFW
	gjV7H4wi0QD8F/phCkghuwL/ufGGcdJYhHlzCT1/BoH84fqJn77DwBvRwA0FydaxlEKtFhgk24M
	zG7jk8ZHoOVv6bF1T7xo1NaPczEcfJo4VQ8uA3JOiwGVWJ2qAY4XYKw028tBFI480+mRHtqYqRf
	kxJCxRI/vR/Emq6Av6iqHBcYjv0A1VWTRoVbcnnAbNRgkQATA+SqwPceXBO3C9QC07FLx/ns+7p
	Ce++rBay3KLpLrj55bDaH+8pJTqJ2o0xCW6VDU3abkWgxt2o/aZQmmzBCvUoonpYI=
X-Received: by 2002:a05:7300:2153:b0:2ea:3370:6e51 with SMTP id 5a478bee46e88-30bc9cbb744mr374150eec.4.1781637444500;
        Tue, 16 Jun 2026 12:17:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:cbae:d24:189c:2cb9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30b6191bf9asm14518352eec.31.2026.06.16.12.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:17:23 -0700 (PDT)
Date: Tue, 16 Jun 2026 12:17:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jie Wang <jie.wang@intel.com>
Cc: Henk Vergonet <Henk.Vergonet@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Input: yealink - stop URB resubmission on completion
 error
Message-ID: <ajGfjuo3MTlezkYX@google.com>
References: <68bba4fb.050a0220.192772.01a4.GAE@google.com>
 <20260616110440.1073059-1-jie.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616110440.1073059-1-jie.wang@intel.com>

Hi Jie,

On Tue, Jun 16, 2026 at 11:04:40AM +0000, Jie Wang wrote:
> urb_irq_callback() and urb_ctl_callback() resubmit each other's URBs
> regardless of completion status. When the device returns a persistent
> error (-EPROTO), this creates an unthrottled resubmission loop that
> starves the CPU and triggers RCU stalls.
> 
> Stop resubmitting on any non-zero URB status, following the standard
> completion pattern used by other USB input drivers.
> 
> Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=039eab266c6321a174bd
> Signed-off-by: Jie Wang <jie.wang@intel.com>

It would be good to have a helper like

bool usb_is_permanent_error(struct urb *urb, struct device *dev);

instead of having this "switch" in all the drivers. It also unclear
whether we should not attempt to re-submit the URB on errors other than
ECONNRESET, ENOENT, or ESHUTDOWN.

> ---
>  drivers/input/misc/yealink.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
> index 8786ed8b3565..bbfa1a9c23d1 100644
> --- a/drivers/input/misc/yealink.c
> +++ b/drivers/input/misc/yealink.c
> @@ -414,9 +414,20 @@ static void urb_irq_callback(struct urb *urb)
>  	struct yealink_dev *yld = urb->context;
>  	int ret, status = urb->status;
> 
> -	if (status)
> +	switch (status) {
> +	case 0:
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		dev_dbg(&yld->intf->dev, "%s - urb shutting down with status %d\n",
> +			__func__, status);
> +		return;
> +	default:
>  		dev_err(&yld->intf->dev, "%s - urb status %d\n",
>  			__func__, status);
> +		return;
> +	}
> 
>  	switch (yld->irq_data->cmd) {
>  	case CMD_KEYPRESS:
> @@ -452,9 +463,20 @@ static void urb_ctl_callback(struct urb *urb)
>  	struct yealink_dev *yld = urb->context;
>  	int ret = 0, status = urb->status;
> 
> -	if (status)
> +	switch (status) {
> +	case 0:
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		dev_dbg(&yld->intf->dev, "%s - urb shutting down with status %d\n",
> +			__func__, status);
> +		return;
> +	default:
>  		dev_err(&yld->intf->dev, "%s - urb status %d\n",
>  			__func__, status);
> +		return;
> +	}
> 
>  	switch (yld->ctl_data->cmd) {
>  	case CMD_KEYPRESS:
> --
> 2.34.1

Thanks.

-- 
Dmitry
