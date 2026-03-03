Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34223E7168;
	Tue,  3 Mar 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535673; cv=none; b=qf2cbF05H7TyI+CPjMHMmSm54/1geAQj1hDfRtXToVP85D7zmIzVjsvcfsgfyXarwEnK+ADm1yPp6PBQBADbR8Z0AprS7ZAnkfJKOdVc6eerklC9K/sSgXQGseoxD1rWXAT3nafY6SeOndYpdjKEHxBAftWhgqGkjlHqzvZMVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535673; c=relaxed/simple;
	bh=rZvuwduFXZlVbfNDavSlfAJ3vUhPa9Zo7+AubmUgQlQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3BJYmNVEvhBqBdNj0dA+sOaP1m5fo5l3gC+Q2kOjgIH3gzQO3Tl85A6+aO6YOH5Ds1i8BTiNheo3x2EUrVcRz3xPTbUHieMzXajSxHT2+u4I05zBdKpEayg7SqM+rnpFoYrvAdTAGh7Ep4NutY5bpPcHF/zGg7PoFbV3vQRpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id A55C3581208;
	Tue,  3 Mar 2026 10:58:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF3D941DD1;
	Tue,  3 Mar 2026 10:58:41 +0000 (UTC)
Message-ID: <545b7301f828ec022937c2bc53df0ae7eab285b1.camel@hadess.net>
Subject: Re: [PATCH v3 09/18] HID: steelseries: Add Bluetooth state sysfs
 attributes
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:58:41 +0100
In-Reply-To: <20260227235042.410062-10-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-10-srimanachanta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepfffhfeffleegudffffdupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg
X-GND-State: clean
X-GND-Score: -100

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Add read-only sysfs attributes bt_enabled and bt_device_connected
> that
> reflect the current Bluetooth radio state for headsets that support
> it.
> Attributes are registered via an attribute group with an is_visible
> callback so they only appear on capable devices.

This needs a longer explanation as to what that "Bluetooth state" is,
so folks that aren't familiar with the Steelseries products'
capabilities.

> Bluetooth state is decoded from the following HID reports:
> - Arctis Nova 7 Gen2: 0xb0 initial status packet and 0xb5 async
> events
> - Arctis Nova Pro: initial 0x06/0x14 status packet
>=20
> Returns -ENODEV if the headset is not currently connected.

Do you have any ideas on how it might be used? Maybe a link to a
product page that shows the Windows or macOS software using the
feature, or another manufacturer using something similar?

Adding sysfs files like this is pretty frowned upon, so you probably
want to make sure that this is the last or close to last patch in your
patchset so maintainers can easily defer it without blocking the rest.



