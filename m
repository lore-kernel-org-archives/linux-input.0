Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777782;
	b=rtBh9ny29YuFH5L+j/MCkkr9lHTwi3fsgMZ1v9ONJpDX41xkbB3DZ1QO3QWopw4I6wvi
	 Jpiu6uuFafvbOaEcE6Xrb6krVsta80F/xqQE1lxTBoReyG1IITqzMgPvBXA5M8wYxokkm
	 8WygrEqbgDSGsASC+oc86+lXOL0YXpszHR1w3IrE3uYf/cslBzjoRiIIyvps2AIBvLyxY
	 F10JFLBcGpMjld4eGMwP6Ut7EmBklzDUgk70vxwGnqyF4F8a8TqCuag2nKAlunv2LUBHP
	 b2qwJkNMOqwNXy2Az90O0JcKglTzEE+vitKShSBBrfzAQzR0evsE3DhhCJ9mWKI7uNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l47Ex4OwVhgo+4q9SioR7Byv1uWcW2l+bDLOQlrv3oA=;
	b=LxTgXdVFFoH+agqw/TBo+K9fQ8Qybbpjdgtc5jslBfBW+vIxQCFLxGKON8rBmMX8Bg3o
	 ncXfas45ZdYUQmKzx8OQ4xemqEGKTZ7rwBKXYKcyRqjeuJpzyioeBAqiKX+ruZWktNtf/
	 K9tnJrn9aLGBkoN/+MhEym9JcuCsS4yXp6c4AvsZPHM8A+iQetLKHPwI695tO+stUIPQs
	 3sPeKHgZZPF7UCOtfAdEOoRlo68gA49FiMqdJQOY08rqJbmCfkQ1g8A+8Z2jDWK1ToQQx
	 MiyVurBhqbSJ15MjGtrZoKrD+khtRSk0gJbYAkadEmq7vMFbLc/aEg21Jv9KmPjODwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuJkp4Sa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DD606A322
	for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuJkp4Sa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D85C1F01825;
	Fri, 23 Oct 2026 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777781;
	bh=l47Ex4OwVhgo+4q9SioR7Byv1uWcW2l+bDLOQlrv3oA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WuJkp4Sa1U+5ouwSwxVtfRdq86A+dBy/fvVpWhXleeQxK/h5m5hwDR/dTjsPrJgAs
	 s9JP+XjiyFoq3Npzv4HxXLg61RS2xxKox7QoBQe1fkLwT5GLW7JzI2EW6afi34di+2
	 xlbYIj//1/syyUgyCrn+suhypkWHOLyVmC3kLOARTEpLGYK6ugSIBgGp+oRIosl7p0
	 QIyMpoEnlf/Nc/lm8AURsJVgfFwTe1DbFEntIwvMzNkas+ZNO46gzktek6hjLbsL5F
	 Ii6fNsxQ88ybcjCYutCs2j2wwRE14fvYyZrVPdQzIdGq70AQ0XNVYiPFSqWpAR4fHB
	 f9kkbEMbMJLpA==
Message-ID: <sashiko-outbox-183018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: surface-hid: support keyboard backlight on Surface
 Pro Keyboard (045E:09AE)
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmFtw7NuIEplc8O6cyBNaXJhbmRh?= <ramonjesusmiranda@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261023173213.6219-1-ramonjesusmiranda@gmail.com>
References: <20261023173213.6219-1-ramonjesusmiranda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:49:41 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] HID: surface-hid: teardown race in surface_hid_device_destroy(=
) causes UAF
- [Medium] HID: surface-hid: missing LEDS_CLASS dependency causes link fail=
ure
- [Medium] HID: surface-hid: unsynchronized kbd_bl_cur access in surface_kb=
d_bl_work_fn()
- [Medium] HID: surface-hid: surface_kbd_bl_work_fn() cycles brightness on =
read error
- [Medium] HID: surface-hid: missing keyboard backlight restoration on resu=
me
--

