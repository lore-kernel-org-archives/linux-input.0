Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358DA440A2C
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903972; cv=none; b=E/uTBhKXthYzIXYUu5KhyEHt69n7J0WaX+lVAI+A50VkcOFq3HaNbybrHHImZZ+job08Hvn/Fr5v1RZvYe7pvR2WDmgr6NkzIPIERCKqd0LxsLhHfzdrR10YNm/gTxXn+yPkMRDiAnTPXcKvZnEKk9ZwjWKmyk1eJo6muz9telA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903972; c=relaxed/simple;
	bh=zS6dvnbdA4ncrKW9jTIn19wPYIhldqhGgRyH1byV2TI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uaE6NI6IpxsiPgVvO/ZI2/KsU7N3cGoB8NTaMEHqwwJyrv5N5H1oFDEvhBB+BiNf/4zcEPJywx/Ytry1xuAZqzZMjngWe0ZIsSVGymG26dj5sR2ikCFZbmhYcNMuABnShZXxEVZl4lAppribyLuxjbbJUBf5NRtbD0Hh++SHsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyUc369f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyUc369f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007D61F00A3A;
	Fri, 24 Jul 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903965;
	bh=/rKuH7QpvKifVEyiuqLydwzjPsE9JAMtkrYySEplHx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IyUc369fEv0mIrCLfn9yZeS3sMiWw4P0rB2rUPCyw4YlfBqLVjgm9yDj/ly1TUUSX
	 ZtpjuczFFdSFWu48qhUMHVUcAQsltgoU2p1vi2BOwjWhYtaD8mUZOj7U5fmOMs0lGo
	 cb8eUdqEo78DYrzmy3Vhc32qMuUZjXKEoi2IVWvo6nDJ50mpFHsOml9hnh5UQG5H1F
	 bCCQpobrdpI1O5svlrgWoDzNc2Xd6vkPgME+jl+bTJY9njw46TaaVtglgx1oRdMXA3
	 5A79df2fX+Y2zfLirEH3lSoo5OabQwNrxPiOHXNxiyv9EdhBdPfO/LuDEy7+nuSibv
	 KNDsnwn1wPZ1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at
 driver unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260724142703.55813-1-doruk@0sec.ai>
References: <20260724142703.55813-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:39:24 +0000
Message-Id: <20260724143925.007D61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error paths in `sony_probe()` fail to remove the device context fr=
om `sony_device_list`, leading to a global use-after-free.
- [High] System suspend breaks the periodic keep-alive timer, permanently d=
isconnecting the GHL guitar dongle.
- [Low] URB DMA buffers are allocated using `devm_kzalloc()`, violating DMA=
 API cache-line alignment requirements.
--

--- Patch [1]: [PATCH v2] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at=
 driver unbind ---
commit 0fb03a05b4d9cc719ee1096b892767332261493d
Author: Doruk Tan Ozturk <doruk@0sec.ai>

    HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind
   =20
    For GHL (Guitar Hero Live) dongles, sony_probe() arms a periodic timer
    that submits a URB, which on completion re-arms the timer.
   =20
    sony_remove() drained the timer with timer_delete_sync() and then freed
    the URB, which did not block re-arming or kill in-flight URBs. This all=
owed
    the timer to re-arm on freed memory, causing a use-after-free.

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index e75246d29e16d..77ab30303080e 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2424,7 +2424,9 @@ static void sony_remove(struct hid_device *hdev)
>  	struct sony_sc *sc =3D hid_get_drvdata(hdev);
> =20
>  	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
> -		timer_delete_sync(&sc->ghl_poke_timer);
> +		/* poison, not kill: a pending timer must not re-submit during teardow=
n */
> +		usb_poison_urb(sc->ghl_urb);
> +		timer_shutdown_sync(&sc->ghl_poke_timer);
>  		usb_free_urb(sc->ghl_urb);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but error paths in sony_probe()
fail to remove the device context from sony_device_list, leading to a global
use-after-free.

When hid_hw_start() triggers sony_input_configured(), the device context sc
is added to the global sony_device_list. If a subsequent operation in
sony_probe() fails (for example, usb_alloc_urb() returns NULL), the function
jumps to the err label:

drivers/hid/hid-sony.c:sony_probe() {
    ...
err:
	usb_free_urb(sc->ghl_urb);

	hid_hw_stop(hdev);
	return ret;
}

Can this lead to a crash when the devm subsystem frees sc upon returning
the error? If the next Sony HID device is plugged in, it seems
sony_check_add() will iterate over sony_device_list and dereference the
freed sc pointer. Should this error path call sony_remove_dev_list(sc)
and sony_release_device_id(sc)?


[Severity: High]
This isn't a bug introduced by this patch, but system suspend breaks the
periodic keep-alive timer, permanently disconnecting the GHL guitar dongle.

During system suspend, usb_submit_urb() fails synchronously. When this
happens, the timer callback exits without re-arming the timer:

drivers/hid/hid-sony.c:ghl_magic_poke() {
    ...
	ret =3D usb_submit_urb(sc->ghl_urb, GFP_ATOMIC);
	if (ret < 0)
		hid_err(sc->hdev, "usb_submit_urb failed: %d", ret);
    ...
}

Neither sony_suspend() nor sony_resume() seem to manage ghl_poke_timer:

drivers/hid/hid-sony.c:
static int sony_suspend(struct hid_device *hdev, pm_message_t message)
{
    ...
}

static int sony_resume(struct hid_device *hdev)
{
    ...
}

Once the system resumes, will the timer remain dead, effectively dropping
the device connection permanently? Does the suspend handler need to pause
the timer and the resume handler restart it?


[Severity: Low]
This isn't a bug introduced by this patch, but URB DMA buffers are allocated
using devm_kzalloc(), which violates DMA API cache-line alignment
requirements.

Looking at ghl_init_urb():

	cr =3D devm_kzalloc(&sc->hdev->dev, sizeof(*cr), GFP_ATOMIC);
	...=20
	databuf =3D devm_kzalloc(&sc->hdev->dev, poke_size, GFP_ATOMIC);

And in sony_allocate_output_report():

		sc->output_report_dmabuf =3D
			devm_kmalloc(&sc->hdev->dev,
				sizeof(union sixaxis_output_report_01),
				GFP_KERNEL);

Since the devm subsystem prepends a devres_node header, the resulting
pointers are offset from ARCH_DMA_MINALIGN. Is it safe to map these unalign=
ed
buffers for DMA by the USB core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724142703.5581=
3-1-doruk@0sec.ai?part=3D1