>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0drivers/hid/hid-steelseries.c | 111
> +++++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 109 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-
> steelseries.c
> index 3de8e1555263..8c6116d02f19 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -24,6 +24,8 @@
> =C2=A0#define SS_CAP_BATTERY			BIT(0)
> =C2=A0#define SS_CAP_CHATMIX			BIT(1)
> =C2=A0#define SS_CAP_MIC_MUTE			BIT(2)
> +#define SS_CAP_BT_ENABLED		BIT(3)
> +#define SS_CAP_BT_DEVICE_CONNECTED	BIT(4)
> =C2=A0
> =C2=A0#define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
> =C2=A0
> @@ -62,6 +64,9 @@ struct steelseries_device {
> =C2=A0	u8 chatmix_game;
> =C2=A0	bool mic_muted;
> =C2=A0
> +	bool bt_enabled;
> +	bool bt_device_connected;
> +
> =C2=A0	spinlock_t lock;
> =C2=A0	bool removed;
> =C2=A0};
> @@ -641,6 +646,20 @@ static void
> steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
> =C2=A0		sd->battery_charging =3D (data[3] =3D=3D 0x01);
> =C2=A0		sd->chatmix_game =3D data[4];
> =C2=A0		sd->chatmix_chat =3D data[5];
> +		switch (data[6]) {
> +		case 0x00:
> +			sd->bt_enabled =3D false;
> +			sd->bt_device_connected =3D false;
> +			break;
> +		case 0x03:
> +			sd->bt_enabled =3D true;
> +			sd->bt_device_connected =3D false;
> +			break;
> +		case 0x02:
> +			sd->bt_enabled =3D true;
> +			sd->bt_device_connected =3D true;
> +			break;
> +		}
> =C2=A0		sd->mic_muted =3D (data[9] =3D=3D 0x01);
> =C2=A0		break;
> =C2=A0	case 0xb7:
> @@ -659,6 +678,15 @@ static void
> steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
> =C2=A0	case 0x52:
> =C2=A0		sd->mic_muted =3D (data[2] =3D=3D 0x01);
> =C2=A0		break;
> +	case 0xb5:
> +		if (data[1] =3D=3D 0x01) {
> +			sd->bt_enabled =3D false;
> +			sd->bt_device_connected =3D false;
> +		} else if (data[1] =3D=3D 0x04) {
> +			sd->bt_enabled =3D true;
> +			sd->bt_device_connected =3D (data[2] =3D=3D 0x01);
> +		}
> +		break;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -673,6 +701,8 @@ static void
> steelseries_arctis_nova_pro_parse_status(struct steelseries_device *
> =C2=A0		sd->battery_capacity =3D
> steelseries_map_capacity(data[6], 0x00, 0x08);
> =C2=A0		sd->battery_charging =3D (data[15] =3D=3D 0x02);
> =C2=A0		sd->mic_muted =3D (data[9] =3D=3D 0x01);
> +		sd->bt_enabled =3D (data[4] =3D=3D 0x00);
> +		sd->bt_device_connected =3D (data[5] =3D=3D 0x01);
> =C2=A0	} else if (data[0] =3D=3D 0x07 && data[1] =3D=3D 0x45) {
> =C2=A0		sd->chatmix_game =3D data[2];
> =C2=A0		sd->chatmix_chat =3D data[3];
> @@ -760,14 +790,16 @@ static const struct steelseries_device_info
> arctis_nova_7p_info =3D {
> =C2=A0static const struct steelseries_device_info arctis_nova_7_gen2_info
> =3D {
> =C2=A0	.sync_interface =3D 3,
> =C2=A0	.async_interface =3D 5,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_MIC_MUTE,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_MIC_MUTE |
> +			SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_7_gen2_parse_status,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_nova_pro_info =
=3D {
> =C2=A0	.sync_interface =3D 4,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_MIC_MUTE,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_MIC_MUTE |
> +			SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.request_status =3D
> steelseries_arctis_nova_pro_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_pro_parse_status,
> @@ -908,6 +940,70 @@ static int steelseries_battery_register(struct
> steelseries_device *sd)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * Sysfs attributes for device state
> + */
> +
> +static ssize_t bt_enabled_show(struct device *dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, c=
har
> *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct steelseries_device *sd =3D hid_get_drvdata(hdev);
> +
> +	if (!sd->headset_connected)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%d\n", sd->bt_enabled);
> +}
> +
> +static ssize_t bt_device_connected_show(struct device *dev,
> +					struct device_attribute
> *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct steelseries_device *sd =3D hid_get_drvdata(hdev);
> +
> +	if (!sd->headset_connected)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%d\n", sd->bt_device_connected);
> +}
> +
> +static DEVICE_ATTR_RO(bt_enabled);
> +static DEVICE_ATTR_RO(bt_device_connected);
> +
> +static struct attribute *steelseries_headset_attrs[] =3D {
> +	&dev_attr_bt_enabled.attr,
> +	&dev_attr_bt_device_connected.attr,
> +	NULL,
> +};
> +
> +static umode_t steelseries_headset_attr_is_visible(struct kobject
> *kobj,
> +						=C2=A0=C2=A0 struct attribute
> *attr,
> +						=C2=A0=C2=A0 int index)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct steelseries_device *sd =3D hid_get_drvdata(hdev);
> +	unsigned long caps;
> +
> +	if (!sd)
> +		return 0;
> +
> +	caps =3D sd->info->capabilities;
> +
> +	if (attr =3D=3D &dev_attr_bt_enabled.attr)
> +		return (caps & SS_CAP_BT_ENABLED) ? attr->mode : 0;
> +	if (attr =3D=3D &dev_attr_bt_device_connected.attr)
> +		return (caps & SS_CAP_BT_DEVICE_CONNECTED) ? attr-
> >mode : 0;
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group steelseries_headset_attr_group =3D
> {
> +	.attrs =3D steelseries_headset_attrs,
> +	.is_visible =3D steelseries_headset_attr_is_visible,
> +};
> +
> =C2=A0#if IS_BUILTIN(CONFIG_SND) || \
> =C2=A0	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
> =C2=A0
> @@ -1218,6 +1314,13 @@ static int steelseries_probe(struct hid_device
> *hdev,
> =C2=A0				hid_warn(hdev, "Failed to register
> battery: %d\n", ret);
> =C2=A0		}
> =C2=A0
> +		if (info->capabilities & (SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED)) {
> +			ret =3D sysfs_create_group(&hdev->dev.kobj,
> +					=09
> &steelseries_headset_attr_group);
> +			if (ret)
> +				hid_warn(hdev, "Failed to create
> sysfs group: %d\n", ret);
> +		}
> +
> =C2=A0#if IS_BUILTIN(CONFIG_SND) || \
> =C2=A0	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
> =C2=A0		ret =3D steelseries_snd_register(sd);
> @@ -1289,6 +1392,10 @@ static void steelseries_remove(struct
> hid_device *hdev)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (interface_num =3D=3D sd->info->sync_interface) {
> +		if (sd->info->capabilities & (SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED))
> +			sysfs_remove_group(&hdev->dev.kobj,
> +					=C2=A0=C2=A0
> &steelseries_headset_attr_group);
> +
> =C2=A0		if (sd->info->async_interface) {
> =C2=A0			struct hid_device *sibling;
> =C2=A0
