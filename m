Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700483;
	b=SPSskRrVSzn/Hks//ohbryDXJq3GEredMnmEX6yVWmz6T11huHSQp7P8OP1qzIYQmybE
	 CvFZtpbyKFM1vXadTixY/w4w0HuxGfXLwygOiz+0dz9R8EdGG4Q/TuROtGKWrQYJq3wvp
	 Vkhywwj0rX3/Q7ZRcdkBaaDiAVdKZdyPD3Y91nSFJV6J2/r6qfLdA3YcD5e7eX00dxV7E
	 7oRZge6NIJUF3jbm/sOHQ3kWfvEV+gyZCDj8XPYr+Bv8fzGQStLELfWOtF3iSVISNjMTR
	 lEG1upQlHb7OLMEbp99sHqAq+PoTeMInpuY9Vpk6P34IiE5/iP8P1jsDa6F4Avl4zsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3AqXVjRVHopdl8c3vjrWXQVWPKQ9kW/h8M9SwpX/geg=;
	b=yHA/EjmfKr3NtlF55JalbV6hCObyu61DqhZlo3y8+2MmkePst7+LiBorvHaHi19L5Sl8
	 cOtxv/sINQGLOxqve13kfBQ/HquW0eFrAyJxO7zk8ryxe8A7YV1DRDMS+4EBNM7wqr0Mg
	 wVtU3eK0NGyIht7hw7Yl+7UR78PiYj26oTKM6fDys5kiKBNLqdJKM6C6jkO6biDDNL/Tv
	 IgLAJJuTBx3N9KTYp0IHZrg4Y0pMEbr7xgIO9UBNUT6nEKnHMKMZXh+uquS9t+m6ORJv6
	 baUjZqNgtBV71aIIHiz+fGtZivai6bymVvk+PjsdgyKWyzSmNrt3zWfUDsZrRwrW6zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHOBnrxz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CEB606A329
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHOBnrxz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC72E1F000C4;
	Sat, 14 Nov 2026 23:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794700482;
	bh=3AqXVjRVHopdl8c3vjrWXQVWPKQ9kW/h8M9SwpX/geg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHOBnrxzocQr8SCvbO12sVB5ITZ4uCmWe1+AQnaSgsigwb+5+I5aIAJzQIaqoxod3
	 OHNr91f22hEbl6NZVRzWgNFP+SGwotzOKsZ6nH/CD1kZ66Q64XOWhZcABsqCnNT7sF
	 h33GPOJolZaT37uAZuXwU0vppbqknbXizRut1ZZZ30IWyeJNptk6hWr2xqGUErO0aM
	 L1B98I2CWiYO6rMiOMccaUwpVejn1dJTRMy3ZY7zHPRHlGA7tVBOfcZcIKByehTr4G
	 o8Cstdwwq8DHmk0Q/Tu5hk9GeTbMqIbSueIT/aGtU8F2UFyv2L0mHE6s3r3S+qT5vX
	 YSiugBHKUe29A==
Message-ID: <sashiko-outbox-215133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] HID: intel-thc-hid: intel-ipts: register the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114234242.177387-4-emfox@debian.org>
References: <20261114234242.177387-1-emfox@debian.org>
 <20261114234242.177387-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:54:42 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: timeout race in
  thc_ipts_get_feature()
--

commit e99496dcf7f84313e5d9ff87c2f348f5f730fd0a
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: register the HID device

This commit registers a HID device for the IPTS port and implements report
descriptor parsing, input report forwarding, and feature/output report
requests over DMA.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 76224f4444828..ea85c9a150899 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> +static void thc_ipts_feature(struct thc_ipts *idev, const u8 *data,
> +			     size_t len)
> +{
> +	if (!len)
> +		return;
> +
> +	/* Only a frame that arrives while a request is waiting is taken. */
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
> +	WRITE_ONCE(idev->feature_done, true);
> +	spin_unlock_irq(&idev->feature_lock);
> +
> +	wake_up(&idev->wq);
> +}
[ ... ]
> +/* A feature report comes back as a frame of its own: the request waits.=
 */
> +static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char rep=
ortnum,
> +				u8 *buf, size_t len)
> +{
> +	unsigned long timeout =3D msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
> +	int ret;
> +
> +	guard(mutex)(&idev->req_lock);
> +
> +	/* The frame carries only the report ID, so a late answer cannot be
> +	 * told from the next one's: after a timeout the channel stays shut.
> +	 */
> +	if (READ_ONCE(idev->feature_off))
> +		return -EIO;
> +
> +	spin_lock_irq(&idev->feature_lock);
> +	WRITE_ONCE(idev->feature_done, false);
> +	idev->feature_id =3D reportnum;
> +	idev->feature_pending =3D true;
> +	spin_unlock_irq(&idev->feature_lock);
> +
> +	ret =3D thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum, 1);
> +	if (!ret &&
> +	    !wait_event_timeout(idev->wq, READ_ONCE(idev->feature_done),
> +				timeout))
> +		ret =3D -ETIMEDOUT;
> +
> +	/* Past this point no request is waiting for the frame. */
> +	spin_lock_irq(&idev->feature_lock);
> +	idev->feature_pending =3D false;
> +	spin_unlock_irq(&idev->feature_lock);
> +
> +	if (ret =3D=3D -ETIMEDOUT) {
> +		/* An answer may still be on its way. */
> +		dev_err(idev->dev, "no feature report %u\n", reportnum);
> +		WRITE_ONCE(idev->feature_off, true);
> +		return ret;
> +	}

[Severity: Medium]
Can a feature report arriving right as wait_event_timeout() expires be
dropped while still latching idev->feature_off?

CPU0                                    CPU1 (irq thread)
thc_ipts_get_feature()
  wait_event_timeout(...) -> 0
  ret =3D -ETIMEDOUT;
                                        thc_ipts_feature()
                                          spin_lock_irq(&idev->feature_lock=
);
                                          /* feature_pending is still true =
*/
                                          memcpy(idev->feature, data, len);
                                          idev->feature_pending =3D false;
                                          WRITE_ONCE(idev->feature_done, tr=
ue);
                                          spin_unlock_irq(&idev->feature_lo=
ck);
  spin_lock_irq(&idev->feature_lock);
  idev->feature_pending =3D false;
  spin_unlock_irq(&idev->feature_lock);
  if (ret =3D=3D -ETIMEDOUT) {
    WRITE_ONCE(idev->feature_off, true);
    return -ETIMEDOUT;                  <-- drops reply and shuts channel

Because idev->feature_done is not re-checked under idev->feature_lock when
clearing idev->feature_pending, a reply accepted in that window is
discarded, the request fails with -ETIMEDOUT, and all further feature
requests fail with -EIO until the port is restarted despite no late answer
remaining in flight.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114234242.1773=
87-1-emfox@debian.org?part=3D3
