Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491670;
	b=SOREDpYAUxwMtGNtiz4KXaDrGUWNhdiaCWWVvVsRQslQs2HLK1PuHsRecmoqvYVSPiQe
	 j3X9i/vQYRpDeWUoYc+OT5xF+Xd3hAT+rQ4mCeRufQGOhKG1JnVscy12LGm1nTJRLcfKd
	 hUglGmGiJ1getNdeKlYn7Hgah3Lf6/bIztgY0I3kisXiHWOE4vXhgV7fy9+Bu+JTKByv3
	 rnBgmjBUO1ywV9foqXm4st8gPSigQGg8TypHbHvrEhk4cDo/pudGC+baMACqeARlPIo6V
	 dQkAWvORC7BP8LUpf7akjxBCPgMQZBuBAZs1s71yUdX+ZUeUw2gE7YuLf1417lDrU3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491670;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kcBxMWIMRQyBZUpOhY+Iz6l5l5jXCwBbPcUHKNdsUak=;
	b=ewqRXJcjHcIDdWZcVCUunokMhulbHUcaw0aKJHD1Z7djl+vv1Ljp2vivINMlmJ5Nhn69
	 FzKknX9qOTDrIYfvy8giJeQTOJlXn/jG8FshZviObglJMA0e2nzEKqyLLFzA0rmZKhLln
	 hew7yNiSnxtZOqL7G9PvFBVZbvI3ksDjF/GD74cqjd4/M+1U7Efoe0ozw0dB6gqeOO7hO
	 y3Zx+uiNwVpyFekn8jJ3KhibrXmPw3/a8ENa5WJsc5dari7bhe6v9lpZFZLH87D/rqEK4
	 Vy9/OaEQGoGvcesOUupwMxOZLJIj6nznHBuUvJi6UgU1wy5B85z/YDA1LyWXGHXDKKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiWn0Azm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFDC606A322;
	Tue, 20 Oct 2026 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiWn0Azm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709FE1F000C4;
	Tue, 20 Oct 2026 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491669;
	bh=kcBxMWIMRQyBZUpOhY+Iz6l5l5jXCwBbPcUHKNdsUak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JiWn0AzmgLVUkZ+shMvnr38aESxusPqaGV1HoGBFCo+dCY+agxeYJ4zKjCw9CXgBY
	 /q/GKRHvSjVGyh34NMuoP3SnsiJkvNaatjoQCOyEUhgXpYF/NHIZCHBUCnPf/fp+nF
	 kp2n8v+wvhvfoJ53b9pbnQb0CnG9O6qP5H8FEkUTeWV7DwsocgCT7XJkZJc+NDPefa
	 p47p4uQqEXt+KyYmVnsB8BUIP61mgmKLuF7A33Xq10oOyc2t0UfyEh11YZVVCy9YwK
	 ziaWV3c+OGAR6MmSpk19wVVapmDiOd6FHvLYz+1FZSuzuva+U9I6zjwaPsgd42xTQt
	 VD8/VdAyZKqNA==
Message-ID: <sashiko-outbox-178826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] HID: lamparray: add new LampArray helper module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Erhardt" <aer@tuxedocomputers.com>
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261020-hid-lamparray-v7-1-47418b667b47@tuxedocomputers.com>
References: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
 <20261020-hid-lamparray-v7-1-47418b667b47@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:21:08 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] HID: lamparray: broken feature report parsing with hid_report_raw_=
event()
- [High] HID: lamparray: missing LampUpdateComplete flag in lamparray_hw_se=
t_state()
- [Medium] HID: lamparray: LED_UNREGISTERING flag left set in lamparray_reg=
ister_led()
- [Medium] HID: lamparray: brightness and intensity races in LED callbacks =
and restore
- [Medium] HID: lamparray: premature sysfs/LED exposure in lamparray_regist=
er()
- [Medium] HID: lamparray: inverted teardown ordering in lamparray_unregist=
er()
- [Medium] HID: lamparray: mixing __free() and guard() cleanup with goto la=
bels
- [Medium] HID: lamparray: missing LampId request in lamparray_get_lamp_att=
ributes()
- [Low] HID: lamparray: stale miscdevice references in hid-lamparray.h kern=
el-doc
--

