Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793018175;
	b=z51BN7TdXU+5CvVZnLkvjTIL1koZdgGYeE0D3RwLYkzfEsBhfv3UsH48QOAvtINatkpY
	 GR+1s1tKNK6x0yuQym0aimhLKlB7GSR7r+iKFJ/Thh5Z08GFAaU0zVoLqVN8pEU4yyFOI
	 Qp2KHy/0A4XACkRQCn4FYxT1Ndc/aoEU+VAVQKdtbOdkDD1hRj4p2vV3c1/OEWB87++pk
	 66eGn6Xab38X6HnKdDT9do6fwQODXnNMbcddoSrQAzPha3v+Q01cquyRktlgtAA6TgXJR
	 ckmLCd8i4s958lC3EUsu/WNfK/b6RIUmnOIVPwe/+vBpLRk0XdQnDCHP4wRosKR2T9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7VLI3MrYaJc/k8ZV5H7RuBNVRxHYklOU2JdIdsau6rw=;
	b=vVG9d8aQKZTseuG87KO9+C2qiF4c6YGy6dcJjpptRWKr8cp2MgrznYFOEBtxztPCCft6
	 BUWY9rCsb0fw4P1yq0tf5Qyc/jUFWrK92SfzaXpgq41BxcgufNHHlyqwPlfCSV1gqErQ/
	 uDcefuuLweeo1kATkPMSoEpKZJe9RoAJZnZPQ0ahyaXm/IyVIGIHIaWBUMoXYGME0/i/K
	 v4pgAZvhCaSYdaaX4yTan1C4V6rzW/t+LGX1VV427JS+XxfghVP8tY+gH21/hHvXV0gDc
	 G+LYzLs1LakzEvGtOsQxAEIX2/H5lyOhQolDe8r59QVqhRrapg2lkNof5NiCgqSP/Zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=YF4Ejih1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F21606A31A;
	Mon, 26 Oct 2026 12:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F21606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=YF4Ejih1
Received: from hillosipuli.retiisi.eu (n18ws8cotq5gnfn8-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:0:19f:4ce7:0:938c:d2f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4jCtQb6rKgz49PwG;
	Mon, 26 Oct 2026 14:36:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1793018169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VLI3MrYaJc/k8ZV5H7RuBNVRxHYklOU2JdIdsau6rw=;
	b=YF4Ejih11b3PY5hrO3F65+VanSe7WNCkiuX5oo2GYxXO5j9+qyOHzN1mnMLhw5T5gQ8mO1
	rYpru7gsAtmH63JavkTfoHmG8uBiumRFw+KCfJwXC1+oOdkOFCG9HQJPGKOfPdOMNpIJ2A
	N3sFN77xLa4tRTaFQ8zyyNiSbQlAbAtlnG32m/2Sc/50p5zdAKYap9+BPmgv1oNj7HHaUB
	Uu6l7V+oJbIuk1uDlv9Dgx/iUhtqp33AljU1rJINZ6fJ07v5vC+qFMIh0uDldlFRB5SdLx
	nzV8+TXb6F8+ob0vJfbXn5pWYc+OkOiGKwBrBUmvTcdtdgUsIdH5W5dZb9UQZw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1793018169;
	b=T49IlUyH5Ip2lfX02UqKKwJV69myElM0IAPCgZiDGBnz6Knw6NKYonQmI+xgMVYsEaI3Tp
	DDw+49WiOWKBMD38+dyWUWWzmtT2+JZXlvSpP1vE6m/G42ge839AYqloaWOUNM0gabt275
	SBm4aETwW3oZJN6Um2ij+hqpa8TXXw0suuZxJjup+AknDy+m/U18obxiJu4XwcTvq5jDJg
	g12CLDklTcqTr4T6xDWn1RjwcCRQHzu/fjrYsqYtZNlqaRoAghFnlAZMBLDLOgGsbwUD+O
	2U9uz0cNMhnjqXH/n6tRoSniJXVJ5MDm+ptQA1l9j9h2hHnPTlwsdvDNSJJW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1793018169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VLI3MrYaJc/k8ZV5H7RuBNVRxHYklOU2JdIdsau6rw=;
	b=r1dXWpvgrOa/bngb5+zgCumVJ/JuHh5uqIyUZMY3nUW7BjrXoSmiRv10SvpjByrL9PyKYo
	uzDb7lNQfIY2lx5f3gqN6utYsUdSAsROy1Di1fYiMc/A7RpEr6WXXOvATgp6mn3rNjmBNA
	4TJ5E19kR3bsVFpxZplDzRH/PZt/DhjQxfCQNnI6W/XsVRYHyj+1SssZgh5PAWkQw2XkjA
	pRqlKdA6yWzlLJBbRn8CzSy4YV6raWL8116McxbozU5YlOVO2aBf1OBn/s6xi3+3Xb5cDF
	q5lHTu1eItfn1t1EmKfHvxlGxyS05A17WmrF3WM3XhydrTdSIi6PCqUgKFHQNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 21C34634C4E;
	Mon, 26 Oct 2026 14:36:07 +0200 (EET)
Date: Mon, 26 Oct 2026 14:36:06 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
	Mateusz Schwartz <matthew.schwartz@linux.dev>,
	Denis Benato <benato.denis96@gmail.com>,
	Jonathan LoBue <jlobue10@gmail.com>,
	Khamunetri Clark <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Rebecca Mara =?iso-8859-1?Q?M=FCller?= <rebecca.mara@posteo.de>,
	Ivan Levchenko <me@livan.pro>,
	Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v11 08/18] HID: asus: add support to force feedback
