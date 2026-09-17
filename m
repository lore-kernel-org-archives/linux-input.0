Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1D4E3233
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658118; cv=none; b=Bbs0jMfntfC3tSYJ5xbl6kxY4aGlR3cqpKaXPbXKUcjKGrPKBgsP2UzCQxIDMGV6jqkq+OLv4ci1s54jOvQIDuOw+xgAY36uQ2ncaVPTBOd2oIAS3AzFGgM5iZz9Bhh8QYZzzFcY7P6aFfD+o44EUujmBhYEkxq1EPpCxMZE9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658118; c=relaxed/simple;
	bh=lj1AArdURKntw/KnF8ugndUqAFz8UXcJI2HmidLS8Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNDXS8Z+HRlALqt1kMcBL9cv8JZ8BTLMlyKt03CWdvN5Um+EL5xTv9/sHcBZrinALmbTFPGdFuYOu2hjCp85qc+h4pLS20cbhGVIxNgUzdMOa7cwIf+IexOD3UUUOv6zlPO6dKSuMcxAGSKGcL/ogahScTdqW30JPwfwclstz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6flIGCj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6flIGCj"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39647184c73so754928a91.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789658105; x=1790262905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UlhivK+zlFu4a3uy9GJIwu4Lv0iGdPKrQsjr7JexLOk=;
        b=O6flIGCj9rp24USOjCztpgIJePjlgnwlN8C5DvBkzvIBEKVxVT03prxyQXioWoRk6q
         LHXkmZ/cMLYUhmVJkr/9KxlBGmM9sV2eyyX7pAt8w2GM3KcQ/nJmEImRZxGs4/pRqVzN
         NmpSv6HmEIRENo2jQ0QdgeSVDJDJtlnFYqz4rW30tFRxP/tSb9tQ1zGnmCnvnLa9IhhC
         OHorTofhHEC3Szg9AeosrOMiJn6XHTCyqgvWPTvm71U/SUjM28plNuFUvytsrQeMKmJV
         9lV+XkiXhRDG3e1J+biR3ZCjqOBdeQwVqzZ+JRA5L0TAPfxp9xum1EEpEaxaw1xUaJ0x
         4uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658105; x=1790262905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlhivK+zlFu4a3uy9GJIwu4Lv0iGdPKrQsjr7JexLOk=;
        b=AsfR8N9WF5kgFjrr9JzyK8VScPG8WlmS4MKTbtcQ3VHcaPergy4LGYGav85heIUVPi
         XM00wFGshJrko17yK32nVA77cEjJE+2FGjrgngepy7GE8TqoYlTA5McVrBGQx38jhcqS
         X56EmpEP9n+pTxIVDO73T4Vy7tTMZgatjN47crgG6iY0RWtFxdTEgywY1Nk8BzfO7esL
         j+2YXqbQ9FClGSkBLu5uw3VbwrbqRP5sKtZ7xpUG1glDWlNXs4tla2/xzrsRK2NDDuc6
         eraQjdgvrdj4AiyqGl/8jlONU5ybXsQkdAvnkhSJtlptLHxTwa/npKUS7PImfRC53oz3
         hfew==
X-Forwarded-Encrypted: i=1; AKwUvBy0/3Dolg+vgcL04dalGI4/oqwctvLfvyHpug3WRs6Y6Koy9Wf8ZH54nJRcpROhao2DFej3dMX8M1e9nw==@vger.kernel.org
X-Gm-Message-State: AFuF++nuty7Be/FJBU91h1Zzg9P3dfhCf1082lWi9SJ0JKE43qPHotR1
	7HVKSWIecRz1QYI68lBSDQMEZPXWRyeW1CERIUbVWR8cdOpKbnD/bOLP
X-Gm-Gg: AYBFou05X1IiOy9V2n1M4HnYfGGbgqfHsY0Aw4r/mJvtN4BiEkRRTRxvonNWyJLLkDx
	IwpbHGJ/qDN4VcF4jwxTWJZ+5sGol5zYDtgHNU8a580D19O68MeKQhFoKH1CA8Vkz7dcWHeM99+
	7ybqF8haa9IZ457r9A0B4RL2PE1YsD/U13mcwriGuOMKkyc1wweRLPBVLmGQkKnjTHxhoVNP+u2
	z3uVQ2Kr6Rv7/TaPOU50QW0TibBqkobamaXcx5jd9HXzxD/cC26UWOwRcsksEl7FlCVi2njtYlv
	UNFiXRFbT6nwLJrevmV2MLG3QbqCuz6X3yLBkkVU9ABBfX4IDFfJHBt1bWuYJyZwBQNk90RcN++
	gq8CNDrEg8zV+TktncNWehEV+n+3TXE78Bq3lbNl9wD8PHw2OMGDXC6M7fbWPWxb/kXwlBsDoR+
	i10gTaBCli2Icim9GZrOQlkGifMFEoyOjxifLE3PZgrDBxcsvuK9taUHRnBqGQzr+N7SFsdm1/n
	dEsRWloB+pu470KChmSvfu7G9EN7DJmQJTibO/j
X-Received: by 2002:a17:90b:3f4f:b0:39e:4c97:ce06 with SMTP id 98e67ed59e1d1-39e4c97cf1bmr761796a91.39.1789658105113;
        Thu, 17 Sep 2026 08:15:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:48d2:6852:2cc5:a7b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5af6593sm15799800eec.25.2026.09.17.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:15:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 08:15:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dudl@cypress.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: cyapa - fix runtime PM leak in
 cyapa_update_rt_suspend_scanrate()
Message-ID: <aqwD1o6J4svIevWW@google.com>
References: <20260916185015.2093520-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916185015.2093520-1-vulab@iscas.ac.cn>

Hi Wentao,

On Wed, Sep 16, 2026 at 06:50:15PM +0000, Wentao Liang wrote:
> pm_runtime_get_sync() unconditionally increments the runtime PM usage
> counter. If mutex_lock_interruptible() is interrupted, the function
> returns without dropping that reference. Add the missing
> pm_runtime_put_sync_autosuspend() call on the error path.
> 
> Fixes: 672865080a8f ("Input: cyapa - add runtime power management support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/input/mouse/cyapa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 6e0d956617a1..5edf4fdbb373 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -901,8 +901,10 @@ static ssize_t cyapa_update_rt_suspend_scanrate(struct device *dev,
>  	pm_runtime_get_sync(dev);
>  
>  	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> -	if (error)
> +	if (error) {
> +		pm_runtime_put_sync_autosuspend(dev);

Why does it have to be "sync" variant?

Thanks.

-- 
Dmitry
