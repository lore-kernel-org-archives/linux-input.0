Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EF42316F
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466937; cv=pass; b=RyfWk6AIZHXTTZqs3l9SsODWs2smtty/9tcaoanpvKzwW6ZGrDT6TXpad74as8GFEowyYodmqGe0iytBk0Ckqm0tvM2xR08kfFe/qpRKwY6NplOaZucVRPy2tvlF0NQ3ekwbOnw3Ibd7FJoS0y4SNeQAKQ53eBqohDCHgelwJoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466937; c=relaxed/simple;
	bh=VhOFoWCa+bo3n9vsM+2pH18ZIeSm1ihUnaSEpGW3mzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjKtzr2qIZs1q77rV5LLTg+lUaxnc1lb7shp6AayIsa7HiGNMUpKwNRhcKybhD0VhsShfGzyhBXBVDLm/itX8kvPPL9d6ELgFPHnHotSJC/M44LYQhaKI4FKdTwOR01qbv4fHXcbuJiCHOPlwjiBjZ6jII1o08EsXvxAprTgm2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=cMbvBsd+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="cMbvBsd+"
ARC-Seal: i=1; a=rsa-sha256; t=1772466924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XOvIuxHAlFxT1fNKhJNGsLaw4ro6Gx2IIvvgjUS3Qnqu/x7DfsteeI7L99ex4avwYeiLyCI1dFXqCpBDBRHexYuQFvsIrR6Z7sf6UPejRg9CDx06faRll/lIT+EkhIimrzU5Ano6hu470aNZ2rDiOKAP/Fp4x9pIpf/9OAgnbBU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772466924; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W11c0pZvFESMk06P7EBFNJAb26536pGIrD5l/5fXxrw=; 
	b=T4/XFwMIe+hJ1zrvHbx8VmpfPRa6T6VkRYrV0e3QAYQw/u5ahBVC3iyXC2wC1DOH9/DZli6RHZwTM6EKdFLR36boQZVHXbnt7Z23J2QH7HR6WkKVEgp8K8wlQz/zOEOHkjikjs6bo6x6TngSV2ylITDNPpgpZu1k4YVjbJvLWTo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772466924;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=W11c0pZvFESMk06P7EBFNJAb26536pGIrD5l/5fXxrw=;
	b=cMbvBsd+AhLQc6jAO73EFztoGwhuxOtxIdJxfH4VEN6MmFoK1+L9yuI3ic2EuyXP
	AzmbnWXfkkO/Nzzjy+X+/NRSwEMz+YPxzBx0a7nmgqfn8hPSsmt8GzgKPHh6XgEUHva
	bpSL/WHbLlMPcu66yxkGyvzrk31ymUNcqO0Yz5KM=
Received: by mx.zohomail.com with SMTPS id 1772466921332756.3876849058651;
	Mon, 2 Mar 2026 07:55:21 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 2785D181254; Mon, 02 Mar 2026 16:55:18 +0100 (CET)
Date: Mon, 2 Mar 2026 16:55:18 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	linux-input@vger.kernel.org, ggrundik@gmail.com
Subject: Re: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan
 touchscreens
Message-ID: <aaWvxHt5RPeSRGxJ@venus>
References: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
 <20260228145258.76937-2-johannes.goede@oss.qualcomm.com>
 <aaTZIcPuY3qz5MJm@google.com>
 <06d2504d-2b66-4ae7-94ec-8c062a8c15dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="przif2fn4kkrprr7"
Content-Disposition: inline
In-Reply-To: <06d2504d-2b66-4ae7-94ec-8c062a8c15dc@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/272.455.35
X-ZohoMailClient: External


--przif2fn4kkrprr7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan
 touchscreens
MIME-Version: 1.0

Hi,

