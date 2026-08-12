Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62737362152;
	Wed, 12 Aug 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573612; cv=none; b=jnsuiuNsniDOQrBOuhM5mb+CxcJ8KVY2BgOXgc0Gid/3lnJZ0+GxTc9oG6kD9ayyPjk8L6m9KbpQr664zr4R6Lh3M16eQI/wnW2qH4QoszoO/gYxChGNPjD9pzXStBEiQdKstB7a5v9ZK8Dk4lf3+hgHprVkdm0U0qK+NZTH+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573612; c=relaxed/simple;
	bh=5PPEt2ey4QDXaj58pIRFvY2ldH9nzgwFnfjomfDGkUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L66nJXTEGo61CQm3b+VXCSUA/+ioT51i/rim6NhGXNtOo7PmJwgSjwIpC9hnHVkWAnuU97YdCrP+XaDNC0iWRHSiYPKwQ2Mt6GOz3QlaJmTiI6HvkFdEOfcki4pYk3/xQuNwPqhobtovIL2J2bcveU+lttG+7bisYURKviHzRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 564B63E97F;
	Wed, 12 Aug 2026 22:26:46 +0000 (UTC)
Message-ID: <72ffd65c9bda6e22bb2939c4e07917c5eff20f51.camel@hadess.net>
Subject: Re: [PATCH v3 1/2] HID: logitech-hidpp: add HID++ 2.0
 reprogrammable button support
From: Bastien Nocera <hadess@hadess.net>
To: Elliot Douglas <edouglas7358@gmail.com>, linux-input@vger.kernel.org
Cc: lains@riseup.net, jikos@kernel.org, bentiss@kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 13 Aug 2026 00:26:45 +0200
In-Reply-To: <20260812195842.77724-2-edouglas7358@gmail.com>
References: <20260812195842.77724-1-edouglas7358@gmail.com>
	 <20260812195842.77724-2-edouglas7358@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEB2JKPV17TsUS176Vvt/l0Mp5ca4e0Cf9aBoDURA4eTWNQKskemruJca5m5oNJH0XuQLmMSVOPPF6JTulGbyEUdEbcDyyEmVlW8IJ41Zx+V2CFAlYUzkuy1CmM+hmFD8CvL4UWKoer/pGPnzsNACUKZXs/sDygJDeSsXj3jeB1W7XCDPVxbjb1/tbmoJBV0guGGwDaPbxlkuNr9Y+G8zHSNNW8NgHyW8GcYxnQgY6MSFoUJ2W2Thwqj3OWj+zMpAJhiIr+I7fSy50rycSBXG/ab/bvSwSSWWlGBYXbPOTlK4+xKDc874UihtE6of9WbnQBtONcD/z/ByLIJUxoV1WmNaooO7LSADKn2xbhGMW2JqtX2MJT2Qu+2QJA4ULMGXwbLr2xENn9gHhBM9PsWJi15dx421S5VRIE0LzyCihV9Xdfpf9+uBeAZghsZQlvq4klZzKf9QPAfdNVsK5Cf/XxMuNCyX+3tv6yo6G/tMaFovHoa8u41AJqPQpihlS15ZztUB4TMvWSgqlZHVaWpT3fGhqjd7zXOf6K+6kRRH6+r2r3w1w0soDkVCJHAo+oqYD2jNmvlCRFvsUB+rXKTKPFrYebF8ynLmKBt1jWPjLmTiurPpzvOnYpeWoX0UTU+DNZsjHyGqeo/PfNgJcMVIu2fy59nLtAKryyl8KLnL5yEQ

