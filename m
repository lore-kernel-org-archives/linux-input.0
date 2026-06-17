Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F513DC87A;
	Wed, 17 Jun 2026 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692120; cv=none; b=bbVdQfEFsBF448TRJPvGfM5BfsMFFLxjkTdeQBRcU3BYPoyMdl9qPWitAP9GuJKy0yFq/Xg8l2K3qfbReM0FYTBZq1aFnKZoBYOveT8BYkJgGbFlHc8zXCWGWwEMaA5nhOmCNkjUpZvG2Jzqxrbw/wtKClOtYqoNJ57Bmt2JgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692120; c=relaxed/simple;
	bh=2JB0ljnSxLl8H3rnDcY1m9U6SNgyoFxjKYI+O5wnpak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBiZQ1ECwb3pE8+1ydbgTKHSJ6RGkNmP/FcZnSErn7GFXvBN+znjsmGU2C5s+N+ZNQbp9LYrBJw2qHr/P1sh8gKr+cCt3pvuW6Z49aLL/GNXRhV3Nq6zwg0ocTT0cAXnPq0zOFGGuAGMQzAWfn4JXnv+PoUyTJB2sOu2KGQ+6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42E273EC38;
	Wed, 17 Jun 2026 10:28:28 +0000 (UTC)
Message-ID: <f741bafd41f7fc31fe0019020e14ad4f99fd193e.camel@hadess.net>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add HID++ 2.0 reprogrammable
 button support
From: Bastien Nocera <hadess@hadess.net>
To: Elliot Douglas <edouglas7358@gmail.com>, linux-input@vger.kernel.org
Cc: lains@riseup.net, jikos@kernel.org, bentiss@kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 17 Jun 2026 12:28:27 +0200
In-Reply-To: <20260613175109.44365-2-edouglas7358@gmail.com>
References: <20260613175109.44365-1-edouglas7358@gmail.com>
	 <20260613175109.44365-2-edouglas7358@gmail.com>
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
X-GND-Cause: dmFkZTFfdXhow/k1eTFzCaHxZltsDAw3KOeixVcs1fIckJSjI9M8UYhkVjfNDFp3eJKUpTzWZtpvWTTcs1/PnUr8aWrXs99IoWtnYrz4TT53kQCXx3LMtNVkpbk4lpRDZcVCR03eC3u7VhjroQZwXVXHjeBqKeUZjwixInPS1xei141vMa4VGg2JO6fYM/BE4djc0SBF+fgZJvFAwjSJpSzH0HH9M67bEBgFRT91URUAWNxxNOQ5xkfQVxjO4zK6sHOUqFJTBuL6eYtM4DZlH4HRHIUEvTx96wlZieyeqa3FEjhl3nayS5oE0ZMDUnPrypSmaoMAoafuK94En4FkjNJvmCN3qdRudr6MNmdQJU4mS2AVrnGKoTix5s5PjjxV/tyuf2HKkTXucuLlIZhn6DhcGB05G765uXPRHtv9EBgNt33DUhOu6WbW3V9fUjkraVYbo55t0MI5zNAzlJHBdMhAMJqv1N5jcmJEf9GRCkYRWdOTXoxH7N1XO0+eYxUAwA5SH8zp6waJ8qdWXTVL92tKNA5TGdXHtq0IEWndb659WCaJ+Q9sd9Yt+dZm3+jr9H+ip4mGt78DE4c7NihkqbsT9wZiShZAoVRbprDcxsGKzM/+XM0w1+9DjAf7ro5KQ/Gzy9HdrOakZUIEzCtEtco3ErSSa/hfAiRm2/8+irRAk4POiw

On Sat, 2026-06-13 at 10:51 -0700, Elliot Douglas wrote:
> Some Logitech HID++ 2.0 mice can report diverted reprogrammable
> controls through HID++ feature 0x1b04, SpecialKeysMseButtons /
> REPROG_CONTROLS_V4, instead of the normal HID mouse report.
>=20
> Add a quirk-gated event path for those controls. The handler temporarily
> diverts verified per-product controls, parses divertedButtonsEvent as the
> current pressed-control list, and reports the corresponding evdev key sta=
te
> for every mapped control.
>=20
> Keep the control mappings in per-product profiles so adding support for
> another mouse does not change the evdev capabilities advertised by
> already-supported devices.

How does this forced setting work/clash with the programmable buttons
in Solaar?

I've added some inline comments below.

