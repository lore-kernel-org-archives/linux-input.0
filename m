Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8F394783;
	Tue,  3 Mar 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535557; cv=none; b=sQZYuebCaSieoBikLhuE9h6/jDeeOYNns83gi5splyzXnPBXuKcSrlVjAXUGgKH6k89S80tNjrSs4t/mjlBo+4UjMa8vOBjUDjPofynG921eXQv3KFi+wMGshl5g0y9IIJDxpbFt/UmuF8cx+6LJakVQK7U5qO5LoxUzI+uCowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535557; c=relaxed/simple;
	bh=/n2pGaYp/H/gaF4mgfl/siBNqv66E8pPM1/BpVPEDXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDc5Q6ShlX528d7IORCC72Eiz98KxvJY/fd/bXrP57bSQSDaWcavaJE/B/q6lO5y//NrK3KlwCerm1HR8vNAXXwfiM6aX0IWbFNHfQ2FPHkAD4IyplJwDuPWnxjuNYNMVcGLtY5oA4SBhnMoT+dvOt+MdbTdTNmr7y0uWEUlI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF30E43145;
	Tue,  3 Mar 2026 10:59:03 +0000 (UTC)
Message-ID: <cf80324676981d47e0194efd35fcc8cb625d381a.camel@hadess.net>
Subject: Re: [PATCH v3 14/18] HID: steelseries: Add Bluetooth call audio
 ducking control
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:59:03 +0100
In-Reply-To: <20260227235042.410062-15-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-15-srimanachanta@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgffhfedtgfegfedugeehpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg
X-GND-State: clean
X-GND-Score: -100

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Expose Bluetooth call audio ducking behavior as a writable ALSA
> enumerated mixer control ("Bluetooth Call Audio Ducking"), with three
> options: off, lower game audio by 12 dB, or mute game audio entirely.

You probably want to explain what "call ducking" or even "Bluetooth
call ducking" is.

