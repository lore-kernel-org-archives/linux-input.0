Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D43B27D8;
	Wed, 17 Jun 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692125; cv=none; b=B9xMWtNltwnyifi86oYQnULC0HhA/ALUMMpqy3H6kq68ogYap6O0sbh6kNQ3Xrvqtum550XtxjCPjoLl7MQvZnfjaOYusUM3akRlGkpM5yjVueKtzkYiBfBgzjCftZSkUYOClZSBG9nVq+gfcR067tIG7N0qXm+fHtc72cW6BMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692125; c=relaxed/simple;
	bh=BuYYPUNoWW9o/E4gxHLkpIDDQ0/vP/s3fieZ9Ja6aMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KcDBZ/lTNj2SiNhMNlOJRgi20c2tBWzblllSo5Gvwa4LzwYeeB3DVeZBTLM2tDc3dtxPg5wqDCojG32ojfkru0htSqfhX/wM1ssTpfZGTWMfVhI1n4iU/mTvqebiJM8KSq5bEh0tSWphuMRWbiAzFu3Sq0Dd9Uvl8OYvhlUzdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 466313E972;
	Wed, 17 Jun 2026 10:28:31 +0000 (UTC)
Message-ID: <a67d0483b35e20cf126fc66efefded786480b169.camel@hadess.net>
Subject: Re: [PATCH 2/2] HID: logitech-hidpp: enable reprogrammable buttons
 on Signature M650
From: Bastien Nocera <hadess@hadess.net>
To: Elliot Douglas <edouglas7358@gmail.com>, linux-input@vger.kernel.org
Cc: lains@riseup.net, jikos@kernel.org, bentiss@kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 17 Jun 2026 12:28:30 +0200
In-Reply-To: <20260613175109.44365-3-edouglas7358@gmail.com>
References: <20260613175109.44365-1-edouglas7358@gmail.com>
	 <20260613175109.44365-3-edouglas7358@gmail.com>
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
X-GND-Cause: dmFkZTGrGfJDIwwjmHHhZdmDMkXbZuIYYRNagew85RIToSHMQ72I4Hq9I/U0FJmSu/Bh5gvkIj6rMSdZexo/+e6aHCywRmoqI0/fxMtvpN7xHt40edf1ymgM3Dr6CHrLPoz0QjYRIbbSJxlhnEFKrRMjxoQKomXxFqZ2pxAAgPPQtsdbBGOLm1ehLeNyOXJXCvTPmUepvvSMW988RJB6OF/PDITmi/IYQ7HfP1KgJW7Iv3rRSgHIbP3XEu+0xf+R0bfxx1yc3ibdWJm2yNfN/7JI2Skg0T668rl5jNBJKr2PYrGspChLgniBqmXOnh9PUavz2jg+gqszGKTPHniQyc7MuFhZWl/ww3vdpwD4Tz9A9R5U+MpIKMiHgnO5fHAkLwq37Kw/h4n7nU/mbFst7MApfOqhMclWH7xVBCK2yuFlMt25UJflznDgfhqWWPWJ2+ZJn71Gic20YEzDdW2HVJglioqyHmz0l4PNOt8E63SHaL3uJe0GnpAo+AdfjXYU0b6KOguuXBpU/47UDGL/xhpsjVWe4LimCtvr8onPYvBErXnTSd+2A2DUYJ69Pp4TMmm83s7TMvh+rHbHq7hzWLltrUN/Awl7JKw8SUnIZNtZKXPulYxXudoe2OllZvav82diVkXUVnvDYxl7zFqb5JeNznT1tgzxiYi668uocMme6/b0jg

Hey Elliot,

I have an m650 on hand on with which I should be able to test your
patch next week, once we've gone through a first round of reviews.

Benjamin, is there something I can capture locally that could make it
into the HID tests for this feature?

Inline comments below

On Sat, 2026-06-13 at 10:51 -0700, Elliot Douglas wrote:
> The Bluetooth Signature M650 exposes its side buttons through the
> normal
> mouse report, but the observed events are short click-like events
> emitted
> around release rather than physical press/release state.
>=20
> The device appears to use the held side-button state for its built-in
> gesture and side-button + wheel horizontal-scroll mode. As a result,
> holding a side button long enough can prevent the normal mouse report
> from
> emitting a usable button event at all.
>=20
> HID++ REPROG_CONTROLS_V4 diversion for control IDs 0x0053 and 0x0056
> provides real press and release timing for those same controls.
> Logitech
> documents the Signature M650 side buttons as Back/Forward buttons, so
> report the diverted controls as BTN_BACK and BTN_FORWARD.
>=20
> Link:
> https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-=
Signature-M650
>=20
> Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 21 ++++++++++++++++++++-
> =C2=A01 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 24c9cfaa4f37..80108778ee80 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3621,6 +3621,9 @@ static int
> hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
> =C2=A0
> =C2=A0#define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED		0x00
> =C2=A0
> +#define HIDPP_REPROG_CONTROL_M650_BACK			0x0053
> +#define HIDPP_REPROG_CONTROL_M650_FORWARD		0x0056

I read through the 0x1b04 docs, and I'm trying to understand whether
those CID numbers change in different hardware, or if they're hardcoded
(a back button will always have the 83/0x53 value).

Seems to me that it's the latter? The back button is listed in the
Example Control ID table in the 0x1b04 docs.

> +
> =C2=A0struct hidpp_reprog_control_mapping {
> =C2=A0	u16 control;
> =C2=A0	u16 code;
> @@ -3631,9 +3634,24 @@ struct hidpp_reprog_controls_profile {
> =C2=A0	unsigned int mapping_count;
> =C2=A0};
> =C2=A0
> +static const struct hidpp_reprog_control_mapping
> m650_reprog_control_mappings[] =3D {
> +	{ HIDPP_REPROG_CONTROL_M650_BACK, BTN_BACK },
> +	{ HIDPP_REPROG_CONTROL_M650_FORWARD, BTN_FORWARD },
> +};
> +
> +static const struct hidpp_reprog_controls_profile
> m650_reprog_controls_profile =3D {
> +	.mappings =3D m650_reprog_control_mappings,
> +	.mapping_count =3D ARRAY_SIZE(m650_reprog_control_mappings),
> +};
> +
> =C2=A0static const struct hidpp_reprog_controls_profile *
> =C2=A0hidpp20_reprog_controls_get_profile(struct hidpp_device *hidpp)
> =C2=A0{
> +	switch (hidpp->hid_dev->product) {
> +	case 0xb02a:

You probably want a define for that constant.

> +		return &m650_reprog_controls_profile;
> +	}
> +
> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0
> @@ -4921,7 +4939,8 @@ static const struct hid_device_id
> hidpp_devices[] =3D {
> =C2=A0	{ /* MX Vertical mouse over Bluetooth */
> =C2=A0	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb020) },
> =C2=A0	{ /* Signature M650 over Bluetooth */
> -	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
> +	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a),
> +	=C2=A0 .driver_data =3D HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
> =C2=A0	{ /* MX Master 3 mouse over Bluetooth */
> =C2=A0	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
> =C2=A0	{ /* MX Anywhere 3 mouse over Bluetooth */
