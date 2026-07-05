Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CF3815CC
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260819; cv=none; b=Z8u4sRWQ2cFF2i4jGDPxf4wRETUEqvrSUGWxrqEqhhhqlji87tZ+q3G8miAs63+m3qN89mxSpL+bRuzZJib6Jo6nZ3J5V+6j9e1kFOpE7p4eJhQCem6TDHIxnBXBvDpcUHTlFfvlTx0Oeuw3ODGPYM6TjkOXK6R932ojdIbrs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260819; c=relaxed/simple;
	bh=mJRNqM926vwKkuddwllMBtyWv1xqZi1lKDyO6OorcVU=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=hpVK9x5RMXDbDmRNlQf6LaplCNsAdVeR+EjHBMW9CLx+Qlb09BSHhrh9Ho9qo5dSNi00J5wPPS7hKCJzEe/Xikpd7Vpm5jkc8HRejJVuAjaPicldlxte4IVRFywavKoR4oggHfEqksJGwK+dzsucKV2NHHODB5gMl0/pEmQ/Pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF8EzfYk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF8EzfYk"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47d70879764so270902f8f.2
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783260816; x=1783865616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jMqzfWbMuoMUDH9+K2rQ2irPTZ84B2fdDmtxE4nFcP4=;
        b=WF8EzfYk5yE6GQUNHvSowavb0c5aF5clJQZJ61syaND+w0sauuybssw17hPVvoMTLW
         GAYEFsIjeQ7I9VSsO4qDgMRD+vKdX3yf9r0MafQEge9GUJc46ZhukyYwsajZO7mtEOm7
         hNL65wSimAOGC9i1clBz6/UbLvF+VE1Jq5CzE4EV0RrrFGhU5C+G0kJCfp5vX2LuoSR0
         m/VN/hbg5DnUGgQJhqI4ahL2+kEvpLgwphB+EEhkf2vdX+F2oigvtSjVw70W05IMRDem
         o5ktETXNv5ZtFrQe+cFtLv5VUWQXtz7pFB/mvT8HiaxNvTSC7IIGrTdZVGio6Lik51if
         jcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260816; x=1783865616;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMqzfWbMuoMUDH9+K2rQ2irPTZ84B2fdDmtxE4nFcP4=;
        b=LfBawSehjS+XvBScHlaPIDUJ5mmmbox+s/PGgsH9YdX7ZKBi1npw8BWa6Qv1QAoR1q
         Tp/Fi8KdGo91y7P0rXP0WAPKVzHfyDo3eAl8pxUUoY3oRqI0sH8itWGiWYtXUYkdmQrJ
         otCBOb76w9wDLv9uU8aN2dFan7wbHKJr3QgsZZMa6U8pSnoXReDVZjAc9tQcXmvN7R2R
         PUY/lkzAq3HnP5DPpYH8skKtDwsBc1Hcr8fOAvnwaSm0451LR0A7FjJISAAcIFoLBi+q
         CU1nAqHRaCGG02ren8u9DmJZjxQShSFQZeEDlyjixBRgyVYoZkpjYR854UmIxSFVpFHH
         Maaw==
X-Forwarded-Encrypted: i=1; AHgh+RpmTcIAnSqHYzc5yhkb0YhGbgGdIh8SmH1Y4GjdIkyBuoJ49RNSWMfvRenDBU8HwKx3FFn02+DlQAB2FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHj0P/u2Z2SprEjRQYGMFo7A46ZZIDU4oj705lHa2XoWDZFWtE
	kLbn4UxCG0VXJAUXvLoWh+B+SdNkGfJ7RgjN8hdYjrBy5L4JWxPBRpJ9