On Wed, 2026-08-12 at 12:58 -0700, Elliot Douglas wrote:
> Some Logitech HID++ 2.0 mice can report diverted reprogrammable
> controls
> through HID++ feature 0x1b04, SpecialKeysMseButtons /
> REPROG_CONTROLS_V4,
> instead of the normal HID mouse report.
>=20
> Add a quirk-gated event path for those controls. The handler
> temporarily
> diverts verified per-product controls, parses divertedButtonsEvent as
> the
> current pressed-control list, and reports the corresponding evdev key
> state
> for every mapped control.
>=20
> Keep the control mappings in per-product arrays so adding support for
> another mouse does not change the evdev capabilities advertised by
> already-supported devices.
>=20
> Documentation for feature 0x1b04 describes divertedButtonsEvent as a
> list
> of currently pressed diverted buttons, which is the event format
> handled
> here.
>=20
> Link:
> https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebuttons.html
> Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>

My earlier
Reviewed-by: Bastien Nocera <hadess@hadess.net>
was for both patches in the patch set :)

Thanks for v3.

> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 205
> +++++++++++++++++++++++++++++++
> =C2=A01 file changed, 205 insertions(+)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 70ba1a5e40d8..f9189e14fb78 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -76,6 +76,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
> =C2=A0#define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(28)
> =C2=A0#define HIDPP_QUIRK_WIRELESS_STATUS		BIT(29)
> =C2=A0#define HIDPP_QUIRK_RESET_HI_RES_SCROLL		BIT(30)
> +#define HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS	BIT(31)
> =C2=A0
> =C2=A0/* These are just aliases for now */
> =C2=A0#define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
> @@ -178,6 +179,8 @@ struct hidpp_scroll_counter {
> =C2=A0	unsigned long long last_time;
> =C2=A0};
> =C2=A0
> +struct hidpp_reprog_control_mapping;
> +
> =C2=A0struct hidpp_device {
> =C2=A0	struct hid_device *hid_dev;
> =C2=A0	struct input_dev *input;
> @@ -205,6 +208,8 @@ struct hidpp_device {
> =C2=A0	struct hidpp_scroll_counter vertical_wheel_counter;
> =C2=A0
> =C2=A0	u8 wireless_feature_index;
> +	u8 reprog_controls_feature_index;
> +	const struct hidpp_reprog_control_mapping *reprog_controls;
> =C2=A0
> =C2=A0	int hires_wheel_multiplier;
> =C2=A0	u8 hires_wheel_feature_index;
> @@ -3601,6 +3606,195 @@ static int
> hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
> =C2=A0	return 1;
> =C2=A0}
> =C2=A0
> +/* -----------------------------------------------------------------
> --------- */
> +/* HID++2.0 reprogrammable
> controls=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +/* -----------------------------------------------------------------
> --------- */
> +
> +#define HIDPP_PAGE_REPROG_CONTROLS_V4			0x1b04
> +
> +#define HIDPP_REPROG_CONTROLS_GET_COUNT			0x00
> +#define HIDPP_REPROG_CONTROLS_GET_CID_INFO		0x10
> +#define HIDPP_REPROG_CONTROLS_SET_CONTROL_REPORTING	0x30
> +
> +#define HIDPP_REPROG_CONTROLS_FLAG_MOUSE		BIT(0)
> +#define HIDPP_REPROG_CONTROLS_FLAG_DIVERT		BIT(5)
> +
> +#define HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED	BIT(0)
> +#define HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT	BIT(1)
> +
> +#define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED		0x00
> +
> +struct hidpp_reprog_control_mapping {
> +	u16 control;
> +	u16 code;
> +};
> +
> +static const struct hidpp_reprog_control_mapping *
> +hidpp20_reprog_controls_get_mappings(struct hidpp_device *hidpp)
> +{
> +	return NULL;
> +}
> +
> +static int hidpp20_reprog_controls_get_count(struct hidpp_device
> *hidpp)
> +{
> +	struct hidpp_report response;
> +	u8 feature_index =3D hidpp->reprog_controls_feature_index;
> +	u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_COUNT;
> +	int ret;
> +
> +	ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd,
> NULL, 0,
> +					=C2=A0 &response);
> +	if (ret > 0)
> +		return -EPROTO;
> +	if (ret)
> +		return ret;
> +
> +	return response.fap.params[0];
> +}
> +
> +static int hidpp20_reprog_controls_get_cid_info(struct hidpp_device
> *hidpp,
> +						u8 index, u16
> *control,
> +						u8 *flags)
> +{
> +	struct hidpp_report response;
> +	u8 feature_index =3D hidpp->reprog_controls_feature_index;
> +	u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_CID_INFO;
> +	int ret;
> +
> +	ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd,
> &index,
> +					=C2=A0 sizeof(index), &response);
> +	if (ret > 0)
> +		return -EPROTO;
> +	if (ret)
> +		return ret;
> +
> +	*control =3D get_unaligned_be16(&response.fap.params[0]);
> +	*flags =3D response.fap.params[4];
> +
> +	return 0;
> +}
> +
> +static bool hidpp20_reprog_controls_find_control(struct hidpp_device
> *hidpp,
> +						 u16 control)
> +{
> +	int count, ret;
> +	u16 cid;
> +	u8 flags;
> +	int i;
> +
> +	count =3D hidpp20_reprog_controls_get_count(hidpp);
> +	if (count < 0)
> +		return false;
> +
> +	for (i =3D 0; i < count; i++) {
> +		ret =3D hidpp20_reprog_controls_get_cid_info(hidpp, i,
> &cid,
> +							=C2=A0=C2=A0 &flags);
> +		if (ret)
> +			return false;
> +
> +		if (cid =3D=3D control)
> +			return (flags &
> HIDPP_REPROG_CONTROLS_FLAG_MOUSE) &&
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (flags &
> HIDPP_REPROG_CONTROLS_FLAG_DIVERT);
> +	}
> +
> +	return false;
> +}
> +
> +static int hidpp20_reprog_controls_set_control_reporting(struct
> hidpp_device *hidpp,
> +							 u16
> control, u8 flags)
> +{
> +	struct hidpp_report response;
> +	u8 params[5];
> +
> +	put_unaligned_be16(control, &params[0]);
> +	params[2] =3D flags;
> +	put_unaligned_be16(control, &params[3]);
> +
> +	return hidpp_send_fap_command_sync(hidpp,
> +					=C2=A0=C2=A0 hidpp-
> >reprog_controls_feature_index,
> +					=C2=A0=C2=A0
> HIDPP_REPROG_CONTROLS_SET_CONTROL_REPORTING,
> +					=C2=A0=C2=A0 params, sizeof(params),
> &response);
> +}
> +
> +static void hidpp20_reprog_controls_connect(struct hidpp_device
> *hidpp)
> +{
> +	const struct hidpp_reprog_control_mapping *mapping;
> +	u8 flags =3D HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED |
> +		=C2=A0=C2=A0 HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT;
> +
> +	if (!(hidpp->quirks &
> HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS))
> +		return;
> +
> +	if (!hidpp->reprog_controls)
> +		return;
> +
> +	if (hidpp_root_get_feature(hidpp,
> HIDPP_PAGE_REPROG_CONTROLS_V4,
> +				=C2=A0=C2=A0 &hidpp-
> >reprog_controls_feature_index))
> +		return;
> +
> +	for (mapping =3D hidpp->reprog_controls; mapping->control;
> mapping++) {
> +		if (!hidpp20_reprog_controls_find_control(hidpp,
> mapping->control))
> +			continue;
> +
> +		hidpp20_reprog_controls_set_control_reporting(hidpp,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> mapping->control,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> flags);
> +	}
> +}
> +
> +static int hidpp20_reprog_controls_raw_event(struct hidpp_device
> *hidpp,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, int size)
> +{
> +	const struct hidpp_reprog_control_mapping *mapping;
> +	struct hidpp_report *report =3D (struct hidpp_report *)data;
> +	u16 controls[4];
> +	bool pressed;
> +	unsigned int i, j;
> +
> +	if (!(hidpp->quirks &
> HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) ||
> +	=C2=A0=C2=A0=C2=A0 !hidpp->input ||
> +	=C2=A0=C2=A0=C2=A0 !hidpp->reprog_controls ||
> +	=C2=A0=C2=A0=C2=A0 hidpp->reprog_controls_feature_index =3D=3D 0xff)
> +		return 0;
> +
> +	if (size < HIDPP_REPORT_LONG_LENGTH ||
> +	=C2=A0=C2=A0=C2=A0 report->fap.feature_index !=3D hidpp-
> >reprog_controls_feature_index ||
> +	=C2=A0=C2=A0=C2=A0 report->fap.funcindex_clientid !=3D
> HIDPP_REPROG_CONTROLS_EVENT_DIVERTED)
> +		return 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(controls); i++)
> +		controls[i] =3D get_unaligned_be16(&report-
> >fap.params[i * 2]);
> +
> +	for (mapping =3D hidpp->reprog_controls; mapping->control;
> mapping++) {
> +		pressed =3D false;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(controls); j++) {
> +			if (controls[j] =3D=3D mapping->control) {
> +				pressed =3D true;
> +				break;
> +			}
> +		}
> +
> +		input_report_key(hidpp->input, mapping->code,
> pressed);
> +	}
> +
> +	input_sync(hidpp->input);
> +
> +	return 1;
> +}
> +
> +static void hidpp20_reprog_controls_populate_input(struct
> hidpp_device *hidpp,
> +						=C2=A0=C2=A0 struct input_dev
> *input_dev)
> +{
> +	const struct hidpp_reprog_control_mapping *mapping;
> +
> +	if (!hidpp->reprog_controls)
> +		return;
> +
> +	for (mapping =3D hidpp->reprog_controls; mapping->control;
> mapping++)
> +		input_set_capability(input_dev, EV_KEY, mapping-
> >code);
> +}
> +
> =C2=A0static void hidpp10_extra_mouse_buttons_populate_input(
> =C2=A0			struct hidpp_device *hidpp, struct input_dev
> *input_dev)
> =C2=A0{
> @@ -3859,6 +4053,9 @@ static void hidpp_populate_input(struct
> hidpp_device *hidpp,
> =C2=A0
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS)
> =C2=A0		hidpp10_extra_mouse_buttons_populate_input(hidpp,
> input);
> +
> +	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS)
> +		hidpp20_reprog_controls_populate_input(hidpp,
> input);
> =C2=A0}
> =C2=A0
> =C2=A0static int hidpp_input_configured(struct hid_device *hdev,
> @@ -3971,6 +4168,10 @@ static int hidpp_raw_hidpp_event(struct
> hidpp_device *hidpp, u8 *data,
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> +	ret =3D hidpp20_reprog_controls_raw_event(hidpp, data, size);
> +	if (ret !=3D 0)
> +		return ret;
> +
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS)
> {
> =C2=A0		ret =3D hidpp10_consumer_keys_raw_event(hidpp, data,
> size);
> =C2=A0		if (ret !=3D 0)
> @@ -4264,6 +4465,8 @@ static void hidpp_connect_event(struct
> work_struct *work)
> =C2=A0			return;
> =C2=A0	}
> =C2=A0
> +	hidpp20_reprog_controls_connect(hidpp);
> +
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS)
> {
> =C2=A0		ret =3D hidpp10_consumer_keys_connect(hidpp);
> =C2=A0		if (ret)
> @@ -4436,6 +4639,8 @@ static int hidpp_probe(struct hid_device *hdev,
> const struct hid_device_id *id)
> =C2=A0	hidpp->hid_dev =3D hdev;
> =C2=A0	hidpp->name =3D hdev->name;
> =C2=A0	hidpp->quirks =3D id->driver_data;
> +	hidpp->reprog_controls_feature_index =3D 0xff;
> +	hidpp->reprog_controls =3D
> hidpp20_reprog_controls_get_mappings(hidpp);
> =C2=A0	hid_set_drvdata(hdev, hidpp);
> =C2=A0
> =C2=A0	ret =3D hid_parse(hdev);
