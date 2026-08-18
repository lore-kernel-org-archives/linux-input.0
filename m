Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9A2772D
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026839; cv=none; b=k34X0XuzA/FkOZg1CfAPFuWU1VZamwM98w8RwJRvZgOIeHmA4V2+BB66hLXWB4wC9Vi4hcsGQM/3+uiAhX0eoWYACzrxioE/qWq90zLinTJr11+VgzuaR3+MXQM46GiG+5dRbUY9lt7eFfcGP15IADqpiKVYZeMnO2nQiUNJSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026839; c=relaxed/simple;
	bh=X4ZtoQ7MryfDTcTBuvwFlr3DbJaLBKfDU9DU956C/u8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uLC3NiAsNuyo5tGUb0aSSEVDCQhfb9+FGfpyZz02Ho/bmxfi3qDVL4mrqA7oi1uayJWGqtZxug9TCwnS2EktnmXgNTITjSU8908Mxn59aEYSlPv8AwuFjqvp6ppI7hnJ1JJOm4e3yFabRevOYHUjyhyQZBMA5u0WNXxJjV0RZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx5d+AOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx5d+AOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C88D1F000E9;
	Tue, 18 Aug 2026 04:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026837;
	bh=l44oT6TYp8YpNzWHwW6vCpRh5ZhfyU4O8bFL32XwfgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bx5d+AOfvQLN4Snu4UxE8ffOV/x3Xu5O9PlwRExM4hkQkI0miklNUdqay/WvwFvab
	 KjjIkpHU7+5Pfj6Gy8W/9tan/YiPUAH+NV8Z4PELZ8pPsd8J5o0D5ISLh0SUf4cPuj
	 sksbJ/LBCFzehiLbs+QqekbHy+IwCgXLIT1kQ2VlwtJ56d0oX1X2GjNT8XBGfNaKDU
	 QUvYw1c0H+FhsacakPGwUeuQSHYrBVH52MOrrLtWEuAqb1g8GYjjpH4mHzBbl3sEYs
	 Gf6AGVwpTmrUJsxWyiJEvQ/QkZPtfHTkP/ZPHAm9BoUVduEamgicvnPOcVn54UDGIC
	 wTCAbZmxUE5/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] virtio_input: stop callbacks before unregistering
 input device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260818040433.66986-3-kmehltretter@gmail.com>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
 <20260818040433.66986-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:20:37 +0000
Message-Id: <20260818042037.8C88D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Breaking early from the event processing loop truncates the input =
packet, violating input subsystem synchronization rules and leading to stuc=
k keys.

Pre-existing issues:
- [High] Missing virtqueue_detach_unused_buf() for the 'events' virtqueue l=
eads to DMA mapping leaks during device teardown and suspend.
--

--- Patch [2]: [PATCH 2/2] virtio_input: stop callbacks before unregisterin=
g input device ---
commit 8b35f1100c300e75de17028044efd92590e5c2f0
Author: Karl Mehltretter <kmehltretter@gmail.com>

virtio_input: stop callbacks before unregistering input device

This commit alters the teardown sequence in virtinput_remove() to reset the
virtio device prior to unregistering the input device. It also adds checks
for vi->ready in virtinput_recv_events() to prevent requeuing buffers or
kicking the queue during teardown.

> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e6828..b6843601d0aea 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
>  				    le16_to_cpu(event->code),
>  				    le32_to_cpu(event->value));
>  			spin_lock_irqsave(&vi->lock, flags);
> +			if (!vi->ready)
> +				break;

[Severity: High]
Does breaking out of this loop truncate the input packet?

If the device begins teardown or suspend while the loop is midway through
processing a packet, breaking early aborts reading the remaining events from
the used ring. If an EV_KEY release was processed just before the break, its
corresponding EV_SYN is left in the queue and subsequently destroyed when
the device resets.

Because EV_SYN is required to flush the state to userspace handlers, this
can lead to lost button releases and stuck keys. Should this use "continue"
instead of "break" to safely process the full packet while preventing buffer
requeue during teardown?

>  			virtinput_queue_evtbuf(vi, event);
>  		}
> -		virtqueue_kick(vq);
> +		if (vi->ready)
> +			virtqueue_kick(vq);
>  	}
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  }

[ ... ]

> @@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vd=
ev)
>  	vi->ready =3D false;
>  	spin_unlock_irqrestore(&vi->lock, flags);
> =20
> -	input_unregister_device(vi->idev);
> +	/* Stop callbacks before unregistering the input device. */
>  	virtio_reset_device(vdev);
> +	input_unregister_device(vi->idev);
>  	while ((buf =3D virtqueue_detach_unused_buf(vi->sts)) !=3D NULL)

[Severity: High]
This is a pre-existing issue, but does this teardown sequence leak DMA
mappings for the events virtqueue?

During initialization, vi->evt is populated with buffers that establish DMA
mappings. During virtinput_remove() (and similarly in virtinput_freeze()),
the driver correctly drains vi->sts using virtqueue_detach_unused_buf() to
trigger dma_unmap_page(), but it skips vi->evt entirely before calling
vdev->config->del_vqs(vdev).

Since vring_del_virtqueue() only frees the queue descriptors and does not
automatically unmap unused buffers left inside the ring, skipping vi->evt
leaks its DMA mappings on every suspend/resume or driver unbind.

>  		kfree(buf);
>  	vdev->config->del_vqs(vdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040433.6698=
6-1-kmehltretter@gmail.com?part=3D2
