Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E402BE644
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126326; cv=none; b=bByMGHNmiCZA3jOvUM8plbZOshrsQcDTHNDPx4LZDndVb8olFJ2/0ke2ZRxttgaBGlccEALF7S27Q5opObpOSCru3M++txKZUgqSg/yo2l93eLMU/kRS9IXlxnCP7VZH+2EUIYB9C0Kfx3pi7Y6f+ufdybdH2nbtlYOqZAx5IYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126326; c=relaxed/simple;
	bh=/lI5B/IQnzUjmmulpZvbYSBUsu+zaCEbkZ2v6EzANZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i3K/V0k7KXp74lPmFmrscvcbjQbqKYvzTlbqk30lOKdixlsuqgBrYhZ1itBbSD85ATf95nVlQz/WXvVcOuI25E9et09BHkGVWlrwDgWNyWyjnLQ9vY72NRIi+cYV+vNi/gxpVwcXr7b3aRiJ/av07S1i2YDnGNFasGaxTxvJTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg2qnptK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg2qnptK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D981F000E9;
	Wed, 15 Jul 2026 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784126321;
	bh=MgtjY0pifY/wqhkn9+mM2QPFXVcB7K0irT9bMPIq5Bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fg2qnptKN6SpSiApks8VVR9Ck45SOeJLlIkyx0IFPMEtG4kXMevGcCJmsWOYKh496
	 pXwI7EJ+L947zqBzqwGEkgRroHNddxSfe7sVMlPJKR3kHAo1W+rcjPdu91GzpLnKkH
	 UdGd9qE8UsPFptS4VBRWTzMgNh6MJsWwagM6Bnzf3Yuz14jOFbKDQiskvwkdjKjzkz
	 D9HPyzSmDTcSXhLt8Cvakc8Odm9hFwfVQ16ITCknfbS072J1zXAqE7kcs97AGxr6ky
	 Pf7yWyQWE2U/bKMXyiJgr7NUfkJtmacuMg9n1XMALeQh0U5wnl4NL2V0DKjfJUQbH2
	 +2109jrOKjv7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] virtio_console: take a kref in find_port_by_vq() to
 fix port UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715142337.22811-5-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-5-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:38:40 +0000
Message-Id: <20260715143841.A5D981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: `in_intr()` can still dereference a freed `hvc_str=
uct` (`port->cons.hvc`) due to a race with `unplug_port()`.
- [High] A TOCTOU data race on `port->portdev` between `in_intr()` and `unp=
lug_port()` can lead to a NULL pointer dereference.
- [High] File operations (e.g., `port_fops_read`, `port_fops_write`) can ac=
cess freed virtqueue and portdev memory if device removal occurs concurrent=
ly.
--

--- Patch [4]: [PATCH 4/4] virtio_console: take a kref in find_port_by_vq()=
 to fix port UAF ---
commit 135dcd5e5260baeaa35a46f85c302542d073ddaf
Author: Hari Mishal <harimishal1@gmail.com>

virtio_console: take a kref in find_port_by_vq() to fix port UAF

This commit fixes a use-after-free of the port structure by taking a
kref in find_port_by_vq() under the ports_lock. It matches the behavior
of find_port_by_devt_in_portdev() and safely drops the reference at the
end of the interrupt handlers.

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index faef362dae853..1b7593684ed9d 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c

[ ... ]

> @@ -1723,6 +1731,7 @@ static void in_intr(struct virtqueue *vq)
>  	if (!port->portdev) {
>  		/* Port is being unplugged, ignore further data. */
>  		spin_unlock_irqrestore(&port->inbuf_lock, flags);
> +		kref_put(&port->kref, remove_port);
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but is there a time-of-check to time-of-use
(TOCTOU) data race on port->portdev here?

In unplug_port(), port->portdev is locklessly set to NULL at the end of the
function. Concurrently, in_intr() checks if (!port->portdev) while holding
inbuf_lock. If the check passes before unplug_port() sets it to NULL,
in_intr() will proceed and later execute this check:

if (!port->guest_connected && !is_rproc_serial(port->portdev->vdev))

Could this force a reload of port->portdev, read NULL, and cause a kernel
panic when accessing ->vdev?

[ ... ]

> @@ -1756,6 +1765,8 @@ static void in_intr(struct virtqueue *vq)
> =20
>  	if (is_console_port(port) && hvc_poll(port->cons.hvc))
>  		hvc_kick();
> +
> +	kref_put(&port->kref, remove_port);
>  }

[Severity: High]
This is a pre-existing issue, but could in_intr() still dereference a freed
hvc_struct due to a race with unplug_port()?

When the host sends a VIRTIO_CONSOLE_PORT_REMOVE control message,
unplug_port() calls hvc_remove(port->cons.hvc), freeing the hvc_struct.
Concurrently, if the host kicks the data virtqueue, in_intr() passes the
portdev check, drops inbuf_lock, and evaluates:

if (is_console_port(port) && hvc_poll(port->cons.hvc))

Since port->cons.hvc is never cleared and this check is lockless, can this
dereference the freed memory and lead to memory corruption?

[Severity: High]
This is also a pre-existing issue, but can file operations like
port_fops_write() access freed virtqueue and portdev memory if device remov=
al
occurs concurrently?

If a user-space process initiates port_fops_write(), it eventually executes:

buf =3D alloc_buf(port->portdev->vdev, count, 0);

Concurrently, if the host removes the virtio device, virtcons_remove() is
called. It unplugs the ports, calls remove_vqs(portdev), and frees portdev
via kfree(portdev) without waiting for existing open file descriptors to be
closed.

Even with the kref protecting struct port, could the file operation resume,
pass checks, and access port->portdev->vdev or call functions on freed
memory like virtqueue_add_outbuf() on port->out_vq?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715142337.2281=
1-1-harimishal1@gmail.com?part=3D4
