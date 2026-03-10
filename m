Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BD33A717;
	Tue, 10 Mar 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168937; cv=none; b=fGxl24RCK5QU29tWgJmgdXUuIybi4PqmYf3cKfAi8SnGH/mOP1CsQtoRw0QsP/WmnOoKpfbk/J7rMJvY0e8J3Hk4InAUSHDxhIUl5dlZ9dKu5i3FtA4ZU5eOXl2dj6S2+15gMjhRLCjxsBew1yP6dFRuT9R62e7hFw6YXrdhO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168937; c=relaxed/simple;
	bh=6IDe7hZa5b+miIWw+pcE9ZT8CXmolnXKy2LwlhEY6+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlsuGmhyut2soCTJ5gET9x9yM3giwzs1NuWoXV9ps0BivSmMtEukYrjIj7O/TCC3AdYKpllzfTmKUEabMbWpZCkOG3/+E1zdtVwNyC/vOL9s4UPJj1NvqdPiyye4mD+xJvQx/TGzy0o3EETwi27TiuQ6hEgQi1FM8RoC++02SKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMR1WPOS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMR1WPOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696B4C19423;
	Tue, 10 Mar 2026 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773168936;
	bh=6IDe7hZa5b+miIWw+pcE9ZT8CXmolnXKy2LwlhEY6+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMR1WPOSFyk9HcYOmORWoyOlpg4CxvvWzANqWpT/VXALBZ1WO536uVfK55TkUTdWh
	 GiW3gM6VsPiNOe1NdGOpWDQpX38/u9e7zpxCaUsYT3O5qquPzxOVMlZwgbkrfGBwRC
	 Ufti3m0zL086uOasAh5EaMfH6GYEMT7SFzSUHAvTmXkMBOUisY2Y/kcLBDgv03qlEB
	 6izryZgbQRdmKdrl/a3teGxXRDN2QCIyLc+gpAn7q6vrBZfUt6sVhS+1tSvmpxTL2K
	 YADHKhS4jrYRw6XJY9rWQsL44CAR49R8bBbKOg/yXHV2Z8IXIiQno/qBY0g4Ht9/6B
	 dtPzGGPCvH8Ow==
Received: by pali.im (Postfix)
	id 93D11BCC; Tue, 10 Mar 2026 19:55:32 +0100 (CET)
Date: Tue, 10 Mar 2026 19:55:32 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 60/61] Input alps: Drop unlikely() around IS_ERR_OR_NULL()
Message-ID: <20260310185532.htsq3koov6f4nhzn@pali>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-60-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-b4-is_err_or_null-v1-60-bd63b656022d@avm.de>
User-Agent: NeoMutt/20180716

On Tuesday 10 March 2026 12:49:26 Philipp Hahn wrote:
> IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
> not like nesting it:
> > WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> > unlikely() internally
> Remove the explicit use of unlikely().
> 
> Change generated with coccinelle.

Hello, exactly same patch was sent to the list more times and was rejected.

The last attempt was here:
https://lore.kernel.org/linux-input/1570869407-41262-1-git-send-email-zhengbin13@huawei.com/t/#u

And the previous one with discussion and explanation is there:
https://lore.kernel.org/linux-input/1566298572-12409-2-git-send-email-info@metux.net/t/#u

> To: "Pali Rohár" <pali@kernel.org>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/input/mouse/alps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index f3d3b6b4e02d798e75a90333ace72a367befdbac..82e11efad7f7f02b4aaefde340f9b71fa792cf6b 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1482,7 +1482,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>  		/* On V2 devices the DualPoint Stick reports bare packets */
>  		dev = priv->dev2;
>  		dev2 = psmouse->dev;
> -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
>  		/* Register dev3 mouse if we received PS/2 packet first time */
>  		if (!IS_ERR(priv->dev3))
>  			psmouse_queue_work(psmouse, &priv->dev3_register_work,
> 
> -- 
> 2.43.0
> 
