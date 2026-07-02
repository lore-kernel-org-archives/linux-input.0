Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070273BCD01
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031806; cv=none; b=aBIbUPe9xxGpeq17IB3eG7DEwMKW3masvbLIthQkrSMl/HXdT6LmncHHIdJXt94+HJVn3xKOgjJyAbcQGBpHEWOMs3D6SsI9C276BKiaYVgXxEg9JhduyN0fHdG7/nNZZJ+dU17bSx7rGJX2YFOvYJJE2K4Py1K9urN6wY8bQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031806; c=relaxed/simple;
	bh=juTCn1j72a/F20f3eRhi5e9Nn1tdL6PwSVSykUO5yN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R2vde/GwhX9l2xBCCy3jbEzNS/xX5+oYOpa9NqOjZBeVGlT/X9Vy7WY87nC55A0N+LcFKc+B/d90vTHvG/JZDC4ikEgrIpmcvryO0dtK595I/8NSeVexAXeQftSmk5SkdB8JCRh2uN8O8z/dSmc94vWM2oDYO+0SszLgOiqSXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U64HT97b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U64HT97b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95431F000E9;
	Thu,  2 Jul 2026 22:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031802;
	bh=RwD33THAIy/OXo4m8bdXOCckqY8wkDzBN8QNtmJOPjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U64HT97b+zDlmdZLqM8lwub6rri8KRWIohzcWNZTe3stA9gF177Rqah1WO3eqH30h
	 aZidjoktl8yv7bnz1YaZR8XKM1WxVAFZ3ATX0Ff1JKczhsBl4494877MrGe1N10jPc
	 OjmmtjSBmyKXf2PwtEVFWtgXgUna59oeP0XBmzEbOFDhA4tX/xOAwlC3My++enuJFB
	 k5FwBuOdw0QC710ELOn0Ha6BKd5glOfuSGjyyYkKz1f8dnbuJkR9RIrTsI06V3CHLs
	 YlntJzE0WQRagYu05fbk56wklCvikv1bQgkAgcYBG4BnGopF/amHK0ZqlcAJddlf8t
	 wpjUAQIepi9Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] HID: steam: Add support for sensor events on the
 Steam Controller (2015)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702222145.1863104-4-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:36:41 +0000
Message-Id: <20260702223641.E95431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] `steam_get_attributes()` incorrectly parses the device attribute=
s payload due to a wrong buffer offset and incorrect loop bounds, misinterp=
reting the report header as payload data.

Pre-existing issues:
- [High] Concurrent execution of device registration due to an unprotected =
race between `steam_probe` and `steam_work_connect_cb` leads to double allo=
cation and a memory leak of input devices.
- [High] If `steam_register` fails, the device remains in the global `steam=
_devices` list, leading to a Use-After-Free when the memory is freed by dev=
res.
--

commit 73cdd9e51b7293cba488d76f23eb3d6d1d4ca204
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Add support for sensor events on the Steam Controller (2015)
   =20
