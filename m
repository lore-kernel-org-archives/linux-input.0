Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34213911C3
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126229; cv=none; b=CjaGaET7/7X6LxLy1DfGhm+Qw0o+vtGpE6zbNrfZe4Mh6aQ0Oh9Nr9WKTNDp3JE0ueVPUnxpZ2yqWmMS6JTssbmKWK5SIcPHGt7z3a7cE+23ZASQIukmucIo+cMWVf3Zy/sVE4zwj53f451r4A5fTfpvFPFBCQs6KQn69JCZIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126229; c=relaxed/simple;
	bh=oIRjt0FsfLyA0xzPvWg309bush8DJcqL5lbRi7wNiJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OmJfzzb1R3OTBDV94bNgiqmf548zFUCVNZMk9b0EtikLjb0pS8nAzxy7EK7oH1mjRtbiL/Mg2WO3kzT6TGyvK4yJmTsU2/KoPKMDPifuWEWkj/YeYyth+++lGYnIPUMIlIprzYDuEhhhjbaJSWcY+di9IUg7yyo+42+YAD+nnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZplnIaVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZplnIaVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0A11F000E9;
	Wed, 15 Jul 2026 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784126228;
	bh=gyNidfqcRXguKqHSfjyT7zOoLc7xfe9HX2TaKHZTMHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZplnIaVE8hjuujs4iS/CGd7Q5NVSlEqJhLwnkxRoqNpP3huULt1hx0nRtaXC3Ljib
	 iUu3wKrxn0506Z30uUOfPX9jEXmM9Kh8ksE3ukVDQJz1hgY+cteys2cwLGZkq3vkPj
	 wTpP2nqt/XTKXJKivMrKzsYp1+HN4eipcm1JPLzRG8GpRUAleqTnBNijaOgE9W9VmG
	 Ajxn32E6YebZ/6DLDJgBDzwlq3nr5e492UXwHMe7Ko1Doq19mix1kSPrW2eAMyePuV
	 Li5zoeHlQGdVouXQkzqXadPAFru185m9tUMsPBMeFoB7DhH3W1alnOx33WquDdgvRO
	 GKNiV6LiYQ12A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] virtio_console: avoid NULL portdev dereference in
 in_intr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715142337.22811-4-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-4-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:37:07 +0000
Message-Id: <20260715143708.2F0A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced `!port->portdev` check in `in_intr()` suffers=
 from a Time-Of-Check to Time-Of-Use (TOCTOU) race condition and fails to r=
obustly prevent the NULL pointer dereference.
- [Medium] Bailing out early from `in_intr()` without consuming the used vi=
rtqueue buffers leaves stale data in the queue, contaminating future port i=
nstances that reuse the same ID.

Pre-existing issues:
- [High] The patch fails to address a fundamental Use-After-Free (UAF) vuln=
erability in `in_intr()` and `out_intr()`. The helper `find_port_by_vq()` r=
eturns a `port` without taking a reference count, allowing concurrent hot-u=
nplug to free the `port` while interrupt handlers are executing.
--

--- Patch [3]: [PATCH 3/4] virtio_console: avoid NULL portdev dereference i=
n in_intr() ---
commit 53028db078d1834cd8a61fa35f5ddb4495c447b8
Author: Hari Mishal <harimishal1@gmail.com>

virtio_console: avoid NULL portdev dereference in in_intr()

This commit attempts to fix a null pointer dereference in in_intr() caused
when a port is hot-unplugged. It adds an early exit check for portdev being
null under the inbuf_lock to ignore further data during the unplug window.

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 198b973141680..faef362dae853 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
[ ... ]
> @@ -1720,6 +1720,11 @@ static void in_intr(struct virtqueue *vq)
>  	}
> =20
>  	spin_lock_irqsave(&port->inbuf_lock, flags);

[Severity: High]
This is a pre-existing issue, but does find_port_by_vq() return the port
pointer without acquiring a reference via kref_get()?=20

If unplug_port() runs concurrently, can it drop the final reference and free
the port structure right before we try to take the lock here?

CPU0                                 CPU1
in_intr()                            unplug_port()
  port =3D find_port_by_vq(...)
                                       kref_put(&port->kref, remove_port);
  spin_lock_irqsave(...)=20

Would this result in a use-after-free on the port structure?

> +	if (!port->portdev) {

[Severity: High]
Does this check reliably prevent a null pointer dereference?=20

Since unplug_port() sets port->portdev =3D NULL locklessly outside of
inbuf_lock, could a concurrent unplug set it to null immediately after this
check passes?

Because get_inbuf() is called next, might the compiler reload port->portdev
from memory for the later is_rproc_serial(port->portdev->vdev) check,
crashing on the newly null pointer?

> +		/* Port is being unplugged, ignore further data. */
> +		spin_unlock_irqrestore(&port->inbuf_lock, flags);
> +		return;

[Severity: Medium]
Does returning here without consuming the virtqueue buffers leave stale data
in the queue?=20

Since virtqueues persist across hot-unplugs for the same port ID, could a
newly hot-plugged port reuse this virtqueue and read leaked data from the
previous session?=20

Should this path consume the buffers, perhaps by calling
flush_bufs(vq, false), before returning?

> +	}
>  	port->inbuf =3D get_inbuf(port);
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715142337.2281=
1-1-harimishal1@gmail.com?part=3D3
