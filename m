Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699380;
	b=Iaxvtpd85aMlgFmzKpsrpQ6NRlzCq6K2Gtfrz7S2OdX+32DlaWiiIP12+KClHyTdBfTs
	 NcuGha+cj+lWLVwE0qyxjWphi7lkgaqPtSpr1bBL/EFIKYWM8igkhWLH/NlNlzhLqa7z6
	 yFUBRBfHO5fNT52dCdjR7z7Jtwe8L9f5WYjoHwvopPg34k7m25tBLbY6DjDr+ebC+J+oz
	 vQigx+LIaFf9dwFPYQXG6jqBHQU9WjpkrM35ez6LLhSh1bx81xU5dlvSMhjrWJQkwAynE
	 1yBYtOmUUZvdzUjadlvWksudvgtSyCUSTLgqomQv4SE3Iv9C7+8Y5733LYhkCESrP8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699380;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lEneLf2GwRI9nZaCaoLmcwXxk+CQbiiCdw68oS70B5E=;
	b=4Wx3aYN+e34wW5VHJolycKFhcOtT5KQhWB8WiTo70bvqA+Vz9RZ5agop5gxTALYZsNyk
	 PtEAzI1zD5ZAYP32F6+QujM8QMU4zTicpWtjWovTyyZmRHdCku6x7l7jFpwa3LE3bJMoo
	 X0RLEoHkwyILP2JjmcfTkHkSWqqSBBM4VAhuQo05weFF1GgacvIFnOknPBGtH0/Z3HOMW
	 bSi1O8H/nLrYpvnkwtV2ZxqQThqOITxuwLdZ8StGI7vvwzqoffEVnLJ9JkEzhfjTeG/Dv
	 hbGN1dJH+yDDFq+zP7p6MiqcW4eZ1U0ViFXfVyJq1Fo8LXZfdzQRI6kWAB85Ihuu4mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx+V1eVe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A47606A329
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx+V1eVe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1591F000C4;
	Sat, 14 Nov 2026 23:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699380;
	bh=lEneLf2GwRI9nZaCaoLmcwXxk+CQbiiCdw68oS70B5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cx+V1eVepK9U+OJq3D+e8SRebrrsVlLjkMZ0d5Ow6jAme//o5Oa5tWKnoCdm1AzV9
	 E+t3yACSbkEUmWRXlWzaOT+w4ns9sKpirWMwO+/AqY44JRZmSB5UBexy/qg9mrEw8R
	 5zIyA/gSJS8KxnwlcVExm4K1HCCAoc2HAXlgh/dro25m34446AS7XUCKjhj7Zz21kv
	 3jhwdS5zvYnopZS9azFoZrQQ1nykiEJIUK23icI4PdmM/W7X9yG1X1b6g4M4RIcRjI
	 V+adw/7dVf1uvy+JGn6p2luWlhOZcngluiM5PEfQ1honRf3PjJM1/vuob/pFnDNYjc
	 my5373DCnvMFw==
Message-ID: <sashiko-outbox-215114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-thc: rewrite PRD tables on
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114231733.3916070-1-emfox@debian.org>
References: <20261114231733.3916070-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:36:19 +0000
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
- [Medium] HID: intel-thc-hid: unrestored PRD tables in
  thc_dma_configure() and SWDMA
- [Low] HID: intel-thc-hid: intel-thc: missing Fixes trailer for
  thc_rxdma_reset()
--

commit 04ab3731a88872f9fa6c5a799a58023acbbb1866
Author: Emfox Zhou <emfox@debian.org>

> HID: intel-thc-hid: intel-thc: rewrite PRD tables on reset
>
> RxDMA reset takes the DMA configuration down and puts it back, but leaves
> the PRD entries as the controller wrote them. A frame that was queued and
> not read keeps its shortened length, so the next frame runs past the end =
of
> the table: the controller reports a buffer overrun, which is a transfer
> error and leads back into the same reset, with the tables still untouched.
>
> Write the receive tables again while both engines are paused, before the
> configuration starts them. The configuration is the wrong place for it: on
> resume it runs with a frame that arrived before the suspend still queued.
>
> Signed-off-by: Emfox Zhou <emfox@debian.org>

[Severity: Low]
This fixes the missing PRD table restoration in thc_rxdma_reset().  Should
it include a Fixes: tag?

  Fixes: 1d46b8d40655 ("HID: Intel-thc-hid: Intel-thc: Add API to reset rea=
d DMA")

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index c80ef8c205742..28a1aa97b69b1 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c

[ ... ]

> @@ -598,6 +601,10 @@ int thc_rxdma_reset(struct thc_device *dev)
> =20
>  	thc_dma_unconfigure(dev);
> =20
> +	/* Still paused: the configuration starts the receive engine again. */
> +	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA1]);
> +	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
> +
>  	ret =3D thc_dma_configure(dev);
>  	if (ret) {
>  		dev_err(dev->dev, "Re-config DMA failed during RxDMA reset\n");

[Severity: Medium]
Should thc_copy_sgls_to_prd() also run when thc_dma_configure() and
thc_swdma_read_completion() reset the ring pointers?

The commit message notes that thc_dma_configure() runs on resume with a
pre-suspend frame still queued, but thc_dma_configure() calls
thc_reset_dma_settings() and dma_set_start_bit(), which reset TPCRP to 0
and TPCWP to THC_POINTER_WRAPAROUND (0x80).  Because is_dma_buf_empty()
treats that state as an empty ring, any unread frame is discarded from the
ring while its shortened PRD entry length stays in prd_tbls.

If an unread frame or DMA error occurs just before quicki2c_suspend() or
quickspi_suspend() cancels recover_work, resume calls thc_dma_configure()
without thc_rxdma_reset(), leaving shortened PRD entries that will trigger
a buffer overrun on the next larger frame.  thc_swdma_read_completion()
likewise resets TPCRP and TPCWP on THC_RXDMA2 without restoring its PRD
tables if a frame arrived just before thc_swdma_read_start() paused RxDMA.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114231733.3916=
070-1-emfox@debian.org?part=3D1
