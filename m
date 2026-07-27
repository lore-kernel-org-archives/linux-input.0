Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287A2C2360;
	Mon, 27 Jul 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161051; cv=none; b=NoJythZHeVc8ZiFQ9zMiabgxsGr237OzIh209ZutZOdbS8bbj4PVDkhnokCWcf4i9svbaVbtcm5KYU9wjgbGDJqqVXy/8uvIAOFJ4++6bwt/PbbsniiVZx8r+YbZxDmMgPCT5pt0XDvC3xOmDzcEyL2HFXFUR1s7a0AvAm5rJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161051; c=relaxed/simple;
	bh=ZM1LJElGJsei4/OUi3Irhb9tnkUJJv78Z7UEgLdkF30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkaiPwOXh0StLsUG1SnWCbYILk3M4IXnpU5nV1tfDSZeZQ+WwnPMAikE0ITByPtpkZ/f2dLFzwXvf+NKqFwVYOCQbb3U38jiEjm4bEtJ7yQRTH6ID+5DTfaShy7VAyKWXp78psza06MuMFpYdTAHtkyshTlitD19IDCgDLXE+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07D693EC3F;
	Mon, 27 Jul 2026 14:04:04 +0000 (UTC)
Message-ID: <1da97f11f46ee3de1d0bcc5545e50423429b5b20.camel@hadess.net>
Subject: Re: [PATCH v5] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
From: Bastien Nocera <hadess@hadess.net>
To: DevExalt <exalt.dev.team@gmail.com>, jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	sari.kreitem@exalt.corp-partner.google.com,
 hbarnor@google.com
Date: Mon, 27 Jul 2026 16:04:04 +0200
In-Reply-To: <20260701073727.53636-1-exalt.dev.team@gmail.com>
References: <20260625080807.74157-1-exalt.dev.team@gmail.com>
	 <20260701073727.53636-1-exalt.dev.team@gmail.com>
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
X-GND-Score: 0
X-GND-Cause: dmFkZTGb9VUcRGKGo/eI2xclrOoCiNPwky7zntnhtlkv4v2eHvGlo7IIyBLgghbJunTRkymDrmFfVjbT08rRuUFE47yL8ONzepkpP9X0/5w4PO5fF5p6d9ymAqJAsADV63/cS6NVIUNJX/aewOPgKREYGD4W2gcwNq2mN3pceVJrIYPOMxjxzGTWYJ2IRuK6v/5PindV1rJLHnteleKs6cfHeTcB6bxNsO+sGTV12Q2gDCpbk4qNOTDKbCEKUsjIqE+ItjXRsajj4C3JKoynh3w0Gc8tOTWTJMtGAtucBOJ4Z/rslJeWUiRdYGkmqb8fIUw8A2WkTpRMqY18b8NKBtfARdIrryED012eP+7BDBRC65Tf4GuETbrxSVTjkWGPYzWAxpmtUQdl10x/CBsDqG0wgLuORyS7q0ldpuxoTiG4YG0KGfWCPraJd/hUrLvXlcR1yqnmCO0BX7hCYlk3trWAiBjbASPzLcRVw4tBPhs2TnovSA2QlJFZ224mZgWK4DN2g38/3VkOVjekhf1ctc+tYOlk5N7TNLolJWrztN75h7+VEF1+4lgYTu+8mx6fJ9bp4UygJ8dbKiybfAK1wA0TENvW9jUh7MG4znJISHKUxKwevvwyCK4YzclQpKj/yZJegtxoY7iEX7SlxvJxCWlpV0XXxBpsFsDqwFeG/AR70BvJ7A

On Wed, 2026-07-01 at 10:37 +0300, DevExalt wrote:
> From: "Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>
>=20
<snip>
> +
> +#define HIDPP_MULTIPLATFORM_FEAT_ID			0x4531
> +#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO		0x00
> +#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR	0x10
> +#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM	0x30
> +
> +#define
> HIDPP_MULTIPLATFORM_PLATFORM_MASK_TIZEN		BIT(0)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS	BIT(8)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINEMB	BIT(9)
> +#define
> HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX		BIT(10)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME	BIT(11)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID	BIT(12)
> +#define
> HIDPP_MULTIPLATFORM_PLATFORM_MASK_MACOS		BIT(13)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_IOS		BIT(14)
> +#define
> HIDPP_MULTIPLATFORM_PLATFORM_MASK_WEBOS		BIT(15)
> +
> +struct hidpp_platform_desc {
> +	u8 plat_idx;
> +	u8 desc_idx;
> +	u16 plat_mask;
> +};
> +
> +/*
> + * Platform names exposed through the "platform" sysfs attribute.
> The order of
> + * this array must stay in sync with multiplatform_masks[] below, as
> the index
> + * returned by sysfs_match_string() is used to look up the matching
> mask.
> + */
> +static const char * const multiplatform_names[] =3D {
> +	"windows", "winemb", "linux", "chrome",
> +	"android", "macos", "ios", "webos", "tizen", NULL
> +};
> +
> +static const u16 multiplatform_masks[] =3D {
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINEMB,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_MACOS,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_IOS,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WEBOS,
> +	HIDPP_MULTIPLATFORM_PLATFORM_MASK_TIZEN,

Wouldn't something like:
static enum multiplatform_masks =3D {
	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS =3D 8,
	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINEMB =3D 9,
...
};

followed by:
static const char * const multiplatform_names[] =3D {
  [HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS] =3D "windows",
...
};

work? It makes the array a little bit bigger, but not hugely.

That way it completely negates the need to keep 2 arrays, and both of
them in sync.

> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 57d8efdd9b89..577af0075e27 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -537,6 +537,8 @@ static const struct hid_device_id
> hid_have_special_driver[] =3D {
>  #endif
>  #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD) },
>  #endif
>  #if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> USB_DEVICE_ID_APPLE_MAGICMOUSE) },

That hunk shouldn't be necessary (since
e04a0442d33b8cf183bba38646447b891bb02123) unless the device was
absolutely unusable without the HID++ driver.

Rest looks fine, I'll try to test it on my Slim Solar+.

Cheers