>=20
> On the Arctis Nova 7 Gen2, this setting is stored alongside inactive
> timeout and Bluetooth auto-enable in a dedicated device configuration
> block. The settings request is expanded to also send a 0x00/0xa0
> device
> query in addition to the existing 0x00/0x20 audio settings query.
>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0drivers/hid/hid-steelseries.c | 120
> ++++++++++++++++++++++++++++++++--
> =C2=A01 file changed, 114 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-
> steelseries.c
> index 47ffec481571..bb9abbb0b6f8 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -30,12 +30,14 @@
> =C2=A0#define SS_CAP_SIDETONE			BIT(6)
> =C2=A0#define SS_CAP_MIC_VOLUME		BIT(7)
> =C2=A0#define SS_CAP_VOLUME_LIMITER		BIT(8)
> +#define SS_CAP_BT_CALL_DUCKING		BIT(9)
> =C2=A0
> =C2=A0#define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
> =C2=A0
> =C2=A0#define SS_SETTING_SIDETONE		0
> =C2=A0#define SS_SETTING_MIC_VOLUME		1
> =C2=A0#define SS_SETTING_VOLUME_LIMITER	2
> +#define SS_SETTING_BT_CALL_DUCKING	3
> =C2=A0
> =C2=A0struct steelseries_device;
> =C2=A0
> @@ -80,12 +82,14 @@ struct steelseries_device {
> =C2=A0	struct snd_ctl_elem_id sidetone_id;
> =C2=A0	struct snd_ctl_elem_id mic_volume_id;
> =C2=A0	struct snd_ctl_elem_id volume_limiter_id;
> +	struct snd_ctl_elem_id bt_call_ducking_id;
> =C2=A0	u8 chatmix_chat;
> =C2=A0	u8 chatmix_game;
> =C2=A0	bool mic_muted;
> =C2=A0	u8 sidetone;
> =C2=A0	u8 mic_volume;
> =C2=A0	bool volume_limiter;
> +	u8 bt_call_ducking;
> =C2=A0
> =C2=A0	bool bt_enabled;
> =C2=A0	bool bt_device_connected;
> @@ -573,6 +577,9 @@ static int
> steelseries_arctis_nova_7_write_setting(struct hid_device *hdev,
> =C2=A0	case SS_SETTING_VOLUME_LIMITER:
> =C2=A0		cmd =3D 0x3a;
> =C2=A0		break;
> +	case SS_SETTING_BT_CALL_DUCKING:
> +		cmd =3D 0xb3;
> +		break;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -883,15 +890,23 @@ static void
> steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
> =C2=A0
> =C2=A0static int steelseries_arctis_nova_7_gen2_request_settings(struct
> hid_device *hdev)
> =C2=A0{
> -	const u8 data[] =3D { 0x00, 0x20 };
> +	const u8 audio_data[] =3D { 0x00, 0x20 };
> +	const u8 device_data[] =3D { 0x00, 0xa0 };
> +	int ret;
> =C2=A0
> -	return steelseries_send_output_report(hdev, data,
> sizeof(data));
> +	ret =3D steelseries_send_output_report(hdev, audio_data,
> sizeof(audio_data));
> +	if (ret)
> +		return ret;
> +
> +	msleep(10);
> +
> +	return steelseries_send_output_report(hdev, device_data,
> sizeof(device_data));
> =C2=A0}
> =C2=A0
> =C2=A0static void steelseries_arctis_nova_7_gen2_parse_settings(
> =C2=A0	struct steelseries_device *sd, u8 *data, int size)
> =C2=A0{
> -	if (size < 4)
> +	if (size < 5)
> =C2=A0		return;
> =C2=A0
> =C2=A0	switch (data[0]) {
> @@ -900,6 +915,9 @@ static void
> steelseries_arctis_nova_7_gen2_parse_settings(
> =C2=A0		sd->sidetone =3D data[2];
> =C2=A0		sd->volume_limiter =3D data[3];
> =C2=A0		break;
> +	case 0xa0:
> +		sd->bt_call_ducking =3D data[4];
> +		break;
> =C2=A0	case 0x37:
> =C2=A0		sd->mic_volume =3D data[1];
> =C2=A0		break;
> @@ -909,6 +927,9 @@ static void
> steelseries_arctis_nova_7_gen2_parse_settings(
> =C2=A0	case 0x3a:
> =C2=A0		sd->volume_limiter =3D data[1];
> =C2=A0		break;
> +	case 0xb3:
> +		sd->bt_call_ducking =3D data[1];
> +		break;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -1025,7 +1046,8 @@ static const struct steelseries_device_info
> arctis_nova_5x_info =3D {
> =C2=A0static const struct steelseries_device_info arctis_nova_7_info =3D =
{
> =C2=A0	.sync_interface =3D 3,
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE |
> -			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
> +			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
> +			SS_CAP_BT_CALL_DUCKING,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 3,
> =C2=A0	.mic_volume_max =3D 7,
> @@ -1036,7 +1058,8 @@ static const struct steelseries_device_info
> arctis_nova_7_info =3D {
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_nova_7p_info =3D=
 {
> =C2=A0	.sync_interface =3D 3,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_MIC_VOLUME |
> SS_CAP_VOLUME_LIMITER,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_MIC_VOLUME |
> SS_CAP_VOLUME_LIMITER |
> +			SS_CAP_BT_CALL_DUCKING,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.mic_volume_max =3D 7,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> @@ -1050,7 +1073,8 @@ static const struct steelseries_device_info
> arctis_nova_7_gen2_info =3D {
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_MIC_MUTE |
> =C2=A0			SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED |
> =C2=A0			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
> -			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
> +			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
> +			SS_CAP_BT_CALL_DUCKING,
> =C2=A0	.sidetone_max =3D 3,
> =C2=A0	.mic_volume_max =3D 7,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> @@ -1557,6 +1581,70 @@ static const struct snd_kcontrol_new
> steelseries_volume_limiter_control =3D {
> =C2=A0	.put =3D steelseries_volume_limiter_put,
> =C2=A0};
> =C2=A0
> +static const char *const bt_call_ducking_texts[] =3D {
> +	"Off",
> +	"Lower Volume (-12dB)",
> +	"Mute Game",
> +};
> +
> +static int steelseries_bt_call_ducking_info(struct snd_kcontrol
> *kcontrol,
> +					=C2=A0=C2=A0=C2=A0 struct snd_ctl_elem_info
> *uinfo)
> +{
> +	return snd_ctl_enum_info(uinfo, 1,
> ARRAY_SIZE(bt_call_ducking_texts),
> +				 bt_call_ducking_texts);
> +}
> +
> +static int steelseries_bt_call_ducking_get(struct snd_kcontrol
> *kcontrol,
> +					=C2=A0=C2=A0 struct snd_ctl_elem_value
> *ucontrol)
> +{
> +	struct steelseries_device *sd =3D snd_kcontrol_chip(kcontrol);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sd->lock, flags);
> +	ucontrol->value.enumerated.item[0] =3D sd->bt_call_ducking;
> +	spin_unlock_irqrestore(&sd->lock, flags);
> +	return 0;
> +}
> +
> +static int steelseries_bt_call_ducking_put(struct snd_kcontrol
> *kcontrol,
> +					=C2=A0=C2=A0 struct snd_ctl_elem_value
> *ucontrol)
> +{
> +	struct steelseries_device *sd =3D snd_kcontrol_chip(kcontrol);
> +	unsigned long flags;
> +	u8 new_value;
> +	int ret;
> +
> +	new_value =3D ucontrol->value.enumerated.item[0];
> +	if (new_value >=3D ARRAY_SIZE(bt_call_ducking_texts))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&sd->lock, flags);
> +	if (sd->bt_call_ducking =3D=3D new_value) {
> +		spin_unlock_irqrestore(&sd->lock, flags);
> +		return 0;
> +	}
> +	spin_unlock_irqrestore(&sd->lock, flags);
> +
> +	ret =3D sd->info->write_setting(sd->hdev,
> SS_SETTING_BT_CALL_DUCKING,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_value);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock_irqsave(&sd->lock, flags);
> +	sd->bt_call_ducking =3D new_value;
> +	spin_unlock_irqrestore(&sd->lock, flags);
> +
> +	return 1;
> +}
> +
> +static const struct snd_kcontrol_new
> steelseries_bt_call_ducking_control =3D {
> +	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name =3D "Bluetooth Call Audio Ducking",
> +	.info =3D steelseries_bt_call_ducking_info,
> +	.get =3D steelseries_bt_call_ducking_get,
> +	.put =3D steelseries_bt_call_ducking_put,
> +};
> +
> =C2=A0static int steelseries_snd_register(struct steelseries_device *sd)
> =C2=A0{
> =C2=A0	struct hid_device *hdev =3D sd->hdev;
> @@ -1644,6 +1732,21 @@ static int steelseries_snd_register(struct
> steelseries_device *sd)
> =C2=A0		sd->volume_limiter_id =3D kctl->id;
> =C2=A0	}
> =C2=A0
> +	if (sd->info->capabilities & SS_CAP_BT_CALL_DUCKING) {
> +		struct snd_kcontrol *kctl;
> +		struct snd_kcontrol_new ducking_ctl =3D
> steelseries_bt_call_ducking_control;
> +
> +		ducking_ctl.access =3D
> SNDRV_CTL_ELEM_ACCESS_READWRITE;
> +		if (sd->info->capabilities & SS_CAP_EXTERNAL_CONFIG)
> +			ducking_ctl.access |=3D
> SNDRV_CTL_ELEM_ACCESS_VOLATILE;
> +
> +		kctl =3D snd_ctl_new1(&ducking_ctl, sd);
> +		ret =3D snd_ctl_add(sd->card, kctl);
> +		if (ret < 0)
> +			goto err_free_card;
> +		sd->bt_call_ducking_id =3D kctl->id;
> +	}
> +
> =C2=A0	ret =3D snd_card_register(sd->card);
> =C2=A0	if (ret < 0)
> =C2=A0		goto err_free_card;
> @@ -1677,6 +1780,7 @@ static int steelseries_raw_event(struct
> hid_device *hdev,
> =C2=A0	u8 old_sidetone;
> =C2=A0	u8 old_mic_volume;
> =C2=A0	bool old_volume_limiter;
> +	u8 old_bt_call_ducking;
> =C2=A0	bool is_async_interface =3D false;
> =C2=A0
> =C2=A0	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_SRWS1)
> @@ -1694,6 +1798,7 @@ static int steelseries_raw_event(struct
> hid_device *hdev,
> =C2=A0	old_sidetone =3D sd->sidetone;
> =C2=A0	old_mic_volume =3D sd->mic_volume;
> =C2=A0	old_volume_limiter =3D sd->volume_limiter;
> +	old_bt_call_ducking =3D sd->bt_call_ducking;
> =C2=A0
> =C2=A0	if (hid_is_usb(hdev)) {
> =C2=A0		struct usb_interface *intf =3D to_usb_interface(hdev-
> >dev.parent);
> @@ -1763,6 +1868,9 @@ static int steelseries_raw_event(struct
> hid_device *hdev,
> =C2=A0		if (sd->volume_limiter !=3D old_volume_limiter)
> =C2=A0			snd_ctl_notify(sd->card,
> SNDRV_CTL_EVENT_MASK_VALUE,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &sd->volume_limiter_id);
> +		if (sd->bt_call_ducking !=3D old_bt_call_ducking)
> +			snd_ctl_notify(sd->card,
> SNDRV_CTL_EVENT_MASK_VALUE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &sd->bt_call_ducking_id);
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
