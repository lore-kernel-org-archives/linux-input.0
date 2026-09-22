Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331BD4343F2
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099518; cv=none; b=eGH2f2urbVgm9N/jHTkDp3c+nRYfGNVK9QmAYWasavBejSwOyUfY0Mjzk97+0HRm5otbvZB2OY7PpeuOfy5Fo+dT88RD9YaNTMnGTUoj5J9mZbyhV9dQXTWrb7m2hYIpN+hwQJl67CCNOSile+MhAHrXZTMeWqyZzTz77FOn++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099518; c=relaxed/simple;
	bh=TZSzyQXEAj6slU8+QP3y/d68v3gx2gSnXdb1c5/Z1do=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4rKJYQT6GytPGGid3MBZsRJ+jrGQEecGs0G59CUO1HKeg2/wuc3QRA5FhF2DQfqIfGH3SNyKwSGkkwh/j6oJI2V5ORkgiWS0kpAy+iicwlghrxJBpzT4n2dU/Z58wMMhCtDZiTcvwTZ+HS91YcAlNcRImKV4j9C5+t9DlI/aO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdwvwvGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdwvwvGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4FD1F000FF;
	Tue, 22 Sep 2026 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099516;
	bh=ik+PqvPKTqhfYaSg/S78/PR3vdFLsjTzyC5vu+F1Chc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdwvwvGC6R/SO9c/e9sYYfQy/qrNWEJA25cLqCGJ66tJo4VQ9C36m7wqcZkKYvFm0
	 BI+7cf+I5aUjZ7eIScqerwiZqRzs1XvjH9xslUz2/CRqKlHuFvEZOiJoH5ITExjy6+
	 ta6E60yQlOv04D7vXb4NHwQtA4YX0EeeTTocRfuHNV9nqvWonYZKi9o+k2aCJ3LP2Y
	 hxSo2QwXPCghXHUqp00naVAWy9nM3xdSiXJlu9lSsX+6aFokkGI1VK6skMPt2P53Wx
	 xw2n9zbEO7z8QvxBKvllYC4wCv23do+n73Nv80emna2Fo20Av4sUAHOMZdhek28WpJ
	 FHPcgdkGpR/RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: fix hi-res scroll for
 Bolt-connected MX Master
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RXJpayBIw6VrYW5zc29u?= <erikhakan@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260922-feature-bolt-fix-v1-1-63b0fa8da0d3@gmail.com>
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <20260922-feature-bolt-fix-v1-1-63b0fa8da0d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:51:55 +0000
Message-Id: <20260922175156.5F4FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: logitech: OOB read via invalid parent cast in hidpp_is_bolt_c=
hild()
--

commit 4a9ffd2a32ed4f113b3f3e2880f7d7d6145199e3
Author: Rafael Passos <rafael@rcpassos.me>

HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX Master

This patch routes the mouse wheel using HID++ for Bolt receivers so ticks
are scaled by the multiplier and correctly reported as a hi-res event. It
also reorders the hidpp_is_bolt_child function to be used in
hidpp_connect_event to check the gate for hidpp_initialize_hires_scroll.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 4e00ac91493f7..166980be57b7c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -3891,6 +3891,19 @@ static int hidpp10_consumer_keys_raw_event(struct =
hidpp_device *hidpp,
>  	return 1;
>  }
> =20
> +static bool hidpp_is_bolt_child(struct hid_device *hdev)
> +{
> +	struct device *parent =3D hdev->dev.parent;
> +	struct hid_device *receiver_hdev;
> +
> +	if (!parent)
> +		return false;
> +
> +	receiver_hdev =3D to_hid_device(parent);
> +	return receiver_hdev->vendor =3D=3D USB_VENDOR_ID_LOGITECH &&

[Severity: High]
Does this code perform an invalid cast for non-Bolt devices that leads to an
out-of-bounds read?

When standard USB devices or Bluetooth devices connect, their parent is not=
 a
struct hid_device (it's typically a struct usb_interface or an HCI connecti=
on).
Using to_hid_device() on these parents results in an invalid container_of c=
ast,
and accessing receiver_hdev->vendor reads from unrelated slab memory, which
could lead to a KASAN slab-out-of-bounds splat or kernel panic.

> +	       receiver_hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_BOLT_RECEIV=
ER;
> +}
> +
>  /* ---------------------------------------------------------------------=
----- */
>  /* High-resolution scroll wheels                                        =
      */
>  /* ---------------------------------------------------------------------=
----- */
> @@ -3901,7 +3914,9 @@ static int hi_res_scroll_enable(struct hidpp_device=
 *hidpp)
>  	u8 multiplier =3D 1;
> =20
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
> -		ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> +		bool use_hidpp =3D hidpp_is_bolt_child(hidpp->hid_dev);

[Severity: High]
For Bluetooth devices with hi-res scroll capabilities, doesn't this
unconditionally call hidpp_is_bolt_child(), exposing them to the invalid
cast mentioned above?

> +
> +		ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
>  		if (ret =3D=3D 0)
>  			ret =3D hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
>  	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL=
) {

[ ... ]

> @@ -4553,7 +4568,9 @@ static void hidpp_connect_event(struct work_struct =
*work)
>  	}
> =20
>  	hidpp_initialize_battery(hidpp);
> -	if (!hid_is_usb(hidpp->hid_dev))
> +
> +	if (!hid_is_usb(hidpp->hid_dev) ||
> +	    hidpp_is_bolt_child(hidpp->hid_dev))

[Severity: High]
For standard USB devices, !hid_is_usb(hidpp->hid_dev) is false, which forces
the evaluation of hidpp_is_bolt_child(). Doesn't this expose all standard
native USB Logitech devices to the invalid parent cast and out-of-bounds re=
ad?

>  		hidpp_initialize_hires_scroll(hidpp);
> =20
>  	/* forward current battery state */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-feature-bo=
lt-fix-v1-0-63b0fa8da0d3@gmail.com?part=3D1
