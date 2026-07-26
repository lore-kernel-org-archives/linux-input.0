Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A13644B3;
	Sun, 26 Jul 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072605; cv=none; b=Cp5QFyUX5kDDODcdr04IzJRt8MlaukAXEnQHgqlR5/45noKB1qAfBI3+8xN5HgoIfsl8uXe5xS86xS/F/XyW+AXRVpt0182QOPLafVg1e2sBJtFH3vDjTqP/bnqQpfbT9Hng4PzCvdYTsPIdIRz+0KpiJpo0tULhFNlw2+FygDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072605; c=relaxed/simple;
	bh=XJS3VgS0gHp5bBodocrEhLyA9FpcRzAyQ0G6DrMxpMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVB2AZsS9LaxranFCJvbjh+1BP8gX1A6VjKg0khGqP1kCPRYsZEYSIKxIpUZ33yAnoYdNczSAUC9eE7DT6eRSQfV+BDJCESJV6I/ag5W6mvfbqyKwk/Yv//0YqD7JfR1MfKW6dZZTWNP9Usq8tG/EXc2yELQBOqp3uJ5wHPldIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xbk0eKmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xbk0eKmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17701F000E9;
	Sun, 26 Jul 2026 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785072604;
	bh=aqm2TUmRpANKAuFpDI6qQ2VO/eM6hxxH7Espp7NEa7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xbk0eKmd9O+P3A7zxHD811w1NN1f4ZvSkZiCqFluIXFGt504nn2rYYfvfmFwrc68s
	 vh3auWccJ109YDv5AprjT9BLFpzzoDLBRITk1QNwSu72u2eeoqkts6vS/Sdm1rjXnU
	 Zk+Tx41mYaKpaJ0tYTs+lxXI44klKPzOt3rEZZRw=
Date: Sun, 26 Jul 2026 15:29:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ishaan Dandekar <ishaan.dandekar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	nikhilsolanke5@gmail.com
Subject: Re: [PATCH 3/3] Input: xpad - add support for generic clone X-Input
 gamepads
Message-ID: <2026072611-esteemed-ought-0b68@gregkh>
References: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
 <20260726132039.28330-4-ishaan.dandekar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726132039.28330-4-ishaan.dandekar@gmail.com>

On Sun, Jul 26, 2026 at 06:50:40PM +0530, Ishaan Dandekar wrote:
> This device exposes a vendor-specific Xbox 360 interface (0283:0001) but was previously ignored by the driver, causing it to fall back to a generic hid interface. Adding its ID to xpad_device and xpad_table allows it to initialize correctly as an X-Input gamepad.

Same "too long of a single line" comment here.

And as this is going to the input subsystem, no need to send it as part
of a different series, right?

thanks,

greg k-h


> 
> Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 2 ++
>  drivers/usb/core/quirks.c     | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f..c0a15db03 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -99,6 +99,7 @@ static const struct xpad_device {
>  } xpad_device[] = {
>  	/* Please keep this list sorted by vendor and product ID. */
>  	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
> +	{ 0x0283, 0x0001, "Generic X-Input Gamepad", 0, XTYPE_XBOX360 },
>  	{ 0x0351, 0x1000, "CRKD LP Blueberry Burst Pro Edition (Xbox)", 0, XTYPE_XBOX360 },
>  	{ 0x0351, 0x2000, "CRKD LP Black Tribal Edition (Xbox) ", 0, XTYPE_XBOX360 },
>  	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
> @@ -496,6 +497,7 @@ static const struct usb_device_id xpad_table[] = {
>  	 */
>  	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
>  	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
> +	{ USB_DEVICE(0x0283, 0x0001) }, /* Generic X-Input Gamepad */
>  	XPAD_XBOX360_VENDOR(0x0351),		/* CRKD Controllers */
>  	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
>  	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 97b1cdf0e..b5b577f0b 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -592,7 +592,7 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x2386, 0x3119), .driver_info = USB_QUIRK_NO_LPM },
>  
>  	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
> -	
> +

You fixed this up here, just do it right in the first patch :)

thanks,

greg k-h
