Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DF3D8128
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102566; cv=none; b=DTtzn8Bu5SOSEGgNASkozgNbq6aE3GbuihRKpYyUbD8stFkmvHuUyoN7r0oCRukMn03hJLg+mQLlTA9Mn5xMjypPec4No1/2TUVA6Hwr9pIy0/s03rlqzGhA3fWjEJJc340kicCr2wCBQDgrpROT9QSd1lGo5Yrc90NPh1nN2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102566; c=relaxed/simple;
	bh=Y7lZN4lnBevZV7Fx3P0XHyjml199ccK8ZJBKbUZfnnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UtGapwoNxe34VZCfR8CI+MPsjSa0aKuEQn8051wzW/wUA4HJfNIhVDP71L4SJPKVtB8RPfLl1EjnQqj/DrZ9F7QktPW/pRvMM2tMuccJDaM4e2XRkGrRpxKLCogggvf4RPqqLmvlphPqNPpuVRRYGCURWMj7LeUIsYWdsOKXS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Da3ORz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Da3ORz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537031F00898;
	Wed, 10 Jun 2026 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102565;
	bh=CJ13Wt5fSQL1jijoy4iuT2BZlxcrgwuzijF78EL8Vq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0Da3ORzydJ4dV3tSmKphz/lRQHst5eT3AWfR4XnayKtf88x3Nu+nWrpCLiIryy7d
	 Wl4BHquXWeavPrn7kY3a3jA+vfPwI52Y8XE1xLVixuHnGaR1a/WZUVrJX3paG6dNZw
	 1KVAM3uJ5wSwabKWCFDYqoh1aut7+SXqYh7CmgN8wXvtcFkN1crSQfgls22jngPAna
	 OcNWKYc8sEKRFopNXvu2BP2uIHY/RabDRRIUbVIix6QLViBepCDuj/gxDKU/EC3YP5
	 LkMljki7ei41kgmlevCimH9WuVpd5ElP1/tdFfUOgDd1DhtWBmT+vI9PGpb2qOhMXa
	 6KqsDx57gik9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: ft260: fix stack-use-after-return write in I2C
 read race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Raman Varabets" <kernel-linux-20260610-80b7ab08@raman.v1.sg>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
References: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:42:44 +0000
Message-Id: <20260610144245.537031F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver calls `hid_hw_open()` and `hid_hw_start()` before fully=
 initializing driver data and locks, allowing an early interrupt to cause a=
 NULL pointer dereference or uninitialized spinlock access.
- [High] Calling `complete(&dev->wait)` outside the `read_lock` creates a r=
ace condition where a delayed completion signal can spuriously wake up a su=
bsequent I2C read, resulting in the exposure of uninitialized memory.
- [High] A delayed I2C response from a timed-out read can erroneously fulfi=
ll a newly issued I2C read request, silently corrupting the read payload.
--

commit f93912f569da4f226a3bdb7379cc9b9a98ba1eb9
Author: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>

HID: ft260: fix stack-use-after-return write in I2C read race

This commit fixes a race condition where a delayed I2C response could write
into a freed stack buffer after a timeout in ft260_i2c_read. It adds a
dedicated spinlock to serialize accesses to the read buffer, index, and len=
gth
between the read path and the raw event handler.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 70e2eedb465af..f479459544aee 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -543,7 +548,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>  			goto ft260_i2c_read_exit;
>  		}
> =20
> +		spin_lock_irqsave(&dev->read_lock, irqflags);
>  		dev->read_buf =3D NULL;
> +		spin_unlock_irqrestore(&dev->read_lock, irqflags);

[Severity: High]
This is a pre-existing issue, but does the timeout path leave stale USB inp=
ut
reports pending?

If an I2C read times out, ft260_i2c_read() resets the controller but does n=
ot
flush the HID/USB receive queues. When a new I2C read begins, dev->read_buf
is updated to point to the new buffer.

Could a delayed USB report containing the response for the previous timed-o=
ut
read arrive, pass the NULL check in ft260_raw_event(), and blindly copy sta=
le
data into the new buffer? This would silently corrupt the payload and
desynchronize the bus state.

[ ... ]
> @@ -1018,6 +1027,7 @@ static int ft260_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  		 "FT260 usb-i2c bridge");
> =20
>  	mutex_init(&dev->lock);
> +	spin_lock_init(&dev->read_lock);
>  	init_completion(&dev->wait);
> =20
>  	ret =3D ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);

[Severity: High]
This isn't a bug introduced by this patch, but does hid_hw_open() allow eve=
nts
to trigger before the driver data and locks are fully initialized?

In ft260_probe(), hid_hw_open() is called before hid_set_drvdata() and befo=
re
spin_lock_init(&dev->read_lock). Because hid_hw_open() submits USB interrupt
IN URBs, the hardware can start sending events immediately.

If ft260_raw_event() triggers early, hid_get_drvdata() would return NULL.
Could this lead to a NULL pointer dereference when ft260_raw_event() attemp=
ts
to acquire dev->read_lock?

[ ... ]
> @@ -1095,8 +1115,11 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>  		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
>  		       xfer->length);
>  		dev->read_idx +=3D xfer->length;
> +		complete_read =3D dev->read_idx =3D=3D dev->read_len;
> +
> +		spin_unlock_irqrestore(&dev->read_lock, irqflags);
> =20
> -		if (dev->read_idx =3D=3D dev->read_len)
> +		if (complete_read)
>  			complete(&dev->wait);
> =20
>  	} else {

[Severity: High]
This is a pre-existing issue, but does calling complete() outside the
read_lock create a race condition with the teardown path?

If an I2C read times out, ft260_i2c_read() wakes up and clears dev->read_bu=
f.
A new I2C read request could then be issued, which calls
reinit_completion(&dev->wait).

If the softirq executing ft260_raw_event() is preempted between dropping the
lock and calling complete(&dev->wait), could it resume and signal the
completion after the new request has already reinitialized it? This would
cause the new wait to instantly succeed, returning success without writing =
any
data to the caller's buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610142952.3335=
586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg?part=3D1
