Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166653DA5BC;
	Tue,  3 Mar 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535548; cv=none; b=qwUsdsmjaY45tpt/6/Zy46jzz7D2YUIlxe04wa1mpWl0f5PRqIH1IZlKKCxYMfD+RwCYdvW7De+Yqn5HrC40XogcT3nM1oKDSjSm5EesT9Te4DijSlyR/fiLGXlTQDyxtOWHo/1jjPg0xqdrSucceckZbtQeBWoj3h5c3B5ZlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535548; c=relaxed/simple;
	bh=hLewgKJoAOh6ZqGgPcORSs74fkNtqauU5oRVUOx0ylY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuFDTEeNXFqPH4GCoReHnvKYRqv4e1rOtkPDi579SeCH9wr+SKpwuFk0b25vq0LREh54UsHxSrK93Ez/bGEY6SXtwvxdxRO+w82L/Pg+gItVquapnCf/ugyipp1WtkIvk8VkMGmoQVWGdIz/soM5iOxhtfnQ5R+521h/hsfVCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 821EA1F747;
	Tue,  3 Mar 2026 10:59:01 +0000 (UTC)
Message-ID: <9f518100d091e1bd89a54bcdcf344c1e1750ec31.camel@hadess.net>
Subject: Re: [PATCH v3 15/18] HID: steelseries: Add inactive time sysfs
 attribute
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:59:01 +0100
In-Reply-To: <20260227235042.410062-16-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-16-srimanachanta@gmail.com>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepkedvudfgteduhfejgeejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg
X-GND-State: clean

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Expose the headset auto-shutoff timer as a read/write sysfs attribute
> (inactive_time), in minutes. Writing the attribute immediately sends
> the
> new value to the device; reading it returns the last value reported
> by
> the firmware.

Question to you and the HID maintainers:

Is there no existing sysfs definition that could match this description
and could be reused instead of needing a new one?

