Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA91286891
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448411; cv=none; b=U85Vz42RzP4YUlYT6PoIQjNAnxm2qpesd+8gxaMYq+EPmIVm/2ekrrwxQisYVrX7TgVWZtrmScmRH8D5jDd0ifUk9EhYSgSqBcjYwIFJ/t/6UW8iUZLkX9S1Se5eI+Wn0HMdr4Fu0jAxIMow2v3GXZHcnm9cXvOS9eXVbnTHu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448411; c=relaxed/simple;
	bh=NukCw9t72hgYvil/R0gblf5Arsw/bmFSoTQ6ROmLpa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGJvZAhqN22txrd1c3cEfc++JUielrY+BXZXHEwHZ4KVdlY6z+At9kFvNQ1SXOKUBLCG4S5UZprQrG6OOaLJISI94aQ/wCymNR29gihoUp4QBIzZGljFm+Pf590H0K7qInGwibzl9X0horOdmojF6Z+VhL6Z1zXe8QETTSv+hSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyKk7CFz; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyKk7CFz"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30749947917so1962064eec.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448409; x=1781053209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u1boD0i29cvw/FIchBYnDDoFVtHAicV6De2EffESY14=;
        b=DyKk7CFz+60VUf9xFkq2dR+WbDKig3qYbcCH26uYDJGoJrXIMS3cZ8hQb2Z15r3htz
         Xab1l3OHtB9FiOJFtQqHQIsW5fk5vuEmcbGE0PFvBsSii8BdtIlhjhvbHAB7JOwJJFwN
         1F3wazMjt7xiY9Jbhr7ltDsk21lhDjZTVFA7RB0zTC47A4TDn3x6nHvYLNXreQfNLwyt
         V0kyn7Kd+uUkFL3wI4zOxE4zO+59MOv51aloxvl0ycGvoBoXBzgS1NPSgP7iKzhiGqV9
         XWeMzBE0/WeIF0yHki1R1z52I86pmnR9rx2a11+MzDA1s1ufWF7UGbt8FjDZTY0imKAS
         NEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448409; x=1781053209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1boD0i29cvw/FIchBYnDDoFVtHAicV6De2EffESY14=;
        b=LiLDHCr16wJabgghjU/Xf2M+OKmm4NV7O6KZ4kHWu5iMhsjXT2WOhqhtkB+ja7jgOA
         DLXLtf0Wqhfb1O/8sGt3oFmpdOFG9ELsCUaXTEN0/Ap93x/HEHZh5zgShqLDdbvFi+gj
         UCMm30t0mGy0SvShZ9o/cSlFCrmcTGAv8SSRqKnFt+t8m107Kf5mHfQy9s1WwPTGFZns
         PzfswTw11LzOYV975kfE4AkJr6oUlTBSkyeWhYRAHdp50P1InIsVPBd04neoYFO0xwd+
         PZ0l4PYMW5OIl+N/aXfY8s3FV++x2PJfLBbbxrXdVz8o1pUsbP4LttoKcpnqeCZ+2vlC
         7gSg==
X-Gm-Message-State: AOJu0Yxgxtb3M5MCfNkqNQZsquztAeHNogcAxpdHZv8JlHDhrUyMvW8V
	s6zEHiOegMLqHzGRI+daS7wWptnQNlfRWayk59p75NLJuOii78y0B4dyC85NdA==
