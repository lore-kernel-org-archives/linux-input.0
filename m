Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A143183CC3
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515083; cv=none; b=u2gzjT+gx4su3iPcx+wWzN3zyhLcoiN9XpmGcJTRCDp2fz0x0mVrMle5guY35UmRZlk9kjpXMq7fz0i7PkPmwjlxFyqSW3GgyQJJK3PVhlXm7ZwTAQTO1Z1pToAQrC4OBUKm4QiEWCrihEtRaxyOwasy3D+HsEDH/Z592Vd88q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515083; c=relaxed/simple;
	bh=NEx+9MhR5h8ykUgmLU7w3lIom6cSExJs+EdPiO0faLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YYQRGrr9MPYqJtfz07XJJpUlD0x7E3SlyyUeeC8k9H2/DJtXgeg369b5Z0cU8lvvF5EElDZ3i5v1YCd6wpd8z0apcaULKbDnCKuvT+TE6ZKnNvrZrJNtlEjG71S65/T4qlLKCODrPgmByzleIo2rpkf9mk5x6CcFzyjL02/DQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy3jrVPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy3jrVPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095BB1F000E9;
	Sat, 23 May 2026 05:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779515082;
	bh=zvyiE3lJhICq4t/HguWwy/KJ3LD9ZZe+O2BMg3boUac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jy3jrVPLKcVw0ORv0vU6kKUNNkuLtQ8RI1hg7p/nbzyJwYNhUk1MFPcfJUUO0ufge
	 wChjr6pQa9kHZrfjmM3SC5gmMUssN6IBt0yKtKt35ZMODwkAthS6d5ZjayhBteDvcS
	 h/bxF+i061FCZ+1LqAsr5w2hZ1VvRaMOcBoz6gHuPia8NZlJ4VJ+qimGPuOwxbki1T
	 PXOdPrhCMZSo41sxkVGuku1A1B1Ep2AivUasmbxHOtbmNChg36D5ON35acwq/WRDa4
	 4UYxMh29gwiFrkwqOULn+oe00zHIVvUyK9VzN8Ywy5Bf+ouSA0m/dZNm3ODvBfsk61
	 TgIR6ydyNsmHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] Input: ims-pcu - validate control endpoint type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-6-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-6-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:44:41 +0000
Message-Id: <20260523054442.095BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The control endpoint's `wMaxPacketSize` is not validated for being=
 non-zero, allowing a malicious USB device to trigger a `WARN_ON` in the DM=
A allocator.
- [High] In `ims_pcu_buffers_free()`, `usb_free_coherent()` is called for `=
urb_in_buf` using `max_out_size` instead of the size it was allocated with =
(`max_in_size`).
- [High] The driver re-initializes an already initialized completion struct=
ure using `init_completion()` instead of `reinit_completion()`.
- [High] The driver modifies the shared buffer `pcu->cmd_buf` in softirq co=
ntext without acquiring any locks, racing with process-context readers and =
writers.
--

commit 84ff3321586c87d80a72cd7623b583cc09753224
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - validate control endpoint type

The driver currently assumes that the first endpoint of the control
interface is an interrupt IN endpoint without verifying it. A malicious
device could provide a different endpoint type, which would then be
passed to usb_fill_int_urb(), potentially leading to kernel warnings
or undefined behavior.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 22be49d3b879d..51b1cdc226e65 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1703,6 +1703,12 @@ static int ims_pcu_parse_cdc_data(struct usb_inter=
face *intf, struct ims_pcu *pc
>  		return -ENODEV;
> =20
>  	pcu->ep_ctrl =3D &alt->endpoint[0].desc;
> +	if (!usb_endpoint_is_int_in(pcu->ep_ctrl)) {
> +		dev_err(pcu->dev,
> +			"Control endpoint is not INTERRUPT IN\n");
> +		return -EINVAL;
> +	}
> +
>  	pcu->max_ctrl_size =3D usb_endpoint_maxp(pcu->ep_ctrl);

[Severity: High]
This is a pre-existing issue, but is the control endpoint's wMaxPacketSize
validated to ensure it is non-zero?

A malicious device can provide an interrupt IN endpoint with a
wMaxPacketSize of 0, which the driver does not validate. Later,
ims_pcu_buffers_alloc() attempts to allocate DMA memory for the control
buffer by calling usb_alloc_coherent() with a size of 0.

This invokes the underlying DMA allocation APIs, which trigger a WARN_ON_ON=
CE
for zero-sized allocations. Furthermore, it causes usb_submit_urb() to be
called with a 0-length transfer buffer for an interrupt IN endpoint, which
may lead to undefined behavior in the host controller driver.

[Severity: High]
This isn't a bug introduced by this patch, but does ims_pcu_buffers_free()
pass the correct size when freeing urb_in_buf?

Looking at the allocation in ims_pcu_buffers_alloc():

        pcu->urb_in_buf =3D usb_alloc_coherent(pcu->udev, pcu->max_in_size,
                                             GFP_KERNEL, &pcu->read_dma);

And the freeing in ims_pcu_buffers_free():

        usb_free_coherent(pcu->udev, pcu->max_out_size,
                          pcu->urb_in_buf, pcu->read_dma);

It appears max_out_size is used to free the buffer instead of max_in_size.
If a device has different max packet sizes for its in and out endpoints,
this size mismatch violates DMA API requirements, as the size passed to
dma_free_coherent() must exactly match the size passed to
dma_alloc_coherent().

Can this lead to memory corruption in the DMA allocator or memory leaks?

[Severity: High]
This is a pre-existing issue, but does the driver safely re-use the cmd_done
completion in __ims_pcu_execute_command()?

__ims_pcu_execute_command() calls init_completion() before sending a comman=
d:

        pcu->expected_response =3D expected_response;
        init_completion(&pcu->cmd_done);

If a late or duplicate response from a previous command arrives just as
init_completion() is executing, the softirq handler
(ims_pcu_handle_response) might concurrently call complete(&pcu->cmd_done).

Because init_completion() unconditionally re-initializes the wait queue's
spinlock, this concurrent access can cause lock corruption and a potential
kernel panic.

Should the driver use reinit_completion() here instead to safely reuse the
completion structure?

[Severity: High]
This isn't a bug introduced by this patch, but is the shared buffer
pcu->cmd_buf adequately protected against concurrent access?

When a response is received, the ims_pcu_handle_response() softirq executes
the buffer copy without holding any spinlock:

        memcpy(pcu->cmd_buf, pcu->read_buf, pcu->read_pos);

Process contexts read and write pcu->cmd_buf while only holding the sleepab=
le
cmd_mutex. Since softirqs don't acquire cmd_mutex, there is no
synchronization.

If a malicious device sends multiple identical or spoofed response packets
for the same command, the softirq will repeatedly overwrite cmd_buf
concurrently while the process context is reading it after waking up from
wait_for_completion().

Could this data race cause the process context to read corrupted data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D6
