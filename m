From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: QUANTA touchscreen controller integrated in HP2310ti no longer recognised (regression in 3.5 and later as compared to 3.3)
Date: Wed, 22 Aug 2012 10:00:12 +0100
Message-ID: <2303254.RzNp9y400f@f17simon>
References: <1700293.Y8yBuPUG33@f17simon> <20120821190626.GA1260@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1754354.pWgEBF0dJL"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp04.uk.clara.net ([195.8.89.37]:42279 "EHLO
	claranet-outbound-smtp04.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750919Ab2HVJAW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 05:00:22 -0400
In-Reply-To: <20120821190626.GA1260@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>


--nextPart1754354.pWgEBF0dJL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 21 August 2012 21:06:26 Henrik Rydberg wrote:
> Hi Simon,
> 
> > We're going through our collection of touch screens, making sure that they all 
> > work with current kernels, and we've found one that doesn't work with today's 
> > Linus master.
> > 
> > lsusb describes the screen as:
> > Bus 006 Device 002: ID 0408:3001 Quanta Computer, Inc. Optical Touch Screen
> 
> What about 0408:3008, does that one work?
> 
I don't have a sample of 0408:3008 to try.

> > Any ideas on the best way to resolve this regression?
> 
> What does 'cat /sys/bus/hid/devices/0003:0408:3001.0001/modalias' say?

It's the same whether or not I revert the patch:

# cat /sys/bus/hid/devices/0003:0408:3001.0001/modalias
hid:b0003g0000v00000408p00003001

If I've understood hid-code.c correctly, this means that 
hdev->group == HID_GROUP_ANY, implying that neither hid_scan_usage nor 
hid_scan_report have run.

> 
> The patch below ought to be enough to make it work, although it is
> still unclear why it is needed.
> 
I'd like to get to the bottom of why this patch is needed - the patch I
reverted covered 71 touchscreen controllers, and the fact that hdev->group is
set to HID_GROUP_ANY worries me - I'm concerned that there's something
deeper wrong that's causing the USB HID core to not be able to get the report
descriptor reliably.

> Thanks,
> Henrik
> 
> ---
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index bd4bc3c..2b775c3 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -963,7 +963,7 @@ static const struct hid_device_id mt_devices[] = {
>                 MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
>                         USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
>         { .driver_data = MT_CLS_CONFIDENCE_CONTACT_ID,
> -               MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
> +               HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
>                         USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001) },
>         { .driver_data = MT_CLS_CONFIDENCE_CONTACT_ID,
>                 MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
-- 
Simon Farnsworth
Software Engineer
ONELAN Ltd
http://www.onelan.com

--nextPart1754354.pWgEBF0dJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAABAgAGBQJQNJ+gAAoJEIKsye9/dtRWTBMH/0EQbRkJtMp4B7kstUzf9cFC
q3NN8DRQgG7Xi09YlwsEwgAsKyHXyUQmld3GpK82PErKZyd4jDrbgqjmAe9gZjUF
k37c2Kbzn1ovA2EebBEtdkwIlqSglICpOm+dxrIH8DetSd2uKGGDrO5hF5ZbwDV4
pPD0IWCZ4iVsvA94TD4PJOaHV1hGE3WQ7+15ETr7+wnr0SZML2XPrHG4Pghf3ZZv
xPjSP8dCC/va8RU0Y43LMCUoz9Op2xSBWMSN0XXbuzdJ9neMv3B5MjxYXLGNC+5G
GkEoxd7JvYCj+lINibwUFQSYfV2881o9A+R2/cwcPPHZXwgNkfrEqrSdQIc6IeE=
=laYz
-----END PGP SIGNATURE-----

--nextPart1754354.pWgEBF0dJL--

