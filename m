Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4243DA4B
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382474; cv=none; b=KM1sVmwveUBzcSrVZ5L1gPLv7b1DtARx4BJUpSaPsgVC6HSXdOTA6CxQe8erOr+3PgQu5rVL1tKiJBAPDCcSxkpQ27glEud9vZUE05K5pYSAb/moeaZhz/oiU2JSzJ2T58tJCYOUSKMGS10MVNIGOatBOjggerC5nt7Z76r3oWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382474; c=relaxed/simple;
	bh=JzODCoqDyqrBOjRXcarcFZf41c4gt3Y5F4wkVteLv1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXiSgW7zvLhmC/1TO/YmJPxjKijoAXzMGIrqw6pTAw7XMJS+NlB9zpxJF9Yc09h7J1G/rnJvt9bNsLqKpkEq37nYY5fJQ7UCz1QOR1BYqqf83CPVwbCXJwbmQomzlzAo0JYLt6sO40VLTfvi9CRwiQOgUflvzHUX56Ky/rxzr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=iJhBb2Q4; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="iJhBb2Q4"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id BAC83635B040;
	Mon, 14 Sep 2026 12:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1789381876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0/8kxkBbMPsCrrouYKr+ENURYKUrB4qrbIqSAxYVtc=;
	b=iJhBb2Q4Vf4BZ+SqIbb+n+5AaEehEeTS6+1bg9uZ4jeuqNz+uLG2MERFWPBPsTjyBphCcT
	pYurNFinbTz2ywQHK4K9b9q+81O9aqL/1ypfoItV8JY+zJpaG/Ya6s+33SxHHwUYJy3RVQ
	coWW1jxe7vzSm+ix/xGGRLn5C9Ap+og=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net, hadess@hadess.net, jikos@kernel.org, bentiss@kernel.org,
 erikhakan@gmail.com, Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Rafael Passos <rafael@rcpassos.me>
Subject:
 Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX
 Master
Date: Mon, 14 Sep 2026 12:31:01 +0200
Message-ID: <awkjflaaQZW7nPVUOsxJ5A@natalenko.name>
In-Reply-To: <20260904034843.1340846-1-rafael@rcpassos.me>
References: <20260904034843.1340846-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartPXfqGdVcShmYsAM8ySghNQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPartPXfqGdVcShmYsAM8ySghNQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org
Date: Mon, 14 Sep 2026 12:31:01 +0200
Message-ID: <awkjflaaQZW7nPVUOsxJ5A@natalenko.name>
In-Reply-To: <20260904034843.1340846-1-rafael@rcpassos.me>
References: <20260904034843.1340846-1-rafael@rcpassos.me>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 4. z=C3=A1=C5=99=C3=AD 2026 5:48:29, st=C5=99edoevropsk=C3=BD=
 letn=C3=AD =C4=8Das Rafael Passos wrote:
