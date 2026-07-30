Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48023A8FE6;
	Thu, 30 Jul 2026 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400621; cv=none; b=F4YsYsuXDl4JBfZ34HUgUBFHZTJU5UClg+OXdx0MkIxNN0hYpDEXXqn8iKEpbqeO51YBUWnDXjXHtY3w2noIZF0WaMOMGAiMC+tbZfZyBhS/JtFlruNrZs9bPNqlZMPgC8P8l9vuBYqXgE7+EcHcpd3UqTL2CG32CmebZjFpqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400621; c=relaxed/simple;
	bh=nEUT4AIo5vnW5vPNoYnNo6BQNAVHz1KF9aFia4mcmNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9bI+2h3ngc2pcHjDMtTFoB5YccVFdvJMDkiD65cpfo+jXiki+JNoUCh/kd/EQAa9GbMkY6p6sst8FKXPf02icQ3Xppv2Q+8OKnaKCBxGr1uwpCmrrhm4g8PyRfcfpGjF0W5cnaZsyGbI4XwGOyxGubyNkEPX1IM/bwitj28AWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C16E3EBD8;
	Thu, 30 Jul 2026 08:36:51 +0000 (UTC)
Message-ID: <87314b89c73bd06c9824da73811a53b3f88a5059.camel@hadess.net>
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
From: Bastien Nocera <hadess@hadess.net>
To: Erik =?ISO-8859-1?Q?H=E5kansson?= <erikhakan@gmail.com>,
 jikos@kernel.org, 	bentiss@kernel.org
Cc: lains@riseup.net, k8ie@mcld.eu, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 30 Jul 2026 10:36:50 +0200
In-Reply-To: <20260713201201.391538-2-erikhakan@gmail.com>
References: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
	 <20260713201201.391538-1-erikhakan@gmail.com>
	 <20260713201201.391538-2-erikhakan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGS7slih2BkvsukFVZfMT7TgXtlWGELd0v+Lr/r5w1W0kRfTwQdpJ13VfClOxejBlEdOYQr2Xsf9+8uLV4HWTqMVOmxdydycyo069ZGq9IbR1P2hWw5TUKofA8y8WET+TVDOnoLhV2GbPv4C7wkGKINA1/3tV6hFPpaitfTnBbbi1nHf6LBLQZ2TumVMdjFZ0G44hRTeqUUUVXmmFlIsbRGH0nuxG9p47HUdoII6I09ERBGXPFJfvYcok5O1hnBe8y+RsTKn0TBL9wzh71FYInoz7fSbRK2kgx01+ZqpBhRoxnWDZyvlm4CC2EgLujtfteW0X/FydJMrjaAkY+PLW81eFzaFI+fiwFf7HJk2Uy7auUBOPbwhMbVk7Poa4bdlagKs3A9aeTC45Alp+oR6xsY0Tqqx3EwOjxpiUAqvwP7UTENG769+dy1gY8jkRBtmaC5aV9RriIux9ssOJmgXX9xF8TWCQw13KDSEkA0GoUr/V8dQymsaS9xjeF1JLZqewYC4ovfOxP7H1cLaTsQXiEzEZqmy/rp0Ks8FLPKtAa/bcrECx0IficaQYHuNOgWnE8sGkummuO816D7g4Bz2Sbd+OwyibsR585y2ntcS9Uv7IiWk2g4Jk6MeDYAQML5YjyeTaTM+I8vFBDk25uYaUhxh5YSaii8BGPRhNtfyzdiTA

Hey Eric,

On Mon, 2026-07-13 at 22:12 +0200, Erik H=C3=A5kansson wrote:
> Add Logitech Bolt receiver support to the Logitech HID receiver and
> HID++ drivers.
>=20
> Handle Bolt receiver notifications in hid-logitech-dj and add a
> Bolt-specific initialization path in hid-logitech-hidpp, separate from
> the existing Unifying receiver path.
>=20
> This allows Bolt-connected HID++ devices to expose battery information
> through the kernel power_supply path, so userspace tools can report
> their battery status with the correct device model.
>=20
> Tested with:
> - Logitech MX Keys for Business via Bolt receiver

