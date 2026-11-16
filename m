Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836982;
	b=laiZakwF+pPSf3KDSWV7iXGsqlk80lQ5LCYbWVnsnM+dMZGlTKOjL7U2h2960aKn81oV
	 yjbceiz77Bywy8APxBzNXJ/TvYlROsv7mxuL+RXlQ4GGjZbgNvQzBhrRQ06FC8awYV6aR
	 CXJfrw573ItIyOcABxRHqySdZJ60tKMBHFkboYv4DY7RYwmjD2G4bUuU0fRVq0T8C5BRo
	 f8IFBvVw63InEWAQIkidXjw+zxvCrkSeias1SqNWahA1zeTumGoq+5dZ7JDL6nGmN0zrr
	 0KsBOugM8VFAj/scraphHQkQ2kjvXM5UW1uLuljXFjXU4Xl6yVJmf4JMA+eFgqIqbHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836982;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=koovYu268jYQCkGtEL00S+OjBhfcV4jtlqUtaTXqSlQ=;
	b=GSKGb7tXqQ0LXQ1u78Un77uSS95qcT+lZ2regwr2G37wR1kVPD89Ek1tuQC+7BN+vWnv
	 9G0vDiz80Yf0OFC6WTjUeS4VHf1wMMnPEtZtyGONS6/IUmiB8P/FUCEpt1DhCLxDppoIf
	 wdoJ7Xu0aXxL/tbt/CD+VdMVPMrd4sDppJsPoVMQx3jjXhSxT1lWjySUptBAgkZQJ2sdr
	 biul2JtOU48pRNJ2fsuBFoy9Ggrf5Z4tePuR4WbAUgIRUPYMeDVE39V6VDWaEsD0o429P
	 ZySjyokUvmUmOVyHKa6H/XyHl2nuUVjHkzBuLbKxcX3HQjGcVOrgJJqntABmtY0aGqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b8o12/zU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39330606A335
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8o12/zU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D6F1F000C4;
	Mon, 16 Nov 2026 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836981;
	bh=koovYu268jYQCkGtEL00S+OjBhfcV4jtlqUtaTXqSlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8o12/zUBtDuJ3jLD4ypn74L7fyHXhfrTC3gx5OtBOjODbH/cXmqZahcw/tmuriuP
	 PFEpHdX1VmPPPNUwwP2JxJBOU1km7uKoCf9oXN/oRmHHl1gUKV37M1U2NLjVCqWyme
	 0AWscnIeOnb214qmeEfVl86FXvi6TxYua5jp7zZDbde8DkVHnLIG1QEgT01zHwJxhW
	 7U06P5KhYlB2xYhXM/bxhpzLI8cHIa2b8sG7XctvV/WkDYQ4l3L5jEM+OnJvB65/r9
	 fJhyyCSzqXYuc9UNlLYKLIFFKc6ZtXsdDgn2Mk0lrm7u5PMzAXz6dBE3winGFgkqHQ
	 BJOT3JVY7qffw==
Message-ID: <sashiko-outbox-217112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] HID: intel-thc-hid: intel-thc: keep TxDMA write
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261116133132.1282020-2-emfox@debian.org>
References: <20261116133132.1282020-1-emfox@debian.org>
 <20261116133132.1282020-2-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:49:41 +0000
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
- [Medium] HID: intel-thc-hid: synchronous block in
  quicki2c_hid_output_report() [1]
--

commit 7d6243e52aaa280fbfaad43053698624190f219b
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: keep TxDMA write errors

This commit waits uninterruptibly for TxDMA completion in thc_dma_write(),
wakes all waiters on write_complete_wait, and preserves the write error code
when unquiescing interrupts during cleanup.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index c80ef8c205742..c0dc44e26e0ac 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> @@ -1045,8 +1045,9 @@ int thc_dma_write(struct thc_device *dev, void *buf=
fer, size_t buf_len)
> =20
>  	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_TXDMA]);
> =20
> -	ret =3D wait_event_interruptible_timeout(dev->write_complete_wait, dev-=
>write_done, 1 * HZ);
> -	if (ret <=3D 0 || !dev->write_done) {
> +	ret =3D wait_event_timeout(dev->write_complete_wait,
> +				 dev->write_done, 1 * HZ);

[Severity: Medium]
This problem wasn't introduced by this patch, but does calling
thc_dma_write() from quicki2c_hid_output_report() violate the HID
output_report contract [1] by blocking the caller?

The HID subsystem requires the .output_report callback to be asynchronous,
yet quicki2c_hid_output_report() -> quicki2c_output_report() ->
thc_dma_write() acquires dev->thc_bus_lock and blocks on
dev->write_complete_wait for up to a second, stalling the calling HID core
workqueue or thread.

[1] https://sashiko.dev/#/bug/linux-84fcc3fd-7b0c-485b-9da1-a71ea67e4f5e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116133132.1282=
020-1-emfox@debian.org?part=3D1