> The new added support for Logitech HID++ caused this mouse to
> scroll too far for each tic when using the USB dongle (Bolt).
> Previously, this mouse was handled as hid_generic over the Bold
> connection, and logitech-hidpp when over Bluetooth.
>=20
> Cause:
> Over the Bolt receiver, the mouse reports  are forwarded over the generic
> interface 1, instead of the new HID++ child device. The generic hid does
> now know about the hi-res scrolling used by the HID++.
> In my tests, I discovered this mouse has a multiplier factor of 15. This
> multiplier is only handled by the logitech-hidpp driver. When piped to
> hid_generic, the "hi-res" value was piped to a "low-res" field, making
> the scroll unbearable.
>=20
> The fix routes the wheel using the HID++, so the ticks are scaled by the
> multiplier and correctly reported as a hi-res event.
>=20
> I also had to move the hidpp_is_bolt_child function up, to use it in the
> hidpp_connect_event function, where the gate for
> hidpp_initialize_hires_scroll function lives.
>=20
> Tested with:
> - Logitech MX Master 3S (mouse) via Bolt receiver and Bluetooth.
>=20
> Fixes: 022eb347ff3a ("HID: logitech: add Bolt receiver support for Logite=
ch HID++ devices")
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>

=46or v7.3-rc3 + Bolt receiver + MX Master 4 mouse:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

> ---
>=20
> Hi,
> I decided to send this patch as soon as I made it work, to try to make
> it into this fix cycle.
>=20
> I do not have other devices to test this with.
> It would *be great* to have other users testing this.
>=20
> Lastly, I decided to make all the changes in a single patch.=20
> But I can break it up if asked.
>=20
> Thanks,
> Rafael
>=20
>=20
>  drivers/hid/hid-logitech-hidpp.c | 47 ++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 1504de32b1c84..960543bfd5ea1 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3900,6 +3900,19 @@ static int hidpp10_consumer_keys_raw_event(struct =
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
> +	       receiver_hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_BOLT_RECEIV=
ER;
> +}
> +
>  /* ---------------------------------------------------------------------=
=2D---- */
>  /* High-resolution scroll wheels                                        =
      */
>  /* ---------------------------------------------------------------------=
=2D---- */
> @@ -3910,7 +3923,9 @@ static int hi_res_scroll_enable(struct hidpp_device=
 *hidpp)
>  	u8 multiplier =3D 1;
> =20
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
> -		ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> +		bool use_hidpp =3D hidpp_is_bolt_child(hidpp->hid_dev);
> +
> +		ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
>  		if (ret =3D=3D 0)
>  			ret =3D hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
>  	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL=
) {
> @@ -3998,6 +4013,19 @@ static int hidpp20_hires_wheel_raw_event(struct hi=
dpp_device *hidpp,
>  		return 1;
>  	}
> =20
> +	/* wheel movement event: 16-bit signed delta in HID++ ticks */
> +	if ((data[3] & 0xf0) =3D=3D 0x00 && size >=3D 7 && hidpp->input &&
> +	    hidpp->vertical_wheel_counter.wheel_multiplier) {
> +		s16 delta =3D get_unaligned_be16(&data[5]);
> +
> +		if (delta) {
> +			hidpp_scroll_counter_handle_scroll(hidpp->input,
> +				&hidpp->vertical_wheel_counter, delta);
> +			input_sync(hidpp->input);
> +		}
> +		return 1;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -4405,19 +4433,6 @@ static int hidpp_initialize_battery(struct hidpp_d=
evice *hidpp)
>  	return ret;
>  }
> =20
> -static bool hidpp_is_bolt_child(struct hid_device *hdev)
> -{
> -	struct device *parent =3D hdev->dev.parent;
> -	struct hid_device *receiver_hdev;
> -
> -	if (!parent)
> -		return false;
> -
> -	receiver_hdev =3D to_hid_device(parent);
> -	return receiver_hdev->vendor =3D=3D USB_VENDOR_ID_LOGITECH &&
> -	       receiver_hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_BOLT_RECEIV=
ER;
> -}
> -
>  static int hidpp_bolt_init(struct hidpp_device *hidpp)
>  {
>  	struct hid_device *hdev =3D hidpp->hid_dev;
> @@ -4579,7 +4594,9 @@ static void hidpp_connect_event(struct work_struct =
*work)
>  	}
> =20
>  	hidpp_initialize_battery(hidpp);
> -	if (!hid_is_usb(hidpp->hid_dev))
> +
> +	if (!hid_is_usb(hidpp->hid_dev) ||
> +	    hidpp_is_bolt_child(hidpp->hid_dev))
>  		hidpp_initialize_hires_scroll(hidpp);
> =20
>  	/* forward current battery state */
>=20


=2D-=20
Oleksandr Natalenko, MSE
--nextPartPXfqGdVcShmYsAM8ySghNQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmqnzOUACgkQil/iNcg8
M0tC0A//U/2mokBPpxvJCA+hf/fOR6cFZAfbv3KKX2OEQieJJPRw8AN018f1FiKc
sTT6OfZoQMvVG45FOT8jc/Fgc/VwyjNRM4e8XTj9AWhGWk5f2ReeOeZ0678KsY3X
C887kTJZad09sJUubX5uyJs9VWBLCD0ydaPZZ1doKNpbdj0pzGBGfK1DVsNwPyjV
CEu04Cg3sFX4Mur7qAkytkZd99wj15tJ1T963gOLXPTtSx0i2+ZCH7Z7L6Qj9D6U
bw7d3+VlfXpuiHzNzl1TrXRna28OX14yIby0iX0P/Uu9VRtq3/N5QuPLAWr90sO0
yH7UeeIN1kjTC9vTTCm/lCUSKlY8i6MlcYKxhF/QkgmmHxDOeS4OEe3QQUPIkWfb
1Bc2rkeRwlQWuHwfcVBvcuP2Dqjcc0fouNFyYF9rHpPVojpBKQA1AZ6Gh8pvj1oh
hAhZpmXNb8JlmYl7XEJa4U0CKL+TCJRq6oV9ZgKVaSU5TAn2QPmrqyJbeN2yN3lD
FyN+5JGC2FaFmAhb1k24BI8oPVntS//85B3j49zdbLFb4A848Dg59dFK4yrNXR1j
OuRcMoLd7JKFqAcP3rAPIPEnpVoArDulw7ux6uB6eRdhuOwRPag0fWc+3mIoFwRk
whX1hVSpQidYrWeb5OBtwhIoTgrTIhGLW2SXgcYIoBU5Hd+D264=
=yyuB
-----END PGP SIGNATURE-----

--nextPartPXfqGdVcShmYsAM8ySghNQ--



