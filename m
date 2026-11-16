Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836343;
	b=lJtBMYgfx2pZ9sIXxhPf7k+xanVGHc7mrsC5hFYTFX59QN6350OAFVyv0hsxpsC3lUET
	 D8iCD1XJ0k0lhR6bfb+fED+utuPdXxuukGbj+CCQVrx1tXf7yJhO9eRZ7b+WJ1jybCYhc
	 iOTDwvW/3Jj39FBvZdOdQzylq73bx3cZ3jNNxrQFg4FZFFBsITijdFjGfKjdYHvD9zyQ+
	 FONCtLH9CLMVDmP2zSEmiQMzIwekAqdmW+es49QqztBoFKN9b/Mpwh4A5l+8ru3Xqi1jX
	 mq9CuwWppQLKwgOPt1lWP9jG+TZ2JtAQGpzZPdtgQ3kQX8CLTfpa+fd6DVB+8Zlsvkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836343;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fGTrvJxk1XcKvqmiuElG56MRwtyi5Y+9HpDAwNsIj0Y=;
	b=oh6bEAgb6x9/7pFDJWwxrSGMpC8IUzW4/mf9jBvLUy62i2GVqtkw+U4cuqePPyvWVNvB
	 X2fpv736DepWTRZAGJTcn9cwPmxlyqV9lkiEOrjD/EaAwX8OLiaVVAgYKUnJpvAvRXJ+8
	 wNSLp2785i7vgObUh8/Dvop6bBNVfWjBR2wpmX+E3LxBikc78Ob5Y8FW1b6ECTPxTFfJt
	 yjJA/vUiyxvvpHfC8xkh0rMqER+kBPgw+eDzhqz1D9S8xDykRCyEPeOuilSyOXITqVMie
	 aG+XmsnQgeAVrcoVxGKxSSYsb6Z2Chkw5rXohoAtvkcxskAw/8q/OF3wF1xcE1DV2GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAfhjZgH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B695606A323
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAfhjZgH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C952B1F000C7;
	Mon, 16 Nov 2026 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836343;
	bh=fGTrvJxk1XcKvqmiuElG56MRwtyi5Y+9HpDAwNsIj0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAfhjZgHnbmUK0hXzD2Z2Tw27RQVgScCv7GzZnMzUFs6ATo9JrlDxJmJc52Vcmcqn
	 4zrorbidz46ZzAIeU+CaEBgQiiGRE7VDZGGMy0kwQg7MXhUcdfgHDtycUlsDzqQVU+
	 dbEFmaX9iJIl5yU9iPPDFEX8Tfi4or0M603OJvWFmWdRzkvfnPaOpJrG1wI+54UHqL
	 raxx4OiLVIITpUw70bsToG8pGCTipWtzPtVmwhqBeWcGo2W58InY3E+H0g9kUaujfx
	 5UrqWTnNAAqih4zdulW/anaeqmR1MQSvfut/j+vvq/khYPS0Wa+4bZEuCdZ0YulKjS
	 gE9h5YZYqpqUg==
Message-ID: <sashiko-outbox-217096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] HID: intel-thc-hid: intel-thc: stop all engines
 first
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261116133132.1282020-4-emfox@debian.org>
References: <20261116133132.1282020-1-emfox@debian.org>
 <20261116133132.1282020-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:39:02 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] HID: intel-thc-hid: intel-thc: missing PRD table reinit in
  thc_dma_configure() [1]
--

commit 68cc7b868e9e15fc7c7b6e500ccb219382a1991c
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: stop all engines first

This commit introduces a helper to clear the start bits of all four DMA
engines and uses it in thc_dma_unconfigure() before clearing the PRD base
address and control registers.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index 704c02822e807..41efdfaf00bc2 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c

[ ... ]

> @@ -518,16 +523,16 @@ void thc_dma_unconfigure(struct thc_device *dev)
>  {
>  	int chan;
> =20
> +	/*
> +	 * Stop the engines first: one that is running keeps writing through
> +	 * a table whose base is already gone.
> +	 */
> +	thc_clear_start_bits(dev);
> +
>  	for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
>  		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
>  		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but does thc_dma_configure()
leave stale PRD table entries behind after an RxDMA reset [1]?

During RxDMA reception, hardware updates len, end_of_prd, and hw_status in
place inside config->prd_tbls, and thc_dma_read() normally restores each
consumed table via thc_copy_one_sgl_to_prd().  When RxDMA error recovery ru=
ns
try_recover() -> thc_rxdma_reset() -> thc_dma_configure(),
thc_reset_dma_settings() resets the hardware ring pointers without
reinitializing unread PRD tables, so subsequent transfers reuse the stale l=
en
and end_of_prd values and can truncate frames or trigger repeated DMA error=
s.

[1] https://sashiko.dev/#/bug/linux-0a97c61f-7f80-4aab-98a8-b9354f3b828e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116133132.1282=
020-1-emfox@debian.org?part=3D3
