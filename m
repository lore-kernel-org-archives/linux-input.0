Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCB3D6673;
	Tue,  3 Mar 2026 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535533; cv=none; b=aJo6w12+8hTsveHheR+cBdWLXSNvMHuxhcxXiYOz8PMmSQuD/kSWBS863xXW8wBHi2akbepK+ygqu49rDSPPZfz2VU6AqfoCqHZ+7q774GvGCQuM+ii1UsYAzbikLmotI4ztMtEWftkDO4Ufg4F0GS280QVkHPu8gtW54PilGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535533; c=relaxed/simple;
	bh=w2c8GVub2Iyf0pEcvLjRWpwWULspARB7+QXjUTHo6z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2ciqKRKr0G03RpcLyhBWXZXeh+LA0AFuXmN6UwgkJl5lYuKtijRdHMnE1D0rI9uwKRgdLrPkdJJslyU98QONkSCmNv7Hp/R6gqcqZn/7NB5iiJ0RoSy9RvUUKtI7AIfv2uIzGuS1ZEqy/0LQjpq4P9itqqtpgSIOq4atWD6KeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D145A43919;
	Tue,  3 Mar 2026 10:58:46 +0000 (UTC)
Message-ID: <f4f0879cda48b9721ec03a51eb7cda98f3761c68.camel@hadess.net>
Subject: Re: [PATCH v3 10/18] HID: steelseries: Add settings poll
 infrastructure
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:58:46 +0100
In-Reply-To: <20260227235042.410062-11-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-11-srimanachanta@gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepffdugeehteegfeeludelpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Some headset settings (sidetone level, mic volume, etc.) are not
> reported spontaneously but must be explicitly requested from the
> device.
> Introduce a separate delayed work item (settings_work) for fetching
> these persistent settings, independent of the existing status work.
>=20
> Settings are requested once at probe time and again whenever the
> headset
> reconnects after being disconnected. Device info structs gain
> request_settings and parse_settings hooks for model-specific
> implementations. The SS_CAP_EXTERNAL_CONFIG capability flag marks
> devices whose writable controls can also be changed from the headset
> hardware directly; writable ALSA controls on such devices will be
> marked
> volatile.

The settings polling work and the addition of SS_CAP_EXTERNAL_CONFIG
for some headsets should probably be made in separate commits.