X-Gm-Gg: AfdE7cl3UWSL2exAzF+PJn7ZjWN+N+k6rFckF/JRNXPQuA3WwNdPoFohNVk7PwQuuXI
	ZwNs0oXFJSOGOTzXpD9pt/h061XoyLDiAH/xsUQDhMBHpd0t8bQeldETw8CWLy8K0KDvTs9gT+R
	wcpWxQiWrVL4OhY49Ouu2UdSiY1FEkrZF8GO9i0Nssq+pUuXLpN0L53KwIE2XFjz47GWafOvaJa
	TVlhHEus83uxLrvFD4HfclWK4Kcg01O+g6ii95lOfcyeWRsJ+pZ+Qde+zb3XIfr9aQBaH8kh6mO
	vJYHwwc6DQm8mAqAqlFV3AM9UH5//FSBbLhye3w1ZKoNUoH38FQNF78K7xBRi2Xpg5OynadTtH5
	dLnEc4k8bLDGmO48B/K5yQDKq1bf6urZbE4NkmykAEcWhiSP8TYKVHxEhF5Oqr8suZcqgDWwQd6
	HwM7+g4dsqY2tEBQV0
X-Received: by 2002:a5d:584e:0:b0:46f:7d90:8114 with SMTP id ffacd0b85a97d-47aa978f2fdmr8117940f8f.14.1783260816266;
        Sun, 05 Jul 2026 07:13:36 -0700 (PDT)
