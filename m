Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE30470111;
	Tue,  8 Sep 2026 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903986; cv=none; b=i/AOArz4qcXf9dKklxx4M8UCBZmxN2RsSqV48nRSilmYQmvXwiKIKWcFJ3Xz58AElxy10KS3FLA6X6gJQfMMtjYH2A4ynNtsCbQdBfJ4iiDy/bXn6AOMiCV5Sqo9Dq05o30k0YzgUCdCqx+OkPpy0KRBRHzwuCgT4GY43BqtN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903986; c=relaxed/simple;
	bh=Wo0ZL3M+Wywg41LZ2lwCb4eKYlm6h4hOEsw4Jfr5HHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLtAyCKgKNNsKf6wq/S3YOa7k6yRD7y2nRbmr9W/B3IZAy62WShgUhXCaZRtqXvfA3PPi/CS3GvecjdmTQUrhuuazfdgAQg+UAfHYxsGfRPZX2LS8Ij16uYuujAwtcPreyT5CwRgtyT+1u+hT0N/Hf2yItSnXT9xAK2GkTehmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn9HoA7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn9HoA7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A671F00A3A;
	Tue,  8 Sep 2026 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788903985;
	bh=xDFCn0lNPOgF6i1hXkAPNA/hzn9F1hmDV3HSMIXSq0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nn9HoA7/zv9eZsVfjPpLIaUXQ1AcSJn3gqPzs9xYEePlkOn7S0lvlYywod2dHun3L
	 foerzEURPNeUMkpPX/0fJgpvnW5hanvxrEMKuH+5BipFzkhtUjfL7RJHg8bxyCxVFz
	 Qs4Fb1Kcy0XI7zKBZQQRzxgZNeBelnZNCaQ9inRYkvP3lamuwe+kFhHQR4RtoDs4nn
	 q6ycyvD7WLV3dnYJSSDDKX1cRjwq/bDyb6BhqZEJ0UWt+ONgmdGgJ+SGY3ItqXpHXy
	 mir2VMg1aCcwiW8Dc0Shrem2bALxQXlyj+Ju3HrtJHnpCuKIhPWYzFchgVT7e6dms4
	 8I6eUApzOaZzA==
Message-ID: <0fe7a8b6-f3df-4822-a03a-d072b86cdfa8@kernel.org>
Date: Tue, 8 Sep 2026 23:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: soc_button_array: ignored -EPROBE_DEFER loses the buttons on 68%
 of boots (Surface Pro 11)
To: Sergey Lebedev <lsa.uz@pm.me>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260830141355.55898-1-lsa.uz@pm.me>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260830141355.55898-1-lsa.uz@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 30-Aug-26 16:14, Sergey Lebedev wrote:
> Hello,
> 
> On a Microsoft Surface Pro 11 for Business (Intel, Lunar Lake) the power and
> volume buttons fail to appear on most boots. The probe runs, gives up
> silently, and the device is lost until something rebinds it by hand.
> 
> Measured across the 40 boots in this machine's journal, using the monotonic
> offset of the first "input: gpio-keys" message:
> 
>   driver attached on its own   13 boots   at 1.28 - 1.78 s
>   did not attach               27 boots   68 %
> 
> The timing is binary. Either the inputs appear at about 1.3 s, or they never
> appear at all - no intermediate values in 40 boots.
> 
> Where it fails
> --------------
> 
> Nothing at all is logged on a failing boot, so I built with
> soc_button_array.dyndbg=+p on the kernel command line. On four consecutive
> failing boots the probe printed exactly one line:
> 
>   [    1.286567] soc_button_array MSHW0040:00: OEM Platform Revision 129
> 
> That eliminates most of the possibilities:
> 
>   - the probe does run
>   - it passes soc_device_check_MSHW0040() - oem_platform_rev is 129, not 0
>   - it passes gpiod_count() - the dev_dbg("no GPIO attached, ignoring...")
>     would have printed with dyndbg on, and did not
> 
> By elimination the buttons are lost inside soc_button_device_create(), at
> 
>         error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index,
>                                        &gpio, &irq);
>         if (error || irq < 0) {
>                 /*
>                  * Skip GPIO if not present. Note we deliberately
>                  * ignore -EPROBE_DEFER errors here. ...
>                  */
>                 continue;
>         }
> 
> Every button is skipped, n_buttons stays 0, and the two returns that follow
> are both silent:
> 
>         if (n_buttons == 0) { error = -ENODEV; goto err_free_mem; }
>   and
>         if (!priv->children[0] && !priv->children[1]) return -ENODEV;
> 
> which is why nothing reaches the log.
> 
> The GPIO controller here is INTC105D, five gpiochips driven by
> pinctrl-intel-platform. Both that and soc_button_array are modules in this
> config:
> 
>   CONFIG_INPUT_SOC_BUTTON_ARRAY=m
>   CONFIG_PINCTRL_INTEL_PLATFORM=m
> 
> A manual bind always works: 25 unbind/bind cycles at runtime gave 25
> successes and 0 failures. The failure exists only in the early-boot window.
> 
> One hypothesis, tested and wrong
> ---------------------------------
> 
> Since both are modules, load order looked like the cause, so I tried
> 
>   softdep soc_button_array pre: pinctrl-intel-platform
> 
> verified applied (modprobe --show-depends inserts pinctrl first), with the
> rescue that normally binds it by hand disabled so nothing masked the result.
> Five boots: 2 successes, 3 failures - the same rate as before.
> 
> pinctrl_intel_platform is a dependency of fifteen other modules and is
> loaded long before either way. softdep orders modules; the race is against
> the asynchronous probe of the individual INTC105D:0N devices, which register
> their gpiochips at their own pace. Reporting this so nobody else spends the
> evening on it.
> 
> Why no patch
> ------------
> 
> The comment says -EPROBE_DEFER is discarded because Intel uses "virtual
> GPIOs" that never materialise, so deferring on them would hang the probe
> forever. A fix has to tell that case apart from a controller that simply has
> not probed yet, and I do not know which signal you would want to use for
> that. Guessing would risk reintroducing the problem the workaround exists
> for.
> > Happy to test whatever shape you would prefer - the machine is here and I
> can build and boot kernels on it.

Thank you for your detailed bug report. I've just submitted a patch which
I believe should fix this:

https://lore.kernel.org/platform-driver-x86/20260908214410.70422-1-johannes.goede@oss.qualcomm.com/

Please give this a try and confirm if it fixes things.

Regards,

Hans