On Mon, Mar 02, 2026 at 10:19:59AM +0100, Hans de Goede wrote:
> Hi Dmitry,
>=20
> On 2-Mar-26 1:44 AM, Dmitry Torokhov wrote:
> > Hi Hans,
> >=20
> > On Sat, Feb 28, 2026 at 03:52:58PM +0100, Hans de Goede wrote:
> >> Elan touchscreens have a HID-battery device for the stylus which is al=
ways
> >> there even if there is no stylus.
> >>
> >> This is causing upower to report an empty battery for the stylus and s=
ome
> >> desktop-environments will show a notification about this, which is qui=
te
> >> annoying.
> >>
> >> Because of this the HID-battery is being ignored on all Elan I2c and U=
SB
> >> touchscreens, but this causes there to be no battery reporting for
> >> the stylus at all.
> >>
> >> This adds a new HID_BATTERY_QUIRK_DYNAMIC and uses these for the Elan
> >> touchscreens.
> >>
> >> This new quirks causes the present value of the battery to start at 0,
> >> which will make userspace ignore it and only sets present to 1 after
> >> receiving a battery input report which only happens when the stylus
> >> gets in range.
> >=20
> > My understanding was that "present" attribute is to be used for
> > removable batteries (i.e. when a battery can be extracted from either
> > from the system or from a peripheral) and we want to notify userspace of
> > that fact).
>=20
> In this case we have a touchscreen and a stylus with a battery embedded
> in the stylus and we're setting present to 0 when the stylus (and thus
> the battery) is not there. I realize this is a bit different but it
> is close enough IMHO.
>=20
> Also keep in mind that most people simply do not have the stylus at all,
> these styluses are typically an optional accessory and some models where
> the touchscreen supports this the vendor is not even selling a stylus to
> go with the 2-in-1 laptop (but you may use a compatible stylus from other
> vendors).
>=20
> TL;DR; the user not having a stylus at all is the most common use case he=
re.
>=20
> > For example, if a laptop can have an additional battery UI
> > can show if it is installed or not, and it should not simply ignore such
> > power supplies.
>=20
> As the screenshots of the KDE control-panel in the bug for this:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221118
>=20
> Show it is not being ignored, but its charge-level is ignored,
> with the battery being shown as not present. Which is pretty much
> what we want.
>=20
> > On the other hand the "Unknown" operating status signals that we
> > actually do not know the state of the battery, and fits better in our
> > situation.
>=20
> Reporting "Unknown" in the status attribute is not something which
> drivers normally do. It is there in the ABI and upower seems to somewhat
> handle it, but upower only handles it in that it forwards it to upower
> DBUS API users it does not reset history, etc. as it does for present=3D0.
>=20
> The problem with status=3DUnknown is that its meaning is not really well
> defined. Unknown status mostly means that it is unknown if the battery is
> charging / discharging / full for some reason. But if there still is a low
> capacity reading then userspace might still warn about the low capacity in
> this case, since the battery is still almost empty and presumably not
> charging.
>=20
> Also when the stylus is not there, the battery state is not unknown,
> the entire stylus, including the battery is simply not there, so
> reporting present=3D0 seems more appropriate and its meaning is well
> defined and present=3D0 causes upower to not read/report any of the
> other attributes.
>=20
> And as mentioned most users will not have the stylus I think having
> a non-present "ELAN Touchscreen Stylus battery" being reported makes
> some sense to end users, where as having the same battery being
> reported "Unknown" status and at 0% charge (Unknown status batteries
> do have a charge) is more confusing for users.
>=20
> > Anyway, I think we need Sebastian's input here.
>=20
> Ack, Sebastian your input would be appreciated here ?

The rationale and the patch LGTM. The other option would be to not
register the battery device in the first place and do that once the
first report arrived.

Greetings,