>=20
> Documentation for feature 0x1b04 describes divertedButtonsEvent as a list
> of currently pressed diverted buttons, which is the event format handled
> here.
>=20
> Link: https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebuttons.ht=
ml
>=20
> Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 215 ++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 215 insertions(+)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 70ba1a5e40d8..24c9cfaa4f37 100644
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
> @@ -205,6 +206,7 @@ struct hidpp_device {
> =C2=A0	struct hidpp_scroll_counter vertical_wheel_counter;
> =C2=A0
> =C2=A0	u8 wireless_feature_index;
> +	u8 reprog_controls_feature_index;
> =C2=A0
> =C2=A0	int hires_wheel_multiplier;
> =C2=A0	u8 hires_wheel_feature_index;
> @@ -3601,6 +3603,209 @@ static int hidpp10_extra_mouse_buttons_raw_event(=
struct hidpp_device *hidpp,
> =C2=A0	return 1;
> =C2=A0}
> =C2=A0
> +/* ---------------------------------------------------------------------=
----- */
> +/* HID++2.0 reprogrammable controls=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +/* ---------------------------------------------------------------------=
----- */
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
> +struct hidpp_reprog_controls_profile {
> +	const struct hidpp_reprog_control_mapping *mappings;

probably needs a __counted_by(), or maybe as it's static, it might be
better to not require an intermediate struct, and return a NULL-
terminated array instead.

> +	unsigned int mapping_count;
> +};
> +
> +static const struct hidpp_reprog_controls_profile *
> +hidpp20_reprog_controls_get_profile(struct hidpp_device *hidpp)
> +{
> +	return NULL;
> +}
> +
> +static int hidpp20_reprog_controls_get_count(struct hidpp_device *hidpp)
> +{
> +	struct hidpp_report response;
> +	u8 feature_index =3D hidpp->reprog_controls_feature_index;
> +	u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_COUNT;
> +	int ret;
> +
> +	ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd, NULL, 0,
> +					=C2=A0 &response);
> +	if (ret > 0)
> +		return -EPROTO;
> +	if (ret)
> +		return ret;
> +
> +	return response.fap.params[0];
> +}
> +
> +static int hidpp20_reprog_controls_get_cid_info(struct hidpp_device *hid=
pp,
> +						u8 index, u16 *control,
> +						u8 *flags)
> +{
> +	struct hidpp_report response;
> +	u8 feature_index =3D hidpp->reprog_controls_feature_index;
> +	u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_CID_INFO;
> +	int ret;
> +
> +	ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd, &index,
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
> +static bool hidpp20_reprog_controls_find_control(struct hidpp_device *hi=
dpp,
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
> +		ret =3D hidpp20_reprog_controls_get_cid_info(hidpp, i, &cid,
> +							=C2=A0=C2=A0 &flags);
> +		if (ret)
> +			return false;
> +
> +		if (cid =3D=3D control)
> +			return (flags & HIDPP_REPROG_CONTROLS_FLAG_MOUSE) &&
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (flags & HIDPP_REPROG_CONTROLS_F=
LAG_DIVERT);
> +	}
> +
> +	return false;
> +}
> +
> +static int hidpp20_reprog_controls_set_control_reporting(struct hidpp_de=
vice *hidpp,
> +							 u16 control, u8 flags)
> +{
> +	struct hidpp_report response;
> +	u8 params[5];
> +
> +	put_unaligned_be16(control, &params[0]);
> +	params[2] =3D flags;
> +	put_unaligned_be16(control, &params[3]);
> +
> +	return hidpp_send_fap_command_sync(hidpp,
> +					=C2=A0=C2=A0 hidpp->reprog_controls_feature_index,
> +					=C2=A0=C2=A0 HIDPP_REPROG_CONTROLS_SET_CONTROL_REPORTING,
> +					=C2=A0=C2=A0 params, sizeof(params), &response);
> +}
> +
> +static void hidpp20_reprog_controls_connect(struct hidpp_device *hidpp)
> +{
> +	const struct hidpp_reprog_controls_profile *profile;
> +	u8 flags =3D HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED |
> +		=C2=A0=C2=A0 HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT;
> +	unsigned int i;
> +
> +	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS))
> +		return;
> +
> +	profile =3D hidpp20_reprog_controls_get_profile(hidpp);

Could the profile be cached in the hidpp_device struct?

