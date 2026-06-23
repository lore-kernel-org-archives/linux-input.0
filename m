Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AA38D69B
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236174; cv=none; b=BpFdg6mTTgp33GSfpioQwApBseZ1g/MzbvreuaEyOa52n7m7EaNPSGGSaMYZDe82wUhmXmGBSS+V4OTnwzP9mcopsdYamURvNn1Eg3T6qckws3R2cNOJKkIhGAo8Hpf2qMxsPLqJxfznmzrw2sGFvpI+sYIyY/+ell3iqfSw9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236174; c=relaxed/simple;
	bh=YYVs3XolGnrm+Axw5i9LEblv4jkimqI114oEREzRoLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I+an4qQU+zZjhDva9XZZHHzEXW1SN5X6w2StYQ/T7zTYIKAoBjd8h69+60geIZ3fLzPvJReb2JOmMOJGLb8XMS0q6iaz73ExHtFPIX2P7ZrNtC7XFVT5WOSU0qKku7QGqEIo0WxlXNxkgL1Mjtiquup8T6Oq2E2HHsRrk/25wwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTy2uz5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTy2uz5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D131F000E9;
	Tue, 23 Jun 2026 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236173;
	bh=rQVLZYVO1L0meF9OL4eM/nbCQqQ2Uryn/1B3/gpRFz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MTy2uz5wnoEa1vk+gSBPulhbum0ZA9y6rOKVkSJYF7ShqSZx7NoH46QkvD6JVN6zX
	 vRRArj1vvxp6Cu4bA1mUz9a+xejH/e/YffmR9bNcj0YC6LrmHfsNROD5GhOALKvItJ
	 wKT1CM3bgtPI3FuVNLmVT6NJ2dXK4rw6vd7P6FMST5tFY1ZhMSg0cXIV1bBS7m5Lu7
	 L4o5W0Alrwn1TFujyHAonIG9U1uxq0thKSds7onUroKV5Kzdie7MNitTAlbaKoWLwo
	 CAxYzzgPr1E5VixwO6N7oBgKAZ/zkRL9P9Uz7pjl9O+0vFhir7ilk0C8FdbNqfjJ9f
	 9ihg6J4+fohBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] HID: steelseries: Add async status interface
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260623172310.272708-10-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
 <20260623172310.272708-10-srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:36:12 +0000
Message-Id: <20260623173612.D0D131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] The driver blindly casts the sibling interface's driver data t=
o a `struct hid_device` without verifying the bound driver, leading to type=
 confusion and memory corruption.
- [Critical] The sync interface publishes `sd` to `drvdata` before initiali=
zation is complete, allowing the async interface to crash the kernel by sch=
eduling an uninitialized work struct.
- [High] Lockless retrieval and access of the sibling interface's driver da=
ta leads to a Use-After-Free if the sync interface is unbound concurrently.
- [High] If the sync interface probe fails after the async interface binds =
to it, the async interface will access a freed `sd->hdev` pointer.

Pre-existing issues:
- [High] An ERR_PTR temporarily assigned to `sd->battery` during initializa=
tion failure can be concurrently dereferenced by the raw event handler.
--

commit 002dd61306f7255151ab901886b17a9e612226ad
Author: Sriman Achanta <srimanachanta@gmail.com>
Subject: HID: steelseries: Add async status interface support

