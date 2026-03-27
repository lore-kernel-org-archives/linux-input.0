Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566433A718;
	Fri, 27 Mar 2026 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608683; cv=none; b=PG+MdCnLUOg1girDPAGwxNaRRLSTywdjJnsGy181VW96k6r1dn8pzhK1ObJkP31LE1MjsBgebiZKpWWUx8s4XVLZzksLg5QaNNx5tsT+oVRfYgUnkm5U/pZbv92ZrMkE3Aar9oPWLkSm1WANczR5GHNMh69Qjykug55jSog9z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608683; c=relaxed/simple;
	bh=c5RRcpHfqRHM2t4BpFKYnDsrlRAJ/3ldrlvz6OHuifk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uImb9H7/1VYHsJB+CRB+IP8oVBjc/W+dtxmwdh8n5XJGWigzU/Zonaqbsy4L9vJIriDaaoOE8Rs6Ey00pJCDraVTx93nvnNI1JVKCVPUIobhkhHyuwGIHDs2nVq89SP7QgE+3YD8GQAQ2pJWwi6nO1nYUYMu4ouF3WlCi65yevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nesTjqZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nesTjqZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0174CC19423;
	Fri, 27 Mar 2026 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608683;
	bh=c5RRcpHfqRHM2t4BpFKYnDsrlRAJ/3ldrlvz6OHuifk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nesTjqZRqtMyqqBk0Gm7t8riCWbPDMHupBZ1IEQphFz8aH6VfRRgKNjAPR0XrjHSS
	 52H89IhBdT631+MkF4Sdbk8vQUMeQv2Z1rcWCvZzRSINeBzEOleqZSAfTwWKaqsXUh
	 p42JrBT9XzC5ARIMw3TrMk3IDIY4dR6m2k/cbbgrTdn4OAJbwk7dbwmx4UHdFcFHYA
	 jaXYCUY3dx4QMBPyiWYz8MT7r5ZjKQewLzQKGiQGgDzlOz8cqsTHKoONQgUkH42EYS
	 EXZE5P6g0LTeS/tJSawFJ2E252y95QyCQgDH8MbD69ILyNtdAa+zsSCDE0YaDYZzd2
	 C9jiBXOhVWLig==
Date: Fri, 27 Mar 2026 11:51:20 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: leo vriska <leo@60228.dev>
cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo
 Pro 3
In-Reply-To: <20260304183727.538405-1-leo@60228.dev>
Message-ID: <029p1n80-9p21-1q78-rn72-p93qpp4rnosq@xreary.bet>
References: <20260304183727.538405-1-leo@60228.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Mar 2026, leo vriska wrote:

> According to a mailing list report [1], this controller's predecessor
> has the same issue. However, it uses the xpad driver instead of HID, so
> this quirk wouldn't apply.
> 
> [1]: https://lore.kernel.org/linux-input/unufo3$det$1@ciao.gmane.io/
> 
> Signed-off-by: leo vriska <leo@60228.dev>
> ---
>  drivers/hid/hid-ids.h    | 3 +++
>  drivers/hid/hid-quirks.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4ab7640b119a..8c1f41a9e5f6 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -22,6 +22,9 @@
>  #define USB_DEVICE_ID_3M2256		0x0502
>  #define USB_DEVICE_ID_3M3266		0x0506
>  
> +#define USB_VENDOR_ID_8BITDO		0x2dc8
> +#define USB_DEVICE_ID_8BITDO_PRO_3	0x6009
> +
>  #define USB_VENDOR_ID_A4TECH		0x09da
>  #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
>  #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 3217e436c052..f6be3ffee023 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -25,6 +25,7 @@
>   */
>  
>  static const struct hid_device_id hid_quirks[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_8BITDO, USB_DEVICE_ID_8BITDO_PRO_3), HID_QUIRK_ALWAYS_POLL },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },

Applied to hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

