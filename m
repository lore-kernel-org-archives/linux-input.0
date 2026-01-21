Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4335CB60
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025784; cv=none; b=BZ6Bd0zVG2VIiGSPajI6wf38OFLgQlIkCoUzYQN74aEKBpcRNRhP54I4r8p6KwK1uyllKZBD2ZynbdmD+dlvXJ0Nx1FqhMmkYvi4bOCEk6TCytukGOiqjDBGSXO69x/JCrfrib0aWLDoc+iZmcJam+9/9kB6fhrEGnLXW6mEduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025784; c=relaxed/simple;
	bh=ryGfHyEX0pdgmogicUMhJer8o2q7Zut9okPt2Zf69UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjTbP6+15a/fMJVV1V75V1zfSSgHYti8n5rLcoYn5pqR14QbQfytyebbAknvSGZQSJydAUoPmpg0Rkr5sorRM0FvqWutdCyk/9lYsz1MLt9yYTLyHgePuEc2PGc2yXI/BHwJ1dw4YkNWfTZbPETGMpzIxkYWzriXutj6++FKRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQu+zMG9; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQu+zMG9"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so557339eec.0
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769025781; x=1769630581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noOMWd8451AiWi9sjesHYL9FiLA2for0VqMOqr/FP1M=;
        b=gQu+zMG9Mvr8420xOEK9ciJT6pxxL7WFICPoDrSWDbsUmk75jHuCvz4T9x1zkR/czp
         2895eAQubjtKaXS0lTLnq06kgL1m2xvhNf03p1FVPclgi/Cg1cHxpLCyuCgeX5a4ESiT
         fBc+VE6FWCez2ggpBLijomqYG/E9Si0nMyKaEhj3LsRhD/kwgLUjbH1ArPc/TB7LI/xT
         21GFWHftYp9xc6lryjA9w8iKU4pitaE4wZTGOnWA08NiD6OugWgRnnCQKGys8dwQaput
         dkBMMeyLiS4g9XEDZZR84NyHD+UaBcjppCAPMD/x0FiAiPKstp2RsaBXORxneaPb6xm0
         sTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025781; x=1769630581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noOMWd8451AiWi9sjesHYL9FiLA2for0VqMOqr/FP1M=;
        b=Dxx9hxTh36rsr6+6N5kWo3zKqNP9A3+gCpJ+7zVmSrMekxUhqHdj9WP38OfOwA/oZt
         Z6exeU82quLzQ2lUkrD9jJhdTn50qoAGRL5SPZY5jgh43ZZp5ubiRSwKKUTOHNz2ntgO
         M48VZ9VdK9rwjw4/5axPwVswH8wvztCNiYfxeFehfih2AHW31sg6A2aS4pemCCu5x2rx
         vlyoBFa3G4czHDuj7jmE1lAHl0p1dv2ZXEifLMj0LyNpD8kL0eCahkfDF5+3NmKnKe0H
         +S3L4h4E+8AJgbPPUIzCMw2DorSA5eSE/4dF6aAO1uSqaC+slh90YlPNmVQE3Mrv3ZDc
         tjpw==
X-Gm-Message-State: AOJu0YyOZ56L5D8MwmTUkfVzKJQEZpJp24uELougUoAJlZlCsvJvtRQZ
	KI9vLIIDKdlRDqV/JktjEaGJzdV9ezLaYQYu1aAQs5otBrrsaaSlanRB
X-Gm-Gg: AZuq6aJBUhq1X7m4+y0TH5Lgs0kgjsc4RXZ+xUZSwIC6e3HbIwx8y+tVl2D2SoVUwkr
	BU8hgpriCKMcSHiPJ1peXsbJAJLmVmaDXC4Is1HEDv0L6cLqJmBJQNGm0RfWJ5FNsdqPTx840wi
	5ZV5MMWTTbO0ABbPINvZjMpEM5+R0IPOmY9ajXD17vlAM7w8Np/Yb+IiNE3QD0Ar+OS9+detZSH
	IcDTyJ1GNuzcliuHxggDL6R0qRUcHC5cSk6zlkRBDVBnMvDaZYKSs080QbJPuRWxTuaB4mouyPw
	gYtbFzaasC4rdk1+QYe0GtoTQkc24mUjlN8xXb8vMmhVyx2EEHdtEmcZW+FrlLe3+zfqLHoDJUn
	CfUet0AoptsaUVJE5wWxb/1YPxnKfDG/m86FDnc+C+yzhnqI4imyC+sArJJp6f1LL1U9Wfs/L4F
	mOqZenjNNaoT70MqV2Lx9Uj5Td10p3aXuHxQiIpp1wg6eJUYCwOuZD+GVUDwO35k4=
X-Received: by 2002:a05:693c:2d8f:b0:2ac:1a21:841d with SMTP id 5a478bee46e88-2b6b4e5b5f9mr12956485eec.16.1769025781007;
        Wed, 21 Jan 2026 12:03:01 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7070eeec2sm6086404eec.21.2026.01.21.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 12:03:00 -0800 (PST)
Date: Wed, 21 Jan 2026 12:02:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Minseong Kim <ii4gsp@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: synaptics_i2c - guard polling restart in resume
Message-ID: <h4k2em6sx5je4yvq26xdelqxxhpnipj6aoq7z6ferpowmfczuv@nib5dh3m45b7>
References: <20260121063738.799967-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121063738.799967-1-ii4gsp@gmail.com>

Hi Minseong,

On Wed, Jan 21, 2026 at 03:37:38PM +0900, Minseong Kim wrote:
> synaptics_i2c_resume() restarts delayed work unconditionally, even when
> the input device is not opened. Guard the polling restart by taking the
> input device mutex and checking input_device_enabled() before re-queuing
> the delayed work.
> 
> Fixes: eef3e4cab72ea ("Input: add driver for Synaptics I2C touchpad")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> ---
>  drivers/input/mouse/synaptics_i2c.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index a0d707e47d93..fc65e28c1b31 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -615,13 +615,17 @@ static int synaptics_i2c_resume(struct device *dev)
>  	int ret;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct synaptics_i2c *touch = i2c_get_clientdata(client);
> +	struct input_dev *input = touch->input;
>  
>  	ret = synaptics_i2c_reset_config(client);
>  	if (ret)
>  		return ret;
>  
> -	mod_delayed_work(system_wq, &touch->dwork,
> +	mutex_lock(&input->mutex);

This can be

	guard(mutex)(&input->mutex);

> +	if (input_device_enabled(input))
> +		mod_delayed_work(system_wq, &touch->dwork,
>  				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
> +	mutex_unlock(&input->mutex);
>  
>  	return 0;
>  }

I made the adjustment and applied.

Thanks.

-- 
Dmitry