commit 5808d3d964362ce7a1a1b72a82eceb2d7c489b7a
Author: Aaron Erhardt <aer@tuxedocomputers.com>

HID: lamparray: add new LampArray helper module

This commit adds a hid-lamparray helper module that provides basic single-z=
one
RGB LED support for HID devices exposing a Lighting/LampArray application
collection (usage page 0x59).

> diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
> new file mode 100644
> index 0000000000000..fb3082f6d19a0
> --- /dev/null
> +++ b/drivers/hid/hid-lamparray.c
> @@ -0,0 +1,858 @@

[ ... ]

> +static int lamparray_read_attributes_report(struct lamparray_device *lde=
v)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +	int ret;
> +	size_t len;
> +
> +	if (!ldev->lamp_count.field) {
> +		hid_warn(hdev, "No LampCount field found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!ldev->lamparray_kind.field) {
> +		hid_warn(hdev, "No LampArrayKind field found\n");
> +		return -ENODEV;
> +	}
> +
> +	report =3D ldev->lamp_count.field->report;
> +
> +	if (!report) {
> +		hid_warn(hdev, "LampCount field has no report\n");
> +		return -ENODEV;
> +	}
> +
> +	len =3D hid_report_len(report);
> +	u8 *buf __free(kfree) =3D kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	guard(mutex)(&ldev->dev_lock);
> +
> +	/* Update values */
> +	ret =3D hid_hw_raw_request(hdev, report->id, buf, len,
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (ret < 0) {
> +		hid_warn(hdev, "Failed to request LampArrayAttributesReport: %d\n", re=
t);
> +		return ret;
> +	}
> +
> +	ret =3D hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf, len, ret, 0=
);

[Severity: High]
Can this sequence in lamparray_read_attributes_report() and
lamparray_get_lamp_attributes() misparse feature reports or leak uninitiali=
zed
heap bytes?

First, buf is allocated with kmalloc(len, GFP_KERNEL) without zeroing it or
setting buf[0] =3D report->id, and buf[0] is not validated after
hid_hw_raw_request(). If a low-level transport driver does not write buf[0]=
 on
HID_REQ_GET_REPORT (for example, handle_lamp_array_attributes_report() and
handle_lamp_attributes_response_report() in
drivers/platform/x86/tuxedo/nb04/wmi_ab.c where report_id is const u8, or
ishtp_raw_request() on timeout), buf[0] retains uninitialized heap memory.
When hid_report_raw_event() runs:

drivers/hid/hid-core.c:hid_report_raw_event() {
	report =3D hid_get_report(report_enum, data);
	...
	if (hid->claimed & HID_CLAIMED_HIDRAW) {
		ret =3D hidraw_report_event(hid, data, size);
		if (ret)
			return ret;
	}
}

hid_get_report() reads the uninitialized buf[0] to index
report_enum->report_id_hash[n] (failing to match the report or updating a
different report), and hidraw_report_event() copies the uninitialized buffer
and synchronous GET_REPORT reply to userspace hidraw clients.

Second, if the feature report is unnumbered (report->id =3D=3D 0),
hid_report_len(report) returns DIV_ROUND_UP(report->size, 8) without a repo=
rt
ID byte. However, low-level raw_request implementations such as
usbhid_get_raw_report() and i2c_hid_get_raw_report() store 0 into buf[0],
advance buf++, and decrement count-- when reportnum =3D=3D 0. Without alloc=
ating an
extra byte and stripping buf[0] before parsing (as __hid_request() in
drivers/hid/hid-core.c and vivaldi_feature_mapping() in
drivers/hid/hid-vivaldi-common.c do), the transfer buffer is 1 byte too sho=
rt
(-EOVERFLOW or truncation) and hid_report_raw_event() parses the stuffed 0x=
00
byte at buf[0] as the first byte of the payload.

Third, hid_report_raw_event() only calls hid_process_report() when
hid->claimed !=3D HID_CLAIMED_HIDRAW:

drivers/hid/hid-core.c:hid_report_raw_event() {
	if (hid->claimed !=3D HID_CLAIMED_HIDRAW && report->maxfield) {
		hid_process_report(hid, report, cdata, interrupt);
		...
	}
}

Because the LampArray application usage (0x00590001) is not an input
application, a standalone LampArray device started via
hid_hw_start(hdev, HID_CONNECT_DEFAULT) without HID_CONNECT_DRIVER on non-U=
SB
buses (or with CONFIG_USB_HIDDEV=3Dn) has hdev->claimed =3D=3D HID_CLAIMED_=
HIDRAW.
In that case hid_report_raw_event() skips hid_process_report(), leaving
ldev->lamp_count at 0 and failing with -EINVAL.

Would using kzalloc() (or hid_alloc_report_buf()) and hid_extract_bits() (or
handling the report->id =3D=3D 0 offset and HID_CLAIMED_DRIVER requirement)=
 avoid
these issues?

> +	if (ret < 0) {
> +		hid_warn(hdev, "Failed to parse LampArrayAttributesReport: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ldev->lamp_count_value =3D get_field_value(&ldev->lamp_count);
> +	if (!ldev->lamp_count_value) {
> +		hid_warn(hdev, "LampCount is 0 (invalid)\n");
> +		return -EINVAL;
> +	}
> +
> +	ldev->lamparray_kind_value =3D get_field_value(&ldev->lamparray_kind);
> +	return 0;
> +}
> +
> +static int lamparray_parse_update_report(struct lamparray_device *ldev)
> +{

[ ... ]

> +				} else if (collection_usage_id =3D=3D HID_LAMP_RANGE_UPDATE_REPORT) {
> +					switch (id) {
> +					case HID_LAIP_RED_UPDATE_CHANNEL:
> +						ldev->color_update.red.field =3D field;
> +						ldev->color_update.red.index =3D j;
> +						break;
> +					case HID_LAIP_GREEN_UPDATE_CHANNEL:
> +						ldev->color_update.green.field =3D field;
> +						ldev->color_update.green.index =3D j;
> +						break;
> +					case HID_LAIP_BLUE_UPDATE_CHANNEL:
> +						ldev->color_update.blue.field =3D field;
> +						ldev->color_update.blue.index =3D j;
> +						break;
> +					case HID_LAIP_INTENSITY_UPDATE_CHANNEL:
> +						ldev->color_update.intensity.field =3D field;
> +						ldev->color_update.intensity.index =3D j;
> +						break;
> +					case HID_LAIP_LAMP_ID_START:
> +						ldev->range_start.field =3D field;
> +						ldev->range_start.index =3D j;
> +						break;
> +					case HID_LAIP_LAMP_ID_END:
> +						ldev->range_end.field =3D field;
> +						ldev->range_end.index =3D j;
> +						break;
> +					default:
> +						break;
> +					}
> +				} else if (collection_usage_id =3D=3D HID_LAMPARRAY_CONTROL_REPORT &&
> +					   id =3D=3D HID_LAIP_AUTONOMOUS_MODE) {
> +					ldev->autonomous_field.field =3D field;
> +					ldev->autonomous_field.index =3D j;
> +				}
> +			}
> +		}
> +	}
> +
> +	if (!ldev->autonomous_field.field ||
> +	    !lamparray_color_fields_is_complete(&ldev->color_update))
> +		ret =3D -ENODEV;
> +
> +	return ret;
> +}
> +
> +static int lamparray_hw_set_autonomous(struct lamparray_device *ldev,
> +				       bool enable)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_field *field =3D ldev->autonomous_field.field;
> +
> +	if (!field)
> +		return -ENODEV;
> +
> +	guard(mutex)(&ldev->dev_lock);
> +	set_field_value(&ldev->autonomous_field, !!enable);
> +	hid_hw_request(hdev, field->report, HID_REQ_SET_REPORT);
> +
> +	return 0;
> +}
> +
> +/* Make sure to hold dev lock to prevent concurrent access. */
> +static int lamparray_hw_set_state(struct lamparray_device *ldev, u8 r, u=
8 g,
> +				  u8 b, u8 intensity)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +
> +	if (!lamparray_color_fields_is_complete(&ldev->color_update))
> +		return -ENODEV;
> +
> +	if (ldev->range_start.field && ldev->range_end.field) {
> +		set_field_value(&ldev->range_start, 0);
> +		set_field_value(&ldev->range_end, ldev->lamp_count_value - 1);
> +	}
> +
> +	set_field_value(&ldev->color_update.red, r);
> +	set_field_value(&ldev->color_update.green, g);
> +	set_field_value(&ldev->color_update.blue, b);
> +	set_field_value(&ldev->color_update.intensity, intensity);
> +
> +	report =3D ldev->color_update.red.field->report;
> +	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);

