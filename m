Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5103EB80B
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179748; cv=pass; b=W44HxDhoCTcv3YIq/nMN9Cy86KYlLIrrZhQuC7+O3ykpE2aCY3FCky1L3bg+4pnkpIS/uxT/NtHQXZOCghLTF+bVj5Ie8m4q23win2j62LIlJ9xwajDBuVlTHV+w7hv7bmDfGTyvvOewm1YF8uG9cN4rEgZPHmWiNOo4Re8t0nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179748; c=relaxed/simple;
	bh=Sa6IpiNNPv7Kz55AgLuf19ff0Ik/ltgBW5w0QWnAkhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHx4kojtFtwWrPHGYKBGAR0FROy9RDdH01pvWNvsfmlcgVFD2er+ky8m/hfHBJfZfb6c+YNgjkA6DOw7TuLiBGJffI2WxxUii4/1Sh1uBakmrIeMGp5MlXKO3gAaHulJrzM+n7FrYgtLh+XAQcxClZTJeTtuvRO7Q7iQewzbguI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=QLjNbwbc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="QLjNbwbc"
ARC-Seal: i=1; a=rsa-sha256; t=1773179736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EtAVW4ZHNJ1TIXEABAY2zBe3mFPMYdmBZ2CtZP/RXb7ZBJm5iW2LGDlBMUlsYBrudKIIOdpLmZULvxHmNbGRbdOKqC9YVLU81uTHJCKbNMTqBkQdw/nnPOo/y+4XDfG8XnP514VYxlguvgC+VPT0d8Ub1xiAgIB7tnthjtqj0Xk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773179736; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vtpg5w5/0QHH4LHl0Iu5VQBCbawJKdPIyXF7fnU4m7Q=; 
	b=nIk91CsoAF9mX9mCO8eCDLkpQMMjv7MTN677MbHkChq9ull/oZhBZ0VU3LWAxTIbHrx6sEiQyw/8JPrj8ICXYfK4rxLmHS0vv4UbotX5JRXZtw7YoGLyMiXFdceZ7Mfp1jqr3tn8ZogOQGHzs7hP9PaM8kGzoeR62tt5F2keyE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773179736;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Vtpg5w5/0QHH4LHl0Iu5VQBCbawJKdPIyXF7fnU4m7Q=;
	b=QLjNbwbcYTnlztxfXQll6/tXqZ8XQHXuf507i8kZhexsYsdkMmzD3lbaZsHqdCLO
	d48T9uDPBuVz0ZGscYPkbHor5Kd5WqjVTC0QK8811Z5awbvQ1JOnNL723GW6NE62LL2
	Cigsgnj5BGoXyG+RgGi51KvggGLwUv8exgJje/RU=
Received: by mx.zohomail.com with SMTPS id 1773179733579622.5465863995054;
	Tue, 10 Mar 2026 14:55:33 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A1AC1180AD6; Tue, 10 Mar 2026 22:55:30 +0100 (CET)
Date: Tue, 10 Mar 2026 22:55:30 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, ggrundik@gmail.com
Subject: Re: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan
 touchscreens
Message-ID: <abCTABMSsjVMVCDE@venus>
References: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
 <20260228145258.76937-2-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5jayuehnwentpoxv"
Content-Disposition: inline
In-Reply-To: <20260228145258.76937-2-johannes.goede@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.171.75
X-ZohoMailClient: External


--5jayuehnwentpoxv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan
 touchscreens
MIME-Version: 1.0

Hi,