Message-ID: <at9JNgMf8EZdCHEh@valkosipuli.retiisi.eu>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-9-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025235232.129945-9-denis.benato@linux.dev>

Hi Denis,

I tested this on Asus T100TA, it seems to work fine.

Please see my other comments below.

On Sun, Oct 25, 2026 at 11:52:21PM +0000, Denis Benato wrote:
> Unlike ROG ally the X version and following ones uses DInput protocol
> and the force feedback needs to be implemented as its protocol is
> vendor-specific, therefore add support for FF_RUMBLE with magnitude
> scaling on a work-queue based approach to avoid using possibly
> sleeping calls in atomic context.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
> Signed-off-by: Luke Jones <luke@ljones.dev>
> ---
>  drivers/hid/Kconfig    |   1 +
>  drivers/hid/hid-asus.c | 321 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 297 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2481bc01c435..042e3bb0d817 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -189,6 +189,7 @@ config HID_ASUS
>  	depends on USB_HID
>  	depends on LEDS_CLASS
>  	depends on ASUS_WMI || ASUS_WMI=n
> +        select INPUT_FF_MEMLESS

Tabs, please.

>  	select POWER_SUPPLY
>  	help
>  	Support for Asus notebook built-in keyboard and touchpad via i2c, and
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e1883ee20413..a3a21a1493aa 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -244,6 +244,23 @@ struct ally_config {
>   */
>  static struct ally_config *ally_config;
>  
> +/* XInput force-feedback report (output report 0x0d, gamepad interface) */
> +struct ff_data {
> +	u8 enable;
> +	u8 magnitude_left;
> +	u8 magnitude_right;
> +	u8 magnitude_strong;
> +	u8 magnitude_weak;
> +	u8 pulse_sustain_10ms;
> +	u8 pulse_release_10ms;
> +	u8 loop_count;
> +} __packed;
> +
> +struct ff_report {
> +	u8 report_id;
> +	struct ff_data ff;
> +} __packed;
> +
>  struct ally_handheld {
>  	/* All read/write to IN interfaces must lock */
>  	struct mutex intf_mutex;
> @@ -269,6 +286,13 @@ struct ally_handheld {
>  	bool ally_x_probe_in_progress;
>  	bool keyboard_probe_in_progress;
>  
> +	struct ff_report ff_packet;
> +	struct work_struct ff_work;
> +	/* Serializes ff_packet and update_ff between play_effect and ff_work */
> +	spinlock_t ff_lock;
> +	bool ff_work_initialized;
> +	bool update_ff;

Arranging these with the rest of the bools would save some memory.

> +
>  	struct hid_device *keyboard_hdev;
>  	struct input_dev *keyboard_input;
>  
> @@ -384,10 +408,15 @@ enum ally_command_codes {
>  	CMD_SET_ANTI_DEADZONE           = 0x18,
>  };
>  
> +/* XInput rumble magnitudes use the hardware's 0..100 intensity range. */
> +#define ALLY_FF_MAX_INTENSITY 100
> +
>  static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
>  	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
>  };
>  
> +static_assert(sizeof(struct ff_report) == sizeof(ALLY_FORCE_FEEDBACK_OFF));
> +
>  /*
>   * The ROG Ally device presents multiple USB interfaces (keyboard, mouse, gamepad,
>   * and custom configuration interface) that bind to the same module. Since only
> @@ -395,6 +424,7 @@ static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
>   * ally_handheld structure to share state across these separate HID interfaces.
>   */
>  static void ally_resume_work_fn(struct work_struct *work);
> +static void ally_x_ff_work_fn(struct work_struct *work);
>  
>  /*
>   * Changes to ally_drvdata must lock: the raw_event callbacks, which may
> @@ -410,6 +440,13 @@ static struct ally_handheld ally_drvdata = {
>  	 */
>  	.resume_work = __DELAYED_WORK_INITIALIZER(ally_drvdata.resume_work,
>  						  ally_resume_work_fn, 0),
> +	/*
> +	 * Initialised statically for the same reason as resume_work: remove()
> +	 * drains the work whichever of the interfaces probed or failed to
> +	 * probe, so it must be safe to cancel unconditionally.
> +	 */
> +	.ff_work = __WORK_INITIALIZER(ally_drvdata.ff_work, ally_x_ff_work_fn),
> +	.ff_lock = __SPIN_LOCK_UNLOCKED(ally_drvdata.ff_lock),
>  };
>  
>  /*
> @@ -2425,7 +2462,8 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
>  	 * create them, so a device without those capabilities does not
>  	 * trigger a "not found" warning.
>  	 */
> -	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
> +	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
> +	    cfg->resp_curve_support) {
>  		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
>  			sysfs_remove_group(&hdev->dev.kobj,
>  					   ally_cal_attr_groups[i]);
> @@ -2611,6 +2649,106 @@ static void ally_x_input_close(struct input_dev *dev)
>  	hid_hw_close(input_get_drvdata(dev));
>  }
>  
> +/**
> + * ally_x_send_ff_report() - Send a force-feedback report to the gamepad
> + * @hdev: HID device
> + * @buf: buffer containing the report to send
> + * @len: length of the report
> + *
> + * The gamepad interface consumes force-feedback packets as output reports,
> + * unlike the config interface which expects feature reports: a rumble packet
> + * sent as HID_REQ_SET_REPORT would be rejected by the hardware.
> + *
> + * The caller must hold ally->intf_mutex, so that a send cannot race with
> + * the gamepad interface being unbound and its transport being stopped.
> + *
> + * Return: count of data transferred, negative if error
> + */
> +static int ally_x_send_ff_report(struct hid_device *hdev,
> +				 const u8 *buf, size_t len)
> +{
> +	u8 *dmabuf __free(kfree) = kmemdup(buf, len, GFP_KERNEL);

It's not very nice to assign variables and then check for errors. I'd thus
separate the declaration and the assignment.

> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	return hid_hw_output_report(hdev, dmabuf, len);
> +}
> +
> +static int ally_x_send_ff_off(struct hid_device *hdev)
> +{
> +	return ally_x_send_ff_report(hdev, ALLY_FORCE_FEEDBACK_OFF,
> +				     sizeof(ALLY_FORCE_FEEDBACK_OFF));
> +}
> +
> +static void ally_x_ff_work_fn(struct work_struct *work)
> +{
> +	struct ally_handheld *ally =
> +		container_of(work, struct ally_handheld, ff_work);
> +	struct hid_device *hdev = NULL;
> +	struct ff_report report;
> +	unsigned long flags;
> +	bool update = false;
> +	int ret;
> +
> +	scoped_guard(spinlock_irqsave, &ally->ff_lock) {
> +		if (ally->update_ff) {
> +			report = ally->ff_packet;
> +			ally->update_ff = false;
> +			update = true;
> +		}

		} else {
			return;
		}

And you could omit update?

> +	}
> +
> +	if (!update)
> +		return;
> +
> +	/*
> +	 * The hdev pointer is published and cleared under ally_data_lock:
> +	 * take a reference on it so the gamepad interface cannot be freed
> +	 * under us while the report is being sent.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	hdev = ally->ally_x_hdev;
> +	if (hdev)
> +		get_device(&hdev->dev);
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (!hdev)
> +		return;
> +
> +	/* Serialize with the interface removal paths and other senders. */
> +	scoped_guard(mutex, &ally->intf_mutex) {
> +		ret = ally_x_send_ff_report(hdev, (u8 *)&report,
> +					    sizeof(report));
> +		if (ret < 0)
> +			hid_err(hdev, "Failed to send force-feedback: %d\n",
> +				ret);
> +	}
> +
> +	put_device(&hdev->dev);
> +}
> +
> +static int ally_x_play_effect(struct input_dev *idev, void *data,
> +			      struct ff_effect *effect)
> +{
> +	struct ally_handheld *ally = &ally_drvdata;
> +
> +	if (effect->type != FF_RUMBLE)
> +		return 0;
> +
> +	scoped_guard(spinlock_irqsave, &ally->ff_lock) {
> +		ally->ff_packet.ff.magnitude_strong =
> +			effect->u.rumble.strong_magnitude * ALLY_FF_MAX_INTENSITY / 65535;
> +		ally->ff_packet.ff.magnitude_weak =
> +			effect->u.rumble.weak_magnitude * ALLY_FF_MAX_INTENSITY / 65535;
> +		ally->update_ff = true;
> +
> +		if (ally->ff_work_initialized)
> +			schedule_work(&ally->ff_work);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev)
>  {
>  	struct input_dev *input_dev = input_allocate_device();
> @@ -2674,6 +2812,36 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
>  	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
>  	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
>  
> +	memcpy(&ally->ff_packet, ALLY_FORCE_FEEDBACK_OFF, sizeof(ally->ff_packet));
> +	/*
> +	 * A play_effect() racing the previous teardown can have left the
> +	 * update latch set: a fresh interface must not inherit it, or the
> +	 * first rumble work would send a packet nobody asked for.
> +	 */
> +	ally->update_ff = false;
> +	ally->ff_work_initialized = true;
> +
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +
> +	/*
> +	 * A registered device advertising FF_RUMBLE without the memless core
> +	 * behind it would crash input_ff_upload(): fail the whole setup instead.
> +	 */
> +	ret = input_ff_create_memless(input, NULL, ally_x_play_effect);
> +	if (ret) {
> +		hid_err(hdev, "Failed to create force-feedback: %d\n", ret);
> +		goto ally_x_setup_input_err;
> +	}
> +
> +	/*
> +	 * Publish the interface before the input device becomes visible to
> +	 * userspace: an effect uploaded right after registration would
> +	 * otherwise find a NULL hdev and get dropped.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	ally->ally_x_hdev = hdev;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);

You're using scoped_guard() elsewhere in the patch but not here. Why?

There's also at least one case above, too.

> +
>  	ret = input_register_device(input);
>  	if (ret) {
>  		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
> @@ -2687,20 +2855,61 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
>  
>  	return 0;
>  ally_x_setup_input_err:
> +	/*
> +	 * Unpublish like hid_asus_ally_remove() does, intf_mutex held: the
> +	 * cross-interface senders snapshot ally_x_hdev under ally_data_lock
> +	 * and send under intf_mutex, so the unpublish must take both in the
> +	 * same order to keep the handshake meaningful.
> +	 */
> +	scoped_guard(mutex, &ally->intf_mutex) {
> +		spin_lock_irqsave(&ally_data_lock, flags);
> +		if (ally->ally_x_hdev == hdev)
> +			ally->ally_x_hdev = NULL;
> +		spin_unlock_irqrestore(&ally_data_lock, flags);

This gets interesting. :-)

> +	}
> +
>  	input_free_device(input);
>  	return ret;
>  }
>  
>  static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
>  {
> +	struct hid_device *x_hdev;
>  	struct ally_config *cfg;
> +	unsigned long flags;
>  	int ret;
>  
> -	/* Failure at this point is non-critical */
> -	ret = ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
> -				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
> -	if (ret < 0)
> -		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> +	/*
> +	 * Snapshot the gamepad interface and send the force-feedback "off"
> +	 * packet through it. usbhid_stop() frees urbout before NULLing it
> +	 * while usbhid_output_report() dereferences it unlocked, so a send
> +	 * overlapping the transport teardown would be a use-after-free: the
> +	 * device lock is taken around the send because the HID core holds
> +	 * it across remove() and the hid_hw_stop() that follows, making the
> +	 * two mutually exclusive. It is taken before intf_mutex, the same
> +	 * order the core's remove path uses, so no lock inversion exists.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	x_hdev = ally->ally_x_hdev;
> +	if (x_hdev)
> +		get_device(&x_hdev->dev);
> +	spin_unlock_irqrestore(&ally_data_lock, flags);

Here, too.

> +
> +	if (x_hdev) {
> +		/* Failure at this point is non-critical */
> +		scoped_guard(mutex, &x_hdev->dev.mutex) {
> +			scoped_guard(mutex, &ally->intf_mutex) {
> +				ret = ally_x_send_ff_off(x_hdev);
> +
> +				if (ret < 0)
> +					hid_err(hdev,
> +						"Ally failed to init force-feedback off: %d\n",
> +						ret);
> +			}
> +		}
> +
> +		put_device(&x_hdev->dev);
> +	}
>  
>  	cfg = ally_get_config(ally);
>  	if (!cfg)
> @@ -2996,6 +3205,17 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
>  			return ERR_PTR(ret);
>  		}
>  
> +		/*
> +		 * Make sure rumble starts disabled: this is the interface that
> +		 * owns the force-feedback output report. Failure is non-critical.
> +		 */
> +		scoped_guard(mutex, &ally_drvdata.intf_mutex) {
> +			ret = ally_x_send_ff_off(hdev);
> +			if (ret < 0)
> +				hid_warn(hdev, "Failed to disable force-feedback: %d\n",
> +					 ret);
> +		}
> +
>  		spin_lock_irqsave(&ally_data_lock, flags);
>  		ally_drvdata.ally_x_hdev = hdev;
>  		ally_drvdata.ally_x_probe_in_progress = false;
> @@ -3024,6 +3244,7 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
>  	struct input_dev *x_input = NULL;
>  	struct ally_config *cfg = NULL;
>  	unsigned long flags;
> +	bool owns_xpad;
>  	bool owns_cfg;
>  
>  	if (!ally)
> @@ -3038,31 +3259,81 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
>  	cancel_delayed_work_sync(&ally->resume_work);
>  
>  	spin_lock_irqsave(&ally_data_lock, flags);
> -	if (ally->ally_x_hdev == hdev) {
> -		x_input = ally->ally_x_input;
> -		ally->ally_x_input = NULL;
> -		ally->ally_x_hdev = NULL;
> +	owns_xpad = ally->ally_x_hdev == hdev;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (owns_xpad) {
> +		/*
> +		 * Stop queueing force-feedback work before the gamepad
> +		 * pointers are cleared: play_effect() tests the flag under the
> +		 * same lock, so no work can be queued past the cancel below.
> +		 */
> +		scoped_guard(spinlock_irqsave, &ally->ff_lock)
> +			ally->ff_work_initialized = false;
> +
> +		/*
> +		 * cancel_work_sync() may sleep: keep it out of ally_data_lock,
> +		 * but run it before the pointers are cleared so in-flight work
> +		 * cannot outlive the interface it sends through.
> +		 */
> +		cancel_work_sync(&ally->ff_work);
> +
> +		/*
> +		 * The input core can no longer stop effects through the
> +		 * disabled work: quiesce any rumble still playing ourselves,
> +		 * or the device would keep vibrating after being unbound.
> +		 *
> +		 * Serialize the packet with the other force-feedback senders:
> +		 * intf_mutex is taken again below for the pointer
> +		 * unpublishing, but the two critical sections never nest.
> +		 */
> +		scoped_guard(mutex, &ally->intf_mutex) {
> +			if (ally_x_send_ff_off(hdev) < 0)
> +				hid_warn(hdev,
> +					 "Failed to stop force-feedback\n");
> +		}
>  	}
>  
>  	/*
> -	 * The keyboard interface is torn down before the config one, and
> -	 * its input_dev is freed with it. handle_ally_event() and
> -	 * ally_resume_work_fn() both report keys through it from the
> -	 * config endpoint, so drop the references here or they dangle.
> +	 * Serialize with hid_asus_ally_init(): it sends the force-feedback
> +	 * "off" packet through the gamepad interface recorded here, whose
> +	 * transport is stopped by hid_hw_stop() as soon as this function
> +	 * returns. Holding intf_mutex while the gamepad pointers are
> +	 * unpublished makes init's snapshot-and-send atomic with the
> +	 * removal: the packet either reaches a transport that is still
> +	 * running, or is not sent at all. The lock must be released before
> +	 * the sysfs teardown below, or an in-flight sysfs store blocked on
> +	 * it would deadlock against kernfs waiting for the callback.
>  	 */
> -	if (ally->keyboard_hdev == hdev) {
> -		ally->keyboard_input = NULL;
> -		ally->keyboard_hdev = NULL;
> -	}
> +	scoped_guard(mutex, &ally->intf_mutex) {
> +		spin_lock_irqsave(&ally_data_lock, flags);
> +		if (owns_xpad) {
> +			x_input = ally->ally_x_input;
> +			ally->ally_x_input = NULL;
> +			ally->ally_x_hdev = NULL;
> +		}
>  
> -	owns_cfg = ally->cfg_hdev == hdev;
> -	if (owns_cfg) {
> -		cfg = ally->config;
> -		ally->cfg_hdev = NULL;
> -		ally->config = NULL;
> -	}
> +		/*
> +		 * The keyboard interface is torn down before the
> +		 * config one, and its input_dev is freed with it.
> +		 * handle_ally_event() and ally_resume_work_fn() both
> +		 * report keys through it from the config endpoint, so
> +		 * drop the references here or they dangle.
> +		 */
> +		if (ally->keyboard_hdev == hdev) {
> +			ally->keyboard_input = NULL;
> +			ally->keyboard_hdev = NULL;
> +		}
>  
> -	spin_unlock_irqrestore(&ally_data_lock, flags);
> +		owns_cfg = ally->cfg_hdev == hdev;
> +		if (owns_cfg) {
> +			cfg = ally->config;
> +			ally->cfg_hdev = NULL;
> +			ally->config = NULL;
> +		}
> +
> +		spin_unlock_irqrestore(&ally_data_lock, flags);

Ditto.

> +	}
>  
>  	/*
>  	 * The config teardown removes sysfs groups and takes sleeping locks:

-- 
Kind regards,

Sakari Ailus