Received: from localhost ([85.195.223.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm15821709f8f.29.2026.07.05.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 07:13:35 -0700 (PDT)
Date: Sun, 05 Jul 2026 16:13:34 +0200
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v11 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260702214704.1859350-1-vi@endrift.com>
 <20260702214704.1859350-3-vi@endrift.com>
In-Reply-To: <20260702214704.1859350-3-vi@endrift.com>
Message-Id: <39MSC7NQF6IO8.2E4BHGFFF82H4@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Heyhey!

Just one comment below.

Vicki Pfau <vi@endrift.com> wrote:
> This adds rumble support for both the "HD Rumble" linear resonant actuato=
r
> type as used in the Joy-Cons and Pro Controller, as well as the eccentric=

> rotating mass type used in the GameCube controller. Note that since there=
's
> currently no API for exposing full control of LRAs with evdev, it only
> simulates a basic rumble for now.
>=20
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
>  drivers/hid/Kconfig        |   8 +-
>  drivers/hid/hid-nintendo.c | 211 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 213 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 19c77c323ec9..851eed76c236 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -859,10 +859,10 @@ config NINTENDO_FF
>  	depends on HID_NINTENDO
>  	select INPUT_FF_MEMLESS
>  	help
> -	Say Y here if you have a Nintendo Switch controller and want to enable
> -	force feedback support for it. This works for both joy-cons, the pro
> -	controller, and the NSO N64 controller. For the pro controller, both
> -	rumble motors can be controlled individually.
> +	Say Y here if you have a Nintendo Switch or Switch 2 controller and wan=
t
> +	to enable force feedback support for it. This works for Joy-Cons, the P=
ro
> +	Controllers, and the NSO N64 and GameCube controller. For the Pro
> +	Controller, both rumble motors can be controlled individually.
> =20
>  config HID_NTI
>  	tristate "NTI keyboard adapters"
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e21c36921832..a36f4fd9a1da 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -37,6 +37,7 @@
>  #include <linux/unaligned.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/kernel.h>
>  #include <linux/hid.h>
>  #include <linux/idr.h>
> @@ -2989,6 +2990,7 @@ enum switch2_init_step {
>  	NS2_INIT_READ_USER_SECONDARY_CALIB,
>  	NS2_INIT_SET_FEATURE_MASK,
>  	NS2_INIT_ENABLE_FEATURES,
> +	NS2_INIT_ENABLE_RUMBLE,
>  	NS2_INIT_GRIP_BUTTONS,
>  	NS2_INIT_REPORT_FORMAT,
>  	NS2_INIT_INPUT,
> @@ -3020,6 +3022,18 @@ struct switch2_stick_calibration {
>  	struct switch2_axis_calibration y;
>  };
> =20
> +struct switch2_hd_rumble {
> +	uint16_t hi_freq : 10;
> +	uint16_t hi_amp : 10;
> +	uint16_t lo_freq : 10;
> +	uint16_t lo_amp : 10;
> +} __packed;
> +
> +struct switch2_erm_rumble {
> +	uint16_t error;
> +	uint16_t amplitude;
> +};
> +
>  struct switch2_controller {
>  	struct hid_device *hdev;
>  	struct switch2_cfg_intf *cfg;
> @@ -3043,8 +3057,45 @@ struct switch2_controller {
> =20
>  	uint32_t player_id;
>  	struct led_classdev *leds;
> +
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	spinlock_t rumble_lock;
> +	uint8_t rumble_seq;
> +	union {
> +		struct switch2_hd_rumble hd;
> +		struct switch2_erm_rumble sd;
> +	} rumble;
> +	uint64_t last_rumble_work;
> +	struct delayed_work rumble_work;
> +	uint8_t *rumble_buffer;
> +#endif
>  };
> =20
> +enum gc_rumble {
> +	GC_RUMBLE_OFF =3D 0,
> +	GC_RUMBLE_ON =3D 1,
> +	GC_RUMBLE_STOP =3D 2,
> +};
> +
> +/*
> + * The highest rumble level for "HD Rumble" is strong enough to potentia=
lly damage the controller,
> + * and also leaves your hands feeling like melted jelly, so we set a sem=
i-arbitrary scaling factor
> + * to artificially limit the maximum for safety and comfort. It is curre=
ntly unknown if the Switch
> + * 2 itself does something similar, but it's quite likely.
> + *
> + * This value must be between 0 and 1024, otherwise the math below will =
overflow.
> + */
> +#define RUMBLE_MAX 450u
> +
> +/*
> + * Semi-arbitrary values used to simulate the "rumble" sensation of an e=
ccentric rotating
> + * mass type haptic motor on the Switch 2 controllers' linear resonant a=
ctuator type haptics.
> + *
> + * The units used are unknown, but the values must be between 0 and 1023=
=2E
> + */
> +#define RUMBLE_HI_FREQ 0x187
> +#define RUMBLE_LO_FREQ 0x112
> +
>  static DEFINE_MUTEX(switch2_controllers_lock);
>  static LIST_HEAD(switch2_controllers);
> =20
> @@ -3136,7 +3187,7 @@ static const uint8_t switch2_init_cmd_data[] =3D {
>  static const uint8_t switch2_one_data[] =3D { 0x01, 0x00, 0x00, 0x00 };
> =20
>  static const uint8_t switch2_feature_mask[] =3D {
> -	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU,
> +	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU | NS2_FEATUR=
E_RUMBLE,
>  	0x00, 0x00, 0x00
>  };
> =20
> @@ -3209,6 +3260,125 @@ static void switch2_kref_put(struct kref *refcoun=
t)
>  	kfree(ns2);
>  }
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +static void switch2_encode_rumble(struct switch2_hd_rumble *rumble, uint=
8_t buffer[5])
> +{
> +	buffer[0] =3D rumble->hi_freq;
> +	buffer[1] =3D (rumble->hi_freq >> 8) | (rumble->hi_amp << 2);
> +	buffer[2] =3D (rumble->hi_amp >> 6) | (rumble->lo_freq << 4);
> +	buffer[3] =3D (rumble->lo_freq >> 4) | (rumble->lo_amp << 6);
> +	buffer[4] =3D rumble->lo_amp >> 2;
> +}
> +
> +static int switch2_play_effect(struct input_dev *dev, void *data, struct=
 ff_effect *effect)
> +{
> +	struct switch2_controller *ns2 =3D input_get_drvdata(dev);

We might want to check ns2 for NULL here (like we do in
switch2_player_led_brightness_set).

Cheers,
Silvan

> +	unsigned long flags;
> +
> +	if (effect->type !=3D FF_RUMBLE)
> +		return 0;
> +
> +	spin_lock_irqsave(&ns2->rumble_lock, flags);
> +	if (ns2->ctlr_type =3D=3D NS2_CTLR_TYPE_GC) {
> +		ns2->rumble.sd.amplitude =3D max(effect->u.rumble.strong_magnitude,
> +			(uint16_t) (effect->u.rumble.weak_magnitude >> 1));
> +	} else {
> +		ns2->rumble.hd.hi_freq =3D RUMBLE_HI_FREQ;
> +		ns2->rumble.hd.lo_freq =3D RUMBLE_LO_FREQ;
> +		ns2->rumble.hd.hi_amp =3D effect->u.rumble.weak_magnitude * RUMBLE_MAX=
 >> 16;
> +		ns2->rumble.hd.lo_amp =3D effect->u.rumble.strong_magnitude * RUMBLE_M=
AX >> 16;
> +	}
> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
> +
> +	schedule_delayed_work(&ns2->rumble_work, 0);
> +
> +	return 0;
> +}
> +
> +static void switch2_rumble_work(struct work_struct *work)
> +{
> +	struct switch2_controller *ns2 =3D container_of(to_delayed_work(work),
> +						      struct switch2_controller, rumble_work);
> +	unsigned long flags;
> +	bool active;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&ns2->rumble_lock, flags);
> +	ns2->rumble_buffer[0x1] =3D 0x50 | ns2->rumble_seq;
> +	if (ns2->ctlr_type =3D=3D NS2_CTLR_TYPE_GC) {
> +		ns2->rumble_buffer[0] =3D 3;
> +		if (ns2->rumble.sd.amplitude =3D=3D 0) {
> +			ns2->rumble_buffer[2] =3D GC_RUMBLE_STOP;
> +			ns2->rumble.sd.error =3D 0;
> +			active =3D false;
> +		} else {
> +			if (ns2->rumble.sd.error < ns2->rumble.sd.amplitude) {
> +				ns2->rumble_buffer[2] =3D GC_RUMBLE_ON;
> +				ns2->rumble.sd.error +=3D U16_MAX - ns2->rumble.sd.amplitude;
> +			} else {
> +				ns2->rumble_buffer[2] =3D GC_RUMBLE_OFF;
> +				ns2->rumble.sd.error -=3D ns2->rumble.sd.amplitude;
> +			}
> +			active =3D true;
> +		}
> +	} else {
> +		ns2->rumble_buffer[0] =3D 1;
> +		switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x2]);
> +		active =3D ns2->rumble.hd.hi_amp || ns2->rumble.hd.lo_amp;
> +		if (ns2->ctlr_type =3D=3D NS2_CTLR_TYPE_PRO) {
> +			/*
> +			 * The Pro Controller contains separate LRAs on each
> +			 * side that can be controlled individually.
> +			 */
> +			ns2->rumble_buffer[0] =3D 2;
> +			ns2->rumble_buffer[0x11] =3D 0x50 | ns2->rumble_seq;
> +			switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x12]);
> +		}
> +	}
> +	ns2->rumble_seq =3D (ns2->rumble_seq + 1) & 0xF;
> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
> +
> +	if (active) {
> +		unsigned long interval =3D msecs_to_jiffies(4);
> +		uint64_t current_jiffies =3D get_jiffies_64();
> +
> +		if (!ns2->last_rumble_work)
> +			ns2->last_rumble_work =3D current_jiffies;
> +		else
> +			ns2->last_rumble_work +=3D interval;
> +
> +		/* Reschedule a little early to make sure the buffer never underruns *=
/
> +		interval -=3D msecs_to_jiffies(2);
> +		if (ns2->last_rumble_work + interval >=3D current_jiffies)
> +			schedule_delayed_work(&ns2->rumble_work,
> +				ns2->last_rumble_work + interval - current_jiffies);
> +		else
> +			schedule_delayed_work(&ns2->rumble_work, 0);
> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}
> +
> +	mutex_lock(&ns2->lock);
> +	if (!ns2->hdev) {
> +		cancel_delayed_work(&ns2->rumble_work);
> +	} else {
> +		ret =3D hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
> +		/*
> +		 * Don't log on ENODEV, ESHUTDOWN, or EPROTO, which can happen
> +		 * mid-hotplug. Also cancel any further work on ENODEV or
> +		 * ESHUTDOWN as they're clear indications that the endpoint
> +		 * is dead.
> +		 */
> +		if (ret =3D=3D -ENODEV || ret =3D=3D -ESHUTDOWN)
> +			cancel_delayed_work(&ns2->rumble_work);
> +		else if (ret < 0 && ret !=3D -EPROTO)
> +			hid_warn_ratelimited(ns2->hdev,
> +				"Failed to send output report ret=3D%d\n", ret);
> +	}
> +	mutex_unlock(&ns2->lock);
> +}
> +#endif
> +
>  static int switch2_set_leds(struct switch2_controller *ns2)
>  {
>  	int i;
> @@ -3332,6 +3502,26 @@ static int switch2_init_input(struct switch2_contr=
oller *ns2)
>  		return -EINVAL;
>  	}
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	ns2->rumble_buffer =3D devm_kzalloc(&input->dev, 64, GFP_KERNEL);
> +	if (!ns2->rumble_buffer) {
> +		input_free_device(input);
> +		return -ENOMEM;
> +	}
> +	ret =3D devm_delayed_work_autocancel(&input->dev, &ns2->rumble_work, sw=
itch2_rumble_work);
> +	if (ret < 0) {
> +		input_free_device(input);
> +		return ret;
> +	}
> +
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +	ret =3D input_ff_create_memless(input, NULL, switch2_play_effect);
> +	if (ret) {
> +		input_free_device(input);
> +		return ret;
> +	}
> +#endif
> +
>  	hid_info(ns2->hdev, "Firmware version %u.%u.%u (type %i)\n", ns2->versi=
on.major,
>  		ns2->version.minor, ns2->version.patch, ns2->version.ctlr_type);
>  	if (ns2->version.dsp_type >=3D 0)
> @@ -3765,7 +3955,16 @@ int switch2_init_controller(struct switch2_control=
ler *ns2)
>  		return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_SET_=
MASK,
>  			switch2_feature_mask, sizeof(switch2_feature_mask), ns2->cfg);
>  	case NS2_INIT_ENABLE_FEATURES:
> -		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS | NS2_FEATURE_=
ANALOG);
> +		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS |
> +			NS2_FEATURE_ANALOG | NS2_FEATURE_RUMBLE);
> +	case NS2_INIT_ENABLE_RUMBLE:
> +		/*
> +		 * It is unclear what this packet is supposed to be for, but it
> +		 * appears to be needed for rumble to work reliably. The reply
> +		 * data indicates it might be a query of some sort, but we
> +		 * ignore the reply so long as it doesn't return an error.
> +		 */
> +		return ns2->cfg->send_command(0x11, 1, NULL, 0, ns2->cfg);
>  	case NS2_INIT_GRIP_BUTTONS:
>  		if (!switch2_ctlr_is_joycon(ns2->ctlr_type)) {
>  			switch2_init_step_done(ns2, ns2->init_step);
> @@ -3878,6 +4077,10 @@ int switch2_receive_command(struct switch2_control=
ler *ns2,
>  			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
>  		}
>  		break;
> +	case 0x11:
> +		if (header->subcommand =3D=3D 1)
> +			switch2_init_step_done(ns2, NS2_INIT_ENABLE_RUMBLE);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -3997,6 +4200,10 @@ static int switch2_probe(struct hid_device *hdev, =
const struct hid_device_id *id
>  	else
>  		ns2->player_id =3D ret;
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	spin_lock_init(&ns2->rumble_lock);
> +#endif
> +
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>  	if (ret) {
>  		hid_err(hdev, "hw_start failed %d\n", ret);


