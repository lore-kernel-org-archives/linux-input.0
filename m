Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DD395ACE;
	Mon,  3 Aug 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781499; cv=none; b=lw8rlmdQYEp92maMbqlZO+bQx2wqCd8yTSOkA/rQeXdqPzaN4vMVmtVc2Y50p7WHIZvics+Y+FfG0woaMVShekdjrS+FUt/Bv8S0H5kQbzUIw49cDtlrNytTDHnXNjr6kR/SgSVDnCijTx20Ew2TBarT3Zk+YgiZaloKNUfZPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781499; c=relaxed/simple;
	bh=oiO/41X6pwLhg2poXMF+tIF/KK8ouxcxcMbRaeXPPBk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nectB8cfbOQfQXReQtYT2I3GwPowNm3j0WvSHZjhWF9vr78rgyHjGHc9WmICNFartEmDOTxfhe4xvn8D32j2cdG02jv1QY3PcIUW2agPKV9RZa2R013wS7L9eZemvxPTRA5xdK3hNPM6+6k8EDuykvK42ZeE1RJVlAcK78voJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6pSHRiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6pSHRiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB2F1F000E9;
	Mon,  3 Aug 2026 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781497;
	bh=j2k9dMwLZkK+jnVUSfHcgai+Yr+R8pYObJlZwxkJ27k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=R6pSHRiQGgLIzZx3KfUrVsH57JfFoI8qlQX8YoqGP0NAKxOeyiVuMIDTMojVW8mTx
	 9+nT0xIoaYZh4hcnWhMxPr4S6jeF0VbA2hAwLfO3nLkbayELyd779lRzRd1VWSJwEx
	 yqN1o4a2dIjURbLdsV0wKUe7tWZhQYFGu6tXvV1qX1MPd8pYrrQri/suyDSfJinB8u
	 AAkGzaKeSfBk1zeqxCDhh2dXT07J8eVtjpun6YBBmRTnREjfq3Qrv2LyD2aichZdHn
	 p/vc8Mjpr50z1DvYfXv0VE7kwfYUKYseCbbGjqGXbxoGea8H+4SGWlcblkz+8FJRhI
	 R5Xip6TynTmRg==
Date: Mon, 3 Aug 2026 20:24:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Bastien Nocera <hadess@hadess.net>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for G502 X Plus USB
 mouse
In-Reply-To: <20260721171246.461232-5-stuart.a.hayhurst@gmail.com>
Message-ID: <447n6n59-2004-53q4-82o2-q3p5rp31ro19@xreary.bet>
References: <20260721171246.461232-5-stuart.a.hayhurst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Jul 2026, Stuart Hayhurst wrote:

> The wireless dongle is already supported, this adds detection for
> the mouse in wired mode. Supports battery reporting.
> 
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 90b0184df777..25620494e741 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4647,6 +4647,8 @@ static const struct hid_device_id hidpp_devices[] = {
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
>  	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
> +	{ /* Logitech G502 X Plus Wireless Gaming Mouse over USB */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC095) },
>  	{ /* Logitech G703 Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
>  	{ /* Logitech G703 Hero Gaming Mouse over USB */

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