[Severity: High]
Should lamparray_parse_update_report() and lamparray_hw_set_state() also pa=
rse
and set LampUpdateFlags (usage 0x0055) in LampRangeUpdateReport (0x0060)?

Per the HID Lighting and Illumination specification, LampRangeUpdateReport
contains LampUpdateFlags where bit 0 (LampUpdateComplete =3D 1) instructs t=
he
device to commit buffered updates to the physical LEDs (as seen with
LAMP_UPDATE_FLAGS_LAMP_UPDATE_COMPLETE in
drivers/platform/x86/tuxedo/nb04/wmi_ab.c). Without setting LampUpdateFlags=
 to
LampUpdateComplete before calling hid_hw_request(), won't spec-compliant
devices that buffer updates until LampUpdateComplete is asserted never apply
the color or brightness changes?

> +
> +	return 0;
> +}
> +
> +/*
> + * Simple helper to read the color information of the first lamp.
> + * This does not read the state of the whole lamp array since this drive=
r only
> + * exposes one LED anyway, so one color is sufficient here for now.
> + */
> +static int lamparray_get_lamp_attributes(struct lamparray_device *ldev)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +	int ret;
> +	size_t len;
> +
> +	if (!lamparray_color_fields_is_complete(&ldev->color_levels))
> +		return -ENODEV;
> +
> +	/*
> +	 * All four fields must share the same report since the
> +	 * attributes are fetched with a single GET_REPORT below.
> +	 */
> +	report =3D ldev->color_levels.red.field->report;
> +	if (!report ||
> +	    ldev->color_levels.green.field->report !=3D report ||
> +	    ldev->color_levels.blue.field->report !=3D report ||
> +	    ldev->color_levels.intensity.field->report !=3D report)
> +		return -ENODEV;
> +
> +	len =3D hid_report_len(report);
> +	u8 *buf __free(kfree) =3D kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	guard(mutex)(&ldev->dev_lock);
> +
> +	/* Update values */
> +	ret =3D hid_hw_raw_request(hdev, report->id, buf, len,
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);

