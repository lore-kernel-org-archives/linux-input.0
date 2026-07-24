Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033282931C1;
	Fri, 24 Jul 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854252; cv=none; b=jFNitQm5wq/9Pq/d7NcjgHTb0XVkN1VEn+bkDNIyJ7VUaNbaMJiO/oCAtjK98p+WraS1tA3fk/2GI2rCvXZ0TOVumy5bo5K9XNauEnbRJg5goGyfDVQj8En/wXXlwG8AzUe0BlkM6Pu1yuXKmL7/R6j4MO2nnJlU5JARsClnCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854252; c=relaxed/simple;
	bh=gNaswln45dMN8IadG+DHYm9R4IqyHYqklZA4RSCGm+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE0KhF0tAerazuu3yyUFNHp183vLARwghd+ld4zMuF+5SkPu/xcCDDF0DMKS7t39JqCP0pNGnFN692oRQ1DZgTKRYmGZaanFPu47blrZ6I0EjTEmTWHQ2ZiP98czFi+5HD2MITeC8yRccNrkyuBXWaOHwQ0TJ/CRk3W1ihbSKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaWyq3mw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaWyq3mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDD91F000E9;
	Fri, 24 Jul 2026 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784854250;
	bh=4p27NKwcTMVUYeEaXxRSDoWU3baMIxD7D4KV3WLcWX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kaWyq3mwvTq1ZCtdxc7Sq1Pl7Ej5hYrnmJjK7kcxgcYjWKdLiS3TkNhudwF2FSLoQ
	 WJ1+8PRrFg23GCkbqkmdC9GPw4oQbPjFPKr2QlahtzTO+Pq+Czgp3crKfGZMWZL6PX
	 ywzi05/V8wZkqR+5WNQq0Vobz2WT6i6l5E5qvdZiLovaPCDo/tlCOZfu0arSbxIOA8
	 /8Q/SwSgmnlUFCpodfb6ZGebdRL9wxtoHYqd+65XgLxytfbI3B8IJUpbbnNweBOEAe
	 0faGCBSYwMzbsfB5TwXoOk1o4h/VaUDnTgfeZJdDoxnLvL4xoDxQ1V7XQ+fzVhzbhL
	 HsboHmlNebpxw==
Date: Fri, 24 Jul 2026 01:50:43 +0100
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
 <ankita@nvidia.com>, <leitao@debian.org>, <jason@os.amperecomputing.com>,
 <pedro.pbg@usp.br>, <paulmck@kernel.org>, <frederic@kernel.org>,
 <kees@kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 08/12] ACPI: APEI: GHES: use
 devm_blocking_notifier_chain_register()
Message-ID: <20260724015043.37cecbfb@jic23-huawei>
In-Reply-To: <20260723175513.39849-4-farbere@amazon.com>
References: <20260723175513.39849-1-farbere@amazon.com>
	<20260723175513.39849-4-farbere@amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:55:09 +0000
Eliav Farber <farbere@amazon.com> wrote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> ghes_vendor_record_notifier_destroy() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/acpi/apei/ghes.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..3aa29dcd70da 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -689,21 +689,12 @@ void ghes_unregister_vendor_record_noti	fier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
>  
> -static void ghes_vendor_record_notifier_destroy(void *nb)
> -{
> -	ghes_unregister_vendor_record_notifier(nb);
> -}
> -
>  int devm_ghes_register_vendor_record_notifier(struct device *dev,
>  					      struct notifier_block *nb)
>  {
> -	int ret;
> -
> -	ret = ghes_register_vendor_record_notifier(nb);
> -	if (ret)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
> +	return devm_blocking_notifier_chain_register(dev,
> +						     &vendor_record_notify_list,
> +						     nb);

Whilst correct, I'm less keen on this one because it looses the obvious connection
to the non devm form.  I suppose with the code being so near
to the non devm we can go with this. 

For that matter why do we have the non devm variants?  There are no users in tree.
Can we just rip that and the unregister given this is removing the only users?

Thanks,

Jonathan


>  }
>  EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
>  

