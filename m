Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220577;
	b=qIeDia0ufF0FL9+XJvioy2QUIBQvs1UyNETBDzmxRdlicIleNHdUaaSLfdtmxgLUXyjK
	 KNWaPco1n1/mXkfDzU1gPBHe8R42l157rNHa8tSXk5+y2PjigMvgej9LRj2YJ8DL7CbjA
	 YWbdOvjsOT6Z+9j0KGyBNhka2eBTYnPSG6o0ON+TAz5hvbwG20ZVl6CGNPdjlzWGcMyY+
	 QfP3Yoi0p/zwxyl+rZcH2k3gCdXlPNTRINT1ZknpjGOLbAIjqP7nOu0QoKg49XSpteIPg
	 rJbRJsRlgi+hYWGdCk0aW4z+DkbrwMk/NPTyIDlcx1nomRtkqhKyrG5qib/SPXMZEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KO/5gnbonsJdY1JiBq0J40rSRiKeC/2nmwMwWb+sAvg=;
	b=ehKEBWI3oECRvtdNzGy8h/cxmfXYx9ocAoaxvyLiTuAO3EiNOfGNpbCalwjMd4FZ+VDy
	 l5sFXhWZQ4gnuBkvcuPA7u5vCcB3RBAVcM8ckUz5m1IqsFJICrDXc1tfqmR1eDrlzvIHh
	 +k80VQWrtJxrrQvoIoFGkuLtUKwhixCTuJUADeZyeOCXnAU6XDmVwxsD741R2fTjHtPjS
	 lxeeuHAsTgAlVDzE9LgUT0HnaIvVgFrtEr50jqchDUdlOkTBQF9gsX4/ZG2XTaL0YuAYa
	 7BCVZ/VC6t3mmKKVbSDR/JBTCwZz+OjFySmxzfTXE+vdv6HVab76f9BNzeNSXAlA+Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0hUtmr2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A2606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0hUtmr2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695991F0089F;
	Mon,  9 Nov 2026 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794220576;
	bh=KO/5gnbonsJdY1JiBq0J40rSRiKeC/2nmwMwWb+sAvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0hUtmr2uZd6vuqvECJH+uTihVyi3DnMjuO6CzcPLFyM+TmbucxbH8zzx/LcLpZWt
	 qCm++O85z0q+0RmPsrf8e5LnfD5XcXjSFgoY9AeIQ9CsQJrxXMQ27TqfuROe4qabrC
	 r4we0cQogK7ohIehCdSlu4zvgfNGnFq0X3eg5EYbCUM+l+NgTBiM6DPrb2gruneGtE
	 IH33NDj8arIgnyfByr4ZWCHLd//rb+tD0xi1HV15ikN0H26ufk/cu0XUxDxxum11vt
	 HB/oJZffQ78Zd8dzac9r3vG4lq54EfP1v9zl7TE5NoFhmXQOBwWBXt79I4d1ePytbK
	 VEgBsVb6lgjhA==
Message-ID: <sashiko-outbox-204828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: lg-g15: report Super-key-lock state on G15
 v2's keyboard interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Torstein Eide" <torsteine+linux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109094426.1432465-4-torsteine+linux@gmail.com>
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
 <20261109094426.1432465-4-torsteine+linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:36:16 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] HID: lg-g15: missing HID_QUIRK_INPUT_PER_APP in
  lg_g15_v2_kbd_probe()
- [Medium] HID: lg-g15: initial lock state read after LED registration
  in lg_g15_v2_kbd_probe()
- [Low] HID: lg-g15: race updating super_lock between lg_g15_resume()
  and raw_event
--

commit 429a4d981b469fb0f361faf62d0245c19b75257d
Author: Torstein Eide <torsteine+linux@gmail.com>

HID: lg-g15: report Super-key-lock state on G15 v2's keyboard interface

This commit binds the Logitech G15 v2 keyboard USB device (046D:C226) to
hid-lg-g15 and exposes the Super-key lock state from report 3 as a
read-only g15::game_mode LED while keeping default hid-input handling.

> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 35d183787383a..592c9747738e2 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
[ ... ]
> @@ -981,11 +995,138 @@ static int lg_g510_leds_event(struct lg_g15_data *=
g15, u8 *data)
[ ... ]
> +static void lg_g15_v2_kbd_set_super_lock(struct lg_g15_kbd_data *kbd, bo=
ol super_lock)
> +{
> +	if (super_lock =3D=3D kbd->super_lock)
> +		return;
> +
> +	kbd->super_lock =3D super_lock;
> +	led_classdev_notify_brightness_hw_changed(&kbd->led, super_lock);
> +}
> +
> +/* Fetches the current lock state, which may already be on at probe/resu=
me. */
> +static void lg_g15_v2_kbd_read_super_lock(struct hid_device *hdev,
> +					  struct lg_g15_kbd_data *kbd)
> +{
> +	u8 *buf;
> +	int ret;
> +
> +	buf =3D kzalloc(2, GFP_KERNEL); /* DMA-able, not on the stack */
> +	if (!buf)
> +		return;
> +
> +	ret =3D hid_hw_raw_request(hdev, LG_G15_V2_KBD_GAME_MODE_REPORT, buf, 2,
> +				 HID_INPUT_REPORT, HID_REQ_GET_REPORT);
> +	if (ret =3D=3D 2 && buf[0] =3D=3D LG_G15_V2_KBD_GAME_MODE_REPORT)
> +		lg_g15_v2_kbd_set_super_lock(kbd, buf[1] & 0x01);
> +	else
> +		hid_dbg(hdev, "Error reading Super-key-lock state: %d\n", ret);
> +
> +	kfree(buf);
> +}
[ ... ]
> +	kbd->led.name =3D "g15::game_mode";
> +	kbd->led.max_brightness =3D 1;
> +	kbd->led.brightness_get =3D lg_g15_v2_kbd_super_lock_get;
> +	kbd->led.flags =3D LED_BRIGHT_HW_CHANGED; /* Enables the hw_changed not=
ify below */
> +
> +	ret =3D devm_led_classdev_register(&hdev->dev, &kbd->led);
> +	if (ret)
> +		return 0; /* Non-fatal, keyboard input still works without the LED */
> +
> +	/*
> +	 * Only set drvdata once the LED is registered: raw_event may run as
> +	 * soon as hid_hw_start() returns, and notifying a brightness change
> +	 * on an unregistered LED triggers a WARN.
> +	 */
> +	hid_set_drvdata(hdev, kbd);
> +	lg_g15_v2_kbd_read_super_lock(hdev, kbd);

