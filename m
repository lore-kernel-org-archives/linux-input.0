Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265475;
	b=gTQkHYjylsrSAZamG5df9a1KJ0mCVsgwPMcVLaG3MjJV30HpNFU5llSa9IY9MPe2S0ul
	 To43G/aisdhD/XnkxLgF8VwfgVo2OaNcgkiEJLqcBn5gKkrCUDbue5+yo206mc2BcXGen
	 xXft1DalXDYvWM6sSua+DZTopbl2lZ2j5CB5GwdKfcO644GopWgAk982kN80sMM6/M8fp
	 efHTsmVmDMv/WwNOJY7ytgAcRBVHB7Hlc7GqzooIlwX/1FZiNGE/su7Taq+ODCULxQumb
	 9s9tzdsqrPhosXH/Eio99rd2qN2YE10SbL8uMWafeHrECyw/0qgl8J+UW9NT0eamzzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2MssGUCTPu7ZBBba5Nq3RjZaQIpRgNBT4Hq0KGVQMcA=;
	b=AZ0TN3Id+ja0zH/Tki+piIEI0CNZReLeMInIlUkvYT/zKIPTEgm57NJGqEGI46JjsJZ2
	 1BhrbI6AYH04ctwXXplGfx4BKAfUKdrpDpuSeDPRPOaQNPoSINDVM2WkLF8d2e0ORnYbp
	 UnATQsrbzXETFPhqnI6f4BB+11TcMRCUB13s2cHkOPjv4r9F+YtD8EDVyIAgvzP65OejL
	 rnDCiMROqxFeH5K+sL4YiVUOyJ9HJoIecW7TnjxgwEoxOHsyaXV5/4ErezsrtzbzWxhPN
	 e3elZLHJjgraSzIW3hBCkPomz9hfBqr+2wKzcCHLDhV5m5Li7eWxD4hqDu6kVUDZ4iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbhblcyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E7606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbhblcyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A7C1F0089F;
	Mon,  9 Nov 2026 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265474;
	bh=2MssGUCTPu7ZBBba5Nq3RjZaQIpRgNBT4Hq0KGVQMcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbhblcyQya84e0B0lH8i+Wvahpnc8vlJLf1PusNVqiKBBBDMTyemV3dImtaKxV6Jw
	 s6hAfFlauePZ6Mh3gztN9BEVdd8cGBcp0oepEyoSYaXsg/SG5LjN1j/pffKOzsEc2G
	 qvW+YAwONhzs9h5RixTP3on4/9z0USkRNj1cx/dlrn4Yg6fxlSpbi0yAgd22tji914
	 YuVoUbKrNgouV6ep/z9BFmC3dpaWP3K7xbM2WRhlnFfan3n2UNPpcUtugjZKJcfYbL
	 LhhXgw2gFPTEWbgOpfTPfbwEqXJH6KcikoV8AIOLKlSGC8tB1ePu2lc/snk7tJ5NLX
	 QewgWNoenNREA==
Message-ID: <sashiko-outbox-205784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] HID: lenovo-legion: Add keyboard lighting
 driver for Legion Gen 10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciro Pedrini" <ciro.pedrini@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-legion-lighting-rfc-v1-2-a87e1db8c5e3@gmail.com>
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
 <20261109-legion-lighting-rfc-v1-2-a87e1db8c5e3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:04:34 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] HID: lenovo-legion: stale led_cdev.brightness after hotkey
  events
- [Medium] HID: lenovo-legion: missing color application when pairing in
  legion_kbd_probe()
- [Medium] HID: lenovo-legion: broken color_set and rgb state tracking
  on write and error
- [Medium] HID: lenovo-legion: missing controller owner hand-back in
  legion_lamps_remove()
- [Medium] HID: lenovo-legion: race between legion_brightness_set() and
  lighting_mode_store()
--

commit f6469bc79f96d1ad122443bdd5d1613264a3381f
Author: Ciro Pedrini <ciro.pedrini@gmail.com>

HID: lenovo-legion: Add keyboard lighting driver for Legion Gen 10

This commit adds a HID driver for the keyboard and chassis lighting of
2025 Lenovo Legion laptops, pairing the ITE 8258 keyboard controller and
its companion HID LampArray into a single multicolor LED device.

> diff --git a/drivers/hid/hid-lenovo-legion.c b/drivers/hid/hid-lenovo-leg=
ion.c
> new file mode 100644
> index 0000000000000..923f03d4ed342
> --- /dev/null
> +++ b/drivers/hid/hid-lenovo-legion.c

[ ... ]

