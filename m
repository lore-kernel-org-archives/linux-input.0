Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE863B19D1
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749031; cv=none; b=DdlQiVRwfEkc7IhBnJ+F9mO3kly82is5H7HBEqY0nIUFs1BuOcbcW+tm57HTxf7ytL46oluwDPd5ScuCRxruARbabfPicrirkBBCXU3HDaWVUECJlLkx8A6nast1JuKYwRmLCBqs6kGKs/deQQHhJc/nPUOMCroa9hYP6eKYgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749031; c=relaxed/simple;
	bh=2wDs8LFB/5guLmuPUXK2cv3yffmwShdRhb+XH4vdacM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TZ/ZqsV2OCwS+yV3jYNk4yK6YnYS6CT1pbVgKquZNiIaqH9yqPokt9TtHPH4/H/O0hhM7scRvVTE002WqUWXJZv+BDKVYs8FvpPD6ZNW8Fh/BR6SJX9Now5GN+zff8kYELoiechEQ1nMJFIuOCDyrRaujWfNXBCics9RML2upCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5LLYuiC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5LLYuiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08664C2BCB7;
	Thu, 14 May 2026 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778749031;
	bh=2wDs8LFB/5guLmuPUXK2cv3yffmwShdRhb+XH4vdacM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=A5LLYuiCIltGyDi6fHvSvR8gcoJWNugG6bsCyNYHHbPhWraM9ccVBCNpgccL32qeN
	 0rEqRVW/xULk1b9EsWITqxRfDhroHm9J78SFYaON5olWLe4BLzglFAP90rshjZjOe9
	 cf2F/A7+tGASX3alV5he+lRgsm8ZJmTTJUZqyLcwu4aT62GUunlr1Me+viywymshs1
	 YEPe6rsO/U17nifyIi7MaOIuxlJvsnYWPpQqbeKT9Iwc6gZnL0IgMR6RX6dhq6J0Zl
	 IfS5HlmDIXjpaG8cOCKm2AX8osdq1ZkTSllB6seSTOYfw+muyjL6+iRek0ro3R6Dja
	 ZPmg+2Cbe+pFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] hid-asus: Remove more bogus zero bytes from some
 report descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260513163248.16483-5-p.pisati@gmail.com>
References: <20260513163248.16483-5-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 08:57:10 +0000
Message-Id: <20260514085711.08664C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The trailing zero removal loop reads past the end of the report de=
scriptor buffer and lacks a lower bounds check.
- [High] The `memcpy` operation copies more bytes than are available in the=
 source `rdesc` buffer.
- [High] Trimming trailing bytes can shrink the new buffer size below what =
is required for subsequent fixed-offset memory operations, causing a heap b=
uffer overflow.
--

commit 1a97afa374b1aa0ec76a035ced7d0e6414476f71
Author: Joshua Leivenzon <hacker1024@users.sourceforge.net>

hid-asus: Remove more bogus zero bytes from some report descriptors

This commit attempts to remove bogus trailing zero bytes from specific
HID report descriptors. It adjusts the new report descriptor size by
stripping zeroes from the end and then allocates a new buffer.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
>  		if (*rsize =3D=3D rsize_orig &&
>  			rdesc[offs] =3D=3D 0x09 && rdesc[offs + 1] =3D=3D 0x76) {
>  			__u8 *new_rdesc;
> +            unsigned int new_rsize =3D rsize_orig;
> =20
> +			/* Clear bogus trailing zero bytes. */
> +			while (rdesc[new_rsize + 1] =3D=3D 0)
> +				--new_rsize;

Since the rdesc buffer contains exactly rsize_orig bytes, does evaluating
rdesc[new_rsize + 1] read two bytes past the end of the allocation?

Additionally, if the adjacent memory happens to contain zeroes, could
new_rsize decrement indefinitely and underflow since there is no lower
bound check?

> +            /* Make room for the added bytes. */
> +			new_rsize +=3D 2;
> +
> +            new_rdesc =3D devm_kzalloc(&hdev->dev, new_rsize,
>  						 GFP_KERNEL);
>  			if (!new_rdesc)
>  				return rdesc;
[ ... ]
> -			memcpy(new_rdesc, rdesc, rsize_orig);
> -			*rsize =3D rsize_orig + 1;
> +			memcpy(new_rdesc, rdesc, new_rsize);

If no trailing zeroes were stripped, new_rsize is now rsize_orig + 2. Does
this memcpy copy more bytes than are available in the original rdesc
buffer, leading to an out-of-bounds read?

> +			*rsize =3D new_rsize;
>  			rdesc =3D new_rdesc;
> =20
>  			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);

If trailing zeroes were successfully removed, could new_rsize drop below the
offsets used in this memmove and subsequent assignments?

For example, if new_rsize shrinks below offs + 15, will the fixed-offset
memmove and subsequent assignments write past the end of the newly allocated
new_rdesc buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513163248.1648=
3-1-p.pisati@gmail.com?part=3D4
