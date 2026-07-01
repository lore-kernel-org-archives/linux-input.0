Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D81F4631
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885256; cv=none; b=Y+tnQFyyn6MhC93zoZJ5irRgKExZ85CK7mqPOD3eQxXbpj8fY76XdY2ADDXWV6yKkQidacM5+2RXErv319XkS7dfgy1ByvvnDmAxdqrekCywPHG4ssFgsfmAMKgm7DMLvvRlP5fKHuETwGkrPFw1RdQIWPUPScCMU9SK1qludjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885256; c=relaxed/simple;
	bh=5TcLZxPWV5mxs1ewDcqf0evMwqlAeXCrhhLdGpbxyUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ggf63yRqL5r8Xvb96RU9zRSMvnDS/CfqaCMekqodTEe64MHHi8JrvcYQZjMHAoRJcla05iPx9sP7z2IfQn2InT3LQcNciU3Q0PX4zLFTy/B/xQwmM/zqAKbFiEHvDsqwo3wo/cFjoHDiWlGh060KSDU3lOK+wJrrnWVHEQzpHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj9/+VQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj9/+VQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AA81F000E9;
	Wed,  1 Jul 2026 05:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885255;
	bh=Lr9FBlEOKh2Dhyz7C5+CQQ4mIrYfAMsfzgQdPs1qGYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qj9/+VQfu/xRo1HRslULxJE+MG6pUbHrLdWVC4yb29cERoQZ093YAYmIW1mpKPkSg
	 iE3Zk6SH7/maPvFcHFfTvCHA66sO1w4r3oA71x1mZMWqEHjN4WYHRGUXjS45kL8Yvk
	 B0U5dka7cZznCW+InmEtQz4a0wxZMg6ky8yxCQxGh2DXh7p1oJdzk/ekJhuTzhbBjS
	 o6aqFEBBEQacD2zruQU048GPqQwr7cbJr/Z/Uej/4zIIhSfEs4DIeg/tJDdLURdWdm
	 A9JXSSqdc5+506NRGx9d4N2vKeTRDoc3u55hC+hU0z6Aa9XGeNrN5mgF8be5oVxJJO
	 fu90p4yq/iUgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: cp2112: validate raw report lengths before parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260701054023.59015-1-pengpeng@iscas.ac.cn>
References: <20260701054023.59015-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:54:13 +0000
Message-Id: <20260701055414.C6AA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential data race due to missing memory barriers between payload=
 updates and availability flags, leading to stale reads.
- [High] Use-After-Free due to incorrect teardown sequence of GPIO poll wor=
ker in remove.
--

commit 1bac7c472f6cc9dcb9d59a5d99910a2876f7382f
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

HID: cp2112: validate raw report lengths before parsing

This commit adds bounds checking to cp2112_raw_event() to ensure raw HID
reports are large enough before parsing their contents. Short transfer-stat=
us
reports now complete with -EINVAL, while short read responses complete as a
zero-length read.

> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 04379db93571b..3f5be199842b1 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -1428,8 +1428,17 @@ static int cp2112_raw_event(struct hid_device *hde=
v, struct hid_report *report,
>  	struct cp2112_device *dev =3D hid_get_drvdata(hdev);
>  	struct cp2112_xfer_status_report *xfer =3D (void *)data;
> =20
> +	if (size < 1)
> +		return 0;
> +
>  	switch (data[0]) {
>  	case CP2112_TRANSFER_STATUS_RESPONSE:
> +		if (size < sizeof(*xfer)) {
> +			dev->xfer_status =3D -EINVAL;
> +			atomic_set(&dev->xfer_avail, 1);

[Severity: High]
This is a pre-existing issue, but could this atomic_set() lead to stale
payload reads on weakly ordered architectures?

Since atomic_set() doesn't provide a memory barrier, is it possible for the
processor to reorder the dev->xfer_status update with this dev->xfer_avail
update?

If so, a reader checking the condition locklessly via the fast path in
wait_event_interruptible_timeout() in cp2112_wait() might observe the flag
as true and return before the new payload is visible.

> +			break;
> +		}
> +

[ ... ]

> @@ -1463,11 +1472,19 @@ static int cp2112_raw_event(struct hid_device *hd=
ev, struct hid_report *report,
>  		atomic_set(&dev->xfer_avail, 1);
>  		break;
>  	case CP2112_DATA_READ_RESPONSE:
> +		if (size < 3) {
> +			dev->read_length =3D 0;
> +			atomic_set(&dev->read_avail, 1);

[Severity: High]
This is a pre-existing issue, but similar to the above, does this missing
memory barrier allow the dev->read_length update to be reordered with the
availability flag update?

> +			break;
> +		}
> +

[ ... ]

[Severity: High]
This is a pre-existing issue, but looking at cp2112_remove(), is there a
potential use-after-free race during teardown?

drivers/hid/hid-cp2112.c:cp2112_remove() {
    ...
    cancel_delayed_work_sync(&dev->gpio_poll_worker);
    ...
    gpiochip_remove(&dev->gc);
    ...
}

During the window between these two calls, the gpiochip is still registered.
Could a concurrent irq_startup request call cp2112_gpio_irq_startup(), which
sets dev->gpio_poll =3D true and reschedules the delayed work?

If the delayed work fires after cp2112_remove() returns and dev is freed via
devres, would cp2112_gpio_poll_callback() dereference the freed dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701054023.5901=
5-1-pengpeng@iscas.ac.cn?part=3D1