Sensor support was added for the Steam Deck previously, but Steam
Controller sensor events were never added. This adds that missing support,
bringing Steam Controller support much closer to feature parity with things
like SDL and Steam itself.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index add9f4f27fff9..34653ad383ac0 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -468,6 +500,38 @@ static int steam_get_serial(struct steam_device *ste=
am)
>  	return ret;
>  }
> =20
> +static int steam_get_attributes(struct steam_device *steam)
> +{
> +	int ret =3D 0;
> +	u8 cmd[] =3D {ID_GET_ATTRIBUTES_VALUES, 0};
> +	u8 reply[64] =3D {};
> +	u8 size;
> +	int i;
> +	struct steam_controller_attribute *attr;
> +
> +	guard(mutex)(&steam->report_mutex);
> +	ret =3D steam_send_report(steam, cmd, sizeof(cmd));
> +	if (ret < 0)
> +		return ret;
> +	ret =3D steam_recv_report(steam, reply, sizeof(reply));
> +	if (ret < 0)
> +		return ret;
> +	if (reply[0] !=3D ID_GET_ATTRIBUTES_VALUES || reply[1] < 2)
> +		return -EIO;
> +
> +	size =3D min(reply[1], sizeof(reply) - 2);
> +	for (i =3D 0; i + sizeof(*attr) <=3D size; i +=3D sizeof(*attr)) {
> +		attr =3D (struct steam_controller_attribute *)&reply[i];

[Severity: Medium]
Does this code incorrectly parse the device attributes payload?

The iteration starts at index 0, which is the message ID reply[0], instead
of index 2 where the payload actually begins.

Also, the size check relies on reply[1] but misses the +2 offset for the
header.

Will this misread the header as payload data and fail to extract attributes
like ATTRIB_CONNECTION_INTERVAL_IN_US?

> +		if (attr->tag =3D=3D ATTRIB_CONNECTION_INTERVAL_IN_US) {
> +			steam->sensor_update_rate_us =3D get_unaligned_le32(&attr->value);
> +			hid_dbg(steam->hdev, "Sensor update rate: %uus\n",
> +				steam->sensor_update_rate_us);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
[ ... ]
> @@ -839,9 +939,6 @@ static int steam_sensors_register(struct steam_device=
 *steam)
>  	struct input_dev *sensors;
>  	int ret;
> =20
> -	if (!(steam->quirks & STEAM_QUIRK_DECK))
> -		return 0;
> -
>  	rcu_read_lock();
>  	sensors =3D rcu_dereference(steam->sensors);
>  	rcu_read_unlock();

[Severity: High]
This is a pre-existing issue, but does steam_input_register() have a race
condition that leaks memory?

Looking at steam_input_register() (and steam_sensors_register() as well), t=
he
check for an existing input device is not protected by a lock:

	rcu_read_lock();
	input =3D rcu_dereference(steam->input);
	rcu_read_unlock();
	if (input) {
		dbg_hid("%s: already connected\n", __func__);
		return 0;
	}

	input =3D input_allocate_device();

If a wired Steam controller sends a wireless connection event
(ID_CONTROLLER_WIRELESS) immediately after its hardware is started in
steam_probe(), steam_work_connect_cb() is queued and runs concurrently with
the rest of steam_probe().

Can both threads enter steam_register() and steam_input_register(), see a
NULL pointer, and allocate/register the input device twice?

[ ... ]
> @@ -968,6 +1077,12 @@ static int steam_register(struct steam_device *stea=
m)
>  			strscpy(steam->serial_no, "XXXXXXXXXX",
>  					sizeof(steam->serial_no));
> =20
> +		ret =3D steam_get_attributes(steam);
> +		if (ret < 0)
> +			hid_err(steam->hdev,
> +				"%s:steam_get_attributes failed with error %d\n",
> +				__func__, ret);
> +

[Severity: High]
This is a pre-existing issue, but does the error handling in steam_probe()
leak the device in the global steam_devices list?

When steam_register() is called, it adds the device to the global list:

	mutex_lock(&steam_devices_lock);
	if (list_empty(&steam->list))
		list_add(&steam->list, &steam_devices);
	mutex_unlock(&steam_devices_lock);

If a subsequent step in steam_register() fails (like input_allocate_device()
failing due to memory pressure), it returns an error but leaves the device =
in
the list.=20

Then in steam_probe():

	ret =3D steam_register(steam);
	if (ret) {
		hid_err(hdev,
			"%s:steam_register failed with error %d\n",
			__func__, ret);
		goto err_hw_close;
	}

The error handling path skips the err_steam_unregister label. The driver co=
re
frees the devres-managed steam_device, leaving a dangling pointer in the
steam_devices list.=20

Could subsequent iterations of this list (like when writing to the lizard_m=
ode
module parameter) dereference the freed pointer and cause a Use-After-Free?

>  		hid_info(steam->hdev, "Steam Controller '%s' connected",
>  				steam->serial_no);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702222145.1863=
104-1-vi@endrift.com?part=3D4
