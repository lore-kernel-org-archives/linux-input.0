Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E63C455E;
	Fri,  3 Apr 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233067; cv=none; b=l3k1WP0XFhiYV5z7UO/PA2SGLarg6kFcYEPEo3Hm3Ov7gw3bVjULC+6c7tO3V3KxFWnqX4m/VCRn4wtF50XdbiJumsKblrTR0AaUmIPQB1vsO4wBtoa+pDGUrgyDaZE031l0NKJLK/yOdwIn8Tht1gKW98PkDcbgyATgBH1zvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233067; c=relaxed/simple;
	bh=bF4sD3BGdqiEYNJvd62lIhsl1UuiOZTz+TC4Kkz08kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDxjeSG1Y7uLzzGUdrLFZ3kF0V/SAd6oufhJXf9CX2mWsGbaQQJMzDMbMfjYERKYkWKxJuoybCHsE+ptP8WFxGUrW0qKwgMl4Mlva8xdkf2/OOdqzrW00Rgm4N/05VWeACC+cjMFwXZjrevoMH8UUN0pMBwypPwjIzynYo/hdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFkeIMZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFkeIMZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DB6C4CEF7;
	Fri,  3 Apr 2026 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233067;
	bh=bF4sD3BGdqiEYNJvd62lIhsl1UuiOZTz+TC4Kkz08kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFkeIMZYWVYZBH83RSHiasn3QiSA8QnWcx+VfssCoBJgtiocSJPPeNoUpROB6rN9I
	 aD/mpIaxHKhJ8XSNqYyizfzm5cVWODx25KYAbXpLffNXEBu0dRnMSCjNBAFgPaHIc/
	 qehJkXgJ5qll3kp/aMMcjtRy3/cVx/MCOPi3nKoeabkgSXMV7nFJosZekRS35nYFH5
	 ffiX2pzgJ0XEGbtZdC6U+IUStK19sUoCTOrlQtSi5fKdGk30/C92wT73tdRLCOGZ9B
	 gqBjlkHK1KrpeKC0U7vhfjVTAzYhp4iuzjqdBeomZVn3al/CQyGP5cL4vJ1dTaTfqf
	 PmZOSnZBPX7eA==
Date: Fri, 3 Apr 2026 18:17:43 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	muhammed Rishal <muhammedrishal7777777@gmail.com>
Subject: Re: [PATCH 8/8] bpf: Add fix for Trust Philips SPK6327 (145f:024b)
 modifier keys
Message-ID: <ac_nblOZD_DwTYKb@beelink>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
 <20260403-wip-sync-udev-hid-bpf-2026-04-v1-8-978cedb9a074@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-8-978cedb9a074@kernel.org>

Of course, you hit send and you realize the commit message is missing
the 'HID:' marker. Sorry Jiri.

Also, this commit should probably be tagged with:
From: muhammed Rishal <muhammedrishal7777777@gmail.com>

Sorry, again.

Muhammed, FYI, there is nothing to be done on your side (just in case
you wonder why you receive this email). It's the normal process to merge
testing HID-BPF programs into stable.

Cheers,
Benjamin

On Apr 03 2026, Benjamin Tissoires wrote:
> The Trust Philips SPK6327 keyboard (USB ID 145f:024b) has a broken HID
> descriptor on interface 1. Byte 101 is 0x00 (Input Array) but should be
> 0x02 (Input Variable), causing LCtrl, LAlt, Super, RAlt, RCtrl and
> RShift to all report as LShift on Linux.
> 
> This BPF fix patches byte 101 at runtime fixing all affected modifier
> keys.
> 
> Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/234
> Signed-off-by: muhammed Rishal <muhammedrishal7777777@gmail.com>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c b/drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c
> new file mode 100644
> index 000000000000..bc7ff27eac9f
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Fix for Trust Philips SPK6327 (145f:024b)
> + * Modifier keys report as Array (0x00) instead of Variable (0x02)
> + * causing LCtrl, LAlt, Super etc. to all act as LShift
> + */
> +#include "vmlinux.h"
> +#include "hid_bpf.h"
> +#include "hid_bpf_helpers.h"
> +#include <bpf/bpf_tracing.h>
> +
> +#define VID_TRUST 0x145F
> +#define PID_SPK6327 0x024B
> +
> +HID_BPF_CONFIG(
> +	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_TRUST, PID_SPK6327)
> +);
> +
> +SEC(HID_BPF_RDESC_FIXUP)
> +int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
> +{
> +	__u8 *data = hid_bpf_get_data(hctx, 0, 4096);
> +
> +	if (!data)
> +		return 0;
> +
> +	/* Fix modifier keys: Input Array (0x00) -> Input Variable (0x02) */
> +	if (data[101] == 0x00)
> +		data[101] = 0x02;
> +
> +	return 0;
> +}
> +
> +HID_BPF_OPS(trust_spk6327) = {
> +	.hid_rdesc_fixup = (void *)hid_fix_rdesc,
> +};
> +
> +SEC("syscall")
> +int probe(struct hid_bpf_probe_args *ctx)
> +{
> +	/* Only apply to interface 1 (169 bytes) not interface 0 (62 bytes) */
> +	if (ctx->rdesc_size == 169)
> +		ctx->retval = 0;
> +	else
> +		ctx->retval = -EINVAL;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> 
> -- 
> 2.53.0
> 
> 
