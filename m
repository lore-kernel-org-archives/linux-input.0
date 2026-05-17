Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3FD35C188
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022269; cv=none; b=TtarjFKJKsS+xKdFe69Fc8hlW7oe3i+ISEUMk/0NLMhddQDHAdOXAoJ244rg8Km9NgKeYRqPRIPgC6gWvPpoLVpZmecrmsGU3RZZ8OuSxHPzvc2O1+gsqThPWvphBq0Tokig80OxnYrcatUkCWWNyclk9yMy3IrSlMbjLwRMOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022269; c=relaxed/simple;
	bh=C2sM/2YKZPDIfG4D2jlT8Hei2JgbUUuzC3eNWhEYRVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mROQM5wBwCVTLGTyiqBDYxUdUHPUpmdjwaG/ucDL0PEXB6SD/Ixd1OVH2hrZBnPXxkn/dSFfxaKR52qCxpZCRVjArTqb0RaxPE4TzhAc2T9s3RKIa/xZMkm/TarcJIzHjYrg8LRGYl1onDenMlfhNheFqxLF/fHbXrevDHbKRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR4GKLti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR4GKLti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3FDC2BCB0;
	Sun, 17 May 2026 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779022268;
	bh=C2sM/2YKZPDIfG4D2jlT8Hei2JgbUUuzC3eNWhEYRVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vR4GKLtiyM49CUNzK1g0Yx7TVB7k5hWhPFotKBpzRfyrCCHFCN9msCjctjhK07CkA
	 PhiRa6vA16DUWUJZ/h4HfBB/DIpdTxExowcm2Qk5ugM/HyUP04TyEnvo1Zl6gBiOg8
	 +r6NSgv6fpEndHHn9gXk9qv+zIORPBpv2eiPxesH4YkqjohckASsFSG6UyGcnojwyD
	 wTpfnCXlmlc32v7TEJSkUM/N2G7Cy63ERYpSNS2KxIVfZEc83FvLFMiUx39fI7Z4Sn
	 rNVgfiUSHDgzEoVWcSFlBpDo2UNPOSeA6bHVMmE9SDqAA6Y/rV9dMABEL6oeQ3lb5F
	 rG9xqiA9L8tCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: picolcd: prevent NULL pointer dereference in
 picolcd_send_and_wait()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Georgiy Osokin" <g.osokin@auroraos.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260517120639.38003-1-g.osokin@auroraos.dev>
References: <20260517120639.38003-1-g.osokin@auroraos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 12:51:08 +0000
Message-Id: <20260517125108.BC3FDC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Pre-existing sleeping in atomic context due to calling `hid_hw_req=
uest()` while holding a spinlock.
- [Medium] Unnecessary fix for an impossible scenario introducing a latent =
API vulnerability.
--

commit 26db02d94328ec65757bbf69ad49450f8c2b4f46
Author: Georgiy Osokin <g.osokin@auroraos.dev>

HID: picolcd: prevent NULL pointer dereference in picolcd_send_and_wait()

This commit changes the loop counter k to an unsigned int in
picolcd_send_and_wait(). The stated goal is to prevent an integer overflow
and a resulting out-of-bounds access.

> In picolcd_send_and_wait(), an integer overflow of the signed loop counter
> 'k' can theoretically lead to a NULL pointer dereference of 'raw_data'.
> If the loop executes more than INT_MAX times, 'k' becomes negative,
> making the condition 'k < size' true even when 'size' is 0.

Is this scenario actually possible? The HID core explicitly limits
report->maxfield to 256 (HID_MAX_FIELDS) and report->field[i]->report_count
to 12288 (HID_MAX_USAGES).

The maximum possible value for the loop counter k is 3,145,728, which
would not overflow a 32-bit signed integer.

> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_cor=
e.c
> index 2cc01e1bc1a84..d73e97c8b853e 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -72,7 +72,8 @@ struct picolcd_pending *picolcd_send_and_wait(struct hi=
d_device *hdev,
>  	struct picolcd_pending *work;
>  	struct hid_report *report =3D picolcd_out_report(report_id, hdev);
>  	unsigned long flags;
> -	int i, j, k;
> +	int i, j;
> +	unsigned int k;
> =20
>  	if (!report || !data)
>  		return NULL;

[ ... ]

Does changing k to an unsigned int introduce a latent vulnerability here?

drivers/hid/hid-picolcd_core.c:picolcd_send_and_wait() {
    ...
    for (i =3D k =3D 0; i < report->maxfield; i++)
        for (j =3D 0; j < report->field[i]->report_count; j++) {
            hid_set_field(report->field[i], j, k < size ? raw_data[k] : 0);
    ...
}

Because the size parameter passed to picolcd_send_and_wait() is still a
signed int, the condition k < size causes an implicit signed-to-unsigned
conversion.

If a caller were to pass a negative size, it would be promoted to a large
unsigned value, bypassing the loop bounds check and causing an out-of-bounds
read of raw_data.

While looking at this function, does the subsequent code sleep in atomic
context?

drivers/hid/hid-picolcd_core.c:picolcd_send_and_wait() {
    ...
    spin_lock_irqsave(&data->lock, flags);
    ...
    hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
    ...
}

If the HID device is instantiated via the user-space HID subsystem (uhid),
hdev->ll_driver->request is not implemented.

This causes hid_hw_request() to fall back to __hid_request(), which
unconditionally calls hid_alloc_report_buf() with GFP_KERNEL. Allocating
memory with GFP_KERNEL while holding a spinlock violates atomic context rul=
es.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517120639.3800=
3-1-g.osokin@auroraos.dev?part=3D1
