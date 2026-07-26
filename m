Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B036654C;
	Sun, 26 Jul 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072559; cv=none; b=OnFTKUEQODwKCkzTHju2eg4ZT0U2ziso3nqhIxlq9F1xajcCy7TUNEUUrAbEri9TVd3aAZyk6AtoWmvqgJQXhPdXC1meCWdzI7kDtb4H8K6wt8IPUy2XGmvBelEpFj+W2Hy+DTAU7DAnfNJABZNXpDrR8HYQM2wCtpWvD9nEo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072559; c=relaxed/simple;
	bh=IMsy+q1MRZ+VohvNPhdDH4Hz13zpkX0HiWuoepEyC88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSrvGRpfFXnotp45GcT2PrPXrINNWDM0lCp0Pf/scxF7N2ZhgBZVcV1l0aoDQot5Tdhj6iHA22mRTKVPVxZPjwEFXRNBPZpKSbLsellyUwyxTw6LF7k9Z2chHLBIUexi2OkzsudFq/yey2jSFuzG00zTvEzfbmdEaTXEP5Gfun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gnXHDhDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gnXHDhDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F581F000E9;
	Sun, 26 Jul 2026 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785072558;
	bh=M1mdfbYQdU8eVPspT2/n8XUGJVnGGskztBho/GbhpDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gnXHDhDVI0P1WaYcbRsFHOe0NRdisfsG15RaVtWv98PrV12yab+0LScuJKw0bh/Qf
	 /33ED3uws6sl9cYo/Wocl/CsJIJQcXVv+K1h5Xn3fOvMI6JwroRRLyKCvi35zdFHh3
	 eEauLfXzxa2lnQ/mWiuhCxCL5EL3z4HPTeM16t3U=
Date: Sun, 26 Jul 2026 15:29:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ishaan Dandekar <ishaan.dandekar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	nikhilsolanke5@gmail.com
Subject: Re: [PATCH 2/3] usb: quirks: Add ShanWan gamepad to quirk list
Message-ID: <2026072633-unafraid-pastime-fe5f@gregkh>
References: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
 <20260726132039.28330-3-ishaan.dandekar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726132039.28330-3-ishaan.dandekar@gmail.com>

On Sun, Jul 26, 2026 at 06:50:39PM +0530, Ishaan Dandekar wrote:
> The ShanWan Wireless Gamepad (dongle ID 2563:0575) crashes with a -71 EPROTO error during standard enumeration because it expects a 255-byte initial configuration request. Add this device to the quirk list to use the USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE flag.

Didn't checkpath complain about this line being too long?  Please wrap
at 72 columns.

> 
> Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
> ---
>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index f5a60ccf2..97b1cdf0e 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -592,6 +592,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x2386, 0x3119), .driver_info = USB_QUIRK_NO_LPM },
>  
>  	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
> +	

checkpatch should have also caught the trailing whitespace here :(

thanks,

greg k-h