> +static int legion_brightness_set(struct led_classdev *led,
> +				 enum led_brightness value)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(led);
> +	struct legion_kbd *kbd =3D container_of(mc, struct legion_kbd, mc);
> +	u8 level =3D min_t(unsigned int, value, LEGION_MAX_BRIGHTNESS);
> +	u8 rgb[3];
> +	int i, ret;
> +
> +	mutex_lock(&kbd->lock);
> +	ret =3D legion_exchange(kbd, LEGION_OP_SET_BRIGHTNESS, &level, 1, NULL);
> +	mutex_unlock(&kbd->lock);
> +	if (ret)
> +		return ret;
> +
> +	/* A multi_intensity write ends up here too: apply a changed colour. */
> +	for (i =3D 0; i < 3; i++)
> +		rgb[i] =3D READ_ONCE(mc->subled_info[i].intensity);
> +
> +	mutex_lock(&legion_pair_lock);
> +	if (memcmp(rgb, kbd->rgb, sizeof(rgb))) {
> +		memcpy(kbd->rgb, rgb, sizeof(rgb));
> +		kbd->color_set =3D true;
> +		ret =3D legion_apply_color(kbd);
> +	}
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return ret;
> +}

[Severity: Medium]
Does checking only memcmp(rgb, kbd->rgb, sizeof(rgb)) prevent switching to
"color" mode when the written multi_intensity matches kbd->rgb?

legion_kbd_probe() initializes both subleds[i].intensity and kbd->rgb[i]
to 255 while starting in "firmware" mode (color_set =3D false), and
switching back to "firmware" mode in lighting_mode_store() leaves kbd->rgb
untouched.  Writing 255 255 255 after probe, or re-writing the previous
colour after switching to "firmware" mode, finds memcmp() =3D=3D 0 and leav=
es
the controller in firmware mode.

In addition, both legion_brightness_set() and lighting_mode_store() update
kbd->rgb and set kbd->color_set =3D true before legion_apply_color(kbd)
succeeds.  If the USB transfer in legion_apply_color() fails,
lighting_mode falsely reports "color" and retries of the same colour via
multi_intensity are skipped.

[ ... ]

> +static void legion_hw_changed_work(struct work_struct *work)
> +{
> +	struct legion_kbd *kbd =3D container_of(work, struct legion_kbd,
> +					      hw_changed_work);
> +
> +	led_classdev_notify_brightness_hw_changed(&kbd->mc.led_cdev,
> +						  READ_ONCE(kbd->hw_brightness));
> +}

[Severity: Medium]
When Fn+Up or Fn+Down changes the controller's brightness, does
kbd->mc.led_cdev.brightness stay at its old value?

led_classdev_notify_brightness_hw_changed() records the value in
led_cdev->brightness_hw_changed and notifies sysfs pollers, but does not
update led_cdev->brightness:

drivers/leds/led-class-multicolor.c:multi_intensity_store() {
    ...
	if (!test_bit(LED_BLINK_SW, &led_cdev->work_flags))
		led_set_brightness(led_cdev, led_cdev->brightness);
    ...
}

When userspace later writes a colour to multi_intensity,
multi_intensity_store() calls legion_brightness_set() with the stale
led_cdev->brightness and sends LEGION_OP_SET_BRIGHTNESS to the controller,
overwriting the hotkey-adjusted brightness (for example, turning the LEDs
back off if brightness started at 0 and was raised with Fn+Up).

[ ... ]

> +static ssize_t lighting_mode_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct legion_kbd *kbd =3D led_dev_to_kbd(dev);
> +	struct led_classdev_mc *mc =3D &kbd->mc;
> +	int i, ret =3D 0;
> +
> +	mutex_lock(&legion_pair_lock);
> +	if (sysfs_streq(buf, "color")) {
> +		for (i =3D 0; i < 3; i++)
> +			kbd->rgb[i] =3D READ_ONCE(mc->subled_info[i].intensity);
> +		kbd->color_set =3D true;
> +		ret =3D legion_apply_color(kbd);
> +	} else if (sysfs_streq(buf, "firmware")) {
> +		kbd->color_set =3D false;
> +		legion_hand_back(kbd);
> +	} else {
> +		ret =3D -EINVAL;
> +	}
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return ret ? ret : count;
> +}

[Severity: Medium]
Can an in-flight set_brightness_work race with lighting_mode_store() and
revert a switch to "firmware" mode?

Because the LED uses brightness_set_blocking, multi_intensity_store()
updates mc->subled_info[i].intensity, schedules set_brightness_work on
leds_wq, and returns immediately:

