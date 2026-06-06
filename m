Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89A3B4E84
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770391; cv=none; b=AQRw61+AGKpTnvV9ffgfbnPf0R0moYFj/C8q7xmY3VcVptVw+HOX7W/17xMKgOCMPxMly9YDf753D/WeinLYukh80//iPHcSDfxhBRq+sGcchaFd66GezI/T9ykgQxnxvEN2lBvzOosmZ1Tr/aJSTeeivHZW4isY8FxuvJPUj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770391; c=relaxed/simple;
	bh=HneO0FC6Ql5Jsbzqyme1JqkM0kETIKslw56XRX0NvcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mtl+s6K3UR6NsDp3HWFg89w4/60xWFIKTGOfZE3/IdbFDKNMk97KeCPKz4XfL20+C275+gXKzQk2pYDrpyfEv+vgG01r8z7kPsEekT65+riROxX1dBi7pb0wsHCYbWQj3iBba11o6P6KWWdrdkA+o+bQ5w+9Z4z5c2KkAnugXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj0/U6Y9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj0/U6Y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A9B1F00893;
	Sat,  6 Jun 2026 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780770388;
	bh=+od58Z25nxyWDX6jphT907ap9kkNYECZTGhqHpLX3JI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qj0/U6Y9qfr6CcUCAClkmUTVC852oHyhhK89+Mr7xJV4IaaOn2zRc/EcXc63qoqOM
	 Zc1RBNMYqhEaCXhq6DTlnQzQ1H7iqgDtujs+FiUa9z2pt+JQbtv55uIeSohhPPdbEc
	 SrDeey3PLVpeojLBo7+1VTOyqwzSAdNvbY3oimICiXWWDdMHpH+AGwwoftJdZ3GY9k
	 W8sEZ9EMj1bUe+onXuGX6phM3iaa7nrGirJNo4qcWGWqneBZB3v0cwVjycMD5EBok6
	 ahFefcfVuZnI23ekSf/KvDI2pLU5mwri8aVLRC17y0VvR95GzdnY/jc4LVtIjseKLp
	 P6OBW6jWawzIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: uhid: convert to hid_safe_input_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Llamas" <cmllamas@google.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606181552.3095967-1-cmllamas@google.com>
References: <20260606181552.3095967-1-cmllamas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 18:26:27 +0000
Message-Id: <20260606182628.60A9B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] In `dispatch_hid_bpf_device_event()`, there is no bounds check=
 before copying `*size` bytes into `hdev->bpf.device_data`, leading to an o=
ut-of-bounds write if the injected report size exceeds the BPF allocated me=
mory.
--

commit c570c0c551ca1ea46eb86fb2144c1ad379f64069
Author: Carlos Llamas <cmllamas@google.com>

HID: uhid: convert to hid_safe_input_report()

This commit converts uhid to use hid_safe_input_report() and passes
UHID_DATA_MAX as the buffer size. This allows hid core to safely zero-pad
shorter reports instead of rejecting them, preventing regressions caused by
the earlier bogus memset() removal.

Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/

> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 524b53a3c87b3..37b60c3aaf66a 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, s=
truct uhid_event *ev)
>  	if (!READ_ONCE(uhid->running))
>  		return -EINVAL;
> =20
> -	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
> -			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
> +	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UH=
ID_DATA_MAX,
> +			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);

[Severity: Critical]
This is a pre-existing issue, but does forwarding this report size without
constraining it to the device's max_report_len cause a buffer overflow in H=
ID
BPF?

In uhid_dev_input(), we allow userspace to inject input reports up to
UHID_DATA_MAX (4096 bytes) regardless of the device's parsed max_report_len.

When a HID-BPF program is attached to the device, hdev->bpf.device_data is
allocated based on the device's max_report_len, which could be much smaller.

Later, in drivers/hid/bpf/hid_bpf_dispatch.c:dispatch_hid_bpf_device_event(=
),
it executes:

	memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
	memcpy(ctx_kern.data, data, *size);

Since there is no bounds check on *size before the memcpy(), could a malici=
ous
uhid client injecting a large report size cause a heap buffer overflow when
copying into the smaller BPF allocated memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606181552.3095=
967-1-cmllamas@google.com?part=3D1