> +	if (!profile)
> +		return;
> +
> +	if (hidpp_root_get_feature(hidpp, HIDPP_PAGE_REPROG_CONTROLS_V4,
> +				=C2=A0=C2=A0 &hidpp->reprog_controls_feature_index))
> +		return;
> +
> +	for (i =3D 0; i < profile->mapping_count; i++) {
> +		u16 control =3D profile->mappings[i].control;
> +
> +		if (!hidpp20_reprog_controls_find_control(hidpp, control))
> +			continue;
> +
> +		hidpp20_reprog_controls_set_control_reporting(hidpp, control, flags);
> +	}
> +}
> +
> +static int hidpp20_reprog_controls_raw_event(struct hidpp_device *hidpp,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, int size)
> +{
> +	const struct hidpp_reprog_controls_profile *profile;
> +	const struct hidpp_reprog_control_mapping *mapping;
> +	struct hidpp_report *report =3D (struct hidpp_report *)data;
> +	u16 controls[4];
> +	bool pressed;
> +	unsigned int i, j;
> +
> +	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) ||
> +	=C2=A0=C2=A0=C2=A0 !hidpp->input ||
> +	=C2=A0=C2=A0=C2=A0 hidpp->reprog_controls_feature_index =3D=3D 0xff)
> +		return 0;
> +
> +	profile =3D hidpp20_reprog_controls_get_profile(hidpp);
> +	if (!profile)
> +		return 0;
> +
> +	if (size < HIDPP_REPORT_LONG_LENGTH ||
> +	=C2=A0=C2=A0=C2=A0 report->fap.feature_index !=3D hidpp->reprog_control=
s_feature_index ||
> +	=C2=A0=C2=A0=C2=A0 report->fap.funcindex_clientid !=3D HIDPP_REPROG_CON=
TROLS_EVENT_DIVERTED)
> +		return 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(controls); i++)
> +		controls[i] =3D get_unaligned_be16(&report->fap.params[i * 2]);
> +
> +	for (i =3D 0; i < profile->mapping_count; i++) {
> +		mapping =3D &profile->mappings[i];
> +		pressed =3D false;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(controls); j++) {
> +			if (controls[j] =3D=3D mapping->control) {
> +				pressed =3D true;
> +				break;
> +			}
> +		}
> +
> +		input_report_key(hidpp->input, mapping->code, pressed);
> +	}
> +
> +	input_sync(hidpp->input);
> +
> +	return 1;
> +}
> +
> +static void hidpp20_reprog_controls_populate_input(struct hidpp_device *=
hidpp,
> +						=C2=A0=C2=A0 struct input_dev *input_dev)
> +{
> +	const struct hidpp_reprog_controls_profile *profile;
> +	unsigned int i;
> +
> +	profile =3D hidpp20_reprog_controls_get_profile(hidpp);
> +	if (!profile)
> +		return;
> +
> +	for (i =3D 0; i < profile->mapping_count; i++)
> +		input_set_capability(input_dev, EV_KEY, profile->mappings[i].code);
> +}
> +
> =C2=A0static void hidpp10_extra_mouse_buttons_populate_input(
> =C2=A0			struct hidpp_device *hidpp, struct input_dev *input_dev)
> =C2=A0{
> @@ -3859,6 +4064,9 @@ static void hidpp_populate_input(struct hidpp_devic=
e *hidpp,
> =C2=A0
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS)
> =C2=A0		hidpp10_extra_mouse_buttons_populate_input(hidpp, input);
> +
> +	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS)
> +		hidpp20_reprog_controls_populate_input(hidpp, input);
> =C2=A0}
> =C2=A0
> =C2=A0static int hidpp_input_configured(struct hid_device *hdev,
> @@ -3971,6 +4179,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_devi=
ce *hidpp, u8 *data,
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> +	ret =3D hidpp20_reprog_controls_raw_event(hidpp, data, size);
> +	if (ret !=3D 0)
> +		return ret;
> +
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
> =C2=A0		ret =3D hidpp10_consumer_keys_raw_event(hidpp, data, size);
> =C2=A0		if (ret !=3D 0)
> @@ -4264,6 +4476,8 @@ static void hidpp_connect_event(struct work_struct =
*work)
> =C2=A0			return;
> =C2=A0	}
> =C2=A0
> +	hidpp20_reprog_controls_connect(hidpp);
> +
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
> =C2=A0		ret =3D hidpp10_consumer_keys_connect(hidpp);
> =C2=A0		if (ret)
> @@ -4436,6 +4650,7 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> =C2=A0	hidpp->hid_dev =3D hdev;
> =C2=A0	hidpp->name =3D hdev->name;
> =C2=A0	hidpp->quirks =3D id->driver_data;
> +	hidpp->reprog_controls_feature_index =3D 0xff;
> =C2=A0	hid_set_drvdata(hdev, hidpp);
> =C2=A0
> =C2=A0	ret =3D hid_parse(hdev);
