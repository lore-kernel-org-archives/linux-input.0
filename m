Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D5387345;
	Mon,  9 Mar 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050017; cv=none; b=rFjRy9+CyQBTMpnVdvKC8KW8XtB+RuL6kUYOsN4d6NKeVwFzMZqW/1JZJqKPFr0KriFLphr5LtZDU9zUzvVq/lwNPHrkd3JExJTDKp1RzERzK9kIBNMX27nYIguYWhGduXHEXCWc4D1qSZDR2CxhL3Sg7fX6wMS4r2B1Y0GS34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050017; c=relaxed/simple;
	bh=wVJEEG4lYFwzKMHRd2FGkl1YL6i/XEsMv9i4AvUW2GA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQMe5oNwizW2AVtgpsVOV4hnUmQPQxMZFLFdVh+Zc0Rgjy1nGTyu9CXvderShlaNP/pef95096ZWvUjMz9G7wbaHAWsJrkgxqo818t1+N0vjhreyyFRimfrq/Y8ZEtpSQQBWBS/TpPk8tMJHNJcWJULfofPLAaKlkgwAVS93BOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6902941D3B;
	Mon,  9 Mar 2026 09:53:24 +0000 (UTC)
Message-ID: <b1a7b5ab35c5dc16753e6a4ce98837d26c0eb98a.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
From: Bastien Nocera <hadess@hadess.net>
To: DevExalt <exalt.dev.team@gmail.com>, jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	sari.kreitem@exalt.corp-partner.google.com,
 hbarnor@google.com
Date: Mon, 09 Mar 2026 10:53:23 +0100
In-Reply-To: <20251215125319.33261-1-exalt.dev.team@gmail.com>
References: <20251215125319.33261-1-exalt.dev.team@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieejffdutdevkedvheethedtvdekieeiffffleekgedvteeflefgkedtieehudejnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeiledtvdelgeduffefuedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepvgigrghlthguvghvthgvrghmsehgmhgrihhlrdgtohhmpdhrt
 ghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrihhnshesrhhishgvuhhprdhnvghtpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 49

Hey,

Sorry for not looking at this earlier, it slipped through the cracks as
it arrived on the mailing-list as I was away.

On Mon, 2025-12-15 at 14:53 +0200, DevExalt wrote:
> From: "Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>
>=20
> Add support in the Logitech HID++ driver for the HID++ Multi-Platform
> feature (0x4531), which enables HID++ devices to adjust their
> behavior
> based on the host operating system (Linux, ChromeOS, Android).

Can you please explain what the feature actually does ? (the Logitech
docs say "Set the right keyboard layout for your computer operating
system" and mention that some multimedia keys are inoperable unless a
compatible OS is set).

>=20
> This patch:
> =C2=A0* Adds device IDs for MX Keys S (046d:b378) and Casa Keys
> (046d:b371).
> =C2=A0* Introduces the module parameter "hidpp_platform" to allow
> selecting a
> =C2=A0=C2=A0 target platform.
> =C2=A0* Detects whether a device implements feature 0x4531.
> =C2=A0* Validates that the requested platform is supported by the device.
> =C2=A0* Applies the platform index when valid, otherwise leaves the devic=
e
> =C2=A0=C2=A0 unchanged.
> =C2=A0* Keeps default behavior when "hidpp_platform" is unset or invalid.

Can you explain the benefits of setting this module parameter, compared
to using the keyboard shortcuts to switch to a specific OS
configuration?

What happens when 2 Logitech devices with different supported OSes are
used?

> Supported values for hidpp_platform:
> =C2=A0=C2=A0 Android, Linux, Chrome

Any reason why there aren't more supported OSes?

The Logitech docs[1] lists:
WebOS iOS MacOS Android Chrome Linux WinEmb Windows Tizen
as possible values.

[1]:
https://drive.google.com/file/d/1KyiBA5m_5V1s6jQ9eQrgRJN0SbbbI9_I/view

I recently got a K980 which has this functionality, it only documents
Windows, macOS and Chrome, but Solaar also lists Linux as an option.

So my questions would be:
- why not support the whole range of possible OSes in this option?
- why is it a module option instead of, say, a sysfs attribute that
could be changed per device?
- why not implement this in user-space through a udev callout?

Cheers