X-Gm-Gg: Acq92OEYRotnifBm2IWw8PRqVSwOvvxdGMNH2U4CdCg5E7G/JK4k7nsJbq4iwyQ5rUQ
	sAmp61zDqCXrkqpK8wxMwmcFvYLG6wTPgx4MVXkrdXW93918loKxJW8K1tFBwR6icxO9zYyw2g5
	+nIDSGogQkG8EQgcAG/syUjwQpgfsUKXBYXNuE1POc6l1LuSQmciuAuKBhaYvUx1w5ZyTH7nwSK
	7h/3hXawAQMG/bEMdciitnAyIuIYdeR3fkjEmckgx38eJMde3GERXFjVPOYPMU0Q5dc/NmPrqqQ
	y8NabkOEP6n3ICP8xLwm9mTeOeUlE6u6yKHmd+GL87gToXg18eMatat1TlUkCq4uWu898GeO+eX
	+sNFliDrC4c6zY0AqR0VRK3+qh9hy6UEROJQmPHGDSiAd+B+KNPdf52ivUbjddp557ld5/yVPQt
	93dGFZ+nibIziRr7CBbh7S9JijWH5SbSdiFtQJPZptRQrqStbvSOt/K9jxMbUmdeobmiv46bbo+
	ik=
X-Received: by 2002:a05:693c:37c8:b0:304:59cc:aee8 with SMTP id 5a478bee46e88-3074fbbd4e3mr585418eec.18.1780448408879;
        Tue, 02 Jun 2026 18:00:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c4f4:520b:1304:b259])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm1371181eec.13.2026.06.02.18.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:00:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:00:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?Q?Rapha=C3=ABl?= Larocque <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - retry SMBus intertouch setup when
 companion is not ready
Message-ID: <ah96mP0RsFT8JNnC@google.com>
References: <20260603002046.10697-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603002046.10697-1-rlarocque@disroot.org>

Hi Raphaël,

On Tue, Jun 02, 2026 at 08:20:46PM -0400, Raphaël Larocque wrote:
> On some machines (here: Lenovo ThinkPad T440p 20AWS0H800),
> the SMBus companion device is not ready
> by the time psmouse probes the Synaptics touchpad
> during early boot.  synaptics_setup_intertouch() returns -EAGAIN in
> this situation, but synaptics_init() previously treated this the same
> as any other error and fell through immediately to PS/2 mode.  As a
> result, the touchpad and TrackPoint were unresponsive for several
> minutes after a cold boot, until an internal reconnect cycle (which
> already carries retry logic in synaptics_reconnect()) eventually
> succeeded.
> 
> Fix this by adding an exponential back-off retry loop in synaptics_init()
> when synaptics_setup_intertouch() returns -EAGAIN: clean up the failed
> state, sleep for 500 ms on the first attempt doubling each time up to
> 4000 ms, then retry.  The worst-case added latency at boot is ~7.5 s
> (500 + 1000 + 2000 + 4000 ms), and only for hardware that actually
> reports SYN_CAP_INTERTOUCH.  The pattern mirrors what
> synaptics_reconnect() already does after resume.
> 
> Tested-by: Raphaël Larocque <rlarocque@disroot.org>
> Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
> ---
>  drivers/input/mouse/synaptics.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index c70502e24031..5c1bfff2b16c 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1918,6 +1918,23 @@ int synaptics_init(struct psmouse *psmouse)
>  		}
>  
>  		error = synaptics_setup_intertouch(psmouse, &info, true);
> +		if (error == -EAGAIN) {
> +			/*
> +			 * On some systems (e.g. ThinkPad T440p) the SMBus
> +			 * companion device is not yet ready at boot time.
> +			 * Clean up and retry with exponential back-off,
> +			 * mirroring synaptics_reconnect().
> +			 */
> +			unsigned int delay = 500;
> +
> +			do {
> +				psmouse_smbus_cleanup(psmouse);
> +				msleep(delay);
> +				error = synaptics_setup_intertouch(psmouse, &info, true);
> +				delay *= 2;
> +			} while (error == -EAGAIN && delay <= 4000);
> +		}
> +

The idea here is that if adapter/device is not ready we leave enuough
"breadcumbs" for it to recognize when SMBus companion appears and
complete the initialization without repeatedly cleaning up and retrying
initialization anew.

Could you enable logging and see where the logic fails for you? I am not
too keen on simply adding up to 8 seconds delay to the boot time.

Thanks.

-- 
Dmitry
