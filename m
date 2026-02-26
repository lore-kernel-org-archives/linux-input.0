Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5A23D7F5
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118436; cv=none; b=FDOlhoNjY77ycY35E7HdhlOS1Kn2OGrIqAcu1Lf8Su1qUjj9D/LZLmjfL2i0oyVojuWIM04xs+rystwjYLG1Gqo6CzRZZbiANqy8GFcypMs0YqgKYD13OOdKLdRisORL/En+RxGx5iqpVV6/t+UlwHMmWK1r0fbkWIhaNRcqEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118436; c=relaxed/simple;
	bh=O3DT9Sm+3+5BnWkcXNqfL+DO6FXuY+x1Arn+NiZYHqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RQrovQY32Dft7QDQlKr9IvTvM32gZgJc0XOt5Sw6jPUYz/SrLhFeVvQ6YUcDYqGt8moex6pVmMyprzjY7yJeuCQg6G6mVfFH7al3rXnEs/cMgHT+FIB/fmoHm+oKn7LZBz8JJIPrkgRANd0dttyGMyxxlSdmrgdKH8D8qoh1uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e07KxwwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e07KxwwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144D5C19423;
	Thu, 26 Feb 2026 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118436;
	bh=O3DT9Sm+3+5BnWkcXNqfL+DO6FXuY+x1Arn+NiZYHqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=e07KxwwUpQw369sNN+k23BE79gLa/2FR8I7vub119WJmoGsyy4MxdNNqG9dcr9JPT
	 tWM51hgLuJyrIWmSE58t4i2B+5pXvtJJ76ONJqphUuJtT5w1JI/pQq2GuGxg8dFlpo
	 mPo2n23YLiUqDTDFtHXB5xKu6YmlHPZFMcwgT1fdnRDLTU4jLxta/yKShU2WnuP56f
	 tM9S6VHz/StrtwbJnFkKcTNVMWm2oIpO9QH4OWk2NEOlz1hwLb0f7gCsJUM7HEKc+m
	 cZk4nHZD1Kv0+LAg6mMXvfUV3OiCXnkLj7pyxOhm9qkoOek+sWoGob/4lzw68X+ocB
	 CeArr9xpiDgxg==
Date: Thu, 26 Feb 2026 16:07:13 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] hid: hid-pl: eliminate private debug macro
In-Reply-To: <20260216134958.260648-3-oneukum@suse.com>
Message-ID: <sppq6o8n-110n-596o-427n-0532s373p60n@xreary.bet>
References: <20260216134958.260648-1-oneukum@suse.com> <20260216134958.260648-3-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 16 Feb 2026, Oliver Neukum wrote:

> Use proper dynamic debugging.
> 
> V2: resend full series
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/hid/hid-pl.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
> index dc11d5322fc0..4b6b33597d11 100644
> --- a/drivers/hid/hid-pl.c
> +++ b/drivers/hid/hid-pl.c
> @@ -24,10 +24,6 @@
>   */
>  
>  
> -/* #define DEBUG */
> -
> -#define debug(format, arg...) pr_debug("hid-plff: " format "\n" , ## arg)
> -
>  #include <linux/input.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -53,14 +49,14 @@ static int hid_plff_play(struct input_dev *dev, void *data,
>  
>  	left = effect->u.rumble.strong_magnitude;
>  	right = effect->u.rumble.weak_magnitude;
> -	debug("called with 0x%04x 0x%04x", left, right);
> +	dev_dbg(&dev->dev, "called with 0x%04x 0x%04x", left, right);

Can you please use hid_dbg() instead?

Thanks,

-- 
Jiri Kosina
SUSE Labs