>=20
> TEST=3DPair MX Keys S and Casa Keys over Bluetooth and verify:
> =C2=A0=C2=A0=C2=A0=C2=A0 * Feature 0x4531 is detected.
> =C2=A0=C2=A0=C2=A0=C2=A0 * Valid platform values are accepted and applied=
.
> =C2=A0=C2=A0=C2=A0=C2=A0 * Invalid platform values result in no update.
> =C2=A0=C2=A0=C2=A0=C2=A0 * Devices without 0x4531 retain default behavior=
.
> =C2=A0=C2=A0=C2=A0=C2=A0 * Platform-specific key behavior is observed onc=
e applied.
>=20
> Signed-off-by: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>
> ---
> =C2=A0drivers/hid/hid-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 280
> +++++++++++++++++++++++++++++++
> =C2=A0drivers/hid/hid-quirks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A03 files changed, 284 insertions(+)
>=20
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index d31711f1aaec..12de1194d7fa 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -866,6 +866,8 @@
> =C2=A0#define USB_DEVICE_ID_LOGITECH_T651	0xb00c
> =C2=A0#define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
> =C2=A0#define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD	0xbb00
> +#define USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD	0xb371
> +#define USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD	0xb378
> =C2=A0#define USB_DEVICE_ID_LOGITECH_C007	0xc007
> =C2=A0#define USB_DEVICE_ID_LOGITECH_C077	0xc077
> =C2=A0#define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index d5011a5d0890..e94daed31981 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4373,6 +4373,280 @@ static bool hidpp_application_equals(struct
> hid_device *hdev,
> =C2=A0	return report && report->application =3D=3D application;
> =C2=A0}
> =C2=A0
> +/* -----------------------------------------------------------------
> --------- */
> +/* 0x4531: Multi-Platform
> Support=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +/* -----------------------------------------------------------------
> --------- */
> +
> +/*
> + * Some Logitech devices expose the HID++ feature 0x4531 (Multi-
> Platform) allowing
> + * the host to specify which operating system platform to use on the
> device. Changing device's
> + * platform may alter the behavior of the device to match the
> specified platform.
> + */
> +
> +static char *hidpp_platform;
> +module_param(hidpp_platform, charp, 0644);
> +MODULE_PARM_DESC(hidpp_platform, "Select host platform type for
> Logitech HID++ Multi-Platform feature "
> +		 "0x4531, valid values: (linux|chrome|android).=C2=A0 If
> unset, no "
> +		 "change is applied.");
> +
> +#define HIDPP_MULTIPLATFORM_FEAT_ID			0x4531
> +#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO		0x0F
> +#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR	0x1F
> +#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM	0x3F
> +
> +#define
> HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX		BIT(10)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME	BIT(11)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID	BIT(12)
> +
> +struct hidpp_platform_desc {
> +	u8 plat_idx;
> +	u8 desc_idx;
> +	u16 plat_mask;
> +};
> +
> +/**
> + * hidpp_multiplatform_mask_from_str() - Convert platform name to an
> HID++ platform mask
> + * @pname: Platform name string
> + *
> + * Converts a platform name string to its corresponding HID++
> platform mask based on
> + * the Multi-Platform feature specification.
> + *
> + * Return: Platform mask corresponding to @pname on success,
> + * or 0 if @pname is NULL or unsupported.
> + */
> +static u16 hidpp_multiplatform_mask_from_str(const char *pname)
> +{
> +	if (!pname)
> +		return 0;
> +
> +	if (!strcasecmp(pname, "linux"))
> +		return HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX;
> +	if (!strcasecmp(pname, "chrome"))
> +		return HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME;
> +	if (!strcasecmp(pname, "android"))
> +		return HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID;
> +
> +	return 0;
> +}
> +
> +/**
> + * hidpp_multiplatform_get_num_pdesc() - Retrieve number of platform
> descriptors
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @num_desc: Pointer to store the number of platform descriptors
> + *
> + * Retrieves the number of platform descriptors supported by the
> device through
> + * the Multi-Platform feature and stores it in @num_desc.
> + *
> + * Return: 0 on success, or non-zero on failure.
> + */
> +static int hidpp_multiplatform_get_num_pdesc(struct hidpp_device
> *hidpp,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 u8 feat_index, u8
> *num_desc)
> +{
> +	int ret;
> +	struct hidpp_report response;
> +	struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +	ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> +					=C2=A0
> HIDPP_MULTIPLATFORM_GET_FEATURE_INFO,
> +					=C2=A0 NULL, 0, &response);
> +	if (ret) {
> +		hid_warn(hdev, "Multiplatform: GET_FEATURE_INFO
> failed (err=3D%d)", ret);
> +		return ret;
> +	}
> +
> +	*num_desc =3D response.fap.params[3];
> +	hid_dbg(hdev, "Multiplatform: Device supports %d platform
> descriptors", *num_desc);
> +
> +	return 0;
> +}
> +
> +/**
> + * hidpp_multiplatform_get_platform_desc() - Retrieve a platform
> descriptor entry
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @platform_idx: Index of the platform descriptor to retrieve
> + * @pdesc: Pointer to store the retrieved platform descriptor
> + *
> + * Retrieves a single platform descriptor identified by
> @platform_idx from the
> + * device and stores the parsed descriptor fields in @pdesc.
> + *
> + * Return: 0 on success, or non-zero on failure.
> + */
> +static int hidpp_multiplatform_get_platform_desc(struct hidpp_device
> *hidpp, u8 feat_index,
> +						 u8 platform_idx,
> struct hidpp_platform_desc *pdesc)
> +{
> +	int ret;
> +	struct hidpp_report response;
> +	u8 params[1] =3D { platform_idx };
> +	struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +	ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> +					=C2=A0
> HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR,
> +					=C2=A0 params, sizeof(params),
> &response);
> +
> +	if (ret) {
> +		hid_warn(hdev,
> +			 "Multiplatform: GET_PLATFORM_DESCRIPTOR
> failed for index %d (err=3D%d)",
> +			 platform_idx, ret);
> +		return ret;
> +	}
> +
> +	pdesc->plat_idx =3D response.fap.params[0];
> +	pdesc->desc_idx =3D response.fap.params[1];
> +	pdesc->plat_mask =3D
> get_unaligned_be16(&response.fap.params[2]);
> +
> +	hid_dbg(hdev,
> +		"Multiplatform: descriptor %d: plat_idx=3D%d,
> desc_idx=3D%d, plat_mask=3D0x%04x",
> +		platform_idx, pdesc->plat_idx, pdesc->desc_idx,
> pdesc->plat_mask);
> +
> +	return 0;
> +}
> +
> +/**
> + * hidpp_multiplatform_get_platform_index() - Find platform index
> for a mask
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @plat_mask: Platform mask to search for
> + * @plat_index: Pointer to store the matched platform index
> + *
> + * Iterates through all platform descriptors exposed by the device
> via the
> + * Multi-Platform feature, retrieving each descriptor and comparing
> its
> + * platform mask to @plat_mask. A descriptor matches if its mask
> overlaps with
> + * the requested @plat_mask (i.e. (pdesc.plat_mask & plat_mask) is
> non-zero).
> + *
> + * When a matching descriptor is found, its platform index
> (plat_idx) is
> + * written to @plat_index and the function returns success.
> + *
> + * If no descriptor matches, -ENOENT is returned.
> + *
> + * Return: 0 on success; -ENOENT if no matching descriptor exists;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or non-zero on failur=
e.
> + */
> +static int hidpp_multiplatform_get_platform_index(struct
> hidpp_device *hidpp,
> +						=C2=A0 u8 feat_index, u16
> plat_mask,
> +						=C2=A0 u8 *plat_index)
> +{
> +	int i;
> +	int ret;
> +	u8 num_desc;
> +	struct hidpp_platform_desc pdesc;
> +	struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +	ret =3D hidpp_multiplatform_get_num_pdesc(hidpp, feat_index,
> &num_desc);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < num_desc; i++) {
> +		ret =3D hidpp_multiplatform_get_platform_desc(hidpp,
> feat_index, i, &pdesc);
> +		if (ret)
> +			return ret;
> +
> +		if (pdesc.plat_mask & plat_mask) {
> +			*plat_index =3D pdesc.plat_idx;
> +			hid_dbg(hdev,
> +				"Multiplatform: Selected platform
> index %d for platform '%s'",
> +				*plat_index, hidpp_platform);
> +			return 0;
> +		}
> +	}
> +
> +	hid_dbg(hdev,
> +		"Multiplatform: No matching platform descriptor
> found for platform '%s'",
> +		hidpp_platform);
> +	return -ENOENT;
> +}
> +
> +/**
> + * hidpp_multiplatform_update_device_platform() - Update the device
> platform
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @plat_index: Platform index to set on the device
> + *
> + * Sends the HID++ Multi-Platform 'SET_CURRENT_PLATFORM' command to
> the device to
> + * update its platform index to @plat_index.
> + *
> + * Return: 0 on success, or non-zero on failure.
> + */
> +static int hidpp_multiplatform_update_device_platform(struct
> hidpp_device *hidpp,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 feat_index,
> u8 plat_index)
> +{
> +	int ret;
> +	struct hidpp_report response;
> +	/* Byte 0 (hostIndex): 0xFF selects the current host. */
> +	u8 params[2] =3D { 0xFF, plat_index };
> +
> +	ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> +					=C2=A0
> HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM,
> +					=C2=A0 params, sizeof(params),
> &response);
> +
> +	if (ret)
> +		hid_warn(hidpp->hid_dev,
> +			 "Multiplatform: SET_CURRENT_PLATFORM failed
> for index %d (err=3D%d)",
> +			 plat_index, ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * hidpp_multiplatform_init() - Apply the HID++ Multi-Platform
> (0x4531) feature
> + * @hidpp: Pointer to the hidpp_device instance
> + *
> + * Initializes the Multi-Platform feature by selecting the device
> platform
> + * corresponding to the module parameter @hidpp_platform, if
> provided.
> + *
> + * The function performs the following steps:
> + *=C2=A0=C2=A0 1. Convert the @hidpp_platform string into a platform mas=
k.
> + *=C2=A0=C2=A0 2. Check whether the device supports the Multi-Platform f=
eature
> (0x4531).
> + *=C2=A0=C2=A0 3. Look up the device's platform index whose mask matches=
 the
> host
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform mask.
> + *=C2=A0=C2=A0 4. Apply that platform index to the device via
> 'SET_CURRENT_PLATFORM'.
> + *
> + * If the module parameter is unset or invalid, or the device does
> not support
> + * the feature, or no matching platform descriptor is found, the
> function exits
> + * silently without modifying the device state.
> + *
> + * On success, the device's platform configuration is updated.
> + */
> +static void hidpp_multiplatform_init(struct hidpp_device *hidpp)
> +{
> +	int ret;
> +	u8 feat_index;
> +	u8 plat_index;
> +	u16 host_plat_mask;
> +	struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +	if (!hidpp_platform)
> +		return;
> +
> +	host_plat_mask =3D
> hidpp_multiplatform_mask_from_str(hidpp_platform);
> +	if (!host_plat_mask) {
> +		hid_warn(hdev,
> +			 "Multiplatform: Invalid or unsupported
> platform name '%s'",
> +			 hidpp_platform);
> +		return;
> +	}
> +
> +	ret =3D hidpp_root_get_feature(hidpp,
> HIDPP_MULTIPLATFORM_FEAT_ID, &feat_index);
> +	if (ret) {
> +		hid_warn(hdev,
> +			 "Multiplatform: Failed to get the HID++
> multiplatform feature 0x4531");
> +		return;
> +	}
> +
> +	ret =3D hidpp_multiplatform_get_platform_index(hidpp,
> feat_index, host_plat_mask,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 &plat_index);
> +	if (ret)
> +		return;
> +
> +	ret =3D hidpp_multiplatform_update_device_platform(hidpp,
> feat_index, plat_index);
> +	if (ret)
> +		return;
> +
> +	hid_info(hdev,
> +		 "Multiplatform: Device platform successfully set to
> '%s'", hidpp_platform);
> +}
> +
> =C2=A0static int hidpp_probe(struct hid_device *hdev, const struct
> hid_device_id *id)
> =C2=A0{
> =C2=A0	struct hidpp_device *hidpp;
> @@ -4467,6 +4741,8 @@ static int hidpp_probe(struct hid_device *hdev,
> const struct hid_device_id *id)
> =C2=A0	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> =C2=A0		connect_mask &=3D ~HID_CONNECT_HIDINPUT;
> =C2=A0
> +	hidpp_multiplatform_init(hidpp);
> +
> =C2=A0	/* Now export the actual inputs and hidraw nodes to the
> world */
> =C2=A0	hid_device_io_stop(hdev);
> =C2=A0	ret =3D hid_connect(hdev, connect_mask);
> @@ -4664,6 +4940,10 @@ static const struct hid_device_id
> hidpp_devices[] =3D {
> =C2=A0	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
> =C2=A0	{ /* MX Anywhere 3SB mouse over Bluetooth */
> =C2=A0	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
> +	{ /* Casa Keys keyboard over Bluetooth */
> +	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD) },
> +	{ /* MX Keys S keyboard over Bluetooth */
> +	=C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD) },
> =C2=A0	{}
> =C2=A0};
> =C2=A0
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index c89a015686c0..99ca04b61bda 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -520,6 +520,8 @@ static const struct hid_device_id
> hid_have_special_driver[] =3D {
> =C2=A0#endif
> =C2=A0#if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD) },
> =C2=A0#endif
> =C2=A0#if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
> =C2=A0	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> USB_DEVICE_ID_APPLE_MAGICMOUSE) },
