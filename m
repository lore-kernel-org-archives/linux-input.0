Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794693275;
	b=rxtD63eXEFYMkXtChIj0s8d8E91IrJjmB8bGtHbuAgugttGTOuYLzz5bqRg/T1exHjl4
	 2i4cGhClAFxIfLqnf/m0IYe9saxTBH3t4t457PKWtHGg4ILHMHLn/xj2DfTc+7YSDNray
	 yF1shQeEsch70mLZZFy/KHVuiIkGwESPtYcXzTDiTLDB2Q7FwsLwSUilqFkRbIjrCLxTm
	 ip1/vxVb5+r0BR3I6juLm4M385WOpTccfw7DJ/BI0AAdiBwchZyfL7yFKwhFlF6djb+SC
	 Lnae9L/ip+6HzzN0vWFdevygsDf5AGNVdzUUb5L795RmllpQ0qYdsHaAi2I78JeBVxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794693275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/xbXRuwZMbZHWtIxB87EVqOBMsMu+ke85rahMTcHQmk=;
	b=kqjB0uiU8ZhaDAvcu2LWtwVVY0dh/DGnVCWf/psx/uKvYEHtEOvY7DKHrihyy1A9J5Z5
	 pPNMdU9N7QZeqs1yIaxRLo6xp7TaPo9FcApQS/eeR8cYBUPVDbV1rtLmyVoC9S9cWCqsA
	 G/8s5w7z6UwpiG6/LUauvTQRVPYdCM5RY5+Ch1a0vDk6yzxDlAn8tdFVflJ+7bypMOzug
	 qbmDCOE0dYkyiUJYjexK57ypR2WmNCYE46vdEXNKFqkyXjvH6l85KW7pn3fdoWZVhGtwU
	 BM740pzlsERzelHQ02Dq4JllW0PpukEWstacTdHuAcOYOcah/H0/rq0Mr+obdrj6Xyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S9/SRo57";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE09606A32E
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9/SRo57
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50F51F000C4;
	Sat, 14 Nov 2026 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794693275;
	bh=/xbXRuwZMbZHWtIxB87EVqOBMsMu+ke85rahMTcHQmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9/SRo57XCT1xqa9tKdDDeDxktjzsNmWWWrSz0EmFVEgMfNfDY1fHTrUHy9c6XeUK
	 A66xmFD8urx5MMkvzts86pQri+CMB8DRzMRI//D+5gUoSyg+zKBO+8/C68RMcCjzl1
	 kXOseZT0LOBphgW99hUszUrotas3u1MtM+HSbSW9taN2lCHF4oGaKqwRimhuUG2jn6
	 x91fZU9nQ00MmSH5+c7d4H7pV6NQjHj5Jh9J/pA5rTIMjx0DRfgBML+CBxvHKNXUcw
	 ss9nzbtegYTTq9jr2QF9fdCh5sPoekggCuKHQqOUMKFetYu7eEO2rP+Til4JHEQSWJ
	 OGurVa4YyVlGQ==
Message-ID: <sashiko-outbox-215052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] HID: intel-thc-hid: intel-ipts: register the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114214026.2809740-4-emfox@debian.org>
References: <20261114214026.2809740-1-emfox@debian.org>
 <20261114214026.2809740-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 21:54:34 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: intel-thc-hid: broken feature_seq check in
  thc_ipts_get_feature()
--

commit 933c7f8eb6c2821b64a9386be774666dc0883345
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: register the HID device

This commit registers a HID device for the IPTS port and implements report
descriptor parsing, input report forwarding, and raw feature/output report
requests over DMA.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index b48199448dbec..80973944a8994 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> +/* The report is collected in a private buffer; the caller copies it out=
. */
> +static void thc_ipts_feature(struct thc_ipts *idev, const u8 *data,
> +			     size_t len)
> +{
> +	if (!len)
> +		return;
> +
> +	/*
> +	 * A request that timed out is dropped by the sender, which may be
> +	 * asking for another report by now: check and copy in one step. The
> +	 * serial number tells an earlier answer from the one asked for.
> +	 */
> +	spin_lock_irq(&idev->feature_lock);
> +	if (!idev->feature_pending ||
> +	    (idev->feature_id && data[0] !=3D idev->feature_id)) {
> +		spin_unlock_irq(&idev->feature_lock);
> +		return;
> +	}
> +
> +	len =3D min(len, idev->max_rx);
> +	memcpy(idev->feature, data, len);
> +	idev->feature_len =3D len;
> +	idev->feature_pending =3D false;
> +	idev->feature_ack =3D idev->feature_seq;
> +	WRITE_ONCE(idev->feature_done, true);
> +	spin_unlock_irq(&idev->feature_lock);
> +
> +	wake_up(&idev->wq);
> +}

[ ... ]

> +/*
> + * A feature report is not pushed by the controller: it is asked for and=
 comes
> + * back as a frame of its own, so the request waits for the handler.
> + */
> +static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char rep=
ortnum,
> +				u8 *buf, size_t len)
> +{
> +	int ret =3D -ETIMEDOUT;
> +	unsigned long timeout =3D msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
> +	unsigned int seq;
> +	int try;
> +
> +	guard(mutex)(&idev->req_lock);
> +
> +	/*
> +	 * The same report may be asked for twice in a row and the answer to
> +	 * the first request can still be in flight: the ID alone cannot tell
> +	 * the two apart, so every request carries a serial number.
> +	 */
> +	spin_lock_irq(&idev->feature_lock);
> +	WRITE_ONCE(idev->feature_done, false);
> +	idev->feature_id =3D reportnum;
> +	idev->feature_pending =3D true;
> +	seq =3D ++idev->feature_seq;
> +	spin_unlock_irq(&idev->feature_lock);
> +
> +	for (try =3D 0; try < THC_IPTS_REQ_TRIES; try++) {
> +		ret =3D thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum,
> +				    1);
> +		if (ret)
> +			break;
> +
> +		if (wait_event_timeout(idev->wq,
> +				       READ_ONCE(idev->feature_done) &&
> +				       READ_ONCE(idev->feature_ack) =3D=3D seq,
> +				       timeout)) {
> +			ret =3D 0;
> +			break;
> +		}
> +
> +		ret =3D -ETIMEDOUT;
> +	}

[Severity: Medium]
Can idev->feature_seq distinguish a delayed reply to an earlier request from
the current request?

thc_ipts_get_feature() only transmits reportnum on the wire, and
thc_ipts_feature() unconditionally sets idev->feature_ack =3D idev->feature=
_seq
whenever a matching report ID arrives while idev->feature_pending is true.
Because idev->feature_seq is only updated under idev->req_lock at the start
of thc_ipts_get_feature(), a late reply from a timed-out request for the
same report ID will be stamped with the new request's sequence number and
consumed as the new answer.

In addition, idev->feature_done and idev->feature_pending are initialized
once before the retry loop rather than on each attempt.  If
wait_event_timeout() expires on try 0 and the delayed reply arrives just as
try 1 begins, thc_ipts_feature() sets feature_done =3D true and
feature_pending =3D false before try 1 calls thc_ipts_send().  Try 1 then
sends a duplicate THC_IPTS_TX_GET_FEATURE frame before checking
feature_done, leaving an extra reply in flight (or failing the request if
thc_ipts_send() returns an error even though the reply already arrived).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114214026.2809=
740-1-emfox@debian.org?part=3D3
