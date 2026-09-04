Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED73ACF10;
	Fri,  4 Sep 2026 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490603; cv=none; b=EwO57FmHyR4RXv8koPNuLAZwuz9rF/7QWdI0JwlVPA2HGEP68FEDOGOYY277g7i+5GU33fmkSXmn1IHbvkOyBSRm/xjL5zAgpCI4FEVK1HSIOVgtEVelFyxD8bJ37VMttfdFtF1urpZ4vrG8z4x4duUxnhCPqDEGO2HZ34CVenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490603; c=relaxed/simple;
	bh=3107Y7JX220AjVb1rk1TFIvZqJnS2YlFKglQU81emTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=at0ip91yeJW4LE5BHA8m+Oso1zRl/8GxLNqI2/bwH7eMqW7/wM1XekGmMEN+XLWe72Zv0iV1VndtzKtsUgBgNspIXYMxzhuRGXXgP1XXg73Jt4Q8ilZCJQQ0+5gQ3TH309AvzowHEAOtKxcP1MkL2jXxc1WmApXfHJuHa2ScLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHeozWzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHeozWzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A507E1F000E9;
	Fri,  4 Sep 2026 02:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490601;
	bh=elq1oOXS9izL1eLEUjPGPGm9Oywm4DVxZpNoEOogJK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VHeozWzmYAkZZvr/Z1IWKOW4YdwtfBCJoGgRQnGnwxA0Uzgm582QN+aoboEJryMxw
	 AU38nuQCgXvFtP3t7Yv5A+K31aPrEiN3ftc+9ep4iIYtN5/tMdtzdmaOxF1m+BgOE3
	 bu849CgT4SoYG6dcCcFnKbe+QftS9ojVD0SU/o4ifYRCC+kWRDQK95/F8290Mx6Ga+
	 TFNdHohZCuHf3XoYc1O4zmPHncAtYQ+UAUioTwE115iOk5nO3mapj4AbHRNeHD45md
	 nb3fOkwmKrnVYX5Lw/3bdUKm43V9ukO2kAQYhanN0Se5vMxab/345qUtQtsYz/i5Oi
	 qj7lfOWfXG0Fg==
Date: Fri, 4 Sep 2026 03:56:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
 <guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
 <lenb@kernel.org>, <laurent.pinchart@ideasonboard.com>,
 <linusw@kernel.org>, <brgl@kernel.org>, <orsonzhai@gmail.com>,
 <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <dmitry.torokhov@gmail.com>, <hansg@kernel.org>,
 <ilpo.jarvinen@linux.intel.com>, <W_Armin@gmx.de>, <ukleinek@kernel.org>,
 <fabio.m.de.francesco@linux.intel.com>, <kaihengf@nvidia.com>,
 <ankita@nvidia.com>, <leitao@debian.org>, <pedro.pbg@usp.br>,
 <paulmck@kernel.org>, <frederic@kernel.org>, <kees@kernel.org>,
 <saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <acpica-devel@lists.linux.dev>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 03/13] iio: light: iqs621-als: use
 devm_blocking_notifier_chain_register()
Message-ID: <20260904035632.4aaf4eab@jic23-huawei>
In-Reply-To: <20260816060648.4030-4-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
	<20260816060648.4030-4-farbere@amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 06:06:02 +0000
Eliav Farber <farbere@amazon.com> wrote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> iqs621_als_notifier_unregister() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied (on top of merging the branch) to the testing branch of iio.git
Upgraded that ack to an SoB as a result.

> ---
>  drivers/iio/light/iqs621-als.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
> index cd5843e3e2c3..f9d215ef1970 100644
> --- a/drivers/iio/light/iqs621-als.c
> +++ b/drivers/iio/light/iqs621-als.c
> @@ -179,19 +179,6 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
>  	return NOTIFY_OK;
>  }
>  
> -static void iqs621_als_notifier_unregister(void *context)
> -{
> -	struct iqs621_als_private *iqs621_als = context;
> -	struct iio_dev *indio_dev = iqs621_als->indio_dev;
> -	int ret;
> -
> -	ret = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
> -						 &iqs621_als->notifier);
> -	if (ret)
> -		dev_err(indio_dev->dev.parent,
> -			"Failed to unregister notifier: %d\n", ret);
> -}
> -
>  static int iqs621_als_read_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int *val, int *val2, long mask)
> @@ -563,19 +550,14 @@ static int iqs621_als_probe(struct platform_device *pdev)
>  	mutex_init(&iqs621_als->lock);
>  
>  	iqs621_als->notifier.notifier_call = iqs621_als_notifier;
> -	ret = blocking_notifier_chain_register(&iqs621_als->iqs62x->nh,
> -					       &iqs621_als->notifier);
> +	ret = devm_blocking_notifier_chain_register(&pdev->dev,
> +						    &iqs621_als->iqs62x->nh,
> +						    &iqs621_als->notifier);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       iqs621_als_notifier_unregister,
> -				       iqs621_als);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  