commit 895dc904dfd7f995cd5b914b2d6be010d9b86f34
Author: Ram=C3=B3n Jes=C3=BAs Miranda <ramonjesusmiranda@gmail.com>

HID: surface-hid: support keyboard backlight on Surface Pro Keyboard (045E:=
09AE)

This commit adds keyboard backlight LED class support to surface-hid for the
Microsoft Surface Pro Keyboard (045E:09AE), mapping brightness levels 0..3 =
to
HID feature and output reports 0xd5 and 0xd6 and handling hardware brightne=
ss
cycle events on input report 0xd5.

> diff --git a/drivers/hid/surface-hid/surface_hid_core.c b/drivers/hid/sur=
face-hid/surface_hid_core.c
> index 6690c24f28f0c..afee61f9af442 100644
> --- a/drivers/hid/surface-hid/surface_hid_core.c
> +++ b/drivers/hid/surface-hid/surface_hid_core.c
> @@ -184,6 +184,98 @@ static const struct hid_ll_driver surface_hid_ll_dri=
ver =3D {
>  };
> =20
> =20
> +/* -- Keyboard backlight (Surface Pro Flex / Type Cover 045E:09AE). ----=
----- */
> +
> +static u8 surface_kbd_bl_raw_to_idx(struct surface_hid_device *shid, u8 =
raw)
> +{
> +	u8 i;
> +
> +	for (i =3D 0; i < 4; i++) {
> +		if (shid->kbd_bl_levels[i] >=3D raw)
> +			return i;
> +	}
> +	return 3;
> +}
> +
> +static enum led_brightness surface_kbd_bl_get(struct led_classdev *cdev)
> +{
> +	struct surface_hid_device *shid =3D
> +		container_of(cdev, struct surface_hid_device, kbd_bl_led);
> +	u8 buf[2] =3D { 0xd6, 0 };
> +
> +	if (surface_hid_is_hot_removed(shid))
> +		return shid->kbd_bl_cur;
> +
> +	if (shid->ops.get_feature_report(shid, 0xd6, buf, sizeof(buf)) < 0)
> +		return shid->kbd_bl_cur;
> +
> +	shid->kbd_bl_cur =3D surface_kbd_bl_raw_to_idx(shid, buf[1]);
> +	return shid->kbd_bl_cur;
> +}
> +
> +static int surface_kbd_bl_set(struct led_classdev *cdev, enum led_bright=
ness value)
> +{
> +	struct surface_hid_device *shid =3D
> +		container_of(cdev, struct surface_hid_device, kbd_bl_led);
> +	u8 idx =3D clamp_t(u8, value, 0, 3);
> +	u8 buf[2] =3D { 0xd5, shid->kbd_bl_levels[idx] };
> +	int ret;
> +
> +	if (surface_hid_is_hot_removed(shid))
> +		return -ENODEV;
> +
> +	ret =3D shid->ops.output_report(shid, 0xd5, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	shid->kbd_bl_cur =3D idx;
> +	return 0;
> +}
> +
> +static void surface_kbd_bl_work_fn(struct work_struct *work)
> +{
> +	struct surface_hid_device *shid =3D
> +		container_of(work, struct surface_hid_device, kbd_bl_work);
> +	u8 prev =3D shid->kbd_bl_cur;
> +	u8 hw_idx =3D surface_kbd_bl_get(&shid->kbd_bl_led);
> +
> +	if (hw_idx =3D=3D prev) {
> +		u8 next =3D (prev + 1) % 4;
> +
> +		surface_kbd_bl_set(&shid->kbd_bl_led, next);
> +	}
> +
> +	led_classdev_notify_brightness_hw_changed(&shid->kbd_bl_led, shid->kbd_=
bl_cur);
> +}

[Severity: Medium]
Can concurrent access to shid->kbd_bl_cur cause surface_kbd_bl_work_fn() to
advance the brightness twice on a single F5 press?

shid->kbd_bl_cur is read and updated without synchronization across
surface_kbd_bl_get(), surface_kbd_bl_set(), and surface_kbd_bl_work_fn().

If a userspace daemon reads the sysfs brightness attribute (calling
brightness_show() -> led_update_brightness() -> surface_kbd_bl_get()) after
the embedded controller increments the brightness on an F5 press, but before
surface_kbd_bl_work_fn() reads shid->kbd_bl_cur, surface_kbd_bl_get() will
update shid->kbd_bl_cur to the new hardware level first.

When surface_kbd_bl_work_fn() subsequently runs, prev already holds the new
hardware level, so hw_idx =3D=3D prev evaluates to true and
surface_kbd_bl_work_fn() calls surface_kbd_bl_set() to step the brightness a
second time to (prev + 1) % 4. Concurrent sysfs writes via
set_brightness_delayed() -> surface_kbd_bl_set() also update shid->kbd_bl_c=
ur
without serialization against surface_kbd_bl_work_fn().

[Severity: Medium]
What happens in surface_kbd_bl_work_fn() if reading feature report 0xd6 fai=
ls
or the keyboard is hot-removed?

In surface_kbd_bl_get(), both surface_hid_is_hot_removed(shid) and a negati=
ve
return from shid->ops.get_feature_report(shid, 0xd6, buf, sizeof(buf)) retu=
rn
the cached shid->kbd_bl_cur.

Because surface_kbd_bl_work_fn() sets prev =3D shid->kbd_bl_cur and then
compares hw_idx =3D=3D prev, any read failure or hot-removal makes hw_idx e=
qual
prev, causing surface_kbd_bl_work_fn() to treat the failed read as an
unchanged hardware brightness, send output report 0xd5 via
surface_kbd_bl_set(), and unconditionally notify userspace via
led_classdev_notify_brightness_hw_changed().

> +
> +static void surface_hid_kbd_bl_init(struct surface_hid_device *shid)
> +{
> +	u8 feat[5] =3D { 0xd5, 0 };
> +	u8 cur[2] =3D { 0xd6, 0 };
> +
> +	if (shid->hid->vendor !=3D 0x045e || shid->hid->product !=3D 0x09ae)
> +		return;
> +
> +	if (shid->ops.get_feature_report(shid, 0xd5, feat, sizeof(feat)) < 0 ||
> +	    feat[4] =3D=3D 0)
> +		return;
> +
> +	memcpy(shid->kbd_bl_levels, &feat[1], 4);
> +	if (shid->ops.get_feature_report(shid, 0xd6, cur, sizeof(cur)) >=3D 0)
> +		shid->kbd_bl_cur =3D surface_kbd_bl_raw_to_idx(shid, cur[1]);
> +
> +	INIT_WORK(&shid->kbd_bl_work, surface_kbd_bl_work_fn);
> +	shid->kbd_bl_led.name =3D "surface::kbd_backlight";
> +	shid->kbd_bl_led.max_brightness =3D 3;
> +	shid->kbd_bl_led.flags =3D LED_BRIGHT_HW_CHANGED;
> +	shid->kbd_bl_led.brightness_set_blocking =3D surface_kbd_bl_set;
> +	shid->kbd_bl_led.brightness_get =3D surface_kbd_bl_get;
> +	shid->kbd_bl_led.brightness =3D shid->kbd_bl_cur;

[Severity: Medium]
The commit message states that the driver will "restore the saved brightness
level on resume", and also mentions hooking raw_event:

    Also hook raw_event to read back Feature Report 0xd6 and notify userspa=
ce
    via led_classdev_notify_brightness_hw_changed() when Input Report 0xd5
    arrives from the F5 key, and restore the saved brightness level on resu=
me.

However, shid->kbd_bl_led.flags only sets LED_BRIGHT_HW_CHANGED without
LED_CORE_SUSPENDRESUME, and neither surface_hid_resume() nor
surface_hid_restore() in drivers/hid/surface-hid/surface_hid_core.c writes
shid->kbd_bl_cur back to the device.

If the keyboard resets its backlight to 0 across suspend/resume while
shid->kbd_bl_cur stays at its pre-suspend index (for example 1), won't the
backlight remain off after resume and cause the next F5 press to step the
hardware from 0 to 1, match hw_idx =3D=3D prev in surface_kbd_bl_work_fn(),=
 and
jump to 2? Also, should device-specific HID report handling for 045E:09AE l=
ive
in a HID device driver rather than the low-level transport driver?

> +
> +	if (led_classdev_register(shid->dev, &shid->kbd_bl_led) =3D=3D 0)
> +		shid->has_kbd_bl =3D true;
> +}

[Severity: Medium]
Will this fail to link when CONFIG_SURFACE_HID_CORE is enabled without
CONFIG_LEDS_CLASS (or when CONFIG_SURFACE_HID_CORE=3Dy and
CONFIG_LEDS_CLASS=3Dm)?

surface_hid_kbd_bl_init() calls led_classdev_register() (which expands to
led_classdev_register_ext()), surface_hid_device_destroy() calls
led_classdev_unregister(), and surface_kbd_bl_work_fn() calls
led_classdev_notify_brightness_hw_changed().

In include/linux/leds.h, led_classdev_register_ext() and
led_classdev_unregister() do not have inline stubs when CONFIG_LEDS_CLASS is
disabled, and SURFACE_HID_CORE (as well as SURFACE_HID and SURFACE_KBD) in
drivers/hid/surface-hid/Kconfig has no dependency on or select of LEDS_CLASS
or NEW_LEDS.

[ ... ]

> @@ -218,15 +310,23 @@ int surface_hid_device_add(struct surface_hid_devic=
e *shid)
>  	shid->hid->ll_driver =3D &surface_hid_ll_driver;
> =20
>  	status =3D hid_add_device(shid->hid);
> -	if (status)
> +	if (status) {
>  		hid_destroy_device(shid->hid);
> +		return status;
> +	}
> =20
> -	return status;
> +	surface_hid_kbd_bl_init(shid);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(surface_hid_device_add);
> =20
>  void surface_hid_device_destroy(struct surface_hid_device *shid)
>  {
> +	if (shid->has_kbd_bl) {
> +		cancel_work_sync(&shid->kbd_bl_work);
> +		led_classdev_unregister(&shid->kbd_bl_led);
> +		shid->has_kbd_bl =3D false;
> +	}
>  	hid_destroy_device(shid->hid);
>  }

[Severity: Critical]
Can ssam_hid_event_fn() re-schedule shid->kbd_bl_work after
cancel_work_sync() in surface_hid_device_destroy(), causing a use-after-free
of shid and shid->kbd_bl_led?

In surface_hid_device_destroy(), cancel_work_sync(&shid->kbd_bl_work) is
called while shid->has_kbd_bl is still true and before
hid_destroy_device(shid->hid) calls surface_hid_stop() ->
__ssam_notifier_unregister() to stop ssam_hid_event_fn():

drivers/hid/surface-hid/surface_hid.c:ssam_hid_event_fn() {
    ...
	if (shid->has_kbd_bl && event->length >=3D 2 &&
	    event->data[0] =3D=3D 0xd5 && (event->data[1] & 0x01))
		schedule_work(&shid->kbd_bl_work);
    ...
}

While led_classdev_unregister(&shid->kbd_bl_led) is sleeping (or before
hid_destroy_device() unregisters the SSAM event notifier), an incoming 0xd5
event in ssam_hid_event_fn() can still observe shid->has_kbd_bl =3D=3D true=
 (or
have already passed that check before shid->has_kbd_bl =3D false) and call
schedule_work(&shid->kbd_bl_work).

Once re-queued after cancel_work_sync(), surface_kbd_bl_work_fn() can run
after led_classdev_unregister() has destroyed shid->kbd_bl_led and after
surface_hid_remove() returns and devres frees shid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023173213.6219=
-1-ramonjesusmiranda@gmail.com?part=3D1