[Severity: Medium]
Does registering kbd->led before reading the initial hardware lock state
publish a stale brightness of 0 and emit a spurious brightness_hw_changed
notification when the Super-key lock switch is already on at probe?

Inside devm_led_classdev_register(), led_classdev_register_ext() calls
kbd->led.brightness_get while kbd->super_lock is still false, caches
kbd->led.brightness =3D 0, initializes kbd->led.brightness_hw_changed to -1
(-ENODATA), and emits KOBJ_ADD.  Userspace readers reacting to the uevent
can observe 0 while the GET_REPORT transfer is in flight, and
lg_g15_v2_kbd_read_super_lock() -> lg_g15_v2_kbd_set_super_lock() then fires
led_classdev_notify_brightness_hw_changed() and sets brightness_hw_changed
to 1 even though no hardware change occurred after registration.

Reading the initial report into kbd->super_lock before calling
devm_led_classdev_register() (similar to lg_g15_get_initial_led_brightness()
in lg_g15_probe()) would register the LED with the actual hardware state.

[ ... ]

> @@ -1492,6 +1638,12 @@ static int lg_g15_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  	struct hid_report *rep;
>  	int ret, i, gkeys =3D 0;
> =20
> +	if (lg_g15_is_v2_kbd(hdev)) /* Not the GamePanel LCD interface */
> +		return lg_g15_v2_kbd_probe(hdev);
> +
> +	if (id->driver_data =3D=3D LG_G15_V2_KBD) /* e.g. a mismatching new_id =
*/
> +		return -ENODEV;
> +
>  	hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;

[Severity: Medium]
Should lg_g15_v2_kbd_probe() also set HID_QUIRK_INPUT_PER_APP on
hdev->quirks before calling hid_parse() and hid_hw_start()?

Previously 046D:C226 was bound by hid-generic, where hid_generic_probe()
sets HID_QUIRK_INPUT_PER_APP:

drivers/hid/hid-generic.c:hid_generic_probe() {
	hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;

	ret =3D hid_parse(hdev);
	if (ret)
		return ret;

	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
}

Because lg_g15_probe() dispatches to lg_g15_v2_kbd_probe() before setting
HID_QUIRK_INPUT_PER_APP, any interface on 046D:C226 with multiple
application collections (such as the consumer-control/extra-report
interface) has all application collections merged into a single input_dev
and loses the per-application input device name suffix, which is a
regression relative to hid-generic.

[ ... ]

> @@ -1772,9 +1947,18 @@ static void lg_g15_remove(struct hid_device *hdev)
>   */
>  static int lg_g15_resume(struct hid_device *hdev)
>  {
> -	struct lg_g15_data *g15 =3D hid_get_drvdata(hdev);
> +	struct lg_g15_data *g15;
>  	struct lg_g15_led *contrast;
> =20
> +	if (lg_g15_is_v2_kbd(hdev)) {
> +		struct lg_g15_kbd_data *kbd =3D hid_get_drvdata(hdev);
> +
> +		if (kbd)
> +			lg_g15_v2_kbd_read_super_lock(hdev, kbd);
> +		return 0;
> +	}

[Severity: Low]
Can lg_g15_resume() race with lg_g15_v2_kbd_raw_event() when updating
kbd->super_lock and kbd->led.brightness_hw_changed?

In usbhid, hid_resume_common() and hid_post_reset() call hid_restart_io() to
restart the interrupt IN URB before invoking the HID driver's resume or
reset_resume callback.  If the Super-key lock switch is toggled during
resume, the GET_REPORT control transfer and an interrupt IN report can run
concurrently:

CPU0 (resume)                     CPU1 (URB completion)
lg_g15_resume()
  lg_g15_v2_kbd_read_super_lock()
    hid_hw_raw_request()
      -> reads old state (0)
                                  lg_g15_raw_event()
                                    lg_g15_v2_kbd_raw_event()
                                      lg_g15_v2_kbd_set_super_lock(kbd, 1)
                                        kbd->super_lock =3D 1;
                                        ..._hw_changed(&kbd->led, 1);
    lg_g15_v2_kbd_set_super_lock(kbd, 0)
      kbd->super_lock =3D 0;  <-- overwrites newer interrupt state

The two paths can also interleave between assigning kbd->super_lock and
calling led_classdev_notify_brightness_hw_changed(), leaving kbd->super_lock
and kbd->led.brightness_hw_changed with opposite values.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109094426.1432=
465-1-torsteine+linux@gmail.com?part=3D3