CPU0 (sysfs)                      CPU1 (leds_wq)
multi_intensity_store()
  subled_info[i].intensity =3D new
  schedule_work(set_brightness_work)
                                  legion_brightness_set()
                                    legion_exchange(SET_BRIGHTNESS)
                                    rgb[i] =3D subled_info[i].intensity
lighting_mode_store("firmware")
  mutex_lock(&legion_pair_lock)
  kbd->color_set =3D false
  legion_hand_back(kbd)
  mutex_unlock(&legion_pair_lock)
                                    mutex_lock(&legion_pair_lock)
                                    memcmp(rgb, kbd->rgb) !=3D 0
                                    kbd->color_set =3D true
                                    legion_apply_color(kbd)  <-- reverts mo=
de

Similarly, if LEGION_OP_SET_BRIGHTNESS fails during a multi_intensity
write, legion_brightness_set() returns before updating kbd->rgb, so a
subsequent brightness change while in "firmware" mode sees memcmp(rgb,
kbd->rgb) !=3D 0 and switches lighting_mode to "color".

[ ... ]

> +	ret =3D led_classdev_multicolor_register(&hdev->dev, &kbd->mc);
> +	if (ret)
> +		goto err_close;
> +
> +	/* Added afterwards: the multicolor class replaces led_cdev.groups. */
> +	ret =3D device_add_groups(kbd->mc.led_cdev.dev, legion_led_groups);
> +	if (ret)
> +		goto err_unregister;
> +
> +	spin_lock_irq(&kbd->event_lock);
> +	kbd->ready =3D true;
> +	spin_unlock_irq(&kbd->event_lock);
> +
> +	mutex_lock(&legion_pair_lock);
> +	list_add(&kbd->node, &legion_kbds);
> +	list_for_each_entry(lamps, &legion_lamps_list, node) {
> +		if (lamps->bus =3D=3D kbd->bus && !lamps->kbd) {
> +			lamps->kbd =3D kbd;
> +			kbd->lamps =3D lamps;
> +			hid_info(hdev, "paired with %s\n", dev_name(&lamps->hdev->dev));
> +			break;
> +		}
> +	}
> +	mutex_unlock(&legion_pair_lock);

[Severity: Medium]
What happens if userspace writes to multi_intensity or lighting_mode right
after the LED is registered, before legion_kbd_probe() pairs kbd with an
already-probed LampArray?

CPU0 (legion_kbd_probe)           CPU1 (udev / sysfs)
led_classdev_multicolor_register()
device_add_groups()
                                  lighting_mode_store("color")
                                    mutex_lock(&legion_pair_lock)
                                    kbd->color_set =3D true
                                    legion_apply_color(kbd)
                                      if (!kbd->lamps)
                                        return 0;
                                    mutex_unlock(&legion_pair_lock)
mutex_lock(&legion_pair_lock)
kbd->lamps =3D lamps
/* missing legion_apply_color() */
mutex_unlock(&legion_pair_lock)

Unlike legion_lamps_probe(), the pairing loop in legion_kbd_probe() does
not call legion_apply_color(kbd) when kbd->color_set is already true, so
the hardware stays in firmware mode while lighting_mode reports "color".
Calling legion_apply_color(kbd) when kbd->color_set is set upon pairing
(or pairing before registering the LED) would avoid this.

[ ... ]

> +static void legion_lamps_remove(struct hid_device *hdev)
> +{
> +	struct legion_lamps *lamps =3D hid_get_drvdata(hdev);
> +
> +	mutex_lock(&legion_pair_lock);
> +	if (lamps->kbd) {
> +		if (lamps->kbd->lamparray_owns)
> +			lamps_set_autonomous(lamps, true);
> +		lamps->kbd->lamps =3D NULL;
> +	}
> +	list_del(&lamps->node);
> +	mutex_unlock(&legion_pair_lock);
> +
> +	hid_hw_stop(hdev);
> +}

[Severity: Medium]
When the LampArray device is removed or unbound while lamparray_owns is
true, shouldn't legion_lamps_remove() also hand LED ownership back to the
keyboard controller?

legion_lamps_remove() puts the LampArray into autonomous mode, but leaves
the keyboard controller in LEGION_OWNER_LAMPARRAY (0xAA 00) and leaves
lamps->kbd->lamparray_owns set to true, which leaves the LEDs dark instead
of restoring the controller's effects as legion_hand_back() does.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-legion-lig=
hting-rfc-v1-0-a87e1db8c5e3@gmail.com?part=3D2