I tested this with a Bolt receiver connected to the same M650 mouse I
used in another test earlier, and my Slim Solar+ keyboard.

Every time the mouse is turned off, I get:
kernel: logitech-hidpp-device 0003:046D:B02A.0009: hidpp_root_get_protocol_=
version: received protocol error 0x04
which probably shouldn't happen.

I also see the battery not going away, but that looks to be a separate
problem.

The only thing I haven't tested, and which might need fixing before we
can merge this is figuring out how quirks can be applied.

The battery reporting works because it probes the available interfaces,
and reports that.

But what about things like:
        { /* Signature M650 over Bluetooth */
          HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
                               HIDPP_PRODUCT_SIGNATURE_M650),
          .driver_data =3D HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
which were added in:
https://patchwork.kernel.org/project/linux-input/list/?series=3D1121633

The recent "HID: logitech-hidpp: Add support for HID++ Multi-Platform
feature (0x4531)" doesn't work either:
https://patchwork.kernel.org/project/linux-input/list/?series=3D1119501

Cheers

>=20
> Reported-by: Kate=C5=99ina Medv=C4=9Bdov=C3=A1 <k8ie@mcld.eu>
> Link: https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a=
52a8d@mcld.eu/
> Signed-off-by: Erik H=C3=A5kansson <erikhakan@gmail.com>
> ---
> Changes in v2:
> - Handle only the Bolt receiver/control interface in hid-logitech-dj and
> =C2=A0 leave the other Bolt receiver interfaces to generic HID handling.
> - Handle Bolt HID++ unpair notifications so child HID devices are removed
> =C2=A0 after unpairing.
>=20
> =C2=A0drivers/hid/hid-logitech-dj.c=C2=A0=C2=A0=C2=A0 | 48 ++++++++++++++=
+++++++++++++++---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 48 +++++++++++++++++++++++++++++=
+--
> =C2=A02 files changed, 89 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.=
c
> index 9c574ab8b60b..571d5caa5bb5 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -121,6 +121,7 @@ enum recvr_type {
> =C2=A0	recvr_type_27mhz,
> =C2=A0	recvr_type_bluetooth,
> =C2=A0	recvr_type_dinovo,
> +	recvr_type_bolt,
> =C2=A0};
> =C2=A0
> =C2=A0struct dj_report {
> @@ -1156,6 +1157,10 @@ static void logi_hidpp_recv_queue_notif(struct hid=
_device *hdev,
> =C2=A0		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
> =C2=A0		workitem.reports_supported |=3D STD_KEYBOARD;
> =C2=A0		break;
> +	case 0x10:
> +		device_type =3D "Bolt";
> +		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
> +		break;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* custom receiver device (eg. powerplay) */
> @@ -1745,6 +1750,24 @@ static int logi_dj_hidpp_event(struct hid_device *=
hdev,
> =C2=A0
> =C2=A0	dj_dev =3D djrcv_dev->paired_dj_devices[device_index];
> =C2=A0
> +	/*
> +	 * Bolt receivers send explicit unpair notifications as HID++ events;
> +	 * queue device removal when we receive one.
> +	 */
> +	if (djrcv_dev->type =3D=3D recvr_type_bolt &&
> +	=C2=A0=C2=A0=C2=A0 hidpp_report->report_id =3D=3D REPORT_ID_HIDPP_SHORT=
 &&
> +	=C2=A0=C2=A0=C2=A0 hidpp_report->sub_id =3D=3D REPORT_TYPE_NOTIF_DEVICE=
_UNPAIRED) {
> +		struct dj_workitem workitem =3D {
> +			.device_index =3D device_index,
> +			.type =3D WORKITEM_TYPE_UNPAIRED,
> +		};
> +
> +		kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
> +		schedule_work(&djrcv_dev->work);
> +		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
> +		return false;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * With 27 MHz receivers, we do not get an explicit unpair event,
> =C2=A0	 * remove the old device if the user has paired a *different* devi=
ce.
> @@ -1884,6 +1907,9 @@ static int logi_dj_probe(struct hid_device *hdev,
> =C2=A0	 * treat these as logitech-dj interfaces then this causes input ev=
ents
> =C2=A0	 * reported through this extra interface to not be reported correc=
tly.
> =C2=A0	 * To avoid this, we treat these as generic-hid devices.
> +	 *
> +	 * Bolt receivers only use LOGITECH_DJ_INTERFACE_NUMBER for receiver
> +	 * reporting. Treat all other Bolt interfaces as generic-hid devices.
> =C2=A0	 */
> =C2=A0	switch (id->driver_data) {
> =C2=A0	case recvr_type_dj:		no_dj_interfaces =3D 3; break;
> @@ -1897,10 +1923,20 @@ static int logi_dj_probe(struct hid_device *hdev,
> =C2=A0	}
> =C2=A0	if (hid_is_usb(hdev)) {
> =C2=A0		intf =3D to_usb_interface(hdev->dev.parent);
> -		if (intf && intf->altsetting->desc.bInterfaceNumber >=3D
> -							no_dj_interfaces) {
> -			hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
> -			return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +		if (intf) {
> +			bool generic_hid_interface;
> +
> +			if (id->driver_data =3D=3D recvr_type_bolt)
> +				generic_hid_interface =3D
> +					intf->altsetting->desc.bInterfaceNumber !=3D
> +					LOGITECH_DJ_INTERFACE_NUMBER;
> +			else
> +				generic_hid_interface =3D
> +					intf->altsetting->desc.bInterfaceNumber >=3D no_dj_interfaces;
> +			if (generic_hid_interface) {
> +				hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
> +				return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +			}
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -2103,6 +2139,10 @@ static const struct hid_device_id logi_dj_receiver=
s[] =3D {
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> =C2=A0		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3),
> =C2=A0	 .driver_data =3D recvr_type_gaming_hidpp_ls_1_3},
> +	{ /* Logitech Bolt receiver (0xc548) */
> +	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +			 USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
> +	 .driver_data =3D recvr_type_bolt},
> =C2=A0	{ /* Logitech lightspeed receiver (0xc54d) */
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> =C2=A0		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 90b0184df777..0b5d0a322ae8 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4161,8 +4161,50 @@ static int hidpp_initialize_battery(struct hidpp_d=
evice *hidpp)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
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
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 receiver_hdev->product =3D=3D USB_=
DEVICE_ID_LOGITECH_BOLT_RECEIVER;
> +}
> +
> +static int hidpp_bolt_init(struct hidpp_device *hidpp)
> +{
> +	struct hid_device *hdev =3D hidpp->hid_dev;
> +	char *name;
> +	int ret;
> +
> +	ret =3D hidpp_serial_init(hidpp);
> +	if (ret)
> +		return ret;
> +
> +	name =3D hidpp_get_device_name(hidpp);
> +	if (!name)
> +		return -EIO;
> +
> +	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
> +	dbg_hid("HID++ Bolt: Got name: %s\n", name);
> +
> +	kfree(name);
> +	return 0;
> +}
> +
> +static int hidpp_receiver_init(struct hidpp_device *hidpp)
> +{
> +	if (hidpp_is_bolt_child(hidpp->hid_dev))
> +		return hidpp_bolt_init(hidpp);
> +
> +	return hidpp_unifying_init(hidpp);
> +}
> +
> =C2=A0/* Get name + serial for USB and Bluetooth HID++ devices */
> -static void hidpp_non_unifying_init(struct hidpp_device *hidpp)
> +static void hidpp_non_receiver_init(struct hidpp_device *hidpp)
> =C2=A0{
> =C2=A0	struct hid_device *hdev =3D hidpp->hid_dev;
> =C2=A0	char *name;
> @@ -4510,9 +4552,9 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> =C2=A0
> =C2=A0	/* Get name + serial, store in hdev->name + hdev->uniq */
> =C2=A0	if (id->group =3D=3D HID_GROUP_LOGITECH_DJ_DEVICE)
> -		hidpp_unifying_init(hidpp);
> +		hidpp_receiver_init(hidpp);
> =C2=A0	else
> -		hidpp_non_unifying_init(hidpp);
> +		hidpp_non_receiver_init(hidpp);
> =C2=A0
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> =C2=A0		connect_mask &=3D ~HID_CONNECT_HIDINPUT;