This commit adds support for a second HID interface that sends battery
and connection updates asynchronously. This allows the driver to stop
polling the sync interface by watching the async interface instead.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index 734cf1eb87894..2208d0e4cd2ad 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -316,6 +318,23 @@ static int steelseries_battery_register(struct steel=
series_device *sd)
>  	return 0;
>  }
> =20
> +static struct hid_device *steelseries_get_sibling_hdev(struct hid_device=
 *hdev,
> +						       int interface_num)
> +{
> +	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> +	struct usb_device *usb_dev =3D interface_to_usbdev(intf);
> +	struct usb_interface *sibling_intf;
> +	struct hid_device *sibling_hdev;
> +
> +	sibling_intf =3D usb_ifnum_to_if(usb_dev, interface_num);
> +	if (!sibling_intf)
> +		return NULL;
> +
> +	sibling_hdev =3D usb_get_intfdata(sibling_intf);

[Severity: High]
Does this code safely retrieve the sibling interface's driver data? Because
no reference is taken on the USB interface and usb_driver_claim_interface()
is not used, could a concurrent sysfs unbind destroy the interface and the
retrieved data while we are accessing it?

[Severity: Critical]
Is it safe to assume usb_get_intfdata() returns a struct hid_device pointer
here? If the sync interface is bound to a different driver (such as
snd-usb-audio), its driver data would be a completely different structure.
Could this lead to type confusion and memory corruption when the pointer is
dereferenced later in the probe function?

> +
> +	return sibling_hdev;
> +}
> +
>  static int steelseries_arctis_probe(struct hid_device *hdev,
>  				    const struct hid_device_id *id)
>  {
> @@ -337,39 +356,76 @@ static int steelseries_arctis_probe(struct hid_devi=
ce *hdev,
>  	if (ret)
>  		return ret;
> =20
> -	/* Let hid-generic handle non-sync interfaces */
> -	if (interface_num !=3D info->sync_interface)
> +	/* Let hid-generic handle non-vendor or unknown interfaces */
> +	if (interface_num !=3D info->sync_interface &&
> +	    (!info->async_interface || interface_num !=3D info->async_interface=
))
>  		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> =20
> -	sd =3D kzalloc_obj(*sd, GFP_KERNEL);
> -	if (!sd)
> -		return -ENOMEM;
> +	if (interface_num =3D=3D info->sync_interface) {
> +		sd =3D kzalloc_obj(*sd, GFP_KERNEL);
> +		if (!sd)
> +			return -ENOMEM;
> =20
> -	kref_init(&sd->refcnt);
> -	sd->hdev =3D hdev;
> -	sd->info =3D info;
> -	spin_lock_init(&sd->lock);
> +		kref_init(&sd->refcnt);
> +		sd->hdev =3D hdev;
> +		sd->info =3D info;
> +		spin_lock_init(&sd->lock);
> =20
> -	hid_set_drvdata(hdev, sd);
> +		hid_set_drvdata(hdev, sd);

[Severity: Critical]
By calling hid_set_drvdata() here, sd is globally published before
INIT_DELAYED_WORK() is called below. If the async interface probes concurre=
ntly
and immediately receives an event, could it call schedule_delayed_work() on
an uninitialized work struct?

> =20
> -	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> -	if (ret)
> -		goto err_put;
> +		ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +		if (ret)
> +			goto err_put;
> =20
> -	ret =3D hid_hw_open(hdev);
> -	if (ret)
> -		goto err_stop;
> +		ret =3D hid_hw_open(hdev);
> +		if (ret)
> +			goto err_stop;

[Severity: High]
If the sync interface probe fails after this point (for example, if hid_hw_=
open()
or steelseries_battery_register() fails) and returns an error, but the async
interface has already bound and incremented sd->refcnt:

Since steelseries_arctis_remove() is never called for the failed sync probe,
sd->removed remains false. If the driver core clears the sync interface's d=
river
data and the sibling interface is unbound, sd->hdev is freed.

Could the still-active async interface then process raw events, bypass the
sd->removed check, and access the freed sd->hdev pointer via
steelseries_headset_set_wireless_status()?

> +
> +		if (info->capabilities & SS_CAP_BATTERY) {
> +			ret =3D steelseries_battery_register(sd);
> +			if (ret < 0)
> +				hid_warn(hdev, "Failed to register battery: %d\n", ret);
> +		}
> =20
> -	if (info->capabilities & SS_CAP_BATTERY) {
> -		ret =3D steelseries_battery_register(sd);
> -		if (ret < 0)
> -			hid_warn(hdev, "Failed to register battery: %d\n", ret);
> +		INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_hand=
ler);
> +		schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
> +
> +		return 0;
>  	}
[ ... ]
> @@ -442,6 +509,10 @@ static int steelseries_arctis_raw_event(struct hid_d=
evice *hdev,
>  			old_connected ? "" : "not ",
>  			sd->headset_connected ? "" : "not ");
> =20
> +		if (sd->headset_connected && !old_connected &&
> +		    sd->info->async_interface && is_async_interface)
> +			schedule_delayed_work(&sd->status_work, 0);
> +
>  		if (sd->battery) {
>  			steelseries_headset_set_wireless_status(sd->hdev,
>  							       sd->headset_connected);
>  			power_supply_changed(sd->battery);

[Severity: High]
This is a pre-existing issue, but is there a data race with sd->battery her=
e?

During initialization in steelseries_battery_register():

	sd->battery =3D power_supply_register(&sd->hdev->dev,
			&sd->battery_desc, &battery_cfg);
	if (IS_ERR(sd->battery)) {
		ret =3D PTR_ERR(sd->battery);
		sd->battery =3D NULL;

Since hardware has already been enabled via hid_hw_start(), interrupts can
arrive concurrently. If an event arrives during the window where sd->battery
holds an ERR_PTR, if (sd->battery) will evaluate to true.

Could this cause power_supply_changed(sd->battery) to dereference the error
pointer?

>  		}
> =20
> @@ -465,6 +536,8 @@ static int steelseries_arctis_raw_event(struct hid_de=
vice *hdev,
>  			power_supply_changed(sd->battery);
>  	}
> =20
> +	spin_unlock_irqrestore(&sd->lock, flags);
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623172310.2727=
08-1-srimanachanta@gmail.com?part=3D9