-- Sebastian

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
> >=20
> >>
> >> Reported-by: ggrundik@gmail.com
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221118
> >> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> >> ---
> >>  drivers/hid/hid-input.c | 14 +++++++++++---
> >>  include/linux/hid.h     |  1 +
> >>  2 files changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> >> index 67ca1e88ce13..8fc20df99b97 100644
> >> --- a/drivers/hid/hid-input.c
> >> +++ b/drivers/hid/hid-input.c
> >> @@ -354,6 +354,7 @@ static enum power_supply_property hidinput_battery=
_props[] =3D {
> >>  #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report =
*/
> >>  #define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the ba=
ttery */
> >>  #define HID_BATTERY_QUIRK_AVOID_QUERY	(1 << 3) /* do not query the ba=
ttery */
> >> +#define HID_BATTERY_QUIRK_DYNAMIC	(1 << 4) /* report present only aft=
er life signs */
> >> =20
> >>  static const struct hid_device_id hid_battery_quirks[] =3D {
> >>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> >> @@ -398,8 +399,8 @@ static const struct hid_device_id hid_battery_quir=
ks[] =3D {
> >>  	 * Elan HID touchscreens seem to all report a non present battery,
> >>  	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
> >>  	 */
> >> -	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_=
IGNORE },
> >> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_=
IGNORE },
> >> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_=
DYNAMIC },
> >> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_=
DYNAMIC },
> >>  	{}
> >>  };
> >> =20
> >> @@ -456,11 +457,14 @@ static int hidinput_get_battery_property(struct =
power_supply *psy,
> >>  	int ret =3D 0;
> >> =20
> >>  	switch (prop) {
> >> -	case POWER_SUPPLY_PROP_PRESENT:
> >>  	case POWER_SUPPLY_PROP_ONLINE:
> >>  		val->intval =3D 1;
> >>  		break;
> >> =20
> >> +	case POWER_SUPPLY_PROP_PRESENT:
> >> +		val->intval =3D dev->battery_present;
> >> +		break;
> >> +
> >>  	case POWER_SUPPLY_PROP_CAPACITY:
> >>  		if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
> >>  		    !dev->battery_avoid_query) {
> >> @@ -573,6 +577,8 @@ static int hidinput_setup_battery(struct hid_devic=
e *dev, unsigned report_type,
> >>  	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
> >>  		dev->battery_avoid_query =3D true;
> >> =20
> >> +	dev->battery_present =3D (quirks & HID_BATTERY_QUIRK_DYNAMIC) ? fals=
e : true;
> >> +
> >>  	dev->battery =3D power_supply_register(&dev->dev, psy_desc, &psy_cfg=
);
> >>  	if (IS_ERR(dev->battery)) {
> >>  		error =3D PTR_ERR(dev->battery);
> >> @@ -628,6 +634,7 @@ static void hidinput_update_battery(struct hid_dev=
ice *dev, unsigned int usage,
> >>  		return;
> >> =20
> >>  	if (hidinput_update_battery_charge_status(dev, usage, value)) {
> >> +		dev->battery_present =3D true;
> >>  		power_supply_changed(dev->battery);
> >>  		return;
> >>  	}
> >> @@ -643,6 +650,7 @@ static void hidinput_update_battery(struct hid_dev=
ice *dev, unsigned int usage,
> >>  	if (dev->battery_status !=3D HID_BATTERY_REPORTED ||
> >>  	    capacity !=3D dev->battery_capacity ||
> >>  	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
> >> +		dev->battery_present =3D true;
> >>  		dev->battery_capacity =3D capacity;
> >>  		dev->battery_status =3D HID_BATTERY_REPORTED;
> >>  		dev->battery_ratelimit_time =3D
> >> diff --git a/include/linux/hid.h b/include/linux/hid.h
> >> index dce862cafbbd..d9b54f0e8671 100644
> >> --- a/include/linux/hid.h
> >> +++ b/include/linux/hid.h
> >> @@ -682,6 +682,7 @@ struct hid_device {
> >>  	__s32 battery_charge_status;
> >>  	enum hid_battery_status battery_status;
> >>  	bool battery_avoid_query;
> >> +	bool battery_present;
> >>  	ktime_t battery_ratelimit_time;
> >>  #endif
> >> =20
> >=20
> > Thanks.
> >=20
>=20

--przif2fn4kkrprr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmlstoACgkQ2O7X88g7
+prtfxAAmL21Gq9G3srojlBjC8nnNwQPab5WvxI35HUtyDqXkanaXzJKey5Mnzhr
oiek+PKG+HVNH0542B8oGn5Nww3LWDqfweNVcCIDFvnar+kxzb40jFyog4KgPyxL
5tCSDJgxbeFhJzp4gTXXnd+6lpwn3oAGCERelRJM93qILEiDjB8hmpkf/R9vNVis
+2iYAOZdpSmIVAMEr2ofcscIQsfcOv67OHipCBZy+Vp8vyFjBgO1NOPIkLaN1OnG
O7y8nprccVGRCy9HgKGbepLJw9yWWw3SOJVryoSjoE7V3vMFBCnEBu2N32ITuTFK
61lUmUw56wgDyXiCZZfv5aQ6xrJ9ZhzabJwpe6ESvGWJGqfK4WUCDfLxfhzBJPLe
vx5pC8UB72gWHhzrYfCGIZ70hZuSW37CACpdyYix0ZnyJ2nn/VpjtaiSdWUmiFQ3
PvrDHyYHYKBgGKELmfrYbNuizZcrKqhXGuxLL+7MKtYAXkumQLZCpiogzM/VScbe
9G387VXY9iAMGGRtW35+JZxMIg/WdMxUmbNOd+6MhnhXPWqpqSqAF94DKn+ACrOs
jpQREYMwBaF+ovVeIQEtwshEeaKmxSULmzVzf/LliHCScDxs8xCiX784CSLbfxbH
HCE1LGEc0oA5uB1GkUiDisg/Dnvf1vYkVvD3SCwVHAeq9OqiVtE=
=cZJE
-----END PGP SIGNATURE-----

--przif2fn4kkrprr7--
