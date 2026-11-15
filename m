Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716784;
	b=DJ9tB0DDt/lyGhU2PaW0XuP45zcA3lhhr/q3AdtnJspQjUNxttMI6MaQlKid21jGcAGp
	 pIx391aVZJ/bTkIgEKwZEUwbLl88ul3hUniNjgH+OwbkOx3kDRW9ogV5tv7VU0UMAeIDI
	 bBo29COB146fsH7HevhPH3mUYM6DHT9CDvSyDsyQZySIxssUgjJbGkPIJdMYrbr6KPnj/
	 yqWr4bX2Ld2TeGm+QeeOZykIo5hzxFw4gWv10nXW5fnjF1M1LdoTCw8q9+nhNsX1+/ZX+
	 tMhbZqVLdZnBhnKvhgS+CsRndkxjHNL7rY/0rEW5yJKLc72NcR/Rj2C90T68LcqeZgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KvDRT8fYPlfjUdlGIuJ37hFVoKfyYTemCD84uDS9WoM=;
	b=OpiKVKohVsZWmXkj9q7IAPQgoHHOeEqLViiFzPcvrCbnROVjV/J7Wr/yXMWXxT4X/fo7
	 ZF6/JiMb2keCnsfL9HJeRKoNS+lZnw2ndAMv5d6doxvA5YNkALXQ/+5S4vrZW5nnAChcX
	 FTT7W1QIePLwnA1aPzdZ3//NTbbZ5dVnN6j3OW4TM2mDc9IhKwtAPPQJLT05zVCEvMqv+
	 F8VN3NeGdcgtRh3gJbkR+HVFrviCA6UEmto0uG84kV2UF010f9zlvVzUFz++4fFq8tesY
	 jexdjcHA0FtdSo6Y+Qp1Zc0CMJsGUK8987CzbjCFfjzswl84r1id3TwCFzvbF1Tv/yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HcyaLyw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06674606A323
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HcyaLyw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692D11F000C4;
	Sun, 15 Nov 2026 04:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794716783;
	bh=KvDRT8fYPlfjUdlGIuJ37hFVoKfyYTemCD84uDS9WoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcyaLyw/s8j/InOxFxypvLla6Wjr9reVlZuN9VdGd8s7qndq5HAQkyycL1KgX8JLo
	 mPgjcahxlxqHh3PJF6jH3+SLVbK35vDBVVN9hCnW3gruCqKO2jVzrdRIygixJnZ8C9
	 gfaTjioutblAUAX+2UYOMnsvZqR6tqy+YNJxstP78rSvFPkO9NRopMzemlV/D6GZzO
	 vf5UpHwGyoa6l7Z6+EBWldkZsYGokOZ9niIzJ4PdmmWExjKzHM0bc2xi1qLzIHePuN
	 /lRfkmYRmakv/UxbK5qzynLrCXpKWZ22dk7zpVzs8xb4EZOAUJWbxGD87mHPwBQOyo
	 DaxQICDPBPTxw==
Message-ID: <sashiko-outbox-215221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: intel-thc-hid: intel-thc: restore PRD table
 capacity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261115040756.602092-1-emfox@debian.org>
References: <20261115040756.602092-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 04:26:22 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] HID: intel-thc-hid: missing THC_SWDMA PRD restore in
  thc_dma_configure()
- [Medium] HID: intel-thc-hid: un-restored RxDMA2 PRD capacity in
  thc_swdma_read()
--

commit dd12d53039d8c9ed77913f6942ca6c87e513e4db
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: restore PRD table capacity

This commit restores the PRD tables for the THC_RXDMA1 and THC_RXDMA2
channels in thc_dma_configure() after rewinding the DMA pointers and
guards thc_copy_sgls_to_prd() against disabled or unallocated channels.

Link: https://lore.kernel.org/r/20261115001100.313270-1-emfox@debian.org

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index c80ef8c205742..64fd890e5a583 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c

[ ... ]

> @@ -491,6 +494,10 @@ int thc_dma_configure(struct thc_device *dev)
>  		return -EINVAL;
>  	}
> =20
> +	/* Pointers rewound, entries still short: restore before restart. */
> +	thc_copy_sgls_to_prd(dev, &dma_ctx->dma_config[THC_RXDMA1]);
> +	thc_copy_sgls_to_prd(dev, &dma_ctx->dma_config[THC_RXDMA2]);
> +
>  	for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
>  		dma_set_prd_base_addr(dev,
>  				      dma_ctx->dma_config[chan].prd_tbls_dma_handle,

[Severity: Medium]
Should this also restore dma_ctx->dma_config[THC_SWDMA]?

thc_reset_dma_settings() rewinds the read pointer for THC_SWDMA as well.
If thc_swdma_read() is interrupted or times out in
wait_event_interruptible_timeout() after the controller writes a shorter
frame into THC_SWDMA's PRD table, thc_dma_read() is never reached to
restore the entry capacity via thc_copy_one_sgl_to_prd().  Subsequent
larger SWDMA reads will then fail with a hardware DMA buffer overrun even
after thc_dma_configure() runs.

[Severity: Medium]
Does the thc_reset_dma_settings() path in thc_swdma_read() also leave
THC_RXDMA2 PRD entries shortened?

thc_swdma_read_start() pauses THC_RXDMA1 and THC_RXDMA2 and calls
thc_reset_dma_settings(), which rewinds their TPCRP pointers to 0, and
thc_swdma_read_completion() resets them again before restarting
THC_RXDMA2 with an empty ring (TPCWP set to 0x80).  If the controller
wrote a short frame into a THC_RXDMA2 PRD slot just before
thc_swdma_read_start() paused the engine and before the IRQ thread
consumed and restored it via thc_rxdma_read(), rewinding the pointers
makes the ring appear empty without restoring that PRD table, so the next
larger input report on that slot will trigger a buffer overrun and forced
reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115040756.6020=
92-1-emfox@debian.org?part=3D1