On Sat, Feb 28, 2026 at 03:52:58PM +0100, Hans de Goede wrote:
> Elan touchscreens have a HID-battery device for the stylus which is always
> there even if there is no stylus.
>=20
> This is causing upower to report an empty battery for the stylus and some
> desktop-environments will show a notification about this, which is quite
> annoying.
>=20
> Because of this the HID-battery is being ignored on all Elan I2c and USB
> touchscreens, but this causes there to be no battery reporting for
> the stylus at all.
>=20
> This adds a new HID_BATTERY_QUIRK_DYNAMIC and uses these for the Elan
> touchscreens.
>=20
> This new quirks causes the present value of the battery to start at 0,
> which will make userspace ignore it and only sets present to 1 after
> receiving a battery input report which only happens when the stylus
> gets in range.
>=20
> Reported-by: ggrundik@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221118
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/hid/hid-input.c | 14 +++++++++++---
>  include/linux/hid.h     |  1 +
>  2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 67ca1e88ce13..8fc20df99b97 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -354,6 +354,7 @@ static enum power_supply_property hidinput_battery_pr=
ops[] =3D {
>  #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
>  #define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the batte=
ry */
>  #define HID_BATTERY_QUIRK_AVOID_QUERY	(1 << 3) /* do not query the batte=
ry */
> +#define HID_BATTERY_QUIRK_DYNAMIC	(1 << 4) /* report present only after =
life signs */
> =20
>  static const struct hid_device_id hid_battery_quirks[] =3D {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> @@ -398,8 +399,8 @@ static const struct hid_device_id hid_battery_quirks[=
] =3D {
>  	 * Elan HID touchscreens seem to all report a non present battery,
>  	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
>  	 */
> -	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGN=
ORE },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGN=
ORE },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYN=
AMIC },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYN=
AMIC },
>  	{}
>  };
> =20
> @@ -456,11 +457,14 @@ static int hidinput_get_battery_property(struct pow=
er_supply *psy,
>  	int ret =3D 0;
> =20
>  	switch (prop) {
> -	case POWER_SUPPLY_PROP_PRESENT:
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		val->intval =3D 1;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D dev->battery_present;
> +		break;
> +
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
>  		    !dev->battery_avoid_query) {
> @@ -573,6 +577,8 @@ static int hidinput_setup_battery(struct hid_device *=
dev, unsigned report_type,
>  	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
>  		dev->battery_avoid_query =3D true;
> =20
> +	dev->battery_present =3D (quirks & HID_BATTERY_QUIRK_DYNAMIC) ? false :=
 true;
> +
>  	dev->battery =3D power_supply_register(&dev->dev, psy_desc, &psy_cfg);
>  	if (IS_ERR(dev->battery)) {
>  		error =3D PTR_ERR(dev->battery);
> @@ -628,6 +634,7 @@ static void hidinput_update_battery(struct hid_device=
 *dev, unsigned int usage,
>  		return;
> =20
>  	if (hidinput_update_battery_charge_status(dev, usage, value)) {
> +		dev->battery_present =3D true;
>  		power_supply_changed(dev->battery);
>  		return;
>  	}
> @@ -643,6 +650,7 @@ static void hidinput_update_battery(struct hid_device=
 *dev, unsigned int usage,
>  	if (dev->battery_status !=3D HID_BATTERY_REPORTED ||
>  	    capacity !=3D dev->battery_capacity ||
>  	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
> +		dev->battery_present =3D true;
>  		dev->battery_capacity =3D capacity;
>  		dev->battery_status =3D HID_BATTERY_REPORTED;
>  		dev->battery_ratelimit_time =3D
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index dce862cafbbd..d9b54f0e8671 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -682,6 +682,7 @@ struct hid_device {
>  	__s32 battery_charge_status;
>  	enum hid_battery_status battery_status;
>  	bool battery_avoid_query;
> +	bool battery_present;
>  	ktime_t battery_ratelimit_time;
>  #endif
> =20
> --=20
> 2.52.0

--5jayuehnwentpoxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmwk08ACgkQ2O7X88g7
+pqcBQ/8DazdYALgisLIY61ngQmK+wFh6vklbwzfRKP5XnYP3fqAOIG0/NjJrAsI
fPUQLmKMjlKt8Q+pGRjUPyblVfnQZXlnkCofYXfNs7c6pyNTC71Zzlw91HBWFPPw
qU79V4yS01L6ozUHpnfTJcUs69gmdH/+LnlSQZ840az7/+0oXXCm/54TNvZzEox5
2tsdYyQ9KAHIaJbT13VKGl7IMTp4LTaiZPjiShTOvOC/nazUsjxbGIGs97WK+no9
9Y9p+WSlklDIy9D0H/eAxfNl8ppqg2PEavM7MFOZhn8xaZil9k7NRM986Fm7Xu0/
CcCJqE/b0OMQ+4iM3jGIF3bvnD2R17WZEci1zu5SHqPemd6hykjBtkSuht7CO0tB
fjEanTLePt2QE/rUUtW7+bZhH1aWxfhixJ8OQJ9m0H/fzrS+DkwZ+auc13IaDzhu
x/RDrg/YF6I7vA4YCWOAl4L/qRbDhGKwiUlgYC8pjeerhF4QZbGnseJilHIq8K0A
qZJ0cjS60Qo/BCvis9Q1y1nlgBGgV26hq8CiVwhO3JLUbk11SgBzpI749FK9l2ze
qL8EUJC00zOq00r7bc7O9qvPAjrTDWLNj7AtR2+I//X9YYfI0RnzNA9H01MVAbP0
QsuPakT1402XdEq8VjBZrQ+KT94C5E4RdUd87IwMKI4YB0lKk/A=
=CPVr
-----END PGP SIGNATURE-----

--5jayuehnwentpoxv--
