Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C438C2BF
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236006; cv=none; b=ggNoCZvJppyQcGhJxPeoT1/eD4da0ib3J828Z1dF6pfO7MULBQo2BLY1DBgCfwWFk7lj/BUrJr+d4iTbWBLY0y74Zk09n6InBcDasLhzNHAqUKr2sVBV94aYYpa7RV4528x8+d08+Hg4h/ewoGBdTE9G3RReqy1ChcbAjFNM5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236006; c=relaxed/simple;
	bh=5kezThzhhkadHTgyvjx1zkRCAFz46yyycqJQ3/DvuBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UBD3q5TVPPHCSAM6p0I/dud+oFmdFqB7VBhdCrUJ05fs5V+xCjRtqaURM00I5CYlzDX8UkFoEqK6D4leUU2cOTfKCSxFqCNsBYaBnp98nTYJzV/GHb5bT+MCfirwGx+/xh1Tj4J6oIn/EIhJsqr+IMf0tkzbhKQgxMjY1KWMlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyUN4nbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyUN4nbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C3C1F00A3A;
	Tue, 23 Jun 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236005;
	bh=Xv2zK3VRjrxXyqyVY8GWYhy6xFRK8DIEVHyuej0L5V4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EyUN4nbnvK14d6RYD8kHlA9pA7JXMd+lVAZ0KIrB+u5W63arGLm5k3xh8AkXXeuNc
	 m0AsRT+lpkxtpo09EIE3YTvNHRrw3RKYNaI6NkcTTgreynv1ll4aU4lpp2yFzkyizm
	 4grUpt97DMv1kIdouVdaMzHmUP2waa31JKxAz5RvZepqp1Mf4lkoarIaGyOP2xMhJx
	 9aAMAxPsdT3NNxL+WCSPImGYpxXsKuKvVHU+k4hFrkeHgY10qNvyiK2A2RDAOLyZgv
	 zVyswvmXRYVv4v129u8EMUWfyVsNomc5B2qkTLM4diC84h8Y4+31zQA6fDnPghG1ar
	 WXD1UbrIyULJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] HID: steelseries: Refactor Arctis driver to
 use device_info framework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260623172310.272708-6-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
 <20260623172310.272708-6-srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:33:24 +0000
Message-Id: <20260623173325.47C3C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing report ID signature validation for Arctis 1 causes arbitra=
ry raw events to corrupt headset state.
- [High] Battery status requests are incorrectly sent as Feature reports in=
stead of Output reports, breaking battery polling.
- [Medium] Dropped logic for marking Arctis 9 headset as disconnected when =
it reports an unknown status.

Pre-existing issues:
- [High] The raw_event interrupt handler can dereference an ERR_PTR due to =
a TOCTOU race window when battery registration fails.
--

commit 0576cf59ec529dc31ed68f59a8d598bdb4ca4a82
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Refactor Arctis driver to use device_info framework

Replace the per-product if/else quirk bitmap with a steelseries_device_info
struct. Each model provides its capabilities, sync_interface, and
request_status/parse_status callbacks.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index 079504e6932a1..f00f4c5e6d9e4 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -15,70 +16,95 @@
[ ... ]
> +static int steelseries_arctis_1_request_status(struct hid_device *hdev)
> +{
> +	const u8 data[] =3D { 0x06, 0x12 };
> +
> +	return steelseries_send_feature_report(hdev, data, sizeof(data));
> +}
> +
> +static int steelseries_arctis_9_request_status(struct hid_device *hdev)
> +{
> +	const u8 data[] =3D { 0x00, 0x20 };
> +
> +	return steelseries_send_feature_report(hdev, data, sizeof(data));
> +}

[Severity: High]
Do these devices expect feature reports instead of output reports for status
requests?

The original code sent the periodic battery status request to the device
using an output report via hid_hw_raw_request(..., HID_OUTPUT_REPORT, ...).
This refactoring switches it to use steelseries_send_feature_report()
instead.

Sending a feature report to a device endpoint expecting an output report
might result in a USB stall, which would break battery polling.

[ ... ]
> @@ -88,30 +114,96 @@ static int battery_capacity_to_level(int capacity)
[ ... ]
> +static void steelseries_arctis_1_parse_status(struct steelseries_device =
*sd,
> +					      u8 *data, int size)
> +{
> +	if (size < 4)
> +		return;
> +
> +	sd->headset_connected =3D (data[2] !=3D 0x01);
> +	sd->battery_capacity =3D data[3];
> +}

[Severity: High]
Will this corrupt the battery state if other reports are received?

The original raw event handler verified that the incoming Arctis 1 report
matched the expected battery status signature using memcmp().

Since steelseries_arctis_raw_event() now invokes parse_status()
unconditionally for all incoming raw events, could a different report
(such as volume control) with a payload of at least 4 bytes be erroneously
parsed as battery data?

> +static void steelseries_arctis_9_parse_status(struct steelseries_device =
*sd,
> +					      u8 *data, int size)
> +{
> +	if (size < 5)
> +		return;
> +
> +	if (data[0] =3D=3D 0xaa) {
> +		sd->headset_connected =3D (data[1] =3D=3D 0x01);
> +		sd->battery_charging =3D (data[4] =3D=3D 0x01);
> +		sd->battery_capacity =3D steelseries_map_capacity(data[3], 0x68, 0x9d);
> +	}
> +}

[Severity: Medium]
What happens if the device is turned off and sends the "no known status"
packet?

The original code explicitly handled the 0x55 response and used it to mark
the headset as disconnected.

By only processing 0xaa and dropping other responses without taking any
action, will we fail to update the connection state and leave the device
incorrectly reported as connected?

[ ... ]
> @@ -168,7 +245,26 @@ static enum power_supply_property steelseries_headse=
t_battery_props[] =3D {
[ ... ]
> +static int steelseries_battery_register(struct steelseries_device *sd)
>  {
[ ... ]
>  	sd->battery =3D devm_power_supply_register(&sd->hdev->dev,
>  			&sd->battery_desc, &battery_cfg);
>  	if (IS_ERR(sd->battery)) {
>  		ret =3D PTR_ERR(sd->battery);
> +		sd->battery =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does assigning the return
value directly to sd->battery before checking for an error create a race
condition?

Since hid_hw_start() and hid_hw_open() are already called in the probe
function, hardware interrupts are active. If power_supply_register() fails,
sd->battery temporarily holds an error pointer.

If steelseries_arctis_raw_event() triggers during this small window, the
following check would evaluate to true because an error pointer is not NULL:

steelseries_arctis_raw_event() {
    ...
    if (sd->battery)
        power_supply_changed(sd->battery);
}

Could this lead to an invalid pointer dereference and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623172310.2727=
08-1-srimanachanta@gmail.com?part=3D5
