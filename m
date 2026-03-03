Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC93CF68A;
	Tue,  3 Mar 2026 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535540; cv=none; b=KaCiBop60qEi3E+i8L53ZFDjJGWndMK8MMAElm5zZLlBXBkE+V1CpESv087keCxnZS7lgPoGt+Xu/SB7ka0Ye2YS6W8H20q/Vq7XgM9st3BFbcnz3Gio6Nol88z+Km2tODDbEewJ2pIfLCB3w47mEclMM8294WAF6/QP4sUuskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535540; c=relaxed/simple;
	bh=XI4KEjwc5j4/I+kRtNkMrDkM084yZDfXeAssulR6jBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mRkfdONrF/4A/cv61NcQx1cDbGuo7uUcVJGL0wk1vTNuZBBvtcz8ixUoY1tn1o3pi5g4LWm5s4k5iM/cTdKvo7iQpURwztftxhYqP2iTS6L6NgcNIhJ6/FHIvdP/HY7UtGzn3xMyoxH8XuXvX4P24rPOmV3+5jliENx5Q23gGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17702433BD;
	Tue,  3 Mar 2026 10:58:53 +0000 (UTC)
Message-ID: <9dab8dd4825d2c672437f767ecf1a3e137668009.camel@hadess.net>
Subject: Re: [PATCH v3 06/18] HID: steelseries: Add ALSA sound card
 infrastructure
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:58:53 +0100
In-Reply-To: <20260227235042.410062-7-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-7-srimanachanta@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepudejjedtvdegfeefueffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg
X-GND-State: clean
X-GND-Score: -100

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Register an ALSA sound card for each supported Arctis headset to
> expose
> headset-specific audio controls to userspace. The card is created in
> steelseries_snd_register() and freed in steelseries_snd_unregister(),
> both guarded by a module compatibility check so that registration
> only
> occurs when both SND and HID_STEELSERIES are built-in or are both
> modules, avoiding a dependency mismatch.

This seems pretty weird, are there examples of that pattern somewhere
else in the kernel source tree?

As we're adding new sound devices, it would probably be nice to CC: the
linux-sound@ mailing-list for their opinion.

>=20
> The Kconfig entry is updated to add SND as a dependency. Subsequent
> commits build on this infrastructure to register mixer controls.
>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/hid/hid-steelseries.c | 52
> +++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 29f05d4b7e30..fcdb5406159a 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1139,7 +1139,7 @@ config STEAM_FF
> =C2=A0
> =C2=A0config HID_STEELSERIES
> =C2=A0	tristate "Steelseries devices support"
> -	depends on USB_HID
> +	depends on USB_HID && SND
> =C2=A0	help
> =C2=A0	Support for Steelseries SRW-S1 steering wheel, and the
> Steelseries
> =C2=A0	Arctis headset family (Arctis 1, Arctis 7, Arctis 7+, Arctis
> 9,
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-
> steelseries.c
> index d8ece8449255..b7f932cde98d 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -16,6 +16,7 @@
> =C2=A0#include <linux/power_supply.h>
> =C2=A0#include <linux/workqueue.h>
> =C2=A0#include <linux/spinlock.h>
> +#include <sound/core.h>
> =C2=A0
> =C2=A0#include "hid-ids.h"
> =C2=A0
> @@ -50,6 +51,8 @@ struct steelseries_device {
> =C2=A0	u8 battery_capacity;
> =C2=A0	bool battery_charging;
> =C2=A0
> +	struct snd_card *card;
> +
> =C2=A0	spinlock_t lock;
> =C2=A0	bool removed;
> =C2=A0};
> @@ -830,6 +833,43 @@ static int steelseries_battery_register(struct
> steelseries_device *sd)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +#if IS_BUILTIN(CONFIG_SND) || \
> +	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
> +
> +static int steelseries_snd_register(struct steelseries_device *sd)
> +{
> +	struct hid_device *hdev =3D sd->hdev;
> +	int ret;
> +
> +	ret =3D snd_card_new(&hdev->dev, -1, "SteelSeries",
> THIS_MODULE,
> +			=C2=A0=C2=A0 0, &sd->card);
> +	if (ret < 0)
> +		return ret;
> +
> +	sd->card->private_data =3D sd;
> +	strscpy(sd->card->driver, "SteelSeries");
> +	strscpy(sd->card->shortname, hdev->name);
> +	snprintf(sd->card->longname, sizeof(sd->card->longname),
> +		"%s at USB %s", hdev->name, dev_name(&hdev->dev));
> +
> +	ret =3D snd_card_register(sd->card);
> +	if (ret < 0) {
> +		snd_card_free(sd->card);
> +		sd->card =3D NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void steelseries_snd_unregister(struct steelseries_device
> *sd)
> +{
> +	if (sd->card)
> +		snd_card_free(sd->card);
> +}
> +
> +#endif
> +
> =C2=A0static int steelseries_raw_event(struct hid_device *hdev,
> =C2=A0				 struct hid_report *report, u8
> *data, int size)
> =C2=A0{
> @@ -975,6 +1015,13 @@ static int steelseries_probe(struct hid_device
> *hdev,
> =C2=A0				hid_warn(hdev, "Failed to register
> battery: %d\n", ret);
> =C2=A0		}
> =C2=A0
> +#if IS_BUILTIN(CONFIG_SND) || \
> +	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
> +		ret =3D steelseries_snd_register(sd);
> +		if (ret < 0)
> +			hid_warn(hdev, "Failed to register sound
> card: %d\n", ret);
> +#endif
> +
> =C2=A0		INIT_DELAYED_WORK(&sd->status_work,
> steelseries_status_timer_work_handler);
> =C2=A0		schedule_delayed_work(&sd->status_work,
> msecs_to_jiffies(100));
> =C2=A0
> @@ -1048,6 +1095,11 @@ static void steelseries_remove(struct
> hid_device *hdev)
> =C2=A0				hid_set_drvdata(sibling, NULL);
> =C2=A0		}
> =C2=A0
> +#if IS_BUILTIN(CONFIG_SND) || \
> +	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
> +		steelseries_snd_unregister(sd);
> +#endif
> +
> =C2=A0		spin_lock_irqsave(&sd->lock, flags);
> =C2=A0		sd->removed =3D true;
> =C2=A0		spin_unlock_irqrestore(&sd->lock, flags);
