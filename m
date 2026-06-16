Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC93CFF55
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635794; cv=none; b=kKej3UhfHYEcUUwewcH7392ptvKopjfkykVrub6M/OE363qtPgYxnCP09GPLJiM3RY5csZTYeEJTWN3/jTIouyINJoZc4qlJbuBJouIAPnHsQGAYRqMrFFi00NAWYI/tTv/SGaoUvtXyHpNPSvE2GdTS/AuxJAy0cB61VBz7GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635794; c=relaxed/simple;
	bh=MRcPwhUY2w+G8cBcZcnK8iiNiaHrKIQXEd36cCtMaFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSb6SeCow7Y21YlqAfXihRf/EsZPrl31L+8kd/9jwbLuA8xrYJ9Y9CcMAuwo/PLZgrfJvO1CLVjnxt2nghzsymf8E7PkdsAvkSNPCiE4IIoeIlL0so9AtKIuUQxGYR3PwJaBJcX1igd19CDKMRVhKPRO66f4yAn8H8nFDB6giog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVQvd9sk; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVQvd9sk"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304e83724bfso6803008eec.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781635792; x=1782240592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eOn28KRGkY3jymFxAfK+tZ04dmjR+0RDYQJz5N/KHF4=;
        b=LVQvd9skR/z2PdBGPAL4M5Nl6+ZjAkc5x4EQd69sc6bt50RHbn2p7AHDMJBDIaNvq1
         xyuVx+5AYJo9sqP8YsLs1qPrczbEb5epGO4itVkSAUaoNCQ1zusAllF1DXnjY1BX6eAZ
         9ZaTTm1FbRctVf+OIGNGcMvL14VmM683tJrCWAwxFTPs23/EX62AToZZG3z1WQ9HRRK+
         zAgAWbBXcecnJNTmBStpEJRE6gTdRObms8Z4PSjhGBjgrb7K/9eZuiYrsEvEXw6lGRod
         HhqOk4gqP9MlyO6pibqo83qNIYLHokI9LrtntYo9O5ky5BQiI5RlERmti6FFl6umYN3q
         uGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635792; x=1782240592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOn28KRGkY3jymFxAfK+tZ04dmjR+0RDYQJz5N/KHF4=;
        b=c6pqC+2bDieFMFX1ulK3B9UBzHJHLN55+VfnGSKHg90Fg5jsnFIkKDLv7e4AoIzRjA
         h6Ch9EZ3qYyp6iExT3CJ9RqOgl+5SG/JmCpFTT2b3bpiXHrbgn5TxZ6ZmLHo+foIa+8X
         5f853oc2sbTlj4nQcfv8cSqdbDLQZCj9eNzNLn483GQRL6ewD70vJgil0j9ezgKcrMGQ
         eBXUOKI0KA0sLCEitbYvOmCky+MmGds9DuRLbffwovy4xxaXEib3+vnf2Wu3edjvmkNi
         KqNwxbJIJdbTgV+TUh8Wov9LwaqXtLf3bDXpfEAH2iVGHNG9MSRJWU/9h6UK5pGj6jXk
         n3jg==
X-Gm-Message-State: AOJu0YzACybZgRY46S7hXQKb7H1v1IDrYLXT80Ta5zXoRojAOs0Bg+8m
	aS1EbirNs+J0OSOohmL51OF05ymHuxoro3/H7ClADS/OMtOeDfzCrS+qyMgezg==
X-Gm-Gg: Acq92OFQQpGztKLTCuvXFOuNVbj41Wzm36OUcufUqusDRJU3OC6V8CaPV8wO2dWPVN7
	VRe2dULYePiCWzmtn8jW7Glgec/Q6p9yK1pufJ+jelPNSL8aXr/Z2TRY36r0y92sKFEQhMSeLt7
	SZfYnsnp6pstgMHm/TqwJLWu5Lc4jHUYPgCIjelArbl5Ni+KJ57hfe09dj498uTS2OqoLKjJxTP
	cGQWAgULtbOSvSKWUgGhwOt6kfOZOQuJIQ0EoPNarP7LQIApjZ4yr1SZ0T+5Jv9xO8vyg603C4c
	8SOTNK3UKgNA9Ohe5J3xsiAQhCa9I4ujWJGS5g2aU+CvZNSvXn1AxvRByIuJfMWJ5H749Drxh5c
	ocpLSsftE0N9PuzqBCyrKhZQKTFs1Xl7KkfLdwWXpHZDcHTO5hV4Ihlg9BC1Kvh1kYVBtHsZd6w
	3QKM3g6+kdMI7QV/0ISi0Ne9LIeF2KkegIT8iQpWdXa6URpI/8/VvTMVdMjcSDW4U=
X-Received: by 2002:a05:693c:2d8d:b0:304:ccdd:594a with SMTP id 5a478bee46e88-30bc9aa99cemr397134eec.5.1781635791823;
        Tue, 16 Jun 2026 11:49:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:cbae:d24:189c:2cb9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm22178268eec.7.2026.06.16.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:49:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:49:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?Q?Rapha=C3=ABl?= Larocque <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p
 (board id 2722)
Message-ID: <ajGaB1eqn8GeGW_A@google.com>
References: <20260616171137.19069-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616171137.19069-1-rlarocque@disroot.org>

Hi Raphaël,

On Tue, Jun 16, 2026 at 01:11:36PM -0400, Raphaël Larocque wrote:
> The Lenovo ThinkPad T440p (PNP ID LEN0036, board id 2722) has a
> Synaptics touchpad whose SMBus companion is not ready at boot and
> takes roughly 200 seconds to appear. During this window the touchpad
> and TrackPoint are completely unresponsive on approximately 50% of
> boots, making the machine unusable until the companion finally
> registers.
> 
> The device is in the topbuttonpad_pnp_ids[] SMBus allowlist, so the
> kernel attempts to use SMBus/RMI4 mode by default. When the companion
> is not ready, psmouse_smbus_init() leaves breadcrumbs and returns
> -EAGAIN, the PS/2 fallback path is taken, but the device does not
> function properly until the companion appears and RMI4 takes over.
> 
> Disable SMBus InterTouch for board id 2722 so the touchpad and
> TrackPoint work immediately via PS/2 from boot. Users can still force
> SMBus with psmouse.synaptics_intertouch=1 if needed.

Is this board ID unique to T440p? Or it may be used in other devices as
well?

I also wonder, if you try loading psmouse later in the initialization
cycle, after SMBus has been loaded, if that would help it detect the
touchpad quicker? Is there anything interested in DTS regarding device
interconnect/hierarchy that we might be missing?

> 
> Tested-by: Raphaël Larocque <rlarocque@disroot.org>
> Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
> ---
>  drivers/input/mouse/synaptics.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index c70502e24031..8f38bc498798 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1837,6 +1837,14 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
>  
>  			return -ENXIO;
>  		}
> +
> +		/* Disable intertouch on known-broken board revisions */
> +		if (info->board_id == 2722) {
> +			psmouse_info(psmouse,
> +				     "Disabling intertouch for board id %d\n",
> +				     info->board_id);
> +			return -ENXIO;
> +		}
>  	}
>  
>  	psmouse_info(psmouse, "Trying to set up SMBus access\n");

Thanks.

-- 
Dmitry