>=20
> The wire encoding differs per family:
> - Arctis 1: HID feature report 0x06/0x53 with the value in minutes
> - Arctis 7: HID feature report 0x06/0x51; split into its own write
> =C2=A0 function as the command byte differs from the Arctis 1
> - Arctis 9: converts minutes to seconds in a big-endian u16
> - Nova 3P: rounds down to the nearest value in a discrete set
> =C2=A0 {0,1,5,10,15,30,45,60,75,90} before sending command 0xa3
> - Nova 5/7: output report with command 0xa3, no rounding required
> - Nova Pro: maps minutes to six firmware-defined level indices via
> =C2=A0 command 0xc1
>=20
> The inactive_time_max field is added to the device info struct to
> enforce the per-device maximum at write time.
>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0drivers/hid/hid-steelseries.c | 183 +++++++++++++++++++++++++++++++=
-
> --
> =C2=A01 file changed, 167 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-
> steelseries.c
> index bb9abbb0b6f8..f076a0ef8af1 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -31,6 +31,7 @@
> =C2=A0#define SS_CAP_MIC_VOLUME		BIT(7)
> =C2=A0#define SS_CAP_VOLUME_LIMITER		BIT(8)
> =C2=A0#define SS_CAP_BT_CALL_DUCKING		BIT(9)
> +#define SS_CAP_INACTIVE_TIME		BIT(10)
> =C2=A0
> =C2=A0#define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
> =C2=A0
> @@ -38,6 +39,7 @@
> =C2=A0#define SS_SETTING_MIC_VOLUME		1
> =C2=A0#define SS_SETTING_VOLUME_LIMITER	2
> =C2=A0#define SS_SETTING_BT_CALL_DUCKING	3
> +#define SS_SETTING_INACTIVE_TIME	4
> =C2=A0
> =C2=A0struct steelseries_device;
> =C2=A0
> @@ -51,6 +53,7 @@ struct steelseries_device_info {
> =C2=A0	u8 sidetone_max;
> =C2=A0	u8 mic_volume_min;
> =C2=A0	u8 mic_volume_max;
> +	u8 inactive_time_max;
> =C2=A0
> =C2=A0	int (*request_status)(struct hid_device *hdev);
> =C2=A0	void (*parse_status)(struct steelseries_device *sd, u8
> *data, int size);
> @@ -93,6 +96,7 @@ struct steelseries_device {
> =C2=A0
> =C2=A0	bool bt_enabled;
> =C2=A0	bool bt_device_connected;
> +	u8 inactive_timeout;
> =C2=A0
> =C2=A0	spinlock_t lock;
> =C2=A0	bool removed;
> @@ -476,6 +480,37 @@ static int
> steelseries_arctis_1_write_setting(struct hid_device *hdev,
> =C2=A0			return steelseries_send_feature_report(hdev,
> data,
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> sizeof(data));
> =C2=A0		}
> +	case SS_SETTING_INACTIVE_TIME: {
> +		const u8 data[] =3D { 0x06, 0x53, value };
> +
> +		return steelseries_send_feature_report(hdev, data,
> sizeof(data));
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int steelseries_arctis_7_write_setting(struct hid_device
> *hdev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 setting, u8 value)
> +{
> +	switch (setting) {
> +	case SS_SETTING_SIDETONE:
> +		if (value =3D=3D 0) {
> +			const u8 data[] =3D { 0x06, 0x35 };
> +
> +			return steelseries_send_feature_report(hdev,
> data,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> sizeof(data));
> +		} else {
> +			const u8 data[] =3D { 0x06, 0x35, 0x01, 0x00,
> value };
> +
> +			return steelseries_send_feature_report(hdev,
> data,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> sizeof(data));
> +		}
> +	case SS_SETTING_INACTIVE_TIME: {
> +		const u8 data[] =3D { 0x06, 0x51, value };
> +
> +		return steelseries_send_feature_report(hdev, data,
> sizeof(data));
> +	}
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -490,11 +525,30 @@ static int
> steelseries_arctis_9_write_setting(struct hid_device *hdev,
> =C2=A0
> =C2=A0		return steelseries_send_feature_report(hdev, data,
> sizeof(data));
> =C2=A0	}
> +	case SS_SETTING_INACTIVE_TIME: {
> +		u16 seconds =3D (u16)value * 60;
> +		const u8 data[] =3D { 0x04, 0x00, seconds >> 8,
> seconds & 0xff };
> +
> +		return steelseries_send_feature_report(hdev, data,
> sizeof(data));
> +	}
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static u8 steelseries_arctis_nova_3p_round_inactive_time(u8 minutes)
> +{
> +	static const u8 supported[] =3D { 0, 1, 5, 10, 15, 30, 45, 60,
> 75, 90 };
> +	int i;
> +
> +	for (i =3D ARRAY_SIZE(supported) - 1; i > 0; i--) {
> +		if (minutes >=3D supported[i])
> +			return supported[i];
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0static int steelseries_arctis_nova_3p_write_setting(struct
> hid_device *hdev,
> =C2=A0						=C2=A0=C2=A0=C2=A0 u8 setting, u8
> value)
> =C2=A0{
> @@ -510,6 +564,10 @@ static int
> steelseries_arctis_nova_3p_write_setting(struct hid_device *hdev,
> =C2=A0	case SS_SETTING_MIC_VOLUME:
> =C2=A0		cmd =3D 0x37;
> =C2=A0		break;
> +	case SS_SETTING_INACTIVE_TIME:
> +		cmd =3D 0xa3;
> +		value =3D
> steelseries_arctis_nova_3p_round_inactive_time(value);
> +		break;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -542,6 +600,9 @@ static int
> steelseries_arctis_nova_5_write_setting(struct hid_device *hdev,
> =C2=A0	case SS_SETTING_VOLUME_LIMITER:
> =C2=A0		cmd =3D 0x27;
> =C2=A0		break;
> +	case SS_SETTING_INACTIVE_TIME:
> +		cmd =3D 0xa3;
> +		break;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -580,6 +641,9 @@ static int
> steelseries_arctis_nova_7_write_setting(struct hid_device *hdev,
> =C2=A0	case SS_SETTING_BT_CALL_DUCKING:
> =C2=A0		cmd =3D 0xb3;
> =C2=A0		break;
> +	case SS_SETTING_INACTIVE_TIME:
> +		cmd =3D 0xa3;
> +		break;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -612,6 +676,24 @@ static int
> steelseries_arctis_nova_pro_write_setting(struct hid_device *hdev,
> =C2=A0	case SS_SETTING_MIC_VOLUME:
> =C2=A0		cmd =3D 0x37;
> =C2=A0		break;
> +	case SS_SETTING_INACTIVE_TIME:
> +		cmd =3D 0xc1;
> +		/* Map minutes to firmware level */
> +		if (value >=3D 45)
> +			value =3D 6; /* 60 min */
> +		else if (value >=3D 23)
> +			value =3D 5; /* 30 min */
> +		else if (value >=3D 13)
> +			value =3D 4; /* 15 min */
> +		else if (value >=3D 8)
> +			value =3D 3; /* 10 min */
> +		else if (value >=3D 3)
> +			value =3D 2; /* 5 min */
> +		else if (value > 0)
> +			value =3D 1; /* 1 min */
> +		else
> +			value =3D 0; /* disabled */
> +		break;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -916,6 +998,7 @@ static void
> steelseries_arctis_nova_7_gen2_parse_settings(
> =C2=A0		sd->volume_limiter =3D data[3];
> =C2=A0		break;
> =C2=A0	case 0xa0:
> +		sd->inactive_timeout =3D data[1];
> =C2=A0		sd->bt_call_ducking =3D data[4];
> =C2=A0		break;
> =C2=A0	case 0x37:
> @@ -927,6 +1010,9 @@ static void
> steelseries_arctis_nova_7_gen2_parse_settings(
> =C2=A0	case 0x3a:
> =C2=A0		sd->volume_limiter =3D data[1];
> =C2=A0		break;
> +	case 0xa3:
> +		sd->inactive_timeout =3D data[1];
> +		break;
> =C2=A0	case 0xb3:
> =C2=A0		sd->bt_call_ducking =3D data[1];
> =C2=A0		break;
> @@ -936,11 +1022,13 @@ static void
> steelseries_arctis_nova_7_gen2_parse_settings(
> =C2=A0static void steelseries_arctis_nova_pro_parse_settings(
> =C2=A0	struct steelseries_device *sd, u8 *data, int size)
> =C2=A0{
> -	if (size < 10)
> +	if (size < 13)
> =C2=A0		return;
> =C2=A0
> -	if (data[0] =3D=3D 0x06 && data[1] =3D=3D 0xb0)
> +	if (data[0] =3D=3D 0x06 && data[1] =3D=3D 0xb0) {
> =C2=A0		sd->mic_volume =3D data[9];
> +		sd->inactive_timeout =3D data[12];
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static void steelseries_arctis_nova_pro_parse_status(struct
> steelseries_device *sd,
> @@ -970,9 +1058,10 @@ static const struct steelseries_device_info
> srws1_info =3D { };
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_1_info =3D {
> =C2=A0	.sync_interface =3D 3,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_SIDETONE,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_SIDETONE |
> SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 18,
> +	.inactive_time_max =3D 90,
> =C2=A0	.request_status =3D steelseries_arctis_1_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_1_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_1_write_setting,
> @@ -980,19 +1069,23 @@ static const struct steelseries_device_info
> arctis_1_info =3D {
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_7_info =3D {
> =C2=A0	.sync_interface =3D 5,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE |
> +			SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 18,
> +	.inactive_time_max =3D 90,
> =C2=A0	.request_status =3D steelseries_arctis_7_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_7_parse_status,
> -	.write_setting =3D steelseries_arctis_1_write_setting,
> +	.write_setting =3D steelseries_arctis_7_write_setting,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_7_plus_info =3D =
{
> =C2=A0	.sync_interface =3D 3,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE |
> +			SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 3,
> +	.inactive_time_max =3D 90,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_7_plus_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_nova_5_write_setting,
> @@ -1000,9 +1093,11 @@ static const struct steelseries_device_info
> arctis_7_plus_info =3D {
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_9_info =3D {
> =C2=A0	.sync_interface =3D 0,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE |
> +			SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 61,
> +	.inactive_time_max =3D 255,
> =C2=A0	.request_status =3D steelseries_arctis_9_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_9_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_9_write_setting,
> @@ -1010,10 +1105,12 @@ static const struct steelseries_device_info
> arctis_9_info =3D {
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_nova_3p_info =3D=
 {
> =C2=A0	.sync_interface =3D 4,
> -	.capabilities =3D SS_CAP_BATTERY | SS_CAP_SIDETONE |
> SS_CAP_MIC_VOLUME,
> +	.capabilities =3D SS_CAP_BATTERY | SS_CAP_SIDETONE |
> SS_CAP_MIC_VOLUME |
> +			SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 10,
> =C2=A0	.mic_volume_max =3D 14,
> +	.inactive_time_max =3D 90,
> =C2=A0	.request_status =3D steelseries_arctis_nova_3p_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_3p_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_nova_3p_write_setting,
> @@ -1022,10 +1119,11 @@ static const struct steelseries_device_info
> arctis_nova_3p_info =3D {
> =C2=A0static const struct steelseries_device_info arctis_nova_5_info =3D =
{
> =C2=A0	.sync_interface =3D 3,
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_SIDETONE |
> SS_CAP_MIC_VOLUME |
> -			SS_CAP_VOLUME_LIMITER,
> +			SS_CAP_VOLUME_LIMITER |
> SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 10,
> =C2=A0	.mic_volume_max =3D 15,
> +	.inactive_time_max =3D 255,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_5_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_nova_5_write_setting,
> @@ -1034,10 +1132,12 @@ static const struct steelseries_device_info
> arctis_nova_5_info =3D {
> =C2=A0static const struct steelseries_device_info arctis_nova_5x_info =3D=
 {
> =C2=A0	.sync_interface =3D 3,
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE |
> -			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
> +			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
> +			SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 10,
> =C2=A0	.mic_volume_max =3D 15,
> +	.inactive_time_max =3D 255,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_5x_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_nova_5_write_setting,
> @@ -1047,10 +1147,11 @@ static const struct steelseries_device_info
> arctis_nova_7_info =3D {
> =C2=A0	.sync_interface =3D 3,
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_SIDETONE |
> =C2=A0			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
> -			SS_CAP_BT_CALL_DUCKING,
> +			SS_CAP_BT_CALL_DUCKING |
> SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 3,
> =C2=A0	.mic_volume_max =3D 7,
> +	.inactive_time_max =3D 255,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_7_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_nova_7_write_setting,
> @@ -1059,9 +1160,10 @@ static const struct steelseries_device_info
> arctis_nova_7_info =3D {
> =C2=A0static const struct steelseries_device_info arctis_nova_7p_info =3D=
 {
> =C2=A0	.sync_interface =3D 3,
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_MIC_VOLUME |
> SS_CAP_VOLUME_LIMITER |
> -			SS_CAP_BT_CALL_DUCKING,
> +			SS_CAP_BT_CALL_DUCKING |
> SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.mic_volume_max =3D 7,
> +	.inactive_time_max =3D 255,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_7_parse_status,
> =C2=A0	.write_setting =3D steelseries_arctis_nova_7_write_setting,
> @@ -1074,9 +1176,10 @@ static const struct steelseries_device_info
> arctis_nova_7_gen2_info =3D {
> =C2=A0			SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED |
> =C2=A0			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
> =C2=A0			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
> -			SS_CAP_BT_CALL_DUCKING,
> +			SS_CAP_BT_CALL_DUCKING |
> SS_CAP_INACTIVE_TIME,
> =C2=A0	.sidetone_max =3D 3,
> =C2=A0	.mic_volume_max =3D 7,
> +	.inactive_time_max =3D 255,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_7_gen2_parse_status,
> =C2=A0	.request_settings =3D
> steelseries_arctis_nova_7_gen2_request_settings,
> @@ -1088,11 +1191,12 @@ static const struct steelseries_device_info
> arctis_nova_pro_info =3D {
> =C2=A0	.sync_interface =3D 4,
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_MIC_MUTE |
> =C2=A0			SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED |
> -			SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME,
> +			SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME |
> SS_CAP_INACTIVE_TIME,
> =C2=A0	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> =C2=A0	.sidetone_max =3D 3,
> =C2=A0	.mic_volume_min =3D 1,
> =C2=A0	.mic_volume_max =3D 10,
> +	.inactive_time_max =3D 60,
> =C2=A0	.request_status =3D
> steelseries_arctis_nova_pro_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_pro_parse_status,
> =C2=A0	.parse_settings =3D
> steelseries_arctis_nova_pro_parse_settings,
> @@ -1271,12 +1375,55 @@ static ssize_t
> bt_device_connected_show(struct device *dev,
> =C2=A0	return sysfs_emit(buf, "%d\n", sd->bt_device_connected);
> =C2=A0}
> =C2=A0
> +static ssize_t inactive_time_show(struct device *dev,
> +				=C2=A0 struct device_attribute *attr,
> char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct steelseries_device *sd =3D hid_get_drvdata(hdev);
> +
> +	if (!sd->headset_connected)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%d\n", sd->inactive_timeout);
> +}
> +
> +static ssize_t inactive_time_store(struct device *dev,
> +				=C2=A0=C2=A0 struct device_attribute *attr,
> +				=C2=A0=C2=A0 const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct steelseries_device *sd =3D hid_get_drvdata(hdev);
> +	unsigned int value;
> +	int ret;
> +
> +	if (!sd->headset_connected)
> +		return -ENODEV;
> +
> +	ret =3D kstrtouint(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value > sd->info->inactive_time_max)
> +		return -EINVAL;
> +
> +	ret =3D sd->info->write_setting(sd->hdev,
> SS_SETTING_INACTIVE_TIME,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value);
> +	if (ret)
> +		return ret;
> +
> +	sd->inactive_timeout =3D value;
> +
> +	return count;
> +}
> +
> =C2=A0static DEVICE_ATTR_RO(bt_enabled);
> =C2=A0static DEVICE_ATTR_RO(bt_device_connected);
> +static DEVICE_ATTR_RW(inactive_time);
> =C2=A0
> =C2=A0static struct attribute *steelseries_headset_attrs[] =3D {
> =C2=A0	&dev_attr_bt_enabled.attr,
> =C2=A0	&dev_attr_bt_device_connected.attr,
> +	&dev_attr_inactive_time.attr,
> =C2=A0	NULL,
> =C2=A0};
> =C2=A0
> @@ -1298,6 +1445,8 @@ static umode_t
> steelseries_headset_attr_is_visible(struct kobject *kobj,
> =C2=A0		return (caps & SS_CAP_BT_ENABLED) ? attr->mode : 0;
> =C2=A0	if (attr =3D=3D &dev_attr_bt_device_connected.attr)
> =C2=A0		return (caps & SS_CAP_BT_DEVICE_CONNECTED) ? attr-
> >mode : 0;
> +	if (attr =3D=3D &dev_attr_inactive_time.attr)
> +		return (caps & SS_CAP_INACTIVE_TIME) ? attr->mode :
> 0;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -1956,7 +2105,8 @@ static int steelseries_probe(struct hid_device
> *hdev,
> =C2=A0				hid_warn(hdev, "Failed to register
> battery: %d\n", ret);
> =C2=A0		}
> =C2=A0
> -		if (info->capabilities & (SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED)) {
> +		if (info->capabilities & (SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED |
> +					=C2=A0 SS_CAP_INACTIVE_TIME)) {
> =C2=A0			ret =3D sysfs_create_group(&hdev->dev.kobj,
> =C2=A0					=09
> &steelseries_headset_attr_group);
> =C2=A0			if (ret)
> @@ -2038,7 +2188,8 @@ static void steelseries_remove(struct
> hid_device *hdev)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (interface_num =3D=3D sd->info->sync_interface) {
> -		if (sd->info->capabilities & (SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED))
> +		if (sd->info->capabilities & (SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED |
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SS_CAP_INACTIVE_TIME))
> =C2=A0			sysfs_remove_group(&hdev->dev.kobj,
> =C2=A0					=C2=A0=C2=A0
> &steelseries_headset_attr_group);
> =C2=A0
