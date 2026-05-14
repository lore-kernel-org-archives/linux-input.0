Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32E357D0E
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754732; cv=none; b=QhJhALzzaQowXlwZtGgRjG4hbxIa9Z84SeVp/HNLLLivH+Yr+V+JQDX2dJD8tx3cLvkNf6bYIxuLgEzBxrg+YJDj6oT4VdcCNdl1XPG5L443OeLL+Ro4PvwrYnBjxN2q6VhYpP/gKOexFNfeYFQqRJdgnk1m7bJTPA7EuVvLV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754732; c=relaxed/simple;
	bh=XoI/cd2i+lFyhygS1nY5DzHwSP+Pk0SxP+CFOE3waFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1IJzjG0rRIV6ofgc3HwgXhcKuGFEU+ZoSxb47WmCTMqjkDdgJpg6xoUW0UA7WHjZenyB9NPB5yf6JLA2bZ3hdfFJ+ARk1lH3P2YES5yIYuAzbnA/ohQo1R9RZHA3KswjfJYR/wZ2NiN9DSGZv910/MffvrPONrhdJ4plSkBU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B40gImTb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B40gImTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E6BC2BCB3;
	Thu, 14 May 2026 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778754731;
	bh=XoI/cd2i+lFyhygS1nY5DzHwSP+Pk0SxP+CFOE3waFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B40gImTb1x88y0U4ydAX6vStGX/q6tzlUMp88B6oy+1IXz2lcMjaLFFSq34Ya59k+
	 RheNxUQ0tMKFQ5zADcPSRCYWaEPWKlYXmdx+8hh3EUCD/TcicNstTKDb8a47Y+ORk1
	 iaPzoD051td0IIxVU9Ny7T+ugZdJDim9X+DpHv+G8ODxUfoItYHa9xdxlB5SP7qQ7V
	 6Lh+N/3bLz7WOfXWRNYOzKvijhuc3UN82wHrHhXOrtJgRC9gIA67f3/frvrTmBQoKc
	 TsinMAl8W8IEQa8/C0c3ylGPL0x71NWqei3SPb5q9atYDlMueYvJnzswPFdnCdNliL
	 /xPG4fREjrfYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] hid-asus: Fix input mapping on dedicated vendor HID
 interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260513163248.16483-6-p.pisati@gmail.com>
References: <20260513163248.16483-6-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 10:32:10 +0000
Message-Id: <20260514103211.96E6BC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The injected fake keyboard descriptor contains a malformed padding =
item that violates the HID specification.
--

commit 98dabe022a958136634ce6b477391fa33ffa21b6
Author: Joshua Leivenzon <hacker1024@users.sourceforge.net>

hid-asus: Fix input mapping on dedicated vendor HID interfaces

This commit adds a fake keyboard input to the vendor-specific interface's
report descriptor on some USB keyboards, such as the Zenbook Duo UX8406MA.
This allows the kernel to combine it with the vendor-specific collections
and process the custom mappings correctly.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index cf9184ed2d3ec..fe52fd63d61c6 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1376,6 +1376,30 @@ static void asus_remove(struct hid_device *hdev)
>  	hid_hw_stop(hdev);
>  }
> =20
> +/*
> + * Some USB keyboards, like the Zenbook Duo UX8406MA keyboard, have a de=
dicated
> + * USB interface for vendor-specific reports, separate to the generic HID
> + * keyboard or consumer control interfaces.
> + *
> + * The kernel does not register these vendor-specific interfaces as keyb=
oards,
> + * or perform input mapping on them at all.
> + *
> + * To work around this, a fake keyboard input can be added to the
> + * vendor-specific interface's report descriptor. The kernel then combin=
es it
> + * with the vendor-specific collections, and allows the interface to be =
used as
> + * a regular keyboard with our custom mappings.
> + */
> +static const __u8 asus_fake_keyboard_rdesc[] =3D {
> +	0x05, 0x01, /* Usage Page (Generic Desktop) */
> +	0x09, 0x06, /* Usage (Keyboard) */
> +	0xa1, 0x01, /* Collection (Application) */
> +	0x85, 0x01, /*   Report ID (1) */
> +	0x75, 0x08, /*   Report Size (8) */
> +	0x95, 0x01, /*   Report Count (1) */
> +	0x81, 0x00, /*   Input (Data,Arr,Abs) */

Does this Input item need to be declared as Constant?

According to the HID 1.11 specification, a field mapped as padding because
no usage is specified must be declared as Constant (e.g., 0x01 or 0x03).

Declaring it as Data (0x00) violates the protocol and could cause strict
user-space HID parsers reading the raw descriptor to reject it.

> +	0xc0,       /* End Collection */
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513163248.1648=
3-1-p.pisati@gmail.com?part=3D5
