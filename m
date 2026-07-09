Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B633F5BD
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568022; cv=none; b=cbkFt8OPF4yYeCnYpRK8Uc2395IoLw6yt94QYxAVKb0Qw12vKAa4kA7KdXVivZbROXs8YG5aOW9P4mAmyLqm5oQ0G9RRZ5Qz8LEcCY6qul4nzmhpnFjjdOR5yK420q75vuXTPloiGD506glrsIPIw6O27CIZvtkMU3wdKZL9M2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568022; c=relaxed/simple;
	bh=nha3HDPEU63w4T4sW4JWpQnCBL9K80VrREfoizXMgLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DbvCjkSK/QReHUp6qfJyahhvvOrPsVpcUpSm37/WCtxmy6J27ftm2cTF77hWCc/C5L6GDZVFl4c0AJZBeakiPx51qeWYwghc5K0+H1TrpzMtAJEtWFr3e9ar87CLDQ+lGVngh5hKBCzVvmDprqy5md5qPo8o/CSp2kA3SXX7tRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW/6fYTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW/6fYTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD891F000E9;
	Thu,  9 Jul 2026 03:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783568021;
	bh=S2S4X/QXZKKHtOib48NiLaN0T/hj4FLq0TGPIdq13gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gW/6fYTlziZnPDfWM7vEBgU3DTY2I33/MxOj2eH8lWwQ0WgrljgoB9tiEsxWVH9A/
	 iFBAUhXtvstF8gljpKAVWWqkqE1o/Gwde0viK73XY7+EtOq20HHOLvoD/QPoJ+yGIT
	 Qk4hr9Ocblf/bKYUePArCRDPicQiFThy8e1kuBFhlIvOvE2luBx+9VLYkyKRhMWs0b
	 e5E05kocRrUScaPV+Y5K9JCUEwCnJGv4q9p+/xkkslAOmeWZCxrUQ+z3UO+5sSdyXz
	 bfJnN9qub8FFOxJaWrL8XOKSUGEj5lvNs7aDWPTL3HTOdE9LaaBjEeeqHeZKOJV8Ov
	 2YVsrwxbkNsZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] HID: steelseries: Refactor Arctis driver to use
 device_info framework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260709032316.1908460-5-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
 <20260709032316.1908460-5-68172138+srimanachanta@users.noreply.github.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:33:40 +0000
Message-Id: <20260709033340.DAD891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Wireless status updates are incorrectly gated by battery registr=
ation success, causing a feature regression.
- [Medium] Relaxing the Arctis 9 battery report size check may cause spurio=
us headset disconnects.

Pre-existing issues:
- [High] A race condition exists during initialization where `sd->battery` =
can temporarily hold an `ERR_PTR`, leading to a potential kernel panic if `=
raw_event` triggers concurrently.
--

--- Patch [4]: [PATCH v6 4/9] HID: steelseries: Refactor Arctis driver to u=
se device_info framework ---
commit 83accfc4c1be2885884d77d1f5dcd98d620ce34b
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Refactor Arctis driver to use device_info framework
   =20
Replace the per-product if/else quirk bitmap with a
steelseries_device_info struct. Each model provides its capabilities,
sync_interface, and request_status/parse_status callbacks. Report
sending is folded into steelseries_send_report() and the feature and
output wrappers, and the battery identifiers lose their per-model names.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index 079504e6932a1..c54c56db9ddd7 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c

[ ... ]

> @@ -88,30 +108,101 @@ static int battery_capacity_to_level(int capacity)
> +static void steelseries_arctis_9_parse_status(struct steelseries_device =
*sd,
> +					      u8 *data, int size)
> +{
> +	if (size < 5)
> +		return;
> +
> +	if (data[0] =3D=3D 0xaa && data[1] =3D=3D 0x01) {
> +		sd->headset_connected =3D true;
> +		sd->battery_charging =3D (data[4] =3D=3D 0x01);
> +		sd->battery_capacity =3D steelseries_map_capacity(data[3], 0x68, 0x9d);
> +	} else {
> +		/* Device off: 0x55 (no status) or 0x03 (stale status). */
> +		sd->headset_connected =3D false;
> +		sd->battery_charging =3D false;
> +	}
> +}

[Severity: Medium]
Could this relaxed size check cause spurious disconnects?

The original code checked for ARCTIS_9_BATTERY_RESPONSE_LEN (64 bytes). By
relaxing the check to 5 bytes, if the headset sends any other non-battery
report between 5 and 63 bytes, it will bypass the filter, fail the signature
check, and fall into the else block.

Would that incorrectly mark the headset as disconnected?

[ ... ]

> @@ -168,7 +244,26 @@ static enum power_supply_property steelseries_headse=
t_battery_props[] =3D {

[ ... ]

> +static int steelseries_battery_register(struct steelseries_device *sd)
>  {
>  	static atomic_t battery_no =3D ATOMIC_INIT(0);
>  	struct power_supply_config battery_cfg =3D { .drv_data =3D sd, };
> @@ -176,25 +271,27 @@ static int steelseries_headset_battery_register(str=
uct steelseries_device *sd)
>  	int ret;

[ ... ]

>  	sd->battery =3D devm_power_supply_register(&sd->hdev->dev,
>  			&sd->battery_desc, &battery_cfg);
>  	if (IS_ERR(sd->battery)) {
>  		ret =3D PTR_ERR(sd->battery);
> +		sd->battery =3D NULL;
>  		hid_err(sd->hdev,
>  				"%s:power_supply_register failed with error %d\n",
>  				__func__, ret);

[Severity: High]
This is a pre-existing issue, but can this cause a kernel panic if a report
arrives concurrently?

Since hid_hw_start() is called earlier during probe, could raw_event()
trigger while sd->battery temporarily holds an ERR_PTR?

If raw_event() fires before sd->battery is set to NULL, it sees a non-NULL
pointer and passes it to power_supply_changed(), which might dereference the
error pointer and crash.

[ ... ]

> @@ -262,130 +365,92 @@ static void steelseries_arctis_remove(struct hid_d=
evice *hdev)

[ ... ]

>  static int steelseries_arctis_raw_event(struct hid_device *hdev,
> -					struct hid_report *report, u8 *read_buf,
> -					int size)
> +				 struct hid_report *report, u8 *data, int size)
>  {

[ ... ]

> -	if (connected !=3D sd->headset_connected) {
> -		hid_dbg(sd->hdev,
> +	if (sd->headset_connected !=3D old_connected) {
> +		hid_dbg(hdev,
>  			"Connected status changed from %sconnected to %sconnected\n",
> -			sd->headset_connected ? "" : "not ",
> -			connected ? "" : "not ");
> -		sd->headset_connected =3D connected;
> -		steelseries_headset_set_wireless_status(hdev, connected);
> +			old_connected ? "" : "not ",
> +			sd->headset_connected ? "" : "not ");
> +
> +		if (sd->battery) {
> +			steelseries_headset_set_wireless_status(sd->hdev,
> +							       sd->headset_connected);
> +			power_supply_changed(sd->battery);
> +		}
>  	}

[Severity: Medium]
Does this check unintentionally gate the wireless status update behind the
battery registration?

If battery registration fails (and sd->battery is NULL), it looks like the
USB device's wireless status will no longer be reported to userspace. Is
this expected behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709032316.1908=
460-1-68172138+srimanachanta@users.noreply.github.com?part=3D4
