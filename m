Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D0374E5B
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127197; cv=none; b=hv87w9ZpCfmSrjFGbaIxzS96HmUU59DSdwu8b5l2/D4+EJGCyWQO4iTHVNE4Yp/75FA2Qz3Bxqp73KWlAGRP3GvCF/u4NWUaUwJaf0vRi54d8PIkwC4WSzd4rwxKK+ZBqj/7ypSz3C8lCXHfY7yj90JGIH6J1g9uL21O6E57vzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127197; c=relaxed/simple;
	bh=pX2KlAu6UnIrxpcm8kmaOybSUfwnj020seDGzU1WLrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzBHuviYRDhHwlUc3sWGnhBqgD77W2Ip4VTZgEl517rg/ga0Hsj3uOGNM8By+M3wpACqpjIQ35cRP2f0IdRfLliENt/dGYh5ZqyN4efgG8Hy1GV9+BJYn72ceptIXSjSoy2iXhf7xwcPNnh4r8BJo/k4D6CNRQlCj9J2+I4MOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=feGy+KFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="feGy+KFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881FE1F000E9;
	Mon, 27 Jul 2026 04:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785127196;
	bh=DW4ccjsDrulV273AU/s0/I3QYaatrMXKJTZJxcfuW6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=feGy+KFltmLadu//MvEkMylaGwnOFt7iMHC5ZLvB/TAonl2g4j5wrzdvk75rSFUEd
	 xpkXfNYLXHNUp7Abd/OhluHu3/FMGJAFvyaK/x9sZwAJ6Jlky9dtn70qV6P1/6wdvT
	 ydJV4dNz9N3ywpcuWLASiZFIedMERKQUmicvbLvc=
Date: Mon, 27 Jul 2026 06:38:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ishaan Dandekar <ishaan.dandekar@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2] Input: xpad - add support for generic clone X-Input
 gamepads
Message-ID: <2026072715-slam-viewing-d59a@gregkh>
References: <20260726171526.43071-1-ishaan.dandekar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726171526.43071-1-ishaan.dandekar@gmail.com>

On Sun, Jul 26, 2026 at 10:45:26PM +0530, Ishaan Dandekar wrote:
> This device exposes a vendor-specific Xbox 360 interface (0283:0001)
> but was previously ignored by the driver, causing it to fall back to
> a generic hid interface. Adding its ID to xpad_device and xpad_table
> allows it to initialize correctly as an X-Input gamepad.
> 
> Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
> ---
> Note to maintainers:
> This device exposes a vendor-specific Xbox 360 interface (0283:0001). 
> Adding its ID to xpad_device and xpad_table allows it to initialize 
> correctly as an X-Input gamepad with full rumble support.
> 
> Context: This patch is a companion to a 2-patch series submitted to 
> the linux-usb subsystem (v2: "Fix initialization for Generic Clone 
> X-Input Gamepads"). The USB patches apply a 255-byte config request 
> quirk to prevent this device's firmware from crashing. Once stabilized 
> by the USB core, this xpad patch is required to actually route it 
> properly. Both can be merged independently.
> 
> Changes in v2:
> - Wrapped commit message at 72 columns.
> - Separated from the USB series to target the input subsystem directly.
> 
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
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

Comment doesn't line up :(

