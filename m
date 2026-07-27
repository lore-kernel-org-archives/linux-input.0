Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85C35E944;
	Mon, 27 Jul 2026 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121306; cv=none; b=E631dd3rtNwfoi/mxQi3/eoOYWtpQfsaAJNCpEqMhjBq0rbj/MrofQuZU/xFw7y+rKI5DnGID5rBF06pH+1Erpm/N7dmMZjf8xvUDGjJvLMxDPTAgH8InPz66635bNWlwba1LOxmEMd/HMwQZyULoxZTnGMgWwoCPy0o1kWAaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121306; c=relaxed/simple;
	bh=0Lot+TnJghW5oCMKx7b/SQcTN+EtQeNK0wfbz8ZtSlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SowLnujnwUcU888AQh6bQozRJGg/R1/urTeGcDQdQXsPiEZe+T4cbKQAdOa1f9UxjwBZOcYisFOZN72EAEMIF+Lj1bcMSizYGRJ+4Rllqs+shbWMIJ9SnHsL+IieHkoLr3clmRmsA7xa/mrneGxoGXc3XNX8tfRVWHH46SnHD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BvBh2W9d; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BvBh2W9d"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785121293; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VQLn2zB/SNndgOSBeaoB1yZlEYmg2mNfunKtH1S8PsI=;
	b=BvBh2W9dKKbQwLVJ7pSjcebD15yWGnxGJcD+gNQvenOhq6LDQyQ5f3gkBp16/J74XgLsPdgt6wX8+cWpQOnqsZ1v374CqRQYTq4P5RJg+XP+0ROQD+ysnvyKUj8k+MZ+hVpjzdE+l162ZTGTBvgKYG/vWLCctLLoqxT/jvSyaj4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0X7oiUc4_1785121289;
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X7oiUc4_1785121289 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Jul 2026 11:01:30 +0800
Message-ID: <bbb207ce-1b85-4310-8af0-14ff8ce000b1@linux.alibaba.com>
Date: Mon, 27 Jul 2026 11:01:28 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] gpio: eic-sprd: use
 devm_atomic_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>, rafael@kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, lenb@kernel.org,
 laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org,
 orsonzhai@gmail.com, zhang.lyra@gmail.com, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com,
 kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org,
 jason@os.amperecomputing.com, pedro.pbg@usp.br, paulmck@kernel.org,
 frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20260723175632.44812-1-farbere@amazon.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260723175632.44812-1-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/26 1:56 AM, Eliav Farber wrote:
> Replace the atomic_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_atomic_notifier_chain_register(), removing the
> sprd_eic_unregister_notifier() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   drivers/gpio/gpio-eic-sprd.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 3b7ebcf12fe7..86eb9624d38a 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -601,13 +601,6 @@ static const struct irq_chip sprd_eic_irq = {
>   	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>   };
>   
> -static void sprd_eic_unregister_notifier(void *data)
> -{
> -	struct notifier_block *nb = data;
> -
> -	atomic_notifier_chain_unregister(&sprd_eic_irq_notifier, nb);
> -}
> -
>   static int sprd_eic_probe(struct platform_device *pdev)
>   {
>   	const struct sprd_eic_variant_data *pdata;
> @@ -690,14 +683,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	}
>   
>   	sprd_eic->irq_nb.notifier_call = sprd_eic_irq_notify;
> -	ret = atomic_notifier_chain_register(&sprd_eic_irq_notifier,
> -					     &sprd_eic->irq_nb);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to register with the interrupt notifier");
> -
> -	return devm_add_action_or_reset(dev, sprd_eic_unregister_notifier,
> -					&sprd_eic->irq_nb);
> +	return devm_atomic_notifier_chain_register(dev, &sprd_eic_irq_notifier,
> +						   &sprd_eic->irq_nb);
>   }
>   
>   static const struct of_device_id sprd_eic_of_match[] = {