>=20
> The initial implementation adds the Arctis Nova 7 Gen2 audio settings
> request (0x00, 0x20).
>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0drivers/hid/hid-steelseries.c | 37
> ++++++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-
> steelseries.c
> index 8c6116d02f19..f2423c350154 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -26,6 +26,7 @@
> =C2=A0#define SS_CAP_MIC_MUTE			BIT(2)
> =C2=A0#define SS_CAP_BT_ENABLED		BIT(3)
> =C2=A0#define SS_CAP_BT_DEVICE_CONNECTED	BIT(4)
> +#define SS_CAP_EXTERNAL_CONFIG		BIT(5)
> =C2=A0
> =C2=A0#define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
> =C2=A0
> @@ -40,6 +41,9 @@ struct steelseries_device_info {
> =C2=A0
> =C2=A0	int (*request_status)(struct hid_device *hdev);
> =C2=A0	void (*parse_status)(struct steelseries_device *sd, u8
> *data, int size);
> +
> +	int (*request_settings)(struct hid_device *hdev);
> +	void (*parse_settings)(struct steelseries_device *sd, u8
> *data, int size);
> =C2=A0};
> =C2=A0
> =C2=A0struct steelseries_device {
> @@ -49,6 +53,7 @@ struct steelseries_device {
> =C2=A0	bool use_async_protocol;
> =C2=A0
> =C2=A0	struct delayed_work status_work;
> +	struct delayed_work settings_work;
> =C2=A0
> =C2=A0	struct power_supply_desc battery_desc;
> =C2=A0	struct power_supply *battery;
> @@ -690,6 +695,14 @@ static void
> steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int steelseries_arctis_nova_7_gen2_request_settings(struct
> hid_device *hdev)
> +{
> +	const u8 data[] =3D { 0x00, 0x20 };
> +
> +	return steelseries_send_output_report(hdev, data,
> sizeof(data));
> +}
> +
> +
> =C2=A0static void steelseries_arctis_nova_pro_parse_status(struct
> steelseries_device *sd,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, int
> size)
> =C2=A0{
> @@ -791,9 +804,11 @@ static const struct steelseries_device_info
> arctis_nova_7_gen2_info =3D {
> =C2=A0	.sync_interface =3D 3,
> =C2=A0	.async_interface =3D 5,
> =C2=A0	.capabilities =3D SS_CAP_BATTERY | SS_CAP_CHATMIX |
> SS_CAP_MIC_MUTE |
> -			SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED,
> +			SS_CAP_BT_ENABLED |
> SS_CAP_BT_DEVICE_CONNECTED |
> +			SS_CAP_EXTERNAL_CONFIG,
> =C2=A0	.request_status =3D steelseries_arctis_nova_request_status,
> =C2=A0	.parse_status =3D steelseries_arctis_nova_7_gen2_parse_status,
> +	.request_settings =3D
> steelseries_arctis_nova_7_gen2_request_settings,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct steelseries_device_info arctis_nova_pro_info =
=3D {
> @@ -901,6 +916,15 @@ static void
> steelseries_status_timer_work_handler(struct work_struct *work)
> =C2=A0	spin_unlock_irqrestore(&sd->lock, flags);
> =C2=A0}
> =C2=A0
> +static void steelseries_settings_work_handler(struct work_struct
> *work)
> +{
> +	struct steelseries_device *sd =3D container_of(
> +		work, struct steelseries_device,
> settings_work.work);
> +
> +	if (sd->info->request_settings)
> +		sd->info->request_settings(sd->hdev);
> +}
> +
> =C2=A0static int steelseries_battery_register(struct steelseries_device
> *sd)
> =C2=A0{
> =C2=A0	static atomic_t battery_no =3D ATOMIC_INIT(0);
> @@ -1185,6 +1209,9 @@ static int steelseries_raw_event(struct
> hid_device *hdev,
> =C2=A0
> =C2=A0	sd->info->parse_status(sd, data, size);
> =C2=A0
> +	if (sd->info->parse_settings)
> +		sd->info->parse_settings(sd, data, size);
> +
> =C2=A0	if (sd->headset_connected !=3D old_connected) {
> =C2=A0		hid_dbg(hdev,
> =C2=A0			"Connected status changed from %sconnected
> to %sconnected\n",
> @@ -1194,6 +1221,9 @@ static int steelseries_raw_event(struct
> hid_device *hdev,
> =C2=A0		if (sd->headset_connected && !old_connected &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 sd->use_async_protocol && is_async_interface) =
{
> =C2=A0			schedule_delayed_work(&sd->status_work, 0);
> +			if (sd->info->request_settings)
> +				schedule_delayed_work(&sd-
> >settings_work,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> msecs_to_jiffies(10));
> =C2=A0		}
> =C2=A0
> =C2=A0		if (sd->battery) {
> @@ -1329,7 +1359,11 @@ static int steelseries_probe(struct hid_device
> *hdev,
> =C2=A0#endif
> =C2=A0
> =C2=A0		INIT_DELAYED_WORK(&sd->status_work,
> steelseries_status_timer_work_handler);
> +		INIT_DELAYED_WORK(&sd->settings_work,
> steelseries_settings_work_handler);
> +
> =C2=A0		schedule_delayed_work(&sd->status_work,
> msecs_to_jiffies(100));
> +		if (info->request_settings)
> +			schedule_delayed_work(&sd->settings_work,
> msecs_to_jiffies(200));
> =C2=A0
> =C2=A0		return 0;
> =C2=A0	}
> @@ -1415,6 +1449,7 @@ static void steelseries_remove(struct
> hid_device *hdev)
> =C2=A0		spin_unlock_irqrestore(&sd->lock, flags);
> =C2=A0
> =C2=A0		cancel_delayed_work_sync(&sd->status_work);
> +		cancel_delayed_work_sync(&sd->settings_work);
> =C2=A0	}
> =C2=A0
> =C2=A0	hid_hw_close(hdev);