[Severity: Medium]
Does lamparray_get_lamp_attributes() need to send a LampAttributesRequestRe=
port
(usage 0x0020) with LampId (0x0021) set to 0 before requesting
LampAttributesResponseReport (0x0022)?

In the HID Lighting and Illumination specification, reading
LampAttributesResponseReport returns the attributes of the lamp selected by=
 a
preceding LampAttributesRequestReport and advances the device's internal La=
mpId
cursor on each read (for example, handle_lamp_attributes_response_report() =
in
drivers/platform/x86/tuxedo/nb04/wmi_ab.c reads and increments
driver_data->next_lamp_id). If the device's internal LampId cursor was alre=
ady
advanced by a prior probe, userspace hidraw access, or warm reboot, or if t=
he
firmware requires an explicit request before populating the response report,
could this read attributes from a different lamp index or fail?

> +	if (ret < 0) {
> +		hid_warn(hdev, "Failed to request LampAttributesResponseReport: %d\n",=
 ret);
> +		return ret;
> +	}

[ ... ]

> +static int lamparray_restore_state(struct lamparray_device *ldev)
> +{
> +	u8 r, g, b;
> +	int ret;
> +	enum led_brightness brightness;
> +
> +	if (!ldev->use_leds_uapi)
> +		return 0;
> +
> +	guard(mutex)(&ldev->dev_lock);
> +
> +	r =3D ldev->last_r;
> +	g =3D ldev->last_g;
> +	b =3D ldev->last_b;
> +	brightness =3D ldev->last_brightness;
> +
> +	ldev->mc_cdev.subled_info[0].intensity =3D r;
> +	ldev->mc_cdev.subled_info[1].intensity =3D g;
> +	ldev->mc_cdev.subled_info[2].intensity =3D b;
> +	ldev->mc_cdev.led_cdev.brightness =3D brightness;
> +
> +	/*
> +	 * Quirk for devices ignoring intensity values, see
> +	 * lamparray_led_brightness_set for more information.
> +	 */
> +	if (brightness)
> +		ret =3D lamparray_hw_set_state(ldev, r, g, b, brightness);
> +	else
> +		ret =3D lamparray_hw_set_state(ldev, 0, 0, 0, 0);
> +
> +	return ret;
> +}
> +
> +/* LEDs API */
> +
> +static int lamparray_led_brightness_set(struct led_classdev *cdev,
> +					enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lamparray_device *ldev =3D
> +		container_of_const(mc, struct lamparray_device, mc_cdev);
> +	u8 r, g, b;
> +	int ret;
> +
> +	/*
> +	 * Brightness is handled by the LampArray device if supported,
> +	 * so we can pass the raw intensity values.
> +	 */
> +	r =3D mc->subled_info[0].intensity;
> +	g =3D mc->subled_info[1].intensity;
> +	b =3D mc->subled_info[2].intensity;
> +	mc->led_cdev.brightness =3D brightness;
> +
> +	guard(mutex)(&ldev->dev_lock);
> +
> +	/*
> +	 * Some devices completely ignore the intensity (brightness)
> +	 * value and instead rely on zeros for each RGB channel to turn
> +	 * the LEDs off (e.g. the ASUS Prime B650-Plus). Since it doesn't
> +	 * hurt spec-compliant devices to quirk this behavior, we turn
> +	 * off the RGB channels unconditionally when the brightness is
> +	 * zero.
> +	 */
> +	if (brightness)
> +		ret =3D lamparray_hw_set_state(ldev, r, g, b, brightness);
> +	else
> +		ret =3D lamparray_hw_set_state(ldev, 0, 0, 0, 0);
> +
> +	if (ret) {
> +		hid_err(ldev->hdev, "Failed to send LampArray update: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ldev->last_r =3D r;
> +	ldev->last_g =3D g;
> +	ldev->last_b =3D b;
> +	ldev->last_brightness =3D brightness;
> +
> +	return 0;
> +}
> +
> +static enum led_brightness
> +lamparray_led_brightness_get(struct led_classdev *cdev)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lamparray_device *ldev =3D
> +	    container_of_const(mc, struct lamparray_device, mc_cdev);
> +
> +	return ldev->last_brightness;
> +}

[Severity: Medium]
Can lamparray_led_brightness_get(), lamparray_led_brightness_set(), and
lamparray_restore_state() race with the LED core and corrupt the cached
brightness and subled intensities?

Because lamparray_register_led() sets cdev->brightness_set_blocking =3D
lamparray_led_brightness_set (with cdev->brightness_set =3D NULL), writes to
brightness or multi_intensity in sysfs call led_set_brightness(), which upd=
ates
led_cdev->brightness and schedules led_cdev->set_brightness_work on leds_wq.
However, ldev->last_brightness is only updated at the end of
lamparray_led_brightness_set() after hid_hw_request() completes.

If userspace reads the brightness sysfs attribute while set_brightness_work=
 is
still queued or running, brightness_show() calls led_update_brightness():

drivers/leds/led-core.c:led_update_brightness() {
	if (led_cdev->brightness_get) {
		ret =3D led_cdev->brightness_get(led_cdev);
		if (ret >=3D 0) {
			led_cdev->brightness =3D ret;
			return 0;
		}
	}
}

This invokes lamparray_led_brightness_get(), which reads ldev->last_brightn=
ess
unlocked and overwrites led_cdev->brightness with the stale value. A subseq=
uent
multi_intensity_store() then passes that stale led_cdev->brightness back to
led_set_brightness().

In addition, if software blinking (LED_BLINK_SW) is active,
led_timer_function() calls led_set_brightness_nosleep(led_cdev, LED_OFF) on=
 the
off-phase, which runs lamparray_led_brightness_set(cdev, 0) and overwrites
ldev->last_brightness with 0.

Finally, lamparray_led_brightness_set() reads mc->subled_info[0..2].intensi=
ty
and writes mc->led_cdev.brightness before acquiring ldev->dev_lock, while
lamparray_restore_state() modifies ldev->mc_cdev.subled_info[0..2].intensity
and ldev->mc_cdev.led_cdev.brightness after the LED classdev is already
registered in sysfs without holding cdev->led_access, racing with concurrent
brightness_store() and multi_intensity_store() calls.

Since the hardware state is not read back in lamparray_led_brightness_get()=
, is
the brightness_get callback needed at all, and should subled_info and
brightness accesses be synchronized cleanly before or during LED registrati=
on?

> +
> +/* Make sure to hold sysfs lock to prevent concurrent access. */
> +static int lamparray_register_led(struct lamparray_device *ldev)
> +{
> +	struct device *dev =3D &ldev->hdev->dev;
> +	struct led_classdev *cdev =3D &ldev->mc_cdev.led_cdev;
> +	int ret;
> +
> +	if (ldev->led_registered)
> +		return 0;
> +
> +	if (!cdev->name) {
> +		/* Fallback value */
> +		const char *function =3D LED_FUNCTION_STATUS;
> +
> +		/* Some heuristics for choosing a better LED function. */
> +		if (ldev->lamparray_kind_value =3D=3D HID_LAMPARRAY_KIND_KEYBOARD)
> +			function =3D LED_FUNCTION_KBD_BACKLIGHT;
> +
> +		cdev->name =3D kasprintf(GFP_KERNEL, "rgb:%s", function);
> +		if (!cdev->name)
> +			return -ENOMEM;
> +	}
> +
> +	mutex_lock(&ldev->dev_lock);
> +	/* Setup */
> +	cdev->max_brightness =3D ldev->max_brightness;
> +	cdev->brightness_set_blocking =3D lamparray_led_brightness_set;
> +	cdev->brightness_get =3D lamparray_led_brightness_get;
> +	/* Don't do anything automatically on shutdown or suspend. */
> +	cdev->flags |=3D LED_RETAIN_AT_SHUTDOWN;

[Severity: Medium]
When the LED classdev is unregistered and re-registered via
use_leds_uapi_store(), does cdev->flags retain LED_UNREGISTERING?

Writing 0 to use_leds_uapi calls:

use_leds_uapi_store()
  -> lamparray_unregister_led()
    -> led_classdev_multicolor_unregister(&ldev->mc_cdev)
      -> led_classdev_unregister(&mcled_cdev->led_cdev)

In drivers/leds/led-class.c, led_classdev_unregister() sets:

	led_cdev->flags |=3D LED_UNREGISTERING;

When 1 is later written to use_leds_uapi, lamparray_register_led() re-regis=
ters
the same embedded ldev->mc_cdev structure and only does
cdev->flags |=3D LED_RETAIN_AT_SHUTDOWN, leaving LED_UNREGISTERING permanen=
tly
set on the re-registered LED device. Should cdev->flags be assigned
(cdev->flags =3D LED_RETAIN_AT_SHUTDOWN) or have LED_UNREGISTERING cleared?

> +
> +	ldev->subleds[0].color_index =3D LED_COLOR_ID_RED;
> +	ldev->subleds[0].max_intensity =3D ldev->max_r;

[ ... ]

> +static ssize_t use_leds_uapi_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct lamparray_device *ldev =3D lamparray_ldev_from_sysfs_dev(dev);
> +	bool val, old_val;
> +	int ret;
> +
> +	if (!ldev)
> +		return -ENODEV;
> +
> +	ret =3D kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Make sure only one concurrent write is possible */
> +	guard(mutex)(&ldev->sysfs_lock);
> +	old_val =3D ldev->use_leds_uapi;
> +
> +	if (val =3D=3D old_val)
> +		return count;
> +
> +	ldev->use_leds_uapi =3D val;
> +
> +	/*
> +	 * Take the device out of autonomous mode before exposing the LED
> +	 * class device, and hand it back afterwards, so that control is
> +	 * transferred in both directions rather than only at probe.
> +	 */
> +	if (val =3D=3D 1) {
> +		ret =3D lamparray_hw_set_autonomous(ldev, false);
> +		if (ret)
> +			goto err_revert;
> +		ret =3D lamparray_register_led(ldev);
> +		if (ret) {
> +			lamparray_hw_set_autonomous(ldev, true);
> +			goto err_revert;
> +		}
> +		ret =3D lamparray_restore_state(ldev);
> +		if (ret) {
> +			hid_warn(ldev->hdev, "Could not restore state: %d\n", ret);
> +			lamparray_unregister_led(ldev);
> +			lamparray_hw_set_autonomous(ldev, true);
> +			goto err_revert;
> +		}
> +	} else {
> +		lamparray_unregister_led(ldev);
> +		ret =3D lamparray_hw_set_autonomous(ldev, true);
> +		if (ret) {
> +			hid_warn(ldev->hdev, "Could not enable autonomous mode: %d\n", ret);
> +			return count;
> +		}
> +	}
> +
> +	return count;
> +
> +err_revert:
> +	ldev->use_leds_uapi =3D old_val;
> +	return ret;
> +}

[Severity: Medium]
In use_leds_uapi_store() (which uses guard(mutex)(&ldev->sysfs_lock) togeth=
er
with goto err_revert) and in lamparray_register() below (which uses
struct lamparray *la __free(kfree) together with goto err_remove_sysfs,
err_xa_erase, err_unregister_led, and err_free), this mixes scope-based cle=
anup
helpers with goto error paths in the same function.

Per include/linux/cleanup.h, goto and cleanup helpers should not be mixed in
the same routine. Could these functions be structured to avoid mixing
__free()/guard() with goto labels?

[ ... ]

> +struct lamparray *
> +lamparray_register(struct hid_device *hdev,
> +		   const struct lamparray_init_state *led_init_state)
> +{
> +	int ret;
> +	struct lamparray_device *ldev;
> +
> +	if (!hdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	struct lamparray *la __free(kfree) =3D kzalloc_obj(*la, GFP_KERNEL);
> +	if (!la)
> +		return ERR_PTR(-ENOMEM);

[ ... ]

> +	/* No locking needed, no races are possible before sysfs setup. */
> +	ret =3D lamparray_register_led(ldev);
> +	if (ret) {
> +		hid_warn(hdev, "Failed to register LED UAPI: %d\n", ret);
> +		ldev->use_leds_uapi =3D false;
> +	}
> +
> +	ret =3D xa_err(xa_store(&lamparray_by_hdev, (unsigned long)hdev, ldev,
> +			      GFP_KERNEL));
> +	if (ret)
> +		goto err_unregister_led;
> +
> +	ret =3D lamparray_register_sysfs(ldev);
> +	if (ret)
> +		goto err_xa_erase;
> +
> +	ret =3D lamparray_hw_set_autonomous(ldev, false);
> +	if (ret) {
> +		hid_err(hdev, "Could not disable autonomous mode: %d", ret);
> +		goto err_remove_sysfs;
> +	}
> +
> +	hid_info(hdev, "LampArray device registered\n");
> +
> +	ret =3D lamparray_restore_state(ldev);
> +	if (ret) {
> +		hid_err(hdev, "Failed to set default state: %d", ret);
> +		goto err_remove_sysfs;
> +	}
> +
> +	return_ptr(la);
> +
> +err_remove_sysfs:
> +	lamparray_remove_sysfs(ldev);
> +err_xa_erase:
> +	xa_erase(&lamparray_by_hdev, (unsigned long)hdev);
> +err_unregister_led:
> +	mutex_lock(&ldev->sysfs_lock);
> +	lamparray_unregister_led(ldev);
> +	mutex_unlock(&ldev->sysfs_lock);
> +err_free:
> +	mutex_destroy(&ldev->dev_lock);
> +	mutex_destroy(&ldev->sysfs_lock);
> +	return ERR_PTR(ret);
> +}

[Severity: Medium]
Does the registration order in lamparray_register() expose the LED classdev=
 and
use_leds_uapi sysfs attribute before the hardware is initialized?

Here, lamparray_register_led(), xa_store(), and lamparray_register_sysfs()
expose /sys/class/leds/rgb:<function> and
/sys/bus/hid/devices/<id>/use_leds_uapi before
lamparray_hw_set_autonomous(ldev, false) and lamparray_restore_state(ldev) =
are
called, and without holding ldev->sysfs_lock:

1. If userspace writes 0 to use_leds_uapi immediately after
   lamparray_register_sysfs(), use_leds_uapi_store() unregisters the LED and
   enables autonomous mode, and then lamparray_register() calls
   lamparray_hw_set_autonomous(ldev, false), leaving autonomous mode disabl=
ed
   while use_leds_uapi is 0. Likewise, lamparray_restore_state() checks
   !ldev->use_leds_uapi without holding sysfs_lock or dev_lock, and will
   overwrite any brightness or color set by udev or LED triggers after
   lamparray_register_led().

2. If lamparray_register_led() fails, ldev->use_leds_uapi is set to false, =
but
   lamparray_register() still calls lamparray_hw_set_autonomous(ldev, false)
   even though no LED class device was registered.

3. If lamparray_restore_state() fails after
   lamparray_hw_set_autonomous(ldev, false) succeeded, the err_remove_sysfs
   error path does not call lamparray_hw_set_autonomous(ldev, true) to rest=
ore
   autonomous mode.

Should autonomous mode be disabled and the initial state applied before
registering the LED classdev and sysfs attribute?

> +EXPORT_SYMBOL_GPL(lamparray_register);
> +
> +void lamparray_unregister(struct lamparray *la)
> +{
> +	struct lamparray_device *ldev;
> +
> +	if (!la)
> +		return;
> +
> +	ldev =3D &la->ldev;
> +
> +	lamparray_hw_set_autonomous(ldev, true);
> +
> +	lamparray_remove_sysfs(ldev);
> +	xa_erase(&lamparray_by_hdev, (unsigned long)ldev->hdev);
> +
> +	mutex_lock(&ldev->sysfs_lock);
> +	lamparray_unregister_led(ldev);
> +	mutex_unlock(&ldev->sysfs_lock);

[Severity: Medium]
In lamparray_unregister(), isn't the teardown order inverted relative to
use_leds_uapi_store()?

lamparray_hw_set_autonomous(ldev, true) is called before
lamparray_remove_sysfs(), xa_erase(), and lamparray_unregister_led(). While=
 the
sysfs attribute and LED classdev are still registered, a concurrent write o=
f 1
to use_leds_uapi_store() can disable autonomous mode again, or pending
cdev->set_brightness_work / blink timers (which are only flushed inside
led_classdev_unregister() during lamparray_unregister_led()) can run
lamparray_led_brightness_set() -> lamparray_hw_set_state() after autonomous
mode was re-enabled.

Also, because lamparray_hw_set_autonomous() submits HID_REQ_SET_REPORT via
hid_hw_request() (which is asynchronous on transports like usbhid) without
calling hid_hw_wait(ldev->hdev), if the caller invokes hid_hw_stop(hdev)
immediately after lamparray_unregister(), can usbhid_stop() cancel the
in-flight control request before autonomous mode is restored?

> +
> +	mutex_destroy(&ldev->dev_lock);
> +	mutex_destroy(&ldev->sysfs_lock);
> +	kfree(la);
> +}
> +EXPORT_SYMBOL_GPL(lamparray_unregister);

[ ... ]

> diff --git a/include/linux/hid-lamparray.h b/include/linux/hid-lamparray.h
> new file mode 100644
> index 0000000000000..6124878859392
> --- /dev/null
> +++ b/include/linux/hid-lamparray.h
> @@ -0,0 +1,89 @@

[ ... ]

> +/**
> + * lamparray_register() - initialize LampArray support for a HID device
> + * @hdev: HID device
> + * @led_init_state: Optional LED state at init specification
> + *
> + * Allocate and initialize internal LampArray state for the given HID de=
vice.
> + * The function parses required HID reports and fields and registers the
> + * associated miscdevice and sysfs attributes.
> + *
> + * Registers a multicolor LED class device to expose the LampArray funct=
ionality
> + * via the LED subsystem. If specified, the desired initial LED state is
> + * applied. If led_init_state is NULL, a default state is applied (white=
 with
> + * zero brightness).
> + *
> + * Return: pointer to a LampArray handle on success, or ERR_PTR() on fai=
lure.
> + */
> +struct lamparray *lamparray_register(struct hid_device *hdev,
> +				     const struct lamparray_init_state *led_init_state);
> +
> +/**
> + * lamparray_unregister() - tear down LampArray support
> + * @la: LampArray handle returned by lamparray_register()
> + *
> + * Remove all resources associated with a LampArray instance.
> + *
> + * This unregisters the LED class device (if present), removes the miscd=
evice
> + * and sysfs interfaces and frees all internal state associated with @la.
> + */
> +void lamparray_unregister(struct lamparray *la);

[Severity: Low]
This isn't a bug, but the kernel-doc comments for lamparray_register() and
lamparray_unregister() mention registering and removing a miscdevice, which
does not exist in the implementation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-hid-lampar=
ray-v7-0-47418b667b47@tuxedocomputers.com?part=3D1
